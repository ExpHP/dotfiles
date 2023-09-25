#!/usr/bin/env python3

import argparse
import os
import sys
import shlex
import subprocess
from pathlib import Path
from collections import namedtuple
import typing as tp

PROG = os.path.basename(sys.argv[0])
ENV_PREFIX = 'EXPHP_GITTOOL'

# This script is meant to have its STDOUT sourced by bash. e.g.
#
#    . <($HOME/dotfiles/shell/gittool/gittool-probe.py)
#
# The text it writes to STDOUT sets the following environment variables:
#
# These are "stringly booleans."
# These are either an empty string (false) or something else (true).
# Use the syntax [[ $VAR_NAME ]] to test them.
#   EXPHP_GITTOOL_BRANCH   : branch name (or "HEAD" when detached). If empty: not in a repo.
#   EXPHP_GITTOOL_IS_BARE  : (contents are unspecified beyond truthiness)
#   EXPHP_GITTOOL_IS_DIRTY : (contents are unspecified beyond truthiness)
#   EXPHP_GITTOOL_ERROR    : contents is an error message
#
# These are integers:
#   EXPHP_GITTOOL_UNTRACKED : untracked file count
#   EXPHP_GITTOOL_ADDITIONS : # inserted lines
#   EXPHP_GITTOOL_DELETIONS : # deleted lines

def main():
    parser = argparse.ArgumentParser(
        description='Probe git repository for status',
    )
    parser.add_argument(
        '-C', dest='probe_dir', type=str, default='.',
        help='Directory to probe. (defaults to cwd)',
    )
    args = parser.parse_args()

    try:
        output = main_impl(
            probe_dir=Path(args.probe_dir),
        )
        print(output.to_bash())

    except ApplicationError as e:
        # User-facing error
        print(FailureOutput(error=str(e)).to_bash())

    except Exception as e:
        # Bug; give debugging info
        import traceback
        error = '{}\n{}'.format(traceback.format_exc(), str(e))
        print(FailureOutput(error=error).to_bash())

# ------------------------------------------------------

def main_impl(probe_dir: Path) -> "SuccessOutput":
    if not GitCommands.git_is_available():
        raise RuntimeError("can't find 'git'")

    git = GitCommands(probe_dir)

    root = git.get_root()
    if root is None:
        return SuccessOutput.new_non_repo()
    root = root.resolve()

    branch = git.get_branch()
    is_bare = git.is_bare()
    if is_bare:
        return SuccessOutput.new_bare(root=root, branch=branch)

    stats = git.count_stats()
    return SuccessOutput(
        root=root,
        branch=branch,
        is_bare=is_bare,
        is_dirty=stats.is_dirty,
        add_count=stats.add_count,
        delete_count=stats.delete_count,
        untracked_count=stats.untracked_count,
    )

# ------------------------------------------------------

class GitCommands:
    def __init__(self, probe_dir: Path):
        self.probe_dir = probe_dir

    def try_git_stdout(self, args: tp.List[str], **kw) -> tp.Optional[str]:
        try:
            return self.git_stdout(args, **kw)
        except subprocess.CalledProcessError:
            return None

    def git_stdout(self, args: tp.List[str], **kw) -> str:
        return subprocess.run(
            ['git', '-C', str(self.probe_dir)] + args,
            **kw,
            stdout=subprocess.PIPE,
            stderr=subprocess.DEVNULL,
            check=True,
        ).stdout.decode('utf-8')

    @staticmethod
    def git_is_available() -> bool:
        return subprocess.run(
            ['which', 'git'],
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
        ).returncode == 0

    def get_root(self) -> tp.Optional[Path]:
        stdout = self.try_git_stdout(['rev-parse', '--show-toplevel'])
        return None if stdout is None else Path(stdout.strip())

    def get_branch(self) -> str:
        stdout = self.git_stdout(['rev-parse', '--abbrev-ref', 'HEAD'])
        return stdout.strip()

    def is_bare(self) -> bool:
        stdout = self.git_stdout(['rev-parse', '--is-bare-repository'])
        return bool_from_git(stdout.strip())

    def count_stats(self) -> "GitStats":
        is_dirty = False
        untracked_count = 0
        stdout = self.git_stdout(['status', '--porcelain']).strip()
        for line in stdout.splitlines():
            is_dirty = True
            if line.startswith('?? '):
                untracked_count += 1

        add_count = 0
        delete_count = 0
        stdout = self.git_stdout(['diff', '--shortstat']).strip()
        stdout_words = stdout.split()
        while stdout_words:
            # Output looks like: (with each part optional)
            #    1 file changed, 1 insertion(+), 2 deletions(-)
            if stdout_words[1].startswith('file'):
                del stdout_words[:3]
            elif stdout_words[1].startswith('insertion'):
                add_count = int(stdout_words[0])
                del stdout_words[:2]
            elif stdout_words[1].startswith('deletion'):
                delete_count = int(stdout_words[0])
                del stdout_words[:2]
            else:
                raise RuntimeError('unrecognized git diff --shortstat output: {!r}'.format(stdout))

        return GitStats(
            untracked_count=untracked_count,
            is_dirty=is_dirty,
            add_count=add_count,
            delete_count=delete_count,
        )

GitStats = namedtuple('GitStatus', ["add_count", "delete_count", "untracked_count", "is_dirty"])

def bool_from_git(gitbool: str):
    if gitbool == 'true':
        return True
    elif gitbool == 'false':
        return False
    else:
        raise ValueError('bad bool: {}'.format(gitbool))

# ------------------------------------------------------

class FailureOutput:
    def __init__(self, error: str):
        self.error = error

    def to_bash(self):
        return "\n".join([
            "{}_ERROR={}".format(ENV_PREFIX, shlex.quote(self.error)),
        ]) + "\n"

class SuccessOutput:
    def __init__(
            self,
            root: tp.Optional[str],
            branch: tp.Optional[str],
            is_bare: bool,
            is_dirty: bool,
            add_count: int,
            delete_count: int,
            untracked_count: int,
    ):
        self.root = root
        self.branch = branch
        self.is_bare = is_bare
        self.is_dirty = is_dirty
        self.add_count = add_count
        self.delete_count = delete_count
        self.untracked_count = untracked_count

    @classmethod
    def new_non_repo(cls):
        return cls(
            root=None,
            branch=None,
            is_bare=False,
            is_dirty=False,
            add_count=0,
            delete_count=0,
            untracked_count=0
        )

    @classmethod
    def new_bare(cls, root: Path, branch: str):
        return cls(
            root=root,
            branch=branch,
            is_bare=True,
            is_dirty=False,
            add_count=0,
            delete_count=0,
            untracked_count=0
        )

    def to_bash(self):
        return "\n".join([
            "{}_ROOT={}".format(ENV_PREFIX, shlex.quote(str(self.root))),
            "{}_BRANCH={}".format(ENV_PREFIX, shlex.quote(self.branch)),
            "{}_IS_BARE={}".format(ENV_PREFIX, bool_to_bash(self.is_bare)),
            "{}_IS_DIRTY={}".format(ENV_PREFIX, bool_to_bash(self.is_dirty)),
            "{}_ADDITIONS={}".format(ENV_PREFIX, self.add_count),
            "{}_DELETIONS={}".format(ENV_PREFIX, self.delete_count),
            "{}_UNTRACKED={}".format(ENV_PREFIX, self.untracked_count),
        ]) + "\n"

def bool_to_bash(b: bool):
    return '1' if b else ''

# ------------------------------------------------------

# Used for user-facing error messages.
class ApplicationError(RuntimeError):
    pass

# ------------------------------------------------------

def die(*args):
    raise RuntimeError('Fatal: ' + ' '.join(args))

# ------------------------------------------------------

if __name__ == '__main__':
    main()

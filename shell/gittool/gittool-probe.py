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
    except Exception as e:
        print(FailureOutput(error=str(e)).to_bash())

# ------------------------------------------------------

def main_impl(probe_dir: Path) -> "SuccessOutput":
    if not GitCommands.git_is_available():
        raise RuntimeError("can't find 'git'")

    git = GitCommands(probe_dir)

    branch = git.get_branch()
    if branch is None:
        return SuccessOutput.new_non_repo()

    is_bare = git.is_bare()
    if is_bare:
        return SuccessOutput.new_bare(branch=branch)

    stats = git.count_stats()

    return SuccessOutput(
        branch=branch,
        is_bare=is_bare,
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

    def get_branch(self) -> tp.Optional[str]:
        stdout = self.try_git_stdout(['rev-parse', '--abbrev-ref', 'HEAD'])
        return stdout.strip()

    def is_bare(self) -> bool:
        stdout = self.git_stdout(['rev-parse', '--is-bare-repository'])
        return bool_from_git(stdout.strip())

    def count_stats(self) -> "GitStats":
        stdout = self.git_stdout(['status', '--porcelain'])
        untracked_count = 0
        for line in stdout.splitlines():
            if line.startswith('?? '):
                untracked_count += 1

        stdout = self.git_stdout(['diff', '--shortstat']).strip()
        stdout_words = stdout.split()
        add_count = 0
        delete_count = 0

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
            add_count=add_count,
            delete_count=delete_count,
        )

GitStats = namedtuple('GitStatus', ["add_count", "delete_count", "untracked_count"])

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
            branch: tp.Optional[str],
            is_bare: bool,
            add_count: int,
            delete_count: int,
            untracked_count: int,
    ):
        self.branch = branch
        self.is_bare = is_bare
        self.add_count = add_count
        self.delete_count = delete_count
        self.untracked_count = untracked_count

    @classmethod
    def new_non_repo(cls):
        return cls(
            branch=None,
            is_bare=False,
            add_count=0,
            delete_count=0,
            untracked_count=0
        )

    @classmethod
    def new_bare(cls, branch):
        return cls(
            branch=branch,
            is_bare=True,
            add_count=0,
            delete_count=0,
            untracked_count=0
        )

    def to_bash(self):
        return "\n".join([
            "{}_BRANCH={}".format(ENV_PREFIX, shlex.quote(self.branch)),
            "{}_IS_BARE={}".format(ENV_PREFIX, bool_to_bash(self.is_bare)),
            "{}_ADD_COUNT={}".format(ENV_PREFIX, self.add_count),
            "{}_DELETE_COUNT={}".format(ENV_PREFIX, self.delete_count),
            "{}_UNTRACKED_COUNT={}".format(ENV_PREFIX, self.untracked_count),
        ]) + "\n"

def bool_to_bash(b: bool):
    return '1' if b else ''

# ------------------------------------------------------

def die(*args):
    raise RuntimeError('Fatal: ' + ' '.join(args))

# ------------------------------------------------------

if __name__ == '__main__':
    main()

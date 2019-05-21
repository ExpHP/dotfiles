use std::env;
use std::path::Path;

fn print_usage(program: &str, opts: getopts::Options) {
    let brief = format!("Usage: {} VALUE [options]", program);
    print!("{}", opts.usage(&brief));
}

struct Options {
    keep_dupes: bool,
    remove_empty: bool,
    sort: bool,
}

fn main() {
    let args: Vec<String> = env::args().collect();
    let program = args[0].clone();

    let mut opts = getopts::Options::new();
    opts.optopt("o", "", "set output file name", "NAME");
    opts.optflag("h", "help", "print this help menu");
    opts.optflag("", "keep-dupes", "keep duplicate entries. By default, only the first appearance of each entry is kept, as the others should have no effect.");
    opts.optflag("", "remove-empty", "remove empty entries. Empty entries are easy to create by accident when naively using PATH=/some/path:$PATH, and are often intepreted as referring to the current directory (a notable exception being MANPATH). By default they are preserved, as removing them changes the meaning of the env var.");
    opts.optflag("", "sort", "lexically sort the entries. CAUTION: This can significantly change the meaning of the env var, as it will change search order.");
    let matches = match opts.parse(&args[1..]) {
        Ok(m) => m,
        Err(e) => panic!("{}", e),
    };
    if matches.opt_present("h") {
        print_usage(&program, opts);
        return;
    }
    let options = Options {
        keep_dupes: matches.opt_present("keep-dupes"),
        remove_empty: matches.opt_present("remove-empty"),
        sort: matches.opt_present("sort"),
    };

    if matches.free.len() != 1 {
        print_usage(&program, opts);
        return;
    }
    let value = matches.free.into_iter().next().unwrap();

    println!("{}", canonicalize_pathvar(options, &value));
}

fn canonicalize_pathvar(options: Options, value: &str) -> String {
    let Options { keep_dupes, remove_empty, sort } = options;

    let mut paths: Vec<_> = std::env::split_paths(value).collect();

    if !keep_dupes {
        paths = filter_dupes(&paths);
    }

    if remove_empty {
        paths = paths.into_iter().filter(|s| s != Path::new("")).collect();
    }

    if sort {
        paths.sort();
    }

    std::env::join_paths(paths)
        .expect("(BUG) invalid character inserted?")
        .to_string_lossy().into()
}

fn filter_dupes<T: Clone + Eq + std::hash::Hash>(elems: &[T]) -> Vec<T> {
    use std::collections::HashSet;

    let mut set = HashSet::new();
    let mut out = vec![];
    for elem in elems {
        if set.insert(elem) {
            out.push(elem.clone());
        }
    }
    out
}

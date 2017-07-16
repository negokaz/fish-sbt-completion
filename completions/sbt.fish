
# sbt new

function __fish_cache_or_print_sbt_new_g8_templates --description 'Print giter8 templates for sbt-new'

    # Set up cache directory
    if test -z $XDG_CACHE_HOME
        set XDG_CACHE_HOME $HOME/.cache
    end
    set --local sbt_completion_cache_dir $XDG_CACHE_HOME/fish/sbt-completions
    mkdir -m 700 -p $sbt_completion_cache_dir

    set --local sbt_g8_templates_cache_file $sbt_completion_cache_dir/sbt_new_g8_templates
    set --local templates_url https://github.com/foundweekends/giter8/wiki/giter8-templates

    if not find $sbt_g8_templates_cache_file -mtime -1 ^ /dev/null
        curl -s $templates_url | grep "\.g8<" | sed -E -e 's/<[^>]+>//g' -e 's/\(//g' -e 's/\)//g' | awk '{ name = $1; $1 = ""; print name, "\t", $0 }' > $sbt_g8_templates_cache_file
    end

    cat $sbt_g8_templates_cache_file
end

complete --command sbt --exclusive --condition='__fish_use_subcommand' --arguments='new' --description='Create new project from a template'
complete --command sbt --exclusive --condition='__fish_seen_subcommand_from new' --arguments='(__fish_cache_or_print_sbt_new_g8_templates)'

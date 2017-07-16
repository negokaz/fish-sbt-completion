function __fish_cache_or_print_sbt_new_g8_templates --description 'Print giter8 templates for sbt-new'

    # Set up cache directory
    if test -z $XDG_CACHE_HOME
        set XDG_CACHE_HOME $HOME/.cache
    end
    mkdir -m 700 -p $XDG_CACHE_HOME/sbt-completions

    set --local sbt_g8_templates_cache_file $XDG_CACHE_HOME/sbt-completions/sbt_new_g8_templates

    # Fetch and cache template list when cache file doesn't exist or is old
    if not [ -f $sbt_g8_templates_cache_file ]; or not find $sbt_g8_templates_cache_file -mtime -1 | grep . ^ /dev/null >&2
        curl -s https://github.com/foundweekends/giter8/wiki/giter8-templates | grep "\.g8<" | sed -e "s/</ /g" -e "s/>/ /g" | awk '{print $3}' > $sbt_g8_templates_cache_file
    end
    cat $sbt_g8_templates_cache_file
end

complete --command sbt --exclusive --condition='__fish_seen_subcommand_from new' --arguments='(__fish_cache_or_print_sbt_new_g8_templates)' --description='giter8 template'

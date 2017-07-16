function __fish_construct_completions_for_sbt_new_g8_templates
    # erase initial sbt-new completion
    complete --erase --command sbt --exclusive --condition='__fish_seen_subcommand_from new'

    # Set up cache directory
    if test -z $XDG_CACHE_HOME
        set XDG_CACHE_HOME $HOME/.cache
    end
    mkdir -m 700 -p $XDG_CACHE_HOME/sbt-completions

    set --local sbt_g8_templates_cache_file $XDG_CACHE_HOME/sbt-completions/sbt_new_g8_templates
    set --local templates_url https://github.com/foundweekends/giter8/wiki/giter8-templates

    for template in (find $sbt_g8_templates_cache_file -mtime -1 -exec cat '{}' ';' ^ /dev/null; or curl -s $templates_url | tee $sbt_g8_templates_cache_file)
        # create sbt-new completion contains description
        set --local template_name   (echo "$template" | awk '{print $1}')
        set --local description     (echo "$template" | awk '{$1 = ""; print $0}')
        complete --command sbt --exclusive --condition='__fish_seen_subcommand_from new' --arguments="$template_name" --description="$description"
        # for initial completion
        echo $template_name
    end
end

# Initial sbt-new completion
complete --command sbt --exclusive --condition='__fish_seen_subcommand_from new' --arguments='(__fish_construct_completions_for_sbt_new_g8_templates)'

function __fish_construct_completions_for_sbt_new_g8_templates
    # erase initial sbt-new completion
    complete --erase --command sbt --exclusive --condition='__fish_seen_subcommand_from new'

    for template in (curl -s https://github.com/foundweekends/giter8/wiki/giter8-templates | grep "\.g8<" | sed -E -e 's/<[^>]+>//g' -e 's/\(//g' -e 's/\)//g')
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

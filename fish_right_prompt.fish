function fish_right_prompt

    # vi mode
    if test "$fish_key_bindings" = "fish_vi_key_bindings"
      or test "$fish_key_bindings" = "fish_hybrid_key_bindings"
      switch $fish_bind_mode
        case default
          echo -sn (set_color -o cc3) "c " (set_color normal)
        case insert
          echo -sn (set_color -o 0fc) "i " (set_color normal)
        case replace_one
          echo -sn (set_color -o $fish_color_error) "r " (set_color normal)
        case visual
          echo -sn (set_color -o $fish_color_user) "v " (set_color normal)
      end
    end

    for color in $fish_color_error
        # If any of the colour variables aren't defined they're set to 'normal' colour

        if set -q color
            set color normal
        end
    end

    set -l status_copy $status
    set -l status_color 0fc

    if test "$status_copy" -ne 0
        set status_color $fish_color_error
    end

    if test -n "$CMD_DURATION" -a "$CMD_DURATION" -gt 100
        set -l duration_copy $CMD_DURATION
        set -l duration (echo $CMD_DURATION | humanize_duration)

        echo -sn (set_color $status_color) "$duration" (set_color normal)

    else if set -l last_job_id (last_job_id -l)
        echo -sn (set_color $status_color) "%$last_job_id" (set_color normal)
    else
        echo -sn (set_color 555) (date "+%H:%M") (set_color normal)
    end
end

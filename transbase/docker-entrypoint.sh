#!/bin/sh

# usage: append_password_parameter "PARAM_NAME"
# appends parameter ${"PARAM_NAME"} or ${"PARAM_NAME"_FILE} to ${transbase_cmd}
append_password_parameter() {
    local var_text_name="${1}"
    local var_file_name="${1}_FILE"
    eval var_text=\$${var_text_name}
    eval var_file=\$${var_file_name}

    if { [ -z "${var_text}" ] && [ -z "${var_file}" ]; }  || { [ ! -z "${var_text}" ] && [ ! -z "${var_file}" ]; }; then
        echo "You need to specify either ${var_text_name} or ${var_file_name}."
        exit 1
    fi
    if [ ! -z "${var_text}" ]; then
        local param_text_name="--`echo ${var_text_name#*_} | awk '{print tolower($0)}' | sed 's/_/-/g'`"
        transbase_cmd="${transbase_cmd} ${param_text_name}=${var_text}"
    else
        local param_file_name="--`echo ${var_text_name#*_} | awk '{print tolower($0)}' | sed 's/_/-/g'`-file"
        transbase_cmd="${transbase_cmd} ${param_file_name}=${var_file}"
    fi
}

# usage: create_configuration_file
# creates configuration file transbase.ini
create_configuration_file() {
    local transbase_ini="${TRANSBASE}/transbase.ini"

    echo "[transbase]" > "${transbase_ini}"

    echo "TRANSBASE_RW=${TRANSBASE}" >> "${transbase_ini}"
    echo "DATABASE_HOME=${TRANSBASE_DATABASE_HOME}" >> "${transbase_ini}"
    echo "TRANSBASE_PORT=${TRANSBASE_PORT}" >> "${transbase_ini}"
    if [ ! -z "${TRANSBASE_LICENSE_FILE}" ]; then
        echo "LICENSE=${TRANSBASE_LICENSE_FILE}" >> "${transbase_ini}"
    fi
    if [ ! -z "${TRANSBASE_CERTIFICATE_FILE}" ]; then
        echo "CERTIFICATE=${TRANSBASE_CERTIFICATE_FILE}" >> "${transbase_ini}"
    fi
    if [ ! -z "${TRANSBASE_MAX_THREADS}" ]; then
        echo "MAX_THREADS=${TRANSBASE_MAX_THREADS}" >> "${transbase_ini}"
    fi
}

# usage: main
# main function
main() {
    # build command line for running transbase service
    local transbase_cmd="transbase start -g"

    # append ${TRANSBASE_PASSWORD} or ${TRANSBASE_PASSWORD_FILE}
    append_password_parameter "TRANSBASE_PASSWORD"

    # if ${TRANSBASE_CERTIFICATE_FILE} is set append ${TRANSBASE_CERTIFICATE_PASSWORD} or ${TRANSBASE_CERTIFICATE_PASSWORD_FILE}
    if [ ! -z "${TRANSBASE_CERTIFICATE_FILE}" ] && { [ ! -z "${TRANSBASE_CERTIFICATE_PASSWORD}" ] || [ ! -z "${TRANSBASE_CERTIFICATE_PASSWORD_FILE}" ]; }; then
        append_password_parameter "TRANSBASE_CERTIFICATE_PASSWORD"
    fi

    # create transbase.ini
    create_configuration_file

    # stop transbase if one of the following signals is received
    trap "transbase stop" SIGTERM SIGKILL SIGHUP

    # start the service and wait for it
    eval "${transbase_cmd}" &
    transbase_pid=$!
    wait "$transbase_pid"
}

main

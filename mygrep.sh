#!/bin/bash

help() {
    echo "Usage: $0 [-n] [-v] search_string file"
    echo "Options:"
    echo "  -n         Show line numbers for each match"
    echo "  -v         Invert match (print lines that do not match)"
    echo "  --help     Display this help message"
}

if [[ "$1" == "--help" ]]; then
    help
    exit 0
fi

show_line_numbers=false
invert_match=false
search_string=""
file=""

#Handel the options 
while getopts ":nv" opt; do
    case $opt in
        n) show_line_numbers=true ;;
        v) invert_match=true ;;
        *) echo "Invalid option: -$OPTARG" >&2
           usage
           exit 1 ;;
    esac
done

shift $((OPTIND - 1))

#Check if all the arguments exist if not give error
if [[ $# -lt 2 ]]; then
    echo "Error: Missing search string or file." >&2
    usage
    exit 1
fi

search_string="$1"
file="$2"

if [[ ! -f "$file" ]]; then
    echo "Error: File '$file' not found." >&2
    exit 1
fi

#Read line by line
line_number=0
while IFS= read -r line || [[ -n "$line" ]]; do
    ((line_number++))
#Convert the entire text to lowercase and then check if it matches
    if [[ "${line,,}" == *"${search_string,,}"* ]]; then
        match=true
    else
        match=false
    fi

#Handel the -v flag
    if $invert_match; then
        if $match; then
            match=false
        else
            match=true
        fi
    fi

    if $match; then
        if $show_line_numbers; then
            echo "$line_number:$line"
        else
            echo "$line"
        fi
    fi
done < "$file"

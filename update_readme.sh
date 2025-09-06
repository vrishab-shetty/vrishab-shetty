#!/bin/bash

# Function to update a section in README.md
update_section() {
    local section_name="$1"
    local template_file="$2"
    local readme_file="README.md"

    local start_marker="<!-- ${section_name}_START -->"
    local end_marker="<!-- ${section_name}_END -->"

    # Get the line numbers of the start and end markers.
    local start_line
    start_line=$(grep -n "$start_marker" "$readme_file" | cut -d: -f1)
    local end_line
    end_line=$(grep -n "$end_marker" "$readme_file" | cut -d: -f1)

    # Check if markers were found.
    if [[ -z "$start_line" || -z "$end_line" ]]; then
        echo "Warning: Markers for section ${section_name} not found in ${readme_file}. Skipping."
        return
    fi

    # The lines to delete are between the start and end markers.
    local delete_start=$((start_line + 1))
    local delete_end=$((end_line - 1))

    # Delete the old content between the markers, if any exists.
    if [ "$delete_start" -le "$delete_end" ]; then
        sed -i "${delete_start},${delete_end}d" "$readme_file"
    fi

    # Read the new content from the template file and insert it after the start marker.
    # The 'r' command in sed is safe for inserting file content.
    sed -i "/${start_marker}/r ${template_file}" "$readme_file"
}

# Update all sections
update_section "WORKING_ON" "templates/working_on.md"
update_section "LEARNING" "templates/learning.md"
update_section "PROJECTS" "templates/projects.md"

echo "README.md has been updated successfully!"

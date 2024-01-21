import os

lib_folder_path = 'lib'
output_file_path = 'lib/output.txt'

def append_files_to_text(files_folder, output_file):
    with open(output_file, 'a', encoding='utf-8') as output:
        for filename in os.listdir(files_folder):
            file_path = os.path.join(files_folder, filename)
            if os.path.isfile(file_path):
                with open(file_path, 'r', encoding='utf-8', errors='ignore') as file:
                    output.write(f"=== Contents of {filename} ===\n")
                    try:
                        output.write(file.read())
                    except UnicodeDecodeError:
                        print(f"Error reading {filename}. Skipping...")
                    output.write("\n\n")

try:
    append_files_to_text(lib_folder_path, output_file_path)
    print(f"Contents of files in '{lib_folder_path}' appended to '{output_file_path}'.")
except Exception as e:
    print(f"An error occurred: {e}")

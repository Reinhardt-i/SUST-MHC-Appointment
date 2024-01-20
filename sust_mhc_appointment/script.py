import os

lib_folder_path = 'lib'
output_file_path = 'lib/output.txt'

def append_files_to_text(files_folder, output_file):
    with open(output_file, 'a') as output:
        for filename in os.listdir(files_folder):
            file_path = os.path.join(files_folder, filename)
            if os.path.isfile(file_path):
                with open(file_path, 'r') as file:
                    output.write(f"=== Contents of {filename} ===\n")
                    output.write(file.read())
                    output.write("\n\n")


append_files_to_text(lib_folder_path, output_file_path)
print(f"Contents of files in '{lib_folder_path}' appended to '{output_file_path}'.")

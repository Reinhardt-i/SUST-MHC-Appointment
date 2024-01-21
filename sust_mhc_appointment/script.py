import os
import chardet

def detect_encoding(file_path):
    with open(file_path, 'rb') as file:
        rawdata = file.read()
    result = chardet.detect(rawdata)
    return result['encoding']

def copy_lib_files_to_txt():
    flutter_project_path = os.getcwd()
    lib_folder_path = os.path.join(flutter_project_path, 'lib')
    output_txt_path = os.path.join(flutter_project_path, 'output.txt')

    try:
        with open(output_txt_path, 'w', encoding='utf-8') as output_txt_file:
            for foldername, subfolders, filenames in os.walk(lib_folder_path):
                for filename in filenames:
                    file_path = os.path.join(foldername, filename)
                    relative_path = os.path.relpath(file_path, lib_folder_path)

                    file_encoding = detect_encoding(file_path)

                    with open(file_path, 'r', encoding=file_encoding) as file:
                        file_content = file.read()

                    output_txt_file.write(f"File: {relative_path}\n")
                    output_txt_file.write("Content:\n")
                    output_txt_file.write(file_content + '\n\n')

        print(f'Files in the "lib" folder and their contents have been copied to {output_txt_path}')
    except Exception as e:
        print(f'Error: {e}')

if __name__ == "__main__":
    copy_lib_files_to_txt()

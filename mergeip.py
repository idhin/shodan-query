##tools buat gabungin semua IP didalam 1 folder ke dalam 1 files
import os

def process_line(line):
    parts = line.strip().split(':')
    if len(parts) == 2:
        ip, port = parts
        if port == '443':
            return f"https://{ip}"
        else:
            return f"http://{ip}:{port}"
    return line

def main():
    folder_path = input("Masukkan path ke folder: ")
    output_file = 'merged_output.txt'

    unique_entries = set()

    with open(output_file, 'w') as output:
        for filename in os.listdir(folder_path):
            if filename.endswith('.txt'):
                file_path = os.path.join(folder_path, filename)
                with open(file_path, 'r') as file:
                    for line in file:
                        processed_line = process_line(line)
                        if processed_line not in unique_entries:
                            unique_entries.add(processed_line)
                            output.write(processed_line + '\n')

    print("Merging and processing complete.")

if __name__ == "__main__":
    main()

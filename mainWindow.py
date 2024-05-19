import tkinter as tk
import dbconnect
import Russian as ru
from tkinter import ttk, messagebox


class MainWindow(tk.Tk):
    def __init__(self):
        super().__init__()
        self.title('Техническое обслуживание поездов')
        self.geometry("300x500")
        self.update_idletasks()
        x = (self.winfo_screenwidth() - self.winfo_width()) // 2
        y = (self.winfo_screenheight() - self.winfo_height()) // 2
        self.geometry("+{}+{}".format(x, y))

        self.connect = dbconnect.create_connection("railway_db", "postgres", "postgresql", "localhost", "5432")
        self.created_windows = {}

        def open_or_show_window(window_title):
            if window_title not in self.created_windows:
                new_window = Window(self.connect, window_title)
                new_window.title(ru.window_name[window_title])
                self.created_windows[window_title] = new_window
                new_window.protocol("WM_DELETE_WINDOW", lambda: on_window_close(window_title))
            else:
                self.created_windows[window_title].deiconify()

        def on_window_close(window_title):
            self.created_windows[window_title].withdraw()

        table_texts = [
                        "maintenances", "station_employees", "railroad_cars",
                        "body_parts", "chassis_parts", "shock_traction_device_parts",
                        "braking_equipment_parts"
                        ]

        for index, text in enumerate(table_texts):
            ttk.Button(text=ru.texts[index], width=30,
                       command=lambda t=text: open_or_show_window(t)).pack(expand=True, ipady= 7)


class Window(tk.Toplevel):
    def __init__(self, connect, table_name):
        super().__init__()
        self.connection = connect
        self.table_name = table_name
        self.columns_names = dbconnect.check_columns(self.connection, table_name)

        self.button_frame = tk.Frame(self)
        self.button_frame.pack(side=tk.TOP, fill=tk.X)
        self.addButton = ttk.Button(self.button_frame, width=20, text='Добавить строчку', command=lambda: self.add_row())
        self.deleteButton = ttk.Button(self.button_frame, width=20, text="Удалить строчку", command=lambda: self.delete_row())
        self.changeButton = ttk.Button(self.button_frame, width=20, text="Редактировать", command=lambda: self.edit_row())

        self.addButton.pack(side=tk.LEFT, expand=True, fill=tk.X, ipady=7)
        self.changeButton.pack(side=tk.LEFT, expand=True, fill=tk.X, ipady=7)
        self.deleteButton.pack(side=tk.LEFT, expand=True, fill=tk.X, ipady=7)

        self.table = ttk.Treeview(self, columns=self.columns_names, show='headings')

        for index, name in enumerate(self.columns_names):
            self.table.heading(name, text=ru.columns_names[table_name][index])

        self.table.pack(expand=True, fill=tk.BOTH)

        self.rows = dbconnect.read_entry(self.connection, table_name)
        for row in self.rows:
            self.load_data(row)

        self.edit_dialog = None
        self.entries = []
        self.current_item = None

    def load_data(self, entry):
        rows = []
        i = 0
        while i != len(entry):
            i+=1
            rows.append(entry[i-1])
        self.table.insert('', 'end', values=rows)

    def edit_row(self):
        highlight = self.table.focus()
        if not highlight:
            messagebox.showinfo("Предупреждение", f"Нет выделенного элемента")
            return

        data = self.table.item(highlight, 'values')
        uid = data[0]
        self.current_item = highlight
        if self.edit_dialog is not None:
            self.edit_dialog.destroy()
        self.edit_dialog = tk.Toplevel(self)
        self.edit_dialog.title("Редактировать")
        x = self.winfo_x() + (self.winfo_width() // 2) - (self.edit_dialog.winfo_reqwidth() // 2) - 100
        y = self.winfo_y() + (self.winfo_height() // 2) - (self.edit_dialog.winfo_reqheight() // 2)
        self.edit_dialog.geometry("+{}+{}".format(x, y))
        column_count = len(self.table["columns"])
        self.entries = []
        for i in range(column_count):
            label = tk.Label(self.edit_dialog, text=f"{ru.columns_names[self.table_name][i]}:")
            label.grid(row=i, column=0, padx=5, pady=5)
            entry = tk.Entry(self.edit_dialog)
            entry.grid(row=i, column=1, padx=5, pady=5)
            self.entries.append(entry)
        for i in range(len(data)):
            if i < len(self.entries):
                self.entries[i].insert(0, data[i])
        save_btn = tk.Button(self.edit_dialog, text="Save", command=lambda : self.save_changes(uid))
        save_btn.grid(row=column_count, columnspan=2, pady=10)

    def save_changes(self, uid):
        new_values = [entry.get() for entry in self.entries]
        data = [tuple(new_values)]
        exception = dbconnect.update_entry(self.connection, self.edit_dialog, self.table_name, data, uid)
        if exception == None:
            self.table.item(self.current_item, values=new_values)
            self.edit_dialog.destroy()
            self.edit_dialog = None

    def add_row(self):
        if not hasattr(self, 'add_dialog'):
            self.add_dialog = tk.Toplevel(self)
            self.add_dialog.title("Добавить")
            x = self.winfo_x() + (self.winfo_width() // 2) - (self.add_dialog.winfo_reqwidth() // 2) - 100
            y = self.winfo_y() + (self.winfo_height() // 2) - (self.add_dialog.winfo_reqheight() // 2)
            self.add_dialog.geometry("+{}+{}".format(x, y))
            column_count = len(self.table["columns"])
            self.entries = []
            for i in range(column_count):
                label = tk.Label(self.add_dialog, text=f"{ru.columns_names[self.table_name][i]}:")
                label.grid(row=i, column=0, padx=5, pady=5)
                entry = tk.Entry(self.add_dialog)
                entry.grid(row=i, column=1, padx=5, pady=5)
                self.entries.append(entry)
            add_btn = tk.Button(self.add_dialog, text="Добавить",
                                command=lambda: self.add_record(self.entries, self.add_dialog))
            add_btn.grid(row=column_count, columnspan=2, pady=10)
            self.add_dialog.protocol("WM_DELETE_WINDOW", self.stop_closing)
        else:
            tk.messagebox.showinfo("Внимание", "Завершите добавление текущей записи перед созданием новой.")

    def stop_closing(self):
        if hasattr(self, 'add_dialog'):
            self.add_dialog.destroy()
            del self.add_dialog

    def add_record(self, entries, add_dialog):
        try:
            new_values = [entry.get() for entry in entries]
            data = [tuple(new_values)]
            exception = dbconnect.add_entry(self.connection, add_dialog, self.table_name, data)
            if exception == None:
                self.table.insert('', 'end', values=new_values)
                add_dialog.destroy()
                del self.add_dialog
        except Exception as e:
            print(f"The error '{e}' occurred")

    def delete_row(self):
        try:
            selected_item = self.table.focus()
            if not selected_item:
                messagebox.showinfo("Предупреждение", f"Нет выделенного элемента")
                return
            if selected_item:
                item_text = self.table.item(selected_item, 'values')
                confirm = messagebox.askyesno("Подтверждение удаления",
                                              f"Вы уверены, что хотите удалить запись {item_text}?")
                if confirm:
                    self.table.delete(selected_item)
                    dbconnect.delete_entry(self.connection, confirm, self.table_name, item_text)
        except Exception as e:
            print(f"The error '{e}' occurred")

    # def check_value(self, values):
    #     for index, value in enumerate(values):
    #         try:
    #             value = int(value)
    #         except ValueError as e:
    #             pass
    #         print(value)
    #         print(ru.datatypes[self.columns_names[index]])
    #         if not isinstance(value, ru.datatypes[self.columns_names[index]]):
    #             print(isinstance(value, ru.datatypes[self.columns_names[index]]))
    #             raise ValueError(f"Неверный тип данных для столбца '{self.columns_names[index]}'")


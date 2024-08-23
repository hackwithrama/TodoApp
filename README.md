# TodoList SwiftUI App

Welcome to the TodoList SwiftUI App repository! This app is a simple yet powerful task management tool built using SwiftUI and SwiftData. It allows users to manage their tasks with features like filtering, sorting, and marking tasks as important.

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Screenshots](#screenshots)
- [How to Run](#how-to-run)
- [Approach](#approach)

## Overview

This application provides a clean and efficient interface for managing to-do tasks. Users can filter tasks by name, toggle visibility for important tasks, and add new tasks. The app leverages SwiftUI for the user interface and SwiftData for data management.

## Features

- Searchable tasks by name
- Filter tasks to show only important ones
- Add and manage tasks
- Mark tasks as completed
- Sort tasks by date

## Screenshots

Here are some screenshots of the app in action:

### Main Screen, Add Task View, Edit Task View, Search Task View
<img width="256" alt="app-home-view" src="https://github.com/user-attachments/assets/e5063777-591c-425b-b3f7-2549162dd7df"> <img width="256" alt="app-add-view" src="https://github.com/user-attachments/assets/976d908f-5e7b-45f5-a86a-5fbb752509cc"> <img width="256" alt="app-edit-view" src="https://github.com/user-attachments/assets/3d309d39-5cc2-4599-b0af-ca4480c0dc5f"> <img width="256" alt="app-search-view-1" src="https://github.com/user-attachments/assets/f46ce606-5816-4b5f-b32a-a3f42e618f8f">

## How to Run

- Clone the repository: ``` git clone https://github.com/hackwithrama/TodoApp.git ```
- Navigate to the project directory: ``` cd TodoApp ```
- Open the project in Xcode: ``` open TodoListApp.xcodeproj ```
- Build and run the app in Xcode.

## Approach

### Project Structure
- Data Model
  1. Defined the Task model using SwiftData.
  2. Implemented properties and methods for task management.
- User Interface
  1. Utilized SwiftUI for a responsive and modern UI.
  2. Implemented List, NavigationLink, and TextField for task display and interactions.
  3. Added .searchable for filtering tasks.
- State Management
  1. Used @State and @Binding to manage user inputs and filter state.
  2. Ensured smooth interaction between views with state-driven updates.
- Toolbar Integration
  1. Added toolbar items for filtering and adding tasks.
  2. Used .sheet to present modal views for task creation.


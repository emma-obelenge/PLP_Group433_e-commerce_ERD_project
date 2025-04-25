# 📦 Peer Group Assignment: E-commerce Database Design

## 🎯 Objective

This repository contains the deliverables for the Peer Group Assignment focused on mastering database design for an e-commerce platform. Our group collaborated to design an Entity-Relationship Diagram (ERD).

## 🛠️ Project Structure

This repository includes the following:

- **`e-commerce_ERD_link`**: This file contains link to the final Entity-Relationship Diagram in a visual format (google drive/draw.io).
- **`README.md`**: The current file, providing an overview of the project and instructions for review.

## 🏗️ Database Design

### 📝 Entity-Relationship Diagram (ERD)

The ERD visually represents the entities (tables) in our e-commerce database and the relationships between them. It clearly defines the attributes of each entity, primary keys, foreign keys, and constraints.

## Screenshots

<div style="display: flex; flex-direction: column; gap: 10px;">

<img src="https://github.com/emma-obelenge/PLP_Group433_e-commerce_ERD_project/blob/40c20ba8e3dda7cdae41d323bbf67ca080681a4a/e-commerce_ER_Diagram_(Group_433).png" alt="Main Menu" width="400" height="500">

- **To view the ERD on drive, please refer to the file located in the `e-commerce_ERD_link` file.**

### 🔄 Data Flow

Our database design aims to facilitate the following data flow:

- Products are organized into `product_category` and associated with a `brand`.
- General product details (name, base price) are stored in the `product` table.
- Specific, purchasable variations of a product (e.g., size, color) are represented by `product_item`, which links back to the main `product`.
- Each `product_item` can have multiple `product_image` entries.
- `product_item` variations are defined through the `product_variation` table, linking to specific options in `color` and `size_option` (categorized by `size_category`).
- Custom product features are managed through `product_attribute`, which belongs to an `attribute_category` and has a defined `attribute_type`.

### 🗃️ Tables Created

The following tables have been designed:

- `product_image`
- `color`
- `product_category`
- `product`
- `product_item`
- `brand`
- `product_variation`
- `size_category`
- `size_option`
- `product_attribute`
- `attribute_category`
- `attribute_type`

- Column definitions and their data types.
- `PRIMARY KEY` constraints to uniquely identify records.
- `FOREIGN KEY` constraints to establish relationships between tables and ensure data integrity.

## 🧑‍🤝‍🧑 Group Collaboration

This project was a collaborative effort. All team members actively participated in the analysis, design, and implementation phases. We ensured that everyone had a clear understanding of each part of the database schema and the reasoning behind our design choices.

We utilized GitHub for:

- Version control to manage changes to the ERD.
- Documentation (through issues and discussions) to track progress and share ideas.
- Teamwork by allowing multiple members to contribute and review the project.

## 🚀 Submission

This public GitHub repository serves as our submission for the E-commerce ERD Design assignment.

### 🔍 Review Instructions

To review our submission:

1.  **Navigate to the `ERD/` directory** to view the visual representation of our database schema.
2.  **Review the README.md** for an overview of our design and collaboration process.

We have strived to create a well-structured and logically sound database design that meets the requirements of a basic e-commerce platform. We welcome your feedback!

## 🔗 Useful Links

- Click [Here](https://drive.google.com/file/d/1qKwLur7UZ645GPVIpLaAT8ShhrAGkjp6/view?usp=drive_link) to view the design

## 👥 Group Members

#### Emmanuel Obelenge

- **Role**: Instantiation/Setup & ERD Design
- **Email**: [obeleemmanuel@gmail.com](mailto:obeleemmanuel@gmail.com)
- **GitHub**: [@emma-obelenge](https://github.com/emma-obelenge)

#### Tabitha Tsisika Lisanza

- **Role**: ERD Review & Design
- **Email**: [lisanzatabitha@gmail.com](mailto:lisanzatabitha@gmail.com)
- **GitHub**: [@lisanzatabby](https://github.com/lisanzaTabby)

#### Berlyn Mumbua Mutinda

- **Role**: ERD Review & Design
- **Email**: [berlynmumbua@gmail.com](mailto:berlynmumbua@gmail.com)
- **GitHub**: [@mumbua-mutinda](https://github.com/mumbua-mutinda)

#### Evan Omanga

- **Role**: ERD Review & Design
- **Email**: [evanwayodi19@gmail.com](mailto:evanwayodi19@gmail.com)
- **GitHub**: [Evan19-CoDe](https://github.com/Evan19-CoDe)

#### Stephen Muhoho

- **Role**: ERD Review & Design
- **Email**: [muhoho.skariuki@gmail.com](mailto:muhoho.skariuki@gmail.com)
- **GitHub**: [RiuK-47](https://github.com/RiuK-47)

## 🗓️ Project Timeline

- [Start Date]: Project Initiation and Requirements Analysis
- [Mid Date - End Date]: Initial ERD Design and Review
- [Submission Date]: Final Review and Repository Submission

---

Thank you for reviewing our work!

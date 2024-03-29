CREATE DATABASE IF NOT EXISTS transport;
USE transport;

-- Table for cities
CREATE TABLE cities (
    city_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    country VARCHAR(100),
    population INT,
    description TEXT
);

-- Table for attractions
CREATE TABLE attractions (
    attraction_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    location VARCHAR(100),
    city_id INT,
    FOREIGN KEY (city_id) REFERENCES cities(city_id)
);

-- Table for categories of attractions
CREATE TABLE attraction_categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- Table to associate attractions with categories (many-to-many relationship)
CREATE TABLE attraction_category_mapping (
    mapping_id INT AUTO_INCREMENT PRIMARY KEY,
    attraction_id INT,
    category_id INT,
    FOREIGN KEY (attraction_id) REFERENCES attractions(attraction_id),
    FOREIGN KEY (category_id) REFERENCES attraction_categories(category_id)
);

-- Table for tourist reviews of attractions
CREATE TABLE attraction_reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    attraction_id INT,
    tourist_id INT,
    review_date DATE,
    rating INT,
    review TEXT,
    FOREIGN KEY (attraction_id) REFERENCES attractions(attraction_id),
    FOREIGN KEY (tourist_id) REFERENCES tourists(tourist_id)
);

-- Table for events happening in cities
CREATE TABLE events (
    event_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    city_id INT,
    event_date DATE,
    description TEXT,
    FOREIGN KEY (city_id) REFERENCES cities(city_id)
);

-- Table to associate attractions with events (many-to-many relationship)
CREATE TABLE attraction_event_mapping (
    mapping_id INT AUTO_INCREMENT PRIMARY KEY,
    attraction_id INT,
    event_id INT,
    FOREIGN KEY (attraction_id) REFERENCES attractions(attraction_id),
    FOREIGN KEY (event_id) REFERENCES events(event_id)
);

-- Table for tourists
CREATE TABLE tourists (
    tourist_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    nationality VARCHAR(100),
    age INT,
    gender ENUM('Male', 'Female', 'Other'),
    email VARCHAR(100),
    phone_number VARCHAR(20)
);

-- Table for feedback from tourists
CREATE TABLE feedback (
    feedback_id INT AUTO_INCREMENT PRIMARY KEY,
    tourist_id INT,
    feedback_date DATE,
    feedback_text TEXT,
    FOREIGN KEY (tourist_id) REFERENCES tourists(tourist_id)
);

-- Table for managing city amenities
CREATE TABLE amenities (
    amenity_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT
);

-- Table to associate amenities with cities (many-to-many relationship)
CREATE TABLE city_amenities (
    city_id INT,
    amenity_id INT,
    FOREIGN KEY (city_id) REFERENCES cities(city_id),
    FOREIGN KEY (amenity_id) REFERENCES amenities(amenity_id)
);

-- Table for tour guides
CREATE TABLE tour_guides (
    guide_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    city_id INT,
    FOREIGN KEY (city_id) REFERENCES cities(city_id)
);

-- Table for tours offered
CREATE TABLE tours (
    tour_id INT AUTO_INCREMENT PRIMARY KEY,
    guide_id INT,
    tour_name VARCHAR(100),
    tour_date DATE,
    duration_hours INT,
    FOREIGN KEY (guide_id) REFERENCES tour_guides(guide_id)
);

-- Table to track tourists participating in tours (many-to-many relationship)
CREATE TABLE tour_participants (
    participant_id INT AUTO_INCREMENT PRIMARY KEY,
    tourist_id INT,
    tour_id INT,
    FOREIGN KEY (tourist_id) REFERENCES tourists(tourist_id),
    FOREIGN KEY (tour_id) REFERENCES tours(tour_id)
);

-- Table for tracking bookings made by tourists
CREATE TABLE bookings (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    tourist_id INT,
    attraction_id INT,
    booking_date DATE,
    booking_status ENUM('Pending', 'Confirmed', 'Cancelled'),
    FOREIGN KEY (tourist_id) REFERENCES tourists(tourist_id),
    FOREIGN KEY (attraction_id) REFERENCES attractions(attraction_id)
);

-- Table for payments
CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    tourist_id INT,
    booking_id INT,
    payment_date DATE,
    amount DECIMAL(10, 2),
    payment_method VARCHAR(50),
    payment_status ENUM('Pending', 'Completed', 'Cancelled'),
    FOREIGN KEY (tourist_id) REFERENCES tourists(tourist_id),
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id)
);

-- Table for admins
CREATE TABLE admins (
    admin_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE,
    password VARCHAR(100), -- Passwords should be hashed for security in production
    email VARCHAR(100),
    admin_type ENUM('SuperAdmin', 'RegularAdmin') DEFAULT 'RegularAdmin'
);
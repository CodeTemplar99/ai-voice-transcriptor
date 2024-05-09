# Test Assignment README

## Overview

This repository contains the code for a speech-to-text AI application. The first page facilitates Google sign-in via Firebase. The second page, "IndRecord," serves the purpose of recording audio and processing it with AI insights from the OpenAI API.

## Project Structure

- **Audio Recordings**: Audio recordings can be made by the hiring manager through the application.
- **APIs**: The project integrates two APIs:
  - **Deepgram API**: Utilized for Speech to Text functionality.
  - **OpenAI API**: Utilized for AI insights such as transcription and summary generation.

## Installation Steps

1. **Set Up Flutter Development Environment**:

   - Follow the official Flutter installation guide to set up Flutter SDK on your machine: [Flutter Installation Guide](https://flutter.dev/docs/get-started/install)
   - Ensure that Flutter SDK is added to your system's PATH.

2. **Clone the Repository**:

   - Clone this repository to your local machine using Git:
     ```
     git clone <repository-url>
     ```

3. **Set Up Project Environment**:

   - Navigate to the project directory and run the following command to install dependencies:
     ```
     flutter pub get
     ```
   - Configure the project environment variables:
     - Obtain a Deepgram API key by signing up for an account on the [Deepgram website](https://www.deepgram.com/).
     - Create a `.env` file in the project root directory.
     - Add your Deepgram API key to the `.env` file:
       ```
       DEEPGRAM_API_KEY=<your-deepgram-api-key>
       ```
     - Ensure that the `.env` file is added to your `.gitignore` to prevent sensitive information from being exposed.

4. **Run the Application**:
   - Connect an Android device or emulator to your development environment.
   - Run the following command to build and install the application on your device:
     ```
     flutter run
     ```

## Specific Requirements

1. **Deepgram API Integration**: The application utilizes the Deepgram API for speech-to-text conversion. The API provides $200 credits without a credit card requirement.
2. **OpenAI API Integration**: The application utilizes Deepgram's API for transcription and summary generation.
3. **Functionality**: The application provides full transcription and summary of the recorded audio. Other sections such as sentiment analysis, speaker quotes, personality scores, and traits are hard coded.
4. **UI/UX Modification**: The "IndRecord" page's UI/UX design has been modified according to the developer's vision to enhance user experience and aesthetic appeal.

## Deployment

The mobile application has been deployed on Google Drive [APK link](https://drive.google.com/file/d/1oh-loSQWCrwU4j1FqVpKe9nuKYS02nMY/view?usp=sharing) and is available for installation on Android devices. 

## Usage

1. ** Sign-in**: The first page facilitates Google sign-in via Firebase.
2. **IndRecord Page**:
   - Record audio using the provided functionality.
   - Play recorded audio.
   - Get AI insights including transcription and summary using OpenAI API.

## Challenges Faced

Throughout the development process, several challenges were encountered, including:

- Integrating multiple APIs seamlessly.
- Designing UI/UX to meet both functional and aesthetic requirements.
- Optimizing performance for audio processing and text display.
- Ensuring compatibility and smooth functionality across different Android devices.

## Conclusion

The completion of this test assignment demonstrates the ability to integrate APIs, develop user-friendly interfaces, and meet specific project requirements. The software may not experience hurdles if the 3rd party API is down, but it works! For any inquiries or further assistance, please get in touch with the developer, Kindly reach out to me at [udoagwac@gmail.com](udoagwac@gmail.com).

---

_Note: This README provides an overview of the completed test assignment. For detailed technical documentation, please refer to the project files._

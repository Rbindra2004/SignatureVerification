🖋️ Signature Verification using CNN (MATLAB)
This project demonstrates a signature verification system built in MATLAB using a basic Convolutional Neural Network (CNN) that surprisingly outperforms more complex architectures like AlexNet and ResNet, achieving an accuracy of ~92%. A MATLAB-based GUI allows users to upload signature images and instantly verify their authenticity as genuine or forged.

💡 Why This Project Stands Out
Sometimes, simplicity wins. In this project, a basic CNN architecture trained from scratch outperformed transfer learning with AlexNet and ResNet. Despite being relatively shallow, the model generalized better to the dataset — proving that model depth isn't everything when your preprocessing and feature extraction are tuned just right.

⚠️ Lesson Learned: Bigger isn't always better. The right architecture depends on the data and the problem, not just the number of layers.

📉 Dataset Challenges
The dataset contained a mix of grayscale and RGB images, which introduced inconsistencies in input dimensions and depth.

Several signature samples were low-contrast, had noise, or were scanned under different lighting conditions.

Preprocessing had to be custom-designed to normalize image channels, resize consistently, and standardize inputs across the dataset.

📂 Project Structure
graphql
Copy
Edit
📁 SignatureVerification/
├── mymodel.mat              # Trained basic CNN model
├── SignatureApp.mlapp       # MATLAB App Designer GUI
├── preprocessSignature.m    # Custom preprocessing script
├── example_signatures/      # Sample images (optional)
└── README.md                # This file
🚀 Features
🖼️ Upload Signature Image

🧠 Verify Authenticity using CNN

✅ Displays Result (Genuine / Forged)

📊 Achieved ~92% accuracy

🛠️ Built with MATLAB + App Designer

🧠 Model Insight
Model	Accuracy	Notes
Basic CNN	~92%	Custom built and tuned from scratch
AlexNet	~85%	Struggled with grayscale inputs
ResNet18	~87%	Overfitted quickly on limited samples

The basic CNN excelled because:

It was tailored to the data (channel handling, smaller image size, etc.).

It had fewer parameters, reducing overfitting.

It was trained from scratch, unlike pre-trained networks expecting full RGB image features.

▶️ How to Run
Open MATLAB

Clone this repo:

bash
Copy
Edit
git clone https://github.com/your-username/SignatureVerification.git
cd SignatureVerification
Open the App:

matlab
Copy
Edit
SignatureApp  % or open in App Designer: appdesigner('SignatureApp.mlapp')
Click "Upload Image", select a signature, and press "Verify".

🧹 Preprocessing Steps
Inside preprocessSignature.m:

Convert RGB to grayscale (if needed)

Resize image to [64x64] or [128x128] as per model input

Normalize pixel values

Flatten or reshape based on CNN input format

📸 Screenshots
(Add screenshots of your UI and output results here)

🛠️ Requirements
MATLAB R2021a or later

Image Processing Toolbox

Deep Learning Toolbox

App Designer (built-in)

🧭 Future Improvements
Integrate support for signature bounding box detection

Add model confidence percentage

Export model as standalone executable (.exe) using MATLAB Compiler

Evaluate more preprocessing pipelines for robustness

👨‍🔬 Developed By
Randeep Singh

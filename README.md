# ISBI-2026-MPI-Encoding-Array
This project provides the 3D printing model files of the coil skeleton and the system matrix measurement data for "Heterogeneous receiving array-based gradient-free encoding for magnetic particle imaging".
![演示文稿1_02(2)](https://github.com/user-attachments/assets/c8e03d4d-c12e-4a1e-83ec-838b02298e4e)

📋 Overview
This project presents a novel gradient-free encoding method for Magnetic Particle Imaging (MPI) using spatially heterogeneous receiving arrays. The proposed approach eliminates the need for traditional field gradients by leveraging the spatial diversity of custom-designed receiver coils.

## 🗂️ Repository Structure
<img width="509" height="272" alt="image" src="https://github.com/user-attachments/assets/a663db43-40d1-4ef7-93c6-d90991da8ee0" />

## 🛠️ Hardware Fabrication
### 3D Printable Coil Support Structures
The _coil_support_structure/_ folder contains 8 STL files for fabricating the proposed MPI device:
* Receiver Coil Supports: Structural frames for the spatially heterogeneous receiving array  
* Excitation Coil Support: Framework for the excitation coil assembly  
* Compensation Coil Supports: Structures for field compensation coils  
* Enclosure/Housing: Main protective enclosure for the complete system  
Researchers can download these files and use standard 3D printing techniques to manufacture the physical device, then proceed with coil winding according to the specifications in our paper.

## 💻 Software Implementation
System Matrix and Reconstruction Codes
The system_matrix_and_codes/ folder contains all necessary data and MATLAB code for image reconstruction:
### Data Files
* S.mat: System matrix (complex-valued, size: 40×64) 
* b1.mat to b5.mat: Electromagnetic response data for 5 different test phantoms
### Reconstruction Method
The image reconstruction solves the linear system:
` S × c = b `  
where:
* S is the interpolated system matrix
* b is the measurement data from phantoms
* c is the reconstructed image

## 🚀 Quick Start
run the file:  
` main_ISBI `  
The script will:
* 1-Load the system matrix and measurement data  
* 2-Interpolate the system matrix to [15×15] resolution
* 3-Perform regularized Kaczmarz reconstruction
* 4-Display the original system matrix, interpolated matrix, and reconstructed image

⚙️ Customization
You can modify parameters in main_ISBI.m:
```
% Reconstruction parameters
max_iterations = 2000;
regularization_param = 5e-4;
``` 
## 🤝 Acknowledgments
We thank the contributors (Haicheng Du and Ziwei Chen), advisors (An Yu and professor Jie Tian) and reviewers for their valuable feedback

## 📞 Contact
If you have any questions about the code or 3D printing files, please feel free to contact us:
**Guanghui Li**  
Email: liguanghui@buaa.edu.cn  
<font color="blue">We are actively working to further optimize this encoding method and transform it into practical clinical devices. We greatly welcome any improvement suggestions, innovative ideas, or collaboration opportunities to advance this technology for clinical applications.</font>

_!! We believe in open science and collaborative innovation.**Your feedback and contributions are highly valued in our journey to make MPI technology more accessible and clinically relevant**._


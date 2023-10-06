# Abnormality-detection-for-novel-capsule-endoscope

The following code uses the wavelet transform, employing the **Daubechies 2** wavelet, in order to analyse the composition of the collected voltage-time signals from conducted TPU of the capsule endoscope and detect peaks from the signals. 

Biological signals are typically noisy, thus the wavelet transform helps convert the signal into a form that makes it much easier for the peak finder function. Here, the maximal overlap discrete wavelet transform (MODWT) function is used to extract the peaks of the signal.  

**Data used:** [Indentation5mm (2).csv](https://github.com/ab4821/Abnormality-detection-for-novel-capsule-endoscope/files/12834881/Indentation5mm.2.csv)


### Plot of original signal:

This comprises of the voltage signals obtained from the resistive TPU when periodically compressed to an indentation of 5mm.

![image](https://github.com/ab4821/Abnormality-detection-for-novel-capsule-endoscope/assets/92801647/5da5188c-b418-44bb-9a35-c8b2181a4aa3)


### Plot of original signal along with wavelet coefficients for each scale over time:

Here, the smaller scales correspond to higher frequencies which predominantly consist of noise. Higher up in the scale, coherent peaks arise corresponding to the indentations. Even higher coefficients depicts lower frequencies, and the signal starts to lose its peaks.

![image](https://github.com/ab4821/Abnormality-detection-for-novel-capsule-endoscope/assets/92801647/ba54a44c-a24b-4f63-a921-2d76739c439e)

### Signal reconstructed using information from the scale 2^3:

The signal is roughly reconstructed using the Inverse Maximal Discrete Wavelet Transform. This involves performing inverse transformation on the wavelet coefficients obtained from forward MODWT. 

![image](https://github.com/ab4821/Abnormality-detection-for-novel-capsule-endoscope/assets/92801647/094bc147-2573-4663-b046-c061bf26401a)


### Applying find-peaks function to the reconstructed signal:

The peak finder is applied to the reconstructed signal, which has more well-defined peaks than the noisy original signal. This gives approximate time stamps of each peak. To evaluate performance, the peaks are detected on top of the original signal as shown below.  

![image](https://github.com/ab4821/Abnormality-detection-for-novel-capsule-endoscope/assets/92801647/8bc86c87-2b4d-4465-9b06-668690dc7941)


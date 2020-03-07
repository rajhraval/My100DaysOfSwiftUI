//
//  ContentView.swift
//  Instafilter
//
//  Created by RAJ RAVAL on 02/03/20.
//  Copyright © 2020 Buck. All rights reserved.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var processedImage: UIImage?
    
    @State private var filterIntensity = 0.5
    @State private var filterRadius = 0.5
    @State private var filterScale = 0.5
    
    @State private var showingImagePicker = false
    @State private var showingFilterSheet = false
    @State private var showingStateAlert = false
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    
    
    let context = CIContext()
    
    var body: some View {
        let intensity = Binding<Double>(
            get: {
                self.filterIntensity
            },
            set: {
                self.filterIntensity = $0
                self.applyProcessing()
            }
        )
        let radius = Binding<Double>(
            get: {
                self.filterRadius
            },
            set: {
                self.filterRadius = $0
                self.applyProcessing()
            }
        )
        let scale = Binding<Double>(
            get: {
                self.filterScale
            },
            set: {
                self.filterScale = $0
                self.applyProcessing()
            }
        )
        return NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(Color.secondary)
                    if image != nil {
                        image?
                            .resizable()
                            .scaledToFit()
                    } else {
                        Text("Tap to select a picture")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                }
                .onTapGesture {
                    self.showingImagePicker = true
                }
                VStack {
                    HStack {
                        Text("Intensity")
                        Slider(value: intensity)
                    }
                    .padding(.vertical)
                    HStack {
                        Text("Radius")
                        Slider(value: radius)
                    }
                    .padding(.vertical)
                    HStack {
                        Text("Scale")
                        Slider(value: scale)
                    }
                    .padding(.vertical)
                }
                
                HStack {
                    Button(self.filterName(filter: currentFilter)) {
                        self.showingFilterSheet = true
                    }
                    Spacer()
                    Button("Save") {
                        guard let processedImage = self.processedImage else { return self.showAlert(title: "Image Saved Failed", message: "Please add an image to save it.") }
                        
                        let imageSaver = ImageSaver()
                        
                        imageSaver.successHandler = {
                            print("Image Save Successfull!")
                            self.showAlert(title: "Image Saved Successfully!", message: "Check your library for the new image you just created.")
                        }
                        
                        imageSaver.errorHandler = {
                            print("Problem: \($0.localizedDescription)")
                        }
                        
                        imageSaver.writeToPhotoAlbum(image: processedImage)
                    }
                    .alert(isPresented: $showingStateAlert) {
                        Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationBarTitle("Instafilter")
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: self.$inputImage)
            }
            .actionSheet(isPresented: $showingFilterSheet) {
                ActionSheet(title: Text("Select a Filter"), buttons: [
                    .default(Text("Crystallize")) { self.setFilter(CIFilter.crystallize()) },
                    .default(Text("Edges")) { self.setFilter(CIFilter.edges()) },
                    .default(Text("Gaussian Blur")) { self.setFilter(CIFilter.gaussianBlur()) },
                    .default(Text("Pixellate")) { self.setFilter(CIFilter.pixellate()) },
                    .default(Text("Sepia Tone")) { self.setFilter(CIFilter.sepiaTone()) },
                    .default(Text("Unsharp Mask")) { self.setFilter(CIFilter.unsharpMask()) },
                    .default(Text("Vignette")) { self.setFilter(CIFilter.vignette()) },
                    .cancel()
                ])
            }
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(filterRadius, forKey: kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(filterScale, forKey: kCIInputScaleKey)
        }
        
        guard let outputImage = currentFilter.outputImage else { return }
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }
    
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
    
    func showAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        showingStateAlert = true
    }
    
    func filterName(filter: CIFilter) -> String {
        if filter.name == "CISepiaTone" {
            return "Sepia"
        } else if filter.name == "CICrystallize" {
            return "Crystallize"
        } else if filter.name == "CIEdges" {
            return "Edges"
        } else if filter.name == "CIGaussianBlur" {
            return "Gaussian Blur"
        } else if filter.name == "CIPixellate" {
            return "Pixellate"
        } else if filter.name == "CIVignette" {
            return "Vignette"
        } else if filter.name == "CIUnsharpMask" {
            return "Unsharp Mask"
        } else  {
            return "Change Label"
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

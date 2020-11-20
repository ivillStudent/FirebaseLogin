import SwiftUI
import UIKit

var globalImage: UIImage? = nil
var globalHeight: Int = 0
var globalWidth: Int = 0
var isCamera: Bool = false
var isHealthy: Bool = false
var L1: Float = 0
var A1: Float = 0
var B1: Float = 0
var L2: Float = 0
var A2: Float = 0
var B2: Float = 0

var globalGoodThreshold = 0.0
var globalBadThreshold = 0.0

struct ModalView1: View {
    
    @Binding var showModal: Bool
    
    var body: some View {
        VStack {
            Spacer()
            if (isHealthy) {
                Image(systemName: "checkmark.circle.fill")
                .resizable().foregroundColor(greenColor).frame(maxWidth: 75, maxHeight: 75)
                Text("Plants have the correct amount of fertilizer.").font(.headline)
            } else {
                if (globalFertilizer) {
                    Image(systemName: "xmark.circle.fill")
                        .resizable().foregroundColor(Color.red).frame(maxWidth: 75, maxHeight: 75)
                    Text("Plants have the incorrect amount of fertilizer.").font(.headline)
                    Text("Fertilizer recommendation")
                } else {
                    Image(systemName: "xmark.circle.fill")
                        .resizable().foregroundColor(Color.red).frame(maxWidth: 75, maxHeight: 75)
                    Text("Plants have the incorrect amount of fertilizer.").font(.headline)
                    Text("No fertilizer recommendation")
                }
            }
            Spacer()
            Button(action: {
                withAnimation {
                    self.showModal.toggle()
                }
            }
                )
            {
                Text("Dismiss")
                    .frame(minWidth: 220, maxWidth: 220, minHeight: 60, maxHeight: 60, alignment: .center)
                    .foregroundColor(.white)
                    .background(greenColor)
                    .cornerRadius(15.0)
                    .font(.headline)
            }
        }
    }
}

struct ImportView: View {
    
    @State var showModal: Bool = true
    @State var modalSelection: Int = 0
    @State var loading: Bool = false
    @State var image: Image? = nil
    let imageSize = CGFloat(300)
    
        
    
    var body: some View {

        
        ZStack {
            NavigationView{
            VStack {


                
                Spacer()
                image?.resizable().frame(width: imageSize, height: imageSize).cornerRadius(imageSize).overlay(RoundedRectangle(cornerRadius: imageSize)
                    .stroke(greenColor, lineWidth: 4))
                Spacer()
                Button(action: {
                    print("Global good threshold: \(globalGoodThreshold)")
                    print("Global bad threshold: \(globalBadThreshold)")
                    print("Selected accuracy: \(globalAcceptPercentage)")
                    print("Global red: \(globalRedColor)")
                    print("Global green: \(globalGreenColor)")
                    print("Global blue: \(globalBlueColor)")
                    print("Recommendations: \(globalFertilizer)")
                    print("Cropping: \(globalCropping)")
                    self.loading.toggle()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.printBitmap()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.loading.toggle()
                        self.modalSelection=1
                        self.showModal.toggle()
                    }
                }
                    )
                {
                    if (!loading) {
                        Text("Analyze Image")
                        .frame(minWidth: 220, maxWidth: 220, minHeight: 60, maxHeight: 60, alignment: .center)
                        .foregroundColor(.white)
                        .background((image == nil) ? greenColor2 : greenColor)
                        .cornerRadius(15.0)
                        .font(.headline)
                    } else {
                        Text("Processing...")
                        .frame(minWidth: 220, maxWidth: 220, minHeight: 60, maxHeight: 60, alignment: .center)
                        .foregroundColor(.white)
                        .background((image == nil) ? greenColor2 : greenColor)
                        .cornerRadius(15.0)
                        .font(.headline)
                    }
                }
                .disabled((image == nil) ? true : false)
                .padding()
                Button(action: {
                    withAnimation {
                        isCamera = true
                        self.modalSelection=0
                        self.showModal.toggle()
                    }
                }
                    )
                {
                    Text("Capture New Image")
                        .frame(minWidth: 220, maxWidth: 220, minHeight: 60, maxHeight: 60, alignment: .center)
                        .foregroundColor(.white)
                        .background(greenColor)
                        .cornerRadius(15.0)
                        .font(.headline)
                }
                .padding()
                Button(action: {
                    withAnimation {
                        isCamera = false
                        self.modalSelection=0
                        self.showModal.toggle()
                    }
                }
                    )
                {
                    Text("Import New Image")
                        .frame(minWidth: 220, maxWidth: 220, minHeight: 60, maxHeight: 60, alignment: .center)
                        .foregroundColor(.white)
                        .background(greenColor)
                        .cornerRadius(15.0)
                        .font(.headline)
                }
                .padding()
                

                NavigationLink(destination: HowToUse()) {
                    Text("How to use")
                        .frame(minWidth: 220, maxWidth: 220, minHeight: 60, maxHeight: 60, alignment: .center)
                        .foregroundColor(.white)
                        .background(greenColor)
                        .cornerRadius(15.0)
                        .font(.headline)
                }
                .padding()
                Spacer()
            }
            .sheet(isPresented: $showModal) {
                if self.modalSelection == 0 {
                    ImagePicker(image: self.$image)
                }
                if self.modalSelection == 1 {
                    ModalView1(showModal: self.$showModal)
                }
            }
            }}
    }
    
    func printBitmap() {
        var colors = [UIColor]()
        var totalPixels = 0
        let threshold1 = globalGoodThreshold // Subject to change
        let threshold2 = globalBadThreshold // Subject to change
        var goodPixels = 0.0
        var badPixels = 0.0
        var outOfBoundsPixels = 0.0
        let acceptPercentage = globalAcceptPercentage
        
        let localImage = (globalImage?.resizeWithPercent(percentage: 0.5))!
        colors = (localImage.colors)!
        for color in colors {
            let components = color.components
            rgb2labL1(R: Float(globalRedColor), G: Float(globalGreenColor), B: Float(globalBlueColor))
            rgb2labL2(R: Float(components.red), G: Float(components.green), B: Float(components.blue))
            let LSubtract = L2 - L1
            let ASubtract = A2 - A1
            let BSubtract = B2 - B1
            let rSquared = pow(LSubtract, 2)
            let gSquared = pow(ASubtract, 2)
            let bSquared = pow(BSubtract, 2)
            let distance = Double(sqrt(rSquared + gSquared + bSquared))
            if (distance < threshold1) {
                goodPixels+=1
                //print("Distance: \(distance)", terminator: " ")
               // print("[\(components.red)", terminator:",")
                //print(components.green, terminator:",")
                //print(components.blue, terminator:"]\n")
            } else if (distance < threshold2) {
                badPixels+=1
                //print("Distance: \(distance)", terminator: " ")
               // print("[\(components.red)", terminator:",")
               // print(components.green, terminator:",")
                //print(components.blue, terminator:"]\n")
            } else {
                outOfBoundsPixels+=1
            }
            //print("Distance: \(distance)")
            //print("[\(Int(distance))", terminator: "] ")
            //print("[\(components.red)", terminator:",")
            //print(components.green, terminator:",")
            //print(components.blue, terminator:"] ")
            totalPixels+=1
            if (totalPixels % globalWidth == 0) {
                //print("\n")
            }
        }
        print("Good pixels: \(goodPixels), Bad Pixels: \(badPixels), Out of bounds pixels: \(outOfBoundsPixels)")
        print("Calculated accuracy is \(goodPixels/(goodPixels+badPixels))")
        if ((goodPixels/(goodPixels+badPixels)) >= acceptPercentage) {
            isHealthy = true
            print("Healthy plant")
        } else {
            isHealthy = false
            print("Unhealthy plant")
        }
        // print("height: \(globalHeight)")
        //print("width: \(globalWidth)")
    }
    
    func rgb2labL2(R : Float, G : Float, B : Float)
    {
        var var_R: Float = R/255.0
        var var_G: Float = G/255.0
        var var_B: Float = B/255.0
        
        
        if (var_R > 0.04045) {
            var_R = pow(((var_R + 0.055)/1.055), 2.4)
        } else {
            var_R = var_R / 12.92
        }
        
        if (var_G > 0.04045) {
            var_G = pow(((var_G + 0.055)/1.055), 2.4)
        } else {
            var_G = var_G / 12.92
        }
        
        if (var_B > 0.04045) {
            var_B = pow(((var_B + 0.055)/1.055), 2.4)
        } else {
            var_B = var_B / 12.92
        }
        
        var_R = var_R * 100.0
        var_G = var_G * 100.0
        var_B = var_B * 100.0
        
        
        var X: Float = var_R * 0.4124 + var_G * 0.3576 + var_B * 0.1805
        var Y: Float = var_R * 0.2126 + var_G * 0.7152 + var_B * 0.0722
        var Z: Float = var_R * 0.0193 + var_G * 0.1192 + var_B * 0.9505
        
        var var_X: Float = X / 95.047
        var var_Y: Float = Y / 100.000
        var var_Z: Float = Z / 108.883
        
        if (var_X > 0.008856) {
            var_X = pow(var_X, (1/3))
        } else {
            var_X = (7.787 * var_X) + (16/116)
        }
        if (var_Y > 0.008856) {
            var_Y = pow(var_Y, (1/3))
        } else {
            var_Y = (7.787 * var_Y) + (16/116)
        }
        if (var_Z > 0.008856) {
            var_Z = pow(var_Z, (1/3))
        } else {
            var_Z = (7.787 * var_Z) + (16/116)
        }
        
        L2 = (116 * var_Y) - 16
        A2 = 500 * (var_X - var_Y)
        B2 = 200 * (var_Y - var_Z)
    }
    
    func rgb2labL1(R : Float, G : Float, B : Float)
    {
        var var_R: Float = R/255.0
        var var_G: Float = G/255.0
        var var_B: Float = B/255.0
        
        
        if (var_R > 0.04045) {
            var_R = pow(((var_R + 0.055)/1.055), 2.4)
        } else {
            var_R = var_R / 12.92
        }
        
        if (var_G > 0.04045) {
            var_G = pow(((var_G + 0.055)/1.055), 2.4)
        } else {
            var_G = var_G / 12.92
        }
        
        if (var_B > 0.04045) {
            var_B = pow(((var_B + 0.055)/1.055), 2.4)
        } else {
            var_B = var_B / 12.92
        }
        
        var_R = var_R * 100.0
        var_G = var_G * 100.0
        var_B = var_B * 100.0
        
        
        var X: Float = var_R * 0.4124 + var_G * 0.3576 + var_B * 0.1805
        var Y: Float = var_R * 0.2126 + var_G * 0.7152 + var_B * 0.0722
        var Z: Float = var_R * 0.0193 + var_G * 0.1192 + var_B * 0.9505
        
        var var_X: Float = X / 95.047
        var var_Y: Float = Y / 100.000
        var var_Z: Float = Z / 108.883
        
        if (var_X > 0.008856) {
            var_X = pow(var_X, (1/3))
        } else {
            var_X = (7.787 * var_X) + (16/116)
        }
        if (var_Y > 0.008856) {
            var_Y = pow(var_Y, (1/3))
        } else {
            var_Y = (7.787 * var_Y) + (16/116)
        }
        if (var_Z > 0.008856) {
            var_Z = pow(var_Z, (1/3))
        } else {
            var_Z = (7.787 * var_Z) + (16/116)
        }
        
        L1 = (116 * var_Y) - 16
        A1 = 500 * (var_X - var_Y)
        B1 = 200 * (var_Y - var_Z)
    }
    
    
    
    
}

struct ImportView_Previews: PreviewProvider {
    static var previews: some View {
        ImportView()
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    
    @Environment(\.presentationMode)
    var presentationMode
    
    @Binding var image: Image?
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        @Binding var presentationMode: PresentationMode
        @Binding var image: Image?
        
        init(presentationMode: Binding<PresentationMode>, image: Binding<Image?>) {
            _presentationMode = presentationMode
            _image = image
        }
        
        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let uiImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            globalImage = uiImage
            image = Image(uiImage: uiImage)
            presentationMode.dismiss()
            
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            presentationMode.dismiss()
        }
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(presentationMode: presentationMode, image: $image)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        if (isCamera) {
            picker.sourceType = .camera
            picker.allowsEditing = globalCropping
            picker.delegate = context.coordinator
           
        } else {
            picker.delegate = context.coordinator
        }
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
    
}

extension UIImage {
    var colors: [UIColor]? {
        
        var colors = [UIColor]()
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        guard let cgImage = cgImage else {
            return nil
        }
        
        let width = Int(size.width)
        let height = Int(size.height)
        globalHeight = height
        globalWidth = width
        
        var rawData = [UInt8](repeating: 0, count: width * height * 4)
        let bytesPerPixel = 4
        let bytesPerRow = bytesPerPixel * width
        let bytesPerComponent = 8
        
        let bitmapInfo = CGImageAlphaInfo.premultipliedLast.rawValue | CGBitmapInfo.byteOrder32Big.rawValue
        
        let context = CGContext(data: &rawData,
                                width: width,
                                height: height,
                                bitsPerComponent: bytesPerComponent,
                                bytesPerRow: bytesPerRow,
                                space: colorSpace,
                                bitmapInfo: bitmapInfo)
        
        let drawingRect = CGRect(origin: .zero, size: CGSize(width: width, height: height))
        context?.draw(cgImage, in: drawingRect)
        
        for x in 0..<height {
            for y in 0..<width {
                let byteIndex = (bytesPerRow * x) + y * bytesPerPixel
                let red = CGFloat(rawData[byteIndex])
                let green = CGFloat(rawData[byteIndex + 1])
                let blue = CGFloat(rawData[byteIndex + 2])
                let alpha = CGFloat(rawData[byteIndex + 3])
                let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
                colors.append(color)
            }
        }
        
        return colors
    }
    
    func resizeWithPercent(percentage: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: size.width * percentage, height: size.height * percentage)))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
}

extension UIColor {
    var coreImageColor: CIColor {
        return CIColor(color: self)
    }
    var components: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        let coreImageColor = self.coreImageColor
        return (coreImageColor.red, coreImageColor.green, coreImageColor.blue, coreImageColor.alpha)
    }
}



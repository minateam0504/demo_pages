import SwiftUI

struct MinaLogo: View {
    enum Size {
        case small, medium, large
        
        var dimensions: CGFloat {
            switch self {
            case .small: return 60
            case .medium: return 120
            case .large: return 200
            }
        }
        
        var fontSize: CGFloat {
            switch self {
            case .small: return 16
            case .medium: return 28
            case .large: return 40
            }
        }
    }
    
    var size: Size
    
    var body: some View {
        VStack(spacing: 8) {
            // Logo image
            LogoShape()
                .frame(width: size.dimensions, height: size.dimensions)
            
            // Logo text
            Text("mina")
                .font(.custom("Georgia", size: size.fontSize))
                .foregroundColor(MinaColors.charcoal)
        }
    }
}

struct LogoShape: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Cloud shape
                Path { path in
                    let width = geometry.size.width
                    let height = geometry.size.height
                    
                    path.move(to: CGPoint(x: width * 0.79, y: height * 0.61))
                    path.addCurve(
                        to: CGPoint(x: width * 0.88, y: height * 0.42),
                        control1: CGPoint(x: width * 0.84, y: height * 0.61),
                        control2: CGPoint(x: width * 0.88, y: height * 0.52)
                    )
                    path.addCurve(
                        to: CGPoint(x: width * 0.79, y: height * 0.42),
                        control1: CGPoint(x: width * 0.88, y: height * 0.33),
                        control2: CGPoint(x: width * 0.84, y: height * 0.42)
                    )
                    path.addCurve(
                        to: CGPoint(x: width * 0.67, y: height * 0.34),
                        control1: CGPoint(x: width * 0.78, y: height * 0.42),
                        control2: CGPoint(x: width * 0.77, y: height * 0.37)
                    )
                    path.addCurve(
                        to: CGPoint(x: width * 0.56, y: height * 0.48),
                        control1: CGPoint(x: width * 0.61, y: height * 0.34),
                        control2: CGPoint(x: width * 0.57, y: height * 0.37)
                    )
                    path.addCurve(
                        to: CGPoint(x: width * 0.44, y: height * 0.48),
                        control1: CGPoint(x: width * 0.54, y: height * 0.42),
                        control2: CGPoint(x: width * 0.53, y: height * 0.41)
                    )
                    path.addCurve(
                        to: CGPoint(x: width * 0.39, y: height * 0.55),
                        control1: CGPoint(x: width * 0.47, y: height * 0.48),
                        control2: CGPoint(x: width * 0.43, y: height * 0.48)
                    )
                    path.addCurve(
                        to: CGPoint(x: width * 0.47, y: height * 0.63),
                        control1: CGPoint(x: width * 0.39, y: height * 0.59),
                        control2: CGPoint(x: width * 0.43, y: height * 0.63)
                    )
                }
                .stroke(MinaColors.charcoal, lineWidth: 8)
                
                // Stroller wheels
                Circle()
                    .fill(MinaColors.sageGreen)
                    .frame(width: geometry.size.width * 0.1, height: geometry.size.width * 0.1)
                    .overlay(Circle().stroke(MinaColors.charcoal, lineWidth: 4))
                    .position(x: geometry.size.width * 0.57, y: geometry.size.height * 0.75)
                
                Circle()
                    .fill(MinaColors.sageGreen)
                    .frame(width: geometry.size.width * 0.1, height: geometry.size.width * 0.1)
                    .overlay(Circle().stroke(MinaColors.charcoal, lineWidth: 4))
                    .position(x: geometry.size.width * 0.79, y: geometry.size.height * 0.75)
                
                // Stroller handle
                Path { path in
                    let width = geometry.size.width
                    let height = geometry.size.height
                    
                    path.move(to: CGPoint(x: width * 0.84, y: height * 0.75))
                    path.addLine(to: CGPoint(x: width * 0.86, y: height * 0.75))
                    path.addCurve(
                        to: CGPoint(x: width * 0.86, y: height * 0.7),
                        control1: CGPoint(x: width * 0.87, y: height * 0.75),
                        control2: CGPoint(x: width * 0.87, y: height * 0.72)
                    )
                    path.addLine(to: CGPoint(x: width * 0.84, y: height * 0.68))
                }
                .stroke(MinaColors.charcoal, lineWidth: 4)
                .frame(width: geometry.size.width, height: geometry.size.height)
                
                // Stroller vertical part
                Path { path in
                    path.move(to: CGPoint(x: geometry.size.width * 0.68, y: geometry.size.height * 0.47))
                    path.addLine(to: CGPoint(x: geometry.size.width * 0.68, y: geometry.size.height * 0.75))
                }
                .stroke(MinaColors.charcoal, lineWidth: 4)
                
                // Stroller horizontal part
                Path { path in
                    path.move(to: CGPoint(x: geometry.size.width * 0.52, y: geometry.size.height * 0.61))
                    path.addLine(to: CGPoint(x: geometry.size.width * 0.84, y: geometry.size.height * 0.61))
                }
                .stroke(MinaColors.charcoal, lineWidth: 4)
                
                // Stroller body
                Path { path in
                    let width = geometry.size.width
                    let height = geometry.size.height
                    
                    path.move(to: CGPoint(x: width * 0.52, y: height * 0.47))
                    path.addLine(to: CGPoint(x: width * 0.68, y: height * 0.47))
                    path.addCurve(
                        to: CGPoint(x: width * 0.68, y: height * 0.61),
                        control1: CGPoint(x: width * 0.76, y: height * 0.47),
                        control2: CGPoint(x: width * 0.68, y: height * 0.61)
                    )
                    path.addLine(to: CGPoint(x: width * 0.52, y: height * 0.61))
                    path.closeSubpath()
                }
                .fill(MinaColors.sageGreen)
                .overlay(
                    Path { path in
                        let width = geometry.size.width
                        let height = geometry.size.height
                        
                        path.move(to: CGPoint(x: width * 0.52, y: height * 0.47))
                        path.addLine(to: CGPoint(x: width * 0.68, y: height * 0.47))
                        path.addCurve(
                            to: CGPoint(x: width * 0.68, y: height * 0.61),
                            control1: CGPoint(x: width * 0.76, y: height * 0.47),
                            control2: CGPoint(x: width * 0.68, y: height * 0.61)
                        )
                        path.addLine(to: CGPoint(x: width * 0.52, y: height * 0.61))
                        path.closeSubpath()
                    }
                    .stroke(MinaColors.charcoal, lineWidth: 4)
                )
                
                // Stroller sun cover
                Path { path in
                    let width = geometry.size.width
                    let height = geometry.size.height
                    
                    path.move(to: CGPoint(x: width * 0.52, y: height * 0.47))
                    path.addLine(to: CGPoint(x: width * 0.68, y: height * 0.47))
                    path.addLine(to: CGPoint(x: width * 0.68, y: height * 0.61))
                }
                .stroke(MinaColors.charcoal, lineWidth: 4)
            }
        }
    }
}

struct MinaLogo_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 30) {
            MinaLogo(size: .small)
            MinaLogo(size: .medium)
            MinaLogo(size: .large)
        }
        .padding()
        .background(MinaColors.cream)
        .previewLayout(.sizeThatFits)
    }
}

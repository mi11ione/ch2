import _MapKit_SwiftUI
import SwiftUI

struct MapBottomSheet: View {
    @State private var showSheet: Bool = true

    var body: some View {
        Map(initialPosition: .region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 60.26309, longitude: -1.4077258), latitudinalMeters: 650, longitudinalMeters: 1300)))
            .sheet(isPresented: $showSheet) {
                SheetView()
                    .presentationBackgroundInteraction(.enabled)
            }
    }
}

struct SheetView: View {
    @State private var activeTab: AppTab = .swag
    @State private var currentDetent: PresentationDetent = .height(80)

    private var smallDetent: PresentationDetent { .height(isiOS26 ? 80 : 130) }

    var body: some View {
        GeometryReader {
            let paddingAdjust = $0.safeAreaInsets.bottom / 2
            VStack(spacing: .zero) {
                TabView(selection: $activeTab) {
                    ForEach(AppTab.allCases, id: \.rawValue) { tab in
                        Tab(value: tab) { IndividualTabView() }
                    }
                }
                .tabViewStyle(.tabBarOnly)
                .background { if #available(iOS 26, *) { TabHelper() } }
                .compositingGroup()

                tabContent()
                    .padding(.top, isiOS26 ? 11 : 5)
                    .padding(.bottom, isiOS26 ? 12 : 5)
                    .overlay(alignment: .top) { if !isiOS26 { Divider() } }
                    .padding(.bottom, isiOS26 ? paddingAdjust : 0)
            }
            .ignoresSafeArea(.all, edges: isiOS26 ? .bottom : [])
        }
        .presentationDetents([smallDetent, .fraction(0.6), .large], selection: $currentDetent)
        .interactiveDismissDisabled()
    }

    private func tabContent() -> some View {
        HStack(spacing: 8) {
            ForEach(AppTab.allCases, id: \.rawValue) { tab in
                VStack {
                    Image(systemName: "swift")
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundStyle(activeTab == tab ? .blue : .gray)
                    Text(tab.rawValue)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(activeTab == tab ? .blue : .gray)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .onTapGesture { activeTab = tab }
                }
            }
        }
        .padding(.horizontal, 12)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct IndividualTabView: View {
    var body: some View {
        EmptyView()
    }
}

enum AppTab: String, CaseIterable {
    case swag = "Swag"
    case flex = "Flex"
    case cool = "Cool"
    case heh = "Heh"
    case ninemice = "9mice"
}

#Preview {
    MapBottomSheet()
}

// <SwiftUI._UIInheritedView: 0x1050d0460; frame = (0 0; 402 7.33333); anchorPoint = (0, 0); autoresizesSubviews = NO; layer = <CALayer: 0x600000cb8e70>>
// <_TtGC7SwiftUI21UIKitPlatformViewHostGVS_42PlatformViewControllerRepresentableAdaptorVS_P10$1d974411421UIKitAdaptableTabView__: 0x10299fcc0; baseClass = _TtGC5UIKit22UICorePlatformViewHostGV7SwiftUI42PlatformViewControllerRepresentableAdaptorVS1_P10$1d974411421UIKitAdaptableTabView__; frame = (0 0; 402 7.33333); anchorPoint = (0, 0); tintColor = UIExtendedSRGBColorSpace 0 0.533333 1 1; layer = <CALayer: 0x600000cab870>>

// <SwiftUI.UIKitTabBarController: 0x1051a6000>

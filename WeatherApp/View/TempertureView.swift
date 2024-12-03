//
//  ForecastView.swift
//  WeatherAPI
//
//  Created by Abdiel Soto on 15/11/24.
//

import SwiftUI

final class TempertureViewModel {
    private let weather: Weather
    private var currentScale: Temperture.Scale = .farenheit
    
    init(weather: Weather) {
        self.weather = weather
    }
    
    var city: String {
        weather.city.name
    }
    
    var weatherDescription: String {
        weather.mainDescription
    }
    
    var wind: String {
        "\(weather.wind)"
    }
    
    var pressure: String {
        "\(weather.pressure)"
    }
    
    var humidity: String {
        "\(weather.humidity)"
    }
    
    var maxAndMinTemperture: String {
        let converter = KelvinTempertureConverter(scale: currentScale)

        return "H: \(String(format:"%.1f", converter.convert(temperture: weather.temperture.max)))° L: \(String(format:"%.1f", converter.convert(temperture: weather.temperture.min)))°"
    }
    
    var temperture: String {
        let converter = KelvinTempertureConverter(scale: currentScale)
        return "\(String(format:"%.1f", converter.convert(temperture: weather.temperture.kelvin)))°"
    }
}


struct TempertureView: View {
    
    let viewModel: TempertureViewModel
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .white]), startPoint: .topLeading, endPoint: .bottomTrailing)
            VisualEffectView(effect: UIBlurEffect(style: .systemMaterialDark))

            VStack {
                Text(viewModel.city)
                    .font(.system(size: 40, weight: .bold))
                    .foregroundStyle(.white)
                VStack(spacing: 0) {
                    Image(systemName: "cloud.sun.fill")
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                    Text(viewModel.temperture)
                        .font(.system(size: 70, weight: .medium))
                        .foregroundStyle(.white)
                    Text(viewModel.weatherDescription)
                        .font(.title)
                        .foregroundStyle(.white)
                        .padding(.vertical, 8)
                    Text(viewModel.maxAndMinTemperture)
                        .font(.title3)
                        .foregroundStyle(.white)
                }
                Divider()
                    .overlay(.white)
                    .padding(.horizontal)
                    .padding(.bottom)
                HStack {
                    detailView(text: viewModel.pressure,
                               image: .init(systemName: "smoke"))
                    .frame(maxWidth: .infinity)
                    Divider()
                        .overlay(.white)
                        .frame(height: 50)
                    detailView(text: viewModel.humidity,
                               image: .init(systemName: "humidity"))
                    .frame(maxWidth: .infinity)
                    Divider()
                        .overlay(.white)
                        .frame(height: 50)
                    detailView(text: viewModel.wind,
                               image: .init(systemName: "wind"))
                    .frame(maxWidth: .infinity)
                }
                Divider()
                    .overlay(.white)
                    .padding(.horizontal)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    private func detailView(text: String, image: Image) -> some View {
        VStack(spacing: 10) {
            image
                .imageScale(.large)
                .foregroundColor(.white)
            Text(text)
                .foregroundStyle(.white)
                .font(.subheadline)
        }
    }
}

struct HourSummaryView: View {
    let temp: String
    let icon: Image?
    let time: String

    var body: some View {
        VStack(spacing: 16) {
            Text(temp)
                .font(.caption)
                .fontWeight(.medium)
            icon?
                .renderingMode(.original)
                .imageScale(.large)
            Text(time)
                .font(.caption)
                .fontWeight(.medium)
        }
        .frame(width: 60, height: 90)
        .padding(10)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10)
    }
}


#Preview {
    TempertureView(
        viewModel: TempertureViewModel(weather: WeatherResponse.stub().toEntity())
    )
}

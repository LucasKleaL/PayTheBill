//
//  FooterView.swift
//  PayTheBill
//
//  Created by Lucas Kusman Leal on 17/05/22.
//

import SwiftUI

struct FooterView: View {
    
    var currentPage = "";
    @State var homeIconColor: Color?
    @State var addIconColor: Color?
    @State var chartIconColor: Color?
    @State var listIconColor: Color?
    @State var goToHomeView = false;
    @State var goToAddDashboard = false;
    @State var goToChartView = false;
    @State var goToListView = false;
    @State var goToContentView = false;
    
    init(currentPage: String) {
        self.currentPage = currentPage;
    }
    
    var body: some View {
        
        VStack {
            
            RoundedRectangle(cornerRadius: 0, style: .continuous)
                .foregroundColor(Color("FooterGray"))
                .opacity(0.8)
                .frame(width: UIScreen.main.bounds.width, height: 50)
                .overlay(
                    HStack {
                        
                        NavigationLink(destination: HomeView(), isActive: $goToHomeView) {
                            Button() {
                                goToHomeView = true;
                            } label: {
                                Image(systemName: "house.fill")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(self.homeIconColor)
                            }
                            .padding(.horizontal, 20.0)
                            .onAppear() {
                                if (currentPage == "home") {
                                    self.homeIconColor = Color("InteractionPink");
                                }
                                else {
                                    self.homeIconColor = Color("DisabledPurple")
                                }
                            }

                        }
                        
                        NavigationLink(destination: AddDashboardView(), isActive: $goToAddDashboard) {
                            Button {
                                goToAddDashboard = true;
                            } label: {
                                Image(systemName: "plus.app")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(self.addIconColor)
                            }
                            .padding(.horizontal, 20.0)
                            .onAppear() {
                                if (currentPage == "add") {
                                    self.addIconColor = Color("InteractionPink");
                                }
                                else {
                                    self.addIconColor = Color("DisabledPurple")
                                }
                            }

                        }
                        
                        Button {
                            goToChartView = true;
                        } label: {
                            Image(systemName: "chart.bar")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(self.chartIconColor)
                        }
                        .padding(.horizontal, 20.0)
                        .onAppear() {
                            if (currentPage == "chart") {
                                self.chartIconColor = Color("InteractionPink");
                            }
                            else {
                                self.chartIconColor = Color("DisabledPurple")
                            }
                        }

                        NavigationLink(destination: ListView(), isActive: $goToListView) {
                            Button {
                                goToListView = true;
                            } label: {
                                Image(systemName: "list.dash")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(self.listIconColor)
                            }
                            .padding(.horizontal, 20.0)
                            .onAppear() {
                                if (currentPage == "list") {
                                    self.listIconColor = Color("InteractionPink");
                                }
                                else {
                                    self.listIconColor = Color("DisabledPurple")
                                }
                            }
                        }
                        
                    }
                )
                
            }.edgesIgnoringSafeArea(.all)
            .navigationBarBackButtonHidden(true)
            .navigationViewStyle(.stack)
            .onAppear {
                //
            }
        }
    
    
}

struct FooterView_Previews: PreviewProvider {
    static var previews: some View {
        FooterView(currentPage: "")
    }
}

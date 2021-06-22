import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';

import { MaterialModule } from "./modules/material.module";
import { ToolbarComponent } from './core/components/toolbar/toolbar.component';
import { BridgeCardComponent } from './core/components/cards/bridge-card/bridge-card.component';
import { HomePageComponent } from './pages/home-page/home-page.component';
import { BridgePageComponent } from './pages/bridge-page/bridge-page.component';

@NgModule({
  declarations: [
    AppComponent,
    ToolbarComponent,
    BridgeCardComponent,
    HomePageComponent,
    BridgePageComponent
  ],
  imports: [
    AppRoutingModule,
    BrowserModule,
    BrowserAnimationsModule,
    MaterialModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }

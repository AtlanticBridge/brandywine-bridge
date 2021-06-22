import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { BridgePageComponent } from './pages/bridge-page/bridge-page.component';
import { HomePageComponent } from './pages/home-page/home-page.component';

const routes: Routes = [
  {
    path: '',
    component: HomePageComponent,
    data: {
      title: 'Home Page'
    }
  },
  {
    path: 'bridge',
    component: BridgePageComponent,
    data: {
      title: 'Brandywine Bridge'
    }
  }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }

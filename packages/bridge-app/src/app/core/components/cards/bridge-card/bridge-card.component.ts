import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-bridge-card',
  templateUrl: './bridge-card.component.html',
  styleUrls: ['./bridge-card.component.scss']
})
export class BridgeCardComponent implements OnInit {

  constructor() { }

  ngOnInit(): void {
  }

  sendEth2Erd(address: string): void {
    console.log(address)
  }

}

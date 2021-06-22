import { ComponentFixture, TestBed } from '@angular/core/testing';

import { BridgeCardComponent } from './bridge-card.component';

describe('BridgeCardComponent', () => {
  let component: BridgeCardComponent;
  let fixture: ComponentFixture<BridgeCardComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ BridgeCardComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(BridgeCardComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

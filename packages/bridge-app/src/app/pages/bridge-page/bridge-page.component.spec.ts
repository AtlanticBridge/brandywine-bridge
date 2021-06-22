import { ComponentFixture, TestBed } from '@angular/core/testing';

import { BrdigePageComponent } from './bridge-page.component';

describe('BrdigePageComponent', () => {
  let component: BrdigePageComponent;
  let fixture: ComponentFixture<BrdigePageComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ BrdigePageComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(BrdigePageComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

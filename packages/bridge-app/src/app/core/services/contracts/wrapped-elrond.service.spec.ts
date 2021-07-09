import { TestBed } from '@angular/core/testing';

import { WrappedElrondService } from './wrapped-elrond.service';

describe('WrappedElrondServiceService', () => {
  let service: WrappedElrondService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(WrappedElrondService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});

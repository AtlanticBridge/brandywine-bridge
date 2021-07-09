import { Injectable } from '@angular/core';
import { WrappedElrondInjectable } from "./wrapped-elrond.injectable";

@Injectable({
  providedIn: 'root'
})
export class WrappedElrondService {

  constructor(
    private wrappedElrondInj: WrappedElrondInjectable
  ) { }
}

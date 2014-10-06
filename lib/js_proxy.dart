library js_proxy;

@MirrorsUsed(symbols: '*', override: '*')
import 'dart:mirrors';
import 'dart:js' as js;

/**
 * Convert [Symbol] into String.
 */
String symbolAsString(Symbol symbol) => MirrorSystem.getName(symbol);

/**
 * Proxy class for JavaScript object
 */
@proxy
class JProxy {
  /**
   * Proxied object.
   */
  js.JsObject _object;
  
  /**
   * Return proxied object.
   */
  js.JsObject get object => _object;
  
  /**
   * Constructor with optional proxied [JsObject].
   */
  JProxy([this._object]);
  
  /**
   * Find object in [context] by [name] and proxied it.
   */
  JProxy.fromContext(String name) {
    _object = js.context[name];
  }
  
  /**
   * Return 'this' object
   */
  getThis() => this;
  
  /**
   * Call the instance to dynamically emulate a function. 
   */
  dynamic call([arg0 = null, arg1 = null, arg2 = null, arg3 = null, arg4 = null, arg5 = null, arg6 = null, arg7 = null, arg8 = null, arg9 = null]) {
      var args = [];
      if (arg0 != null) args.add(arg0);
      if (arg1 != null) args.add(arg1);
      if (arg2 != null) args.add(arg2);
      if (arg3 != null) args.add(arg3);
      if (arg4 != null) args.add(arg4);
      if (arg5 != null) args.add(arg5);
      if (arg6 != null) args.add(arg6);
      if (arg7 != null) args.add(arg7);
      if (arg8 != null) args.add(arg8);
      if (arg9 != null) args.add(arg9);
      return new JProxy((_object as js.JsFunction).apply(args));
    }
  
  /**
   * This methods is invoked when a non-existent method on an object invokes.
   * The name of the method and the arguments of the invocation are passed 
   * in an [Invocation]. This method returns a value, that value becomes the 
   * result of the original invocation.
   */
  @override
  dynamic noSuchMethod(Invocation invocation) {
    if (invocation.isMethod) {
      return _proxify(_object.callMethod(symbolAsString(invocation.memberName), _jsify(invocation.positionalArguments)));
    } else if (invocation.isGetter) {
      return _proxify(_object[symbolAsString(invocation.memberName)]);
    } else if (invocation.isSetter) {
      throw new Exception('The setter feature was not implemented yet.');
    }
    return super.noSuchMethod(invocation);
  }
  
  /**
   * Path through list of [params] and jsify each element of it.
   */
  List _jsify(List params) {
    List res = [];
    params.forEach((item) {
      if (item is Map || item is List) {
        res.add(new js.JsObject.jsify(item));
      } else {
        res.add(item);
      }
    });
    return res;
  }
  
  /**
   * Wrap the [value] with JProxy only if value is an [JsObject] type.
   */
  dynamic _proxify(value) {
    return value is js.JsObject ? new JProxy(value) : value;
  }
  
  /**
   * This method returns result of invocation of [toString] method of proxied object.
   */
  @override
  String toString() {
    return _object.toString();
  }
}
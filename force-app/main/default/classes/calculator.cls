//Generated by wsdl2apex

public class calculator {
    public class Add_element {
        public Integer intA;
        public Integer intB;
        private String[] intA_type_info = new String[]{'intA','http://tempuri.org/',null,'1','1','false'};
        private String[] intB_type_info = new String[]{'intB','http://tempuri.org/',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://tempuri.org/','true','false'};
        private String[] field_order_type_info = new String[]{'intA','intB'};
    }
    public class Subtract_element {
        public Integer intA;
        public Integer intB;
        private String[] intA_type_info = new String[]{'intA','http://tempuri.org/',null,'1','1','false'};
        private String[] intB_type_info = new String[]{'intB','http://tempuri.org/',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://tempuri.org/','true','false'};
        private String[] field_order_type_info = new String[]{'intA','intB'};
    }
    public class SubtractResponse_element {
        public Integer SubtractResult;
        private String[] SubtractResult_type_info = new String[]{'SubtractResult','http://tempuri.org/',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://tempuri.org/','true','false'};
        private String[] field_order_type_info = new String[]{'SubtractResult'};
    }
    public class Multiply_element {
        public Integer intA;
        public Integer intB;
        private String[] intA_type_info = new String[]{'intA','http://tempuri.org/',null,'1','1','false'};
        private String[] intB_type_info = new String[]{'intB','http://tempuri.org/',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://tempuri.org/','true','false'};
        private String[] field_order_type_info = new String[]{'intA','intB'};
    }
    public class MultiplyResponse_element {
        public Integer MultiplyResult;
        private String[] MultiplyResult_type_info = new String[]{'MultiplyResult','http://tempuri.org/',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://tempuri.org/','true','false'};
        private String[] field_order_type_info = new String[]{'MultiplyResult'};
    }
    public class AddResponse_element {
        public Integer AddResult;
        private String[] AddResult_type_info = new String[]{'AddResult','http://tempuri.org/',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://tempuri.org/','true','false'};
        private String[] field_order_type_info = new String[]{'AddResult'};
    }
    public class Divide_element {
        public Integer intA;
        public Integer intB;
        private String[] intA_type_info = new String[]{'intA','http://tempuri.org/',null,'1','1','false'};
        private String[] intB_type_info = new String[]{'intB','http://tempuri.org/',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://tempuri.org/','true','false'};
        private String[] field_order_type_info = new String[]{'intA','intB'};
    }
    public class DivideResponse_element {
        public Integer DivideResult;
        private String[] DivideResult_type_info = new String[]{'DivideResult','http://tempuri.org/',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://tempuri.org/','true','false'};
        private String[] field_order_type_info = new String[]{'DivideResult'};
    }
    public class CalculatorSoap {
        public String endpoint_x = 'http://www.dneonline.com/calculator.asmx';
        public Map<String,String> inputHttpHeaders_x;
        public Map<String,String> outputHttpHeaders_x;
        public String clientCertName_x;
        public String clientCert_x;
        public String clientCertPasswd_x;
        public Integer timeout_x;
        private String[] ns_map_type_info = new String[]{'http://tempuri.org/', 'calculator'};
        public Integer Divide(Integer intA,Integer intB) {
            calculator.Divide_element request_x = new calculator.Divide_element();
            request_x.intA = intA;
            request_x.intB = intB;
            calculator.DivideResponse_element response_x;
            Map<String, calculator.DivideResponse_element> response_map_x = new Map<String, calculator.DivideResponse_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              'http://tempuri.org/Divide',
              'http://tempuri.org/',
              'Divide',
              'http://tempuri.org/',
              'DivideResponse',
              'calculator.DivideResponse_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x.DivideResult;
        }
        public Integer Add(Integer intA,Integer intB) {
            calculator.Add_element request_x = new calculator.Add_element();
            request_x.intA = intA;
            request_x.intB = intB;
            calculator.AddResponse_element response_x;
            Map<String, calculator.AddResponse_element> response_map_x = new Map<String, calculator.AddResponse_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              'http://tempuri.org/Add',
              'http://tempuri.org/',
              'Add',
              'http://tempuri.org/',
              'AddResponse',
              'calculator.AddResponse_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x.AddResult;
        }
        public Integer Multiply(Integer intA,Integer intB) {
            calculator.Multiply_element request_x = new calculator.Multiply_element();
            request_x.intA = intA;
            request_x.intB = intB;
            calculator.MultiplyResponse_element response_x;
            Map<String, calculator.MultiplyResponse_element> response_map_x = new Map<String, calculator.MultiplyResponse_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              'http://tempuri.org/Multiply',
              'http://tempuri.org/',
              'Multiply',
              'http://tempuri.org/',
              'MultiplyResponse',
              'calculator.MultiplyResponse_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x.MultiplyResult;
        }
        public Integer Subtract(Integer intA,Integer intB) {
            calculator.Subtract_element request_x = new calculator.Subtract_element();
            request_x.intA = intA;
            request_x.intB = intB;
            calculator.SubtractResponse_element response_x;
            Map<String, calculator.SubtractResponse_element> response_map_x = new Map<String, calculator.SubtractResponse_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              'http://tempuri.org/Subtract',
              'http://tempuri.org/',
              'Subtract',
              'http://tempuri.org/',
              'SubtractResponse',
              'calculator.SubtractResponse_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x.SubtractResult;
        }
    }
}
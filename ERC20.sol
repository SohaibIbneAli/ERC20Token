pragma solidity >=0.5.0 <0.7.0;
interface ERC20
{
    function totalSupply() external view returns (uint _totalSupply);

    function balanceOf(address _owner) external view returns (uint balance);
    
    function transfer(address _to,uint _value) external returns(bool success);
    
    function transferFrom(address _from,address _to,uint _value) external returns(bool success);
    
    function approve(address _spender,uint _value) external returns(bool success);
    
    function allowance(address _owner,address _spender) external view returns(uint reminder);
    
    event Transfer (address indexed _from, address indexed _to, uint _value);
    event Approval (address indexed _owner, address indexed _spender, uint _value);
    
}


contract MyFirstToken is ERC20
{
    string public constant symbol = "MFT";
    string public constant name ="My First Token";
    uint public constant decimals=10;

    uint private constant __totalSupply=1000;
   
    mapping (address => uint ) private __balanceOf;
    mapping(address => mapping(address=>uint)) private __allowance;
    
    constructor() public
    {
        __balanceOf[msg.sender]=__totalSupply;        
    }
    
    function totalSupply() public view returns (uint _totalSupply)
    {
        _totalSupply=__totalSupply;
    }

    function balanceOf(address _owner) public view returns (uint balance)
    {
        return __balanceOf[_owner];
    }
    
    function transfer(address _to,uint _value) public returns(bool success)
    {
        if(_value > 0 && _value <= balanceOf(msg.sender) )
        {
            __balanceOf[msg.sender] -=_value;
            __balanceOf[_to] +=_value;
            return true;
            
        }
        return false;
        
    }
    
    function transferFrom(address _from,address _to,uint _value) public returns(bool success)
    {
        if(__allowance[_from][msg.sender] >0 && _value >0 && __allowance[_from][msg.sender] >=_value)
        {
         __balanceOf[_from] -=_value;
         __balanceOf[_to] +=_value;
            return true;
        }
            return false;
    }
    
    function approve(address _spender,uint _value) public returns(bool success)
    {
        __allowance[msg.sender][_spender]=_value;
    }
    
    function allowance(address _owner,address _spender) public view returns(uint reminder)
    {
        return __allowance[_owner][_spender];
    }
    
    
}

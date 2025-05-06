/**
 * @description       : Classes Virtuais
 * @last modified on  : 05-05-2025
 * @last modified by  : Alessandro Souza
**/
public virtual with sharing class VirtualClass {
    protected String bottleType;
    protected String bottleStatus = 'closed';

    public String getStatusBottle() {
        return 'Bottle is' + this.bottleStatus;
    }

    public VirtualClass() {
        this.bottleType = 'Default Bottle';
    }

    public virtual void setOpening() {
        this.bottleStatus = 'open';
        System.debug('Opening the bottle of type: ' + this.bottleType);
    }

    public virtual void setClosing() {
        this.bottleStatus = 'closed';
        System.debug('Closing the bottle of type: ' + this.bottleType);
    }
    
    public virtual void setBottleType(String bottleType) {
        this.bottleType = bottleType;
    }
}
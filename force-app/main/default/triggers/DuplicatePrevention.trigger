trigger DuplicatePrevention on Contact (before insert) {
    
list <String> emailSet = new list<String>(); 

for (contact con:trigger.new) {
emailSet.add(con.email);
}
    
list<Contact> contactlist = [SELECT email FROM Contact WHERE email IN :emailSet];
    
for (contact con:trigger.new) {
If (contactList.size() > 0) {
con.email.adderror( 'Duplicate Contact Found. Use Existing Contact.' );
}
}
}
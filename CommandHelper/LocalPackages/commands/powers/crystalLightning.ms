register_command('crystallightning', 
    array(
        'description': 'Power',
        'permission': 'powers.crystallightning',
        'noPermMsg': 'Sorry you don\'t have permission to use this command.',
        'executor': closure() { 

            @player = player()
            include('/home/minecraft/server/plugins/CommandHelper/includes/coolDown.ms')
            if(_coolDown('crystalLightning',1,@player)){
                return()
            }
    
            if(!has_bind(@player.'crystalLightning')){
                console('binded!')
                bind('entity_damage',array('id':@player.'crystalLightning'),array('cause':'LIGHTNING'),@e,@player){
                    cancel()
                    console('bind fired!')
                    if(@player == player()){
                        set_timeout(1500,closure( 
                            unbind()
                        ))
                    }else{
                        console(@e)
                    }
                }
            }
            set_timeout(500,closure( 
                lightning(ploc(@player))
            ))
        }
    
    )
) 

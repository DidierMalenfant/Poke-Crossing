stds.didiermalenfant_pdutility = {
    globals = {
        enum = {},
        math = {
            -- This will be overidden for the math.lua file but here we don't want
            -- to make the entire 'math' global read-write in other pdutility files.
            read_only = true,
            fields = {
                clamp = {},
                ring = {},
                ring_int = {},
                approach = {},
                infinite_approach = {},
                round = {},
                sign = {},
            }
        },
        pdutility = {
            fields = {
                animation = {
                    fields = {
                        animatedImage = {
                            fields = {
                                super = { 
                                    fields = {
                                        className = {},
                                        init = {},
                                    }
                                },
                                className = {},
                                new = {},
                                init = {},
                                reset = {},                                
                                setDelay = {},
                                getDelay = {},
                                setShouldLoop = {},
                                getShouldLoop = {},
                                setPaused = {},
                                getPaused = {},
                                setFrame = {},
                                getFrame = {},
                                setFirstFrame = {},
                                setLastFrame = {},
                                __index = {},
                            }                
                        },
                        sequence = {
                            fields = {
                                __index = {},
                                super = { 
                                    fields = {
                                        className = {},
                                        init = {},
                                    }
                                },
                                className = {},
                                new = {},
                                init = {},
                                update = {},
                                print = {},
                                clear = {},
                                from = {},
                                to = {},
                                set = {},
                                again = {},
                                sleep = {},
                                loop = {},
                                mirror = {},
                                newEasing = {},
                                getEasingByIndex = {},
                                getEasingByTime = {},
                                get = {},
                                getClampedTime = {},
                                start = {},
                                stop = {},
                                pause = {},
                                restart = {},
                                isDone = {},
                                isEmpty = {},
                            }
                        }
                    }
                },
                debug = {
                    fields = {
                        betamax = {
                            fields = {
                                eof = {},
                                printFrame = {},
                            }
                        },                        
                        showToast = {},
                        sampler = {
                            fields = {
                                super = { 
                                    fields = {
                                        className = {},
                                        init = {},
                                    }
                                },
                                className = {},
                                new = {},
                                init = {},
                                reset = {},                                
                                print = {},                                
                                draw = {},
                            }
                        }
                    }
                },
                filepath = {
                    fields = {
                        filename = {},
                        extension = {},
                        directory = {},
                        basename = {},
                        join = {},
                    }
                },
                graphics = {
                    fields = {
                        drawTiledImage = {},
                        drawQuadraticBezier = {},
                        drawCubicBezier = {},
                        getSvgPaths = {},
                        parallax = {
                            fields = {
                                super = { 
                                    fields = {
                                        className = {},
                                        init = {},
                                    }
                                },
                                className = {},
                                new = {},
                                init = {},
                                draw = {},
                                addLayer = {},
                                scroll = {},
                            }
                        },
                        tiled = {
                            fields = {
                                importTilemapsFromTiledJSON = {},
                            }
                        },
                    }
                },
                utils = {
                    fields = {
                        signal = {
                            fields = {
                                super = { 
                                    fields = {
                                        className = {},
                                        init = {},
                                    }
                                },
                                className = {},
                                new = {},
                                init = {},
                                subscribe = {},
                                unsubscribe = {},
                                notify = {},
                            }
                        },
                        state = {
                            fields = {
                                super = { 
                                    fields = {
                                        className = {},
                                        init = {},
                                    }
                                },
                                className = {},
                                new = {},
                                init = {},
                                __newindex = {},
                                __index = {},
                                subscribe = {},
                                unsubscribe = {},
                            }
                        }
                    }
                }
            }
        },
        table = {
            -- This will be overidden for the table.lua file but here we don't want
            -- to make the entire 'table' global read-write in other pdutility files.
            read_only = true,
            fields = {
                random = {},
                each = {},
                newAutotable = {},
            }
        }
    }
}

std = "lua54+playdate+didiermalenfant_pdutility"

globals = {
    Main = {
        fields = {
            super = { 
                fields = {
                    init = {},                    className = {},
                }
            },
            className = {},
            init = {},
            update = {},
        }
    },
    Player = {
        fields = {
            super = { 
                fields = {
                    init = {},
                    className = {},
                }
            },
            className = {},
            init = {},
            update = {},
            goLeft = {},
            goRight = {},
            jump = {},
            turn = {},
            isJumping = {},
            collisionResponse = {},
            drawDebug = {},
        }
    },
}

operators = {"+=", "-=", "*=", "/="}
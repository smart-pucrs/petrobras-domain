#! /home/rafaelcc/acl/alisp -#!
(require :asdf)
(push "/home/rafaelcc/shop2/" asdf:*central-registry*)
(asdf:oos 'asdf:load-op :shop2)
(load "/home/rafaelcc/petrobras-domain/htn/p01")

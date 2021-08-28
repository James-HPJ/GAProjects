const express = require("express");
const snakeModel = require("../models/snakes");
const controller = express.Router();

controller.get('/seed', async(req, res) => {
    await snakeModel.insertMany([
        {
            commonName: 'Oriental Whip Snake',
            scientificName: 'Ahaetulla prasina',
            img: 'https://lh3.googleusercontent.com/II7XZfywPN3F06kfo7N5iLiEC7dlXSOl5jmpAP__XVOZ5GalqCh6WhQ9-JTI-UsGzSRQX-wJbdurf5bMEIn4paViutX6gpy9AdKNUQ2LmN4bPyqm-YIg1v3OcpE_H-vysgHxxpnfng=w2400',
            dateFound: new date('2020-12-06'),
            description: 'bright yellow, juvenile',
            location: {
                type: 'Point', 
                coordinates: [1.353429, 103.773746],
        
            },
        },
        {
            commonName: 'Reticulated Python',  
            scientificName: 'Malayopython reticulatus',
            img: 'https://lh3.googleusercontent.com/RmpEhWBaRax2HOcHCTQ-5qu0mcxPS-32o2ryWyp9hcb3OtAHUy-Hy4qQAuyO2K0takLi686JzsSAFalNCFKMf-sXRC27kYJqfGAdiHDkM-wgWoQnSMX6vdCT5QGKI695GTsSgaLrsA=w2400',
            dateFound: new date('2021-06-06'),
            description: 'Young Adult, found along canal',
            location: {
                type: 'Point', 
                coordinates: [1.339709, 103.812770],
            },
        },       
        
        {
            commonName: 'Blue Coral Snake',  
            scientificName: 'Calliophis bivirgatus',
            img: 'https://lh3.googleusercontent.com/R4Zq4c4xger87K3VmQDWaYi7ATw3fKY9iaDpnFSBeycW84u6ztfNj6BK9ndhO0OpaXoxWgR2je1RyiJDekVUvsVnEss73SyGxMYigRCJjvbEPls-dY9ESSc5kQqj7Ue3QnUQWkQHAQ=w2400',
            dateFound: new date('2020-05-25'),
            description: 'Adult, found burrowing in dead leaves',
            location: {
                type: 'Point', 
                coordinates: [1.380250, 103.822886],
            },
        },        
        
        {
            commonName: `Kopstein's Bronzeback`,  
            scientificName: 'Dendrelaphis kopsteini',
            img: 'https://lh3.googleusercontent.com/SRiydyP11rhUpASRHWEWVOwswvAQ82h-A7RLn2DO80lzbVaC5fuGTI282quxKG_4bE37sse0F2i5hSxzwe7iDZfavTiKTE85qbFS7clkIUKObXMQ-BTJtPVLkttA7zzeN_fPc_kW9g=w2400',
            dateFound: new date('2020-01-23'),
            description: 'Young adult, displayed hunting behaviour',
            location: {
                type: 'Point', 
                coordinates: [1.246694, 103.828962],
            },
        }, 
        
        {
            commonName: 'Twin Barred Tree Snake',  
            scientificName: 'Chrysopelea pelias',
            img: 'https://lh3.googleusercontent.com/Kn64Yzz0T-WWfjVjPJd_DJI6T1MxSN3bfECDzPymVsrUt10yzfNgbDXaqCsyE8Nrym6ntG1BX5CFz1KMFU6STr7b5IhJMNAT0vPspzPG4s_IB15tcmxXZATCwumBzzvLcfC1XdlZ8A=w2400',
            dateFound: new date('2021-03-21'),
            description: 'Juvenile, resting on moss',
            location: {
                type: 'Point', 
                coordinates: [1.360896, 103.773971],
            },
        },
        
        {
            commonName: `Wagler's Pit Viper`,  
            scientificName: 'Tropidolaemus wagleri',
            img: 'https://lh3.googleusercontent.com/-yrXIKPRQ7-lFld4MC7OW3_2Nit4mrHCOLlvfBaT8jBZitVudY2xEFaAID00nyA8BVq-5lggpBKmgQUb-eIBWu4BB0bd4YGuGALFlmlJITL6X57C2L9ATjNHvdS-1VHfioKCIdHkrw=w2400',
            dateFound: new date('2020-08-18'),
            description: 'Adult, resting on tree branch',
            location: {
                type: 'Point', 
                coordinates: [1.251685, 103.827170],
            },
        },       
        
        {
            commonName: `Paradise Tree Snake`,  
            scientificName: 'Chrysopelea paradisi',
            img: 'https://lh3.googleusercontent.com/hfP9CJ8a2K1d3W-A7FewUrGuo3BOtl7W5cIaADcY2aq2pqit-TZzWSXTsBYfTP0QJpq7BtoMEiOwYjdNV4GN27_238DagkN6IZ63Ow7Tu3ePFDELvA87wzF07A9bL9bZNjzPWaM1Tw=w2400',
            dateFound: new date('2010-01-01'),
            description: 'Juvenile, moving along leaves',
            location: {
                type: 'Point', 
                coordinates: [1.347380, 103.778462],
            },
        },       
        
        {
            commonName: `Gold-ringed Catsnake`,  
            scientificName: 'Boiga dendrophila',
            img: 'https://lh3.googleusercontent.com/YCbZBkJzUap08bf7D4zRfJw-v1deddZSFtXYrqUi7OFyOQo0-oEhlD-C9dP4tPR4tZ9ilSrTAk1gXTtiUDnfZQwc91ZP281Ze4-yoqaD0Qp_Pljkv6pXBe4kwdIQhQaaA_P-YnDPsg=w2400',
            dateFound: new date('2020-04-02'),
            description: 'Adult, moving along swarmp',
            location: {
                type: 'Point', 
                coordinates: [1.415737, 103.819005],
            },
        },
        
    ])

    res.send('Seeding is completed')
})

module.exports = controller
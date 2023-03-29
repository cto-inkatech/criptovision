
import { expect } from "chai";
import { ethers } from "hardhat";

describe("InkToken", function () {



  describe("Deployment", function () {
    it("Deploy y Sendstorage", async function () {
      const accounts = await ethers.getSigners();
      const address = accounts[0].address;

      const Ikt = await ethers.getContractFactory("InkToken");
      const ikt = await Ikt.deploy();

      const IkntSwap = await ethers.getContractFactory("InkSwap");
      const ikntSwap = await IkntSwap.deploy(ikt.address);

      //Darrr permiso para que el contrato pueda 'mover' los tokens
      await ikt.approve(ikntSwap.address, ikt.totalSupply());

      // Transfiero 1 IKT a la direccion
      await ikt.transfer(address, ethers.utils.parseUnits('1'));

      // Guardo 0.1 IKT  en mi balance
      await ikntSwap.addToken(ikt.address, ethers.utils.parseUnits('0.1'), { from: address });

      // 18 % => True
      // 32 % => False
      // Guardo 0.2 Etereums a 40 meses
      await ikntSwap.sendStorage(true, { value: ethers.utils.parseUnits('0.2') });

      expect(true);
    });


  });


});

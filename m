Received: from sender6-pp-e108.zoho.com (sender6-pp-e108.zoho.com [165.173.180.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802774E01EA;
	Thu, 17 Sep 2026 19:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789673101; cv=pass; b=BFnDvLDL2VnW1JfPsZSyhCkl76rhZbG/BzDR+pFcuYInzAoKafxWMFcDJvUVs/giExJdEI2/cBv1RBPYoZXyLkwgrGYnBOYih/iXMQz8MAE1d8umS/JNmJcVcRjtXpnQ+pTBaHcQ2jLybCE6ejftv222PO11kSszKB4Sl6VyUWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789673101; c=relaxed/simple;
	bh=COsDXbO5lefNcjkUhG4y3yCJCLWRW+MV3gXfiAf77Pw=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=ZV7ZOIP3L7jR0R9ByXcVPkyDaKM2rnLFZeeOULSAJQpnJIMMQh2DsieTROrbvQbJmTxNsVlkcZShBLdmwICmpPDHfKXQeJorO2a8xwuuk+kUjewFoaskUG2KL8SRyuUWShrntogZrCjf8DHdZHdhPurRv07nn+FMA/tDTDPiAKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=HZP0o2oa; arc=pass smtp.client-ip=165.173.180.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="HZP0o2oa"
ARC-Seal: i=1; a=rsa-sha256; t=1789673065; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=a+H2TUv6KGTupS01TJRTbOa9KsZn2hZnKy6iSfl9IOj4t2RRna/U6mRT/lu/Cw+wGLTFdtNY78+8Ui8pbvC8sRkvaVPgpa8CsEv6nuBAg32qpCjJHGAS6OmNQpL11hSa9JDAqoIUWVaso55rxDd0qu7u1b2Qssp1YXdottwAlkU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1789673065; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=MSbqFIHcLQgtkbnj5wdgFLRbGkShnBM0tZoy+L4TD/o=; 
	b=mYRZ62HVGCGp8vBjM+4VobabH9xVxE1bEfFZq+CngkVMwMLNRvlasRD7oRdGjH/FXfx1iVE/QfUbWJqBORO3nkA0m/EIg9J8O7Qj5IbtlCS5ojKGqL7J5d3AKiDoPgQJhyQVuqisVVK3EgBjz1cOM6o1dz4vfXbEPw0yMcEoqaQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789673065;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:In-Reply-To:Content-Type:Content-Transfer-Encoding:Date:Date:MIME-Version:Message-Id:Reply-To;
	bh=MSbqFIHcLQgtkbnj5wdgFLRbGkShnBM0tZoy+L4TD/o=;
	b=HZP0o2oaAM7av9lRahI0Xi/+0qW9jKcbD+NM11SSb4iaewTLetMnBoCxDlSVKXmL
	B8VZauCYUzxsGfFIKBbZQ693/JJeiMwRIj0qHM/3uXJmKlbMszLeHwpZjVQ8q5oepBK
	q56s739zBOz9QsFh5i71fZTrP7skCZZ9KaYyb+B1E2YbUn0eCGDo+RefFeDWNXcl0Kx
	mx8+pZk+UIVKEoFQ4+edM+u3hteM1xauUnAliiMJif5++BF6lzSgsXJQ0ZpMnKaP+CP
	3i/aN9AdHRqE9kvjkmE8LBoQkld7cHZQ7Bd607dRpNZqX+3Bkf/jcIynoFvkwxjxcIn
	o6ZHS6sFJA==
Received: by smtp.zohomail.com with SMTPS id 1789673064794197.91866481875297;
	Thu, 17 Sep 2026 12:24:24 -0700 (PDT)
Message-ID: <975d235815ab28424260bf8ea7a661ebdd017e58.camel@rong.moe>
Subject: Re: [PATCH v3] PCI: rcar-gen4: Limit Max_Read_Request_Size and
 Max_Payload_Size to 256 Bytes
From: Rong Zhang <i@rong.moe>
To: Marek Vasut <marek.vasut@mailbox.org>, Bjorn Helgaas
 <helgaas@kernel.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-pci@vger.kernel.org, 
	stable@vger.kernel.org, Krzysztof =?gb2312?Q?Wilczy=A8=BDski?=	
 <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Koichiro Den <den@valinux.co.jp>,
 Lorenzo Pieralisi	 <lpieralisi@kernel.org>, Magnus Damm
 <magnus.damm@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>, Rob
 Herring <robh@kernel.org>, Yoshihiro Shimoda	
 <yoshihiro.shimoda.uh@renesas.com>, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, Huacai Chen <chenhuacai@loongson.cn>, 
 Richard Zhu <hongxing.zhu@nxp.com>
In-Reply-To: <f62d0ac12ba51c29a9bcf33305f3363c99dc1a96.camel@rong.moe>
References: <20260903202706.GA2234456@bhelgaas>
		 <41f323cbed2da4fa3913dfd62b5595bc3d5228da.camel@rong.moe>
		 <9f0d8887-9332-4919-bee9-c165361e2ea3@mailbox.org>
		 <f66d7e55bb388c550e70fc425f1b911e40e0d578.camel@rong.moe>
		 <e563766f-359e-4133-9960-1b691bc0c774@mailbox.org>
	 <f62d0ac12ba51c29a9bcf33305f3363c99dc1a96.camel@rong.moe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 03:19:17 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2-10+b1 
X-ZohoMailClient: External

Hi Marek,

On Thu, 2026-09-10 at 00:03 +0800, Rong Zhang wrote:
> Hi Marek,
>=20
> On Wed, 2026-09-09 at 04:34 +0200, Marek Vasut wrote:
> > On 9/6/26 7:07 PM, Rong Zhang wrote:
> >=20
> > Hello Rong,
> >=20
> > I apologize for my delayed reply.
> >=20
> > > > > If you need more information I can do some more experiments with =
the PCIe
> > > > > switch card.
> > > >=20
> > > > Please look at the commit message [1] , that lists the exact test a=
nd
> > > > the PCIe NVMe SSD which triggers the data corruption (let me know i=
f
> > > > something is unclear). I think any PCIe NVMe SSD which is non-HMB w=
ith
> > > > MRRS on the SSD size that is > MRRS on the controller side will tri=
gger
> > > > this issue too.
> > > >=20
> > >=20
> > > Unfortunately I don't have any non-HMB NVMe SSD, and it's unlikely I'=
ll
> > > get one anytime soon due to the crazy price. Before the AI supply cha=
in
> > > crisis, I bought several NVMe SSDs, but I chose HMB ones as they gene=
rate
> > > less heat and consume less electricity.
> >=20
> > Maybe this could be reproduced even with another PCIe device with=20
> > MRRS=3D512 or more, which posts MRd to the PCIe controller with MRRS=3D=
128=20
> > or 256. The AHCI controller might be capable of that. I only have the=
=20
> > SSD as a reproducer, but there could easily be more.
> >=20
> > > > If you could reproduce it on the Loongson, then yes, it
> > > > is affected. You might have to disable the current MRRS workaround =
in
> > > > the Loongson PCIe driver though as it might hide the issue.
> > >=20
> > > Due to the lack of non-HMB NVMe SSDs, I can't reproduce the exact sam=
e
> > > issue. Theoretically I may try to mess around with the AHCI controlle=
r
> > > (see the mentioned commit below) by manually overriding MRRS, as my
> > > device's firmware already clamps it. We will see...
> >=20
> > Does the AHCI controller have MRRS higher than the PCIe controller ?
>=20
> Oh, I meant "a" controller, not "the" controller. Sorry for the typo.
>=20
> I don't have the exact same controller as the report, but I do have a
> quite modern one. It's from an AMD Promontory 21 chipset add-in card, see
> https://oshwhub.com/wesd/b650
>=20
> I haven't done any MRRS experiment yet. I will find some time this week
> or the next. As I've said, you don't need to wait for my result :-)

I found some time to do the experiment and successfully reproduced the
MRRS issue.

PCI topology:

   -[0000:00]-+-00.0  Loongson Technology LLC 7A1000 Chipset Hyper Transpor=
t Bridge Controller
              +-00.1  Loongson Technology LLC 7A2000 Chipset Hyper Transpor=
t Bridge Controller
              +-03.0  Loongson Technology LLC 2K1000/2000 / 7A1000 Chipset =
Gigabit Ethernet Controller
              +-04.0  Loongson Technology LLC 2K1000 / 7A1000/2000 Chipset =
USB OHCI Controller
              +-04.1  Loongson Technology LLC 2K1000 / 7A1000/2000 Chipset =
USB EHCI Controller
              +-05.0  Loongson Technology LLC 2K1000 / 7A1000/2000 Chipset =
USB OHCI Controller
              +-05.1  Loongson Technology LLC 2K1000 / 7A1000/2000 Chipset =
USB EHCI Controller
              +-06.0  Loongson Technology LLC 7A1000 Chipset Vivante GC1000=
 GPU
              +-06.1  Loongson Technology LLC 2K1000 / 7A1000 Chipset Displ=
ay Controller
              +-07.0  Loongson Technology LLC 2K1000/2000/3000 / 3B6000M / =
7A1000/2000 Chipset HD Audio Controller
              +-08.0  Loongson Technology LLC 2K1000 / 7A1000 Chipset 3Gb/s=
 SATA AHCI Controller
              +-08.1  Loongson Technology LLC 2K1000 / 7A1000 Chipset 3Gb/s=
 SATA AHCI Controller
              +-08.2  Loongson Technology LLC 2K1000 / 7A1000 Chipset 3Gb/s=
 SATA AHCI Controller
              +-0a.0-[01]----00.0  Etron Technology, Inc. EJ188/EJ198 USB 3=
.0 Host Controller
              +-0f.0-[02-07]----00.0-[03-07]--+-00.0-[04]----00.0  MEDIATEK=
 Corp. MT7925 802.11be 160MHz 2x2 PCIe Wireless Network Adapter [Filogic 36=
0]
              |                               +-08.0-[05]----00.0  Shenzhen=
 Longsys Electronics Co., Ltd. FORESEE XP1000 / Lexar Professional CFexpres=
s Type B Gold series, NM620 PCIe NVME SSD (DRAM-less)
              |                               +-0c.0-[06]----00.0  Advanced=
 Micro Devices, Inc. [AMD] 600 Series Chipset USB 3.2 Controller
              |                               \-0d.0-[07]----00.0  Advanced=
 Micro Devices, Inc. [AMD] 600 Series Chipset SATA Controller
              \-16.0  Loongson Technology LLC 7A1000 Chipset SPI Controller
  =20
   00:00.0 Host bridge [0600]: Loongson Technology LLC 7A1000 Chipset Hyper=
 Transport Bridge Controller [0014:7a00]
   00:00.1 Non-VGA unclassified device [0000]: Loongson Technology LLC 7A20=
00 Chipset Hyper Transport Bridge Controller [0014:7a10]
   00:03.0 Ethernet controller [0200]: Loongson Technology LLC 2K1000/2000 =
/ 7A1000 Chipset Gigabit Ethernet Controller [0014:7a03]
   00:04.0 USB controller [0c03]: Loongson Technology LLC 2K1000 / 7A1000/2=
000 Chipset USB OHCI Controller [0014:7a24]
   00:04.1 USB controller [0c03]: Loongson Technology LLC 2K1000 / 7A1000/2=
000 Chipset USB EHCI Controller [0014:7a14]
   00:05.0 USB controller [0c03]: Loongson Technology LLC 2K1000 / 7A1000/2=
000 Chipset USB OHCI Controller [0014:7a24]
   00:05.1 USB controller [0c03]: Loongson Technology LLC 2K1000 / 7A1000/2=
000 Chipset USB EHCI Controller [0014:7a14]
   00:06.0 Multimedia video controller [0400]: Loongson Technology LLC 7A10=
00 Chipset Vivante GC1000 GPU [0014:7a15]
   00:06.1 VGA compatible controller [0300]: Loongson Technology LLC 2K1000=
 / 7A1000 Chipset Display Controller [0014:7a06]
   00:07.0 Audio device [0403]: Loongson Technology LLC 2K1000/2000/3000 / =
3B6000M / 7A1000/2000 Chipset HD Audio Controller [0014:7a07]
   00:08.0 SATA controller [0106]: Loongson Technology LLC 2K1000 / 7A1000 =
Chipset 3Gb/s SATA AHCI Controller [0014:7a08]
   00:08.1 SATA controller [0106]: Loongson Technology LLC 2K1000 / 7A1000 =
Chipset 3Gb/s SATA AHCI Controller [0014:7a08]
   00:08.2 SATA controller [0106]: Loongson Technology LLC 2K1000 / 7A1000 =
Chipset 3Gb/s SATA AHCI Controller [0014:7a08]
   00:0a.0 PCI bridge [0604]: Loongson Technology LLC 2K1000 / 7A1000 Chips=
et PCIe x1 Bridge [0014:7a09] (rev 01)
   00:0f.0 PCI bridge [0604]: Loongson Technology LLC 7A1000 Chipset PCIe x=
8 Bridge [0014:7a29] (rev 01)
   00:16.0 System peripheral [0880]: Loongson Technology LLC 7A1000 Chipset=
 SPI Controller [0014:7a0b]
   01:00.0 USB controller [0c03]: Etron Technology, Inc. EJ188/EJ198 USB 3.=
0 Host Controller [1b6f:7052]
   02:00.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] 600 Series=
 Chipset PCIe Switch Upstream Port [1022:43f4] (rev 01)
   03:00.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] 600 Series=
 Chipset PCIe Switch Downstream Port [1022:43f5] (rev 01)
   03:08.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] 600 Series=
 Chipset PCIe Switch Downstream Port [1022:43f5] (rev 01)
   03:0c.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] 600 Series=
 Chipset PCIe Switch Downstream Port [1022:43f5] (rev 01)
   03:0d.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] 600 Series=
 Chipset PCIe Switch Downstream Port [1022:43f5] (rev 01)
   04:00.0 Network controller [0280]: MEDIATEK Corp. MT7925 802.11be 160MHz=
 2x2 PCIe Wireless Network Adapter [Filogic 360] [14c3:7925]
   05:00.0 Non-Volatile memory controller [0108]: Shenzhen Longsys Electron=
ics Co., Ltd. FORESEE XP1000 / Lexar Professional CFexpress Type B Gold ser=
ies, NM620 PCIe NVME SSD (DRAM-less) [1d97:5216] (rev 01)
   06:00.0 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] 600 Se=
ries Chipset USB 3.2 Controller [1022:43f7] (rev 01)
   07:00.0 SATA controller [0106]: Advanced Micro Devices, Inc. [AMD] 600 S=
eries Chipset SATA Controller [1022:43f6] (rev 01)

Instead of messing around with the AHCI controller, I decided to do the
experiment with the xHCI controller (0000:06:00.0) by connecting a USB
3.0 hub with a RTL8153 USB 3.0 to GbE controller. xHCI controllers do
DMA, so they can be used to reproduce the issue easily, without the need
of sacrificing the data of a hard drive.

With the quirk applied, everything worked fine.

I built a kernel image with the quirk removed, manually overrode MRRS to
512B, rebound the driver, and plugged the USB 3.0 hub to the xHCI
controller.

   [  580.527181] xhci_hcd 0000:06:00.0: USB bus 7 deregistered
   [  583.675928] xhci_hcd 0000:06:00.0: xHCI Host Controller
   [  583.689993] xhci_hcd 0000:06:00.0: new USB bus registered, assigned b=
us number 7
   [  583.774300] xhci_hcd 0000:06:00.0: hcc params 0x0200ef81 hci version =
0x110 quirks 0x0000000200000010
   [  583.795399] xhci_hcd 0000:06:00.0: xHCI Host Controller
   [  583.795980] xhci_hcd 0000:06:00.0: new USB bus registered, assigned b=
us number 8
   [  583.810550] xhci_hcd 0000:06:00.0: Host supports USB 3.2 Enhanced Sup=
erSpeed
   [  583.826573] usb usb7: New USB device found, idVendor=3D1d6b, idProduc=
t=3D0002, bcdDevice=3D 7.01
   [  583.842936] usb usb7: New USB device strings: Mfr=3D3, Product=3D2, S=
erialNumber=3D1
   [  583.856206] usb usb7: Product: xHCI Host Controller
   [  583.868244] usb usb7: Manufacturer: Linux 7.1.9-cip-main+ xhci-hcd
   [  583.880346] usb usb7: SerialNumber: 0000:06:00.0
   [  583.899451] hub 7-0:1.0: USB hub found
   [  583.900066] hub 7-0:1.0: 12 ports detected
   [  583.924683] usb usb8: We don't know the algorithms for LPM for this h=
ost, disabling LPM.
   [  583.925753] usb usb8: New USB device found, idVendor=3D1d6b, idProduc=
t=3D0003, bcdDevice=3D 7.01
   [  583.946605] usb usb8: New USB device strings: Mfr=3D3, Product=3D2, S=
erialNumber=3D1
   [  583.965879] usb usb8: Product: xHCI Host Controller
   [  583.979156] usb usb8: Manufacturer: Linux 7.1.9-cip-main+ xhci-hcd
   [  583.995799] usb usb8: SerialNumber: 0000:06:00.0
   [  584.025088] hub 8-0:1.0: USB hub found
   [  584.026026] hub 8-0:1.0: 5 ports detected
   [  584.249890] usb 7-1: new high-speed USB device number 2 using xhci_hc=
d
   [  584.452592] usb 7-1: New USB device found, idVendor=3D2109, idProduct=
=3D2817, bcdDevice=3D 2.14
   [  584.452743] usb 7-1: New USB device strings: Mfr=3D1, Product=3D2, Se=
rialNumber=3D0
   [  584.452852] usb 7-1: Product: USB2.0 Hub
   [  584.470092] usb 7-1: Manufacturer: VIA Labs, Inc.
   [  584.495186] hub 7-1:1.0: USB hub found
   [  584.495833] hub 7-1:1.0: 4 ports detected
   [  584.556958] usb 8-1: Device not responding to setup address.
   [  584.774875] usb 8-1: new SuperSpeed USB device number 2 using xhci_hc=
d
   [  584.821162] usb 8-1: New USB device found, idVendor=3D2109, idProduct=
=3D0817, bcdDevice=3D 2.14
   [  584.821531] usb 8-1: New USB device strings: Mfr=3D1, Product=3D2, Se=
rialNumber=3D0
   [  584.839861] usb 8-1: Product: USB3.0 Hub
   [  584.853146] usb 8-1: Manufacturer: VIA Labs, Inc.
   [  584.884823] hub 8-1:1.0: USB hub found
   [  584.885462] hub 8-1:1.0: 4 ports detected
   [  585.431958] usb 8-1.3: new SuperSpeed USB device number 3 using xhci_=
hcd
   [  585.466401] usb 8-1.3: Int endpoint with wBytesPerInterval of 8 in co=
nfig 2 interface 0 altsetting 0 ep 0x83: setting to 16
   [  585.466636] usb 8-1.3: New USB device found, idVendor=3D0bda, idProdu=
ct=3D8153, bcdDevice=3D30.00
   [  585.482682] usb 8-1.3: New USB device strings: Mfr=3D1, Product=3D2, =
SerialNumber=3D6
   [  585.495865] usb 8-1.3: Product: USB 10/100/1000 LAN
   [  585.505992] usb 8-1.3: Manufacturer: Realtek
   [  585.514688] usb 8-1.3: SerialNumber: 000001
   [  585.621409] r8152-cfgselector 8-1.3: reset SuperSpeed USB device numb=
er 3 using xhci_hcd
   [  591.076733] r8152-cfgselector 8-1.3: Failed to write 512 bytes at 0xf=
800/0x01ff (-145)
   [  591.077414] r8152 8-1.3:1.0: Write PLA fw fail
   [  593.273770] r8152-cfgselector 8-1.3: reset SuperSpeed USB device numb=
er 3 using xhci_hcd
   [  598.570636] r8152-cfgselector 8-1.3: device descriptor read/8, error =
-145
   [  598.685870] r8152-cfgselector 8-1.3: reset SuperSpeed USB device numb=
er 3 using xhci_hcd
   [  615.108738] r8152-cfgselector 8-1.3: device descriptor read/8, error =
-145
   [  616.256190] usb 8-1-port3: cannot disable (err =3D -145)
   [  621.920265] hub 8-1:1.0: hub_ext_port_status failed (err =3D -145)
   [  623.047210] usb 8-1-port3: cannot reset (err =3D -145)
   [  624.169283] usb 8-1-port3: cannot reset (err =3D -145)
   [  625.294280] usb 8-1-port3: cannot reset (err =3D -145)
   [  626.419281] usb 8-1-port3: cannot reset (err =3D -145)
   [  627.544617] usb 8-1-port3: cannot reset (err =3D -145)
   [  627.544706] usb 8-1-port3: Cannot enable. Maybe the USB cable is bad?

Oops, the driver "Failed to write 512 bytes" to the RTL8153, and failed
to load the firmware.

I am not an expert in xHCI. IIUC, sending an OUT URB usually needs these
steps:

1. write data to the DMA buffer
2. prepare a TRB
3. write the TRB to the xHCI controller's TRB ring
4. ring the doorbell
5. the xHCI controller reads the data via DMA
6. the xHCI controller delivers the data to the device

The MRRS issue corrupted the data in the fifth step, causing the failures
on firmware loading. The subsequent port reset failures also seemed to be
triggered in the same way. On the other hand, device enumeration itself
succeeded, because IN URBs are delivered to the host via write DMA.=20

After that, I unplugged the USB 3.0 hub, manually overrode MRRS to 256B
without rebinding the driver, and replug the hub to the xHCI controller.

   [  741.219489] usb 8-1: USB disconnect, device number 2
   [  741.220582] r8152-cfgselector 8-1.3: USB disconnect, device number 3
   [  741.334226] usb 7-1: USB disconnect, device number 2
   [  772.657795] usb 7-1: new high-speed USB device number 3 using xhci_hc=
d
   [  772.880341] usb 7-1: New USB device found, idVendor=3D2109, idProduct=
=3D2817, bcdDevice=3D 2.14
   [  772.880539] usb 7-1: New USB device strings: Mfr=3D1, Product=3D2, Se=
rialNumber=3D0
   [  772.892671] usb 7-1: Product: USB2.0 Hub
   [  772.898715] usb 7-1: Manufacturer: VIA Labs, Inc.
   [  772.922778] hub 7-1:1.0: USB hub found
   [  772.923476] hub 7-1:1.0: 4 ports detected
   [  772.976982] usb 8-1: Device not responding to setup address.
   [  773.197271] usb 8-1: new SuperSpeed USB device number 4 using xhci_hc=
d
   [  773.241771] usb 8-1: New USB device found, idVendor=3D2109, idProduct=
=3D0817, bcdDevice=3D 2.14
   [  773.243041] usb 8-1: New USB device strings: Mfr=3D1, Product=3D2, Se=
rialNumber=3D0
   [  773.256269] usb 8-1: Product: USB3.0 Hub
   [  773.265074] usb 8-1: Manufacturer: VIA Labs, Inc.
   [  773.289073] hub 8-1:1.0: USB hub found
   [  773.289735] hub 8-1:1.0: 4 ports detected
   [  773.831471] usb 8-1.3: new SuperSpeed USB device number 5 using xhci_=
hcd
   [  773.863051] usb 8-1.3: Int endpoint with wBytesPerInterval of 8 in co=
nfig 2 interface 0 altsetting 0 ep 0x83: setting to 16
   [  773.863288] usb 8-1.3: New USB device found, idVendor=3D0bda, idProdu=
ct=3D8153, bcdDevice=3D30.00
   [  773.880071] usb 8-1.3: New USB device strings: Mfr=3D1, Product=3D2, =
SerialNumber=3D6
   [  773.892286] usb 8-1.3: Product: USB 10/100/1000 LAN
   [  773.902420] usb 8-1.3: Manufacturer: Realtek
   [  773.911120] usb 8-1.3: SerialNumber: 000001
   [  774.011156] r8152-cfgselector 8-1.3: reset SuperSpeed USB device numb=
er 5 using xhci_hcd
   [  774.380507] r8152 8-1.3:1.0 enp6s0u1u3: renamed from eth0
   [  777.496526] r8152 8-1.3:1.0 enp6s0u1u3: carrier on

Yay! Everything returned to normal.

>=20
> >=20
> > > The firmware of many Loongson devices (except for some MIPS-based one=
s,
> > > see the commit message of commit ef61a0405742 ("PCI: loongson: Limit =
MRRS
> > > to 256")) already clamps MRRS for most PCIe devices, which has proven
> > > that the 7A1000/7A2000 chipset does need the MRRS quirk.
> >=20
> > This still only applies the MRRS limit to the PCIe controller, not to=
=20
> > all devices on the bus, correct ?
>=20
> This applies to all devices that are the downstream (direct or behind
> another bridge) of any root ports (i.e., internal bridges). In detail,
> pci_match_id(loongson_internal_bridge_devids, *bridge*) matches the root
> port but pcie_set_readrq(*pdev*, 256) sets the downstream PCIe device.
>=20
> This essentially sets all PCIe devices on the bus (unless firmware has
> selected a smaller MRRS), since any other internal endpoints of the
> chipset have no PCIe capability (i.e., they are legacy PCI or HT
> devices). IOW, only the root ports (i.e.,
> loongson_internal_bridge_devids) and their downstream PCIe devices have
> MRRS, and they are covered by loongson_set_min_mrrs_quirk().

In conclusion, the experiment matched with what you've occurred on the R-
Car Gen4 PCIe controller, and proved that the quirk needs to be applied
to every PCIe device [1] on the bus.

[1]: As I've said in the previous reply, the chipset's only PCIe devices
are its PCIe root ports (so-called "internal bridges"), i.e.,
0000:00:0a.0 and 0000:00:0f.0.

Thanks,
Rong

>=20
> >=20
> > I would like to find out whether all the devices (not only the=20
> > controller) on the PCIe bus on Loongson must have MRRS limited or not.
> > -> If yes, then I should start preparing core patches
> > -> If no, then this quirk might specific to this controller
>=20
> My answer is yes.
>=20
> >=20
> > > Therefore, you
> > > can just go ahead with preparing the core patches without the need of
> > > waiting for my test result. It seems that your approach is not going =
to
> > > change the current fixup effects in a significant way, so it should b=
e
> > > fine.
> >=20
> > [...]
> >=20
> > Thank you for your help !
>=20
> Thanks,
> Rong

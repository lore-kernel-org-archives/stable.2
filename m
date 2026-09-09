Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DDA57F725;
	Wed,  9 Sep 2026 16:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788970165; cv=pass; b=sFwxKkRqKz6nGg4RSbvzNE4AWK+jxp7753H8cW/LoE63soJyZIHTEaSVu6owe5BrXkxtlIJdT63rEXupjOBHdczDjWiiAZTb9/DxKNOqYRWXohqBIJBAIIB1tTGGeh8ve+8LW7RO8c4Ce2rzSDCzxn8JBbCfEBBD+7Qe+XTJ3DY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788970165; c=relaxed/simple;
	bh=tOK6V83U7ctJDujtL27OtlLg4IBqs7pHG2c7SK8LIr4=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=L6KQr5v3RS+qfBcIP6i5VRLUMkP3lehpuKCwK2dQcrJmtgwmatEl9fBCXQXcrbd+JqN7KT2GYsI2Mv++/xo/WRuYgo9neebSFx5TTvWOtPU8Uf+xZ7kThOPFub2anyBWxlA0GXWzYR+tRo6QvQjVbOlkQnG8BtV+5IBdYSgzui0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=WoYQAnWY; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="WoYQAnWY"
ARC-Seal: i=1; a=rsa-sha256; t=1788970121; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=KJhr14BZFjEIh92U3YJK1CLq4tNvcQKvAhd8OzooercMW1ET4xnigMt4xld8IVCK6eF99wTkYdhxAznprH5zFSK1izZTab09T8hPzjusoRyOpjNzh68/Gkk6Bj0acP1PFelxgYtuO/h7nUcM+GpAhz2DMJaV3KNaruyE+Istl5Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1788970121; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=tOK6V83U7ctJDujtL27OtlLg4IBqs7pHG2c7SK8LIr4=; 
	b=edhdy6sJYhpLSAMVp5SBpKcppMD0ohQ7Ed7NzyYNdIgpflP1MO6Nr4M+3n45pOkR2EpvLJLI3G0MqWW+8GQAZf9Z1SxWg9kEyWxIIscZaXzu0ID2PVfwsIUtukVzy4DzjeAQtldUUg0HTPc+LXoKsG/kfWeWzzRNu1jXrYqBkAE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788970121;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:In-Reply-To:Content-Type:Content-Transfer-Encoding:Date:Date:MIME-Version:Message-Id:Reply-To;
	bh=tOK6V83U7ctJDujtL27OtlLg4IBqs7pHG2c7SK8LIr4=;
	b=WoYQAnWYUQ5UR32HgB+DwQ3d5aBpBwkj/CiDb7pJZdIMsYnM3GRNWLCcckdpEXRL
	5Mik73lEsmA+lmeVDjdfsijeVUow8tU8nL4znFia0tvN5Wt+z6n0oI1eD0IgjPL5JTf
	j0mID+I/zokol19s1rVp83NEMKW0jjBxVj0jwYbzjl8Qz/Fg9OP0vCbOrfa2b3VUz7O
	YYPQFfw4vwS9l9+WBEcwaHCq4ilYF1whZMPSFQblkbFvheTJwTw+abhkT2nMnl+2hh6
	RRgBaQpRMJDeQb17Vu1gbmUUoC6f06Q/qgdz9Jl6tfDoVTBN8hsnGXjn2OZNpe9Aesf
	LqgjZEKztA==
Received: by mx.zohomail.com with SMTPS id 1788970118815714.682859229956;
	Wed, 9 Sep 2026 09:08:38 -0700 (PDT)
Message-ID: <f62d0ac12ba51c29a9bcf33305f3363c99dc1a96.camel@rong.moe>
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
	linux-renesas-soc@vger.kernel.org, Ziyao Li <liziyao@uniontech.com>, Huacai
 Chen	 <chenhuacai@loongson.cn>, Richard Zhu <hongxing.zhu@nxp.com>
In-Reply-To: <e563766f-359e-4133-9960-1b691bc0c774@mailbox.org>
References: <20260903202706.GA2234456@bhelgaas>
	 <41f323cbed2da4fa3913dfd62b5595bc3d5228da.camel@rong.moe>
	 <9f0d8887-9332-4919-bee9-c165361e2ea3@mailbox.org>
	 <f66d7e55bb388c550e70fc425f1b911e40e0d578.camel@rong.moe>
	 <e563766f-359e-4133-9960-1b691bc0c774@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 00:03:30 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2-10+b1 
X-ZohoMailClient: External

Hi Marek,

On Wed, 2026-09-09 at 04:34 +0200, Marek Vasut wrote:
> On 9/6/26 7:07 PM, Rong Zhang wrote:
>=20
> Hello Rong,
>=20
> I apologize for my delayed reply.
>=20
> > > > If you need more information I can do some more experiments with th=
e PCIe
> > > > switch card.
> > >=20
> > > Please look at the commit message [1] , that lists the exact test and
> > > the PCIe NVMe SSD which triggers the data corruption (let me know if
> > > something is unclear). I think any PCIe NVMe SSD which is non-HMB wit=
h
> > > MRRS on the SSD size that is > MRRS on the controller side will trigg=
er
> > > this issue too.
> > >=20
> >=20
> > Unfortunately I don't have any non-HMB NVMe SSD, and it's unlikely I'll
> > get one anytime soon due to the crazy price. Before the AI supply chain
> > crisis, I bought several NVMe SSDs, but I chose HMB ones as they genera=
te
> > less heat and consume less electricity.
>=20
> Maybe this could be reproduced even with another PCIe device with=20
> MRRS=3D512 or more, which posts MRd to the PCIe controller with MRRS=3D12=
8=20
> or 256. The AHCI controller might be capable of that. I only have the=20
> SSD as a reproducer, but there could easily be more.
>=20
> > > If you could reproduce it on the Loongson, then yes, it
> > > is affected. You might have to disable the current MRRS workaround in
> > > the Loongson PCIe driver though as it might hide the issue.
> >=20
> > Due to the lack of non-HMB NVMe SSDs, I can't reproduce the exact same
> > issue. Theoretically I may try to mess around with the AHCI controller
> > (see the mentioned commit below) by manually overriding MRRS, as my
> > device's firmware already clamps it. We will see...
>=20
> Does the AHCI controller have MRRS higher than the PCIe controller ?

Oh, I meant "a" controller, not "the" controller. Sorry for the typo.

I don't have the exact same controller as the report, but I do have a
quite modern one. It's from an AMD Promontory 21 chipset add-in card, see
https://oshwhub.com/wesd/b650

I haven't done any MRRS experiment yet. I will find some time this week
or the next. As I've said, you don't need to wait for my result :-)

>=20
> > The firmware of many Loongson devices (except for some MIPS-based ones,
> > see the commit message of commit ef61a0405742 ("PCI: loongson: Limit MR=
RS
> > to 256")) already clamps MRRS for most PCIe devices, which has proven
> > that the 7A1000/7A2000 chipset does need the MRRS quirk.
>=20
> This still only applies the MRRS limit to the PCIe controller, not to=20
> all devices on the bus, correct ?

This applies to all devices that are the downstream (direct or behind
another bridge) of any root ports (i.e., internal bridges). In detail,
pci_match_id(loongson_internal_bridge_devids, *bridge*) matches the root
port but pcie_set_readrq(*pdev*, 256) sets the downstream PCIe device.

This essentially sets all PCIe devices on the bus (unless firmware has
selected a smaller MRRS), since any other internal endpoints of the
chipset have no PCIe capability (i.e., they are legacy PCI or HT
devices). IOW, only the root ports (i.e.,
loongson_internal_bridge_devids) and their downstream PCIe devices have
MRRS, and they are covered by loongson_set_min_mrrs_quirk().

>=20
> I would like to find out whether all the devices (not only the=20
> controller) on the PCIe bus on Loongson must have MRRS limited or not.
> -> If yes, then I should start preparing core patches
> -> If no, then this quirk might specific to this controller

My answer is yes.

>=20
> > Therefore, you
> > can just go ahead with preparing the core patches without the need of
> > waiting for my test result. It seems that your approach is not going to
> > change the current fixup effects in a significant way, so it should be
> > fine.
>=20
> [...]
>=20
> Thank you for your help !

Thanks,
Rong

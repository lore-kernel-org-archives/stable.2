Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DF637F8B6;
	Fri,  4 Sep 2026 17:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788544111; cv=pass; b=o8X068VwMIb//qOWeG9bc4cvjQPR4a8nNFQDhFmQayKIZN0mV8qEKxZwfQqJEEhAif/GNd5GU+hCSICirBegg0Mw2L7ycvHRb7xo8UFFsZbvrqgyImfm4JXUE3FcYbxgyur7XUxFWzrXpsmBYOP34nWEeYneVlBODcdlQ6GIRWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788544111; c=relaxed/simple;
	bh=HYklYISxwUoTnCsdMrPvx9XtzPgtJCXKx1frW+Bj1eM=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=Gcbi9WSz/uatHor9Fwzg2A7oKU2vkBl0olPXR6gQQhNpb3jkyeGZvOwwXKqWc0kad7gK6iqX1r5cXEHvQ7TzDr0ye6yUwpeuC0ogFSYgcJoZPbLWQhwbAy2cC9r4upft+aDq08r+t1J03Owwl4p5PMhtewYuULsTwsQZ8LEHFm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=gKK6IMsO; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="gKK6IMsO"
ARC-Seal: i=1; a=rsa-sha256; t=1788544073; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Nj9FK/0gXWu1nGPERRtz+MousLsB3WAydGZ4dl8RVelIXTsvZbXJxD6mXLuLkBDGpAKtVR1ggjnrW2Hz/0iQ57RRW2hu87JR58wvf+wfZXTnJYuH4ieDaRGSRThjey+ELHaVnZwttBh2BivkrpliaeA6cAnLOkDc4vjV5oyYYmY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1788544073; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=1S8GwIHC1p7xRqe/7PlUpgpZUjKKXHgsXPpFaor8ZJs=; 
	b=Ag1VuhkrITezWBrC/qwMPdRMsk2RyUJFxjsWqcObPTQADXPbQ28KKoztk+HYf96iUqCqoFjpO8aqK0HiiKrKIHnaVxquyPUcaoxs1jPIKbo7f7LJX5Bb2uVEHmEKdU2vdeYsh04KWO1IVxjBUCz+6yRXtT/RRDRxu56NR7h4yuA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788544073;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:In-Reply-To:Content-Type:Content-Transfer-Encoding:Date:Date:MIME-Version:Message-Id:Reply-To;
	bh=1S8GwIHC1p7xRqe/7PlUpgpZUjKKXHgsXPpFaor8ZJs=;
	b=gKK6IMsOBfnBLf6NOnTnVtu5Cbkkzw7oIZDC/409XNhcr8iT0cUZnot2Zu+SrFjb
	ThwjCtILZgAfGuD+HleBv53l/CsR/kT1GSBNI2tU5mHpy5bmnfYr6nkH4CWA0XD/wiv
	ipVBqgc9+q/VHSbk6XbOVCBCdcGgi68aJr3LzJyZTh9uY5zw2SpxgE7VUWyBCh6k2zz
	tOuQomreFcXjR6up2tJBlTbbxqZYpybi7/0SAWjZWmLYuSbKPhvqS6mHelG59SJCPPK
	7Qz883YVtFHQ8QXe5l43Xtcy25p5GRG7NG6DyEFEwF6kUZpCG1R84GpQi37TVK7KGCn
	7ZUAlkhmig==
Received: by mx.zohomail.com with SMTPS id 1788544069977527.5411411525034;
	Fri, 4 Sep 2026 10:47:49 -0700 (PDT)
Message-ID: <41f323cbed2da4fa3913dfd62b5595bc3d5228da.camel@rong.moe>
Subject: Re: [PATCH v3] PCI: rcar-gen4: Limit Max_Read_Request_Size and
 Max_Payload_Size to 256 Bytes
From: Rong Zhang <i@rong.moe>
To: Bjorn Helgaas <helgaas@kernel.org>, Marek Vasut
 <marek.vasut@mailbox.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-pci@vger.kernel.org, 
	stable@vger.kernel.org, Krzysztof =?gb2312?Q?Wilczy=A8=BDski?=	
 <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Koichiro Den <den@valinux.co.jp>,
 Lorenzo Pieralisi	 <lpieralisi@kernel.org>, Magnus Damm
 <magnus.damm@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>, Rob
 Herring <robh@kernel.org>, Yoshihiro Shimoda	
 <yoshihiro.shimoda.uh@renesas.com>, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, Ziyao Li <liziyao@uniontech.com>, Huacai
 Chen	 <chenhuacai@loongson.cn>
In-Reply-To: <20260903202706.GA2234456@bhelgaas>
References: <20260903202706.GA2234456@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 01:42:36 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2-10+b1 
X-ZohoMailClient: External

Hi Bjorn, Marek,

Thanks for reaching me.

On Thu, 2026-09-03 at 15:27 -0500, Bjorn Helgaas wrote:
> On Thu, Sep 03, 2026 at 08:51:06PM +0200, Marek Vasut wrote:
> > Hello Bjorn,
> >=20
> > On 9/3/26 7:32 PM, Bjorn Helgaas wrote:
> > > [+cc Ziyao, Rong, Huacai for similar Loongson MRRS issue]
> > >=20
> > > On Fri, Aug 21, 2026 at 04:05:51AM +0200, Marek Vasut wrote:
> > > > R-Car Gen4 PCIe controller has a hardware limitation of 256 Bytes
> > > > Max_Payload_Size (MPS). PCIe specification indicates that the MPS
> > > > must not exceed minimum MPS of any element along the packet path.
> > > > Force limit Max_Payload_Size to at most 256 Bytes for each device
> > > > connected to this PCIe controller.
> > >=20
> > > IIUC the PCI core already enforces this limit, and what this patch
> > > does is double-check that this limit is observed with this check,
> > > right?
> >=20
> > That is correct, this was changed in V3, I missed the commit message up=
date,
> > sorry.
> >=20
> > Would you like me to respin the patch one more time with an updated com=
mit
> > message, or would you be willing to fix it up in tree ?
>=20
> I fixed the commit log, no problem.
>=20
> > >    +	WARN_ON(pcie_get_mps(dev) > 256);
> > >=20
> > > More below.
> >=20
> >=20
> > [...]
> >=20
> > > > +	bridge->no_inc_mrrs =3D 1;
> > > > +	if (pcie_get_readrq(dev) > 256) {
> > > > +		pci_info(dev, "Limiting MRRS to 256 bytes\n");
> > > > +		pcie_set_readrq(dev, 256);
> > > > +	}
> > >=20
> > > It would be nice if all the platforms that need no_inc_mrrs could
> > > apply it the same way, but I assume you saw loongson_mrrs_quirk() and
> > > loongson_set_min_mrrs_quirk() in the process of finding no_inc_mrrs,
> > > and chose a different implementation strategy for some reason, e.g.,
> > > this way doesn't have to include device IDs for all the Root Ports?
> >=20
> > The loongson quirk won't work if the PCIe controller driver is built as=
 a
> > module, which the R-Car Gen4 PCIe driver can be, and in fact is often b=
uilt
> > as a module, because it depends on firmware which is loaded from filesy=
stem.
> >=20
> > If the controller driver is built as a module, then
> > DECLARE_PCI_FIXUP_ENABLE() is not applied, the DECLARE_PCI_FIXUP_ENABLE=
() is
> > applied only on boot and therefore only for built-in drivers.
> >=20
> > I got burnt by DECLARE_PCI_FIXUP_ENABLE() in V1 of this patch.
>=20
> Ouch, that does hurt.
>=20
> > However, there is also another part to this -- the
> > rcar_gen4_pcie_enable_device() is called for every device on the bus an=
d
> > applies the MRRS limitation to every device on the bus that is downstre=
am of
> > the controller, not only the controller. This is necessary on this
> > controller variant, else hardware like PCIe SSDs with MRRS higher than =
the
> > controller break.
> >=20
> > > Maybe we should rework no_inc_mrrs in such a way that drivers could
> > > set a max MRRS in the struct pci_host_bridge and make
> > > pcie_write_mrrs() and pcie_set_readrq() pay attention to it?  That
> > > might let us get rid of the FIXUP approach.
> >=20
> > In light of the last paragraph above, that the MRRS has to be limited a=
lso
> > on all devices downstream of this particular controller, I would like t=
o ask
> > -- does the Loongson controller have the same limitation or not ? If no=
t,
> > then I would argue this quirk should be isolated to this controller var=
iant
> > ; else, I am happy to start on the core patches.

ACK. I agreed that it should make our life easier.

>=20
> I don't know if we'll get a real answer for Loongson (there's no
> maintainer listed for it, hint hint :)),=C2=A0
>=20

(+CC Jiaxun)

The driver was introduced by Jiaxun without updating MAINTAINERS. I guess
he'd be willing to be listed as a maintainer.

I don't work for Loongson, but I do maintain several MIPS-based Loongson
devices for the Golang community with my colleagues and personally own a
MIPS-based Loongson-LS3A4000-7A1000-NUC-SE mini PC. I do some PCIe
experiments on it from time to time for fun. So I am OK if someone wants
to list me as a maintainer or reviewer :)

> but my guess is that it does
> apply to all devices downstream of the Loongson controller.

I believe this is the case. Maybe Jiaxun can shed a light on it too.

Just checked the kmsg log from April, the firmware seemed to only clamp
MRRS for devices directly connected to the root ports. IOW, it seemed to
only clamp MRRS for the upstream port of a PCIe switch, so
loongson_set_min_mrrs_quirk() had to fix up downstream ports.

If you need more information I can do some more experiments with the PCIe
switch card.

Thanks,
Rong

>=20
> I think MRRS is mostly interesting for DMA because MMIO from CPUs is
> usually small sizes, far below the 128-byte or larger transfers that
> devices may do.

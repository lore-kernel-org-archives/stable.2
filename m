Received: from mail-10625.protonmail.ch (mail-10625.protonmail.ch [79.135.106.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912E9415B8B;
	Wed, 16 Sep 2026 11:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789557290; cv=none; b=dahbor0MRNOVjvqCav926ZOp9yHjU+z9jOkdKghagdN7avGqDxon4RT+JM00aY0cXOo5JfelV4evFG8eM0TAz+ou/9u3oxNDhyh8UMQHsBz8kTEQCoHVKStZLfiwo9WxQE2p/kX0h7a3tgZOL/pSvRgeVctK74NSTsjv4mu9Jqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789557290; c=relaxed/simple;
	bh=B9YGmUGz7rBZgMbUehF0UJpdMSsCJn/PsR7VtP8b9vo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WMDZ73a4z+7S4IN2k3GsO1zcCvckM1O3Do7ljdCDU52p9ygu81CYtWJprhqj1+pyFJELQB3umyYsZHPuP4xebhkJfwKX0C8jQbpmyNVDVtYCCYS2rejEetM/9728ZHj51FyNVEAzOu5n6hsFQZHNB2jaimHqEd8gxV9F/FufGbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=httpd.dev; spf=pass smtp.mailfrom=httpd.dev; dkim=pass (2048-bit key) header.d=httpd.dev header.i=@httpd.dev header.b=Hd4D/yzk; arc=none smtp.client-ip=79.135.106.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=httpd.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=httpd.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=httpd.dev header.i=@httpd.dev header.b="Hd4D/yzk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=httpd.dev;
	s=protonmail3; t=1789557270; x=1789816470;
	bh=eZUCmvaO7TAIj3qUPGiLJi/TotpZBP9JAzCiVX0/K1w=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Hd4D/yzkl/XA6TfOjLF6IYMYRTt0e7tjxhFP0wlKdsOxWub7hU2gvG49z+GCp88RE
	 7lL6anjk0ikqybKQSCwZ869d/0av5TapJ38G7KapZ81gHZ5SYDHFO8fJa65UDCowzl
	 K/QiazQFaBVMTSPqhUoMtZwWaunPQbhHPqGhslagJJxKujJ97brxBwQKHUlvhnGYGF
	 FmJH1a97izTY4Y6NvcMAEcXrWvvaanaKo3z/vj8QsMpUadl2+l4kSBdHcqDjdQpoVi
	 uItuZyfpMY9IXIb5krsWhObqN+/kj5vZwgi/EEPf+jrAwcJ51jyuzKJVKiZSp94kzK
	 z9eEY26kzk6WQ==
Date: Wed, 16 Sep 2026 11:14:25 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
From: Angel J <iamanaws@httpd.dev>
Cc: Andrea della Porta <andrea.porta@suse.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "regressions@lists.linux.dev" <regressions@lists.linux.dev>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-rpi-kernel@lists.infradead.org" <linux-rpi-kernel@lists.infradead.org>, "robh@kernel.org" <robh@kernel.org>, "florian.fainelli@broadcom.com" <florian.fainelli@broadcom.com>
Subject: Re: [REGRESSION] PCI: Dynamic OF node creation hangs on invalid bridge configuration
Message-ID: <Tav3crct3HpgoRPBGOe-bfkBEORVT1RkvRbP8B7IXhRvEbUTAi-G6RiSnynkgV2rJ1dOIbCxm-mHUcm1e0MyQG52qswzpxURe4KFJoddhGg=@httpd.dev>
In-Reply-To: <20260916012115.GA888380@bhelgaas>
References: <20260916012115.GA888380@bhelgaas>
Feedback-ID: 163474212:user:proton
X-Pm-Message-ID: 094e44f9aa91c588aa9c4e73791ecf48b014b478
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------a9b7216e2949918706075e5a2be417011537498a061203db8d3df343ccefc90b"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------a9b7216e2949918706075e5a2be417011537498a061203db8d3df343ccefc90b
Content-Type: multipart/mixed;boundary=---------------------0c3a1ee94d39a4855b62717ad2d7feb6

-----------------------0c3a1ee94d39a4855b62717ad2d7feb6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

Hi Bjorn, Andrea,

Thanks, that clears it up. I agree the of_property fix is simpler. If a
Type 1 device can legitimately have no bus below it, I don't see a reason
to change its class or header just to avoid that case.

The v2 patch is already in the thread. Is there anything you'd like me
to change?

Thanks,
Angel J



On Tuesday, September 15th, 2026 at 18:21, Bjorn Helgaas <helgaas@kernel.o=
rg> wrote:

> On Mon, Sep 14, 2026 at 11:28:45PM +0000, Angel J wrote:
> > Ok, here it is...
> >
> > I tested this quirk on Linux 6.18.44 with CONFIG_PCI_DYNAMIC_OF_NODES=3D=
y,
> > and it boots without either OF fix. The diff below omits the test logg=
ing.
> >
> > PCI_FIXUP_HEADER runs after the resources have been parsed using the
> > original header type, and changing hdr_type also affects configuration
> > restore. I don't know enough about this part of PCI to judge whether
> > that's safe, so I'll wait for your advice before submitting it as a pa=
tch.
> >
> > Thanks,
> > Angel J
> >
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index de9bbccda..57df88a38 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -291,6 +291,22 @@ static int __init pci_apply_final_quirks(void)
> >  }
> >  fs_initcall_sync(pci_apply_final_quirks);
> >
> >
> > +/*
> > + * On the Dell XPS 8940, 8086:4c43 reports a PCI-to-PCI bridge but ha=
s no
> > + * downstream bus. Use host-bridge class and a normal header so that
> > + * pci_is_bridge() does not send it through bridge scanning.
> > + */
> > +static void quirk_intel_4c43_host_bridge(struct pci_dev *dev)
> > +{
> > +	if ((dev->class >> 8) !=3D PCI_CLASS_BRIDGE_PCI ||
> > +	    dev->hdr_type !=3D PCI_HEADER_TYPE_BRIDGE)
> > +		return;
> > +
> > +	dev->class =3D (PCI_CLASS_BRIDGE_HOST << 8) | (dev->class & 0xff);
> > +	dev->hdr_type =3D PCI_HEADER_TYPE_NORMAL;
> > +}
> > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x4c43, quirk_intel_4c4=
3_host_bridge);
> =


> I think your of_property patch is better because it removes some
> assumptions made in the of_pci_make_dev_node() path about what things
> in the pci_dev are valid.  It's quite legal for a device to have a
> Type 1 header (so pci_is_bridge() is true), but have no pci_bus below
> it, e.g., a bridge on bus 0 with Secondary Bus Number also being 0.
> =


> I don't know what happened in this particular case, whether the
> Secondary Bus Number and Subordinate Bus Numbers are hard-wired to
> 0xff or what (per spec, both should be read/write).  Maybe the system
> "lspci -vv" and/or complete dmesg log would have a clue.
> =


> But I do think it's better if we don't assume that every pci_dev with
> a Type 1 header has a pci_bus allocated.
> =


-----------------------0c3a1ee94d39a4855b62717ad2d7feb6--

--------a9b7216e2949918706075e5a2be417011537498a061203db8d3df343ccefc90b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wrsEARYKAG0FgmqqegMJEBoBbwppzUxnRRQAAAAAABwAIHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmdBTq1b8ZUc+gb/I1AJD8UGLeUtvQia/H5qXzQI
iIboUBYhBEAFf9htFyVnqZzmVhoBbwppzUxnAAA9kAEApIknk8UNcVUwcKBd
Kq3x5KPCfSCe3yyufvbqxlW7dEUA/2crmFQr79DT5ZLDX38FhnGhEcGQHdTQ
3lDfWTugakYI
=CPLW
-----END PGP SIGNATURE-----


--------a9b7216e2949918706075e5a2be417011537498a061203db8d3df343ccefc90b--


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C921250AC27;
	Wed, 16 Sep 2026 14:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789569770; cv=none; b=ZjSWyxKc7X0944oJDdDLtd9ksIEOvZQhMfOs9AQGdd2agHpTLf+MsC0U96C8zv/zV5MC9PiOuJw4hAOrI2876YglVk0rZ2iTnZ/tAbvDdMEYLvmmLnYpGYJtNOEFfjPquFSOiFJ/CRaLHvbakCg+Ox6Rv7XlP4KmCjWfMhJ7ZFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789569770; c=relaxed/simple;
	bh=y9cL+bWw17AHMHxfB2jXBHEFAqLUnaBApDnIfvis9AM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=g5jMhbzPXLCmpT+s1RdAFzDOu+E4h37HeS6LZvuC4LQPdMoZrvayqCa6aXXFIBDLyePb9jbBxaVUoPTnhnCaLFWWjFsB23DPROxn8dMfX+3CikrnkZeDcMMQ8ovZ2Ccbn5pSTDNlI5d4rnB1vcoTWmS97/X6oh/f3pgeu2R7B0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k+KLzS9z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+KLzS9z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D089A1F000FF;
	Wed, 16 Sep 2026 14:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789569768;
	bh=FwvS5UItrcHkrDAwHzE/UOVRGSXseRvyP1Un30H9BwI=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=k+KLzS9zTk864hpz365FRpXfY9iaqSvKrxQge6vTXejwJTW3Wtb1o/LiAEPboialQ
	 D9uvZcZc/21ENKvBBBiE6VfVFFvgKy2jNZ4IxwGBA8vMcEQQzPJm6sYFLd9509FheH
	 y0eew0WGi1MJgeqsyxXwuDIwEk3CjLt5QjDsUYy1kEhIWI6Bwjp8gC+GyN0t4wu+7U
	 uocjuqu/cwXcBEDJOJ0cO/9DxMd8lWvgsQO8ncIdbUaFeiAdHmcpsrv3WFbSJlzIBr
	 Sefi+SGqL4YVVyKf1LDkQD1TE898XzKHYwfZtHyCC2xomXxln88LTHgaR9/T+zvzVb
	 iyTnyfNt3i4uA==
Date: Wed, 16 Sep 2026 09:42:46 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Angel J <iamanaws@httpd.dev>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-rpi-kernel@lists.infradead.org" <linux-rpi-kernel@lists.infradead.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"florian.fainelli@broadcom.com" <florian.fainelli@broadcom.com>
Subject: Re: [REGRESSION] PCI: Dynamic OF node creation hangs on invalid
 bridge configuration
Message-ID: <20260916144246.GA921594@bhelgaas>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Tav3crct3HpgoRPBGOe-bfkBEORVT1RkvRbP8B7IXhRvEbUTAi-G6RiSnynkgV2rJ1dOIbCxm-mHUcm1e0MyQG52qswzpxURe4KFJoddhGg=@httpd.dev>

On Wed, Sep 16, 2026 at 11:14:25AM +0000, Angel J wrote:
> Hi Bjorn, Andrea,
> 
> Thanks, that clears it up. I agree the of_property fix is simpler. If a
> Type 1 device can legitimately have no bus below it, I don't see a reason
> to change its class or header just to avoid that case.

Yes.  And I suspect this affects more than just the [8086:4c43]
device, so I think it will be easier if we don't have to list
individual devices for a quirk.  I think it's very common to have this
kind of bridge for Intel uncore at bridge 0xff or 0x7f.

> On Tuesday, September 15th, 2026 at 18:21, Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> > On Mon, Sep 14, 2026 at 11:28:45PM +0000, Angel J wrote:
> > > Ok, here it is...
> > >
> > > I tested this quirk on Linux 6.18.44 with CONFIG_PCI_DYNAMIC_OF_NODES=y,
> > > and it boots without either OF fix. The diff below omits the test logging.
> > >
> > > PCI_FIXUP_HEADER runs after the resources have been parsed using the
> > > original header type, and changing hdr_type also affects configuration
> > > restore. I don't know enough about this part of PCI to judge whether
> > > that's safe, so I'll wait for your advice before submitting it as a patch.
> > >
> > > Thanks,
> > > Angel J
> > >
> > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > > index de9bbccda..57df88a38 100644
> > > --- a/drivers/pci/quirks.c
> > > +++ b/drivers/pci/quirks.c
> > > @@ -291,6 +291,22 @@ static int __init pci_apply_final_quirks(void)
> > >  }
> > >  fs_initcall_sync(pci_apply_final_quirks);
> > >
> > >
> > > +/*
> > > + * On the Dell XPS 8940, 8086:4c43 reports a PCI-to-PCI bridge but has no
> > > + * downstream bus. Use host-bridge class and a normal header so that
> > > + * pci_is_bridge() does not send it through bridge scanning.
> > > + */
> > > +static void quirk_intel_4c43_host_bridge(struct pci_dev *dev)
> > > +{
> > > +	if ((dev->class >> 8) != PCI_CLASS_BRIDGE_PCI ||
> > > +	    dev->hdr_type != PCI_HEADER_TYPE_BRIDGE)
> > > +		return;
> > > +
> > > +	dev->class = (PCI_CLASS_BRIDGE_HOST << 8) | (dev->class & 0xff);
> > > +	dev->hdr_type = PCI_HEADER_TYPE_NORMAL;
> > > +}
> > > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x4c43, quirk_intel_4c43_host_bridge);
> > 
> 
> > I think your of_property patch is better because it removes some
> > assumptions made in the of_pci_make_dev_node() path about what things
> > in the pci_dev are valid.  It's quite legal for a device to have a
> > Type 1 header (so pci_is_bridge() is true), but have no pci_bus below
> > it, e.g., a bridge on bus 0 with Secondary Bus Number also being 0.
> > 
> 
> > I don't know what happened in this particular case, whether the
> > Secondary Bus Number and Subordinate Bus Numbers are hard-wired to
> > 0xff or what (per spec, both should be read/write).  Maybe the system
> > "lspci -vv" and/or complete dmesg log would have a clue.
> > 
> 
> > But I do think it's better if we don't assume that every pci_dev with
> > a Type 1 header has a pci_bus allocated.
> > 




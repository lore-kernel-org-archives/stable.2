Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C43838F253;
	Wed, 16 Sep 2026 01:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789521678; cv=none; b=oA92814kY7IjYGnBWlWsb+9IrZSGVkVvP+Rhzj6vXJYkLpr26vXiHAvwa9lYOeVNXNHPYessqRa+cUyOzI7hCaNkFNaqdFkBntlNyM3ZqFZI2aOkRea/r9Ul9COost3p5SjFfB8chN7DpHftidyanfeR8x4ruNJ0x9KWa6KLIRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789521678; c=relaxed/simple;
	bh=0Wbe+nQ3iMRYcPF5b2fQhTZ72kvmf1L1FbpmuIH6ClQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Odf7YF/MYNnV/QH7YVAwxJMGwpnwG1JiwXoPMTAQRCoZ7kvxyu9Ctyx8CdxjUv9Tc4bzPr9xd8yErIfVqu64WS2X7yxi9k4Irgmt46z9B2gu6WoPnCH2j0iz0xUxZJ6GU5dzXlXiOse6Wb2hL1Erkuhp9TtSHnO4UpFAulMyWwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RkXicEF3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RkXicEF3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A3831F000FF;
	Wed, 16 Sep 2026 01:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789521677;
	bh=ffJRaL2ky6pBQl8PtqB+J2dsYGt8mUxbX9DKk1QC71U=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=RkXicEF3L9BA4bhrsFGpqr7wgrUxNKkf67F+tRYiUGJ3df8JFH8orZ8NiNZj33jWo
	 7aNa+nVsGYoD7Itv0pdaAngqwtrILN/DxiwevL5b9VuYj4gLrMwDtGE7fWWR800TA2
	 A8GY9x18OvbCXjGWCdmu7/1h/KdoxMUQmPOE4mWZAMPaVPdld7I2EAdyQOyWGb6e/Z
	 YvpXzxZBw8R2SI4ZjeSAQCX1IMRR9MQz/clX8oUGJPVdigCTCHCaX1yU2FQG2AEzIs
	 49/1YMgHuW2ev+JZBUHaU+Um+2RyEkE4qJzBy81JgsfOrrJ5jseFgTAVPIvfyp12FY
	 b82RZ92Uo74gQ==
Date: Tue, 15 Sep 2026 20:21:15 -0500
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
Message-ID: <20260916012115.GA888380@bhelgaas>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VaPKN3QbW3sGj8wePAvI_xD3twp_MQE4-4xeSbvgoQPVUnKDWKz0EWT_JiLehpmc6WOsCAoFOPs412Xhtthes_ZtvrgsKB4QB6QPz-XvRb4=@httpd.dev>

On Mon, Sep 14, 2026 at 11:28:45PM +0000, Angel J wrote:
> Ok, here it is...
> 
> I tested this quirk on Linux 6.18.44 with CONFIG_PCI_DYNAMIC_OF_NODES=y,
> and it boots without either OF fix. The diff below omits the test logging.
> 
> PCI_FIXUP_HEADER runs after the resources have been parsed using the
> original header type, and changing hdr_type also affects configuration
> restore. I don't know enough about this part of PCI to judge whether
> that's safe, so I'll wait for your advice before submitting it as a patch.
> 
> Thanks,
> Angel J
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index de9bbccda..57df88a38 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -291,6 +291,22 @@ static int __init pci_apply_final_quirks(void)
>  }
>  fs_initcall_sync(pci_apply_final_quirks);
>  
> 
> +/*
> + * On the Dell XPS 8940, 8086:4c43 reports a PCI-to-PCI bridge but has no
> + * downstream bus. Use host-bridge class and a normal header so that
> + * pci_is_bridge() does not send it through bridge scanning.
> + */
> +static void quirk_intel_4c43_host_bridge(struct pci_dev *dev)
> +{
> +	if ((dev->class >> 8) != PCI_CLASS_BRIDGE_PCI ||
> +	    dev->hdr_type != PCI_HEADER_TYPE_BRIDGE)
> +		return;
> +
> +	dev->class = (PCI_CLASS_BRIDGE_HOST << 8) | (dev->class & 0xff);
> +	dev->hdr_type = PCI_HEADER_TYPE_NORMAL;
> +}
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x4c43, quirk_intel_4c43_host_bridge);

I think your of_property patch is better because it removes some
assumptions made in the of_pci_make_dev_node() path about what things
in the pci_dev are valid.  It's quite legal for a device to have a
Type 1 header (so pci_is_bridge() is true), but have no pci_bus below
it, e.g., a bridge on bus 0 with Secondary Bus Number also being 0.

I don't know what happened in this particular case, whether the
Secondary Bus Number and Subordinate Bus Numbers are hard-wired to
0xff or what (per spec, both should be read/write).  Maybe the system
"lspci -vv" and/or complete dmesg log would have a clue.

But I do think it's better if we don't assume that every pci_dev with
a Type 1 header has a pci_bus allocated.

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBA94DA9AA;
	Mon, 12 Oct 2026 21:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791840890; cv=none; b=GFWSNgqpEnwkWoIGCb/Qes+4UBcY+3eIhOg9jPzh6JAcHE7wdFEHLcZRCHjCmQxVAFE30oktRfUAOtxk/0fXxvRpmwONdynaBC8LHrSG+Zaciqjp0WgLbamVC4zltGOafwlsOgQ1Id0ETlhVWua1116fX4kbzUOEVXDSql/aCrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791840890; c=relaxed/simple;
	bh=2rYQqctxIJ2NAfH8d5iXblRfcvOqUMnrMip1eofojvk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ZSyTMYmJ45xcWN2SDEBi89YMEBwokuqGNu+s8h/km3IiEWuT2ntYvii0AtBzvEfdJIdEgivkHpI1jhYQRrq6oRddTPhHyc48D/wjs5QBReA9/1bh0W17U/Our0Fxpi2uQQyM0ooPP/HhHBkgAUlig1HXkin+4plC93FoJLMlPEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HENcQPzl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HENcQPzl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C4411F008A1;
	Mon, 12 Oct 2026 21:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791840888;
	bh=+k/A8cNCSgFkxc2tpT06bk4634W3QnFn4AnLpYa6IdI=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=HENcQPzl2lLQKWet8buJsvIU9gf4FXwjfIYCelfQDQPmPjJxz3KqOpYdwDZudafVZ
	 Z3o1JqQOOZuYRCXPTmeBItGIj1dAX59mnCWc+gKqNyNkhZwsiqbIqYM8O2o9ZpB2e+
	 wuuHRN9/wzrfpZfnfuT6IrfkNiYm7UtP+tlbdGQspPluyy03NXuhyH7QHXmwiSo2P9
	 6DFwu/IAwnPSwde3a9dEyKgYmO6M32OMcppRRsMW5f4fdeqX51bd24gWO2IcZSY4BI
	 dPrpJefJv6B7EK0qC8cOH/fZlaVeW2L1EVM4PKniM8V/vWcBj16QqQmlo1hwOJynt2
	 pgw6vk/SA8FTQ==
Date: Mon, 12 Oct 2026 16:34:47 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Imre Kaloz <kaloz@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
	Srinath Mannam <srinath.mannam@broadcom.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Vikas Gupta <vikas.gupta@broadcom.com>
Subject: Re: [PATCH] PCI: Avoid D3 on PLX PEX 8532/8533/8548 downstream ports
Message-ID: <20261012213447.GA1392402@bhelgaas>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260927105609.8813-1-kaloz@kernel.org>

[+cc several Broadcom folks, help with possible switch erratum]

On Sun, Sep 27, 2026 at 12:56:09PM +0200, Imre Kaloz wrote:
> Runtime PM suspends an idle downstream port of a PLX/Broadcom PEX
> 8532/8533/8548 switch to D3hot, but that takes the whole switch down
> with it: any device behind another port of the same switch then
> faults with a fatal bus error on its next access, e.g. mptsas probe
> on a Sun Ultra 45.
> 
> This surfaced on sparc64 once commit a5fb3ff63287 ("PCI: Allow PCI
> bridges to go to D3Hot on all non-x86") let bridges enter D3hot. Keep
> these downstream ports out of D3 by setting PCI_DEV_FLAGS_NO_D3.

I don't really have any objection to this, but I am concerned that
this quirk only applies to a few specific devices, but
https://admin.pci-ids.ucw.cz/read/PC/10b5 shows a TON of
similar-looking switches that I assume have the same behavior, so
this may be just the tip of the iceberg.

> Fixes: a5fb3ff63287 ("PCI: Allow PCI bridges to go to D3Hot on all non-x86")
> Cc: stable@vger.kernel.org
> Signed-off-by: Imre Kaloz <kaloz@kernel.org>
> ---
>  drivers/pci/quirks.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index de9bbccda21f..a3c9250182a6 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -2381,6 +2381,24 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9050,
>  DECLARE_PCI_FIXUP_HEADER(0x1402, 0x2000, quirk_plx_pci9050);
>  DECLARE_PCI_FIXUP_HEADER(0x1402, 0x2600, quirk_plx_pci9050);
>  
> +/*
> + * An idle downstream port of a PLX/Broadcom PEX 8532/8533/8548 switch
> + * autosuspends into D3hot, and that takes the whole switch down with
> + * it -- any device behind another port of the same switch then sees a
> + * fatal, non-recoverable bus fault on its next access. Keep these
> + * ports out of D3 entirely.
> + */
> +static void quirk_plx_pex_no_d3(struct pci_dev *dev)
> +{
> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM) {
> +		dev->dev_flags |= PCI_DEV_FLAGS_NO_D3;
> +		pci_info(dev, "avoiding D3 on this downstream port\n");
> +	}
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_PLX, 0x8532, quirk_plx_pex_no_d3);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_PLX, 0x8533, quirk_plx_pex_no_d3);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_PLX, 0x8548, quirk_plx_pex_no_d3);
> +
>  static void quirk_netmos(struct pci_dev *dev)
>  {
>  	unsigned int num_parallel = (dev->subsystem_device & 0xf0) >> 4;
> 
> base-commit: fe2ec83746e501645709761605c2464a44fd2929
> -- 
> 2.47.3
> 

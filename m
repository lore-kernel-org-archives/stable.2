Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7393FD960;
	Thu,  3 Sep 2026 20:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788467246; cv=none; b=cVbZjFyFjs/hIMywCROAnRnE4JXo8tw1YnGASh6FxSBAeflez74FwQGt7m7hj/rY3XTJVskDB9UPXPTobcUmeBR9oB1aTMjm6ogoy+dLypAQkd5DLbZdoaKiyxF42Zz5YuxTngTton276CizrLn8fcL2SSfVR4IOKtWpMGUZ7zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788467246; c=relaxed/simple;
	bh=SEv99GbFvhCoi4C7FxZ6KLtENccVuBT3J0i4H1Xf7uc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LSRa+0U/yo9DBF9q+4y6eHWRxsozDH2TJN6sIs9wKnXYUW0m3q5oELTc5Ua2fI6U934eiQ8QLrKFJEjYdruzMAKpd6wLvHoJlvX0bR/xJ5ERwntkfr4SuL1T7MDI1jZ6/fZ/hnNO7CyWPplJVH9nZlorqVSU88Usdiv8xMop9rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SathpNyU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SathpNyU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26AB61F00A3D;
	Thu,  3 Sep 2026 20:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788467228;
	bh=6hatARtWn4PZ/aznb37PUvzfdSTr4y4SRVJj3QN/3qw=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=SathpNyUJPJwwW32qOty1IywXRfFf2LhjFwnQ9QkpAMTG99Q67ZHrmEigGDtV5jdb
	 LTK5e2Tjq/35GhYGzkt8Pj2sdKZ/+BuqDpmrgEW1V7hOm9CPjwEM8N/VBG4Cewa/jL
	 V1noqPIqe0RWo+O4Xq3NZrxbGaR5TFUNt/nAlyH8HPYtwROVwUYrKyKnOMYlC9S4H+
	 zZfiBDRYewQ1qT6rrfFCBZCb1ySklBYwA+Wq5lVrnomvroW+IUZBg7Qi0z8kgYVA1E
	 Kq2AeOxkbvVXmm06zhurETyAI1sxSkDkQpcFiBYgYm8IBCz9oTRBx0E9CrnjEP6yCe
	 4vKj+ggetbdQA==
Date: Thu, 3 Sep 2026 15:27:06 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: linux-pci@vger.kernel.org, stable@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Koichiro Den <den@valinux.co.jp>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	Ziyao Li <liziyao@uniontech.com>, Rong Zhang <i@rong.moe>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH v3] PCI: rcar-gen4: Limit Max_Read_Request_Size and
 Max_Payload_Size to 256 Bytes
Message-ID: <20260903202706.GA2234456@bhelgaas>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5b47840-6c45-4e00-8907-7766dd1d4607@mailbox.org>

On Thu, Sep 03, 2026 at 08:51:06PM +0200, Marek Vasut wrote:
> Hello Bjorn,
> 
> On 9/3/26 7:32 PM, Bjorn Helgaas wrote:
> > [+cc Ziyao, Rong, Huacai for similar Loongson MRRS issue]
> > 
> > On Fri, Aug 21, 2026 at 04:05:51AM +0200, Marek Vasut wrote:
> > > R-Car Gen4 PCIe controller has a hardware limitation of 256 Bytes
> > > Max_Payload_Size (MPS). PCIe specification indicates that the MPS
> > > must not exceed minimum MPS of any element along the packet path.
> > > Force limit Max_Payload_Size to at most 256 Bytes for each device
> > > connected to this PCIe controller.
> > 
> > IIUC the PCI core already enforces this limit, and what this patch
> > does is double-check that this limit is observed with this check,
> > right?
> 
> That is correct, this was changed in V3, I missed the commit message update,
> sorry.
> 
> Would you like me to respin the patch one more time with an updated commit
> message, or would you be willing to fix it up in tree ?

I fixed the commit log, no problem.

> >    +	WARN_ON(pcie_get_mps(dev) > 256);
> > 
> > More below.
> 
> 
> [...]
> 
> > > +	bridge->no_inc_mrrs = 1;
> > > +	if (pcie_get_readrq(dev) > 256) {
> > > +		pci_info(dev, "Limiting MRRS to 256 bytes\n");
> > > +		pcie_set_readrq(dev, 256);
> > > +	}
> > 
> > It would be nice if all the platforms that need no_inc_mrrs could
> > apply it the same way, but I assume you saw loongson_mrrs_quirk() and
> > loongson_set_min_mrrs_quirk() in the process of finding no_inc_mrrs,
> > and chose a different implementation strategy for some reason, e.g.,
> > this way doesn't have to include device IDs for all the Root Ports?
> 
> The loongson quirk won't work if the PCIe controller driver is built as a
> module, which the R-Car Gen4 PCIe driver can be, and in fact is often built
> as a module, because it depends on firmware which is loaded from filesystem.
> 
> If the controller driver is built as a module, then
> DECLARE_PCI_FIXUP_ENABLE() is not applied, the DECLARE_PCI_FIXUP_ENABLE() is
> applied only on boot and therefore only for built-in drivers.
> 
> I got burnt by DECLARE_PCI_FIXUP_ENABLE() in V1 of this patch.

Ouch, that does hurt.

> However, there is also another part to this -- the
> rcar_gen4_pcie_enable_device() is called for every device on the bus and
> applies the MRRS limitation to every device on the bus that is downstream of
> the controller, not only the controller. This is necessary on this
> controller variant, else hardware like PCIe SSDs with MRRS higher than the
> controller break.
> 
> > Maybe we should rework no_inc_mrrs in such a way that drivers could
> > set a max MRRS in the struct pci_host_bridge and make
> > pcie_write_mrrs() and pcie_set_readrq() pay attention to it?  That
> > might let us get rid of the FIXUP approach.
>
> In light of the last paragraph above, that the MRRS has to be limited also
> on all devices downstream of this particular controller, I would like to ask
> -- does the Loongson controller have the same limitation or not ? If not,
> then I would argue this quirk should be isolated to this controller variant
> ; else, I am happy to start on the core patches.

I don't know if we'll get a real answer for Loongson (there's no
maintainer listed for it, hint hint :)), but my guess is that it does
apply to all devices downstream of the Loongson controller.

I think MRRS is mostly interesting for DMA because MMIO from CPUs is
usually small sizes, far below the 128-byte or larger transfers that
devices may do.

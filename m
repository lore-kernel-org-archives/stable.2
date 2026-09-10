Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548863AEF51;
	Thu, 10 Sep 2026 08:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789028701; cv=none; b=o6WYmb18S7mcDIZ/lAgriplowC8D08pyOmRdRe4DUSk5REyZsLJC5l9j33pE7xO3bhmUuC0hvyimNhcK8U8PZ3W83Oj2/WLI5T13QPtbHLtjbIcJRiPHMWodaDt+oBxLbg7VDcIMHHoEB45PuzgEIIQUq/JNJss97GOnJrMokTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789028701; c=relaxed/simple;
	bh=cNgogUyCXQ5C0C+s+vEwUwbUb4/RySuQS6UxVHOIolk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ScTzJjvIUauM9Gkyeu+9Ab/0npVPnoPSN2JOoJ9KuzUX3YBjngiMHNM1xSU3nlnRO0G1ct2z+5T17azkmGLABln4ApFxVdyIOn78QTiz/Ed/tWPkuKXCDESIko8SJnPEY+IVoGqJtLkJpHj1UCRDMcagK6puDPlXLa9PYKDmrIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hX5Yl2YN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hX5Yl2YN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE8B41F000FF;
	Thu, 10 Sep 2026 08:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789028698;
	bh=N2SURyTcbduKJLk+a5NWhlHR0NrFlRiMGnI7Q6438/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hX5Yl2YNobLqEoQGyfzkEC3/pXkCXYI1wPtA3nQRL90+U2tsjl585qPkt2jJeYlqR
	 r9+BLuQ7nyuawukphAupVDlLTa3wei1BP4VCCAUHNdvw8kXsXcmmvGchTQoPDBrtFD
	 mKv39Bwq/YCJv6IONs7Rll0waiH9WdLTHkXtV566YbpD0TYUOmLfVIfnyooheTo6ie
	 p+izrXrqrW62my+otdagP4QucslAmrJ61ClZT1fGkJp5DDzma+CnOf1tOeIfkN6a44
	 7DbDUNtkgPRsmmhRxjFlD0e/O2a4JzedQWdEKRu1Q5GqZG2x3Ktg8y9EcXkhMcy1Rr
	 ic9Wp2U5bnphA==
Date: Thu, 10 Sep 2026 10:24:50 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Rudi Heitbaum <rudi@heitbaum.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>, 
	Lucas Stach <l.stach@pengutronix.de>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	imx@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] PCI: imx6: Avoid dereferencing a NULL clock name
Message-ID: <v5xbens6xr63smpdm4qugj6vtstd2efvezhbic2j3vctxcdbme@lh42pxcn7qp2>
References: <am8iBwJSEhYhWTqk@6cfee64030a6>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <am8iBwJSEhYhWTqk@6cfee64030a6>

On Sun, Aug 02, 2026 at 10:55:03AM +0000, Rudi Heitbaum wrote:
> of_clk_bulk_get() leaves clk_bulk_data::id as NULL for every clock that
> has no matching entry in "clock-names", which is legal: a node may list
> more "clocks" phandles than it names. The extref scan dereferences that
> id unconditionally, so such a node oopses during probe.
> 
> Check clk_bulk_data::id before dereferencing it.
> 
> Fixes: d8574ce57d76 ("PCI: imx6: Add external reference clock input mode support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Rudi Heitbaum <rudi@heitbaum.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index f7389b5437df..dcdeba1856f7 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1831,7 +1831,8 @@ static int imx_pcie_probe(struct platform_device *pdev)
>  		return dev_err_probe(dev, imx_pcie->num_clks,
>  				     "failed to get clocks\n");
>  	for (i = 0; i < imx_pcie->num_clks; i++)
> -		if (strncmp(imx_pcie->clks[i].id, "extref", 6) == 0)
> +		if (imx_pcie->clks[i].id &&
> +		    strncmp(imx_pcie->clks[i].id, "extref", 6) == 0)

As Sashiko mentioned, there are other places in this driver without the check.
Please fix all of them in a single patch.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

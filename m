Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6801E98EF;
	Fri, 18 Sep 2026 23:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789772419; cv=none; b=FwX8aP9qP6TNvkc99SNYrQOehmJFzTAapdi6Gk5lAMppo6Vli4tonJzY/2H5cJkLq3U0rIHkLM7P01XOsnGXwu9TenkgwozAGzuUYUzfMFUuqCpyOxXnVGnK+CE85HbHtLDu3Us605cHUjX8I5fai9Id+O0ZHyUfMVHpYdtWjgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789772419; c=relaxed/simple;
	bh=soRR53JeLr5E9sO4bwIPbK6EtttDoUxkkFFZYgNvOok=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Jnw9FKeDRW5eHedG7r3JTs4Ld7zArG2UaTcRZaC4qvchRyjX8acCgdBzQaFtpgi73X+O7loDlgqpRP0ilL2O/mWTehVwfRQDptclOR6RLf8osewIiqwn+ZacUgKKeVx6BgsvsSCMpxGwn371woBsrmcPqSjHW0eo+2pqYULoRQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oLTy+OD6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oLTy+OD6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1276C1F000FF;
	Fri, 18 Sep 2026 23:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789772417;
	bh=ODTQrY0Jnry0Dfu3UICCoe8mZrLfiMVB8y8nz6T8EQE=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=oLTy+OD6g/37bVTLXaNX0EZiObFu59/4XeOqEG62ekDkw/ztpvQkkogMu189UZa7A
	 mGAad6qFw8J/sUBL9JZHnmtiLhuTzCDdPozJbGAVl7PiUaz4gWMCu7JiMlVKkTSCaw
	 +YfAVpn4M2CC19X1EXCEgBJ2RMIa3bPCqaWnXUHfb8r05WrHiq67rxJmMA5R1quXqf
	 htus6gV7Jv7wOGz27XSMw+2vCB5eEI1b0CDjDKwE5vcn+GBLvq6Y16oHmM/JMM0Hn/
	 1twk7jc9DlL+zhdgbFzx11yGaXOz6Lws0Pjj3ixaVzWTLEIHLJqmucY6rMEhuWPfGE
	 mpNZFawkau82Q==
Date: Fri, 18 Sep 2026 18:00:15 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Soeren Moch <smoch@web.de>
Cc: Richard Zhu <hongxing.zhu@nxp.com>, stable@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
	Fabio Estevam <festevam@gmail.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [PATCH] PCI: imx6: Keep Root Port MSI capability also for i.MX6Q
Message-ID: <20260918230015.GA1205610@bhelgaas>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427115804.134231-1-smoch@web.de>

[+cc Thorsten, possible regzbot confusion?]

On Mon, Apr 27, 2026 at 01:58:04PM +0200, Soeren Moch wrote:
> Also on the NXP i.MX6Q chipset MSIs from the endpoints won't be received by
> the iMSI-RX MSI controller if the Root Port MSI capability is disabled.
> 
> Even though the Root Port MSIs won't be received by the iMSI-RX controller
> due to design, this chipset has some weird hardware bug that prevents
> the endpoint MSIs from reaching when the Root Port MSI capability is
> disabled.
> 
> Hence, always keep the Root Port MSI capability for this chipset.
> 
> Note that by keeping Root Port MSI capability, Root Port MSIs such as AER,
> PME and others won't be received by default. So users need to use
> workarounds such as passing 'pcie_pme=nomsi' cmdline param.
> 
> Fixes: 3a4e8302e72f ("PCI: imx6: Keep Root Port MSI capability with iMSI-RX to work around hardware bug")
> Cc: <stable@vger.kernel.org> # 7.0.x
> Signed-off-by: Soeren Moch <smoch@web.de>

This thread is still listed as a regression:
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/20260427115804.134231-1-smoch@web.de/

But I *think* it's been resolved by:

  b4bee12ebecc ("PCI: imx6: Keep i.MX6 Root Port MSI/MSI-X Capabilities with iMSI-RX to work around hardware bug")

Can you confirm?

Maybe regzbot is confused by the fact that the regression was first
attributed to 3a4e8302e72f, and then later attributed to
f5cd8a929c825?

> ---
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Cc: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Frank Li <Frank.Li@nxp.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: imx@lists.linux.dev
> Cc: linux-kernel@vger.kernel.org
> 
> Tested on a tbs2910 board [1]
> [1] arch/arm/boot/dts/nxp/imx/imx6q-tbs2910.dts
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 6d6a1688e7eb..3d461bdef967 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1865,7 +1865,8 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.flags = IMX_PCIE_FLAG_IMX_PHY |
>  			 IMX_PCIE_FLAG_SPEED_CHANGE_WORKAROUND |
>  			 IMX_PCIE_FLAG_BROKEN_SUSPEND |
> -			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
> +			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND |
> +			 IMX_PCIE_FLAG_KEEP_MSI_CAP,
>  		.dbi_length = 0x200,
>  		.gpr = "fsl,imx6q-iomuxc-gpr",
>  		.ltssm_off = IOMUXC_GPR12,
> -- 
> 2.43.0
> 

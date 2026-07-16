Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD1C3C585A;
	Thu, 16 Jul 2026 22:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784240827; cv=none; b=GYYKNMFkdnOogEflunKr46eDnLxaZNqbY6aWLw5ozzq+gYXk4j4tFPkcaQjP+Oa8f5CtBXX3mKFX40UvDaFnDfHSkqwlcMfeXpGsuSdQ08hGFdh02dz1+k7ju2NVpYikmZKjfR/3IiA7Fn6AEKcmQjjWdXqHtaikdCWWbDT7dcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784240827; c=relaxed/simple;
	bh=VLNYfRJTeld0drkHGyfcc9RtZGEyJPkTccv5z3IRa70=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=k9wlGynSmDSL1Hl/mzl1tLP2eA4dxYWx/WO1sDTvprtxcnM2DknGii3K/0SD2rdM8dZRXtrIIGseCYBNCYLJxD3kEXLCHn1uorxuH6SvePGTRZG1stwI9tPFuNECX5u/RsgB17arvSHbJT3bU1EGz3HJvBpv7pChBCw65gcph7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UPpLHQ45; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UPpLHQ45"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88F1B1F000E9;
	Thu, 16 Jul 2026 22:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784240825;
	bh=1xljQTmqJlCzKIHpALxY+4GD7OjjFlayegI2A0zHBXY=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=UPpLHQ452t47t7yKSVf2NY5R05kKElpfJvJu4gfkdUp4VGi/FyRTWbsAkzD0HKGEk
	 eOU5MY0FbwoQ5El9idrCMexlCd44Kxls9YZDsBScrje6Fs8MVyPyiV8ngXCHCmkjQa
	 FjD/UsPU7oIi4130Lfpc+hxylmLL0M8RRRDXnCu9TnJlKz8MmWFXLQPuOlyF3WFU29
	 jOk6xjqNZU5Zuk+zpiQ2NJTXgvmL55f3lRt7dDmc3WOCzU/UpWpQUnp/bB7/EGLQCV
	 z6flHmUHuXrqzuqmt9V9TO8R/j2A2vPSjWDl1e954cHcQ7nVj6xQ7USFR6y98zTfSl
	 NQJhQfXCnmGcw==
Date: Thu, 16 Jul 2026 17:27:04 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Soeren Moch <smoch@web.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, stable@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>, Frank Li <Frank.Li@nxp.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: imx6: Keep Root Port MSI capability also for
 i.MX6Q
Message-ID: <20260716222704.GA240248@bhelgaas>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716214054.47372-1-smoch@web.de>

On Thu, Jul 16, 2026 at 11:40:54PM +0200, Soeren Moch wrote:
> On the NXP i.MX6Q chipset MSIs from the endpoints won't be received by
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

I'd like to align the subject a little more with 3a4e8302e72f and
avoid repeating the ".. from reaching when the Root Port MSI ..." part
of the commit log, which seems to be missing a word.  So I propose the
following (if you think it's accurate):

  PCI: imx6: Keep i.MX6Q Root Port MSI capability with iMSI-RX to work around hardware bug

  On some NXP chipsets, disabling Root Port MSI/MSI-X Capabilities blocks
  MSIs originating from Endpoints from reaching the iMSI-RX controller.

  To address this hardware bug, 3a4e8302e72f ("PCI: imx6: Keep Root Port MSI
  capability with iMSI-RX to work around hardware bug") preserves Root Port
  MSI and MSI-X Capabilities on i.MX7D, i.MX8MM, and i.MX8MQ when iMSI-RX is
  in use.

  The same applies to i.MX6Q, so preserve Root Port MSI/MSI-X Capabilities
  there as well.

  Note that preserving these Capabilities means Root Port-originated MSIs
  such as AER and PME won't be received due to separate hardware limitations.
  Users may need to use workarounds such as passing the 'pcie_pme=nomsi'
  command-line parameter.

Also, we need to resolve the Sashiko question about whether IMX6QP and
IMX6SX also need this.  NXP folks, can you verify?

> Fixes: f5cd8a929c825 ("PCI: dwc: Remove MSI/MSIX capability for Root Port if iMSI-RX is used as MSI controller")
> Cc: <stable@vger.kernel.org> # 7.0+
> Signed-off-by: Soeren Moch <smoch@web.de>
> Acked-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
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
> This patch is similar to
> 3a4e8302e72f ("PCI: imx6: Keep Root Port MSI capability with iMSI-RX to work around hardware bug")
> 
> Tested on a tbs2910 board [1]
> [1] arch/arm/boot/dts/nxp/imx/imx6q-tbs2910.dts
> 
> changes in v2:
> - collect a-b and r-b tags
> - use correct fixes tag (Manivannan)
>   (reference commit that introduced the bug, not the incomplete fix)
> 
> Since this is a fix for a regression in linux-7.0+, can this still be merged for 7.2-rcS ?
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 98e1db751132..8130cf93c2bb 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1995,7 +1995,8 @@ static const struct imx_pcie_drvdata drvdata[] = {
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

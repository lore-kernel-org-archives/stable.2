Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3912736EAA6;
	Tue,  9 Jun 2026 15:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781020063; cv=none; b=KipAa8vuKLVMnjp22rP0VpXu4a/LuosCnJDkoWD2QNpepkbw6rRe5zwXoKb9f5sWKigMMDHVUMcBwViIch2W/AvzBXWfBIN63hFI0oX41LXKX2pnlvyvO7c3osrg87rd/ow9mZVL7VZTCuKWzhz871C/ODd+novNaXW5j+7sp6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781020063; c=relaxed/simple;
	bh=hUY8WmaKPqdt5XKj0BNv9cUF5ZQbwgXw9S9j3KenIxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L2s+Z4FfxQdbM6/0qLJnjWyrY9dtqIPosKdJJuIAp8wa0GWi9sWso186SNJ4PZ0fcGwf60QFOSteCU7PUMfsDl3/P48ZbYNv0LwoEBMJkt+GFOkbtAye1HVBOW/5gDPTgosSCoINYsQ3E6Zu0RzBPyvjEE1NQ3OGCbtHX/RMr5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ftE0Hrzt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ftE0Hrzt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 848DE1F00893;
	Tue,  9 Jun 2026 15:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781020062;
	bh=M1W7CRAqGX1E8dfJFnTYqdwHB0D9gv4yn30ZbnB9uVE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ftE0HrztmsU8QOKAipN0RVsg9+hFmlEX/gcr/B0muCWCk2NcG6rBy14Kz3V4w59uv
	 ySUyPSUYFtMVkok4w7vYMZe4GLCayGjLWr4Cb23yG+zCnOzBRivoFarrAoND0goLN7
	 /b8RiY2cC44AXgj3fgnAtnwp3oNscE2qgBIa89ACDOmbqdI6e51NGe7x/h2hsYoAKo
	 0Z+T5LZUgexpPN8pKGvpuSFDvOkrlEYspCSmErNL0QI/UyJRy6m/eZCLiDoolOYSPu
	 fT31i7Y6VNydiZOelzi5FjWxASApqxkIqUpFhMRVxWFD3DKJgaZtC/7kd8aQQcMmOx
	 70fjglbLcnhLw==
Date: Tue, 9 Jun 2026 21:17:33 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, festevam@gmail.com, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: imx6: Configure REF_USE_PAD before PHY reset
 for i.MX95
Message-ID: <xwupi3bxiihnmddqkdc6xsixkbirdpnips6qy5n4xchtcysnfq@f6pa5usw2a4f>
References: <20260518072715.3166514-1-hongxing.zhu@nxp.com>
 <20260518072715.3166514-2-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260518072715.3166514-2-hongxing.zhu@nxp.com>

On Mon, May 18, 2026 at 03:27:14PM +0800, Richard Zhu wrote:
> According to the i.MX95 PCIe PHY Databook, the ref_use_pad signal in the
> Common Block Signals section selects the reference clock source connected
> to the PHY pads. Per the specification, any change to this input must be
> followed by a PHY reset assertion to take effect.
> 
> Move the REF_USE_PAD configuration before the PHY reset toggle to comply
> with the required initialization sequence.
> 
> Fixes: 47f54a902dcd ("PCI: imx6: Toggle the core reset for i.MX95 PCIe")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 27 ++++++++++++++++++++++++---
>  1 file changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 002e0a0d9382..66e760015c92 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -138,6 +138,7 @@ struct imx_pcie_drvdata {
>  	const u32 mode_off[IMX_PCIE_MAX_INSTANCES];
>  	const u32 mode_mask[IMX_PCIE_MAX_INSTANCES];
>  	const struct pci_epc_features *epc_features;
> +	int (*init_pre_reset)(struct imx_pcie *pcie);

I renamed the callback and helper while applying:

s/init_pre_reset/select_ref_clk_src

- Mani

>  	int (*init_phy)(struct imx_pcie *pcie);
>  	int (*enable_ref_clk)(struct imx_pcie *pcie, bool enable);
>  	int (*core_reset)(struct imx_pcie *pcie, bool assert);
> @@ -249,6 +250,24 @@ static unsigned int imx_pcie_grp_offset(const struct imx_pcie *imx_pcie)
>  	return imx_pcie->controller_id == 1 ? IOMUXC_GPR16 : IOMUXC_GPR14;
>  }
>  
> +static int imx95_pcie_init_pre_reset(struct imx_pcie *imx_pcie)
> +{
> +	bool ext = imx_pcie->enable_ext_refclk;
> +
> +	/*
> +	 * Regarding the Signal Descriptions of i.MX95 PCIe PHY, ref_use_pad is
> +	 * used to select reference clock connected to a pair of pads.
> +	 *
> +	 * Any change in this input must be followed by phy_reset assertion.
> +	 */
> +
> +	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_PHY_GEN_CTRL,
> +			   IMX95_PCIE_REF_USE_PAD,
> +			   ext ? IMX95_PCIE_REF_USE_PAD : 0);
> +
> +	return 0;
> +}
> +
>  static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
>  {
>  	bool ext = imx_pcie->enable_ext_refclk;
> @@ -271,9 +290,6 @@ static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
>  			IMX95_PCIE_PHY_CR_PARA_SEL,
>  			IMX95_PCIE_PHY_CR_PARA_SEL);
>  
> -	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_PHY_GEN_CTRL,
> -			   IMX95_PCIE_REF_USE_PAD,
> -			   ext ? IMX95_PCIE_REF_USE_PAD : 0);
>  	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_SS_RW_REG_0,
>  			   IMX95_PCIE_REF_CLKEN,
>  			   ext ? 0 : IMX95_PCIE_REF_CLKEN);
> @@ -1348,6 +1364,9 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
>  		pp->bridge->disable_device = imx_pcie_disable_device;
>  	}
>  
> +	if (imx_pcie->drvdata->init_pre_reset)
> +		imx_pcie->drvdata->init_pre_reset(imx_pcie);
> +
>  	imx_pcie_assert_core_reset(imx_pcie);
>  
>  	if (imx_pcie->drvdata->init_phy)
> @@ -2047,6 +2066,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.mode_mask[0] = IMX95_PCIE_DEVICE_TYPE,
>  		.core_reset = imx95_pcie_core_reset,
>  		.init_phy = imx95_pcie_init_phy,
> +		.init_pre_reset = imx95_pcie_init_pre_reset,
>  		.wait_pll_lock = imx95_pcie_wait_for_phy_pll_lock,
>  		.enable_ref_clk = imx95_pcie_enable_ref_clk,
>  		.clr_clkreq_override = imx95_pcie_clr_clkreq_override,
> @@ -2102,6 +2122,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.ltssm_mask = IMX95_PCIE_LTSSM_EN,
>  		.mode_off[0]  = IMX95_PE0_GEN_CTRL_1,
>  		.mode_mask[0] = IMX95_PCIE_DEVICE_TYPE,
> +		.init_pre_reset = imx95_pcie_init_pre_reset,
>  		.init_phy = imx95_pcie_init_phy,
>  		.core_reset = imx95_pcie_core_reset,
>  		.wait_pll_lock = imx95_pcie_wait_for_phy_pll_lock,
> 
> base-commit: 40b7f61a1a4d7fd18188f3f87e15ff5a90ce1d31
> -- 
> 2.37.1
> 

-- 
மணிவண்ணன் சதாசிவம்

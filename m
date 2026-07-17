Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDB4349CD7;
	Fri, 17 Jul 2026 17:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784308199; cv=none; b=JD6xDc5h8Vn4O7ZVnDldVSiV10KPFCKUf96S5DqOm//CMoQITqWpO3zH2Z74LrJTU44NFBYPpzLR3dDFoX5LERXV+j2BCjD0NPfZgCngM/mJDj1HRmB9M/yFKuEOdfHtORE5cF9ceKwJ2tJul2+Dg1LGOaOnMk9gJlTUTsGpz8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784308199; c=relaxed/simple;
	bh=ym2v4YmYfJCHRs2bjR8+AYF/V8og/2Ps/38jlnEn5mE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=avNxDOv866cphhX8jaw5z2UynkQV0TkU7Nk1jZUcaw5tteRqwzJNdKbzGMz7bVdPY/bMBIvMiqQuHOM8pE8NetQkS3JgRAy5uim8bUYna7kr2ng8y92qY5f0C7B8t8NJYM2cuERhjJjSPKEvdmEna24bRO3/YB65Hw3mf6AskcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5TbUhyE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5TbUhyE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D3E11F000E9;
	Fri, 17 Jul 2026 17:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784308197;
	bh=vrIIp5vvuim1vMqA0JaquYGqHqFXlC/x9tIPiRIrp0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=i5TbUhyEKURDYC//pmORMnyZIHNvtflLPqTTUQgKjllucYKinkcQl+ssuKZrzA7nW
	 0n1w6zhI7AJ8gx3SWYRLm94qclZsGIEQ9CYPDjQfTiGpHLt9Ff7ggdTTeowCJZyvZT
	 mmNL9TJt8Z4HGsobH3Avb+VLWn2yNV9cWWxBd8b16diMtjrchCYgSJTlEAAgI4EMtR
	 aiifL/uiUt/WVKnSRKSEfa6fDxMc1TzQVBaCh2F+csc0OP+bVjd9+fe4qH0b2/tfHr
	 XdbQCSQJDcpGeFjTha6ceq7sFcmk0kmVqlPIxSwi/mMCo0mGgQBP0XzDJPuvtj9nIW
	 X6fVJCtnhYTmQ==
Date: Fri, 17 Jul 2026 12:09:56 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: hongxing.zhu@oss.nxp.com
Cc: frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
	bhelgaas@google.com, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, Soeren Moch <smoch@web.de>,
	stable@vger.kernel.org, Richard Zhu <hongxing.zhu@nxp.com>
Subject: Re: [PATCH v3] PCI: imx6: Keep i.MX6Q Root Port MSI capability with
 iMSI-RX to work around hardware bug
Message-ID: <20260717170956.GC11343@bhelgaas>
References: <20260717033203.2965045-1-hongxing.zhu@oss.nxp.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717033203.2965045-1-hongxing.zhu@oss.nxp.com>

On Fri, Jul 17, 2026 at 11:32:03AM +0800, hongxing.zhu@oss.nxp.com wrote:
> From: Soeren Moch <smoch@web.de>
> 
> On some NXP chipsets, disabling Root Port MSI/MSI-X Capabilities blocks
> MSIs originating from Endpoints from reaching the iMSI-RX controller.
> 
> To address this hardware bug, commit 3a4e8302e72f ("PCI: imx6: Keep Root
> Port MSI capability with iMSI-RX to work around hardware bug") preserves
> Root Port MSI and MSI-X Capabilities on i.MX7D, i.MX8MM, and i.MX8MQ
> when iMSI-RX is in use.
> 
> The same applies to i.MX6Q, i.MX6QP and i.MX6SX. So preserve Root Port
> MSI/MSI-X Capabilities there as well.
> 
> Note that preserving these Capabilities means Root Port-originated MSIs
> such as AER and PME won't be received due to separate hardware limitations.
> Users may need to use workarounds such as passing the 'pcie_pme=nomsi'
> command-line parameter.
> 
> Fixes: f5cd8a929c825 ("PCI: dwc: Remove MSI/MSIX capability for Root Port if iMSI-RX is used as MSI controller")
> Cc: <stable@vger.kernel.org> # 7.0+
> Signed-off-by: Soeren Moch <smoch@web.de>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Acked-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Applied to pci/for-linus for v7.2, thank you!

> ---
> changes in v3:
> - Extend the fix to i.MX6QP and i.MX6SX variants as well.
> - Update the commit descriptions suggested by Bjorn.
> 
> changes in v2:
> - collect a-b and r-b tags
> - use correct fixes tag (Manivannan)
>   (reference commit that introduced the bug, not the incomplete fix)
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 98e1db751132a..dba27eac6bff6 100644
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
> @@ -2011,7 +2012,8 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.flags = IMX_PCIE_FLAG_IMX_PHY |
>  			 IMX_PCIE_FLAG_SPEED_CHANGE_WORKAROUND |
>  			 IMX_PCIE_FLAG_SKIP_L23_READY |
> -			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
> +			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND |
> +			 IMX_PCIE_FLAG_KEEP_MSI_CAP,
>  		.gpr = "fsl,imx6q-iomuxc-gpr",
>  		.ltssm_off = IOMUXC_GPR12,
>  		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
> @@ -2026,7 +2028,8 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.flags = IMX_PCIE_FLAG_IMX_PHY |
>  			 IMX_PCIE_FLAG_SPEED_CHANGE_WORKAROUND |
>  			 IMX_PCIE_FLAG_SKIP_L23_READY |
> -			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
> +			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND |
> +			 IMX_PCIE_FLAG_KEEP_MSI_CAP,
>  		.dbi_length = 0x200,
>  		.gpr = "fsl,imx6q-iomuxc-gpr",
>  		.ltssm_off = IOMUXC_GPR12,
> -- 
> 2.34.1
> 

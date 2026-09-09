Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56403DC878;
	Wed,  9 Sep 2026 07:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788940702; cv=none; b=ACUl9dmtz448Sa4gj4USng8bUj8KkTO6+9mhF/AUqVL9apgEqC+YFTfnlrC4xEs7wU0gdhK3gtzzKVkpTBQafnd2x0YfEmZncnp/1I8ZtOWwsfa9lplRaE6DtopsQgLnBI2bPVwPu80QK+9YpeXKLkBVmUqUaKZX585oebVbChY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788940702; c=relaxed/simple;
	bh=qbF8Py7zaoy6Xc6VWkTu+v3MqSesXwF5k56kToMBmbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQb0m+r70QsQ6MNWLy04HriuevEKrT9Npj+OlgkMiPub7lRoOAovG2IKA/+emRAWrOqQP1fwMgbvGp1hIrZJg7ib6TinwGAxdVToNxs0AKnDhdPbmHjOX4BnnmIharprGqSoSgYhURbyEJNTEUoZa+dg1DO0yO8LYEqT4Uej9JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OUB4piiA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OUB4piiA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE9FD1F00A3A;
	Wed,  9 Sep 2026 07:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788940700;
	bh=PWnFaNRftVsLHoAenU5vbpmSu4o5KTXu8Qk5OuN0Zn8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OUB4piiAG/iMLs5wx4MVywuI930DqI8qv0bLNPt87l1bhHP7Od/2XyZnH3fkxKU98
	 brr0NjI4SEyY4KQFGfPi7bHEMDPh7N4HHajXBYsWqjCgFRWxFMFbbQy1uyuy1ShE89
	 34ax4j0ErRACN/6Z55Z4e/UiGrgx+OMNSrPc2wmkHrtGNrlWN5rqsxo1qDoflQt7UG
	 55vitECZpPaRbVFdp0PqsTwC5XbCb0ZXOhMDIZn/fS5gkHnQAYIox/e3IE6O7KqQgy
	 f0Of0c2HMulR7gdKkNuPGJsd1siezIPiIIpQRLXytl89xB/5GmWWuCapbUcUUC8Uj2
	 5JjqMwDfmjDsw==
Date: Wed, 9 Sep 2026 09:58:12 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Hongling Zeng <zenghongling@kylinos.cn>
Cc: vkoul@kernel.org, neil.armstrong@linaro.org, johan@kernel.org, 
	kishon@kernel.org, rogerq@ti.com, linux-phy@lists.infradead.org, 
	linux-kernel@vger.kernel.org, zhongling0719@126.com, stable@vger.kernel.org
Subject: Re: [PATCH v6 4/4] phy: ti-pipe3: Fix clock leak in init error path
Message-ID: <lsywnpxioldkbvb6n7pi6uihlnofjdwrhvm7yt3qiarori4hua@c6wueslryla4>
References: <20260619030214.1779043-1-zenghongling@kylinos.cn>
 <20260619030214.1779043-5-zenghongling@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260619030214.1779043-5-zenghongling@kylinos.cn>

On Fri, Jun 19, 2026 at 11:02:14AM +0800, Hongling Zeng wrote:
> When regmap_update_bits() fails in ti_pipe3_init() for PCIe mode,
> the function returns the error without calling ti_pipe3_disable_clocks().
> This leaves the clocks permanently enabled since the PHY framework won't
> invoke the .exit callback on init failure.
> 
> Fix this by adding proper clock cleanup in the PCIe error path, consistent
> with how the DPLL program error path handles cleanup.
> 
> Fixes: 234738ea3390 ("phy: ti-pipe3: move clk initialization to a separate function")
> Reported-by: Sashiko AI <sashiko@kernel.org>
> Closes: https://lore.kernel.org/all/20260518023657.41852C2BCB0@smtp.kernel.org/
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
> Cc: stable@vger.kernel.org
> 
> ---
> Change in v5:
>   -Add Fix ignored clock enable return value in init patch
> ---
> Change in v6:
>  -Fix all clock leak paths comprehensively:
>  -PCIe syscon update failure path
>  -SATA DPLL lock check path
>  -SATA errata path in ti_pipe3_exit()
> ---
>  drivers/phy/ti/phy-ti-pipe3.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/phy/ti/phy-ti-pipe3.c b/drivers/phy/ti/phy-ti-pipe3.c
> index 9ec228c2a940..860058f31594 100644
> --- a/drivers/phy/ti/phy-ti-pipe3.c
> +++ b/drivers/phy/ti/phy-ti-pipe3.c
> @@ -518,6 +518,8 @@ static int ti_pipe3_init(struct phy *x)
>  		val = 0x96 << OMAP_CTRL_PCIE_PCS_DELAY_COUNT_SHIFT;
>  		ret = regmap_update_bits(phy->pcs_syscon, phy->pcie_pcs_reg,
>  					 PCIE_PCS_MASK, val);
> +		if (ret)
> +			ti_pipe3_disable_clocks(phy);
>  		return ret;
>  	}
>  
> @@ -531,8 +533,9 @@ static int ti_pipe3_init(struct phy *x)
>  
>  	/* SATA has issues if re-programmed when locked */
>  	val = ti_pipe3_readl(phy->pll_ctrl_base, PLL_STATUS);
> -	if ((val & PLL_LOCK) && phy->mode == PIPE3_MODE_SATA)
> -		return ret;
> +	if ((val & PLL_LOCK) && phy->mode == PIPE3_MODE_SATA) {
> +		return 0;

Why are you returning 0 here and below?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

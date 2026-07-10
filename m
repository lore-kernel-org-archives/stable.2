Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4113806CD
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 08:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783673453; cv=none; b=D7TsRCMuuszlBucco4KgdG+q6j/0R/FRtDahhZtAjD67IFYplT9L0tzk09LvTjOr+xnTZcMVHA3mBzTXQkroPn5mEp1eD/HpfuPrC8zTA51GP2mTVPwKHJ8hDP/ULxZO6gjCq3wXouzQW1v+5DMIcty6rFXrkFoLUxf2UfLsAS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783673453; c=relaxed/simple;
	bh=5dM8YSKtmX3/xzYsXF2HVvat7PXeJQXKl8GCaYw+DbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oiDIz0UAYYsZ9625dxS1/6OjKl/CN2eewdi6UzH/oCSXCSSnnRJsoFRByT7p41QVf/9pfTynCjX1ngRgCmF+swAJuIPnKna+aQBqfCZg/ko/O08x8AmUenb0ahYUwJw83EiOFztSUC9mxtXfu/8AtcvLM+ArycV2ROnuzemvI18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QvDbu4xd; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QvDbu4xd"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C7FB61A0F33;
	Fri, 10 Jul 2026 08:50:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 99F5160341;
	Fri, 10 Jul 2026 08:50:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A80CA11BD078C;
	Fri, 10 Jul 2026 10:50:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783673447; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=v8gCKgh20t8MVOv0EHjwCoe6FndkvE+YsFdQeIoFVXA=;
	b=QvDbu4xd9VUwS6f51YRS1nAGHH8rlW2aIXNMDiswlHyDKQpIORB2QT3Mf2cSiNG7xDdgAJ
	45lg6jPfoUHnJ3Rn1PbARjw2c39aolsHHPwYeZfIydCN9L5jljHfX9XmHekcohFhQGmBaY
	C4+azk7xUepCDtSv8hLurWbdcl5yBNjSxh/MorILuigz+8Jr32l/PzFATweAX3RSv6HN3a
	LW7AK+w3i0GHLCO1mB1V6XxtH4g8diBZ20obAe6id2CcJr8m3hDDG6QgLt6F/ZnWaW/lSF
	Qfyx3WctLi5y+f8wxT6Q9xtUTS+gsHeIgnwPDT303oPSBnLMZKl6uWSHAOVkzQ==
Message-ID: <a95aab9e-24ad-4d9e-a9b4-2464431f4ec5@bootlin.com>
Date: Fri, 10 Jul 2026 10:50:41 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: stmmac: intel: gate SerDes reconfig on rate
To: Markus Breitenberger <bre@breiti.cc>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Choong Yong Liang <yong.liang.choong@linux.intel.com>,
 Markus Breitenberger <bre@keba.com>, stable@vger.kernel.org
References: <20260709190329.124432-1-bre@breiti.cc>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260709190329.124432-1-bre@breiti.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Markus,

On 7/9/26 21:03, Markus Breitenberger wrote:
> From: Markus Breitenberger <bre@keba.com>
> 
> intel_mac_finish() is registered as the phylink mac_finish()
> callback for the Elkhart Lake SGMII ports. phylink calls it at
> the end of every major link reconfiguration, including the
> initial one during probe.
> 
> The callback selects the PMC ModPHY LCPLL programming for the
> requested MAC-side interface and then power-cycles the SerDes.
> On Elkhart Lake that ModPHY is also used by the on-die AHCI
> SATA PHY. Reapplying the programming during the initial
> boot-time link-up disturbs the shared analog block while it is
> still driving SATA, so the SATA link fails to train:
> 
>   ata1: SATA link down (SStatus 1 SControl 300)
> 
> The disk carrying the root filesystem is never detected and the
> system hangs at rootwait. Ethernet itself comes up normally,
> which makes the failure look unrelated to the network driver.
> 
> Before mac_finish() runs, the legacy SerDes power-up path has
> already programmed SERDES_GCR0 for the current interface. The
> 1G and 2.5G ModPHY tables selected by mac_finish() correspond
> to the SerDes lane rate, so read that rate back from SERDES_GCR0
> and skip the PMC reprogramming and SerDes power-cycle when it
> already matches the selected interface.
> 
> This keeps the disruptive reprogramming out of the boot path
> when the SerDes is configured correctly, while preserving the
> previous behavior when a real SGMII/1000BASE-X to 2500BASE-X
> rate change is needed. If the register read fails, reconfigure
> as before.
> 
> Fixes: a42f6b3f1cc1 ("net: stmmac: configure SerDes according to the interface mode")
> Cc: stable@vger.kernel.org
> Assisted-by: GitHub-Copilot:claude-opus-4.8
> Signed-off-by: Markus Breitenberger <bre@keba.com>
> ---
> v2:
>   - Read the current SerDes lane rate from SERDES_GCR0 instead of
>     comparing against cached phy_interface state.
>   - Rework the commit message to clarify the SerDes power-up path and
>     the rate readback check.
>   - Keep the previous reconfiguration behavior if the SERDES_GCR0 read
>     fails.
> 
> v1: https://lore.kernel.org/netdev/20260706061954.94842-1-bre@breiti.cc/
> 
>  .../net/ethernet/stmicro/stmmac/dwmac-intel.c | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
> index b8d467ba6d72..fa0113597c97 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
> @@ -525,6 +525,31 @@ static int intel_set_reg_access(const struct pmc_serdes_regs *regs, int max_regs
>  	return ret;
>  }
>  
> +/* Return true if the SerDes lane rate must change to serve @interface.
> + * If the current rate cannot be determined, reconfigure as before.
> + */
> +static bool intel_serdes_needs_reconfig(struct stmmac_priv *priv,
> +					struct intel_priv_data *intel_priv,
> +					phy_interface_t interface)
> +{
> +	u32 cur_rate, want_rate;
> +	int data;
> +
> +	if (!intel_priv->mdio_adhoc_addr)
> +		return true;
> +
> +	data = mdiobus_read(priv->mii, intel_priv->mdio_adhoc_addr,
> +			    SERDES_GCR0);
> +	if (data < 0)
> +		return true;
> +
> +	cur_rate = (data & SERDES_RATE_MASK) >> SERDES_RATE_PCIE_SHIFT;
> +	want_rate = interface == PHY_INTERFACE_MODE_2500BASEX ?
> +			SERDES_RATE_PCIE_GEN2 : SERDES_RATE_PCIE_GEN1;
> +
> +	return cur_rate != want_rate;
> +}
> +
>  static int intel_mac_finish(struct net_device *ndev,
>  			    void *intel_data,
>  			    unsigned int mode,
> @@ -536,6 +561,9 @@ static int intel_mac_finish(struct net_device *ndev,
>  	int max_regs = 0;
>  	int ret = 0;
>  
> +	if (!intel_serdes_needs_reconfig(priv, intel_priv, interface))
> +		return 0;

You're returning a bit too early, make sure that you still update
priv->plat->phy_interface as you may be switching between 1000BaseX and
SGMII, so no rate change needed, but an interface change still :)

Maxime


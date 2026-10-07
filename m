Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0B13D34B3;
	Wed,  7 Oct 2026 10:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791370219; cv=none; b=kjRu2D8GOInbRljigfiYpA92k4jAfaEko6x6cjwWoSqthZgJBMZ0OgI8orcjTqwYw/aRLZ/fE0GxPNdL7FAwd6KFFmsBUPMBIzvpbTElfqN//hFn22tT/CK2nxBBCk8Ptfl4M5veZgHZIMM04B99qdHfnNFcd60wIojUyzdlw5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791370219; c=relaxed/simple;
	bh=xa7GPJf/5YzalSIzFrhjj9fOOO4caqXjlSgmFxKr/Uc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gM6qKlr11sJpDQm/I9rkW/plKplt0ljODgj7zapeIx91EpHyMz1mBGP58iCWSf1htmSMKbofo/yCOmH5GOI/UpqjPbZWZhqts5bhoG9BQmHwRGt4F/tqxZ0wISR2StRdiXDZ7cr6xSL69SvoNbbMxo7bJkNg2g+Yhew+uNvdPJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=V1OJEA5g; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="V1OJEA5g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1791370179; x=1822906179;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xa7GPJf/5YzalSIzFrhjj9fOOO4caqXjlSgmFxKr/Uc=;
  b=V1OJEA5gi2bpdnc5u2KlVMQESwy08gGPM/s8CfFR+0KhaY8qvRETzKDx
   pmlBUraNggA8p8nY+VQf4NgywjoeuHpPr0A1D1i8G0/H4F1gEmn0plB0B
   ytPnYPWxYa5gJwW5Wwi571DIMwheIBnHxt8wda1UzStS37MtetbFUtp3k
   zsvgFLHrjErZ3wTDv/U26UTEgx+idWSYyhYOTDKStlbjZ0uj3ZdjhxMi5
   YwybL+IOtlneaP6fUOexePmxIDu1tA4L5V3aZ/uyS0xFZ9qWW+2fwHHvY
   +oAUi5ibsJMocfnxg0Rt0QYcIHy4GjRI05sL9bKimFlzpbm15y623jl3m
   Q==;
X-CSE-ConnectionGUID: KFIgPLjrQ2mJudFnxTwwhw==
X-CSE-MsgGUID: VKI0oHsISvKy8ZCsHSCwUg==
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="63749271"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Oct 2026 03:48:36 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 7 Oct 2026 03:48:35 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 7 Oct 2026 03:48:34 -0700
Date: Wed, 7 Oct 2026 12:48:33 +0200
From: Daniel Machon <daniel.machon@microchip.com>
To: Myeonghun Pak <mhun512@gmail.com>
CC: <netdev@vger.kernel.org>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@kernel.org>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
	<ae878000@gmail.com>
Subject: Re: [PATCH net v2] net: nixge: stop IRQ producers before draining
 DMA error tasklet
Message-ID: <20261007104833.4ukkys7rnmv7ki5i@DEN-DL-M70577.microsemi.net>
References: <20261004042702.1130389-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261004042702.1130389-1-mhun512@gmail.com>

Hi,

> The TX and RX IRQ handlers can reschedule dma_err_tasklet after
> tasklet_kill(), allowing it to access rings freed by nixge_stop().
> 
> Free both IRQs before killing the tasklet. Since pending recovery can
> restart DMA, mask channel interrupts and wait for a DMA reset to finish
> before releasing the rings. Clearing RUNSTOP alone does not ensure that
> outstanding DMA accesses have completed.
> 
> If reset times out, retain the DMA buffers and reject subsequent opens
> to prevent those buffers from being freed or their pointers overwritten.

The subject only covers the IRQ/tasklet reorder. Whats described here is really
two separate fixes - should this be two patches?

> 
> Fixes: 492caffa8a1a ("net: ethernet: nixge: Add support for National Instruments XGE netdev")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
> Changes in v2:
> - Wait for DMA reset completion; retain buffers and reject reopen on timeout.
> 
> Based on net commit 6dc989ea46b96ce170840174b4a38c4a387fb005.
> No hardware testing was performed.
> 
>  drivers/net/ethernet/ni/nixge.c | 33 ++++++++++++++++++++++++++++++---
>  1 file changed, 30 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ni/nixge.c b/drivers/net/ethernet/ni/nixge.c
> index 230d5ff..878ca67 100644
> --- a/drivers/net/ethernet/ni/nixge.c
> +++ b/drivers/net/ethernet/ni/nixge.c
> @@ -185,6 +185,7 @@ struct nixge_priv {
>         void __iomem *dma_regs;
> 
>         struct tasklet_struct dma_err_tasklet;
> +       bool dma_stop_failed;
> 
>         int tx_irq;
>         int rx_irq;
> @@ -391,7 +392,7 @@ out:
>         return -ENOMEM;
>  }
> 
> -static void __nixge_device_reset(struct nixge_priv *priv, off_t offset)
> +static int __nixge_device_reset(struct nixge_priv *priv, off_t offset)
>  {
>         u32 status;
>         int err;
> @@ -407,6 +408,8 @@ static void __nixge_device_reset(struct nixge_priv *priv, off_t offset)
>                                      1000);
>         if (err)
>                 netdev_err(priv->ndev, "%s: DMA reset timeout!\n", __func__);
> +
> +       return err;
>  }
> 
>  static void nixge_device_reset(struct net_device *ndev)
> @@ -869,6 +872,10 @@ static int nixge_open(struct net_device *ndev)
>         struct phy_device *phy;
>         int ret;
> 
> +       /* A failed stop retained buffers which DMA may still be using. */
> +       if (priv->dma_stop_failed)
> +               return -EIO;
> +
>         nixge_device_reset(ndev);
> 
>         phy = of_phy_connect(ndev, priv->phy_node,
> @@ -911,6 +918,7 @@ static int nixge_stop(struct net_device *ndev)
>  {
>         struct nixge_priv *priv = netdev_priv(ndev);
>         u32 cr;
> +       int ret;

nit: RXT

> 
>         netif_stop_queue(ndev);
>         napi_disable(&priv->napi);
> @@ -920,6 +928,7 @@ static int nixge_stop(struct net_device *ndev)
>                 phy_disconnect(ndev->phydev);
>         }
> 
> +       /* Stop DMA while the completion IRQ handlers are still installed. */
>         cr = nixge_dma_read_reg(priv, XAXIDMA_RX_CR_OFFSET);
>         nixge_dma_write_reg(priv, XAXIDMA_RX_CR_OFFSET,
>                             cr & (~XAXIDMA_CR_RUNSTOP_MASK));
> @@ -927,11 +936,29 @@ static int nixge_stop(struct net_device *ndev)
>         nixge_dma_write_reg(priv, XAXIDMA_TX_CR_OFFSET,
>                             cr & (~XAXIDMA_CR_RUNSTOP_MASK));
> 
> -       tasklet_kill(&priv->dma_err_tasklet);
> -
> +       /* Remove both producers before draining the error tasklet. */
>         free_irq(priv->tx_irq, ndev);
>         free_irq(priv->rx_irq, ndev);
> 
> +       tasklet_kill(&priv->dma_err_tasklet);
> +
> +       /* Error recovery may have restarted DMA and enabled interrupts. */
> +       cr = nixge_dma_read_reg(priv, XAXIDMA_RX_CR_OFFSET);
> +       nixge_dma_write_reg(priv, XAXIDMA_RX_CR_OFFSET,
> +                           cr & ~(XAXIDMA_CR_RUNSTOP_MASK | XAXIDMA_IRQ_ALL_MASK));
> +       cr = nixge_dma_read_reg(priv, XAXIDMA_TX_CR_OFFSET);
> +       nixge_dma_write_reg(priv, XAXIDMA_TX_CR_OFFSET,
> +                           cr & ~(XAXIDMA_CR_RUNSTOP_MASK | XAXIDMA_IRQ_ALL_MASK));
> +
> +       /* Either channel's reset quiesces the entire AXI DMA engine. */
> +       ret = __nixge_device_reset(priv, XAXIDMA_TX_CR_OFFSET);
> +       if (ret) {
> +               /* Retain DMA buffers and prevent a subsequent open replacing them. */
> +               priv->dma_stop_failed = true;
> +               netdev_err(ndev, "DMA stop failed; retaining DMA buffers\n");
> +               return ret;
> +       }
> +
>         nixge_hw_dma_bd_release(ndev);
> 
>         return 0;
> --
> 2.53.0
> 
> 

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795869371;
	b=IiS/CVdqK25EcAijMl8Uo0nWbf9ZzAgAPyXAzPJpPdZhTGwPcJd4Mq+zTm0wCS812s0Y
	 gi+ozqEjPwfZr5khiYzwEE+mYxdo/cH1iZ8wPpFTDblzaKCnlzNTfLE4oHt3E9BJqg8cw
	 yQkCsR0c0P732VeYsShM3fULpJ9McEt4kVdZCpJuenulVSu70f/joTMTPkj7+RcZ0e3Xb
	 pBR9XzyAffORb4MaMxb/4qMiqSSjCE7kw6VdOOPC7BrPOMDDyND4+hPJqWJn7dM0wLERZ
	 UAiSnsXszNP1z/CJz59l8hLy2/i7HR+jcoiR7LKk42mlXtCdzzRf1oqeR/XQ19ywnIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795869371;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=e4tEpL5eqWttsGZfNF3g5fGUTnRitHzItkaZ9VIiO+w=;
	b=Z5fj2QrTM+ldH+W/mCT8knqpwR1O82X2jThCpkWqNvLqGloY8WdNYiT0x+UEGjsi+sbD
	 vJkBXkLKnAKStvFCIl1i8CzrOubnoa2H02VFZ940YPwmr9jG6fD7/2ZSYYdN0zgH6XVkM
	 zt5MQJn2hA4Mb+NPON0pSjuxcpwPf1I5TSmLWEokUfZp2LM4lfCVqhUf/esOz2bno2jnv
	 mkLQJv2/ebrHIYpiw8K0Sgvy6lWaIgHoUgjePCTOOyvtbB9HplgL29EV1LMUZQZnZ+pC3
	 MuzfGh1qoK3vfExug/OaX/b4y1MWP/zVTWPGuTKG3tmNL6mLmezXwbSVx6Vy5nUVFPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="n/puXPBr";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A54606A31F;
	Sat, 28 Nov 2026 12:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n/puXPBr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C6461F000C1;
	Sat, 28 Nov 2026 12:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795869371;
	bh=e4tEpL5eqWttsGZfNF3g5fGUTnRitHzItkaZ9VIiO+w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=n/puXPBrrDA+MLP/N4C//9HByS6mFgpyNbxhZfoGCJA3AFXPDxVGi1ASDcSy+UyyJ
	 UE7CZfNgHzyuluk/QXbHKEOujurk04uOhLQRTtxfmRFfklML9rNDhQQreogcDUh1dg
	 nKGwM4nEmzjfcKJ6j7YtD1YMefnRezf1m2WQdOKdlGISBW0BnEd1HBdg+LusQtjSyw
	 DXBa6FrgVK7pHmlMvtUAY0vq4m66WDvw1XhZLAZ+xRFw5h/0ZJoDjtgi0P8mi79GQG
	 k3e8/9UPIFGaqqEzZ6M+Fy3yMCGJ31PIHbLIiYGPFEnmTQddd2jt4sBhYwl5+phL8u
	 xQLTqReVxLUug==
Subject: Re: [PATCH net v2] net: ethernet: mtk_wed: fix double free in
 mtk_wed_rx_reset
From: netdev-bot+sashiko@kernel.org
To: hujy652@gmail.com
Cc: nbd@nbd.name, lorenzo@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 sujuan.chen@mediatek.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, sashiko-bot@kernel.org,
 stable@vger.kernel.org
Date: Sat, 28 Nov 2026 12:36:09 +0000
Message-ID: <179586936991.3135.11080392761968621173@kernel.org>
In-Reply-To: <20261127-doublefree-v2-1-c0c6d3da3b52@gmail.com>
References: <20261127-doublefree-v2-1-c0c6d3da3b52@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message describes a different bug from the one the
  new `dev->rx_buf_ring.desc = NULL` line fixes, and the only Fixes: tag…

Pre-existing issues:
- [Medium] mtk_wed_rx_reset() frees the RX buffer-manager resources only
  on full success.

--

net: ethernet: mtk_wed: fix double free in mtk_wed_rx_reset

mtk_wed_free_rx_buffer() already calls mtk_wed_hwrro_free_buffer(), so
this patch removes the second mtk_wed_hwrro_free_buffer() call in
mtk_wed_rx_reset(). It also sets dev->rx_buf_ring.desc, dev->hw_rro.desc
and dev->hw_rro.pages to NULL after they are freed, so the existing NULL
checks work.

Link: https://sashiko.dev/#/map/216156

> diff --git a/drivers/net/ethernet/mediatek/mtk_wed.c b/drivers/net/ethernet/mediatek/mtk_wed.c
> index 0bae252477987..0f215dd3d2d44 100644
> --- a/drivers/net/ethernet/mediatek/mtk_wed.c
> +++ b/drivers/net/ethernet/mediatek/mtk_wed.c

[ ... ]

> @@ -896,6 +898,7 @@ mtk_wed_free_rx_buffer(struct mtk_wed_device *dev)
>  	dev->wlan.release_rx_buf(dev);
>  	dma_free_coherent(dev->hw->dev, dev->rx_buf_ring.size * sizeof(*desc),
>  			  desc, dev->rx_buf_ring.desc_phys);
> +	dev->rx_buf_ring.desc = NULL;

[Severity: Medium]
Does this line fix an older bug than the one the Fixes: tag names?

The commit message describes the duplicated mtk_wed_hwrro_free_buffer()
call. Removing that call is enough to fix that bug. The only tag is:

    Fixes: 1543b8ff02f0 ("net: ethernet: mtk_wed: add wed 3.0 reset support")

The stale rx_buf_ring.desc pointer goes back further, to b08134c6e109
("net: ethernet: mtk_wed: add mtk_wed_rx_reset routine"). That commit added
the mtk_wed_free_rx_buffer() call at the end of mtk_wed_rx_reset() and
moved mtk_wed_rx_buffer_alloc() into mtk_wed_start(). It also affects WED
v2 (MT7986/MT7915).

Before this patch, rx_buf_ring.desc stays dangling after a reset until the
next successful mtk_wed_start(). There are two ways the restart can be
skipped.

The first is mt7915_dma_start() with wed_reset=true returning early:

drivers/net/wireless/mediatek/mt76/mt7915/dma.c:mt7915_dma_start() {
    ...
		ret = mt7915_mcu_wed_enable_rx_stats(dev);
		if (ret)
			return ret;

		mtk_wed_device_start(&dev->mt76.mmio.wed, wed_irq_mask);
    ...
}

The second is mtk_wed_start() bailing out when dma_alloc_coherent() fails
in mtk_wed_rx_buffer_alloc().

In either case, a later detach runs the free path again on the stale
pointer:

__mtk_wed_detach()
  mtk_wed_free_rx_rings()
    mtk_wed_free_rx_buffer()
      dev->wlan.release_rx_buf(dev);
      dma_free_coherent(..., desc, ...);

With only 1543b8ff02f0 tagged, would stable trees that have b08134c6e109
but not the hwrro code (such as 6.6.y) miss this part of the fix?

Would it make sense to add a Fixes: tag for b08134c6e109 and describe the
reset->detach double free in the commit message?

Also, the commit message says dev->hw_rro.page, but the field is
dev->hw_rro.pages.

>  
>  	mtk_wed_hwrro_free_buffer(dev);
>  }
> @@ -1722,7 +1725,6 @@ mtk_wed_rx_reset(struct mtk_wed_device *dev)
>  				   false);
>  	}
>  	mtk_wed_free_rx_buffer(dev);
> -	mtk_wed_hwrro_free_buffer(dev);
>  
>  	return 0;
>  }

[Severity: Medium]
This is a pre-existing issue and was not introduced by this patch.
mtk_wed_rx_reset() only reaches mtk_wed_free_rx_buffer() if every step
succeeds. Both mtk_wed_mcu_send_msg() state change calls return early on
error:

	ret = mtk_wed_mcu_send_msg(wo, MTK_WED_MODULE_ID_WO,
				   MTK_WED_WO_CMD_CHANGE_STATE, &val,
				   sizeof(val), true);
	if (ret)
		return ret;

mtk_wed_reset_dma() then ignores the return value:

	if (mtk_wed_get_rx_capa(dev))
		mtk_wed_rx_reset(dev);

After that, the WLAN reset flow calls mtk_wed_device_start() again. On
mt7915 this goes through
mt7915_dma_reset()->mt7915_dma_enable()->mt7915_dma_start().

mtk_wed_start() always calls mtk_wed_rx_buffer_alloc(). That function
overwrites the live pointers without releasing them first:

	dev->rx_buf_ring.desc = desc;
	dev->rx_buf_ring.desc_phys = desc_phys;
	dev->wlan.init_rx_buf(dev, dev->wlan.rx_npkt);

mtk_wed_hwrro_buffer_alloc() overwrites dev->hw_rro.pages and
dev->hw_rro.desc in the same way.

If a firmware message fails during SER recovery, can this leak the old
rx_buf_ring coherent ring? The same question applies to the hw_rro mapped
pages, page_list and coherent ring, and to the RX buffers taken by the
first init_rx_buf() call.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261127-doublefree-v2-1-c0c6d3da3b52%40gmail.com

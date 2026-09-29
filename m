Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346B03D525B;
	Tue, 29 Sep 2026 02:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790647261; cv=none; b=g+ger6pEPI5SNVuNgzjhRGDC/29FOhngoD0O8/L58fhe4FTFkcdTeb8Vl4lvtJOYNcVtcGnJe87s/7Kv2EeaUAac3kU6xU+e3D9Rz8HDndw4SKcp5RBO45FTcHeimR/Dp+tmBkSruUVdIrFj0Vc85IG+lXzxyKWGnr+IqSzdYws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790647261; c=relaxed/simple;
	bh=IApvHR6u5H1Pl7cj1/Iq37j8LmptrkcNWANo6MPPOtw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LqqhCn0zpUgcIrWozm5jwBWDHzisYDGcMIauV2bYwvDlO7wuAlf1WjbGAyYMXi6leoBj9/O43menT3413NclENGCtFhjbU8ApfLeh4ujbdrBu7sPXmYQJ4NdgKZfiOx03vMayJEVt/JJpevFHfcexmuC5SiYaawLZroMouFUs3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IswdQSpD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IswdQSpD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEFA31F000FF;
	Tue, 29 Sep 2026 02:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790647259;
	bh=xoQ0w4/ryNoyvsxo+4lQ4K7swAFRQCuVLghtmpgkZM8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=IswdQSpDchpj006rQ6WQoup5wll8+ZIGAwqhXEyhpT4Kc35eHKC0jDUomD+49JlBn
	 JGRb4+RROWCM+7k/IzCPErR35GVe/n0p0/puqE+YGphnLusnMnjWhINHVpi4m8yoD0
	 f9ck+qFYlcHJYpA7NqZpcqEycmpgU2c2KTJeTG9M4twtMUow+PAV9vjqW4wQRzaobG
	 WqPrQ3e/YeH8ORJsD1jXqWAZfDO+V8fsJ86+WeDtsjimL4kI5dlZT/XsSnKAio1Cly
	 0mxQADMja7ZTGsUajUnmMc0d5adBCGcPgAKrtMHzsmfCEWuchlAB/aXfD0HiQuNQiu
	 S/EQ/zrEbvjCw==
Subject:
 Re: [PATCH net v2 1/3] net: macb: never give hardware a NULL RX buffer
From: netdev-bot+sashiko@kernel.org
To: theo.lebrun@bootlin.com
Cc: conor.dooley@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, sean.anderson@linux.dev,
 atenart@kernel.org, edumazet@kernel.org, nicolas.ferre@microchip.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 nb@tipi-net.de, vladimir.kondratiev@mobileye.com, gregory.clement@bootlin.com,
 tawfik.bayouk@mobileye.com, thomas.petazzoni@bootlin.com,
 maxime.chevallier@bootlin.com, stable@vger.kernel.org
Date: Tue, 29 Sep 2026 02:00:58 +0000
Message-ID: <179064725824.434549.9533834557285217997@kernel.org>
In-Reply-To: <20260925-macb-close-v2-1-360efa565914@bootlin.com>
References: <20260925-macb-close-v2-1-360efa565914@bootlin.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] RX can stall permanently once no descriptor is armed (rx_tail ==
  rx_prepared_head) and refill has failed.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the patch
  widens it.

--

net: macb: never give hardware a NULL RX buffer

This patch sets RX_USED on every GEM RX descriptor in gem_init_rx_ring()
before the refill. A failed allocation or DMA mapping then cannot leave
hardware-owned slots pointing at NULL buffers. gem_rx() and
macb_rx_pending() now also stop once rx_tail reaches rx_prepared_head.

> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 8e5c034dc3a48..7f25574928d71 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c

[ ... ]

> @@ -1859,6 +1866,10 @@ static bool macb_rx_pending(struct macb_queue *queue)
>  	struct macb_dma_desc *desc;
>  	unsigned int entry;
>  
> +	/* No armed descriptor left: nothing can be pending. */
> +	if (macb_is_gem(bp) && queue->rx_tail == queue->rx_prepared_head)
> +		return false;
> +

[Severity: High]
Can RX on a GEM queue stall for good once every armed descriptor has
been consumed and gem_rx_refill() keeps failing?

Under memory pressure, the sequence would be:

gem_rx()
    rx_tail == rx_prepared_head -> break
    gem_rx_refill()
        netdev_alloc_skb() or dma_map_single() fails -> break
macb_rx_poll()
    napi_complete_done()
    queue_writel(queue, IER, bp->rx_intr_mask)
    macb_rx_pending()
        rx_tail == rx_prepared_head -> return false
    (no napi_schedule())

At that point every descriptor has RX_USED set. The hardware cannot
complete a frame, so RCOMP cannot fire. gem_rx_refill() is only called
from gem_rx() and gem_init_rx_ring(), and no timer or work item retries
it.

bp->rx_intr_mask is MACB_RX_INT_FLAGS. RXUBR is only added for
MACB_CAPS_NEEDS_RSTONUBR parts:

    bp->rx_intr_mask = MACB_RX_INT_FLAGS;
    if (bp->caps & MACB_CAPS_NEEDS_RSTONUBR)
        bp->rx_intr_mask |= MACB_BIT(RXUBR);

Zynq and the EMAC would still get a retry from macb_interrupt() on each
incoming frame through RXUBR.

On other GEM variants, is anything left to restart NAPI apart from
ISR_ROVR, if the controller raises it at all in this state? If not, RX
on that queue would stay dead after memory recovers, until the
interface is closed and reopened.

Before this patch, macb_rx_pending() returned true for the stale
RX_USED slot at rx_tail. NAPI kept rescheduling itself and so kept
retrying gem_rx_refill().

Later in the series, "net: macb: propagate RX ring refill errors"
handles the open-time case where nothing gets armed, by making
macb_open() fail. That commit leaves NAPI, resume and HRESP refill as
best effort. Its message also notes that with zero armed descriptors
nothing would ever trigger a refill. So this steady-state case seems
to remain at the end of the series.

[ ... ]

> @@ -2795,9 +2806,14 @@ static int macb_alloc(struct macb *bp)
>  
>  static void gem_init_rx_ring(struct macb_queue *queue)
>  {
> +	unsigned int i;
> +
>  	queue->rx_tail = 0;
>  	queue->rx_prepared_head = 0;
>  
> +	for (i = 0; i < queue->bp->rx_ring_size; i++)
> +		macb_rx_desc(queue, i)->addr |= MACB_BIT(RX_USED);
> +
>  	gem_rx_refill(queue);
>  }

[Severity: High]
This is a pre-existing issue, but this loop seems to widen it.
macb_hresp_error_task() reinitialises every RX ring without disabling
or synchronising RX NAPI:

macb_hresp_error_task()
    queue_writel(queue, IDR, ...)
    macb_writel(bp, NCR, ctrl & ~(RE | TE))
    bp->macbgem_ops.mog_init_rings(bp)
        gem_init_rx_ring()

It calls neither napi_disable() nor napi_synchronize(), and takes no
lock that gem_rx() also takes. With per-queue IRQs on different CPUs,
or with threaded NAPI, a gem_rx() poll already running on another CPU
keeps touching rx_tail, rx_prepared_head, the descriptors and
rx_skbuff[] at the same time.

The new loop ORs RX_USED into descriptors the hardware still owns
(valid buffer, ctrl == 0). A concurrent gem_rx() may have passed the
cursor check using stale values. Could it then see RX_USED with
ctrl == 0, log "not whole frame pointed by descriptor", and do
rx_tail++?

Suppose that increment lands after rx_tail = 0 but before
gem_rx_refill() runs. CIRC_SPACE(0, 1, rx_ring_size) is then 0, so
refill arms nothing. The whole ring is left RX_USED and RX stalls.

The same race already existed in other forms before this patch. Both
CPUs can run gem_rx_refill() on the same NULL rx_skbuff[] entry, and
each allocates and maps an skb. That either leaks one skb or leaves
desc->addr and rx_skbuff[] out of sync.

The HRESP refill can also take the rx_skbuff[entry] != NULL branch in
gem_rx_refill() and clear RX_USED on a descriptor whose skb gem_rx() on
the other CPU is about to unmap and hand to napi_gro_receive(). Once RE
is re-enabled, wouldn't the hardware DMA into an skb that the stack
already owns?

Later in the series, "net: macb: quiesce IRQs and drain BH on interface
close" only covers close and the open error path.
macb_hresp_error_task() looks unchanged at the end of the series.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260925-macb-close-v2-0-360efa565914%40bootlin.com

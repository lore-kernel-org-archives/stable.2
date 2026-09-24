Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5A9443E2F;
	Thu, 24 Sep 2026 10:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790246813; cv=none; b=RAM3bSN4RIwzbmkLNAnhroQDlTc4d8TCTNpGdEnmV2o9xnnEnEUarvK8ZdHoA8AnkBaq4d/yqGk/DVx+/rFtoSExsEpxaPWl60hBDoPEBTqqlArvs3M77TR5Ksg+aDLjH9zg37BUIHamDtDeRBb6aH7EwiUUcCZNxlQbK81UFT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790246813; c=relaxed/simple;
	bh=YOS5bjRLkBavMHPo54el7DPmPKo0f+8jX7zSfqk7Mrg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sFkdki+9MgADkLt0tc1/UVQRy6AphTm2XwbDo8U0BQ258az4o+QWvXlNeEW51XSrWoraLLkzohCFpItFpARtQnXw/GPK7Pn27S9SsrcBZwNB/W4AwvzjHMxG4lByYOekyBWE2VVgda38nYnPGuBE+LKxlwugQEGx7/AIlp1yWxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b20pLs3u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b20pLs3u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F8C51F00893;
	Thu, 24 Sep 2026 10:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790246811;
	bh=Dryo0wJ7TA0LsjhaB7mKMvUhYMqEw3rb87kzw0WTVU8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=b20pLs3u1Fzz3Dgy8I6KTrujy+PGv7fxgQMYh08V8GObeXhW6+NgeHeK5OGvv0kLm
	 ro0Ysj1gwkKcilNwk/4UVk/A4KolYPFMEHl8OEPAhSCRV+/biNlJtBgNZq1hZI2Dtm
	 ZftH5fPpumLQ8zsD41+vzs/dLEe4r2nO+S0Mewx8+kHTqncR2iMsNNm4HbhQjRftFD
	 h0kkwgjGNgL3ekMHzqrhejVDIXcYdWeWHp53KWTBkD/d/SUWeOsxQKhhDmK8CDHgwL
	 yUc1OX1vX7KcQ+39+jULikwmN9FWnVBox5iPe8/8Vzo8WDFKXY0NX3hBFmwKyXdSwZ
	 3k8hQ1vcVl7Mg==
Subject: Re: [PATCH net v2 7/9] gve: disable NAPI when registering XSK pools
 in QPL mode
From: netdev-bot+sashiko@kernel.org
To: joshwash@google.com
Cc: netdev@vger.kernel.org, hramamurthy@google.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, jordanrhee@google.com,
 willemb@google.com, thostet@google.com, nktgrg@google.com,
 eddiephillips@google.com, pkaligineedi@google.com, jeroendb@google.com,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
Date: Thu, 24 Sep 2026 10:46:49 +0000
Message-ID: <179024680999.2160803.2955533583331222995@kernel.org>
In-Reply-To: <20260922194533.631387-8-joshwash@google.com>
References: <20260922194533.631387-8-joshwash@google.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] On GQI-QPL, the new
  gve_disable_xsk_napis()/gve_enable_xsk_napis() window can leave a…
- [Low] The Fixes: tag and root-cause description in commit "gve: disable
  NAPI when registering XSK pools in QPL mode" appear to point at the…

--

gve: disable NAPI when registering XSK pools in QPL mode

This patch disables the RX NAPI and the XDP TX NAPI of the target queue
while gve_xsk_pool_enable() registers the MEM_TYPE_XSK_BUFF_POOL memory
model in QPL mode. The NAPIs are enabled again afterwards through a new
gve_enable_xsk_napis() helper. The goal is to close a race between packet
processing and the memory model registration.

> GVE in QPL mode does not current respect this, which could lead to a
> race condition between packet processing and the XSK_BUFF_POOL memory
> model registration.

[ ... ]

> Fixes: fd8e40321a12 ("gve: Add AF_XDP zero-copy support for GQI-QPL format")
> Cc: stable@vger.kernel.org

[Severity: Low]
Is fd8e40321a12 the right Fixes: target? The race described above needs
the memory model of the live rx->xdp_rxq to change while NAPI is running.

In fd8e40321a12, gve_xsk_pool_enable() registered MEM_TYPE_XSK_BUFF_POOL
on a separate rx->xsk_rxq:

    xdp_rxq_info_reg(&rx->xsk_rxq, ...);
    xdp_rxq_info_reg_mem_model(&rx->xsk_rxq, MEM_TYPE_XSK_BUFF_POOL, NULL);
    xsk_pool_set_rxq_info(pool, &rx->xsk_rxq);

The page-backed buffers that NAPI built kept using rx->xdp_rxq, and that
rxq stayed MEM_TYPE_PAGE_SHARED.

The switch on the live rxq seems to come from 077f7153fd25 ("gve: merge
xdp and xsk registration"). That commit changed gve_reg_xsk_pool() to do:

    err = xdp_rxq_info_reg_mem_model(&rx->xdp_rxq,
                                     MEM_TYPE_XSK_BUFF_POOL, pool);

The next patch in this series, "gve: ensure XDP mem model is registered
when disabling XSK pools", fixes the same problem on the disable path, and
it tags 077f7153fd25.

With the current tag, stable would try to backport this to 6.8 through
6.16, including 6.12 LTS. Those kernels don't have the mem-model switch
described here. The patch also won't apply there: gve_reg_xsk_pool() came
from d57ae093c887, and napi_disable_locked() isn't in the older trees.

fd8e40321a12 may have had a separate ordering race, because rx->xsk_pool
was published without an smp_wmb() after xsk_pool_set_rxq_info(). This
NAPI quiesce would close that race too, but the commit message doesn't
describe it.

Should the tag be 077f7153fd25 instead?

Also, the message only says the race "could lead to" a problem and doesn't
name a symptom. Could it mention that the mismatch can end with
container_of(xdp, struct xdp_buff_xsk, xdp) being applied to a page-backed
xdp_buff in the XSK receive path?

> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
> index 49ae2b8c6a270..f2bd4011de23f 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -1626,6 +1626,40 @@ static int gve_xdp_xmit(struct net_device *dev, int n,

[ ... ]

> +static void gve_enable_xsk_napis(struct gve_priv *priv, u16 qid)
> +{
> +	struct napi_struct *napi_rx, *napi_tx;
> +	u16 tx_qid;
> +
> +	napi_rx = &priv->ntfy_blocks[priv->rx[qid].ntfy_id].napi;
> +	napi_enable_locked(napi_rx);
> +
> +	tx_qid = gve_xdp_tx_queue_id(priv, qid);
> +	napi_tx = &priv->ntfy_blocks[priv->tx[tx_qid].ntfy_id].napi;
> +	napi_enable_locked(napi_tx);
> +
> +	if (gve_is_gqi(priv)) {
> +		if (gve_rx_work_pending(&priv->rx[qid]))
> +			napi_schedule(napi_rx);
> +
> +		if (gve_tx_clean_pending(priv, &priv->tx[tx_qid]))
> +			napi_schedule(napi_tx);
> +	}
> +}

[Severity: Medium]
On GQI-QPL, can this leave the notify block's IRQ doorbell masked while
NAPI is idle?

In GQI mode, gve_intr() masks the doorbell before it schedules NAPI:

gve_intr() {
    ...
    iowrite32be(GVE_IRQ_MASK, gve_irq_doorbell(priv, block));
    napi_schedule_irqoff(&block->napi);
    ...
}

Only gve_napi_poll() re-arms the doorbell, by writing
GVE_IRQ_ACK | GVE_IRQ_EVENT after napi_complete_done(). A poll that uses
its full budget returns before that write:

gve_napi_poll() {
    ...
    if (reschedule)
        return budget;
    ...
}

Suppose napi_disable_locked() in gve_disable_xsk_napis() overlaps an RX
poll that uses exactly its budget and drains the ring. __napi_poll() then
completes the NAPI without calling the driver again:

__napi_poll() {
    ...
    if (unlikely(napi_disable_pending(n))) {
        napi_complete(n);
        return work;
    }
    ...
}

An interrupt that arrives while the NAPI is disabled has the same effect.
gve_intr() masks the doorbell, but napi_schedule_prep() fails, so no poll
is queued.

gve_enable_xsk_napis() never unmasks the doorbell. It only reschedules if
gve_rx_work_pending() or gve_tx_clean_pending() sees work. If no new
descriptor arrived during the window, would the RX queue and its XDP TX
queue stop getting interrupts?

gve_turnup() unmasks the doorbell and schedules unconditionally:

gve_turnup() {
    ...
    if (gve_is_gqi(priv)) {
        iowrite32be(0, gve_irq_doorbell(priv, block));
    } ...
    mb();
    napi_schedule(&block->napi);
    ...
}

GQI-QPL never sets the XSK RX need_wakeup flag. xsk_set_rx_need_wakeup()
is only used in gve_buffer_mgmt_dqo.c, so an RX-only AF_XDP application
won't kick the NAPI through gve_xsk_wakeup(). The netdev TX watchdog
doesn't cover the XDP TX queue. Regular XDP_PASS traffic on that queue
would stall as well.

This pattern is copied from the existing gve_xsk_pool_disable() code. The
later patch in this series, "gve: ensure XDP mem model is registered when
disabling XSK pools", reuses this helper on the disable path, so the end
of the series still reschedules only conditionally.

Should gve_enable_xsk_napis() unmask the doorbell and schedule NAPI
unconditionally, as gve_turnup() does?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922194533.631387-1-joshwash%40google.com

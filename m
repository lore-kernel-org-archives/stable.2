Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FC124A078;
	Sun, 27 Sep 2026 15:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790522862; cv=none; b=Cd+YtB5P+tMiKWbdtik+48uQA32fnH6pzsGN+AFriTsTXDNOp99F3sF4zoa09z8TDxAzQs2GyDwUMBQtspN6aIxZsoVL4weGovXAU6ySn+xsOoVV1NBCDxtGW6Nar+JZYePkKq4Co2jdeUIbuxAi4PDFtqOEreU4T7y4ZposHzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790522862; c=relaxed/simple;
	bh=ZZctbrUtdp2u1m5vR8OUb3RsnNvd4XESXPNyA9NR6/4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ozPkFoOyFyTBezebjeiSzGmhsqebigwA4iD7dWxIc5fZi5cr3uqmts4Jk8L26/KGIWcq0iB3OYitAfkwjEdad81o8j5a23yIwO0XL99o3seMBXj/ph2lwmnrBNUI3ZnLSZNG4d5/LATR/GZhE6seeouBI0xv/VU+1p2WaYgPcPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJ9lOZUi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJ9lOZUi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C21C41F000FF;
	Sun, 27 Sep 2026 15:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790522861;
	bh=ogmrucsA1GTOgB+NrmzwiRT9ggqTpVQd1FndsO0P5oI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XJ9lOZUioQgut0C+aOfkbVUFgxqx+RqYjpyXr8Jxy96ecgJqIkV1RCw6UOWab7LNK
	 npnuMdCqFqPBu9Vdz+Xi44WpWRa/15gSMFKdNf5nOHEdnlGxcLgTLbbcX1v0jddA4n
	 DTtcwbsgTHAczjpdB+WGatG5qHLVM+mdPShuwxaepAgUI5gwFUtZe9mY5VgWXfjDJz
	 BtJTkK+/GCWmv31H+SAzM45DBdD1l3UWzQfWq6QdTk5HVxRYyqcgVECZfZiZOFeWGp
	 N4REtcWRX2FuCnemnQtHe5E7Atjb6TOZh1k3QkQTDEqvZXKoKCywobAYj8fRFS/M3A
	 Iybgv4QrKdwZA==
Subject: Re: [PATCH net] net: mana: reserve RX buffer headroom to fix
 forwarding performance
From: netdev-bot+sashiko@kernel.org
To: hamzamahfooz@linux.microsoft.com
Cc: netdev@vger.kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, horms@kernel.org,
 ernis@linux.microsoft.com, dipayanroy@linux.microsoft.com,
 gargaditya@linux.microsoft.com, jacob.e.keller@intel.com,
 ssengar@linux.microsoft.com, linux-hyperv@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Sun, 27 Sep 2026 15:27:39 +0000
Message-ID: <179052285930.2160803.11184804113286091670@kernel.org>
In-Reply-To: <20260923144500.4073380-1-hamzamahfooz@linux.microsoft.com>
References: <20260923144500.4073380-1-hamzamahfooz@linux.microsoft.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] With XDP attached, the patch sets rxq->headroom to max_t(u32,
  LL_RESERVED_SPACE(ndev), XDP_PACKET_HEADROOM) in…
- [Low] mana_set_priv_flags() (mana_ethtool.c) keeps its own copy of the
  old rule for when one buffer per page is forced anyway: `ndev->mtu +…
- [Low] The comment above mana_get_rxbuf_cfg() still reads "Get RX
  buffer's data size, alloc size, XDP headroom based on MTU".

--

net: mana: reserve RX buffer headroom to fix forwarding performance

This patch reserves LL_RESERVED_SPACE(ndev) of headroom in MANA RX buffers,
so forwarded packets no longer have to be reallocated by
pskb_expand_head() to satisfy skb_cow() in ip_forward(). With XDP attached,
the headroom is the larger of that value and XDP_PACKET_HEADROOM. The
frag-vs-single-buffer decision now uses the computed buffer size instead of
comparing the MTU against PAGE_SIZE / 2.

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index 591fb4191d90d..e3f3b33ba9062 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -758,6 +758,36 @@ static void *mana_get_rxbuf_pre(struct mana_rxq *rxq, dma_addr_t *da)

[ ... ]

> +static u32 mana_get_rxbuf_headroom(struct mana_port_context *apc)
> +{
> +	u32 headroom = LL_RESERVED_SPACE(apc->ndev);
> +
> +	if (mana_xdp_get(apc))
> +		return max_t(u32, headroom, XDP_PACKET_HEADROOM);

[Severity: High]
With XDP attached, can rxq->headroom now be larger than
XDP_PACKET_HEADROOM while the XDP path still assumes 256?

MANA_HEADROOM is sizeof(struct mana_skb_head), and that size grows with
MAX_SKB_FRAGS. CONFIG_MAX_SKB_FRAGS can be anywhere from 17 to 45. With
17 or 18 frags, LL_RESERVED_SPACE(ndev) is 256. With 19 to 45 frags it
is 272 to 592, and then max_t() returns that value instead of 256.

The NIC writes each frame at va + rxq->headroom in mana_get_rxfrag():

    *da = dma_map_single(dev, va + rxq->headroom, rxq->datasize,
                         DMA_FROM_DEVICE);

However, mana_run_xdp() in mana_bpf.c still does:

    xdp_prepare_buff(xdp, buf_va, XDP_PACKET_HEADROOM, pkt_len, true);

On XDP_PASS, mana_build_skb() then reserves
xdp->data - xdp->data_hard_start, which is 256 rather than
rxq->headroom:

    skb_reserve(skb, xdp->data - xdp->data_hard_start);

In those configs, would the XDP program, the XDP_PASS skb, and the
XDP_TX/REDIRECT/AF_XDP frames all start (headroom - 256) bytes before
the real frame? The leading bytes would be stale page_pool contents, and
the tail of the frame would be cut off.

There is a related question about the MTU limit in include/net/mana/mana.h:

    #define MANA_XDP_MTU_MAX (PAGE_SIZE - MANA_RXBUF_PAD - XDP_PACKET_HEADROOM)

This still budgets 256 bytes of headroom, while the XDP branch of
mana_get_rxbuf_cfg() keeps *alloc_size = PAGE_SIZE. mana_xdp_set() uses
MANA_XDP_MTU_MAX both for the MTU check and to set max_mtu.

At the largest accepted XDP MTU, does the DMA window now run
(headroom - 256) bytes into the skb_shared_info area that
napi_build_skb() initializes afterwards? If so, fixing only the
xdp_prepare_buff() offset would leave this limit wrong.

Before this patch the XDP headroom was always exactly
XDP_PACKET_HEADROOM, so these values always matched.

> +
> +	return headroom;
> +}
> +
> +static u32 mana_get_rxbuf_size(struct mana_port_context *apc, u32 mtu)
> +{
> +	u32 len = SKB_DATA_ALIGN(mtu + MANA_RXBUF_PAD +
> +				 mana_get_rxbuf_headroom(apc));
> +
> +	return ALIGN(len, MANA_RX_FRAG_ALIGNMENT);
> +}
> +
>  static bool
>  mana_use_single_rxbuf_per_page(struct mana_port_context *apc, u32 mtu)
>  {
> @@ -770,11 +800,16 @@ mana_use_single_rxbuf_per_page(struct mana_port_context *apc, u32 mtu)
>  	if (apc->priv_flags & BIT(MANA_PRIV_FLAG_USE_FULL_PAGE_RXBUF))
>  		return true;
>  
> -	/* For xdp and jumbo frames make sure only one packet fits per page. */
> -	if (mtu + MANA_RXBUF_PAD > PAGE_SIZE / 2 || mana_xdp_get(apc))
> +	/* For xdp make sure only one packet fits per page. */
> +	if (mana_xdp_get(apc))
>  		return true;
>  
> -	return false;
> +	/* Only use the page_pool fragment path when at least two buffers,
> +	 * including the headroom each of them has to reserve, actually fit
> +	 * into one page. Otherwise the fragment path degenerates into one
> +	 * buffer per page while still paying the fragment accounting cost.
> +	 */
> +	return PAGE_SIZE / mana_get_rxbuf_size(apc, mtu) < 2;

[Severity: Low]
Should mana_set_priv_flags() in mana_ethtool.c use this same rule? It
still has its own copy of the old one:

		if (ndev->mtu + MANA_RXBUF_PAD > PAGE_SIZE / 2 ||
		    mana_xdp_get(apc))
			return 0;

The comment above that check says single-buffer-per-page "is already
forced regardless of this flag", so the detach/attach cycle can be
skipped "since nothing changes".

On 4K pages with an MTU of about 1459 to 1714, which includes the default
1500, the old check is false. The new rule here already forces one buffer
per page in that range (buf_size is 2112 at MTU 1500).

Toggling the full-page-rx private flag at those MTUs would still run
mana_pre_alloc_rxbufs(), mana_detach() and mana_attach(), even though the
RX layout doesn't change. The mismatch only goes this way: a
reconfiguration that is actually needed is never skipped.

>  }
>  
>  /* Get RX buffer's data size, alloc size, XDP headroom based on MTU */

[Severity: Low]
This isn't a bug, but this comment still describes the headroom output as
"XDP headroom". After this patch, *headroom is always set from
mana_get_rxbuf_headroom(). Without XDP, that is LL_RESERVED_SPACE(ndev),
reserved for the TX-path struct mana_skb_head.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260923144500.4073380-1-hamzamahfooz%40linux.microsoft.com

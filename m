Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642E33CE4B5;
	Tue, 13 Oct 2026 04:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791866137; cv=none; b=IV+qSn4c/Cw9s6StRTFbb0r9xJLkBHF5c48v3KnsONakQ0vgQxYpa++x0TRJTdUfAWyLd32wis3Cr770BBlA2KqCOPvpS9WdH8Am6rp3MzW9g2bwuQDYdCKyT87BTXjYWr6jFvs8iL8xQXiG54ODgX/ujtFPHOpXTWBX9n+29CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791866137; c=relaxed/simple;
	bh=EH+xaYCLWuQB/Yv0HxiMNA0p61Kk+Jv047HsXAHaUN4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=msbxGvpz7vYxlUyrRxP0Ujjs807Ah9FXp73dhcG5nvcu/6j4ewd8qclWd/XDYFtkjSXBmPYINWeiX9hiFe/VCczCstgTMce+RkcJY0hFbBFBej4tMPyQ1LNTKCPaNbSJO4kyNh2ZoKrIlst0+3VdnPwDTFQ84r8OzjNOuoiSsd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7wDeMN1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7wDeMN1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28AFD1F000FF;
	Tue, 13 Oct 2026 04:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791866136;
	bh=WaRImVBsUFE4eVUeB1PEiSi3TIH9bh1+r5KroOTpC6M=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=h7wDeMN1FyVQF+HZAQGNGmJmwz7FJiB20VAVrnIl0RS/X2GiMgP9e42563iL/5T/4
	 E6/R5e5NfdDS8GRI0ogNhzCJyy1I1/Fs7E7/4SJ14boE3rjv2RVxS4CyDNMsPN5/Tz
	 TTNEHE3g6VUaFbo/0/2v/6XHyKgv4qABF+/rwPRxBpj/GUq9bATYgoExjS58UQYC4q
	 OR/BP/LmCfo61XJAMG6GOp691W7s8gXJP+fU7GCp9HV9pJ0qTYF6Op2bh48dn/m7JO
	 AZHG/F0VeskAzoH923qAEoEEhD9LRs50WaSVMcQc0P/fz5NYBKuPyKTwrKh718F4MV
	 a4gcbqQiXQ7xg==
Subject: Re: [PATCH net v3 1/5] eth: fbnic: only act on Rx completions naming
 a posted buffer
From: netdev-bot+sashiko@kernel.org
To: yhlee@isslab.korea.ac.kr
Cc: alexanderduyck@fb.com, kuba@kernel.org, netdev@vger.kernel.org,
 kernel-team@meta.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org, daskald@meta.com,
 mohsin.bashr@gmail.com, bobbyeshleman@meta.com, daniel.zahka@gmail.com,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 13 Oct 2026 04:35:34 +0000
Message-ID: <179186613465.434549.17421358167809172410@kernel.org>
In-Reply-To: =?utf-8?q?=3C25ce85c9821fba5d94932b36b9c9afb9a2fbd12a=2E1791775?=
 =?utf-8?q?409=2Egit=2Eyhlee=40isslab=2Ekorea=2Eac=2Ekr=3E?=
References: =?utf-8?q?=3C25ce85c9821fba5d94932b36b9c9afb9a2fbd12a=2E17917754?=
 =?utf-8?q?09=2Egit=2Eyhlee=40isslab=2Ekorea=2Eac=2Ekr=3E?=
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

Critical: 0 · High: 1 (2) · Medium: 0 (2) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Rx header offset/length validation is still incomplete at the
  end of the series.

Pre-existing issues:
- [High] The Tx completion path still trusts device-reported heads in
  fbnic_clean_twq0(), even at the end of the series.
- [High] fbnic_rx_buf_posted() only checks that an ID is inside [head,
  tail).
- [Medium] At the reviewed commit, fbnic_pkt_prepare() only does
  WARN_ON_ONCE(pkt->buff.data_hard_start) when a second HDR_AL…
- [Medium] At the reviewed commit, fbnic_add_rx_frag() takes a page_pool
  reference with fbnic_page_pool_get_data() (pagecnt_bias--) and does…

--

eth: fbnic: only act on Rx completions naming a posted buffer

This patch drops Rx completions whose buffer id is outside the rx_buf[]
array or outside the posted [head, tail) window, so the driver no longer
dereferences a NULL page. It also bounds the BDQ head used by
fbnic_clean_bdq(), and drops META completions that arrive without a
header buffer.

> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> index 10caacffee0f0..305fe6d2f511f 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> @@ -797,6 +797,34 @@ static void fbnic_page_pool_drain(struct fbnic_ring *ring, unsigned int idx,
>  	rx_buf->netmem = 0;
>  }
>  
> +/* The device names an Rx buffer by its index in the buffer descriptor
> + * ring.  A completion may only name a buffer we posted, that is one in
> + * [head, tail), so test the index against the array and against the
> + * posted window.  The window test is not enough on its own: it masks the
> + * index, so an index past the end of the array can fold back into the
> + * window and run off rx_buf[].
> + */
> +static bool fbnic_rx_buf_posted(struct fbnic_ring *ring, unsigned int idx)
> +{
> +	if (idx > ring->size_mask)
> +		return false;
> +
> +	return ((idx - ring->head) & ring->size_mask) < fbnic_desc_used(ring);
> +}

[Severity: High]
This is a pre-existing issue, but the commit message rejects masking
because it "corrupts that buffer's page_pool reference count". Can the
device still corrupt that count by repeating an id that is inside the
window?

Every accepted HDR_AL or PAY_AL completion takes a reference, and nothing
puts a lower bound on the bias:

fbnic_page_pool_get_head() {
	...
	rx_buf->pagecnt_bias--;
	...
}

fbnic_page_pool_get_data() does the same thing. fbnic_page_pool_init()
fragmented the page with only FBNIC_PAGECNT_BIAS_MAX (PAGE_SIZE)
references.

Suppose the device keeps naming idx == ring->head:

- fbnic_rx_buf_posted() returns true every time.
- fbnic_clean_rcq() sets head0 to ring->head.
- fbnic_clean_bdq() then returns early without advancing:

	if (head == hw_head)
		return;

After PAGE_SIZE such completions, pagecnt_bias reaches zero. When those
skbs are freed, pp_ref_count drops to zero. The page then goes back to
the page_pool or to the page allocator, while rx_buf[head].netmem still
points at it.

Later completions naming the slot would hand out references to a freed or
reused page. fbnic_page_pool_drain() would also call
page_pool_unref_netmem() with a negative bias.

Can this become a use-after-free of the Rx page? It still looks reachable
at the end of the series, though only with a misbehaving device.

> +
> +/* fbnic_clean_bdq() is given a position to consume up to rather than a
> + * buffer to use, so unlike fbnic_rx_buf_posted() it also accepts tail,
> + * which is how the teardown path asks for the whole ring to be drained.
> + */
> +static bool fbnic_bdq_head_valid(struct fbnic_ring *ring, unsigned int hw_head)
> +{
> +	if (hw_head > ring->size_mask)
> +		return false;
> +
> +	return ((hw_head - ring->head) & ring->size_mask) <=
> +	       fbnic_desc_used(ring);
> +}
> +
>  static void fbnic_clean_twq(struct fbnic_napi_vector *nv, int napi_budget,
>  			    struct fbnic_q_triad *qt, s32 ts_head, s32 head0,
>  			    s32 head1)

[Severity: High]
This isn't a bug introduced by this patch, but the Tx completion side
trusts a device-reported head in the same way. fbnic_clean_tcq() reads
head0 straight from the descriptor:

	head0 = FIELD_GET(FBNIC_TCD_TYPE0_HEAD0_MASK, tcd);

fbnic_clean_twq() then passes it to fbnic_clean_twq0() without checking
it against the posted window. Because clean_desc is masked, the loop
always terminates. But if hw_head is past ring->tail, can the loop walk
into a slot that was never posted?

fbnic_clean_twq0() {
	...
	clean_desc = (hw_head - head) & ring->size_mask;

	while (clean_desc) {
		struct sk_buff *skb = ring->tx_buf[head];
		unsigned int desc_cnt;

		desc_cnt = FBNIC_XMIT_CB(skb)->desc_count;
	...
		ring->tx_buf[head] = NULL;
	...
}

Consumed slots are set to NULL, and only the first slot of a packet ever
holds an skb. So once head reaches tail, or right away if the ring is
empty, skb is NULL and FBNIC_XMIT_CB(skb) dereferences it in NAPI
context.

The later commit "eth: fbnic: bound the XDP Tx completion head to the
ring" in this series fixes the twq1 side. Its commit message says:

  "fbnic_clean_twq0() masks the head difference to the ring and is
  finite"

That holds for termination, but it doesn't cover this NULL dereference
past the tail. Should twq0 get the same window check?

[ ... ]

> @@ -985,14 +1020,25 @@ static void fbnic_pkt_prepare(struct fbnic_napi_vector *nv, u64 rcd,
>  {
>  	unsigned int hdr_pg_idx = FIELD_GET(FBNIC_RCD_AL_BUFF_PAGE_MASK, rcd);
>  	unsigned int hdr_pg_off = FIELD_GET(FBNIC_RCD_AL_BUFF_OFF_MASK, rcd);
> -	struct page *page = fbnic_page_pool_get_head(qt, hdr_pg_idx);
>  	unsigned int len = FIELD_GET(FBNIC_RCD_AL_BUFF_LEN_MASK, rcd);
>  	unsigned int frame_sz, hdr_pg_start, hdr_pg_end, headroom;
>  	unsigned char *hdr_start;
> +	struct page *page;
>  
>  	/* data_hard_start should always be NULL when this is called */
>  	WARN_ON_ONCE(pkt->buff.data_hard_start);

[Severity: Medium]
This is a pre-existing issue. If a second HDR_AL completion arrives
before META, this only warns, and then xdp_init_buff() and
xdp_prepare_buff() overwrite pkt->buff. Does that leak the earlier header
page reference and any frags already attached?

The later commit "eth: fbnic: return a pending Rx packet before reusing
its buffer" in this series fixes this. It calls fbnic_put_pkt_buff() and
clears data_hard_start before the posted-id check, so the leak is gone by
the end of the series.

>  
> +	/* A buffer ID we never posted cannot name a buffer we own, so drop
> +	 * the packet instead of running off the end of rx_buf[] or picking
> +	 * up a slot we have already drained.
> +	 */
> +	if (unlikely(!fbnic_rx_buf_posted(&qt->sub0, hdr_pg_idx))) {
> +		pkt->add_frag_failed = true;
> +		return;
> +	}
> +
> +	page = fbnic_page_pool_get_head(qt, hdr_pg_idx);
> +
>  	/* Short-cut the end calculation if we know page is fully consumed */
>  	hdr_pg_end = FIELD_GET(FBNIC_RCD_AL_PAGE_FIN, rcd) ?
>  		     FBNIC_BD_FRAG_SIZE : fbnic_hdr_pg_end(hdr_pg_off, len);

[Severity: High]
The id is validated now, but hdr_pg_off and len from the same completion
still feed hdr_pg_end, hdr_pg_start, frame_sz and the DMA sync without any
check. Two questions here:

- Can an offset below FBNIC_RX_HROOM underflow fbnic_hdr_pg_start()?
- Can offset plus length push frame_sz and
  dma_sync_single_range_for_cpu() past the FBNIC_BD_FRAG_SIZE fragment?

The later commit "eth: fbnic: validate the Rx completion offset and
length" in this series adds checks for these. The header bound it adds
seems to leave out FBNIC_RX_TROOM, though:

	if (unlikely(hdr_pg_off < FBNIC_RX_HROOM ||
		     hdr_pg_off + len > FBNIC_BD_FRAG_SIZE)) {
	...
	hdr_pg_end = min(hdr_pg_end, FBNIC_BD_FRAG_SIZE);

Take hdr_pg_off = 192 and len = 3904. Then hdr_pg_start is 0 and frame_sz
is 4096. napi_build_skb() puts skb_shared_info at
4096 - FBNIC_RX_TROOM (3776 on x86-64). xdp_build_skb_from_buff() then
does:

	__skb_put(skb, xdp->data_end - xdp->data);

This leaves skb->tail past skb->end, and the packet data overlaps the
shared info.

The CPU writes frags[] netmem pointers, dataref and nr_frags into that
area. Could kernel pointers end up in the payload delivered to the stack?
And could a later skb_put() on this skb trip skb_over_panic()?

That commit's own message gives the legitimate maximum as offset 192 plus
length 3584, which is 4096 - FBNIC_RX_TROOM. Should the check be
hdr_pg_off + len + FBNIC_RX_TROOM > FBNIC_BD_FRAG_SIZE instead?

[ ... ]

> @@ -1026,10 +1072,27 @@ static void fbnic_add_rx_frag(struct fbnic_napi_vector *nv, u64 rcd,

[ ... ]

> +	if (unlikely(!fbnic_rx_buf_posted(&qt->sub1, pg_idx))) {
> +		pkt->add_frag_failed = true;
> +		return;
> +	}
> +
> +	netmem = fbnic_page_pool_get_data(qt, pg_idx);
> +
>  	truesize = FIELD_GET(FBNIC_RCD_AL_PAGE_FIN, rcd) ?
>  		   FBNIC_BD_FRAG_SIZE - pg_off : ALIGN(len, 128);

[Severity: Medium]
This is a pre-existing issue. Further down in fbnic_add_rx_frag(), the
failure path doesn't return the reference taken by
fbnic_page_pool_get_data():

	added = xdp_buff_add_frag(&pkt->buff, netmem, pg_off, len, truesize);
	if (unlikely(!added)) {
		pkt->add_frag_failed = true;
		netdev_err_once(nv->napi.dev,
				"Failed to add fragment to xdp_buff\n");
	}

If the device sends more than MAX_SKB_FRAGS payload completions for one
packet, does this leak the sub1 page?

The later commit "eth: fbnic: return the page reference taken for a
dropped Rx fragment" in this series fixes this. It restores
qt->sub1.rx_buf[pg_idx].pagecnt_bias on the failure path, so the leak is
gone by the end of the series.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1791775409.git.yhlee%40isslab.korea.ac.kr

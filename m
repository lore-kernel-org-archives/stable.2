Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3385F360EF5;
	Sun, 11 Oct 2026 20:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791750162; cv=none; b=KyYXXC1S27q8tq9u9IDpfj84h9W+gSwJrHt0RLxMPTlgfmGNcq/KQQD7EKdqhA/3iaD/d3zJDt2h/Ph/dnAZ6TD1BoDzfD28DpdWvMH2HDL7WzSbRSl0Zo7w4u8leh+HSDlo6v0u1N5QQzhJSWXqBZYSyHf4zRbgySYebdHi5m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791750162; c=relaxed/simple;
	bh=eGiUbWfpQCfGPdKIIoVagFzznM0xjYZTiyEI5jZ2Op8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VM6CKJnIVWcLhUOvBJTP/wOzm8XOZIzQ+fv5tzhuhLezjH9lWeoBUgdTdE/CQb9tRPbGQzv77Pn6R0+LuNe/RPmXc2Zv+gvU4V1Lgmncx7tPhqQx5NFLN/4fQVnEJ56VpMK9vadEySQVZZxY3Yn9tgjnoI51lx8ASD13vhVEit8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h1WrCz8U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h1WrCz8U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1928B1F0089B;
	Sun, 11 Oct 2026 20:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791750160;
	bh=fOujxcO/4jkX+6tx/XZxDjjf05jHLyP4XMfBgsYe3JU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=h1WrCz8U5DxDws8zWTyAJwLZ5JzIMuLAMh13EAgN2bPjMkvajmwwEhP5rpWoNME3l
	 HD/ytpm2NBEB/G//ES6/09VPPsAKluqjS046RBg9G53hoMGyx3+F5DjVvN6lCaP5YL
	 3FjDOVbahLLXj3agvnos4K13Sa+0S0RQk0N4+MF6RTMefCbZkUkAzZYVm+Bmh3QYT5
	 AQ3okJ+5sP4Itmf996AFQHjczmAXdtJQnw9czu8m/6qdqwy4qCsUyUCHhJj9XnfpTK
	 fLh8BhZE24k6CdtAaPn/Xg6+0LHKZbTu4pxSuKRDZXBnfcgG37RTnoLDDmc+kexsOl
	 Kf5Xti/n59WVA==
Subject:
 Re: [PATCH net v2 1/2] eth: fbnic: validate the Rx completion buffer index
From: netdev-bot+sashiko@kernel.org
To: yhlee@isslab.korea.ac.kr
Cc: alexanderduyck@fb.com, kuba@kernel.org, netdev@vger.kernel.org,
 kernel-team@meta.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org, daskald@meta.com,
 mohsin.bashr@gmail.com, bobbyeshleman@meta.com, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Sun, 11 Oct 2026 20:22:39 +0000
Message-ID: <179175015961.434549.3888861023391952248@kernel.org>
In-Reply-To: =?utf-8?q?=3C5c05a7f423b5a0dd5e30d7dd8bac268da1289538=2E1791659?=
 =?utf-8?q?860=2Egit=2Eyhlee=40isslab=2Ekorea=2Eac=2Ekr=3E?=
References: =?utf-8?q?=3C5c05a7f423b5a0dd5e30d7dd8bac268da1289538=2E17916598?=
 =?utf-8?q?60=2Egit=2Eyhlee=40isslab=2Ekorea=2Eac=2Ekr=3E?=
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

Critical: 0 · High: 2 (2) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new checks only test that the device-supplied buffer ID or
  head fits inside rx_buf[] (`<= size_mask`).
- [High] A META completion with no HDR_AL completion before it still
  builds an skb on a NULL buffer.
- [Medium] fbnic_clean_rcq() sets head0/head1 from the raw descriptor
  (lines 1318 and 1323) before fbnic_pkt_prepare()/fbnic_add_rx_frag()…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but
  fbnic_clean_twq1() has the same 'masked running index never reaches an…
- [High] This problem wasn't introduced by this patch, but the sibling
  fields of the same untrusted Rx completion descriptor are still…

--

I found five issues in this patch:

- Three are regressions or incomplete fixes, rated High, High and Medium.
- Two are High-severity problems that already existed before the patch and are related to it.

The main gap is that the new checks only test whether an index fits the rx_buf[] array. They don't test whether the slot was actually posted, so empty in-range slots can still reach a NULL dereference. A bare metadata completion can also still build an skb on a NULL buffer.

eth: fbnic: validate the Rx completion buffer index

This patch checks the device-supplied buffer ID in Rx address/length
completions against the BDQ size_mask in fbnic_pkt_prepare() and
fbnic_add_rx_frag(). It also bounds the reported head in
fbnic_clean_bdq(). Finally, it marks the packet as failed when a payload
completion arrives without a header completion before it.

> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> index 10caacffee0f0..b4ca9f7e8bb2e 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> @@ -882,6 +882,13 @@ static void fbnic_clean_bdq(struct fbnic_ring *ring, unsigned int hw_head,
>  {
>  	unsigned int head = ring->head;
>  
> +	/* A head outside the ring cannot name a buffer we posted, and the
> +	 * loop below masks head to the ring so it would never reach it.
> +	 * Leave the ring alone and wait for a head we can act on.
> +	 */
> +	if (unlikely(hw_head > ring->size_mask))
> +		return;

[Severity: Medium]
Can this early return throw away valid progress from earlier in the same
poll?

fbnic_clean_rcq() records head0/head1 straight from the descriptor. It
does this before fbnic_pkt_prepare() or fbnic_add_rx_frag() has a chance
to reject the ID:

fbnic_clean_rcq() {
    ...
		case FBNIC_RCD_TYPE_HDR_AL:
			head0 = FIELD_GET(FBNIC_RCD_AL_BUFF_PAGE_MASK, rcd);
			fbnic_pkt_prepare(nv, rcd, pkt, qt);
    ...
	if (head0 >= 0)
		fbnic_clean_bdq(&qt->sub0, head0, budget);
	fbnic_fill_bdq(&qt->sub0);
    ...
}

If the last HDR_AL or PAY_AL of a poll carries a bad ID, it overwrites
any valid head recorded earlier in that poll. fbnic_clean_bdq() then
reclaims nothing.

On a full ring whose ring->head does not advance, fbnic_desc_unused()
returns 0, so fbnic_fill_bdq() posts nothing.

Suppose the device has already used up its posted buffers when it emits
the bad ID, or it keeps emitting bad IDs. Would a valid head ever arrive?
If not, the Rx queue could stall until reset, and the only sign would be
the dropped counter.

Would validating the ID in fbnic_clean_rcq() before assigning
head0/head1 keep the earlier progress? That would also match the
per-packet drop the patch uses elsewhere.

[Severity: High]
This isn't a bug introduced by this patch, but fbnic_clean_twq1() looks
like it has the same masked-index loop problem the commit message
describes for fbnic_clean_bdq():

fbnic_clean_tcq() {
    ...
		case FBNIC_TCD_TYPE_0:
			if (tcd & FBNIC_TCD_TWQ1)
				head1 = FIELD_GET(FBNIC_TCD_TYPE0_HEAD1_MASK,
						  tcd);
    ...
}

fbnic_clean_twq1() {
    ...
	while (hw_head != head) {
		...
		page_pool_put_page(pp_page_to_nmdesc(page)->pp, page, -1,
				   pp_allow_direct);
next_desc:
		head++;
		head &= ring->size_mask;
	}
    ...
}

FBNIC_TCD_TYPE0_HEAD1_MASK is DESC_GENMASK(31, 16), so head1 can be as
large as 65535. The default Tx ring has 1024 entries.

If HEAD1 is above sub1.size_mask, does this loop ever end in NAPI
context? Neither tx_buf[] nor the descriptors are cleared. Each pass
would therefore call page_pool_put_page() again on the same XDP_TX pages.

fbnic_clean_twq0() does not seem to have this problem, because it
computes clean_desc as (hw_head - head) & size_mask.

> +
>  	if (head == hw_head)
>  		return;
>  

[ ... ]

> @@ -985,14 +992,24 @@ static void fbnic_pkt_prepare(struct fbnic_napi_vector *nv, u64 rcd,
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
>  
> +	/* A buffer ID the device never got from us cannot name a buffer we
> +	 * own, so drop the packet instead of running off the end of rx_buf[].
> +	 */
> +	if (unlikely(hdr_pg_idx > qt->sub0.size_mask)) {
> +		pkt->add_frag_failed = true;
> +		return;
> +	}
> +
> +	page = fbnic_page_pool_get_head(qt, hdr_pg_idx);

[Severity: High]
Does this check cover the "never posted" case that the comment and the
commit message describe? It only checks the rx_buf[] array bound. It
does not check that the slot is in the posted window between ring->head
and ring->tail.

Slots outside that window have netmem == 0, for three reasons:

- fbnic_page_pool_drain() clears netmem on every slot it consumes, and
  rx_buf[] starts out zeroed.
- fbnic_fill_bdq() never fills slot (head - 1), because
  fbnic_desc_unused() returns (head - tail - 1) & size_mask.
- fbnic_fill_bdq() also stops early when page_pool_dev_alloc_netmems()
  fails.

With hdr_pg_idx == (sub0.head - 1) & size_mask, the new check passes.
fbnic_page_pool_get_head() then returns netmem_to_page(0), which is NULL.
Would page_pool_get_dma_addr(page) and page_address(page) then
dereference NULL?

fbnic_add_rx_frag() has the same gap for sub1. There, netmem 0 is passed
to page_pool_dma_sync_netmem_for_cpu() and xdp_buff_add_frag().

The new fbnic_clean_bdq() guard has a similar limit. Take a ring where
fbnic_fill_bdq() stopped early, say size_mask = 255, head = 10 and
tail = 200. An in-range hw_head of 250 passes the new check. The loop
drains slots 10..199, reaches slot 200, whose netmem is 0, and calls
page_pool_unref_netmem() on it:

fbnic_page_pool_drain() {
	...
	netmem_ref netmem = rx_buf->netmem;

	if (!page_pool_unref_netmem(netmem, rx_buf->pagecnt_bias))
	...
}

Wouldn't that reproduce the "null-ptr-deref in fbnic_clean_bdq" splat
quoted in the commit message? It would also move ring->head past
ring->tail.

Would checking against the posted window, for example
((idx - ring->head) & size_mask) < fbnic_desc_used(ring), cover both
the buffer ID and the hw_head cases?

>  	/* Short-cut the end calculation if we know page is fully consumed */
>  	hdr_pg_end = FIELD_GET(FBNIC_RCD_AL_PAGE_FIN, rcd) ?
>  		     FBNIC_BD_FRAG_SIZE : fbnic_hdr_pg_end(hdr_pg_off, len);

[Severity: High]
This is a pre-existing issue, but the other fields of the same untrusted
completion descriptor are still unchecked.

FBNIC_RCD_AL_BUFF_OFF_MASK is 12 bits and FBNIC_RCD_AL_BUFF_LEN_MASK is
13 bits. A buffer fragment is FBNIC_BD_FRAG_SIZE, which is 4096 bytes.

fbnic_hdr_pg_start() does unsigned arithmetic:

fbnic_hdr_pg_start() {
	...
	return pg_off - FBNIC_RX_HROOM;
}

Suppose the offset is below FBNIC_RX_HROOM and is not the special-cased
ALIGN(FBNIC_RX_HROOM, 128). Does hdr_pg_start then wrap to about 4G?
That value feeds dma_sync_single_range_for_cpu() and
hdr_start = page_address(page) + hdr_pg_start.

An oversized len would push data_end past the page through
xdp_prepare_buff(). It would also enlarge frame_sz, so the shared info
written by __build_skb_around() or xdp_buff_add_frag() would land outside
the fragment.

fbnic_add_rx_frag() has a similar gap: truesize and len are not clamped
to FBNIC_BD_FRAG_SIZE - pg_off before the DMA sync and
xdp_buff_add_frag().

[ ... ]

> @@ -1026,10 +1043,27 @@ static void fbnic_add_rx_frag(struct fbnic_napi_vector *nv, u64 rcd,
>  	unsigned int pg_idx = FIELD_GET(FBNIC_RCD_AL_BUFF_PAGE_MASK, rcd);
>  	unsigned int pg_off = FIELD_GET(FBNIC_RCD_AL_BUFF_OFF_MASK, rcd);
>  	unsigned int len = FIELD_GET(FBNIC_RCD_AL_BUFF_LEN_MASK, rcd);
> -	netmem_ref netmem = fbnic_page_pool_get_data(qt, pg_idx);
>  	unsigned int truesize;
> +	netmem_ref netmem;
>  	bool added;
>  
> +	/* No header completion has set buff up, either because one was
> +	 * rejected or because the device sent none, so there is nothing to
> +	 * add a fragment to.  Mark the packet so the metadata descriptor
> +	 * drops it instead of building an skb on an empty buffer.
> +	 */
> +	if (unlikely(!pkt->buff.data_hard_start)) {
> +		pkt->add_frag_failed = true;
> +		return;
> +	}

[Severity: High]
This only runs when a PAY_AL completion arrives. What happens when the
device sends a META completion with no HDR_AL before it?

After the previous packet's META, fbnic_clean_rcq() sets
pkt->buff.data_hard_start to NULL. add_frag_failed keeps the false value
left by the last successful fbnic_pkt_prepare(). After fbnic_nv_flush(),
the whole pkt is zeroed. Either way, a bare META still passes the good
packet test:

fbnic_clean_rcq() {
    ...
		case FBNIC_RCD_TYPE_META:
			if (likely(!fbnic_rcd_metadata_err(rcd) &&
				   !pkt->add_frag_failed)) {
				pkt_bytes = xdp_get_buff_len(&pkt->buff);
				skb = fbnic_run_xdp(nv, pkt);
			}
    ...
}

With no XDP program attached, this goes
fbnic_build_skb()->xdp_build_skb_from_buff()->napi_build_skb() with a
NULL data_hard_start and a stale frame_sz. Isn't that the same
"null-ptr-deref in __build_skb_around" the commit message says it fixes?

With an XDP program attached, would the program run on the previous
packet's data/data_end? That buffer has already been handed to the stack
or recycled to the page_pool.

Should the META case check pkt->buff.data_hard_start itself?

> +
> +	if (unlikely(pg_idx > qt->sub1.size_mask)) {
> +		pkt->add_frag_failed = true;
> +		return;
> +	}
> +
> +	netmem = fbnic_page_pool_get_data(qt, pg_idx);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1791659860.git.yhlee%40isslab.korea.ac.kr

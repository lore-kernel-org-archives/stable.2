Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677A730CD95;
	Sat, 10 Oct 2026 18:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791655559; cv=none; b=Pcyq5q+Oy8wQHcvskzv8WVaxr3iAr4bu5Dbs/WS8/3atKIHRqzS17s9NdqF+8EimjiBG0f/lOrn2eqYPN17v4AA38tsIEalBO1vyJMuHaxnY6OUc/HJYov2L5w/TdKwEX90IUFD1x/BihZGUgJoqlY2SaDDaXvSOE6s96KJJKsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791655559; c=relaxed/simple;
	bh=VErKEckSacCuCVEqpz5N3YByojM3VsG8ykn3X2VTdlQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bvgJ/KkEnhgKtD8HXmDtnWppWlI+8UXaTCn/6V9JEMdL3J1GjlAPvfmyOB9xmoAlxPq4GXcGbPcrBHlUTNHo4e6p45nXFzeLI02aKc0He8bdvkZ0ww7nT8/APCchw3YGc0i3VtcmA0pLmYY3jR6ni1F6ljBSyP5MKShXv9F/5Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GqITr1Pa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GqITr1Pa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28DA41F000FF;
	Sat, 10 Oct 2026 18:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791655558;
	bh=CKufVa8PUWT5kdt1Yj6aF7/iEqXWShP+fMpxSTA6Vzc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GqITr1PaYV+HzFBD9gWLPi04HKORcFJKmz4V+V6dCzqzTvDE+jK1olHC2V/NmzdlO
	 IG0E/gronAlMJ/1ltbiJBJc+1bHvRwDvKNbAN4zNJmiJA8xl99trQ5rTvYIPwW7++A
	 IVuJ0zvYODBS7U4s3QYVhSBPP/MCp++pYfjd40x4rVCzQWS2JP7jGl3W6DI9utBG+p
	 EO6TdL/V+VP3m1f1yFI7RMK4oFiaa5iElU+Fz9Gshk5FgJCbQp+HtyrcbgaFguS1ze
	 JenheB6IWGmneHVd8cqU8SqbEAvVsGrAjjnECa0n75scfWaWaIC13n+nqpfMzsTlNb
	 gzW4XlFBGFlKw==
Subject: Re: [PATCH net] eth: fbnic: validate the Rx completion buffer index
From: netdev-bot+sashiko@kernel.org
To: yhlee@isslab.korea.ac.kr
Cc: alexanderduyck@fb.com, kuba@kernel.org, netdev@vger.kernel.org,
 kernel-team@meta.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org, daskald@meta.com,
 mohsin.bashr@gmail.com, bobbyeshleman@meta.com, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Sat, 10 Oct 2026 18:05:56 +0000
Message-ID: <179165555662.434549.7573121362042133650@kernel.org>
In-Reply-To: <20261009175358.1598001-1-yhlee@isslab.korea.ac.kr>
References: <20261009175358.1598001-1-yhlee@isslab.korea.ac.kr>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 2 (1) · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch does not fix the injection case its commit message
  describes.
- [High] eth: fbnic: uninitialized buffer dereference when payload
  descriptor arrives without header descriptor
- [Medium] The new guards `hdr_pg_idx > qt->sub0.size_mask`
  (fbnic_pkt_prepare(), line 999) and `pg_idx > qt->sub1.size_mask`…
- [Medium] eth: fbnic: memory leak of netmem fragment when
  xdp_buff_add_frag() fails

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it is a
  memory-corruption bug on the same malformed-completion path the patch…

--

eth: fbnic: validate the Rx completion buffer index

This patch checks the buffer ID from address/length Rx completions
against the BDQ size_mask in fbnic_pkt_prepare() and fbnic_add_rx_frag().
An out-of-range ID sets add_frag_failed so the frame is dropped.
fbnic_add_rx_frag() also returns early when the header completion was
rejected and pkt->buff.data_hard_start is still NULL.

> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> index 10caacffee0f0..d85daab06c99c 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> @@ -985,14 +985,24 @@ static void fbnic_pkt_prepare(struct fbnic_napi_vector *nv, u64 rcd,
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

[Severity: High]
Does this rejection stop the injected out-of-range completion described
in the commit message? The caller stores the raw ID before it calls
in here, and nothing resets it when the check fails:

drivers/net/ethernet/meta/fbnic/fbnic_txrx.c:fbnic_clean_rcq() {
    ...
		case FBNIC_RCD_TYPE_HDR_AL:
			head0 = FIELD_GET(FBNIC_RCD_AL_BUFF_PAGE_MASK, rcd);
			fbnic_pkt_prepare(nv, rcd, pkt, qt);
    ...
	if (head0 >= 0)
		fbnic_clean_bdq(&qt->sub0, head0, budget);
    ...
}

So a head0 of 65535 still reaches fbnic_clean_bdq() as hw_head:

fbnic_clean_bdq() {
    ...
	do {
		fbnic_page_pool_drain(ring, head, napi_budget);

		head++;
		head &= ring->size_mask;
	} while (head != hw_head);
    ...
}

Because head is masked to [0, size_mask], it can never equal an hw_head
above size_mask. Does this loop ever terminate?

As the loop runs, fbnic_page_pool_drain() hands buffers that are still
posted to the device back to the page_pool, and the device can still DMA
into them.

The ring always keeps at least one slot unposted. fbnic_desc_unused()
returns (head - tail - 1) & size_mask, and that slot has
rx_buf->netmem == 0. When the loop reaches it,
page_pool_unref_netmem(0, ...) dereferences
netmem_to_nmdesc(0)->pp_ref_count.

Wouldn't the KASAN injection test from the commit message still oops in
NAPI softirq, just later in the poll?

head1 has the same problem: FBNIC_RCD_TYPE_PAY_AL stores it before the
new check in fbnic_add_rx_frag() runs, and fbnic_clean_bdq(&qt->sub1,
head1, budget) uses it afterwards.

Could the ID be validated in fbnic_clean_rcq() before head0/head1 are
updated? Alternatively, the helpers could return a bool and the heads
could be updated only on success.

> +
> +	page = fbnic_page_pool_get_head(qt, hdr_pg_idx);

[Severity: Medium]
The new comment says "A buffer ID the device never got from us cannot
name a buffer we own". The commit message says the arrays "only cover
the buffers the driver posted". Are those statements accurate?

rx_buf[] has size_mask + 1 entries, and at least one of them is never
posted. fbnic_desc_unused() always leaves one slot free. fbnic_fill_bdq()
also stops early when page_pool_dev_alloc_netmems() fails. These slots
have rx_buf->netmem == 0, either from kvzalloc() or from the
rx_buf->netmem = 0 in fbnic_page_pool_drain().

A completion that names one of these in-range slots passes the size_mask
check. fbnic_page_pool_get_head() then decrements pagecnt_bias on the
empty slot and returns netmem_to_page(0), which is NULL.

Can that NULL page then be dereferenced by page_pool_get_dma_addr(page)
and page_address(page) later in fbnic_pkt_prepare()?

The payload side in fbnic_add_rx_frag() looks the same: netmem 0 would
be passed to page_pool_dma_sync_netmem_for_cpu() and
xdp_buff_add_frag().

Should the check also confirm that the slot was posted? For example, it
could test !qt->sub0.rx_buf[idx].netmem, or check the index against the
[ring->head, ring->tail) window.

> +
>  	/* Short-cut the end calculation if we know page is fully consumed */
>  	hdr_pg_end = FIELD_GET(FBNIC_RCD_AL_PAGE_FIN, rcd) ?
>  		     FBNIC_BD_FRAG_SIZE : fbnic_hdr_pg_end(hdr_pg_off, len);

[Severity: High]
This isn't a bug introduced by this patch, but it is on the same
malformed-completion path the patch hardens. Is len or hdr_pg_off
checked against the fragment size anywhere?

FBNIC_RCD_AL_BUFF_LEN_MASK is DESC_GENMASK(28, 16), so len can be as
large as 8191. FBNIC_BD_FRAG_SIZE is 4096.

As an example, take an in-range, posted header ID with
hdr_pg_off = 256, len = 8191 and PAGE_FIN clear. On x86_64 with 4K
pages (FBNIC_RX_TROOM = 320, FBNIC_RX_HROOM = 192):

    fbnic_hdr_pg_end(256, 8191) = ALIGN(256 + 8191 + 320 + 192, 128) - 192
                                = 8768
    fbnic_hdr_pg_start(256)     = 0
    frame_sz                    = 8768

Nothing compares frame_sz with the page size. As a result,
dma_sync_single_range_for_cpu() runs past the mapping, and
xdp_get_shared_info_from_buff() places skb_shared_info at
data_hard_start + 8448, well past the end of the 4096-byte page.

A following valid PAY completion passes both new checks and reaches
__xdp_buff_add_frag(). That function writes sinfo->xdp_frags_size,
nr_frags and frags[] through that pointer. On the META path,
xdp_build_skb_from_buff() builds the skb with the same frame_sz and
initializes the shared info outside the page.

Separately, an hdr_pg_off below FBNIC_RX_HROOM (other than the special
case in fbnic_hdr_pg_start()) makes fbnic_hdr_pg_start() underflow.

[ ... ]

> @@ -1026,10 +1036,23 @@ static void fbnic_add_rx_frag(struct fbnic_napi_vector *nv, u64 rcd,
>  	unsigned int pg_idx = FIELD_GET(FBNIC_RCD_AL_BUFF_PAGE_MASK, rcd);
>  	unsigned int pg_off = FIELD_GET(FBNIC_RCD_AL_BUFF_OFF_MASK, rcd);
>  	unsigned int len = FIELD_GET(FBNIC_RCD_AL_BUFF_LEN_MASK, rcd);
> -	netmem_ref netmem = fbnic_page_pool_get_data(qt, pg_idx);
>  	unsigned int truesize;
> +	netmem_ref netmem;
>  	bool added;
>  
> +	/* The header completion was rejected, so buff was never initialized
> +	 * and add_frag_failed is already set.  There is nothing to add to.
> +	 */
> +	if (unlikely(!pkt->buff.data_hard_start))
> +		return;
> +
> +	if (unlikely(pg_idx > qt->sub1.size_mask)) {
> +		pkt->add_frag_failed = true;
> +		return;
> +	}
> +
> +	netmem = fbnic_page_pool_get_data(qt, pg_idx);
> +
>  	truesize = FIELD_GET(FBNIC_RCD_AL_PAGE_FIN, rcd) ?
>  		   FBNIC_BD_FRAG_SIZE - pg_off : ALIGN(len, 128);
>  

[Severity: Medium]
This isn't a bug introduced by this patch. Since this hunk moves the
fbnic_page_pool_get_data() call, though, what happens to the reference
it takes when xdp_buff_add_frag() fails further down in this function?

fbnic_page_pool_get_data() decrements rx_buf->pagecnt_bias, which
transfers one page_pool reference to the fragment. xdp_buff_add_frag()
can then return false, for example because the frame already carries
MAX_SKB_FRAGS fragments. In that case the code sets add_frag_failed
and logs the error, but netmem was never attached to pkt->buff.

The drop path in fbnic_put_pkt_buff() only walks the fragments that
are recorded in the shared info, so it never releases this one. Later,
fbnic_page_pool_drain() only drops the remaining pagecnt_bias for the
slot. Doesn't that leave one reference on the page that nobody will
ever drop, so the page is never returned to qt->sub1.page_pool?

Should the failure path hand the reference back? It could restore
rx_buf->pagecnt_bias for that slot, or release netmem to
qt->sub1.page_pool the way fbnic_put_pkt_buff() does for attached
fragments. That probably belongs in a separate fix.

[Severity: High]
The new comment says add_frag_failed is already set whenever
data_hard_start is NULL here. Is a rejected header completion the only
way to reach this point with a NULL data_hard_start?

Suppose the device sends a PAY_AL completion without a preceding HDR_AL
completion. Then fbnic_pkt_prepare() never ran for this frame. As far
as I can see, add_frag_failed is only written by fbnic_pkt_prepare()
and fbnic_add_rx_frag(). It therefore still holds whatever the previous
frame left behind, which is false after any frame that completed
normally.

This early return then leaves it false. When the META completion
arrives, fbnic_clean_rcq() sees !pkt->add_frag_failed and calls
xdp_get_buff_len() and fbnic_run_xdp() on an xdp_buff that was never
initialized for this frame. data_hard_start is NULL and the other
fields are left over from the previous frame. Wouldn't
xdp_build_skb_from_buff() then hand that NULL buffer to
__build_skb_around()?

Before this patch, the same sequence crashed in xdp_buff_add_frag(),
so the crash isn't new. However, the comment now documents an
invariant that the code doesn't enforce. The point of the patch is to
survive a misbehaving device, so could this early return also set
pkt->add_frag_failed = true?

A META completion with no HDR_AL before it would reach fbnic_run_xdp()
the same way, without passing through fbnic_add_rx_frag() at all.
Would it be more robust to also check pkt->buff.data_hard_start in the
FBNIC_RCD_TYPE_META case of fbnic_clean_rcq()?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009175358.1598001-1-yhlee%40isslab.korea.ac.kr

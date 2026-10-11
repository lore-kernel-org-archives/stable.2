Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874123876D5;
	Sun, 11 Oct 2026 20:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791750163; cv=none; b=reswy602hqkyMu9v3qOLqo/KGYIJXRgsb0kDKq4zSA/XeXQ2S1ic7Rwtyv0503MXm8gmDrW1ox5VRZYQY9HFyXLmCLcAgzIjNBjWCxI7/Y4o3gMBNS33Ss/25vD1v0oPYs1EOY0fMNjqUh0UMu1UWJwWJBlO8FPG2W8iWvThYys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791750163; c=relaxed/simple;
	bh=Grp5wMGxwoD3roPDxCWIS48obqzm7/Wjam0MlNUArCg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EHs6er9kBmW2kRPKAtMWfsvOwFcu8SfyQR5PGfdR1aF+3XM1EjyzVnK7L/8ZMmG06UbFzRBf//gAdQ190xZEtA8rdRiGJSo1Iha4vA/fIvuI/oWlySg1loPzv32CDHDrW56f8CHoVnJd2zwKBaDm6kBptBqid3GhmRT7Nogmpko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RxJojhUf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RxJojhUf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DCF31F0089C;
	Sun, 11 Oct 2026 20:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791750162;
	bh=JwFNo1jSshDaw7CI1TXs8YLlCOnlboRNo6+TCGY9qDY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RxJojhUfyN8p25njqCm4Fdw/xzM/VSNJh64/a11dVoY8ihw6z0M2GfpiVyYS7IjI/
	 SFPZb3o3lQ1LXJC0XcgvEPv1iEHsOuc0IjmYHhxhSVXePK8QBnFxfSrkyVe3T27WQU
	 kHz1rBXDqZG24C9PxB/3ShNGoquNzamzmaWjEg8daDIlKeAwmytl/SRkpMtcUZReL9
	 ij4M316W0i+bmszthMO6YaHw6+lVfqJxSMmHEUHo0y9RgoUYns2owhQjFC6akFG11M
	 9JFTDjcD3uHghYILuyXjEGn+SSua+RQq8NBo0bMMlX6W5RU1oxOTJjNtsnLW7k+J7C
	 lsmtaf93ovuGw==
Subject: Re: [PATCH net v2 2/2] eth: fbnic: return the page reference taken
 for a dropped Rx fragment
From: netdev-bot+sashiko@kernel.org
To: yhlee@isslab.korea.ac.kr
Cc: alexanderduyck@fb.com, kuba@kernel.org, netdev@vger.kernel.org,
 kernel-team@meta.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org, daskald@meta.com,
 mohsin.bashr@gmail.com, bobbyeshleman@meta.com, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Sun, 11 Oct 2026 20:22:41 +0000
Message-ID: <179175016106.434549.17893353841904698919@kernel.org>
In-Reply-To: =?utf-8?q?=3C57e762aa85874571b506e5b5a55004029b4b2a5d=2E1791659?=
 =?utf-8?q?860=2Egit=2Eyhlee=40isslab=2Ekorea=2Eac=2Ekr=3E?=
References: =?utf-8?q?=3C57e762aa85874571b506e5b5a55004029b4b2a5d=2E17916598?=
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] A device-supplied buffer ID that is in range but names a slot
  holding no buffer still causes a NULL netmem dereference.

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but a second
  header completion leaks pages.

--

eth: fbnic: return the page reference taken for a dropped Rx fragment

When xdp_buff_add_frag() fails in fbnic_add_rx_frag(), this patch restores
the sub1 rx_buf pagecnt_bias. The page reference that
fbnic_page_pool_get_data() took for a fragment past MAX_SKB_FRAGS is then
returned to the page pool by fbnic_page_pool_drain().

> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> index b4ca9f7e8bb2e..ba663fe7598f1 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> @@ -1076,6 +1076,8 @@ static void fbnic_add_rx_frag(struct fbnic_napi_vector *nv, u64 rcd,
>  
>  	added = xdp_buff_add_frag(&pkt->buff, netmem, pg_off, len, truesize);
>  	if (unlikely(!added)) {
> +		/* Give back the reference fbnic_page_pool_get_data() took */
> +		qt->sub1.rx_buf[pg_idx].pagecnt_bias++;
>  		pkt->add_frag_failed = true;
>  		netdev_err_once(nv->napi.dev,
>  				"Failed to add fragment to xdp_buff\n");

[Severity: High]
The new line runs only after netmem has already been used. That raises a
question about the buffer ID check earlier in this function.

The previous patch in this series, "eth: fbnic: validate the Rx completion
buffer index", added only an upper bound check in fbnic_add_rx_frag():

	if (unlikely(pg_idx > qt->sub1.size_mask)) {
		pkt->add_frag_failed = true;
		return;
	}

	netmem = fbnic_page_pool_get_data(qt, pg_idx);

fbnic_pkt_prepare() has the same kind of check on hdr_pg_idx against
qt->sub0.size_mask. Its comment says:

	/* A buffer ID the device never got from us cannot name a buffer we
	 * own, so drop the packet instead of running off the end of rx_buf[].
	 */

Can an in-range ID still name a slot that holds no buffer?

rx_buf[] comes from kvzalloc(), and fbnic_fill_bdq() only posts
fbnic_desc_unused() slots:

	return (ring->head - ring->tail - 1) & ring->size_mask;

So the slot at ring->tail is never posted. fbnic_page_pool_drain() also
clears every slot it drains:

	rx_buf->netmem = 0;

If a PAY_AL completion names sub1.tail, fbnic_page_pool_get_data() returns
0. Would the dereference of NULL then happen in NAPI context? It could
happen in page_pool_dma_sync_netmem_for_cpu(), or along this path:

xdp_buff_add_frag()->netmem_is_pfmemalloc()->page_is_pfmemalloc(NULL)

The HDR_AL case looks similar. If the completion names sub0.tail,
fbnic_page_pool_get_head() returns netmem_to_page(0), which is NULL. In
fbnic_pkt_prepare(), the dma_sync_single_range_for_cpu() call then passes
page_pool_get_dma_addr(page), which dereferences it.

fbnic_clean_bdq() also checks hw_head only against size_mask. Suppose
fbnic_fill_bdq() left extra slots unposted after a page_pool allocation
failure. Could an in-range hw_head past tail make the drain loop call
page_pool_unref_netmem(0, ...)? That would be the same null-ptr-deref that
the earlier commit message says it fixes.

An in-range ID that names a slot which was drained and refilled would
instead attach a recycled page_pool page. The device never wrote that page
for this packet.

Should the check also require rx_buf[idx].netmem to be non-zero, or idx to
fall inside the posted window between ring->head and ring->tail?

[Severity: Medium]
This is a pre-existing issue and was not introduced by this patch. It is a
separate path from the xdp_buff_add_frag() failure fixed here. Can a second
header completion leak the pages of the packet that is still pending?

fbnic_clean_rcq() calls fbnic_pkt_prepare() for every
FBNIC_RCD_TYPE_HDR_AL completion. Only the FBNIC_RCD_TYPE_META case sets
pkt->buff.data_hard_start back to NULL. fbnic_pkt_prepare() warns about a
pending packet but carries on:

	/* data_hard_start should always be NULL when this is called */
	WARN_ON_ONCE(pkt->buff.data_hard_start);
	...
	page = fbnic_page_pool_get_head(qt, hdr_pg_idx);
	...
	xdp_init_buff(&pkt->buff, frame_sz, &qt->xdp_rxq);
	...
	xdp_prepare_buff(&pkt->buff, hdr_start, headroom,
			 len - FBNIC_RX_PAD, true);
	...
	pkt->add_frag_failed = false;

Say the device sends HDR_AL, then some PAY_AL, then a second HDR_AL with no
META in between. The second HDR_AL has these effects:

- xdp_init_buff() clears XDP_FLAGS_HAS_FRAGS.
- xdp_prepare_buff() replaces data_hard_start. This also moves the shinfo
  that xdp_get_shared_info_from_buff() finds.
- add_frag_failed is reset.

At the next META, fbnic_put_pkt_buff() only releases what the current
pkt->buff describes. The earlier head page and all sub1 fragments already
attached to it can no longer be reached. That includes fragments of a
packet that already hit the MAX_SKB_FRAGS failure handled in this patch.

Each of those references was already subtracted from pagecnt_bias. Does
this leave fbnic_page_pool_drain() one short for each lost reference? If
so, the pages never return to the pool and are still counted as inflight
when the pool is destroyed.

The warn-and-continue logic seems to date back to a29b8eb6e533 ("eth:
fbnic: Add basic Rx handling"). The shinfo frag tracking came in with
61f9a066c309 ("eth: fbnic: Use shinfo to track frags state on Rx").

One option would be to call fbnic_put_pkt_buff() on a stale pending packet
before the new one is prepared. That would be a separate change from this
one.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1791659860.git.yhlee%40isslab.korea.ac.kr

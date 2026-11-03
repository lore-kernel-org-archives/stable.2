Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793742974;
	b=GhYvR1DBsD+pvCGFFVzsPlH1e5W94AncdyDGVo7RSApG49lDiX9+udxJe9xTbs5BKjak
	 jMHfzNpylwThghqlcm/OjDvn7VOTAhTJVFzEuDzrOfY2BTNiFOc8xfjqKwdavG+lQXol9
	 fQujb2wxrnmBfqr//SzOfO1mdJrAaPJmSWE8W1qBvWyXenSah1rRxTUcdSQ8G0UeSEcNL
	 Wx0GUzJvRgjVw2bNpVQiAkueDbeHGPbc4xVi6VchH9Krw8CAEm2WhGyVUemYYKoE3UUo5
	 S8c4VKxnb2oRRuOnEtR+7SciLv4Be0GpVDGDhDUGVjuCEObEgUQ6X7JrlN49lcKQ/rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793742974;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=oeJF8aYxxD8BZqjwEQqWSZiARQ0h/lpcOUQiKQJRU+8=;
	b=eGUp4UlCIoLZDlbmBwIPc7lPXfF6UVdGoE3zW8v2UUHVh184cKH1sMnMOmgpmNbZZRXx
	 STJT4UG21xw0PcHC2Mz509d0dM23Lsh7KXVEWvdLxhDXaJ2dhJhlv+1l3enc+ca7IxHRb
	 dSV3Y7r0UaJ2XPULDaMywpT5OOp9SGq3742lR9NoaC1f6G5H5+RCGZoD5vZyW2ox/x1fX
	 Yey2+LNxw+rLcrosRWuH2ATLVpbTtUgWRTe4tJSh1bOHg7r7Daap70h8bOSUy8UQr1wgT
	 pqGtNL6v/l4y0SMhwynhWuuc7Ogt8xiDcCOMq5VuRMnxUZpkCxsDBQzvwJVVwcHGbQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hFYGX2DO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CA3606A324;
	Tue,  3 Nov 2026 21:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hFYGX2DO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E6281F000C1;
	Tue,  3 Nov 2026 21:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793742973;
	bh=oeJF8aYxxD8BZqjwEQqWSZiARQ0h/lpcOUQiKQJRU+8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hFYGX2DO2rT5zi1fI/bB4jwybkDtTCQJBYmajEbY6jfx46OEx1qvX5reQeAL1+XEi
	 AhoPCYNl+6WFuOeE7RW1BJFjPsiAjX8quXA2zw27NNDWon2U2oOUrlOZhijX8AjdkW
	 xBr8wT+ytRrIKKUjpCkXXIqGk1cFCDKNwLKbaVR9jfQG2ajO1o9ukM3Qusc8MyexSj
	 eXFrUlDYWCKAmglC6aJX6TvriOK5/l5zAPPnUWubQ3x4qRxnVduVsnq6ZNC1xCZZo4
	 TupNhtdCyuCXXhDtBncW/dQ2PvjfWmD3+lNrPN98YgzRngF0eVxmW1w2E0ABeXF0N5
	 G1olaUH6UW9/Q==
Subject: Re: [PATCH net v2] net: atl1c: free the RX buffer when the descriptor
 reports an error
From: netdev-bot+sashiko@kernel.org
To: federico@rimpianto.com
Cc: chris.snook@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Tue, 03 Nov 2026 21:56:12 +0000
Message-ID: <179374297269.488856.7749172366095110113@kernel.org>
In-Reply-To: <20261102215253.68185-1-federico@rimpianto.com>
References: <20261102215253.68185-1-federico@rimpianto.com>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 (3) · Medium: 2 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new error-path free can release a buffer the device still
  owns when a stale RRD is processed after a reset.
- [Medium] The patch converts only one of the two decodes of the same RFD
  index.
- [Medium] The leak fix covers only single-RFD frames.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the patch
  edits this exact branch.
- [High] This problem wasn't introduced by this patch, but the new error-
  path unmap/free adds another site exposed to it.
- [High] This problem wasn't introduced by this patch, but the patch
  notes rely on the same state.
- [Medium] This problem wasn't introduced by this patch.

--

net: atl1c: free the RX buffer when the descriptor reports an error

Before this commit, atl1c_clean_rx() only recycled the RFD for a return
descriptor flagged RRS_RX_ERR_SUM or RRS_802_3_LEN_ERR. Now it also
unmaps and frees the skb on that path. The RFD index lookup and DMA unmap
move into a new helper, atl1c_unmap_rx_buffer(), which the good receive
path also uses, and the index is now decoded with le32_to_cpu().

> diff --git a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
> index eddd8406867f7..689941e46ff43 100644
> --- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
> +++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
> @@ -1864,6 +1864,23 @@ static void atl1c_clean_rfd(struct atl1c_rfd_ring *rfd_ring,
>  	rfd_ring->next_to_clean = rfd_index;
>  }
>  
> +static struct atl1c_buffer *
> +atl1c_unmap_rx_buffer(struct pci_dev *pdev, struct atl1c_rfd_ring *rfd_ring,
> +		      struct atl1c_recv_ret_status *rrs)
> +{
> +	struct atl1c_buffer *buffer_info;
> +	u16 rfd_index;
> +
> +	rfd_index = (le32_to_cpu(rrs->word0) >> RRS_RX_RFD_INDEX_SHIFT) &
> +		    RRS_RX_RFD_INDEX_MASK;

[Severity: Medium]
Only one of the two decoders of this index is converted.
atl1c_clean_rx() calls atl1c_clean_rfd() on the same rrs right after this
helper, on both the error and good paths. In
drivers/net/ethernet/atheros/atl1c/atl1c_main.c that function still decodes
the field raw:

atl1c_clean_rfd() {
	rfd_index = (rrs->word0 >> RRS_RX_RFD_INDEX_SHIFT) &
			RRS_RX_RFD_INDEX_MASK;
	for (i = 0; i < num; i++) {
		buffer_info[rfd_index].skb = NULL;
		ATL1C_SET_BUFFER_STATE(&buffer_info[rfd_index],
					ATL1C_BUFFER_FREE);
	...
}

rfd_num in atl1c_clean_rx() is also extracted from the raw rrs->word0.

On a big-endian host, could these two decodes pick different slots? The
helper would unmap slot X and free its skb (or hand it to the stack).
atl1c_clean_rfd() would then clear a different slot Y and mark it
ATL1C_BUFFER_FREE.

Slot X would stay marked busy with stale skb and dma values. A later
atl1c_clean_rx_ring()->atl1c_clean_buffer() would unmap it a second time
and call napi_consume_skb() on an skb that is already freed or owned by the
stack. The mapping for slot Y would leak.

Before this patch both sites used the same raw index, so they at least
agreed. Big-endian RX in this driver already decodes word3 raw, so these
setups were already broken in other ways.

The commit message says "using le32_to_cpu() when decoding the descriptor
index", but this is the only decoder that does. Could word0 be decoded once
into a CPU-endian local, and that value used for rfd_num, for this helper
and for atl1c_clean_rfd()?

[Severity: Medium]
This is a pre-existing issue, but this helper adds another reader of
rrs->word0. atl1c_clean_rx() checks the valid bit the device writes, then
reads word0 with no barrier in between:

	if (likely(RRS_RXD_IS_VALID(rrs->word3))) {
		rfd_num = (rrs->word0 >> RRS_RX_RFD_CNT_SHIFT) &
			RRS_RX_RFD_CNT_MASK;

atl1c_main.c has no dma_rmb() or rmb() anywhere. On weakly ordered CPUs
such as arm64 or ppc, can the word0 load (or the vlan_tag and rss_hash
loads) complete before the word3 load and return a value from the previous
lap?

In steady state RRD slot p maps to RFD slot p, so a stale word0 usually
gives the same rfd_index, which limits the damage. Would a dma_rmb() after
the RRS_RXD_IS_VALID() check be appropriate?

[ ... ]

> @@ -1908,6 +1925,14 @@ static int atl1c_clean_rx(struct napi_struct *napi, int budget)
>  rrs_checked:
>  		atl1c_clean_rrd(rrd_ring, rrs, rfd_num);
>  		if (rrs->word3 & (RRS_RX_ERR_SUM | RRS_802_3_LEN_ERR)) {
> +			/* atl1c_clean_rfd() drops the only pointer to the skb. */
> +			if (likely(rfd_num == 1)) {

[Severity: Medium]
Are the skbs and DMA mappings still leaked when an errored descriptor
reports more than one RFD? The unmap and free only run when rfd_num == 1.
atl1c_clean_rfd() runs either way and walks all rfd_num slots:

	for (i = 0; i < num; i++) {
		buffer_info[rfd_index].skb = NULL;
		ATL1C_SET_BUFFER_STATE(&buffer_info[rfd_index],
					ATL1C_BUFFER_FREE);

rfd_num comes from a 4-bit field written by the hardware. The earlier
rfd_num != 1 check in atl1c_clean_rx() only prints "Multi rfd not support
yet!" before jumping to rrs_checked, so such a descriptor still reaches
this branch.

The driver doesn't show whether the hardware ever spreads an errored frame
over several RFDs. Since the frame is dropped anyway, could this path walk
all rfd_num slots, with ring wrap, and unmap and free each one?

> +				buffer_info = atl1c_unmap_rx_buffer(pdev, rfd_ring,
> +								    rrs);
> +				if (buffer_info->skb)
> +					kfree_skb_reason(buffer_info->skb,
> +							 SKB_DROP_REASON_NOT_SPECIFIED);
> +			}

[Severity: High]
Can this free a buffer the device still owns, when a stale RRD is
processed after a reset?

The RRD ring is only zeroed when it is allocated at open. Some resets keep
the existing rings: the reset worker in atl1c_common_task(),
atl1c_reinit_locked(), and the link-down path in atl1c_check_link_status().
On those, atl1c_clean_rx_ring() clears only the RFD descriptors:

	memset(rfd_ring->desc, 0, rfd_ring->size);
	rfd_ring->next_to_clean = 0;
	rfd_ring->next_to_use = 0;
	rrd_ring->next_to_use = 0;
	rrd_ring->next_to_clean = 0;

atl1c_down() calls napi_disable() before atl1c_reset_mac(). Any RRD the
hardware writes in that window keeps RRS_RXD_UPDATED set.

The refill then posts fresh mapped skbs to RFD slots 0..count-2. Software
can reach a stale index before the device rewrites it. RRD and RFD indices
advance in lockstep, so the stale rfd_index names a slot that was just
reposted.

If the stale word3 has RRS_RX_ERR_SUM or RRS_802_3_LEN_ERR set, this new
code unmaps and frees that skb, and the device can later DMA into the
freed buffer.

Before this patch, the same stale error descriptor only leaked the skb. The
if (buffer_info->skb) guard only covers the one empty slot, count-1. The
good path already had this hazard before this patch.

Would clearing the RRD ring on reset, or checking rfd_index against
rfd_ring->next_to_clean, close this?

[Severity: High]
This isn't a bug introduced by this patch, but the new unmap and free here
is one more site exposed to it. The link-change worker tears down and
refills the RX rings without stopping RX NAPI:

atl1c_common_task()
    atl1c_irq_disable()
    atl1c_check_link_status()
        atl1c_reset_dma_ring()
            atl1c_clean_rx_ring()
                atl1c_clean_buffer()
        atl1c_configure()

atl1c_irq_disable() masks the interrupt and calls synchronize_irq().
Nothing on this path calls napi_disable() or napi_synchronize().
atl1c_clean_rx() checks netif_carrier_ok() only at poll entry.

A poll may already be inside its loop on another CPU, for example threaded
NAPI preempted mid-poll. Can atl1c_clean_buffer() then find this slot still
busy while atl1c_clean_rx() is between atl1c_unmap_rx_buffer() and
atl1c_clean_rfd()?

atl1c_clean_buffer() {
	if (buffer_info->flags & ATL1C_BUFFER_FREE)
		return;
	...
	if (buffer_info->skb)
		napi_consume_skb(buffer_info->skb, budget);
	...
}

That would mean a double dma_unmap_single() and a double free of the skb.
The two sides would also race on next_to_use and next_to_clean.

Should the link-down path call napi_disable() on the RX rings before
atl1c_reset_dma_ring()?

>  			atl1c_clean_rfd(rfd_ring, rrs, rfd_num);
>  			if (netif_msg_rx_err(adapter))
>  				dev_warn(&pdev->dev,

[Severity: High]
This isn't a bug introduced by this patch, but this branch is being changed
anyway. It recycles the RFD and then hits continue without counting the
work:

			atl1c_clean_rfd(rfd_ring, rrs, rfd_num);
			...
			continue;
		}

The only RX-time refill is gated on work_done. It is also the only place
the RFD producer index is written during RX:

	if (work_done)
		atl1c_alloc_rx_buffer(adapter, rrd_ring->num, true);

Suppose about a ring's worth of errored frames (CRC, runt, 802.3 length
errors) arrives with no good frame in between. Can the device then run out
of RFDs?

Once that happens it stops writing RRDs, so there is no RX interrupt, no
poll and no refill. atl1c_intr() only logs ISR_OVER. RX would stay stopped
until an administrative reset.

The oversized-frame drop in the same function already does work_done++ for
this reason. Should the error path do the same? That would also let the
budget check limit polls that see only errored frames.

[ ... ]

> @@ -1920,11 +1945,7 @@ static int atl1c_clean_rx(struct napi_struct *napi, int budget)
>  				RRS_PKT_SIZE_MASK);
>  		/* Good Receive */
>  		if (likely(rfd_num == 1)) {
> -			rfd_index = (rrs->word0 >> RRS_RX_RFD_INDEX_SHIFT) &
> -					RRS_RX_RFD_INDEX_MASK;
> -			buffer_info = &rfd_ring->buffer_info[rfd_index];
> -			dma_unmap_single(&pdev->dev, buffer_info->dma,
> -					 buffer_info->length, DMA_FROM_DEVICE);
> +			buffer_info = atl1c_unmap_rx_buffer(pdev, rfd_ring, rrs);
>  			skb = buffer_info->skb;

[Severity: High]
This isn't a bug introduced by this patch. The patch notes say the
if (buffer_info->skb) guard is there because "the slot can be empty after a
reset". Can the good path hit that same empty slot? skb is used with no
NULL check:

		skb_put(skb, length - ETH_FCS_LEN);
		skb->protocol = eth_type_trans(skb, netdev);

After a reset that keeps the existing rings, atl1c_alloc_rx_buffer()
refills slots 0..count-2 and leaves slot count-1 with skb == NULL.
atl1c_clean_buffer() doesn't reset buffer_info->length, so that slot keeps
its old rx_buffer_len and the length > buffer_info->length check still
passes.

Only rfd_ring->desc is cleared on reset. A valid RRD at index count-1 that
was not processed before the reset survives it. When software reaches that
index in the first lap after the reset, would it take this path with a NULL
skb and oops in skb_put() or eth_type_trans() in NAPI context?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261102215253.68185-1-federico%40rimpianto.com

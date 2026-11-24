Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795544241;
	b=l9XFglJY3UxamMHK9cRlurThc2YeGI2Lh0Op9YIH3rE9lIprRv3iRpO70GDPcyoWEJDS
	 /LYS4nKaZBbvUxDMEHMKDbuhDqEtAdE7oeHXhIGbmFsZ+Paqj+MzZ+QqZPucmtrX8le2V
	 pqZzgKErTxDFyFJ+7jv8vdzcY3n89HcFAdfjPIFsdQ5H3EvYs8QULIgF/OCF23Jhy778i
	 r1m3D/iw0MqRnGVNUhBsYwrcGfht0luHsdG35QjDjHxU0cHRK4LeIenFzPWSoILqt9kMx
	 QXD6b8hpVJ2GCNsR6ekyg6Q7IKigT4UPacDFcUuPd9jvOsaRgxY0n7sxYIVQOVQ8wtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795544241;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=0OndKyajzvz0q4rcHtIWvV88HXJQNA05HlXFtABxYO8=;
	b=gKTarPz29QowRIqc0Afed0CcjE8Xy68pX54klpWAdgcqEidQYDtRH6eIwGqX8eZuS2qp
	 DWKv+DJxqsPEr+r3nhSxRJM8JJHmjUVnmHCBCD/xlEeXll/s+508E4hZauJCI4OIqhCAi
	 P9qt2T5oYic7cxGY9SVbClpghBKJyUUx0OPEXFyqxxqQlJvIqIbY8bevVNfvTQDNZsMUA
	 /ME3jt+DwCq2LK8WT1tVzcgVRp/CHRR20RvPTMODqw07Ct4/qDJgQGyMgB7bOEH6EOlQ+
	 kxtRXEVdUM92GwGErhETNS08iHY9JbcUUwjupf7VWYaT/GiVsN0keGjMwrbhQJCHSjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="nFUKk/gl";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B264606A31E;
	Tue, 24 Nov 2026 18:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nFUKk/gl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 307351F000C0;
	Tue, 24 Nov 2026 18:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795544241;
	bh=0OndKyajzvz0q4rcHtIWvV88HXJQNA05HlXFtABxYO8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=nFUKk/gl3xd7G5fgm0oM3q42hKqqAxxsemdkqRGrH9EOFPTfmN/M7h6s8olVb2R/f
	 xMe8nbaPMhRdlylOYTKWS0TpwkZl3dx4lPOEVbyWI0IhouM3XRX5XuA3gL2VXMBR+g
	 9xx9ruN7gzlqGJG1cvWoFt8jSn44LrdrT8Pr0KPZUzF0LrFaenae5XvrdprH1iWaHg
	 PrWsJ9FkgH+1m5jOXs2VTorL0Pi0DZGZhFTJtore4fF2a0TSmyE1B6hnHyB8l/gYwi
	 RjYJJkXqNAbwKcCxHD7iTBnJmziRRpyqaRklwseyo7L8CeHi8OCHIguE5Krt8ojckW
	 XstTts6mpudvA==
Subject:
 Re: [PATCH net v2] net: wwan: t7xx: validate PIT data before building RX skb
From: netdev-bot+sashiko@kernel.org
To: fangxy@xiaopeng.com
Cc: chandrashekar.devegowda@intel.com, loic.poulain@oss.qualcomm.com,
 ryazanov.s.a@gmail.com, ilpo.jarvinen@linux.intel.com, netdev@vger.kernel.org,
 haijun.liu@mediatek.com, johannes@sipsolutions.net, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, linqj@xiaopeng.com
Date: Tue, 24 Nov 2026 18:17:19 +0000
Message-ID: <179554423968.3135.4032693125961744005@kernel.org>
In-Reply-To: <20261123171519.33975-1-fangxy@xiaopeng.com>
References: <20261123171519.33975-1-fangxy@xiaopeng.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 (4) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new err_drop path in t7xx_dpmaif_set_data_to_skb() frees
  the normal BAT skb (dev_kfree_skb_any) and marks the modem-supplied…
- [Low] The commit message undersells or leaves out several of the
  patch's changes, and it bundles several independent fixes into one…

Pre-existing issues:
- [Medium] Not introduced by this patch: a normal (non-fragment) PD PIT
  that arrives while skb_info->cur_skb is already set overwrites cur_skb…
- [Medium] Not introduced by this patch: t7xx_dpmaif_stop_rxq() clears
  rxq->rx_data_info with memset() without freeing skb_info->cur_skb.
- [Medium] Not introduced by this patch: both RX queues (DPMAIF_RXQ_NUM =
  2) share one normal BAT and one frag BAT.
- [Medium] Not introduced by this patch, though the new drop path keeps
  the same behaviour: when a PD PIT's BID fails t7xx_bat_cur_bid_check()…

--

net: wwan: t7xx: validate PIT data before building RX skb

The patch checks the modem-supplied PIT data address, offset and length
against the BAT buffer before the RX skb is built, in both the normal and
fragment paths. It marks BAT entries as consumed on error and adds a drop
path for fragments of packets that have already failed. It also keeps packet
assembly errors separate from PIT notification errors in
t7xx_dpmaif_rx_start().

> The unsigned 64-bit
> difference was stored in an int without checking the address order,
> so a backwards address could wrap into a non-negative offset.

[Severity: Low]
Is this description complete? For a small backwards distance, truncating
the u64 difference to an int gives a negative value. For example, base - 16
becomes -16, and that value was then passed to skb_reserve().

> Cast the fragment BAT void pointer to
> struct dpmaif_bat_page before pointer arithmetic.

This reads like a cosmetic change, but the baseline code was:

	bat_page = bat_frag->bat_skb + cur_bid;

That is arithmetic on a void pointer, so it advanced by cur_bid bytes
rather than cur_bid entries. t7xx_frag_bat_cur_bid_check() therefore read
a misaligned ->page field from the wrong place.

The new t7xx_dpmaif_drop_frag() relies only on this helper before it sets a
bitmap bit. Could the message describe this as a functional fix, so
backporters know it is a prerequisite?

The message also leaves out a few changes:

  - The dev_err() to dev_err_ratelimited() conversions in
    t7xx_dpmaif_get_frag() and t7xx_dpmaif_get_rx_pkt().

  - t7xx_dpmaif_rx_start() no longer returns a negative value to the NAPI
    poll path when a packet is dropped. The sentence about keeping packet
    assembly errors separate from PIT notification errors only implies
    this.

Since this is tagged for stable, would it make sense to split it into
separate, bisectable fixes? The frag BID arithmetic, the normal-path range
check, the frag-path range check, the BAT accounting on error and the PIT
notify separation each look independent.

> diff --git a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c
> index 5af90ca6e0631..da4b7cb05bf33 100644
> --- a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c
> +++ b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c

[ ... ]

> @@ -438,22 +448,44 @@ static int t7xx_dpmaif_get_frag(struct dpmaif_rx_queue *rxq,

[ ... ]

> +/* Consume a fragment PIT belonging to a packet that is already dropped. */
> +static int t7xx_dpmaif_drop_frag(struct dpmaif_rx_queue *rxq,
> +				 const struct dpmaif_pit *pkt_info)
> +{
> +	unsigned int cur_bid = t7xx_normal_pit_bid(pkt_info);
> +
> +	if (t7xx_frag_bat_cur_bid_check(rxq, cur_bid))
> +		return -EINVAL;

[Severity: Medium]
This is a pre-existing issue, and the new drop path behaves the same way.
When the BID fails t7xx_frag_bat_cur_bid_check(), or
t7xx_bat_cur_bid_check() in t7xx_dpmaif_get_rx_pkt(), no bitmap bit is set
at all. The check fails when the BID is out of range or when the slot's
page or skb is NULL.

The hardware still consumed some BAT or FRG entry for that PIT. Release
stops at the first zero bit:

t7xx_dpmaif_avail_pkt_bat_cnt() {
    ...
	zero_index = find_next_zero_bit(bat_req->bat_bitmap, bat_req->bat_size_cnt,
					bat_req->bat_release_rd_idx);
    ...
}

Can the release cursor get stuck on that consumed but unmarked slot? If so,
t7xx_dpmaif_rx_buf_alloc() and t7xx_dpmaif_rx_frag_alloc() never refill,
and DL RX stalls until the queue is restarted. The DL BAT error interrupts
only log, so nothing triggers a reset.

The driver cannot tell which slot a bad BID referred to. Would this case
need a recovery step, such as a queue reset or a resync from the hardware
read index, rather than another set_bit?

> +
> +	/*
> +	 * The page is still mapped and owned by the BAT entry; marking it
> +	 * consumed lets release advance and the allocator reuse the page.
> +	 */
> +	t7xx_dpmaif_set_bat_mask(rxq->bat_frag, cur_bid);
> +	return -EINVAL;
> +}
> +
>  static int t7xx_bat_cur_bid_check(struct dpmaif_rx_queue *rxq, const unsigned int cur_bid)
>  {
> -	struct dpmaif_bat_skb *bat_skb = rxq->bat_req->bat_skb;
> +	struct dpmaif_bat_skb *bat_skb;
> +
> +	if (cur_bid >= DPMAIF_BAT_COUNT)
> +		return -EINVAL;
>  
> -	bat_skb += cur_bid;
> -	if (cur_bid >= DPMAIF_BAT_COUNT || !bat_skb->skb)
> +	bat_skb = (struct dpmaif_bat_skb *)rxq->bat_req->bat_skb + cur_bid;
> +	if (!bat_skb->skb)
>  		return -EINVAL;

[Severity: Medium]
This isn't a bug introduced by this patch, but both RX queues share one
normal BAT and one frag BAT:

t7xx_dpmaif_rx_alloc() {
    ...
	rxq->bat_req = &rxq->dpmaif_ctrl->bat_req;
    ...
	rxq->bat_frag = &rxq->dpmaif_ctrl->bat_frag;
    ...
}

Each queue has its own NAPI instance, and only bat_bitmap is protected by
mask_lock. The per-entry bat_skb[bid].skb and bat_page[bid].page fields are
checked here and used later without a lock. The later use is in
t7xx_dpmaif_set_data_to_skb(), t7xx_dpmaif_set_frag_to_skb() or
t7xx_dpmaif_drop_frag().

If the modem reports the same BID on PITs for both queues, could RXQ0 and
RXQ1 both pass this check and then race on the same entry? Possible
results:

  - a second dma_unmap_single() on the same buffer
  - a NULL dereference at skb->len = 0 after the other CPU cleared
    bat_skb->skb
  - both CPUs taking the same skb, either as cur_skb or through the new
    err_drop dev_kfree_skb_any()
  - in the frag path, a double dma_unmap_page() and one page attached to
    two skbs

[ ... ]

> @@ -627,38 +659,50 @@ static void t7xx_dpmaif_parse_msg_pit(const struct dpmaif_rx_queue *rxq,
>  
>  static int t7xx_dpmaif_set_data_to_skb(const struct dpmaif_rx_queue *rxq,
>  				       const struct dpmaif_pit *pkt_info,
> +				       unsigned int cur_bid,
>  				       struct dpmaif_cur_rx_skb_info *skb_info)
>  {

[ ... ]

> -	bat_skb = rxq->bat_req->bat_skb;
> -	bat_skb += t7xx_normal_pit_bid(pkt_info);
> +	bat_skb = (struct dpmaif_bat_skb *)rxq->bat_req->bat_skb + cur_bid;
>  	dma_unmap_single(dev, bat_skb->data_bus_addr, bat_skb->data_len, DMA_FROM_DEVICE);

[ ... ]

> +	if (data_bus_addr < data_base_addr) {
> +		dev_err_ratelimited(dev, "Invalid PIT data address\n");
> +		goto err_drop;
> +	}
> +
> +	data_offset = data_bus_addr - data_base_addr;
> +	tailroom = skb_tailroom(skb);
> +	max_len = min(tailroom, bat_skb->data_len);
> +	if (data_offset > max_len || data_len > max_len - data_offset) {
> +		dev_err_ratelimited(dev, "Invalid PIT data offset or length\n");
> +		goto err_drop;
>  	}
>  
> +	skb_reserve(skb, (int)data_offset);
>  	skb_put(skb, data_len);
>  	skb_info->cur_skb = skb;
>  	bat_skb->skb = NULL;
>  	return 0;
> +
> +err_drop:
> +	dev_kfree_skb_any(skb);
> +	bat_skb->skb = NULL;
> +	t7xx_dpmaif_set_bat_mask(rxq->bat_req, cur_bid);
> +	return -ENOBUFS;

[Severity: Medium]
Is it safe to free the skb here? A wrong BID is exactly what produces a PIT
data address outside this BID's buffer. t7xx_bat_cur_bid_check() only
checks that cur_bid is in range and that bat_skb->skb is non-NULL. Nothing
compares cur_bid against the hardware BAT read index.

If that entry is still posted in the BAT ring, its descriptor keeps the old
DMA address until t7xx_dpmaif_rx_buf_alloc() rewrites it, which happens
only after release passes that slot. On systems without an IOMMU, could a
later modem DMA into this entry write into the freed skb?

The baseline -ENOBUFS path had its own problems. It left the skb unmapped
with modified data and tail pointers, and the entry was never marked. But
it did not free memory the device could still write to.

dma_unmap_single() also still runs before any of this validation. If the
checks ran first, could the mapping be kept and the buffer reused, as the
frag path now does?

[ ... ]

> @@ -756,13 +800,13 @@ static int t7xx_dpmaif_rx_start(struct dpmaif_rx_queue *rxq, const unsigned int
>  		} else { /* DES_PT_PD */
>  			val = FIELD_GET(PD_PIT_BUFFER_TYPE, le32_to_cpu(pkt_info->header));
>  			if (val != PKT_BUF_FRAG)
> -				ret = t7xx_dpmaif_get_rx_pkt(rxq, pkt_info, skb_info);
> -			else if (!skb_info->cur_skb)
> -				ret = -EINVAL;
> +				pkt_ret = t7xx_dpmaif_get_rx_pkt(rxq, pkt_info, skb_info);

[Severity: Medium]
This is a pre-existing issue. What happens when a non-fragment PD PIT
arrives while skb_info->cur_skb is already set? This can happen when the
earlier PIT had PD_PIT_CONT set, including after a failed fragment has set
err_payload.

This branch calls t7xx_dpmaif_get_rx_pkt() regardless of cur_skb or
err_payload. t7xx_dpmaif_set_data_to_skb() then does:

	skb_info->cur_skb = skb;
	bat_skb->skb = NULL;

Does this leak the previous skb? Its BAT slot was already marked consumed
and refilled, so nothing limits how many skbs can leak this way. The new
err_payload / !cur_skb check covers fragment PITs but not normal PITs.

> +			else if (skb_info->err_payload || !skb_info->cur_skb)
> +				pkt_ret = t7xx_dpmaif_drop_frag(rxq, pkt_info);
>  			else
> -				ret = t7xx_dpmaif_get_frag(rxq, pkt_info, skb_info);
> +				pkt_ret = t7xx_dpmaif_get_frag(rxq, pkt_info, skb_info);
>  
> -			if (ret < 0) {
> +			if (pkt_ret < 0) {
>  				skb_info->err_payload = 1;
>  				dev_err_ratelimited(dev, "RXQ%u error payload\n", rxq->index);
>  			}

[Severity: Medium]
This isn't a bug introduced by this patch, but cur_skb can survive across
NAPI polls in two cases:

  - t7xx_dpmaif_rx_start() returns early on a PIT sequence-check failure
    in the middle of a packet.
  - The loop ends at pit_cnt while the hardware write index is in the
    middle of a packet.

If the queue is then stopped, t7xx_dpmaif_rx_clear()->t7xx_dpmaif_stop_rxq()
does:

t7xx_dpmaif_stop_rxq() {
    ...
	memset(&rxq->rx_data_info, 0, sizeof(rxq->rx_data_info));
    ...
}

It never calls dev_kfree_skb_any() on skb_info->cur_skb. Does this leak the
partly assembled skb, along with any pages attached through
skb_add_rx_frag()?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261123171519.33975-1-fangxy%40xiaopeng.com

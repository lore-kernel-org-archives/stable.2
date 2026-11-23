Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795415969;
	b=epdhtve3j53VztQYEENwl/KX0/wOSwfEc2hpIXK2nMupaptEFCGvEtMfZxgeYdX5gjcP
	 J84o5BJycI12ArvZqqKmb87/z0BCME+wynBieiPM2BOpkioN0fy0nUQm2uU4oanpq7+Ct
	 bxgm1raR4ysrB7EmXG+TqtfPRYMMfHgJv+9UhUUxjcTZ9BlTmAzj6E4KBvmQhof++Ugcl
	 sF1Er6+ylRdqr8OCXwK5SUzW7DvN38xkNB0LUx4tXggZbZuj1WvrsPEml3nXBIuTA38sv
	 YZ2DuwMeb0vu/GeYNH5SIKq0Gyj4Adkyf1XfvT2PYH4+zajnE3oIlU63AWpcir9SMag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795415969;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=7agXcixM5SUecxuwupsf5SFmE1L7F0iLFU7WsXCvLCo=;
	b=Z7ow5/bcnSDi18kZJU6BXO7Z3ICMwUocwzJG4t+udrm1c36l/4HLOoJVh8ZAP5R2WCsD
	 6AfXQ5B6NGJ7h0yfHf2LsSbVzhBWab9MPTk75NMdixxMmM6CE0rydxFypkCf9HqSQz6Y9
	 fNbSYosrSmlox9kQcmOgQ/UpRLboASJoOYrUTrfdMbKPO4RLwUbZNzmOhEcehd+KWGf2K
	 ZKcpmffQhQZxWukQTXYITsvzvji5sf0NC6TSZR0sT/oUUat551JmHwuJ89dmvE51E+CXy
	 Q/aOyoFMbvuvEnNYjVeU4CRksFSCoRbh9m8IWeKEoqbn6/8wbAGuqMkFE+zCtqt9D+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NOKrRDrr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56497606A31A;
	Mon, 23 Nov 2026 06:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NOKrRDrr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F21701F000CF;
	Mon, 23 Nov 2026 06:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795415968;
	bh=7agXcixM5SUecxuwupsf5SFmE1L7F0iLFU7WsXCvLCo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NOKrRDrrj6eRUaabPUhzPcwV+gkEJogXEb2Au13b84teh3Gk8VNyNCNENuvdHjNGl
	 oqdOWYsPCA/87fO+bc/dNhjmfYcnY4NtPWfNiGr30RnbvoIvDiaN4dRAhApBnLAqER
	 epTUnH28hTOj5uvLuHtT4U/4yqPcjmpy6Er8/88a6ckSUARkXlgUzBkML4a2fBvGEn
	 BQ7uGI6K/FMOi11L881IUooUP4HYlhOIkySp306IXn4QVi8/AslHUQoFHSKgwdMbFw
	 eEolOWrQixXJOJBXzXLbV3Fq469UNk1bEFGTtI4M1pVACy8vyfcFGSlP7HmgGwxeVf
	 IltdaeN86w5Ag==
Subject:
 Re: [PATCH net] net: wwan: t7xx: validate PIT data offset before skb_reserve
From: netdev-bot+sashiko@kernel.org
To: fangxy@xiaopeng.com
Cc: chandrashekar.devegowda@intel.com, loic.poulain@oss.qualcomm.com,
 ryazanov.s.a@gmail.com, ilpo.jarvinen@linux.intel.com, netdev@vger.kernel.org,
 haijun.liu@mediatek.com, johannes@sipsolutions.net, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, linqj@xiaopeng.com
Date: Mon, 23 Nov 2026 06:39:27 +0000
Message-ID: <179541596756.3135.6965744505387412637@kernel.org>
In-Reply-To: <20261119062044.72261-1-fangxy@xiaopeng.com>
References: <20261119062044.72261-1-fangxy@xiaopeng.com>
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

Critical: 0 · High: 2 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch fixes the modem-supplied PIT address/length problem
  only for the normal BAT path.
- [High] The new err_drop path in t7xx_dpmaif_set_data_to_skb() calls
  `t7xx_dpmaif_set_bat_mask(rxq->bat_req,…
- [Medium] The patch makes the normal-BAT error path free the skb and set
  the entry's bit in bat_req->bat_bitmap, so release can move past it.

--

net: wwan: t7xx: validate PIT data offset before skb_reserve

This patch makes t7xx_dpmaif_set_data_to_skb() check the modem-supplied
PIT data address and length against the skb tailroom and the DMA mapping
length before it calls skb_reserve(). On error it now frees the skb and
marks the normal BAT entry consumed, so the BAT ring can be released and
refilled.

> diff --git a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c
> index 5af90ca6e0631..44e2ba15984df 100644
> --- a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c
> +++ b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c

[ ... ]

> @@ -643,22 +643,35 @@ static int t7xx_dpmaif_set_data_to_skb(const struct dpmaif_rx_queue *rxq,
>  	data_bus_addr = le32_to_cpu(pkt_info->pd.data_addr_h);
>  	data_bus_addr = (data_bus_addr << 32) + le32_to_cpu(pkt_info->pd.data_addr_l);
>  	data_base_addr = bat_skb->data_bus_addr;
> -	data_offset = data_bus_addr - data_base_addr;
>  	data_len = FIELD_GET(PD_PIT_DATA_LEN, le32_to_cpu(pkt_info->header));

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

[Severity: High]
Does t7xx_dpmaif_set_frag_to_skb() need the same validation? It derives
the offset in the same way from the modem-supplied PIT address, and
still stores it in an int:

drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c:t7xx_dpmaif_set_frag_to_skb() {
    ...
	int data_offset;
    ...
	data_offset = data_bus_addr - data_base_addr;
	data_offset += page_info->offset;
	data_len = FIELD_GET(PD_PIT_DATA_LEN, le32_to_cpu(pkt_info->header));
	skb_add_rx_frag(skb, shinfo->nr_frags, page_info->page,
			data_offset, data_len, page_info->data_len);
    ...
}

On this path the only check is t7xx_frag_bat_cur_bid_check(). It
validates the BID, but not the address or the length. PD_PIT_DATA_LEN is
a 16-bit field (GENMASK(31,16)), and the fragment buffer is only
DPMAIF_HW_FRG_PKTBUF (128) bytes. skb_add_rx_frag() does no bounds
checking of its own.

PKT_BUF_FRAG PD PITs come from the same PIT ring, through
t7xx_dpmaif_rx_start()->t7xx_dpmaif_get_frag(). A backwards address, or
an oversized offset or length, would produce a fragment that points
outside the 128-byte DMA-mapped buffer. A negative int offset would also
become a huge fragment offset.

Could later GRO header pulls, checksum walks or socket copies then read
memory outside the fragment allocation? Should the frag path also reject
data_bus_addr < data_base_addr, and any offset plus length beyond
page_info->data_len?

>  
> +	skb_reserve(skb, (int)data_offset);

[ ... ]

> +
> +err_drop:
> +	dev_kfree_skb_any(skb);
> +	bat_skb->skb = NULL;
> +	t7xx_dpmaif_set_bat_mask(rxq->bat_req, t7xx_normal_pit_bid(pkt_info));

[Severity: High]
This line reads the BID from the PIT entry again. The PIT ring
(rxq->pit_base) is dma_alloc_coherent() memory, so the device can write
to it.

The caller t7xx_dpmaif_get_rx_pkt() has already read the BID into
cur_bid and bounded it with t7xx_bat_cur_bid_check()
(cur_bid < DPMAIF_BAT_COUNT). That checked value is not passed down to
this function.

A re-read BID can be as large as 65535 (PD_PIT_H_BID << 13 plus
PD_PIT_BUFFER_ID). bat_bitmap comes from
bitmap_zalloc(DPMAIF_BAT_COUNT), so it holds 8192 bits. Because
dma_unmap_single() and dev_kfree_skb_any() sit between the reads, the
value really is loaded again from coherent memory.

If the modem rewrites the PIT entry after the caller's check, can the
set_bit() in t7xx_dpmaif_set_bat_mask() write past the end of
bat_bitmap?

Even if the index stays in range, the bit could land on a different slot
from the one whose skb was just freed. The freed slot would then stay
unmarked, and a slot the hardware still owns would be counted as
consumed and refilled.

The earlier re-read in "bat_skb += t7xx_normal_pit_bid(pkt_info)" has
the same problem and predates this patch. Would it help to pass the
validated cur_bid down (or read the PIT words once) and use that one
value for both the bat_skb indexing and the bitmap update?

> +	return -ENOBUFS;
>  }

[Severity: Medium]
This path now marks the normal BAT entry consumed. Can the frag BAT ring
still stall in the same way, from the same malformed input?

When the head PD is rejected here, skb_info->cur_skb stays NULL. Every
following PKT_BUF_FRAG PIT of the same packet then takes this branch in
t7xx_dpmaif_rx_start():

		else if (!skb_info->cur_skb)
			ret = -EINVAL;

That branch leaves the frag page mapped and never sets its bit in
rxq->bat_frag->bat_bitmap.

t7xx_dpmaif_get_frag() also sets the bit only on success:

	ret = t7xx_dpmaif_set_frag_to_skb(rxq, pkt_info, skb_info->cur_skb);
	if (ret < 0) {
		dev_err(rxq->dpmaif_ctrl->dev, "Failed to set frag data to skb: %d\n", ret);
		return ret;
	}

	t7xx_dpmaif_set_bat_mask(rxq->bat_frag, cur_bid);

So a failure such as shinfo->nr_frags >= MAX_SKB_FRAGS leaves the entry
unmarked as well.

t7xx_dpmaif_avail_pkt_bat_cnt() counts set bits with
find_next_zero_bit() starting at bat_release_rd_idx. One unmarked frag
entry therefore stops release and refill of the frag ring for good.

Isn't this the same "stall BAT release and buffer replenishment" problem
the commit message describes, only on the frag ring?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261119062044.72261-1-fangxy%40xiaopeng.com

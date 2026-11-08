Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794102559;
	b=XyKmnQi3TXnSkJSLqSM9mRvE1mSw9DryAFVVnlcka8HRx0DRkc+836GLw4bi1TVqjFkQ
	 aol51vlNVUMV0EB8isz92dO0SbANhz1tjDIZFWu026RR0CliMhQ8FY2NouFTj8hOGNCdC
	 nIt6+3bTcLZD9j49I/kxnmxb7jFcZG442EevFXOAPFbhauCA8mAXmDEcnCkAuKH1O6fHt
	 WGYLcrsn6YFau5w5vkWNb/shht4FZ8HPnK6lCWbxp6cdHzuyS5nIXZ0Hg2HFFe9BbKb2k
	 8Q33bnIESMnR2WXmIRPVDSo1FDK9lTZjr0h3WZryuUHkVVU9kL8vYGHqndVUvdw3VQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794102559;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=QlFn/ogZnBwnGXypaqw1Bx3HTl2v+r0AMb9Jwl2RJhE=;
	b=lkMpSXzMBgmL0q4EBKI8k29pKi4FQc6V0QxcedMV5Z/YRluhl3at5M4hp9xN0UO8zLGV
	 wI6xapbhthkywMT4CCeaLaB8VjBhKrsw/JJYVxGvI0JBBZ4xGWMdp7+g3CZt/1oKreJl1
	 zGqwRHH7azaxI804+gtn38z40KcuQjhltsDFvKF6B3N7a9F0VXfocuGgrQ76BRh8HO14S
	 vAiLaTDopeDGOsihgzyAyaDuOpWWhUd+LDCcN9Up7oCXktb4588oVlAFXOKmbxbV0S8+V
	 YWhsJOV2sntIYnzJSlLR6jfrN0hQvZvutWuSJV3Vvc80Q0Si2LF5haJG26M3wJXcupg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Cu+/WexB";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38661606A31A;
	Sun,  8 Nov 2026 01:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cu+/WexB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39C8D1F0089F;
	Sun,  8 Nov 2026 01:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794102558;
	bh=QlFn/ogZnBwnGXypaqw1Bx3HTl2v+r0AMb9Jwl2RJhE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Cu+/WexBi0lEOhEn4R93nkwKirlhVJq0PSZIO7L2Xz2eGRqXSuzc2Uv49dNXhD3LX
	 NbjqzoNeiSbMd16WsTRPgQfA3PEOvo4dXP4R63Dbuid+L+aGOPm05bVH4zmXtX+bQv
	 zaQ/GqWyOW3VhAdcQB4lrPo+Hf5+uPTh5rlwH2Bj6Yq1x1EoLblgxJ2aTskmNONZ7A
	 VbvAaFl56dzuVgnGmbEldIZ2BHMRSUdsu2JB+XJx0a50+P8YoQVchLikQkJJhJMiKv
	 8wJ3wsbve9O624caX3kcrxVGmnKSfcF9wPryfb2SYVhqJHBxGcJh5nY6+a+AgmcAPb
	 qCoReXdaNxr/Q==
Subject: Re: [PATCH net v3] net: atl1c: free the RX buffer when the descriptor
 reports an error
From: netdev-bot+sashiko@kernel.org
To: federico@rimpianto.com
Cc: chris.snook@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Sun, 08 Nov 2026 01:49:17 +0000
Message-ID: <179410255769.994134.16589271793081668306@kernel.org>
In-Reply-To: <20261103225218.19206-1-federico@rimpianto.com>
References: <20261103225218.19206-1-federico@rimpianto.com>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 1 (2) · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new errored-frame branch in atl1c_clean_rx()
  (drivers/net/ethernet/atheros/atl1c/atl1c_main.c:1926-1943) unmaps and…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the patch
  widens it: the link-change worker resets and reposts the RX rings…
- [Medium] In atl1c_clean_rx(), a valid RRD with an error bit set and
  RRS_RX_RFD_CNT == 0 is never consumed.
- [Medium] atl1c_clean_rx() checks RRS_RXD_IS_VALID(rrs->word3) (line
  1909) and then reads rrs->word0 (line 1910) with no dma_rmb() between…
- [Low] struct atl1c_recv_ret_status (atl1c.h) declares word0 and word3
  both as __le32.

--

net: atl1c: free the RX buffer when the descriptor reports an error

This patch changes how atl1c_clean_rx() handles an RRD that reports
RRS_RX_ERR_SUM or RRS_802_3_LEN_ERR. It now unmaps and frees the skb of
every RFD slot the RRD references, where before it only marked those slots
free. It also decodes word0 once with le32_to_cpu(), counts errored
descriptors as work so the RX refill runs, and clears the RRD ring in
atl1c_clean_rx_ring().

> diff --git a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
> index eddd8406867f7..0d7d8426ce99b 100644
> --- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
> +++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
> @@ -912,8 +912,9 @@ static void atl1c_clean_rx_ring(struct atl1c_adapter *adapter, u32 queue)
>  		buffer_info = &rfd_ring->buffer_info[j];
>  		atl1c_clean_buffer(pdev, buffer_info, 0);
>  	}
> -	/* zero out the descriptor ring */
> +	/* zero out the descriptor rings */
>  	memset(rfd_ring->desc, 0, rfd_ring->size);
> +	memset(rrd_ring->desc, 0, rrd_ring->size);

[Severity: High]

This is a pre-existing issue, but does the RRD memset fully prevent what
the commit message describes?

  "Clear the RRD ring on reset, preventing a stale error descriptor from
  causing a freshly reposted RX buffer to be unmapped and freed while the
  device still owns it."

The link-change worker gets here without stopping NAPI:

atl1c_common_task()
  atl1c_irq_disable()
  atl1c_check_link_status()      /* link down branch */
    netif_carrier_off()
    atl1c_reset_mac()
    atl1c_reset_dma_ring()
      atl1c_clean_rx_ring()
        atl1c_clean_buffer()     /* unmap + napi_consume_skb() each RFD */
        memset(rrd_ring->desc, 0, rrd_ring->size);
    atl1c_configure()
      atl1c_alloc_rx_buffer()    /* repost fresh buffers from index 0 */

atl1c_irq_disable() masks the interrupt and calls synchronize_irq(). There
is no napi_disable(), and atl1c_clean_rx() checks netif_carrier_ok() only
on entry.

Suppose a poll on another CPU is already inside its loop and has decoded
rfd_index. Can the new error branch then see buffer_info->skb as non-NULL
and call dma_unmap_single() and kfree_skb_reason() on it? That would
either double unmap and free a buffer that atl1c_clean_buffer() also
frees, or unmap and free a buffer the worker just reposted to the device.

The good receive path has the same race. The notes below the --- line say
the link-reset/NAPI races are left to separate patches. Still, this patch
adds another free site inside that window.

[ ... ]

> @@ -1894,8 +1907,11 @@ static int atl1c_clean_rx(struct napi_struct *napi, int budget)
>  			break;
>  		rrs = ATL1C_RRD_DESC(rrd_ring, rrd_ring->next_to_clean);
>  		if (likely(RRS_RXD_IS_VALID(rrs->word3))) {
> -			rfd_num = (rrs->word0 >> RRS_RX_RFD_CNT_SHIFT) &
> +			rrs_word0 = le32_to_cpu(rrs->word0);
> +			rfd_num = (rrs_word0 >> RRS_RX_RFD_CNT_SHIFT) &
>  				RRS_RX_RFD_CNT_MASK;
> +			rfd_index = (rrs_word0 >> RRS_RX_RFD_INDEX_SHIFT) &
> +				RRS_RX_RFD_INDEX_MASK;

[Severity: Medium]

This isn't a bug introduced by this patch, but should there be a dma_rmb()
between the RRS_RXD_IS_VALID(rrs->word3) check and the load of rrs->word0?
Without one, a weakly ordered CPU can pair a stale word0 with a fresh
word3.

The practical effect looks limited. The RRD and RFD rings advance
one-for-one, as the comment in atl1c_clean_rrd() says ("the relationship
between rrd and rfd is one map one"), so a stale rfd_index at RRD slot i
normally still names RFD slot i. After the new memset, a stale word0 also
gives rfd_num == 0.

The good path has the same missing barrier, and the notes defer the
memory-ordering issues to a separate patch.

> @@ -1908,11 +1924,22 @@ static int atl1c_clean_rx(struct napi_struct *napi, int budget)
>  rrs_checked:
>  		atl1c_clean_rrd(rrd_ring, rrs, rfd_num);
>  		if (rrs->word3 & (RRS_RX_ERR_SUM | RRS_802_3_LEN_ERR)) {

[Severity: Low]

This is a pre-existing issue, but struct atl1c_recv_ret_status declares
word3 as __le32 too. Now that word0 goes through le32_to_cpu(), should
word3 be converted as well?

These accesses all apply CPU-order masks to the raw little-endian value,
so they test the wrong bits on big-endian hosts:

  RRS_RXD_IS_VALID(rrs->word3)
  this error test
  the RRS_PKT_SIZE extraction
  rrs->word3 &= ~RRS_RXD_UPDATED in atl1c_clean_rrd()

The driver was already broken on big-endian before this patch.

> -			atl1c_clean_rfd(rfd_ring, rrs, rfd_num);
> +			/* atl1c_clean_rfd() drops the only pointer to each skb. */
> +			for (i = 0; i < rfd_num; i++) {
> +				buffer_info = atl1c_unmap_rx_buffer(pdev, rfd_ring,
> +								    rfd_index);
> +				if (buffer_info->skb)
> +					kfree_skb_reason(buffer_info->skb,
> +							 SKB_DROP_REASON_NOT_SPECIFIED);
> +				atl1c_clean_rfd(rfd_ring, rfd_index, 1);
> +				if (++rfd_index == rfd_ring->count)
> +					rfd_index = 0;
> +			}

[Severity: Medium]

Can this loop unmap and free a buffer the NIC still owns? rfd_num and
rfd_index come straight from the device-written RRD:

#define RRS_RX_RFD_CNT_MASK	0x000F
#define RRS_RX_RFD_INDEX_MASK	0x0FFF

So rfd_index can be as large as 4095 against a 512-entry RFD ring, and
rfd_num can be as large as 15.

Before any slot is freed, nothing checks that:

  - rfd_index < rfd_ring->count
  - rfd_index is the slot software expects (rfd_ring->next_to_clean is
    written but never read)
  - the slot is ATL1C_BUFFER_BUSY

atl1c_unmap_rx_buffer() only checks buffer_info->skb.

Before this patch, a wrong index or count here leaked the buffer but left
the mapping valid. Now the buffer is unmapped and freed, and the device
can then DMA into freed memory or a released swiotlb slot.

The wrap test is ++rfd_index == rfd_ring->count, so a starting index at or
above count never wraps. Could the loop then walk into another queue's
buffer_info entries, or past the end of the single allocation that
atl1c_setup_ring_resources() shares between the TPD and RFD buffer_info
arrays, and pass whatever it finds to kfree_skb_reason()?

For comparison, alx_clean_rx_irq() uses the same RRD layout. It unmaps by
its software index and schedules a reset on a mismatch:

	if (ALX_GET_FIELD(le32_to_cpu(rrd->word0),
			  RRD_SI) != rxq->read_idx ||
	    ALX_GET_FIELD(le32_to_cpu(rrd->word0),
			  RRD_NOR) != 1) {
		alx_schedule_reset(alx);
		return work;
	}

Would a similar sanity check, or using the software index, make sense
here?

Multi-RFD freeing is also added only on the error path. The good path
still treats rfd_num != 1 as unsupported.

The patch notes say it hasn't been tested on hardware, so it isn't known
how atl1c fills these fields for errored frames.

>  			if (netif_msg_rx_err(adapter))
>  				dev_warn(&pdev->dev,
>  					 "wrong packet! rrs word3 is %x\n",
>  					 rrs->word3);
> +			work_done++;
>  			continue;

[Severity: Medium]

This isn't a bug introduced by this patch, but what happens with a valid
errored RRD whose RFD count is 0?

atl1c_clean_rrd(rrd_ring, rrs, 0) neither clears RRS_RXD_UPDATED nor
advances next_to_clean. The free loop runs zero times, and continue
re-reads the same descriptor.

Before this patch, that looped forever inside a single poll. With the new
work_done++, the poll returns budget and NAPI repolls the same RRD. That
is an improvement, but RX on that queue still makes no progress.

Should rfd_num == 0 be rejected, or the RRD consumed, explicitly? It's not
known whether the hardware ever produces such a descriptor.

>  		}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261103225218.19206-1-federico%40rimpianto.com

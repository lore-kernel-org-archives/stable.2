Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DA04F4CE5;
	Wed, 14 Oct 2026 11:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791976709; cv=none; b=E+tODpeCgk4NKRnv5As+6aarWfzA2VUAjUkwH/t29p4XtqSXVQjfn2ftOGTgNhm+F2Zmss9SGK15n5z9hHvLAszrvHMV6VnT3Y1jzWCzkcfJXnt3BiFfD8dzQKLvBoh4tWb1AOkBBeGh1k2crk2ihbbaTBAf3zIesAoJbXSCYXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791976709; c=relaxed/simple;
	bh=ewLYliVnd7ZSeqBWV78N1KQN4ewFXoJr8g+sAgKHTSc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ye3tuxaWCJ8Y3rdARoAIErtHo/MMXmJmuYYFManbSX72Esv99KFVUZ3puGohAzpIYia1kt/C0WdzCNvFVkr5lysZeBmSbzpmqhXJJis0YRIzhvQ0qhnPPieEQitZZdsFI9WHqs3GErSryodutcCdMnaiPXM5RTbNw7d+CKnYFpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qaks0+1v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qaks0+1v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1236D1F000FF;
	Wed, 14 Oct 2026 11:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791976707;
	bh=x2RmlG7/DNYZUkvwHEdu2BFerSCe0Wm/zWi/nMGE3w8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Qaks0+1vUnFVnAJ6FriPFKUNetLcAC1DPv96J8mSSVYvGzGfnL/2OlwNNU5JDurnw
	 mJ0LYwDvco1gVb6P4OYkM7lhuyhmIdvN+7hzlflYhhu3zG3t12lAd1WU8s5Ir0MdCL
	 yiHursUipQ/K0e2d3Bn3CbqHGeM5aUn5/JLpgNAIAvkAGDctGjHMDfYpen6vFilY4M
	 buVkjRo0BnuMBFz/I603xEyP8qfPHNximqzvF9ZKR5T13uQDpK/fXuAJ17Yr/vVogo
	 8h7d6Aw8UnkL4PYto/AhYVw0PvvndnBG0r+nBmQ3bZxr28+QNU541e9h1l1imBZC5m
	 NC7Eu8P7PNTyQ==
Subject:
 Re: [PATCH net] net: sunhme: fix infinite loop in unmap_partial_tx_skb()
From: netdev-bot+sashiko@kernel.org
To: arefev@swemel.ru
Cc: seanga2@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org, stable@vger.kernel.org
Date: Wed, 14 Oct 2026 11:18:26 +0000
Message-ID: <179197670661.434549.16333488251778765478@kernel.org>
In-Reply-To: <20261013103228.37430-1-arefev@swemel.ru>
References: <20261013103228.37430-1-arefev@swemel.ru>
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

Critical: 0 · High: 1 (1) · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] net: sunhme: MAC processes unmapped memory due to stale
  TXFLAG_OWN

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the patch
  makes it reachable.

--

net: sunhme: fix infinite loop in unmap_partial_tx_skb()

This commit fixes the loop in unmap_partial_tx_skb(), which never advanced
first_entry. Before the fix, a DMA mapping failure on any fragment after
the first one made happy_meal_start_xmit() spin forever with
hp->happy_lock held. The fix adds NEXT_TX() at the end of the loop body.

> diff --git a/drivers/net/ethernet/sun/sunhme.c b/drivers/net/ethernet/sun/sunhme.c
> index a70f704eb9f3f..544eb43af1258 100644
> --- a/drivers/net/ethernet/sun/sunhme.c
> +++ b/drivers/net/ethernet/sun/sunhme.c
> @@ -1965,6 +1965,7 @@ static void unmap_partial_tx_skb(struct happy_meal *hp, u32 first_mapping,
>  		len = hme_read_desc32(hp, &this->tx_flags);
>  		len &= TXFLAG_SIZE;
>  		dma_unmap_page(hp->dma_dev, addr, len, DMA_TO_DEVICE);
> +		first_entry = NEXT_TX(first_entry);

[Severity: High]
This isn't a bug introduced by this patch, but now that the error path
no longer locks up, it becomes reachable. It came in with ec1f1276022e
together with the missing NEXT_TX().

Once the fragment mappings are undone here, are those descriptors still
owned by the hardware?

happy_meal_start_xmit() sets TXFLAG_OWN in tx_flags and writes each
fragment descriptor with hme_write_txd() as soon as skb_frag_dma_map()
succeeds. Only the head descriptor at first_entry is held back. If a
later fragment fails to map, unmap_partial_tx_skb() calls
dma_unmap_page() on the fragment entries that were already staged, but
never rewrites them. Each one keeps TXFLAG_OWN, its length and a
tx_addr that is no longer mapped.

The out_dma_error path then leaves hp->tx_new at first_entry, sets
hp->tx_skbs[hp->tx_new] to NULL and frees the skb with
dev_kfree_skb_any(), which releases the fragment pages or swiotlb
slots.

If the next transmit is a linear skb such as a TCP ACK, it only writes
first_entry with OWN|SOP|EOP and kicks the engine with ETX_TP_DMAWAKEUP.
Could the MAC then move on to first_entry + 1, find OWN still set, and
DMA from the unmapped bus address? Depending on the platform that would
be an IOMMU fault, a TX DMA error and chip reset, or freed or reused
memory sent onto the wire. The stale chain also has no SOP, and no EOP
on its last descriptor.

After that the chip's ring position would be ahead of hp->tx_new.
Descriptors the driver later writes into those slots would sit behind
the hardware, and happy_meal_tx() stops at the first entry that still
has TXFLAG_OWN set. Would that stall TX completions until the ring
wraps or the TX watchdog resets the chip?

Should unmap_partial_tx_skb() also clear each descriptor after
unmapping it, for example with hme_write_txd(hp, this, 0, 0)? That
could also be a separate follow-up if you prefer to keep this fix
minimal for stable.

[Severity: High]

This isn't a bug introduced by this patch, but the patch makes it reachable
now that this error path returns instead of locking up. It came in with
ec1f1276022e together with the loop bug.

Once the fragment mappings are undone, are these descriptors still owned
by the hardware?

In happy_meal_start_xmit(), tx_flags always includes TXFLAG_OWN. Each
fragment is written to the ring as soon as it is mapped, and only the head
descriptor is held back:

drivers/net/ethernet/sun/sunhme.c:happy_meal_start_xmit() {
    ...
	tx_flags = TXFLAG_OWN;
    ...
			this_txflags = tx_flags;
			if (frag == skb_shinfo(skb)->nr_frags - 1)
				this_txflags |= TXFLAG_EOP;
			hme_write_txd(hp, &hp->happy_block->happy_meal_txd[entry],
				      (this_txflags | (len & TXFLAG_SIZE)),
				      mapping);
    ...
}

If fragment k+1 (with k >= 1) fails skb_frag_dma_map(),
unmap_partial_tx_skb() calls dma_unmap_page() on entries first_entry+1
through first_entry+k. It never rewrites those descriptors, so each one
keeps TXFLAG_OWN, its length and its now-unmapped tx_addr.

The error path then leaves hp->tx_new at first_entry and frees the skb,
which releases the fragment pages or swiotlb slots:

out_dma_error:
	hp->tx_skbs[hp->tx_new] = NULL;
	spin_unlock_irq(&hp->happy_lock);

	dev_kfree_skb_any(skb);

Suppose the next transmit is a linear skb, such as a TCP ACK. It writes
only first_entry with OWN|SOP|EOP and then kicks the DMA engine:

	hme_write32(hp, hp->etxregs + ETX_PENDING, ETX_TP_DMAWAKEUP);

Could the device then move on to first_entry+1, find OWN still set, and
DMA from the unmapped bus address? Depending on the platform, that would
mean an IOMMU fault, or freed or reused memory sent onto the wire. The
stale descriptors also form a chain with no SOP, and no EOP on the last
staged fragment.

After that, the device's ring position would be ahead of the driver's.
Descriptors the driver later writes into those slots would sit behind the
device. happy_meal_tx() stops at the first one with OWN still set:

		flags = hme_read_desc32(hp, &this->tx_flags);
		if (flags & TXFLAG_OWN)
			break;

Would that stall TX completions until the ring wraps or the TX watchdog
resets the chip?

Should unmap_partial_tx_skb() also clear each descriptor after unmapping
it, for example with hme_write_txd(hp, this, 0, 0)?

>  	}
>  }
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261013103228.37430-1-arefev%40swemel.ru

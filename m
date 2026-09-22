Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2E64D4868;
	Tue, 22 Sep 2026 07:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790063069; cv=none; b=K1YrwdVHDCnJLktIlVkWketWPBvUNplkkAKlj1vi8ilxkGkdMufrcCQj7je7cqiflvP296pRQNxkLNgh55TD/92PxzJCl1haeq8VgyFgc8luxcN3Ikt8Alm/TU4HexOK6Jc1V09cBrPx9FLg0uIQJwpWCw/5stjKv4CxlpBdBrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790063069; c=relaxed/simple;
	bh=BLSRwa20kCE7EArPXcKQr5kZ43kSG+lur4OacCc6AJ4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k3UUs2JFOz2FhFawt5tdAvRP3+Bcqx4V86OtUsRLzeTkeaIAUAHLepUO2ucaiyagcNdWHIXgsjA9lB3liY0GakaLdLNPGDhE2+JHfkswADadorSiYlNbwjPRCQWOVR56o9JK0H+aAkoLaeWSXrYVNZqo6nDxm/+yv94sMvk67uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7AtoFqx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7AtoFqx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FF571F00898;
	Tue, 22 Sep 2026 07:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790063062;
	bh=Dc+7ht9AUxPqxIO1kN1mC4z7K0gjkXpcd+T6+V+HMG0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=T7AtoFqxlZ/L+zN5uj4QcwJz6QQnFP0ptj2oDUI76ZNHH+kAAt3xl1hQwpzKe/bdJ
	 mftNDZI88BJLbF++syCex3dTKWYy/vbolwaNjm5+HG7XSiEirMde/O2GaP/crp3m0L
	 mLLcAZ0/VG16GAQ0VCduqLPCqLHGPqhgeV8ucaOJJTktIJO4AMgOjJY32y040wgcS/
	 vWdlIQiCGw901fvd5l7IBQiwzlnZPrAXpoMi6bDfZcnBRhppvKj8m3oUjgeia4aaZD
	 W5rmHQabUIeRpPv9xdz7YaE90y163qrfSiKI8jzzpdu+94jEyJ73sIqq85pq8YKtUv
	 Dn0edq1huV68Q==
Subject: Re: [PATCH net v2 4/4] ieee802154: mcr20a: fix 1-byte out-of-bounds
 read in mcr20a_handle_tx()
From: netdev-bot+sashiko@kernel.org
To: benquike@gmail.com
Cc: alex.aring@gmail.com, miquel.raynal@bootlin.com, stefan@datenfreihafen.org,
 linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, kuba@kernel.org
Date: Tue, 22 Sep 2026 07:44:21 +0000
Message-ID: <179006306173.2160803.2024412371470708989@kernel.org>
In-Reply-To: <20260921074207.2289391-4-benquike@gmail.com>
References: <20260921074207.2289391-4-benquike@gmail.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 (1) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message of "ieee802154: mcr20a: fix 1-byte out-of-
  bounds read in mcr20a_handle_tx()" misrepresents the severity of the…

Pre-existing issues:
- [High] Unhandled spi_async() failure in the TX state machine leaks the
  skb and wedges the TX queue forever.

--

ieee802154: mcr20a: fix 1-byte out-of-bounds read in mcr20a_handle_tx()

This drops the "+ 1" from lp->tx_xfer_buf.len in mcr20a_handle_tx(), so the
payload SPI transfer now clocks out exactly lp->tx_skb->len bytes instead of
one extra byte. The 1-byte psduLength prefix is already carried by the
separate lp->tx_xfer_len transfer.

A couple of questions below, one about the commit message and one about the
error path that the hunk touches.

>     In mcr20a_handle_tx(), the 1-byte psduLength prefix (lp->tx_len[0]) is
>     already sent in a separate SPI transfer (lp->tx_xfer_len), while
>     lp->tx_xfer_buf transfers the payload from lp->tx_skb->data. Setting
>     lp->tx_xfer_buf.len = lp->tx_skb->len + 1 causes the SPI transfer to read
>     1 byte past the end of lp->tx_skb->data:
>
>       BUG: KASAN: slab-out-of-bounds in mcr20a_handle_tx+0xf5/0x150
>       Read of size 17 at addr ffff8880057f7500 by task init/1
>       ...
>       The buggy address belongs to the object at ffff8880057f7500
>        which belongs to the cache kmalloc-16 of size 16

[Severity: Medium]
Can this splat actually be produced by the driver's own TX path?

lp->tx_skb comes from mac802154 via mcr20a_xmit(), and an skb head allocated
by __alloc_skb()/kmalloc_reserve() is always sized as the data area plus
SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) inside one slab object.
sizeof(struct skb_shared_info) alone is a few hundred bytes, so an skb head
cannot live in kmalloc-16, and skb->data[skb->len] always lands inside the
same allocation (tailroom or shared info) where KASAN has no redzone to
report.

The last paragraph says:

>     Tested in QEMU with KASAN enabled by transferring a 16-byte tx_skb->data
>     buffer in mcr20a_handle_tx().

Would it be clearer to state up front that the trace comes from an
instrumented/synthetic buffer rather than from a normal transmit, and to
describe the real effect instead?

As far as I can tell the real effect is that one byte of unrelated
in-allocation memory was clocked into the transceiver packet buffer at the
first FCS position, which the chip then overwrites because mcr20a_hw_setup()
sets IEEE802154_HW_TX_OMIT_CKSUM and the hardware generates the FCS itself.
That reads as a correctness fix with no kernel memory-safety violation and
no over-the-air leak, which matters for how stable maintainers judge the
Cc: stable tag.

The code change itself looks right: mcr20a_setup_tx_spi_messages() already
sends psduLength as its own transfer:

	lp->tx_xfer_len.len = 1;
	lp->tx_xfer_len.tx_buf = lp->tx_len;

and at86rf230_write_frame() uses the same layout (length byte = skb->len + 2,
payload = skb->len bytes).

> diff --git a/drivers/net/ieee802154/mcr20a.c b/drivers/net/ieee802154/mcr20a.c
> index ee3c1e67ef60..d7e076397550 100644
> --- a/drivers/net/ieee802154/mcr20a.c
> +++ b/drivers/net/ieee802154/mcr20a.c
> @@ -867,8 +867,7 @@ mcr20a_handle_tx(struct mcr20a_local *lp)
>  	/* add 2 bytes of FCS */
>  	lp->tx_len[0]		= lp->tx_skb->len + 2;
>  	lp->tx_xfer_buf.tx_buf	= lp->tx_skb->data;
> -	/* add 1 byte psduLength */
> -	lp->tx_xfer_buf.len	= lp->tx_skb->len + 1;
> +	lp->tx_xfer_buf.len	= lp->tx_skb->len;
>  
>  	ret = spi_async(lp->spi, &lp->tx_buf_msg);
>  	if (ret) {

[Severity: High]
This isn't a bug introduced by this patch, but since the hunk sits right
above it: does this error path leak lp->tx_skb and stall the TX queue for
good?

	ret = spi_async(lp->spi, &lp->tx_buf_msg);
	if (ret) {
		dev_err(printdev(lp), "SPI write Failed for TX buf\n");
		return ret;
	}

On failure the message is never submitted, so no completion callback runs.
lp->tx_skb is neither completed nor freed and lp->is_tx stays 1. The only
caller discards the return value:

mcr20a_irq_clean_complete() {
	...
	case (DAR_IRQSTS1_SEQIRQ):
		if (lp->is_tx) {
			dev_dbg(printdev(lp), "TX is starting\n");
			mcr20a_handle_tx(lp);
	...
}

Meanwhile ieee802154_tx() in net/mac802154/tx.c already did
ieee802154_hold_queue() and atomic_inc(&local->phy->ongoing_txs) when the
earlier drv_xmit_async() (mcr20a_xmit()) returned 0, and only
mcr20a_handle_tx_complete() -> ieee802154_xmit_complete() undoes that. So
the queue is never woken and ongoing_txs stays non-zero.

Does that then make ieee802154_sync_queue() wait forever?

net/mac802154/tx.c:ieee802154_sync_queue() {
	...
	wait_event(local->phy->sync_txq, !atomic_read(&local->phy->ongoing_txs));
	...
}

There is no timeout and no alternative wake condition, so any MLME operation
going through ieee802154_mlme_op_pre() would block indefinitely.

spi_async() can fail for real reasons: -EBUSY when ctlr->bus_lock_flag is
set by a concurrent spi_bus_lock() user, or an error propagated from
spi_maybe_optimize_message()/__spi_async().

Would ieee802154_xmit_error(lp->hw, lp->tx_skb, IEEE802154_SYSTEM_ERROR),
or ieee802154_wake_queue() plus kfree_skb(), together with clearing
lp->is_tx, be the right handling here?

mcr20a_write_tx_buf_complete() looks to have the same gap for the SEQ TX
register write:

	ret = spi_async(lp->spi, &lp->reg_msg);
	if (ret)
		dev_err(printdev(lp), "failed to set SEQ TX\n");

Should that path also release the skb and the queue?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921074207.2289391-1-benquike%40gmail.com

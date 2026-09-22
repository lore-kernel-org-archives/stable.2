Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E57543E066;
	Tue, 22 Sep 2026 08:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790065951; cv=none; b=dKZpbyg/V2SL1RWwHS5OZ/hBh+iqLz6HttRYJ3NezFhQTgJaVcCFBS84tHELBqgZAIJo1NRafLRYRCtC/sOiWwbEGR8Ovy/fj9YQYz6tF4PSn4e+bH+ZDuTppqElyHWeYAhqv7i5SOAN7nfSx8cW2ntpEfeXgJJ2dqJhoLkX3mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790065951; c=relaxed/simple;
	bh=4sqCU4zBHWOSgXUR2rs8X2LWH7/he4c8zE7n+HH4q/s=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=StRNj0kujFpEVkUbo4I8a0pLHlXv4Z7AI5gNNe/IWL1rQctGuCG4kB3Ybe16AcIp7d8TuJ9CcnO11pQVVK85lLASekO8QTye/ku7LdpFF/d6UsaaeBujQYP+zYxB+28gx9Uo8/k9Keng9yKgZSLIQRiQqiMsGLtB1W4oj4jaMRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kfySsA+M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kfySsA+M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D981F00898;
	Tue, 22 Sep 2026 08:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790065948;
	bh=Ju9mNb1Cqn3qRuavXl8s4qxRg3Qp7mnO/3stNcEh5b4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kfySsA+MLazd0qzSGjwF3xxrsGMa57aR1QqFjFYA6CLapL8vSeMddJtRP0fqS1dgJ
	 Bp2ndWelgEpUhEu9ZaLTZwuoJE308CYLSZSJGtdH3oLBSmGqgwLNi09wFekOMbentA
	 Prtdf/oH8kfEDP7rtCNNUNNoYsnkvPSvxP9URcJ2LreycHgdh/3orf25ZdvUVz/wmv
	 8oWYPaKzQlOzptepfmcOWYFG8+QzlwVm9GvZx5HUfBMbX0pPWw2XszKrjg1kByLXJs
	 A/6WQ3tpKOKE5fF1VZiIdlEn6cEybseqOFrBpBHfIFo+YQK3/YNXrgV7pSzuwI0F7m
	 5QMfR0YFzpxHw==
Subject: Re: [PATCH net v2 3/3] ieee802154: ca8210: validate data_ind length
 upfront in ca8210_skb_rx()
From: netdev-bot+sashiko@kernel.org
To: benquike@gmail.com
Cc: h.morris@cascoda.com, alex.aring@gmail.com, miquel.raynal@bootlin.com,
 stefan@datenfreihafen.org, linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, kuba@kernel.org
Date: Tue, 22 Sep 2026 08:32:27 +0000
Message-ID: <179006594782.2160803.17929419446576675162@kernel.org>
In-Reply-To: <20260921074205.2289211-3-benquike@gmail.com>
References: <20260921074205.2289211-3-benquike@gmail.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 3 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message misrepresents the defect being fixed.
- [Medium] The patch silently changes `struct ieee802154_hdr hdr;` to
  `struct ieee802154_hdr hdr = { };` in ca8210_skb_rx()…
- [Medium] The consolidated validation is placed in the callee, but the
  caller already parses the same MCPS_DATA_indication at a fixed offset…
- [Low] The newly added validation and the code it protects read
  priv->promiscuous twice, with no snapshot, lock, or READ_ONCE().

--

ieee802154: ca8210: validate data_ind length upfront in ca8210_skb_rx()

This moves all length and msdulen validation for an MCPS_DATA_indication to
the top of ca8210_skb_rx(), before dev_alloc_skb(), and adds a check that the
declared SPI frame length covers the payload and the optional security header.
The struct ieee802154_hdr on the stack is also changed to be zero-initialised.

First, a question about the commit message itself:

>     In ca8210_skb_rx(), data_ind is read at offsets 22 (msdulen), 23
>     (mpdulinkquality), 29 + msdulen (hdr.sec.level), 30..39 + msdulen
>     (security header), and 29 .. 29 + msdulen (payload) without verifying
>     that the received SPI frame length len covers those offsets, causing an
>     out-of-bounds read when msdulen exceeds len - 30:
>
>       BUG: KASAN: slab-out-of-bounds in ca8210_skb_rx.constprop.0.isra.0+0x137/0x160
>       ...
>       The buggy address belongs to the object at ffff888006453dc0
>        which belongs to the cache kmalloc-32 of size 32

[Severity: Medium]
Can this kmalloc-32 slab-out-of-bounds actually be reached in-tree?  There is
only one caller of ca8210_skb_rx(), and it passes a pointer into a fixed-size
array rather than a len-sized allocation:

drivers/net/ieee802154/ca8210.c:ca8210_net_rx() {
	...
	return ca8210_skb_rx(hw, len - 2, command + 2);
	...
}

command is always cas_ctl->tx_in_buf:

struct cas_control {
	...
	u8 tx_buf[CA8210_SPI_BUF_SIZE];
	u8 tx_in_buf[CA8210_SPI_BUF_SIZE];
	...
};

With msdulen rejected above IEEE802154_MTU (127), the highest byte the parser
can touch is data_ind[39 + 127], i.e. tx_in_buf[168], which is inside the
256-byte array, and the payload copy tops out at tx_in_buf[157].  The same
was true before the patch.

The test note also suggests the splat comes from calling the static function
directly rather than from the driver path:

>     Tested in QEMU with KASAN enabled by passing a short data_ind buffer with
>     msdulen = 64 and len = 30 into ca8210_skb_rx().

What the driver does appear to do without the new checks is consume bytes
beyond the firmware-declared frame length (leftover bytes of the same SPI
exchange, or SPI_IDLE fill) and copy them into the skb handed to
ieee802154_rx_irqsafe() - a stale/garbage frame rather than memory
corruption.  Given the Fixes: tag and Cc: stable, would it be worth
rewording the message so backporters do not triage this as a remotely
triggerable slab out-of-bounds read?

> diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
> index 1de63142a45a..2aa7d8c8ae00 100644
> --- a/drivers/net/ieee802154/ca8210.c
> +++ b/drivers/net/ieee802154/ca8210.c
> @@ -1759,19 +1759,15 @@ static int ca8210_skb_rx(
>  	u8                    *data_ind
>  )
>  {
> -	struct ieee802154_hdr hdr;
> +	struct ieee802154_hdr hdr = { };

[Severity: Medium]
Should this hunk be described in the commit message?  The body only mentions
consolidating the length and msdulen validation, but this line looks like a
separate fix with a visible behaviour change.

ca8210_skb_rx() never assigns hdr.seq, hdr.sec.frame_counter, or the fc bits
frame_pending/ack_request/version/reserved, yet ieee802154_hdr_push()
serialises them unconditionally:

net/ieee802154/header_ops.c:ieee802154_hdr_push() {
	...
	buf[pos++] = hdr->seq;
	...
	memcpy(buf, fc, 2);
	...
}

and for security-enabled frames:

net/ieee802154/header_ops.c:ieee802154_hdr_push_sechdr() {
	...
	memcpy(buf + 1, &hdr->frame_counter, 4);
	...
}

So before this change, every non-promiscuous received frame carried a few
bytes of uninitialised stack in the reconstructed MAC header delivered to the
802.15.4 stack.  Zeroing closes that, but also makes the reported sequence
number always 0 and clears the fc bits.  Would it make sense to split this
out with its own description and Fixes: tag?

>  	int msdulen;
>  	int hlen;
> -	u8 mpdulinkquality = data_ind[23];
> +	u8 mpdulinkquality;
>  	struct sk_buff *skb;
>  	struct ca8210_priv *priv = hw->priv;
>  
> -	/* Allocate mtu size buffer for every rx packet */
> -	skb = dev_alloc_skb(IEEE802154_MTU + sizeof(hdr));
> -	if (!skb)
> -		return -ENOMEM;
> -
> -	skb_reserve(skb, sizeof(hdr));
> +	if (len < 30)
> +		return -EMSGSIZE;

[Severity: Medium]
Is the callee the right place for this check, given that the only caller
already parses the same indication at a fixed offset first?

drivers/net/ieee802154/ca8210.c:ca8210_net_rx() {
	...
	spin_lock_irqsave(&priv->lock, flags);
	if (command[26] == priv->last_dsn) {
		...
		return 0;
	}
	priv->last_dsn = command[26];
	spin_unlock_irqrestore(&priv->lock, flags);
	return ca8210_skb_rx(hw, len - 2, command + 2);
	...
}

command[26] is data_ind[24], which is inside the region the new len >= 30
check is meant to guarantee.  len itself comes straight from the device:

drivers/net/ieee802154/ca8210.c:ca8210_rx_done() {
	...
	len = buf[1] + 2;
	if (len > CA8210_SPI_BUF_SIZE) {
	...
}

only the upper bound is checked, so a declared length of 2..31 still reaches
the offset-26 read.  Can that latch priv->last_dsn from a byte outside the
declared frame, so that a later genuine frame whose DSN matches is dropped as
a resend, even though the frame that set it is then rejected with -EMSGSIZE?
Would moving the validation (or the last_dsn update) ahead of the DSN read
close that gap?

>  
>  	msdulen = data_ind[22]; /* msdu_length */
>  	if (msdulen > IEEE802154_MTU) {
> @@ -1779,9 +1775,25 @@ static int ca8210_skb_rx(
>  			&priv->spi->dev,
>  			"received erroneously large msdu length!\n"
>  		);
> -		kfree_skb(skb);
>  		return -EMSGSIZE;
>  	}
> +
> +	if (len < 30 + msdulen ||
> +	    (!priv->promiscuous && data_ind[29 + msdulen] > 0 &&
> +	     len < 29 + msdulen + sizeof(struct secspec))) {

[Severity: Low]
This check and the code it protects read priv->promiscuous twice, with no
snapshot, lock or READ_ONCE().  The stronger bound (len >= 40 + msdulen) is
only applied here when !priv->promiscuous, and the decision to parse the
security header is taken from a second read further down:

	if (priv->promiscuous)
		goto copy_payload;

	/* Populate hdr */
	hdr.sec.level = data_ind[29 + msdulen];
	...
		hdr.sec.key_id = data_ind[39 + msdulen];

priv->promiscuous is a plain bool written from ca8210_set_promiscuous_mode()
in process context and from ca8210_reset_send(), while the RX path runs from
ca8210_spi_transfer_complete() -> ca8210_rx_done() -> ca8210_net_rx() ->
ca8210_skb_rx().

If the flag goes true to false (or is simply reloaded) between the two reads,
does the security header parse then run on a frame only validated to
30 + msdulen bytes, reading up to 10 bytes past the declared frame length and
pushing them into the reconstructed header?  Would taking one snapshot at
entry, or making the len >= 40 + msdulen requirement unconditional whenever
the security-level byte is non-zero, be preferable?

> +		dev_err(&priv->spi->dev,
> +			"received truncated data indication!\n");
> +		return -EMSGSIZE;
> +	}
> +
> +	mpdulinkquality = data_ind[23];
> +
> +	/* Allocate mtu size buffer for every rx packet */
> +	skb = dev_alloc_skb(IEEE802154_MTU + sizeof(hdr));
> +	if (!skb)
> +		return -ENOMEM;
> +
> +	skb_reserve(skb, sizeof(hdr));

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921074205.2289211-1-benquike%40gmail.com

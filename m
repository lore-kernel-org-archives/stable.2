Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAF440F751;
	Thu, 24 Sep 2026 06:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790232133; cv=none; b=tSb4cMcEmHOvnAtIxFFkhziQptPcc+brqxz0OfDSYJt6BPoUEhPqfTybKPW/mlGJ3/+b5acMQRNWqPRjoM3wWwThU0sJYCCa+2xJnFruk9cppzjSkBuTNk2SNs3KI6oQK5Asy5LzQZuvi6P2XsG6eZSz6h2w3sMUvkClhKKEYW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790232133; c=relaxed/simple;
	bh=td/yYbK5bI9dc6tX4363U6k7tYns3zAOy5tt+729Nmc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GieT57whrkNmpQtrBCTpYismxzKeSlMypBVMzb+wDqsi5CjkIky8cZVnmoVsOIFjPcS4PLyLXgxSTRs/wiXQGOvV8WvjFnVMyMmQFDRJIbSP2AyUTpnFNYlx4KZRC92pLWP/hQRGFHLGckxTmW2ytH1U0uD/dEe/thBYm9s8YPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KXyIqLhn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KXyIqLhn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F2A41F00893;
	Thu, 24 Sep 2026 06:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790232127;
	bh=82h3I6umrt5O91bmGNbUEmaj8zSJsKMS+EBgEvVmPFc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KXyIqLhnXytpzFI7IZeCO5BhL/vj/PvtaJVayljpRW5rVIkTQhucPQpUypZK0UhAU
	 3dyZ490AL43pzQ8fYju0+L0ouw5AZcTRk9nyLbJDsm0eyYdEv3OhKbWLwFb+DNJyX+
	 nLo1AqcI8gxeuUtidU8fSwDlbUmKPDASFhSxVKrtdQHDwO58l0ceSDEwkqPh64sFqK
	 vJHMZVHS2eZFUMpnsOMzBtmuSoig/pR3YPsCDVgxv+K/r3F2xa2UeEKH/s/zfgUgoy
	 AmrP2Ia5S1MTeonAAsPI0oTK6x+KdGfzbE0q64HRCHgSCue5cb2hEhYxmaELKNy/yA
	 KxOWIL4V/U4Nw==
Subject: Re: [PATCH net v3 3/3] ieee802154: ca8210: validate data_ind length
 upfront in ca8210_skb_rx()
From: netdev-bot+sashiko@kernel.org
To: benquike@gmail.com
Cc: h.morris@cascoda.com, alex.aring@gmail.com, miquel.raynal@bootlin.com,
 stefan@datenfreihafen.org, david.laight.linux@gmail.com,
 linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, kuba@kernel.org
Date: Thu, 24 Sep 2026 06:42:06 +0000
Message-ID: <179023212677.2160803.12604531347108623270@kernel.org>
In-Reply-To: <20260922093126.141969-4-benquike@gmail.com>
References: <20260922093126.141969-4-benquike@gmail.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 3 · Low: 0 (2)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message mischaracterises the defect: it pastes a
  KASAN "slab-out-of-bounds ... kmalloc-32 of size 32" report and…
- [Medium] The patch silently changes 'struct ieee802154_hdr hdr;' to
  'struct ieee802154_hdr hdr = { };' (ca8210.c:1761) without mentioning…
- [Medium] The new consolidated validation in ca8210_skb_rx() gates the
  security-header length check on priv->promiscuous…

Pre-existing issues:
- [Low] ca8210_net_rx() reads command[26] (== data_ind[24], the DSN of an
  MCPS_DATA_INDICATION) and latches it into priv->last_dsn…
- [Low] Concern (reported for completeness, assessed as not actionable):
  hdr is now explicitly zero-initialized and no path assigns hdr.seq,…

--

ieee802154: ca8210: validate data_ind length upfront in ca8210_skb_rx()

This moves all length and msdulen validation in ca8210_skb_rx() into a
single check at the top of the function, before dev_alloc_skb(), and adds
a new check that the reported SPI frame length covers the payload and the
optional security header.  The hdr declaration is also changed to be
zero-initialized.

A few questions below.

> In ca8210_skb_rx(), data_ind is read at offsets 22 (msdulen), 23
> (mpdulinkquality), 29 + msdulen (hdr.sec.level), 30..39 + msdulen
> (security header), and 29 .. 29 + msdulen (payload) without verifying
> that the received SPI frame length len covers those offsets, causing an
> out-of-bounds read when msdulen exceeds len - 30:
>
>   BUG: KASAN: slab-out-of-bounds in ca8210_skb_rx.constprop.0.isra.0+0x137/0x160
>   Read of size 64 at addr ffff888006453ddd by task init/1
> ...
>   The buggy address belongs to the object at ffff888006453dc0
>    which belongs to the cache kmalloc-32 of size 32

[Severity: Medium]
Can this slab-out-of-bounds actually be reached from the driver's receive
path?

ca8210_skb_rx() has one caller chain:

  ca8210_spi_transfer_complete() -> ca8210_rx_done() -> ca8210_net_rx()
    -> ca8210_skb_rx(hw, len - 2, command + 2)

and the buffer is always cas_ctl->tx_in_buf, a fixed array embedded in a
kzalloc'd struct cas_control:

drivers/net/ieee802154/ca8210.c:
    struct cas_control {
        ...
        u8 tx_in_buf[CA8210_SPI_BUF_SIZE];
    ...
    };

with CA8210_SPI_BUF_SIZE == 256, not a kmalloc-32 allocation.  Since the
pre-existing check caps msdulen at IEEE802154_MTU (127), the furthest byte
the unpatched code can touch is data_ind[39 + 127] == tx_in_buf[168], and
skb_put_data() copies tx_in_buf[31..157] — all inside the 256-byte array.

The changelog's own note:

> Tested in QEMU with KASAN enabled by passing a short data_ind buffer with
> msdulen = 64 and len = 30 into ca8210_skb_rx().

suggests the splat came from a synthetic direct call on a 32-byte buffer
rather than from the SPI receive path.  On the real path the observable
effect of the missing checks looks like stale SPI buffer bytes (idle fill
0xFF, or residue from a previous exchange) being copied into the skb and
into hdr.sec, which is a data-integrity issue rather than memory
corruption.

Could the commit message describe the actual in-tree consequence, and
could the Fixes:/Cc: stable rationale be restated accordingly so stable
triage isn't misled by the pasted KASAN report?

> diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
> index 8aa7ffeb22d78..ab245add9ff5c 100644
> --- a/drivers/net/ieee802154/ca8210.c
> +++ b/drivers/net/ieee802154/ca8210.c
> @@ -1758,19 +1758,15 @@ static int ca8210_skb_rx(
>  	u8                    *data_ind
>  )
>  {
> -	struct ieee802154_hdr hdr;
> +	struct ieee802154_hdr hdr = { };

[Severity: Medium]
Is this zero-initialization a separate fix that deserves a mention in the
changelog?

ieee802154_hdr_push() unconditionally emits the sequence octet and both
frame control bytes:

net/ieee802154/header_ops.c:ieee802154_hdr_push() {
	...
	buf[pos++] = hdr->seq;
	...
	memcpy(buf, fc, 2);
	memcpy(skb_push(skb, pos), buf, pos);
}

while ca8210_skb_rx() only assigns hdr.fc.type, hdr.fc.security_enabled,
hdr.fc.intra_pan and the two address-mode fields, and never assigns
hdr.seq, hdr.fc.version (outside the security path), hdr.fc.ack_request,
hdr.fc.frame_pending or the reserved bits.  Before this hunk those bytes
were uninitialized stack data pushed into every reconstructed header handed
to mac802154 via ieee802154_rx_irqsafe(); after it they are deterministic
zeros.

The only trace of this is below the --- line ("dropped the unrelated
hdr.seq assignment"), which does not end up in the git log.  Should the
changelog describe this behaviour change, or should the hunk be split into
its own patch?

[Severity: Low]
This isn't a bug introduced by this patch, but with hdr now explicitly
zeroed and no path assigning hdr.seq, every non-promiscuous frame is
reported upstream with sequence number 0, even though the driver does read
the real DSN from the same message in ca8210_net_rx():

	if (command[26] == priv->last_dsn) {

Previously the emitted octet was stack garbage, so this is unchanged in
kind, and the v2 changelog records that wiring up hdr.seq was dropped at
the maintainer's request.  Noting it only so the intent is on record.

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

[Severity: Low]
This is a pre-existing issue, but the caller parses the same message with
no minimum length at all, so the new "upfront" check is not the first
parse of the frame:

drivers/net/ieee802154/ca8210.c:ca8210_rx_done() {
	buf = cas_ctl->tx_in_buf;
	len = buf[1] + 2;
	if (len > sizeof(struct mac_message)) {
	...
}

drivers/net/ieee802154/ca8210.c:ca8210_net_rx() {
	...
	if (command[26] == priv->last_dsn) {
	...
	priv->last_dsn = command[26];
	spin_unlock_irqrestore(&priv->lock, flags);
	return ca8210_skb_rx(hw, len - 2, command + 2);
}

len is only bounded from above, so a data indication declaring buf[1] < 25
still has command[26] (== data_ind[24]) read and latched into
priv->last_dsn before ca8210_skb_rx() gets to reject it.  The read stays
inside tx_in_buf, but the byte is idle fill or residue, so last_dsn can be
poisoned and a later legitimate frame carrying that DSN is dropped as a
resend.

Would it make sense to also give ca8210_net_rx() a minimum length check
for SPI_MCPS_DATA_INDICATION, so both parsers of this message format agree
on its minimum size?

>  
>  	msdulen = data_ind[22]; /* msdu_length */
>  	if (msdulen > IEEE802154_MTU) {
> @@ -1778,9 +1774,25 @@ static int ca8210_skb_rx(
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
> +		dev_err(&priv->spi->dev,
> +			"received truncated data indication!\n");
> +		return -EMSGSIZE;
> +	}

[Severity: Medium]
Can the two reads of priv->promiscuous disagree here?

The security-header length check is gated on !priv->promiscuous above, but
the decision to actually parse the security header is a second, independent
read a few lines later:

	if (priv->promiscuous)
		goto copy_payload;

	/* Populate hdr */
	hdr.sec.level = data_ind[29 + msdulen];
	...
		hdr.sec.key_id_mode = data_ind[30 + msdulen];
		memcpy(&hdr.sec.extended_src, &data_ind[31 + msdulen], 8);
		hdr.sec.key_id = data_ind[39 + msdulen];

priv->promiscuous is a plain bool written without any lock, READ_ONCE() or
barrier:

drivers/net/ieee802154/ca8210.c:ca8210_set_promiscuous_mode() {
	...
		priv->promiscuous = on;
}

drivers/net/ieee802154/ca8210.c:ca8210_reset_send() {
	...
	priv->promiscuous = false;
}

and ca8210_net_rx() drops priv->lock before calling ca8210_skb_rx():

	spin_unlock_irqrestore(&priv->lock, flags);
	return ca8210_skb_rx(hw, len - 2, command + 2);

So if the flag reads true at the check and false at the use — for example
a monitor-mode toggle from ca8210_set_promiscuous_mode() landing between
the two — the "len < 29 + msdulen + sizeof(struct secspec)" branch is
never evaluated, yet data_ind[29 + msdulen] through data_ind[39 + msdulen]
are dereferenced.  That reads up to 11 bytes past the end of the frame the
length check validated (stale tx_in_buf contents), producing a fabricated
hdr.sec or an ieee802154_hdr_push() failure and a dropped frame, which is
the exact byte class this patch sets out to stop touching.

Would taking one snapshot, e.g.

	bool promisc = READ_ONCE(priv->promiscuous);

and using it for both the check and the parse decision, or validating the
security-header length unconditionally, close that window?

> +
> +	mpdulinkquality = data_ind[23];
> +
> +	/* Allocate mtu size buffer for every rx packet */
> +	skb = dev_alloc_skb(IEEE802154_MTU + sizeof(hdr));
> +	if (!skb)
> +		return -ENOMEM;
> +
> +	skb_reserve(skb, sizeof(hdr));
>  	dev_dbg(&priv->spi->dev, "skb buffer length = %d\n", msdulen);
>  
>  	if (priv->promiscuous)

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922093126.141969-1-benquike%40gmail.com

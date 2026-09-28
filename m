Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234E933A02B;
	Mon, 28 Sep 2026 06:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790577751; cv=none; b=sm20IneHwYFC0EcVOVrBJvFdmmxS8FqQMEGjrtU/G2SSTgfUzN5r8UJBX0soEVAW8b/xKUy//IfGqTpw82yDLMFcTJHalQFLKyB8GLnSeWgbNtRoZtl7l7DK4ZoxOQk6XF4RBmDwUpGRBJ5xgOhOD2qjUk+jH1Hz2zSS7LyIupE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790577751; c=relaxed/simple;
	bh=Zc1j8jFQvHth18qveTKKPro1b6xENUDmNtJla6AwZCw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J5soCH3NEFBEsBcRnRJ+lPsyBJFIoahMOR51BCisycBeGpOAXFa22AHF9InVOg2uGsn0AoGj/aXIIHYPqIc4gcQgc0DvDIPsstvDINegQYXazTJibgK3VA9EuZKU8oKEm/XH2a23cL3WQ2RY7VsPrSRegl7mZqjNtY3mE+FWJ88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QvWwE0aA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QvWwE0aA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6582A1F00893;
	Mon, 28 Sep 2026 06:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790577749;
	bh=npvHD8EvKMpzEAU+NXPuprys3FP0QvO5YG08kuqJMRs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QvWwE0aAVMW3BAnV2DKomGYr+KMaMkInOeiJMq+LSqvQDd570BAktE1Yj0CTEOLEO
	 gWXhBk3rYRWZW73CPlKRgPEUC91+wVya/YGdRItFPiFuBcFXF8ySCU4y04UebGh85m
	 D1PO9kt7jGkh+QO8VHUc+G/Xc3toNDNysNSfIZXlHBIs3nSTnyxXPgRKbjl3f/+Ybt
	 8ehIPjXiOoTeStVJ6uH8WPyrhZ52ps4/zKbDN6X6OV4LNVKMppz/3zzzYNrWnxKtIY
	 pUxfaXJYPJWmOdniHUgztk63iXhM8beMlh7HLuNc/N7DvizM1lbi1E9IGuE4ar4ddB
	 OMQzwTsNtZKqQ==
Subject: Re: [PATCH net v3 3/3] ieee802154: ca8210: validate data_ind length
 upfront in ca8210_skb_rx()
From: netdev-bot+sashiko@kernel.org
To: benquike@gmail.com
Cc: h.morris@cascoda.com, alex.aring@gmail.com, miquel.raynal@bootlin.com,
 stefan@datenfreihafen.org, david.laight.linux@gmail.com,
 linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, kuba@kernel.org
Date: Mon, 28 Sep 2026 06:42:28 +0000
Message-ID: <179057774899.3145.985018275093364264@kernel.org>
In-Reply-To: <20260924062244.2444225-4-benquike@gmail.com>
References: <20260924062244.2444225-4-benquike@gmail.com>
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

Critical: 0 · High: 1 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] ieee802154: ca8210: TOCTOU race on priv->promiscuous allows OOB
  read
- [Medium] The commit message overstates the impact.
- [Medium] The new upfront length check in ca8210_skb_rx() does not cover
  the first read of the MCPS-DATA.indication fields.
- [Low] The patch changes `struct ieee802154_hdr hdr;` to `struct
  ieee802154_hdr hdr = { };` in ca8210_skb_rx()…

--

ieee802154: ca8210: validate data_ind length upfront in ca8210_skb_rx()

This patch moves the length checks in ca8210_skb_rx() to the start of the
function, ahead of the skb allocation. It adds a minimum length check, a
check that len covers the msdu, and a check that len covers the security
header. It also zero-initialises the on-stack struct ieee802154_hdr.

>     In ca8210_skb_rx(), data_ind is read at offsets 22 (msdulen), 23
>     (mpdulinkquality), 29 + msdulen (hdr.sec.level), 30..39 + msdulen
>     (security header), and 29 .. 29 + msdulen (payload) without verifying
>     that the received SPI frame length len covers those offsets, causing an
>     out-of-bounds read when msdulen exceeds len - 30:
>
>       BUG: KASAN: slab-out-of-bounds in ca8210_skb_rx.constprop.0.isra.0+0x137/0x160
>       Read of size 64 at addr ffff888006453ddd by task init/1

[ ... ]

>       The buggy address belongs to the object at ffff888006453dc0
>        which belongs to the cache kmalloc-32 of size 32

[Severity: Medium]
Can the real driver produce this slab-out-of-bounds read? The only caller
of ca8210_skb_rx() is ca8210_net_rx(), which gets its buffer from
ca8210_rx_done():

drivers/net/ieee802154/ca8210.c:ca8210_rx_done() {
    ...
	buf = cas_ctl->tx_in_buf;
	len = buf[1] + 2;
    ...
	ca8210_net_rx(priv->hw, buf, len);
    ...
}

ca8210_net_rx() then does:

	return ca8210_skb_rx(hw, len - 2, command + 2);

tx_in_buf is a fixed u8 tx_in_buf[CA8210_SPI_BUF_SIZE] (256 bytes) that
sits inside struct cas_control. It is memset to SPI_IDLE before each
transfer.

msdulen is already capped at IEEE802154_MTU (127). So the highest byte
ca8210_skb_rx() can touch is tx_in_buf[2 + 39 + 127], which is inside the
object.

The kmalloc-32 splat seems to come from the test harness passing a 32-byte
buffer directly into ca8210_skb_rx(). The underlying problem looks like
missing validation of a truncated MCPS-DATA.indication, not a read outside
the allocation.

With Cc: stable attached, could the commit message describe the real
impact more precisely, so stable and CVE triage are not misled?

> diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
> index 8aa7ffeb22d7..ab245add9ff5 100644
> --- a/drivers/net/ieee802154/ca8210.c
> +++ b/drivers/net/ieee802154/ca8210.c
> @@ -1758,19 +1758,15 @@ static int ca8210_skb_rx(
>  	u8                    *data_ind
>  )
>  {
> -	struct ieee802154_hdr hdr;
> +	struct ieee802154_hdr hdr = { };

[Severity: Low]
This isn't a bug, but this change in behaviour isn't mentioned in the
commit message.

ieee802154_hdr_push() writes hdr->seq and the full 2-byte frame control
into the skb:

net/ieee802154/header_ops.c:ieee802154_hdr_push() {
    ...
	buf[pos++] = hdr->seq;
    ...
	memcpy(buf, fc, 2);

	memcpy(skb_push(skb, pos), buf, pos);
    ...
}

ca8210_skb_rx() never sets hdr.seq, fc.ack_request, fc.frame_pending, the
reserved fc bits or sec.frame_counter. Before this patch, uninitialised
stack bytes ended up in the reconstructed MAC header of every
non-promiscuous received frame. After this patch those fields are always
zero, so seq is 0 for every frame.

The v2 changelog says the hdr.seq assignment was dropped as unrelated.
Could this initialisation either get its own patch or be described in
this commit message? Otherwise a backporter might drop it as unrelated
and bring the stack data leak back.

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
This check runs only after the caller has already read and stored a
data_ind field. Is the upfront validation complete?

ca8210_rx_done() sets len = buf[1] + 2 and checks only an upper bound.
ca8210_net_rx() then reads the DSN (data_ind[24]) before any length check:

drivers/net/ieee802154/ca8210.c:ca8210_net_rx() {
    ...
	if (command[0] == SPI_MCPS_DATA_INDICATION) {
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

Suppose the device sends a truncated indication with buf[1] < 25. Then
command[26] is stale data or SPI_IDLE filler. It gets stored in
priv->last_dsn, and ca8210_skb_rx() then rejects the frame with -EMSGSIZE.

Wouldn't the next valid frame whose DSN matches that byte be silently
dropped as a resend? Should the minimum length check move ahead of the
command[26] access in ca8210_net_rx()?

>  
>  	msdulen = data_ind[22]; /* msdu_length */
>  	if (msdulen > IEEE802154_MTU) {

[ ... ]

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
>

[Severity: High]
Can priv->promiscuous change between the new truncation check and the
later promiscuous test that jumps to copy_payload?

With this patch ca8210_skb_rx() reads priv->promiscuous twice. The
first read decides whether the secspec length condition is applied. The
second read decides whether the security header is parsed:

	hdr.sec.level = data_ind[29 + msdulen];
	if (hdr.sec.level > 0) {
		hdr.sec.key_id_mode = data_ind[30 + msdulen];
		memcpy(&hdr.sec.extended_src, &data_ind[31 + msdulen], 8);
		hdr.sec.key_id = data_ind[39 + msdulen];
	}

ca8210_set_promiscuous_mode() writes priv->promiscuous from the
mac802154 .set_promiscuous_mode callback without taking priv->lock.
ca8210_skb_rx() does not hold priv->lock either, because
ca8210_net_rx() drops it before the call. The two reads are also
separated by dev_alloc_skb() and dev_dbg(), so the compiler has to
reload the field.

Suppose promiscuous mode is switched off between the two reads, and
the frame has len == 30 + msdulen and a non-zero security level. The
frame passes the new check with the secspec condition skipped. It then
falls through into the security header parsing, which reads
data_ind[30 + msdulen] .. data_ind[39 + msdulen]. That is up to 10
bytes past len, and those stale bytes end up in the MAC header pushed
onto the skb. This is exactly the access the new check is meant to
prevent.

Would it be better to sample the flag once, for example with a local
bool promiscuous = READ_ONCE(priv->promiscuous) at the top of the
function? That local could then be used for both the length check and
the goto to copy_payload.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260924062244.2444225-1-benquike%40gmail.com

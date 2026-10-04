Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43092E4257;
	Sun,  4 Oct 2026 07:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791099573; cv=none; b=CICB54ORhWYTvOkkxH3nstrRpIYVXRW0H4XtHtGYWE7te5q24+ndGxs0iYvnfFJik4WzD8EJCxKdpkZkmQXovBIIXIFfTKYXNgU1+jQbN6FImDSRGLAgjmeH+iI9JO513wpIzsNIh3d2Yfd+hT3bSvXrFKiJTt4lXm4v6e1I8hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791099573; c=relaxed/simple;
	bh=NffAOsD/RLNLka6XB70MGaXpERV5MUxvEURq64HeRq4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=opZLVLFBjK9ZoLv6DD0bUAeqpw+lBVOiuXHD/2qvMY1rLNNotucETnp6L8d3VyiwecGZBG/Hn+rlpJf+IMc20VbcUfsnMYiqWKmJxuASu2YuYE0xeUicqAqWyRbMGduWbv0g82Aqb6zZ1bZHexqIASl0kSFj2B0pVRQUzvEjxP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GrrM70DD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GrrM70DD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D4041F00898;
	Sun,  4 Oct 2026 07:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791099570;
	bh=lSUoBFfGhuHMZDOmmp8eSQSG+S5lhuHFHUZbk7wvcRI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GrrM70DDvdwWLuma+G0MU6S424LsQAXkoqZisDyg5PUEjo+by6ZsC/pLTj/LmovLO
	 oiFiTbRMfLwZ0mKqj7Pg0hr/YC5MTw7dtj5UDji4ByMEkhyxTooXHRRycHYOdJl0ku
	 wznnUoTwA+ZqQyp1VCBPBzkn6IxM8mG6fl8FwLNX6e4RcgUGV1yG5JIXfuJqns9c16
	 RBjK3FZfOzh212DAeUQtA2iKuNCf+uRsq+rHYhsafo744+IoL1fwT0jg4Z/mwSui08
	 F5cUUzKPrskTNN0VT9w/qIrKpOmM4VDYIKaZGLBdQhsXDJztKicuTKv9panXsA3lcS
	 Ykic8Q17+f3Xg==
Subject: Re: [PATCH net v3 3/3] ieee802154: ca8210: validate data_ind length
 upfront in ca8210_skb_rx()
From: netdev-bot+sashiko@kernel.org
To: benquike@gmail.com
Cc: h.morris@cascoda.com, alex.aring@gmail.com, miquel.raynal@bootlin.com,
 stefan@datenfreihafen.org, david.laight.linux@gmail.com,
 linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, kuba@kernel.org
Date: Sun, 04 Oct 2026 07:39:29 +0000
Message-ID: <179109956960.434549.9439305358402977833@kernel.org>
In-Reply-To: <20260930071914.421586-4-benquike@gmail.com>
References: <20260930071914.421586-4-benquike@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message says the patch fixes a slab-out-of-bounds
  read, quotes a KASAN splat from a kmalloc-32 object and adds Cc:…
- [Medium] The new truncation check in ca8210_skb_rx() reads
  priv->promiscuous without a lock at line 1781 to decide whether to…

--

ieee802154: ca8210: validate data_ind length upfront in ca8210_skb_rx()

This patch moves the length checks in ca8210_skb_rx() ahead of the skb
allocation. It adds checks that len covers the fixed 30-byte header, the
msdu payload, and the security header when one is present. It also
zero-initializes hdr.

> In ca8210_skb_rx(), data_ind is read at offsets 22 (msdulen), 23
> (mpdulinkquality), 29 + msdulen (hdr.sec.level), 30..39 + msdulen
> (security header), and 29 .. 29 + msdulen (payload) without verifying
> that the received SPI frame length len covers those offsets, causing an
> out-of-bounds read when msdulen exceeds len - 30:
>
>   BUG: KASAN: slab-out-of-bounds in ca8210_skb_rx.constprop.0.isra.0+0x137/0x160
>   Read of size 64 at addr ffff888006453ddd by task init/1

[ ... ]

>   The buggy address belongs to the object at ffff888006453dc0
>    which belongs to the cache kmalloc-32 of size 32

[ ... ]

> Tested in QEMU with KASAN enabled by passing a short data_ind buffer with
> msdulen = 64 and len = 30 into ca8210_skb_rx().

[Severity: Medium]
Can this slab-out-of-bounds read happen on a real driver path? As far as
I can tell, ca8210_skb_rx() has only one caller chain,
ca8210_spi_transfer_complete()->ca8210_rx_done()->ca8210_net_rx(), and
data_ind always points into the fixed-size tx_in_buf:

drivers/net/ieee802154/ca8210.c:
#define CA8210_SPI_BUF_SIZE 256

struct cas_control {
    ...
	u8 tx_in_buf[CA8210_SPI_BUF_SIZE];
};

ca8210_rx_done() {
    ...
	buf = cas_ctl->tx_in_buf;
    ...
	ca8210_net_rx(priv->hw, buf, len);
}

ca8210_net_rx() {
    ...
		return ca8210_skb_rx(hw, len - 2, command + 2);
}

The existing check already caps msdulen at IEEE802154_MTU (127). That
makes the largest read data_ind[39 + 127], which is tx_in_buf[168]. The
payload copy of data_ind[29..155] also stays well inside the 256-byte
array, both before and after this patch.

The kmalloc-32 object in the splat seems to come from the test harness,
which passed a short buffer directly into ca8210_skb_rx(). The trace
still shows ca8210_net_rx() as the caller, though, so it reads like a
live heap over-read.

The real effect looks like a data-integrity problem, not a memory-safety
one. Bytes past the length the device declared get delivered as payload
and security header fields. Those bytes are the rest of the MISO transfer
or the SPI_IDLE fill from ca8210_spi_transfer(), and this can only happen
with a buggy or malicious SPI peripheral.

Could the commit message describe it that way instead of presenting a
KASAN slab-out-of-bounds report? The Cc: stable tag was added on the
basis of that report.

> diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
> index 8aa7ffeb22d78..ab245add9ff5c 100644
> --- a/drivers/net/ieee802154/ca8210.c
> +++ b/drivers/net/ieee802154/ca8210.c

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

[Severity: Medium]
Can the two reads of priv->promiscuous in ca8210_skb_rx() disagree? The
new truncation check reads the flag once, and the later "if
(priv->promiscuous) goto copy_payload;" reads it again. The
dev_alloc_skb() call in between forces a reload.

priv->promiscuous is a plain bool with no locking. It is written from
process context by ca8210_set_promiscuous_mode(), which mac802154 calls
through drv_set_promiscuous_mode():

ca8210_set_promiscuous_mode() {
    ...
	} else {
		priv->promiscuous = on;
	}
}

ca8210_reset_send() also sets it to false. The RX path runs from SPI
completion context, and ca8210_net_rx() drops priv->lock before it calls
ca8210_skb_rx(). So one possible interleaving is:

RX: ca8210_rx_done()->ca8210_net_rx()->ca8210_skb_rx()
    new check sees priv->promiscuous == true
    secspec length check skipped, len == 30 + msdulen

                        ca8210_set_promiscuous_mode(hw, false)
                            priv->promiscuous = on;   /* false */

RX: dev_alloc_skb()
    if (priv->promiscuous)         /* now false, no goto */
    hdr.sec.level = data_ind[29 + msdulen];     /* > 0 */
    hdr.sec.key_id_mode = data_ind[30 + msdulen];
    memcpy(&hdr.sec.extended_src, &data_ind[31 + msdulen], 8);
    hdr.sec.key_id = data_ind[39 + msdulen];

These reads go up to 10 bytes past the validated len. This is the case
the new check is meant to reject. The bytes are still inside the
256-byte tx_in_buf, so the result is garbage security header fields
rather than a memory-safety fault.

Would it make sense to read the flag once into a local, for example
"bool promisc = READ_ONCE(priv->promiscuous);", and use it in both
places?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930071914.421586-1-benquike%40gmail.com

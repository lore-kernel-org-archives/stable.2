Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DC73A5E67;
	Tue, 22 Sep 2026 07:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790063067; cv=none; b=DybgOCzQh2JlWElkbCVjMXObnmCGF14VE9Qu+NWn7trwQtXDL1oFhq5uqIaCbOmIDl6nb5wxHyA8ZQcfbYvn0RdIDsnC761gO9Cqb5ge0VQLCRrKJNhkRuz8F9skAAXi3j9RgoCY8KsyZG8H+FBpUdkVNRDsYGwXs1lqF+hPQ9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790063067; c=relaxed/simple;
	bh=QlMeLu+L6xiQInXI2eIs27kOYDpTjPvxGpELNX1DjAI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aD3XiK8ABFvuUAWQmmbre/WXBS/7fiZwz3kNb0SKF6nxOZVV5xubj3ZJhx45MhD5hFVy7TQOP4Gk6IwQAME2ge/RZJO7EG5PcSP9fJ03STJqG5srBtwra/31ZkHQZ+ONifXkyN3hdrddstBy+eVQxqTvlfJE5/057dZ6IYWllfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+qMIj9L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+qMIj9L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F5701F00893;
	Tue, 22 Sep 2026 07:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790063061;
	bh=zNg10MyXKAU0YY+tfsXTm8HcUimI/me8kiBIccG4eZ4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=R+qMIj9LmafDYOefhiougjsD0KXuPebaCO4QoxIGBtW05mOeHctoXQK4rEdfwqurl
	 DNu+XGr9OQihlLjhvRTqt4Aa0yyxK76hMlxfnXL30ScOS98H3IepCBjQII6saPFyPT
	 2aga1IMni0WzBoKpi6p2NQxOj8hAdvf2L0FtBSBqTSbI+AuU75MRnTie8juCr1xsg1
	 O2LG3rWkHwyZRl5K06p5Fv90mosxCSr9lZxxnc41RtoG/mtyIQCN2dMSF5q7SsUfiG
	 v3pQ3CkWbuoauXxlII8GUp/3j7DwNPEO1SavveP3GrdWCGTIQnPjn17A2hRz26GtTC
	 Z+jTwGS40AwKQ==
Subject: Re: [PATCH net v2 3/4] ieee802154: mcr20a: drop corrupted RX frames
 instead of reading 125 stale bytes
From: netdev-bot+sashiko@kernel.org
To: benquike@gmail.com
Cc: alex.aring@gmail.com, miquel.raynal@bootlin.com, stefan@datenfreihafen.org,
 linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, kuba@kernel.org
Date: Tue, 22 Sep 2026 07:44:20 +0000
Message-ID: <179006306060.2160803.5728215627968945017@kernel.org>
In-Reply-To: <20260921074207.2289391-3-benquike@gmail.com>
References: <20260921074207.2289391-3-benquike@gmail.com>
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

Critical: 0 · High: 0 (2) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message justifies the change with a KASAN slab-out-
  of-bounds splat ("Read of size 125 at addr ffff888002853f40 ... cache…

Pre-existing issues:
- [High] mcr20a_irq_status_complete() unconditionally programs XCVSEQ to
  MCR20A_XCVSEQ_IDLE (mcr20a.c:938-939) before the RX length/buffer read…
- [High] mcr20a_handle_rx_read_buf_complete() strips the two FCS bytes
  from the received PSDU (`len = len - 2; /* get rid of frame check…

--

ieee802154: mcr20a: drop corrupted RX frames instead of reading 125 stale bytes

When the reported PSDU length is invalid, mcr20a_handle_rx_read_buf_complete()
no longer forces len to IEEE802154_MTU and copies the whole buffer; it now
drops the frame and re-arms reception with mcr20a_request_rx(lp).

First, a question about the justification in the commit message:

>     In mcr20a_handle_rx_read_buf_complete(), when
>     !ieee802154_is_valid_psdu_len(len) is true, the driver overwrites len
>     with IEEE802154_MTU (127) and copies 125 bytes from lp->rx_buf into a new
>     skb even though only the original len bytes were transferred over SPI,
>     reading past the valid RX data and leaking up to 125 bytes of stale heap
>     memory to the network stack:
>
>       BUG: KASAN: slab-out-of-bounds in mcr20a_handle_rx_read_buf_complete.constprop.0+0x91/0xc0
>       Read of size 125 at addr ffff888002853f40 by task init/1
>       ...
>       The buggy address belongs to the object at ffff888002853f40
>        which belongs to the cache kmalloc-8 of size 8
>       The buggy address is located 0 bytes inside of
>        allocated 4-byte region [ffff888002853f40, ffff888002853f44)

[Severity: Medium]
Can this KASAN splat actually be produced by this driver?  The memcpy source
in mcr20a_handle_rx_read_buf_complete() is lp->rx_buf, which is a fixed array
embedded in struct mcr20a_local:

drivers/net/ieee802154/mcr20a.c:
	u8 rx_buf[MCR20A_MAX_BUF];

with MCR20A_MAX_BUF defined as 127, and mcr20a_setup_rx_spi_messages() binds
the SPI transfer to it permanently:

	lp->rx_xfer_buf.rx_buf = lp->rx_buf;

struct mcr20a_local itself is the priv blob from ieee802154_alloc_hw(sizeof(*lp),
...), so a 125-byte read from rx_buf stays inside the object and cannot be
reported as a slab-out-of-bounds access, and the source object can never be a
4-byte allocation in kmalloc-8.  The only small heap object in the driver is
lp->buf from devm_kzalloc(SPI_COMMAND_BUFFER), which is never the memcpy
source here.

The defect the patch fixes looks narrower: mcr20a_handle_rx_read_len_complete()
only refreshes lp->rx_xfer_buf.len bytes,

	lp->rx_xfer_buf.len = len;

so with the old "len = IEEE802154_MTU" fallback the driver handed the stale
tail of its own RX buffer (leftovers of previously received frames, or zeros)
to the 802.15.4 stack as if it were received data.  Given the Cc: stable tag,
would it make sense to describe it that way and drop the KASAN block, so that
backporters do not read this as an out-of-bounds read?

> diff --git a/drivers/net/ieee802154/mcr20a.c b/drivers/net/ieee802154/mcr20a.c
> index 020d392a98b6..ee3c1e67ef60 100644
> --- a/drivers/net/ieee802154/mcr20a.c
> +++ b/drivers/net/ieee802154/mcr20a.c
> @@ -790,7 +790,8 @@ mcr20a_handle_rx_read_buf_complete(void *context)
>  
>  	if (!ieee802154_is_valid_psdu_len(len)) {
>  		dev_vdbg(&lp->spi->dev, "corrupted frame received\n");
> -		len = IEEE802154_MTU;
> +		mcr20a_request_rx(lp);
> +		return;
>  	}
>  
>  	len = len - 2;  /* get rid of frame check field */

[Severity: High]
This isn't a bug introduced by this patch, but the new branch highlights the
sibling exits of the same RX chain that do not re-arm reception.
mcr20a_irq_status_complete() always parks the sequence manager first:

	regmap_update_bits_async(lp->regmap_dar, DAR_PHY_CTRL1,
				 DAR_PHY_CTRL1_XCVSEQ_MASK, MCR20A_XCVSEQ_IDLE);

so RX only resumes when mcr20a_request_rx() writes MCR20A_XCVSEQ_RX.  A few
lines below the hunk, mcr20a_handle_rx_read_buf_complete() returns without
doing that:

	skb = dev_alloc_skb(len);
	if (!skb)
		return;

and mcr20a_handle_rx_read_len_complete() does the same on a submission
failure:

	ret = spi_async(lp->spi, &lp->rx_buf_msg);
	if (ret)
		dev_err(printdev(lp), "failed to read rx buffer length\n");

With XCVSEQ left at IDLE, does the part generate any further RXIRQ/SEQIRQ that
could restart the chain?  mcr20a_request_rx() is only reachable from
mcr20a_handle_rx_read_buf_complete(), mcr20a_handle_tx_complete() and
mcr20a_start(), so recovery would seem to require a transmit or an interface
down/up, while the netdev stays up and silently deaf - for a receive-only or
monitor configuration there is no such event.  Would it be worth re-arming RX
on these paths too, in the same way the new corrupted-length branch does?

Related: mcr20a_request_rx() issues the re-arm with
regmap_update_bits_async() and returns 0 unconditionally:

	regmap_update_bits_async(lp->regmap_dar, DAR_PHY_CTRL1,
				 DAR_PHY_CTRL1_XCVSEQ_MASK, MCR20A_XCVSEQ_RX);

	return 0;

so is a failed register write distinguishable from a successful re-arm?

[Severity: High]
This is a pre-existing issue, but it sits on the length computation this patch
touches.  The driver removes the two FCS bytes and hands the FCS-less data to
ieee802154_rx_irqsafe(), while mcr20a_hw_setup() advertises:

	hw->flags = IEEE802154_HW_TX_OMIT_CKSUM |
			IEEE802154_HW_AFILT |
			IEEE802154_HW_PROMISCUOUS;

i.e. without IEEE802154_HW_RX_OMIT_CKSUM.  In net/mac802154/rx.c,
ieee802154_rx() only synthesizes an FCS when that flag is set, and then trims
two bytes regardless:

	if (local->hw.flags & IEEE802154_HW_RX_OMIT_CKSUM) {
		crc = crc_ccitt(0, skb->data, skb->len);
		put_unaligned_le16(crc, skb_put(skb, 2));
	}
	...
	skb_trim(skb, skb->len - 2);

Does this mean every frame received through mcr20a loses two bytes of real MAC
payload, and gets dropped by the crc_ccitt() check when
phy->filtering == IEEE802154_FILTERING_NONE?  adf7242, the other driver that
strips the CRC, sets IEEE802154_HW_OMIT_CKSUM in adf7242_hw_init().  Should
mcr20a either advertise IEEE802154_HW_RX_OMIT_CKSUM or keep the FCS in the
skb?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921074207.2289391-1-benquike%40gmail.com

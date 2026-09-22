Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5219F3F86F2;
	Tue, 22 Sep 2026 07:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790063059; cv=none; b=lVjEccnqq30Uzb+4cSrbgvC9jwb6EEbe16s5sCPjOGvG9MYU2w9iGFX3L96dborZDU9idjYMboeB7DW99HuAolsWuNTdRija2/MeS07bngggQDArQDSLD1iSShbCnG1MbdPySX0pd4pPEmqQqG6VLGEMNVOYHqOHV1rbCsai5BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790063059; c=relaxed/simple;
	bh=AiKWwoSUtak1/Rm0bfuWe5HPl8bVcxbz4lCtvhUIJ5c=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oRhaJLEbJ2nW9R95vCXmmhiy04ea8UQP+Q2Wy/P9Y69EfPW0wqKHivvEXatDqq1LlPDC7gu0l81FHLaChi69p77bHzOEgBwWHPLUI+v5pYLAoDR1BlTi90v/JNiljWlufjOwmvfGWVZV0hPhtxTA25BOcwE7YSbJ75s5uTJ7GkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETDULeiI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETDULeiI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F351F000FF;
	Tue, 22 Sep 2026 07:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790063057;
	bh=V5G1w4Vm2xeTWueoYJWM117u2gyxyBJZp2e0YJ6iLSs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ETDULeiIvf01zmml9he2qzkDl1v1Bl6aZjuP0i5MeCJhESikPPI5sfmH2zajn21Ej
	 hF91vnRMwNTWmykxk7CC+bOMhNTYjIK0eBdHZ2Xac6gR/E+dXX3lFmcVFyNv2Aplrs
	 TWPK2EOk8FSxM55CbqYNzM+RklFDN5tOZ3NFhnSfw5KsahHOS7qOzZYVPWSWDD7fD3
	 leIbczFlj9RY5OBxUK9ma2/9fajJYvU2nfM6u6bojJZZwGLRatddQrfXWUJz2ENHay
	 dORcdhAyjKb5WZ406tjh5x3EYLfedaOWkApMbGZNxQJlNka1UYexDYCMrp0eP2d5gw
	 I0IAfBiuo/m0w==
Subject:
 Re: [PATCH net v2 2/2] mac802154: rx: ensure tailroom before appending CRC
From: netdev-bot+sashiko@kernel.org
To: benquike@gmail.com
Cc: alex.aring@gmail.com, miquel.raynal@bootlin.com, stefan@datenfreihafen.org,
 linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, kuba@kernel.org
Date: Tue, 22 Sep 2026 07:44:16 +0000
Message-ID: <179006305688.2160803.18133046080885644930@kernel.org>
In-Reply-To: <20260921074202.2289040-2-benquike@gmail.com>
References: <20260921074202.2289040-2-benquike@gmail.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new guard in ieee802154_rx() (net/mac802154/rx.c:490-492)
  uses the wrong predicate and the wrong primitive, so it does not close…
- [Medium] The commit message presents an observed `skb_over_panic` BUG
  splat (`skbuff: skb_over_panic: text:... len:386 put:2` / `kernel BUG…

--

mac802154: rx: ensure tailroom before appending CRC

This adds a tailroom check in ieee802154_rx() before the 2-byte CRC is
appended with skb_put() when IEEE802154_HW_RX_OMIT_CKSUM is set, calling
pskb_expand_head() when skb_tailroom(skb) is less than 2 and dropping the
frame if the expansion fails.

A couple of questions about the commit message and the new guard.

>     When IEEE802154_HW_RX_OMIT_CKSUM is set, ieee802154_rx() appends a 2-byte
>     calculated CRC via skb_put(skb, 2) without checking whether the driver
>     allocated sufficient tailroom in the received skb, triggering
>     skb_over_panic when skb_tailroom(skb) < 2:
>
>       skbuff: skb_over_panic: text:ffffffffb6e61896 len:386 put:2
>       kernel BUG at net/core/skbuff.c:214!
>
>     Tested in QEMU with KASAN by injecting a zero-tailroom skb into
>     ieee802154_rx() with IEEE802154_HW_RX_OMIT_CKSUM set.
>
>     Fixes: b7889497d306 ("mac802154: rx: simplify crc receive handling")
>     Cc: stable@vger.kernel.org

[Severity: Medium]
Can this splat be reproduced with an in-tree driver?

IEEE802154_HW_RX_OMIT_CKSUM only reaches drivers through the combined
IEEE802154_HW_OMIT_CKSUM macro in include/net/mac802154.h, and only
adf7242 and ca8210 set it.  The remaining drivers (at86rf230, atusb,
cc2520, mcr20a, mrf24j40) set just IEEE802154_HW_TX_OMIT_CKSUM, and
mac802154_hwsim sets only IEEE802154_HW_PROMISCUOUS in hwsim_add_one(),
so none of them enter the patched branch.

adf7242_rx() guarantees two bytes of tailroom by construction:

drivers/net/ieee802154/adf7242.c:adf7242_rx() {
	skb = dev_alloc_skb(len);
	...
	skb_put(skb, len);
	...
	skb_trim(skb, len - 2);	/* Don't put RSSI/LQI or CRC into the frame */

	ieee802154_rx_irqsafe(lp->hw, skb, lqi);
}

ca8210_skb_rx() allocates dev_alloc_skb(IEEE802154_MTU + sizeof(hdr)),
reserves sizeof(hdr), and rejects msdulen > IEEE802154_MTU, so the skb it
hands up has hundreds of bytes of tailroom.

The len:386 value in the splat also looks inconsistent with this
subsystem, since 802.15.4 frames are bounded by IEEE802154_MTU (127); the
largest skb->len reaching this point is around 127 for adf7242 and around
150 for ca8210 including the pushed header.

Together with the note that the trace comes from "injecting a
zero-tailroom skb into ieee802154_rx()", should the Fixes: tag and the
Cc: stable be dropped and the change described as hardening the
ieee802154_rx_irqsafe() contract instead?  Otherwise, could the concrete
driver and path that delivers a short-tailroom skb be named?

> diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
> index ad602d222e86..6aa59202f088 100644
> --- a/net/mac802154/rx.c
> +++ b/net/mac802154/rx.c
> @@ -487,6 +487,9 @@ void ieee802154_rx(struct ieee802154_local *local, struct sk_buff *skb)
>  	 * solution because the monitor needs a crc here.
>  	 */
>  	if (local->hw.flags & IEEE802154_HW_RX_OMIT_CKSUM) {
> +		if (skb_tailroom(skb) < 2 &&
> +		    pskb_expand_head(skb, 0, 2, GFP_ATOMIC))
> +			goto free_skb;

[Severity: High]
Does this guard still leave a BUG() reachable for a non-linear skb?

skb_tailroom() reports zero for any skb with data_len > 0:

include/linux/skbuff.h:skb_tailroom() {
	return skb_is_nonlinear(skb) ? 0 : skb->end - skb->tail;
}

so the first half of the condition is always true in that case, and
pskb_expand_head() only grows the head buffer:

net/core/skbuff.c:pskb_expand_head() {
	memcpy(data + nhead, skb->head, skb_tail_pointer(skb) - skb->head);
	memcpy((struct skb_shared_info *)(data + size), skb_shinfo(skb),
	       offsetof(struct skb_shared_info, frags[skb_shinfo(skb)->nr_frags]));
	...
}

It preserves frags, frag_list and skb->data_len, so it does not linearize
and it returns 0, meaning the goto free_skb is not taken.

>  		crc = crc_ccitt(0, skb->data, skb->len);
>  		put_unaligned_le16(crc, skb_put(skb, 2));

With the guard passed, crc_ccitt() then reads skb->len bytes starting at
skb->data even though only skb_headlen(skb) bytes live in the linear area.
Is that a slab out-of-bounds read?  The resulting CRC is appended and
cloned to every monitor interface:

net/mac802154/rx.c:ieee802154_monitors_rx() {
	skb2 = skb_clone(skb, GFP_ATOMIC);
	if (skb2) {
		skb2->dev = sdata->dev;
		ieee802154_deliver_skb(skb2);
	}
}

which would make the over-read bytes visible from user space via a packet
socket bound to the monitor wpan netdev.

skb_put() then still aborts before any tail/end arithmetic:

net/core/skbuff.c:skb_put() {
	void *tmp = skb_tail_pointer(skb);
	SKB_LINEAR_ASSERT(skb);
	...
}

include/linux/skbuff.h:
#define SKB_LINEAR_ASSERT(skb)  BUG_ON(skb_is_nonlinear(skb))

So the failure signature the commit message describes, a kernel BUG
reached from skb_put() inside ieee802154_rx(), appears to remain, just
from a different assertion and now preceded by an out-of-bounds read.
There is no CONFIG guard on SKB_LINEAR_ASSERT, so this holds in all
configurations.

Also, for a non-linear skb the condition is true on every received frame,
so does this add a head reallocation per frame?

Would a predicate that matches what skb_put() actually requires be better
here, for example skb_cow()/skb_linearize(), skb_copy_expand(), or an
explicit skb_is_nonlinear() rejection?  The TX counterpart in
net/mac802154/tx.c:ieee802154_tx() implements the same "reserve FCS
tailroom then skb_put" contract with skb_copy_expand(skb, 0,
IEEE802154_FCS_LEN, GFP_ATOMIC), which yields a linear unshared buffer and
also spells the size as IEEE802154_FCS_LEN rather than a hard-coded 2.

>  	}

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921074202.2289040-1-benquike%40gmail.com

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0F0396B76;
	Thu, 10 Sep 2026 04:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789014377; cv=none; b=fLa1BqHBdCm4SxgwOsdFIxOEA99H+dJDSr8bWrnWPSGsl2nHne0//DHLdXZZfdR0siXhG7X0dy0/wMNo5qMrkvpVjBLuYzNtdmqNN06klHGW1GucfiUL+BRzDYIj3lHyZ0zKIikKgu9gtrsz+oicv6FZnLgt83Hk3OLuqkDPEEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789014377; c=relaxed/simple;
	bh=EkKMYN6rqU1yP4gebFP8T2LzpNwQ81LdLlbjkhdEiZ4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Au2r58pnDzAZrH3GGYBlEN5BFSv+JBXoojOBEulV9I4o4NmxYOKIE6gi+LWsmpXaGhkkmzNFYO6paene71isa7p83PBEhjVZtCn1l4V9oUCk9rBmQxwHFQZgtN02fwFsH6L/pa/801K2OY2LiM6w+KkgrNH8edRSflS0nfXesng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gFRyBBys; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFRyBBys"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 930901F000FF;
	Thu, 10 Sep 2026 04:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789014375;
	bh=ROvdocL9BxILIzjnJ5VJFG7M9GIFNFE2U/YroZ5F2sQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gFRyBBysaoOcok/S9I3ibfCNXzk5A2BA701rs0lhGIBtMYUFR7kgRdqOj9CYJuaWT
	 jDfK2GubbDof2hKP/CKFJLX4+5ugcxGPMGPcOnZKLtLDGOvfdgJ2+mPy7P1UGZldHy
	 Q3vy1IskcXauCTTa9e07n/Dsll5grMuZIAI6LjD70jlcxARkGGaWF1KqS2v5tXkQjd
	 Y2SDoNWz3XO9+Di8ojGvwWMh6942hkIzKoa4Zi7UZSjdbgvNIahMsUB8Sj+izdVXd4
	 eUAUgSccxn/I9jvL022PgcZswVcU37eI+LWMp5eraM3D6dyZUx+53KK5NLT2+DRVBJ
	 mINIAQ7n9mwGw==
Subject: Re: [PATCH] net: usb: catc: fix out-of-bounds read in catc_rx_done()
From: netdev-bot+sashiko@kernel.org
To: elb12345@hotmail.co.uk
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, peter@korsgaard.com,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org, stable@vger.kernel.org
Date: Thu, 10 Sep 2026 04:26:14 +0000
Message-ID: <178901437412.219967.4393218357548011225@kernel.org>
In-Reply-To: =?utf-8?q?=3CAS8P251MB00013A0DCA600A79DC58B0FEC8B22=40AS8P251MB?=
 =?utf-8?q?0001=2EEURP251=2EPROD=2EOUTLOOK=2ECOM=3E?=
References: =?utf-8?q?=3CAS8P251MB00013A0DCA600A79DC58B0FEC8B22=40AS8P251MB0?=
 =?utf-8?q?001=2EEURP251=2EPROD=2EOUTLOOK=2ECOM=3E?=
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
issue(s) to consider:

Critical: 0 · High: 0 (1) · Medium: 1 · Low: 0 (1)

- [Medium] catc_rx_done() (drivers/net/usb/catc.c) still accepts a
  device-supplied pkt_len that is smaller than an Ethernet header.

Pre-existing issues:
- [High] For F5U011 (Belkin) devices catc_rx_done() can return with the
  RX_RUNNING flag set and no bulk-IN URB in flight, which permanently…
- [Low] The new bounds validation in catc_rx_done() re-reads
  urb->actual_length (line 237-238: `remaining = urb->actual_length -…

--

net: usb: catc: fix out-of-bounds read in catc_rx_done()

The patch reworks the length validation in catc_rx_done() so the 2-byte
per-packet header offset is accounted for and so each packet in a
multi-packet URB is checked against the bytes remaining from the current
pkt_start rather than against urb->actual_length. A few questions about
the new check and the surrounding code follow.

> diff --git a/drivers/net/usb/catc.c b/drivers/net/usb/catc.c
> index 96e82f94edcf8..e4f8b9a0caf19 100644
> --- a/drivers/net/usb/catc.c
> +++ b/drivers/net/usb/catc.c
> @@ -234,8 +234,16 @@ static void catc_rx_done(struct urb *urb)
>  
>  	do {
>  		if(!catc->is_f5u011) {
> +			int remaining = urb->actual_length -
> +					(pkt_start - (u8 *)urb->transfer_buffer);
> +
> +			if (remaining < pkt_offset) {
> +				catc->netdev->stats.rx_length_errors++;
> +				catc->netdev->stats.rx_errors++;
> +				break;
> +			}
>  			pkt_len = le16_to_cpup((__le16*)pkt_start);
> -			if (pkt_len > urb->actual_length) {
> +			if (pkt_len + pkt_offset > remaining) {
>  				catc->netdev->stats.rx_length_errors++;
>  				catc->netdev->stats.rx_errors++;
>  				break;

[Severity: Medium]
Since this block is being rewritten to sanitise the device-supplied
length, should it also reject a pkt_len smaller than an Ethernet header?

As written, any value in [0, remaining - 2] is accepted, including 0, and
the rest of the loop then does:

drivers/net/usb/catc.c:catc_rx_done() {
	...
	if (!(skb = dev_alloc_skb(pkt_len)))
		return;

	skb_copy_to_linear_data(skb, pkt_start + pkt_offset, pkt_len);
	skb_put(skb, pkt_len);

	skb->protocol = eth_type_trans(skb, catc->netdev);
	netif_rx(skb);
	...
}

eth_type_trans() dereferences 14 bytes unconditionally:

net/ethernet/eth.c:eth_type_trans() {
	...
	eth = eth_skb_pull_mac(skb);
	eth_skb_pkt_type(skb, dev);
	...
	if (likely(eth_proto_is_802_3(eth->h_proto)))
		return eth->h_proto;
	...
}

include/linux/etherdevice.h:eth_skb_pull_mac() {
	struct ethhdr *eth = (struct ethhdr *)skb->data;

	skb_pull_inline(skb, ETH_HLEN);
	return eth;
}

With pkt_len between 0 and 13, h_dest and h_proto are read from bytes
that were never copied into the skb, so skb->pkt_type and skb->protocol
are derived from uninitialised tailroom. skb_pull_inline() also declines
the ETH_HLEN pull when ETH_HLEN > skb->len, so the runt skb reaches
netif_rx() with its MAC header still unpulled.

Note this does not look like memory corruption: skb->len is not
underflowed, since skb_pull_inline() returns NULL without touching
skb->len or skb->data when len > skb->len.

The is_f5u011 branch of the same loop takes the length straight from the
transfer:

		} else {
			pkt_len = urb->actual_length;
		}

so a zero-length transfer reaches the same path there. Would a shared
pkt_len < ETH_HLEN test cover both branches? A sanity maximum against
PKT_SZ or dev->mtu might be worth adding at the same time, as the new
check only bounds pkt_len by what fits in the URB.

[Severity: High]
This is a pre-existing issue and is not introduced by this patch, but
while this loop is under discussion: can reception stop permanently on
F5U011 devices?

RX_RUNNING is only cleared early for the non-F5U011 case:

drivers/net/usb/catc.c:catc_rx_done() {
	if (!catc->is_f5u011) {
		clear_bit(RX_RUNNING, &catc->flags);
		pkt_offset = 2;
	}
	...
}

so on the F5U011 path the flag is only cleared (or the URB resubmitted)
by the tail block:

	if (catc->is_f5u011) {
		if (atomic_read(&catc->recq_sz)) {
			int state;
			atomic_dec(&catc->recq_sz);
			netdev_dbg(catc->netdev, "getting extra packet\n");
			urb->dev = catc->usbdev;
			if ((state = usb_submit_urb(urb, GFP_ATOMIC)) < 0) {
				netdev_dbg(catc->netdev,
					   "submit(rx_urb) status %d\n", state);
			}
		} else {
			clear_bit(RX_RUNNING, &catc->flags);
		}
	}

Two paths appear to skip re-arming the endpoint:

  - the "if (!(skb = dev_alloc_skb(pkt_len))) return;" early return in
    the loop leaves the function before the tail block, so RX_RUNNING
    stays set and recq_sz is not decremented;

  - a usb_submit_urb() failure in the tail block is only logged, after
    recq_sz has already been decremented, so no URB is in flight and
    RX_RUNNING remains set.

catc_irq_done() is the only other place that starts the bulk transfer,
and it is gated purely on the flag:

drivers/net/usb/catc.c:catc_irq_done() {
	if (hasdata) {
		if (test_and_set_bit(RX_RUNNING, &catc->flags)) {
			if (catc->is_f5u011)
				atomic_inc(&catc->recq_sz);
		} else {
			catc->rx_urb->dev = catc->usbdev;
			if ((res = usb_submit_urb(catc->rx_urb, GFP_ATOMIC)) < 0) {
	...
}

With the bit stuck set, every later data notification only increments
recq_sz and never resubmits catc->rx_urb, so RX would stay dead until
the interface is brought down and up. The submit-failure path also loses
one unit of the pending-frame credit, leaving recq_sz permanently out of
step with what the adapter holds.

[Severity: Low]
This is also pre-existing rather than something the patch introduces, but
the new computation re-reads urb->actual_length on every iteration:

			int remaining = urb->actual_length -
					(pkt_start - (u8 *)urb->transfer_buffer);

For non-F5U011 devices RX_RUNNING is cleared before the parsing loop
starts, and catc_irq_done() only checks that bit before resubmitting the
same URB over catc->rx_buf. If the two ever overlap, usb_submit_urb()
resets urb->actual_length to 0 and the controller refills catc->rx_buf,
so the value validated here and the two header bytes read as pkt_len can
change before skb_copy_to_linear_data() runs.

The accesses stay inside catc->rx_buf, since rx_urb->transfer_buffer_length
equals sizeof(catc->rx_buf), so the visible effect would be garbled
frames handed to netif_rx() plus spurious rx_length_errors rather than an
out-of-bounds access. This one is speculative: URB giveback for a single
host controller is normally serialised, so it is not clear that the bulk
and interrupt completion handlers of this device can actually run at the
same time. Is the bit flag intended to provide exclusion here?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/AS8P251MB00013A0DCA600A79DC58B0FEC8B22%40AS8P251MB0001.EURP251.PROD.OUTLOOK.COM

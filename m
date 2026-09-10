Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72FD39B972;
	Thu, 10 Sep 2026 04:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789015939; cv=none; b=oAPieVJib/opsXU8HNzE+pC7yGD8iePLi+z6hD7uR0Do4GE3ofa2MWBtx4I60CoOO/ctzENdvmWH+z9aPzpm/rjNESanudOp0uVomA/xVPlTc1l231C+snBGjIahfHwpuNZKVAVdV+ok0+B6cQjs7+fTMjh4gzbMVAHbvEcXPUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789015939; c=relaxed/simple;
	bh=0Lm51wTH9VGr/i6Wdxm7m04pe2ecCcXI0ZrykPiipJo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mbVWzFSM+n81DbelHkitutr/8J8M167Tjz+qMY66rZ92dg/6TJGpNECYwbFGuE4euIe9A8btci/3In5V2IHnQROXTED9yaRU9PNugAe/P8Wuc9daVnjDvuhQiUW+/D3qb6z3SM8lHUKRn42HP/ZqqMhxfbZqiqPLlGQABZ+tSJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YIkmSJQi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YIkmSJQi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6ECC1F000FF;
	Thu, 10 Sep 2026 04:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789015937;
	bh=15HFrqWF/+MQsMOouFb0s1rwFayiwTbtk9+s3/wEPWo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YIkmSJQiVQqij5iQPtnhmKvjCiWZ/bHVz1wE97JDb5h5Hq11WfiD3l8BzAhc/GUSG
	 lw6xKGxoi10wSoF6JsbB3ZqsRdeiG5D31U0vi1oQBVNJVyLZuY0vTrfvHzfKUVr6M9
	 skYMslGoMnuejlOJDjKrSpmNRQgkW7ZuSzyYHQN+HQ7JRJX7E+jFIoYPll3KxL9eil
	 K0pvpEXr12vN8ni6bJ9Es1Yz60A07DxZCESIX1jayYDej3Tkpc2PandmGZ+iAOLN2e
	 9xI8i1sb01XKMtjAFArBBljleSt4wry80F54RiJGoHYAwJH1LCzXCupsTKhh/MuBcu
	 woIOZahrfEVxA==
Subject: Re: [PATCH] net: usb: asix: fix off-by-one in rx_fixup bounds check
From: netdev-bot+sashiko@kernel.org
To: elb12345@hotmail.co.uk
Cc: andrew@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, peter@korsgaard.com, Dean_Jenkins@mentor.com,
 jstultz@google.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 stable@vger.kernel.org
Date: Thu, 10 Sep 2026 04:52:16 +0000
Message-ID: <178901593630.219967.12800331069404600154@kernel.org>
In-Reply-To: =?utf-8?q?=3CAS8P251MB00014BB4591CE6011152DB4FC8B22=40AS8P251MB?=
 =?utf-8?q?0001=2EEURP251=2EPROD=2EOUTLOOK=2ECOM=3E?=
References: =?utf-8?q?=3CAS8P251MB00014BB4591CE6011152DB4FC8B22=40AS8P251MB0?=
 =?utf-8?q?001=2EEURP251=2EPROD=2EOUTLOOK=2ECOM=3E?=
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
issue(s) to consider:

Critical: 0 · High: 1 (1) · Medium: 1 · Low: 0

- [High] Incomplete fix: the patch only tightens the pre-loop
  synchronisation predicate at drivers/net/usb/asix_common.c:151, but…
- [Medium] The commit message characterises the read at
  drivers/net/usb/asix_common.c:153 as a '1-byte heap OOB read' and adds…

Pre-existing issues:
- [High] Unsigned underflow after the loop's over-read leads to a large
  out-of-bounds copy and a kernel heap info leak to userspace.

--

net: usb: asix: fix off-by-one in rx_fixup bounds check

This tightens the multi-URB Data header synchronisation check in
asix_rx_fixup_internal() so the guard uses the same even-aligned offset
that the following get_unaligned_le32() actually reads from.  It carries
a Fixes tag for 3f30b158eba5 and Cc: stable.

No Link: tags in the commit header.

Quoting the changelog:

>     When rx->remaining is odd, the alignment rounding makes offset larger
>     than rx->remaining. For example with rx->remaining=3 and skb->len=7:
>     check passes (3+4<=7) but offset becomes ((3+1)&0xfffe)=4, and the
>     4-byte read at offset 4 needs 8 bytes total, causing a 1-byte
>     heap OOB read.

[Severity: Medium]
Is "heap OOB read" the right description for this read, and does it
justify Cc: stable on memory-safety grounds?

In the usbnet receive path the rx skb is allocated with dev->rx_urb_size
bytes of linear space and skb->len is only set from urb->actual_length:

drivers/net/usb/usbnet.c:rx_submit() {
	size_t			size = dev->rx_urb_size;
	...
	skb = __netdev_alloc_skb_ip_align(dev->net, size, flags);
	...
}

drivers/net/usb/usbnet.c:rx_complete() {
	...
	skb_put(skb, urb->actual_length);
	...
}

Every asix path sets an even rx_urb_size (2048 for FLAG_FRAMING_AX in
asix_devices.c and ax88172a.c, and 2048/4096/8192/16384 in
ax88178_set_mfb()).  The scenario in the changelog needs an odd skb->len,
so skb->len < rx_urb_size and skb->data + skb->len is still inside the
skb's own allocation, i.e. tailroom.

The overshoot of the read at the patched site is at most one byte
(offset + 4 <= rx->remaining + 5 <= skb->len + 1), and the value is only
used for the size-versus-complement comparison before being discarded, so
the visible effect is a spurious "Data Header synchronisation was lost"
message and a dropped frame.

Would it be more accurate to describe this as a read of stale/uninitialised
tailroom rather than an out-of-allocation access that KASAN would flag?

> diff --git a/drivers/net/usb/asix_common.c b/drivers/net/usb/asix_common.c
> index 4f03f4e57655d..c50646ea35c7e 100644
> --- a/drivers/net/usb/asix_common.c
> +++ b/drivers/net/usb/asix_common.c
> @@ -148,7 +148,7 @@ int asix_rx_fixup_internal(struct usbnet *dev, struct sk_buff *skb,
>  	 * Also avoid unnecessarily discarding a good current netdev socket
>  	 * buffer.
>  	 */
> -	if (rx->remaining && (rx->remaining + sizeof(u32) <= skb->len)) {
> +	if (rx->remaining && (((rx->remaining + 1) & 0xfffe) + sizeof(u32) <= skb->len)) {
>  		offset = ((rx->remaining + 1) & 0xfffe);
>  		rx->header = get_unaligned_le32(skb->data + offset);
>  		offset = 0;

[Severity: High]
Does this change actually remove the read described in the changelog, or
just move it into the main parsing loop?

Replaying the changelog example, rx->remaining = 3 and skb->len = 7:

  ((3 + 1) & 0xfffe) + 4 = 8 <= 7   -> false, sync branch skipped

offset stays 0 and control falls into the loop, which is gated only on two
bytes being present:

drivers/net/usb/asix_common.c:asix_rx_fixup_internal() {
	while (offset + sizeof(u16) <= skb->len) {
	...
			if (skb->len - offset == sizeof(u16)) {
				... rx->split_head = true; break;
			}

			if (rx->split_head == true) {
				...
			} else {
				rx->header = get_unaligned_le32(skb->data +
								offset);
				offset += sizeof(u32);
			}
	...
}

The first iteration copies the 3 remaining payload bytes, clears
rx->remaining and does offset += (copy_length + 1) & 0xfffe, giving
offset = 4.  The loop is re-entered because 4 + 2 <= 7, rx->remaining is 0
and rx->split_head is false, so the else branch runs
get_unaligned_le32(skb->data + 4) on a 7-byte skb, reading skb->data[7] --
the same byte the changelog says is being fixed.

offset is always even here (it starts at 0 and advances by 2, 4, or
(copy_length + 1) & 0xfffe), and only the exact skb->len - offset == 2 case
is special-cased, so any 3-byte tail reaches the 4-byte read.  The same
state is reachable with no prior rx->remaining at all, for example a fresh
rx state with skb->len == 3.

Would guarding that read with offset + sizeof(u32) <= skb->len, or handling
a 3-byte tail the way the 2-byte split_head case is handled, be the fix
instead of re-deriving the pre-loop predicate?

There also looks to be a behaviour change for the inputs the new predicate
excludes.  For odd rx->remaining with skb->len == rx->remaining + 4 the old
check was true (3 + 4 <= 7), so the header was validated and
reset_asix_rx_fixup_info() discarded the frame on a mismatch.  With the new
predicate that branch is skipped entirely, and the trailing bytes are
appended to rx->ax_skb and handed to the stack:

drivers/net/usb/asix_common.c:asix_rx_fixup_internal() {
	...
		if (rx->ax_skb) {
			skb_put_data(rx->ax_skb, skb->data + offset,
				     copy_length);
			if (!rx->remaining) {
				usbnet_skb_return(dev, rx->ax_skb);
	...
}

Does this lose the desynchronisation detection for exactly those lengths?

[Severity: High]
This isn't a bug introduced by this patch, but the same 3-byte-tail path
looks like it goes further than a one-byte over-read, and this patch steers
the changelog's own example into it, so it may be worth handling in the same
change.

Once the else branch has done offset += sizeof(u32) with only 3 bytes left,
offset == skb->len + 1.  The reconstructed header has 3 device-supplied
bytes plus one stale byte, and only bits 24-26 of the complement come from
the stale byte, so the self-check has roughly a one-in-eight chance of
passing and a device can retry:

			size = (u16)(rx->header & 0x7ff);
			if (size != ((~rx->header >> 16) & 0x7ff)) {
				... return 0;
			}

If it passes and size <= mtu + ETH_HLEN + VLAN_HLEN, rx->remaining = size
and the clamp is evaluated with offset > skb->len:

		if (rx->remaining > skb->len - offset) {
			copy_length = skb->len - offset;
			rx->remaining -= copy_length;
		} else {
			copy_length = rx->remaining;
			rx->remaining = 0;
		}

skb->len is unsigned int, so skb->len - offset wraps to 0xffffffff, the
test is false and copy_length becomes the full device-chosen size.  Can
this then copy up to mtu + ETH_HLEN + VLAN_HLEN bytes from one byte past
the received data, beyond the rx_urb_size allocation when skb->len is near
rx_urb_size?

		if (rx->ax_skb) {
			skb_put_data(rx->ax_skb, skb->data + offset,
				     copy_length);
			if (!rx->remaining) {
				usbnet_skb_return(dev, rx->ax_skb);

usbnet_skb_return() delivers the skb before the trailing
skb->len != offset check reports the error, so would adjacent heap contents
be handed to userspace as a normal received frame?  asix sets
FLAG_MULTI_PACKET, so there is no usbnet-level length sanity check ahead of
rx_fixup, and skb->len comes straight from urb->actual_length.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/AS8P251MB00014BB4591CE6011152DB4FC8B22%40AS8P251MB0001.EURP251.PROD.OUTLOOK.COM

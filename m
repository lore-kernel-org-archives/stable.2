Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B903B7B83;
	Wed,  9 Sep 2026 23:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788996887; cv=none; b=qoQ+whsmYjfWwpsllh/+ol+8FwlT6dLTlkmJ7bgd52X3mFlpKKe1pGm0OE1KlySvH4JeDeGQ2e/GxcYdQNOx4Oa4tOiVdAEyL+lB4AdRzjXyfto4eA2lcFhj3GBpP/Isinu+ohr9dpSdn9bgOHoUcC0BD+jsDDqArKSl89eDi+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788996887; c=relaxed/simple;
	bh=vkjff3u+/BYFRzHeF1tw/HRswIUOSNvB/lfFuVNbVmY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eKaw55a/iLhW3l/rCUxyzwYXlLTFsOxC3Y6A4FuLq7EB8ti50yeLLv1Rggvjk2/evCwYUlMXik0R92uUiBTZUldVmwi5q1A9RqVptmYWStl+giu1heJq+o8W78OchIO4oa3G7ebIhubfwD0MiZx7ROTB5fxSacWWJ6IrwpW5ZNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ikZWL/P8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ikZWL/P8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99F1C1F000FF;
	Wed,  9 Sep 2026 23:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788996886;
	bh=aQ2+QobUCEMWvg/09vvO7l8pVw231Ta9gbRBr+//V9M=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ikZWL/P8qduQQngPfdmhvfs/UL3mkexPEEjOI9vL2zy0mVttHfcAQmyD4xMqmCS9z
	 PQsOBvqu896Z2/XFB6K/7RTaCaP6l21qZ4HptzJ3SG5Gg+orLrAkjrRoMRBUro7H+V
	 diDpVNUp9e43b493UsZsckfvDjeoC/c983M/ne+8yriSMfDqdZzLkWX2KmpJFtEHA9
	 O247kNqqVwQrcZSeiYcKMG6opj9yED1/uPPH1lyH4WjeNfB/Y/CpTX1Vxcx9NIISC+
	 6iv8A+qXIp78OakqOXjAuQkLieMxvOutdyytQ5o8RmoMudWq4C9E5DCC1BayzCZ+rx
	 XueuFdCUcXU9A==
Subject: Re: [PATCH] net: usb: net1080: fix out-of-bounds access in rx_fixup()
From: netdev-bot+sashiko@kernel.org
To: elb12345@hotmail.co.uk
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, xmei5@asu.edu, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, stable@vger.kernel.org
Date: Wed, 09 Sep 2026 23:34:45 +0000
Message-ID: <178899688516.219967.6073178823130755671@kernel.org>
In-Reply-To: =?utf-8?q?=3CAS8P251MB0001E8B611B22B19AA882542C8B22=40AS8P251MB?=
 =?utf-8?q?0001=2EEURP251=2EPROD=2EOUTLOOK=2ECOM=3E?=
References: =?utf-8?q?=3CAS8P251MB0001E8B611B22B19AA882542C8B22=40AS8P251MB0?=
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] The commit message for net1080_rx_fixup()
  (drivers/net/usb/net1080.c) misdescribes the bug it claims to fix.

--

net: usb: net1080: fix out-of-bounds access in rx_fixup()

This adds a length check in net1080_rx_fixup() so that frames whose
device-supplied hdr_len does not leave room for the two byte nc_trailer
are rejected before skb_pull() is called. The change is described as a
fix for an out-of-bounds read reachable from a malicious USB device, and
carries a Fixes: tag and Cc: stable.

> diff --git a/drivers/net/usb/net1080.c b/drivers/net/usb/net1080.c
> index 19f6e1222d931..64477a4caa07b 100644
> --- a/drivers/net/usb/net1080.c
> +++ b/drivers/net/usb/net1080.c
> @@ -374,6 +374,13 @@ static int net1080_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
>  		nc_ensure_sync(dev);
>  		// switch (vendor/product ids) { ... }
>  	}
> +	if (hdr_len + sizeof(*trailer) > skb->len) {
> +		dev->net->stats.rx_frame_errors++;
> +		netdev_dbg(dev->net, "header too long for frame, %d\n",
> +			   hdr_len);
> +		nc_ensure_sync(dev);
> +		return 0;
> +	}
>  	skb_pull(skb, hdr_len);
>  
>  	trailer = (struct nc_trailer *)

[Severity: Medium]
Does the out-of-bounds read described in the changelog actually exist?
The commit message says:

  "the pointer arithmetic underflows, pointing before skb->data. The
   subsequent read of trailer->packet_id accesses memory outside the skb
   buffer."

skb_pull() subtracts from skb->len exactly what it adds to skb->data:

include/linux/skbuff.h:__skb_pull() {
	skb->len -= len;
	...
	skb->data += len;
}

So the sum skb->data + skb->len is unchanged by the pull, and in
net1080_rx_fixup():

	trailer = (struct nc_trailer *)
		(skb->data + skb->len - sizeof *trailer);

always resolves to the last two bytes of the frame as it was received,
regardless of hdr_len. The pointer can land inside the just-stripped
header bytes, which is before the post-pull skb->data, but not before
skb->head.

The entry guard also bounds the minimum frame size:

	/* This check is no longer done by usbnet */
	if (skb->len < dev->net->hard_header_len)
		return 0;

with net1080_bind() setting

	unsigned	extra = sizeof (struct nc_header)
				+ 1
				+ sizeof (struct nc_trailer);

	dev->net->hard_header_len += extra;

which gives hard_header_len = ETH_HLEN + 6 + 1 + 2 = 23, so skb->len is
at least 23 whenever the trailer arithmetic runs and data + len - 2 stays
well inside the linear area.

For the hdr_len > skb->len case, skb_pull() returns NULL and leaves
skb->data and skb->len untouched, so the trailer computation is again in
bounds. And the following

	skb_trim(skb, skb->len - sizeof *trailer);

does wrap the unsigned argument when the post-pull skb->len is 0 or 1,
but skb_trim() only shrinks:

net/core/skbuff.c:skb_trim() {
	if (skb->len > len)
		__skb_trim(skb, len);
}

so that is a no-op rather than an overread.

What the new check does change is that frames whose declared hdr_len
leaves less than sizeof(nc_trailer) of payload are now rejected, which
also covers the previously ignored NULL return from skb_pull() where the
nc_header stayed un-stripped and a malformed frame could be passed up if
packet_len and packet_id happened to match. That looks like a reasonable
hardening, and real devices report hdr_len == MIN_HEADER == 6.

Given that, could the subject and changelog be reworded to describe the
robustness fix instead of an out-of-bounds access, and could the
Fixes: tag and Cc: stable be re-evaluated on that basis?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/AS8P251MB0001E8B611B22B19AA882542C8B22%40AS8P251MB0001.EURP251.PROD.OUTLOOK.COM

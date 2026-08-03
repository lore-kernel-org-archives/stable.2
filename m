Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DF3340A52;
	Mon,  3 Aug 2026 21:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785792343; cv=none; b=KXGrLujJumWMYb56BSGnx5ay/FPxkOEw00c2hxXNgJts6cuMwjBedSKwFacvSTv35iz2Vkx48dYkWCw78X8ybyPwxQ5RtdzohoIGHO7rtZxbT8NS9dbBTK1jN9+EnJqxP7m+QFWxDJAWoHbdBvrr/wJgGTew4kJo+2QE79lU43s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785792343; c=relaxed/simple;
	bh=je9GDD8GSsiIcEDF+ctWHs0z2fK8qmov7Bt8d7q138M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FReGbS4SPVKCPZ+dEuUxhsEs8oKA0fNQqy+sHdqcS1uxk46O8O3ltfu+7Y6RYrsBwTogVuhSZm7t2n7KDC9Mtu2Ba4LqbCLcscLAUyvXMoMXh9VGtsRMhsrlYYeSByl4wFfIdIeoay7xkavQktJyWxYZUhXPRYQMpL8jn3+/1yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UKhKL9w+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKhKL9w+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C13191F000E9;
	Mon,  3 Aug 2026 21:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785792342;
	bh=TW791XHfnbh/+kenPwpNOF4SjtuhI/21F3zEMqwYwb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UKhKL9w+Uhd4vbov5vSGvHLrk+XixCQt8mlqCdDc6EFhxjQMiVopFPFPZavmtzBDd
	 2yuUeqUJc2dK2Ch/wVYY1QNoOC/F7IgUZstL3K9vUayP+wYvd4clLOd31pWHDd61CQ
	 VPwo53hqGiLLavfbVR57lhQhqBSQYcIHB9xYGuo84afPv8wUCGtXu09xobbC4kZO27
	 d/fAFnreRtkxq++8KDj5cPYj2r+e1aOIiW8rBAudueypEymjMrEU8N9dzsJzpheLgb
	 86K0iTbY44UYHiN3JoLQuMmWphW5ccjJ8Jg5KIevXfRBf1QEWeQpQkEA/jG4VnWmtG
	 qBqR9C4Diwa5A==
From: Jakub Kicinski <kuba@kernel.org>
To: syjcnss@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: pktgen: fix out-of-bounds write in pktgen_finalize_skb()
Date: Mon,  3 Aug 2026 14:25:37 -0700
Message-ID: <20260803212537.2171760-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729031252.54476-1-syjcnss@gmail.com>
References: <20260729031252.54476-1-syjcnss@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
--- Patch [1]: [PATCH net] net: pktgen: fix out-of-bounds write in pktgen_finalize_skb() ---
commit 482871be2b4cb4112bd717673de3a4fe3ab0b9c3
Author: Yuejie Shi <syjcnss@gmail.com>

net: pktgen: fix out-of-bounds write in pktgen_finalize_skb()

The patch changes the per-fragment length in pktgen_finalize_skb() from a
truncating division to DIV_ROUND_UP(), and adds an i < frags bound to the
fragment fill loop, so the loop can no longer write past
skb_shinfo(skb)->frags[].  The reported KASAN overflow with pkt_size in
[69675, 69689] and frags 17 does look fixed by this.

> diff --git a/net/core/pktgen.c b/net/core/pktgen.c
> index ee64f3012321..60dbe60005eb 100644
> --- a/net/core/pktgen.c
> +++ b/net/core/pktgen.c
> @@ -2843,8 +2843,8 @@ static void pktgen_finalize_skb(struct pktgen_dev *pkt_dev, struct sk_buff *skb,
>  		}
>  
>  		i = 0;
> -		frag_len = min_t(int, datalen / frags, PAGE_SIZE);
> -		while (datalen > 0) {
> +		frag_len = min_t(int, DIV_ROUND_UP(datalen, frags), PAGE_SIZE);
> +		while (datalen > 0 && i < frags) {

[Severity: Medium]
[Finding: main-2-0]
[Sources: opus-5]
With frag_len rounded up, can the partition now run out of bytes before
i reaches frags - 1, so that the else branch over-charges the last
fragment?

frag_len is computed once and never re-clamped against the bytes still
outstanding, and only the i == (frags - 1) branch uses min(datalen,
PAGE_SIZE):

		/*last fragment, fill rest of data*/
		if (i == (frags - 1))
			skb_frag_fill_page_desc(&skb_shinfo(skb)->frags[i],
						pkt_dev->page, 0,
						min(datalen, PAGE_SIZE));
		else
			skb_frag_fill_page_desc(&skb_shinfo(skb)->frags[i],
						pkt_dev->page, 0, frag_len);

		datalen -= skb_frag_size(&skb_shinfo(skb)->frags[i]);
		skb->len += skb_frag_size(&skb_shinfo(skb)->frags[i]);
		skb->data_len += skb_frag_size(&skb_shinfo(skb)->frags[i]);

Taking pkt_size 77 with frags 17, which the pkt_size setter accepts since
it only clamps against 14 + 20 + 8:

  fill_packet_ipv4():   datalen = 77 - 42 = 35
  pktgen_finalize_skb(): datalen -= sizeof(*pgh) -> 19
  frag_len = DIV_ROUND_UP(19, 17) = 2

Iterations i = 0..8 consume 18 bytes and leave 1 byte.  At i == 9 the
i == (frags - 1) test is false (frags - 1 is 16), so the else branch
charges the full frag_len of 2:

  datalen becomes -1
  skb->len and skb->data_len are 1 byte larger than requested
  nr_frags ends at 10 instead of the requested 17

Another example is datalen 71 with frags 17: frag_len is 5, 15 iterations
consume 75 bytes, overshooting by 4, and nr_frags ends at 15.  The
overshoot is bounded by frag_len - 1, so at most 16 bytes with
MAX_SKB_FRAGS == 17, and fragment sizes still never exceed PAGE_SIZE, so
this is a length-accounting problem rather than a memory-safety one.

Does the inflated skb->len leave the frame inconsistent with the L3/L4
headers?  fill_packet_ipv4() writes the lengths from the same datalen it
hands to pktgen_finalize_skb():

	udph->len = htons(datalen + 8);	/* DATA + udphdr */
	...
	iplen = 20 + 8 + datalen;
	iph->tot_len = htons(iplen);

fill_packet_ipv6() follows the same pattern.  pktgen_xmit() also does
pkt_dev->last_pkt_size = pkt_dev->skb->len, which feeds
pkt_dev->tx_bytes, so the reported byte counts would drift from the
configured pkt_size too.

Before this change these same inputs partitioned exactly: with datalen 19
and frags 17 the truncated frag_len was 1, giving 16 one-byte fragments
plus a last fragment of 3, and the i == (frags - 1) branch was always
reached.

Would using min(datalen, frag_len) in the else branch, or treating
datalen <= frag_len as the last fragment, keep the sum equal to datalen
in these cases?

The commit message says:

    the fragments now cover datalen exactly and the loop always terminates
    on the last one.  As a side effect pktgen stops emitting zero-length
    fragments when datalen < frags.

Should this also mention that for small datalen with many fragments the
loop terminates before the last fragment, and that fewer fragments than
requested are produced?
-- 
pw-bot: cr

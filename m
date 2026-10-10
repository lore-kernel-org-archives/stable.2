Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CA236B07C;
	Sat, 10 Oct 2026 13:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791639197; cv=none; b=RQiBJcCOR/lbkRe/hCpGzoIqzbnESP/wkfKSfJFcOTSKUKxgCZEF1O6lVRhA7QuniQuwockqG3fiZonsBtaekBoJkSMvQUR9bYYB/cSCQLOeBjbFEVJDI2V68eD/L/tEl9Bg1Y15uWskng2Gn7HHmMmUlZDJeStWRA0zb9a2WmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791639197; c=relaxed/simple;
	bh=fQ96koIwsc+73ye2d9WY1cAHeJdGvpPPwMKjvKPy60U=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IMKFQhl2IS630KMFn6QVu8SRAvKh908O8xgHxdbiHxH96hME0L8IB+ISURpYd0Nzee/3zRq/D1xRWyX48cGiHY5LaY5JHFpd1I3W4UOfagWyns8tR01B0LHdFSLJ1MqdrjI5YU2b8YzRq/dO9MZayjHEMFVbj42r2uL/luZNy/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BkAJVzE1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BkAJVzE1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 053691F000FF;
	Sat, 10 Oct 2026 13:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791639195;
	bh=hSeD2f5/61SwfYL5OwNCKY5q2+rB1164Ic0xoMaUHwU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=BkAJVzE1U0KVGOqZ/8okpduQkfKpZZsG5ycHEHb5VVYkj8pCi5Nml+GXwITmxWdrb
	 v0f0qwLgReRbV2uyHP0Fn1z9JXU0N5TK+n2sUiIftIudcQyqmx0f9lJx034aFStm1k
	 dfuuLbixvN0obW3B/iBmtGwPMiK/MQVtszmA9hZ6ZZ+DMJ2RWrUL/pUfyn7s6BLWNs
	 DQxp3V8C4bnUCM9FnPzeYQJgLgu0VpWoBIdQ7rxCcwUJQ4VmlIr0nXHrGlXnTHGcS6
	 bEFcQVmQSHclH5f79gQpvTHfNdmlJ9ZE59vJbQPmOzdkmk5SFExAaeyKX6nJ2hdlzo
	 fOyrYnINAvpdA==
Subject: Re: [PATCH net] net: skbuff: don't segment unreadable skbs without SG
From: netdev-bot+sashiko@kernel.org
To: josef@toxicpanda.com
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, almasrymina@google.com,
 willemb@google.com, kaiyuanz@google.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Sat, 10 Oct 2026 13:33:14 +0000
Message-ID: <179163919450.434549.9325877615055483977@kernel.org>
In-Reply-To:
 <20261009-b4-skb-segment-nosg-unreadable-v1-1-7e2334a55fe8@toxicpanda.com>
References:
 <20261009-b4-skb-segment-nosg-unreadable-v1-1-7e2334a55fe8@toxicpanda.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message says the 'only checksum offload off' case
  is safe because 'the segments keep sharing the frags'.

--

net: skbuff: don't segment unreadable skbs without SG

This patch makes skb_segment() reject unreadable skbs, including their
frag_list members, when NETIF_F_SG is not set. Without SG the payload is
copied out of head_skb. Since commit ab9414ed70bd, a devmem payload copied
that way turns into zeroes that carry a valid checksum.

Link: https://lore.kernel.org/all/179148235783.434549.14322374227477832817@kernel.org/

> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 41beaf625421a..4ba544b5f3bab 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c

[ ... ]

> @@ -4842,6 +4854,14 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
>  	sg = !!(features & NETIF_F_SG);
>  	csum = !!can_checksum_protocol(features, proto);
>  
> +	/* Without SG every segment's payload is copied out of head_skb, which
> +	 * can't be done for unreadable frags.
> +	 */
> +	if (!sg && skb_segment_unreadable(head_skb)) {
> +		err = -EINVAL;
> +		goto err;
> +	}
> +

[Severity: Medium]
Does this guard also need to cover the sg && !csum case?

The commit message says:

  "and with only checksum offload off the segments keep sharing
  the frags."

The segments do share the frags. But in that case skb_segment() still
reaches perform_csum_check, and __copy_skb_header() has already copied the
unreadable bit into each nskb:

net/core/skbuff.c:skb_segment() {
    ...
perform_csum_check:
		if (!csum) {
			if (skb_has_shared_frag(nskb) &&
			    __skb_linearize(nskb))
				goto err;

			if (!nskb->remcsum_offload)
				nskb->ip_summed = CHECKSUM_NONE;
			SKB_GSO_CB(nskb)->csum =
				skb_checksum(nskb, doffset,
					     nskb->len - doffset, 0);
    ...
}

The devmem MSG_ZEROCOPY path in tcp_sendmsg_locked() goes through
skb_zerocopy_iter_stream() and never sets SKBFL_SHARED_FRAG. As far as I
can tell, only the MSG_SPLICE_PAGES branch sets it. That means the
__skb_linearize() fallback is skipped and skb_checksum() is called on an
nskb whose payload is entirely in unreadable frags. skb_checksum() then
hits:

	if (WARN_ON_ONCE(!skb_frags_readable(skb)))
		return 0;

This leaves SKB_GSO_CB(nskb)->csum at 0. tcp_gso_segment() then calls
gso_make_checksum() and writes a TCP checksum that does not cover the
dmabuf payload that actually goes out on the wire.

The setup looks reachable in the same way the commit message describes
for the case where both features are off. sk_setup_caps() grants SG and
HW_CSUM, and validate_xmit_unreadable_skb() lets the skb through.
harmonize_features() strips the checksum and GSO features but keeps SG:

	if (skb->ip_summed != CHECKSUM_NONE &&
	    !can_checksum_protocol(features, type)) {
		features &= ~(NETIF_F_CSUM_MASK | NETIF_F_GSO_MASK);
	}

So with tx-checksumming off and SG on, software GSO reaches skb_segment()
with sg=1 and csum=0. The result is a WARN splat, and the peer drops
segments that will never checksum correctly, including on retransmit.

Would checking !sg || !csum here be more appropriate? Since this is
tagged for stable, could the commit message also be updated so it does
not describe the checksum-off-only case as safe?

>  	if (sg && csum && !gso_by_frags)  {
>  		if (!(features & NETIF_F_GSO_PARTIAL)) {
>  			struct sk_buff *iter;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009-b4-skb-segment-nosg-unreadable-v1-1-7e2334a55fe8%40toxicpanda.com

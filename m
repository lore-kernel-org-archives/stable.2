Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795311508;
	b=07UherGY5dxIFK0S5HLALtbdVRiFW9P9MEwWRpIN44xP58FItb2AxsqMKI+HzEbDP0fW
	 ZktQbu8GDOI7Kpx4Y1XW5+klsTsIVavaCfEZl3k/Oluaf6S/lr1+eFIrPdgpsQ3vwWu+8
	 EW2SGs6h42+G6cTmMS4dqGz6zxFVRAfC6i6LykyJhIwkcPoiiro6pKM5w4pbfIhjlwQ0a
	 wKH7TdcHNQYm8IwTlZ0jycza7mB6FBsm5Ubv7rvtRDRK4OEd+0Oc4Xt7kBHumc77LDJ1Y
	 KHk/NIcySUuWYnzyzJYH39fDN+1yO8afqdTs49dlVyL6X4pVyoi4xxGegTzAAF8ZsVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795311508;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=81Pbkrc52gEy+fyEGLKCyvPeoMIXZ32F4Jmz33E/W4w=;
	b=z8mEtCAs/eYX9T9fM7/DMfOcMVO0hJ4TJ2gvr/41of9wti7DFS/RoT5Nw3ZBDDMOqDJH
	 Zu6TvDmFl1cPsBIczaj1IU7+iTQLsMGe3tP885lYqVMWhfxkJs1CzGRnM5V8pJe6JFp5I
	 rZh7Ri6V8r0KOnjpT7UV/qSoCXrQsv5ytlkTrUQxulQdwKgrFinYPZ/cy4eIFuOriAWWP
	 v0lJVxPFrs6/kjY+fUNoGf82+lguL2S0W4dCRazfr55H/hgjAKeCof0KUHcZe/TA/jNFL
	 Lrxn/PCA6XNL9qD5lmGVk5nHfDOtKEX31R5ubzwTH4RkGVbHjD80OCU1E1O/N8k1uVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KGDjHrI0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF21F606A32A;
	Sun, 22 Nov 2026 01:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KGDjHrI0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A91171F000C4;
	Sun, 22 Nov 2026 01:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795311508;
	bh=81Pbkrc52gEy+fyEGLKCyvPeoMIXZ32F4Jmz33E/W4w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KGDjHrI0XUWcenBRawfxf232RBlQKwxPGfIOwt+Fpe9pi6zDCHXyEIG4JQ93Rak9J
	 J1g/af98yy2+e8/OiPB7Y32gntgb3zlTXnDE278xHpb2tGzDGn7nik71+MjvIRHjwj
	 +FFE6OAzKEbFjvyE3OxK4Y/NQ620qvdvY0aars6tJlINftf2vmfFUvJkNcrosSdIIu
	 pKHiul5iIzCWe3FeMWgSpWfBlQPWdg+R8ve+/0TYWeoqomHe2wCBdtpbNmGYehlf/E
	 k2xlS2aoQyhw25xCOL6aIyo38Mv/FGx+lLZKH43YR2gD0F7s9OPW3nQa7gDpaUD0Pl
	 kmCNss1EfAK8g==
Subject: Re: [PATCH ipsec 1/2] xfrm: iptfs: don't modify the shared info of
 cloned skbs on output
From: netdev-bot+sashiko@kernel.org
To: opensource@andrii.net
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, chopps@labn.net, netdev@vger.kernel.org,
 ipsec@lists.linux.dev, linux-kernel@vger.kernel.org, security@kernel.org,
 stable@vger.kernel.org
Date: Sun, 22 Nov 2026 01:38:27 +0000
Message-ID: <179531150722.3135.5639628464200463791@kernel.org>
In-Reply-To: <c1e999b5-15ee-468d-81c5-530a560e84df@mid.andrii.net>
References: <c1e999b5-15ee-468d-81c5-530a560e84df@mid.andrii.net>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete.
- [Low] The commit message says: "ESP copies a cloned head anyway, so
  this moves that copy earlier and does not add one." That is not true…

--

xfrm: iptfs: don't modify the shared info of cloned skbs on output

This patch changes how iptfs_output_queued() handles a cloned first skb.
It unclones the skb before appending inner packets to its frag_list, or
sends it on its own if it already has a frag_list or cannot be uncloned.
It also stops aggregation at a cloned skb2 that has a frag_list, and
keeps iptfs_consume_frags() from taking the page frags of a cloned skb2.

> diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
> index 0313a43aa8a97..95ba7301324b9 100644
> --- a/net/xfrm/xfrm_iptfs.c
> +++ b/net/xfrm/xfrm_iptfs.c
> @@ -2234,6 +2234,19 @@ static void iptfs_output_queued(struct xfrm_state *x, struct sk_buff_head *list)
>  		if (iptfs_first_skb(&skb, xtfs, mtu))
>  			continue;
>  
> +		/* A clone shares skb_shinfo(), and with it the frag_list we
> +		 * are about to append to, with its original, e.g. the skb TCP
> +		 * keeps for retransmission. A cloned head that has a frag_list,
> +		 * or that we cannot unclone, is sent on its own rather than
> +		 * aggregated; the skbs on a frag_list stay shared with the
> +		 * original even after an unclone, so they are never appended.
> +		 */
> +		if (skb_cloned(skb) &&
> +		    (skb_has_frag_list(skb) || skb_unclone(skb, GFP_ATOMIC))) {
> +			xfrm_output(NULL, skb);
> +			continue;
> +		}

[Severity: High]
Does this guard hold the "they are never appended" rule from the comment
above? It only tests skb_cloned(skb). It also runs after
iptfs_first_skb(), which may already have uncloned the head.

For a CHECKSUM_PARTIAL head, iptfs_first_skb() does:

	if (skb->ip_summed == CHECKSUM_PARTIAL) {
		err = skb_checksum_help(skb);

On a cloned skb, skb_checksum_help()->skb_ensure_writable()->
pskb_expand_head() calls skb_clone_fraglist(). That only takes a
reference on each frag_list member. It then clears skb->cloned and
resets dataref to 1:

net/core/skbuff.c:pskb_expand_head() {
    ...
		if (skb_has_frag_list(skb))
			skb_clone_fraglist(skb);
    ...
	skb->cloned   = 0;
    ...
}

After that, skb_cloned(skb) is false, but the original still links the
frag_list members.

Wouldn't two later steps then write into sk_buffs the other owner still
links? The first is the re-home loop, where iptfs_rehome_fraglist()
rewrites the members' frag_list, len and data_len. The second is this
append:

	*nextp = skb2;

The ->next of the last shared member would then point to skb2, which the
other owner's len and data_len do not count.

There seem to be a few other ways to reach the same state.

The new break in the inner loop leaves a cloned skb2 that has a
frag_list for the next head. On the next pass that skb goes through
iptfs_first_skb() again, so it can be uncloned the same way and then
aggregated anyway.

Heads can also arrive already uncloned but with shared frag_list
members. For example, nf_dup_ipv4() calls pskb_copy(), and
__pskb_copy_fclone() does:

	if (skb_has_frag_list(skb)) {
		skb_shinfo(n)->frag_list = skb_shinfo(skb)->frag_list;
		skb_clone_fraglist(n);
	}

A reassembled forwarded packet and its duplicate are then both
non-cloned but share their frag_list members. skb_cow() in ip_forward()
on a cloned skb has the same effect.

A non-cloned skb2 whose frag_list members are shared also gets past the
new skb_cloned(skb2) && skb_has_frag_list(skb2) check. Its members are
then linked into the head's chain, and later appends write their ->next.

When the other owner frees its skb, can kfree_skb_list() follow the
modified ->next into skb2? By then skb2 may already be freed, or
consumed by ESP's skb_cow_data(). The result would be a use-after-free,
a double free, or the same skb_over_panic described in the commit
message.

For comparison, __pskb_pull_tail() forks shared list members with
skb_clone(), and skb_cow_data() copies them.

Could the code refuse to aggregate onto, or re-home, any frag_list with
an skb_shared() member, whether or not the head is cloned? Or could the
clone/frag_list decision be made before skb_checksum_help() can unclone
the head?

[Severity: Low]
The commit message says:

    Unclone the first skb before appending to it. ESP copies a cloned head
    anyway, so this moves that copy earlier and does not add one.

Is that accurate for the local TCP case this patch targets?
skb_unclone() here does pskb_expand_head(skb, 0, 0), which adds no
tailroom. The following skb2s are TCP clones, so share_ok becomes false
and they go onto the frag_list.

In esp_output_head() the head is no longer cloned. It still has a
frag_list, though, so this check fails and it goes to cow:

		} else if ((skb_shinfo(skb)->nr_frags < MAX_SKB_FRAGS)
			   && !skb_has_frag_list(skb)) {

skb_cow_data() then sees nr_frags != 0:

	if ((skb_cloned(skb) || skb_shinfo(skb)->nr_frags) &&
	    !__pskb_pull_tail(skb, __skb_pagelen(skb)))

If the pulled data does not fit in the tailroom, __pskb_pull_tail() does
a second pskb_expand_head(). Before the patch, the cloned head needed
only one pskb_expand_head(skb, 0, eat + 128) inside __pskb_pull_tail().

Doesn't this add a head reallocation and copy for each aggregated outer
packet? When nothing is aggregated, the uncloned head can take ESP's
page-frag path and a copy is saved instead. Either way, the cost depends
on the traffic.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/b56bbced-a8b0-4ae9-80b4-1958ea36684c%40mid.andrii.net

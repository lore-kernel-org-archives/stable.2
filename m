Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793086268;
	b=LLC1kmP8VFRDJwV+UIUCXZou8jiwDVtK8wlBjJoyXy09/JQ8eoZcuRjt/qp+/gwngpW0
	 jqmwZ5Av1nLU0dOXWh2goVuhh6AXBj2f1wiGqP43wWFLYKEOlcqc2lgYWHwBnUutlsK29
	 /8hF8C9631tgpsjUU8XK2UD1aZW1usZnFztGj3nhR0QFBkcUU4d0ezauKTgaJ/kT7P+6J
	 U5ZUrgZNPWDCMlwKwr5qw9KVfpwrk52Lu6gG604MrMX2vDroQCm4ZB5eaEUW/RKQM949o
	 tCq7iqHTBiyt8xE611C1ZGK4/JshiqFpz4Esr8JRgfJ1/rLpj7TjjKvrwo88NOmZoqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793086268;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=TSzWHCPYD+61FDYzvIaUM/XSpeBKrTUMpoKDAlcttLw=;
	b=K86N8BVr8zBIhOOCCNgdYZLHmZvwmAIhfSuaS44nV+XjT5BV5gF41a4EoCcAuF6cw6Ab
	 pkzIMxWHNKsaSG61pgU4dK5NZLaU/DiR/dhplzYXi550NHzUL9R6Ugm18U4l2CIMBevYL
	 Yz+8iYYVKdgQmGVYrfjQhfR/EebLiSXTAx8E+y0+TrwDTwUWXXTrOOru2QcKbQqX8uI75
	 HyM67VSDcO1byjcqQS/KuRqKW89iT2V4OKoSegLmMCO/isuf0UgaG4idAakWlnQJpSUwW
	 39ooH9yIa9bBlQ/Tk53n2hPLpKFxaSf5RvK+LPJsPo6SmtONbsarFtfXDH+IfXy3C6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M7g9fxfM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4402C606A31A;
	Tue, 27 Oct 2026 07:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M7g9fxfM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E4D1F01825;
	Tue, 27 Oct 2026 07:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793086267;
	bh=TSzWHCPYD+61FDYzvIaUM/XSpeBKrTUMpoKDAlcttLw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=M7g9fxfMXawEb4o84LE3DlT49o4CGS+NuHl7wlKbmcWmn4I7EOZMpv1Rr60pITHgg
	 Dqub4aRSd6IBNEnL3hUn1HiryZFfKQvr9frfsy2q//7GeQbxvG3TGmqZklF85tx4oq
	 P7f58F8+wY6DAAMmzRxaE/F/12KTxkDHKEdgbEvmUBxrgpcmdUKMdcdFdFvizKt4P3
	 m2gB66ToFe2tv+cAeDe4ouaXIp3kEuLfI9Ouals+wH76B2F6TacSsrBKriNZXpW1pu
	 cZ2U+ndptccftx8WpToOR3zREPcneEIxezbP86VemeGq0XX+Qwr5VLmw+24yOyMjRo
	 VlWnCOTp507gg==
Subject:
 Re: [PATCH net v3] xfrm: esp: reset outer TCP GSO metadata on espintcp input
From: netdev-bot+sashiko@kernel.org
To: yangguoshuai@gmail.com
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
 sd@queasysnail.net, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Tue, 27 Oct 2026 07:31:06 +0000
Message-ID: <179308626642.3134.14988418944940808850@kernel.org>
In-Reply-To: <20261023065311.65031-1-yangguoshuai@gmail.com>
References: <20261023065311.65031-1-yangguoshuai@gmail.com>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message presents a crash as the current failure
  mode: skb_segment() 'hits BUG_ON(!list_skb->head_frag)', followed by…
- [Medium] esp_reset_espintcp_fraglist_gso() (include/net/esp.h:31-71)
  replaces a shared frag_list member by writing `*fragp = frag` (line…
- [Low] The commit message names 'rx-gro-list is enabled' as the example
  trigger for the SKB_GSO_FRAGLIST case.

--

xfrm: esp: reset outer TCP GSO metadata on espintcp input

This patch clears stale outer TCP GSO metadata from espintcp ESP records
in esp_input() and esp6_input(). Before skb_cow_data(), a new helper
unclones the head and any frag_list members that carry SKB_GSO_FRAGLIST.
At skip_cow, skb_gso_reset() is called on the head and on every
frag_list member.

> Furthermore, if an outer TCP GRO aggregate carried SKB_GSO_FRAGLIST (e.g.,
> when rx-gro-list is enabled) and was chained onto
> skb_shinfo(head)->frag_list by __strp_recv(), skb_cow_data() invokes
> skb_copy() / skb_copy_expand() on that frag_list member and hits
> WARN_ON_ONCE(skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST), failing with
> -ENOMEM before decryption even begins.

[Severity: Low]
Is enabling rx-gro-list enough on its own to reach this case?

tcp4_check_fraglist_gro() looks up an established socket in the netns of
the GRO device. It enables fraglist GRO only when no socket is found:

net/ipv4/tcp_offload.c:tcp4_check_fraglist_gro() {
    ...
	net = dev_net_rcu(skb->dev);
	sk = __inet_lookup_established(net, iph->saddr, th->source,
				       iph->daddr, ntohs(th->dest),
				       iif, sdif);
	NAPI_GRO_CB(skb)->is_flist = !sk && !skb_is_gso(skb);
    ...
}

tcp6_check_fraglist_gro() does the same.

An espintcp flow always ends at a locally established TCP socket. If that
socket is in the same netns as the GRO device, is_flist stays 0. In that
case only plain SKB_GSO_TCPV4/V6 state reaches esp_input(), and the
skip_cow reset handles it without the new pre-pass.

It looks like esp_reset_espintcp_fraglist_gso() only matters when GRO runs
in a different netns from the espintcp socket and the aggregate arrives
unsegmented. One example is a host NIC forwarding into a container over
veth, since VETH_FEATURES includes NETIF_F_GSO_SOFTWARE and so
NETIF_F_GSO_FRAGLIST.

Could the commit message describe that topology? Could it also say that
this half of the fix depends on TCP fraglist GRO? That feature is much
newer than e27cca96cd68 from the Fixes: tag, so on stable trees without it
the pre-pass does nothing.

> stale gso_size and SKB_GSO_DODGY is not set, skb_segment() attempts to map
> the slab-backed frag_list member as a scatter-gather page fragment and hits
> BUG_ON(!list_skb->head_frag):
>
>   Internal error: Oops - undefined instruction: 0 [#1] SMP ARM
>   PC is at skb_segment+0x574/0xd20

[Severity: Medium]
Is there still a BUG_ON() at this point? In the tree this patch targets,
skb_segment() handles the condition like this:

net/core/skbuff.c:skb_segment() {
    ...
				} else {
					if (unlikely(!list_skb->head_frag)) {
						DEBUG_NET_WARN_ON_ONCE(1);
						err = -EINVAL;
						goto err;
					}
    ...
}

On current kernels, segmentation seems to fail and validate_xmit_skb()
drops the packet. A warning appears only with CONFIG_DEBUG_NET, and there
is no oops.

Could the commit message say which kernel the trace came from? Could it
also describe the behavior on the kernels this patch targets?

> diff --git a/include/net/esp.h b/include/net/esp.h
> index 322950727dd0a..09ed682209113 100644
> --- a/include/net/esp.h
> +++ b/include/net/esp.h
> @@ -28,6 +28,57 @@ static inline void esp_output_fill_trailer(u8 *tail, int tfclen, int plen, __u8
>  	tail[plen - 1] = proto;
>  }
>
> +static inline int esp_reset_espintcp_fraglist_gso(struct sk_buff *skb)
> +{

[ ... ]

> +	if (skb_unclone(skb, GFP_ATOMIC))
> +		return -ENOMEM;
> +
> +	for (fragp = &skb_shinfo(skb)->frag_list; (frag = *fragp);
> +	     fragp = &frag->next) {
> +		if (!(skb_shinfo(frag)->gso_type & SKB_GSO_FRAGLIST))
> +			continue;
> +
> +		if (skb_shared(frag)) {
> +			struct sk_buff *nfrag;
> +
> +			nfrag = skb_clone(frag, GFP_ATOMIC);
> +			if (!nfrag)
> +				return -ENOMEM;
> +
> +			nfrag->next = frag->next;
> +			consume_skb(frag);
> +			frag = nfrag;
> +			*fragp = frag;

[Severity: Medium]
Can fragp point at the ->next field of a member that is still shared when
this store happens?

When the head is cloned, the skb_unclone(skb) call above goes through
pskb_expand_head(). That calls skb_clone_fraglist(), which only takes a
reference on each member:

net/core/skbuff.c:skb_clone_fraglist() {
	skb_walk_frags(skb, list)
		skb_get(list);
}

After that, the old shinfo and the new shinfo both walk the same ->next
pointers.

Take a chain A -> B where A has no SKB_GSO_FRAGLIST, B does, and both are
now shared. The loop skips A with continue. It then clones B into N, calls
consume_skb(B), and writes A->next = N.

A is shared, so the other owner's chain now points at N as well. B still
holds one reference but is no longer linked anywhere, so it leaks. N has
users == 1 but two chains reach it.

skb_cow_data() runs next. It sees that A is shared, copies A and
everything after it, and calls kfree_skb() on N, while the other owner's
A->next still points at N. Can that lead to a use-after-free or double
free of N?

The -ENOMEM returns after this point can leave the same cross-linked chain
behind.

This relink pattern looks like it comes from ___pskb_trim(). That function
handles skb_shared() on every member before skipping any, so it never
writes through a shared predecessor. Would it be safer to privatize every
member walked so far, including the skipped ones, or to copy from the first
shared member onward the way skb_cow_data() does?

I could not find a current producer that hands esp_input() a cloned head,
or a shared non-FRAGLIST member in front of a FRAGLIST member. strparser
unclones the head or allocates a fresh one before chaining. Still, the
skb_unclone(skb) and skb_shared() branches here exist only for that case.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261023065311.65031-1-yangguoshuai%40gmail.com

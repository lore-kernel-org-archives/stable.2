Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793030894;
	b=NfiD9OQbqChnMImLwy4OiQq6CIpw8rv0zmEBHWdrpZ7Zm7GYpaFR6EMhaxSoCbBF/MuF
	 SkS2mJk52mPBcp3M2G3yihFzE9ZFIqjMtu7VdPpMTIhaMRObRSyz+l0IP4Z2CF0y8kFqm
	 7kmzSTjJ3V7Slu9mvRvrRE6C4S++JL6fINa0f9EABZl9toLeATJvudGGVjs68utWgwyky
	 gJjCZYoElWSwuDw0gM9zA+zChP+DwyVnP8fSID3ioQ2Y8585gg24z2y9Ay1igt1ztC0Uq
	 AZ7GeoU9eTSMzq8/EFsSdm+FXTFSMuo7UaW91IBHrfHbblm5Nt3CH+gSeDF1oktc7Lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793030894;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=bsElpaakProAkQI3U/uO4njKGWReKzYAsJKj9LZFt8g=;
	b=tcvbk8zRkVfjBdnBwndhbrmOVWHCyIugxW1rRQZWzXKe/Jkyuq823xvzb6P39EghA5fu
	 2cv2xf2MHSdkIGdNwtj77g7btibAMkCFyYmTB6LMxwFPK/tmsdK7GSfJQMnZUsRfoyVk0
	 GCZaZXf/uYeyzha70YvHnKBYCKLJ6Ta7TM2fGVPR4T5H28tz+lKY02A2P71GHXK5reIBB
	 bYGjjE70L9bMY/wAMZa9c6dBSPfFgizlBFNmrKwhSqUemWM3pkzMC2fBkiyyb2e8O1bKh
	 tSPWpnHOoRqgDdpHSADd5joURmIjlUIAmQNIGLAOYGI6k/EedyZO8xlP6C3kjgYn9Kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eht2wVRX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DB0606A31A;
	Mon, 26 Oct 2026 16:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eht2wVRX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D90041F01825;
	Mon, 26 Oct 2026 16:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793030893;
	bh=bsElpaakProAkQI3U/uO4njKGWReKzYAsJKj9LZFt8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eht2wVRXkDWjz1mwWq+3SSGPycnbiZJ9Wy+QJH13wQJNiaGpx5cnfWGdDH9IeQuIQ
	 jJD+sdPRFSVn7lJWuPejhqnZFciff9rxFrNbvTffsZuW++VDSzbro00TaWWtVXY6mx
	 mpkmMw24KAqAHM/zuoBVsrKJLVRYHl6cXqaOnKFvwpht9xnxjFU57pQZXPyEfcgJCr
	 wkFX8Nv/m6HXPtWx3VEq7KN8MXvywDDK+4aNN3niWAPidXuHU8nHyiX73fZCzLBQeE
	 pDe5Aq3ORa48yZXEcwvcumsiNbEmFrCrrOHqhlM3b7BzKrQY/PuwIt6QU1klPnyIUY
	 2IDOTMirNgQmg==
From: Simon Horman <horms@kernel.org>
To: jhs@mojatatu.com
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	victor@mojatatu.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	stable@vger.kernel.org,
	sashiko-bot@kernel.org
Subject: Re: [PATCH net 2/2 repost2] net/sched: sch_teql: keep skb->dev consistent on the arp-queue path
Date: Mon, 26 Oct 2026 16:07:47 +0000
Message-ID: <20261026160747.283702-1-horms@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <QDISC-6HS9.v1.r2.20261020051718-2@mojatatu.com>
References: <QDISC-6HS9.v1.r2.20261020051718-2@mojatatu.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email says "Hi Jamal, passing this on for your consideration as it
seems to have got stuck somewhere."
Full review at: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-6HS9.v1.r2.20261020051718-1@mojatatu.com?part=2
---
net/sched: sch_teql: keep skb->dev consistent on the arp-queue path

The patch sets skb->dev = slave before teql_resolve(). An skb parked on
the slave's neighbour arp_queue then names the slave, not the teql master.
It also adds skb->dev = n1->dev at the reinjection point in
neigh_update_process_arp_queue(), so parked teql skbs go back through
teql_master_xmit() when the neighbour resolves.

Link: https://lore.kernel.org/netdev/20260824115928.4099988-1-victor@mojatatu.com/

> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index 7448320f7ad52..5823f5007812b 100644
> --- a/net/core/neighbour.c
> +++ b/net/core/neighbour.c
> @@ -1336,6 +1336,7 @@ static void neigh_update_process_arp_queue(struct neighbour *neigh)
>  			if (n2)
>  				n1 = n2;
>  		}
> +		skb->dev = n1->dev;
>  		READ_ONCE(n1->output)(n1, skb);
>  		if (n2)
>  			neigh_release(n2);

[Severity: Medium]
The commit message says this assignment "is the identity for every other
parker (neigh_resolve_output() parks with skb->dev == neigh->dev, ndisc
probes carry no skb)". Does that hold when the skb's dst points at a
different device than the neighbour it was parked on?

If the dst is not DST_OBSOLETE_DEAD, n1 is not the parking neighbour. It is
replaced by n2 from dst_neigh_lookup_skb(), and ipv4_neigh_lookup() looks
that neighbour up on the dst's device:

net/ipv4/route.c:ipv4_neigh_lookup() {
    ...
	dev = dst_dev_rcu(dst);
	if (likely(rt->rt_gw_family == AF_INET)) {
		n = ip_neigh_gw4(dev, rt->rt_gw4);
    ...
}

So the new line is only a no-op when dst->dev == skb->dev.
skb->dev == neigh->dev is not enough.

At least two parkers seem to break that. The first is bpf_redirect_neigh()
with explicit nexthop params. bpf_out_neigh_v4() moves skb->dev to the
redirect target B and resolves the nexthop on B:

net/core/filter.c:bpf_out_neigh_v4() {
    ...
	skb->dev = dev;
    ...
	} else if (nh->nh_family == AF_INET) {
		neigh = ip_neigh_gw4(dev, nh->ipv4_nh);
    ...
}

However, __bpf_redirect_neigh_v4() only replaces the dst in the !nh branch,
so the routed dst for the original device A stays attached:

net/core/filter.c:__bpf_redirect_neigh_v4() {
    ...
		skb_dst_drop(skb);
		skb_dst_set(skb, &rt->dst);
	}
    ...
}

bpf_out_neigh_v6() follows the same pattern with ip_neigh_gw6().

The second is nft fwd ... neigh in a netdev egress chain.
nft_fwd_neigh_eval() changes skb->dev and parks the skb without touching
the dst:

net/netfilter/nft_fwd_netdev.c:nft_fwd_neigh_eval() {
    ...
	skb->dev = dev;
	skb_clear_tstamp(skb);

	nf_dev_xmit_recursion_inc();
	neigh_xmit(neigh_table, dev, addr, skb);
    ...
}

In __dev_queue_xmit(), nf_hook_egress() and sch_handle_egress() run before
the IFF_XMIT_DST_RELEASE skb_dst_drop(), so A's routed dst is still
attached at these hooks. If B's neighbour is incomplete, the skb is parked
on B's arp_queue with skb->dev == B and dst->dev == A.

When B's neighbour resolves, n2 is A's neighbour. With this patch skb->dev
becomes A, and n1->output() builds A's link-layer header and calls
dev_queue_xmit() on A.

Before the patch, the frame still left on B, though with A's link-layer
header, which was already a pre-existing problem. After the patch, would
the packets queued during resolution go through A's egress qdisc, tc and
nft hooks a second time?

That could mean nft_fwd_neigh_eval() calls ip_decrease_ttl() or
decrements hop_limit again. Non-idempotent BPF programs (encap,
adjust_room) would run again, and counting or stateful rules would see
the packet twice. If the redirect is not applied again on A's path, the
packets would leave on A and bypass the configured BPF or nft steering.

Since this is a change to core neighbour code tagged for stable, could the
reinjection fix be limited to the teql case? Alternatively, could the
commit message describe the behaviour change for these other parkers?

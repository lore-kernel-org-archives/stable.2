Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795438883;
	b=S7Hk+WCDBz0LLoJYrfptsutsygnlTZeZmmzzlhlBZDYtRYJDZnjekpxarXSS3nx9hNDH
	 zdoaKUrI9JKHJ+3Gp8FIJaQOUOHyQ1ur+BLZTX7TVdf9iOS7NyxT1EFKINeorE+BVjYUj
	 P+n5DJ7KUaIXk1Mjvm0tSEzcbK9yqjOQAXHkPH5h+efSlKSpya6nBY3U8b9KvG6ZrmEB/
	 8QWXKe1cH8jXUNYdl5DDGNtSf2IU03fNdPOJVjfXSiDktfKnI7YQnDjfw10QJSGYJJ9qY
	 ZG5Ghp0uL/RBRRelC1nPrfCsn3Zvscnlx/6uB2bgomh6nYxNExfuPU+FY01xgjUf27w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795438883;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PAuFky0Xtt+dFGs0iNDYak9fLerRV0YZCqKqpxkCLis=;
	b=O2kRRXdIir9VWQ8/ccqPo53U1PhiLvarJ4kyY10F3hCRyWNtdTmjuHOPBi72R+EoVQhN
	 w1QBSkZwWLlFlw1iXeBd35LdusUHJxee/MhsPzlubSQvOsAi0gHUxgw+vdG4tCZ9ecFzZ
	 BnlHtOx0wYxBEz3maB/KsvF5Y4Lkky+JAa2M577B1TNI71LUB03L8o1hvi0YFye4vzM1h
	 H9CEfKcMzAUIjQC3/Eu81AYrtteZZZ+selEujhusq1CvUdwfBpCazN5rCahcksVpFnu5k
	 hcd3x8LoHUOiL2fsz2Fiw3Yg8SA0XEtOq5sQlgZcEvikYQ45AoOp7Px9HHbN45khhLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ObFnkdJ0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5912606A334;
	Mon, 23 Nov 2026 13:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ObFnkdJ0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3C3A1F000D8;
	Mon, 23 Nov 2026 13:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795438883;
	bh=PAuFky0Xtt+dFGs0iNDYak9fLerRV0YZCqKqpxkCLis=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ObFnkdJ0NpEE89AHztqUdNV/pu2EK+vE5SUG5cQZX0Ynobb9/fFAfcvac8iOtekXM
	 eJsBseHRCtb6m9qd2CFZKE68RCtHaARiT+x27K3gH919GTwiw6QkK90vnx88WLBArR
	 dzKD38efXPaMIBK/ZvBfh7HDO2tIc5AL4qQZ8cMmmiPNSeyOM5NdK8O/1sjNCfrj+y
	 gBmNnTFy5ExHknSQkWjlG4P87WVuvqhi7zIQDJRz3fC0is/e4J56MmL68ZgDuP0Uzy
	 nKVNI5j4lMFHaJZgl+hZDjqr9sCuV1oQ9P1sj42gozAl7qlzW78F9yruLAmc/kMKuw
	 qsNXK6wpIFwvw==
Subject: Re: [PATCH net v6 2/3] net: neighbour: reinject a parked skb through
 a headerless output device
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, victor@mojatatu.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, stable@vger.kernel.org, sashiko-bot@kernel.org
Date: Mon, 23 Nov 2026 13:01:22 +0000
Message-ID: <179543888245.3135.17083845108187483466@kernel.org>
In-Reply-To: <QDISC-6HS9.v6.r0.20261119070330-2@mojatatu.com>
References: <QDISC-6HS9.v6.r0.20261119070330-2@mojatatu.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new gate in neigh_update_process_arp_queue()
  (net/core/neighbour.c:1345-1347) trusts the neighbour found through…
- [Low] The patch carries 'Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")' and
  'Cc: stable', but the commit message says it fixes nothing reachable…
- [Low] The new comment ('headerless output transmits on skb->dev, not
  n1->dev') and the commit message ('Such an output sends the skb out…

--

net: neighbour: reinject a parked skb through a headerless output device

This commit changes neigh_update_process_arp_queue() so that, before the
output call, skb->dev is set back to n1->dev when n1->dev has no
header_ops. It is the neighbour half of a pair with the sch_teql patch
"net/sched: sch_teql: keep skb->dev consistent on the arp-queue path",
which moves skb->dev = slave ahead of teql_resolve().

Link: https://lore.kernel.org/netdev/20261110101908.2e64e8e9@kernel.org/

> exists once the second half, "net/sched: sch_teql: keep skb->dev
> consistent on the arp-queue path", moves skb->dev = slave ahead of
> teql_resolve(): until then the parked skb still names the master, so the
> assignment is a no-op and the recipe below does not reproduce on this
> patch alone. The two are taken together.

[ ... ]

> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Link: https://lore.kernel.org/netdev/20261110101908.2e64e8e9@kernel.org/
> Cc: stable@vger.kernel.org

[Severity: Low]
Do the Fixes: and Cc: stable tags fit this patch when it is applied alone?

In this tree teql_master_xmit() in net/sched/sch_teql.c calls teql_resolve()
before it sets skb->dev = slave:

		switch (teql_resolve(skb, skb_res, slave, slave_txq, &hlen)) {
		case 0:
			if (__netif_tx_trylock(slave_txq)) {
				unsigned int length = qdisc_pkt_len(skb);
				int rc = NETDEV_TX_BUSY;

				skb->dev = slave;

So an skb parked by __teql_resolve() still names the master. The master has
no header_ops, so n1->dev == skb->dev and the new assignment does nothing
for teql.

The stable tag carries no prerequisite note. Could Fixes-driven stable
selection pull this into a tree where the sch_teql companion patch isn't
applied? In that tree the only visible effect would be the nft fwd /
bpf_redirect_neigh() side effect that the commit message describes.

Would a stable prerequisite annotation naming the sch_teql patch help here?

> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index ae2db3912454a..d36d86cfc441c 100644
> --- a/net/core/neighbour.c
> +++ b/net/core/neighbour.c
> @@ -1342,6 +1342,9 @@ static void neigh_update_process_arp_queue(struct neighbour *neigh)
>  			if (n2)
>  				n1 = n2;
>  		}
> +		/* headerless output transmits on skb->dev, not n1->dev */

[Severity: Low]
Is this comment accurate? It reads as if only the headerless output
transmits on skb->dev.

neigh_resolve_output() and neigh_connected_output() use neigh->dev only for
dev_hard_header(), and then call dev_queue_xmit(skb):

neigh_resolve_output():
		if (err >= 0)
			rc = dev_queue_xmit(skb);

neigh_connected_output():
	if (err >= 0)
		err = dev_queue_xmit(skb);

Both of these transmit on skb->dev too, the same as neigh_direct_output().
The real difference is whether n1->dev's link header gets written, not which
device sends the frame.

Could the comment, and the matching sentence in the commit message ("Such
an output sends the skb out whatever device skb->dev names, not out
n1->dev"), say that instead?

> +		if (!n1->dev->header_ops)
> +			skb->dev = n1->dev;

[Severity: Medium]
Can this gate send a redirected skb back out the original device, so that
its egress hook runs a second time?

Two producers steer an skb to another device but leave the original route's
dst attached. nft_fwd_neigh_eval() in net/netfilter/nft_fwd_netdev.c does
not drop the dst:

	skb->dev = dev;
	skb_clear_tstamp(skb);

	nf_dev_xmit_recursion_inc();
	neigh_xmit(neigh_table, dev, addr, skb);

__bpf_redirect_neigh_v4() and __bpf_redirect_neigh_v6() in net/core/filter.c
replace the dst only in the !nh branch:

		skb_dst_drop(skb);
		skb_dst_set(skb, &rt->dst);

Suppose one of these runs on egress of a device A that has NULL
header_ops, such as the teql master (teql_master_setup() never sets
header_ops). It redirects to an Ethernet device B whose neighbour is
unresolved:

neigh_resolve_output() on B's neighbour
  __neigh_event_send()
    skb_dst_force(skb);            /* A's dst is kept */
    __skb_queue_tail(&neigh->arp_queue, skb);

B resolves:

neigh_update_process_arp_queue()
  n2 = dst_neigh_lookup_skb(dst, skb);   /* A's neighbour */
  if (!n1->dev->header_ops)
      skb->dev = n1->dev;                /* skb->dev = A */
  neigh_direct_output()
    dev_queue_xmit()                     /* A's egress hook runs again */

For nft fwd, TTL/hop_limit is lowered a second time. A packet that arrived
with TTL 2 would then hit the iph->ttl <= 1 drop. Stateful nft expressions
and BPF map side effects would also run twice.

If the second pass does not redirect (a quota or limit is used up, or a
conditional rule no longer matches), the packet leaves via A instead of B.

The commit message acknowledges this and calls the producer fix "a
separate change to the producers". That change doesn't appear in this
series: after this commit only sch_teql.c changes, and nft_fwd_netdev.c and
filter.c still keep the dst. With Cc: stable, does this patch ship that
behaviour on its own?

Common L3 tunnels such as ipip, sit, ip6tnl, vti, L3 tun and wireguard set
ip_tunnel_header_ops, so the gate does not match them. Before this patch the
same path was already broken in a different way: the frame left B without a
link header.

>  		READ_ONCE(n1->output)(n1, skb);
>  		if (n2)
>  			neigh_release(n2);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-6HS9.v6.r0.20261119070330%40mojatatu.com

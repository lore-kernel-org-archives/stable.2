Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793637004;
	b=PwGmHL5iib1P9vFoJRzW1a0u7SbW2MshtT4u6WJOIhcyNbV3KxZOMQFJqm9Mqu2N73D4
	 IPgJc3H3v6o84UxQFzrcr+JKSa6UOiKqEnoRYX8KJ3lTgqfNbyGv3GANsYSms+ur3J/Wt
	 JgpqAMrLdBdJAGpH0roUcfejqPX4tdwPHBGZtVV4UbWpFKZ8uYRef3O4Ot5vbaI4QY19v
	 fde7Xj+ppuNBj7VuCFIKVqblpZQugnK+XN3w0qYWi7TsslLTmR6xDbE7isCbwJUEHz+yU
	 w0yOKG4tDc7AdOQi1WB03mF8ajYZ2xl5VzV2tVC8VUFt1wbuSphpkFQEvfV8wmPdUKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793637004;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=h4kYxvFfAorg4Jasu3Jf/tQfK1V990SC2QcBhguelIE=;
	b=djXBs6D1CeU8SWe1YYpnFCHmT+Tg3fYy4cWQIj09k4T/cQq6tdZsGABInSRlfJdJtSb4
	 swkn6PgIzpkA57ecK14ji7h+98v5b0LJS9hwN0vB1kCYsggvOHsevV3kvs+1YqV9aSahU
	 mMCSryd7t77QdJPTRXiI/D4uGhTUyBzYBpTV78L8zTGQg9fo/WszI5t2JHCCevk4VlfDq
	 brluc0bn5mOi4la3aDHfFYEfYzHyfDHOcPWeDrxBs79xHowpmRUXgXb/1yKh4eAIMdg/k
	 fi1bWzUrD5HJmVXQFEh8pQFYWnoeSWaWiDvAZ55e6kfqB7YdgvY7eVp0QgRwOTmbGew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HyjvVe50;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873266072ECD;
	Mon,  2 Nov 2026 16:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HyjvVe50
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A7731F00A17;
	Mon,  2 Nov 2026 16:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793637004;
	bh=h4kYxvFfAorg4Jasu3Jf/tQfK1V990SC2QcBhguelIE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HyjvVe50V1qRRZmBvd+x34by7kotPH65/V3/vkTrSkGNb7vwg03xJWIMSwGwDjshO
	 XkIFoxI3BThH4CYRpKomAxdFGsaB7xGeVlDx3EcwhW34SL4J5H0Lr0OlIww0djo8lc
	 DbDqwwA6qV0uF/9Q/BaBYBfAgq3uik8P5nivkWyVmfNbl9xRN6FUlf40fmPElkSgyY
	 rJrsn5+zrz+tE18a+xZSRWH/TcHOzkiAwTfScmHVyeEr9+fOVvmoKD3HjAD/CySky/
	 f//WYNPwA0Pfw16PASXN+g5e1ZQwTojMPqJ4qSrJ3dDfgAlQbuJ08xr/fvHg7JuSxc
	 HNuxpVNRa7w4w==
Subject: Re: [PATCH net v2 2/2] net/sched: sch_teql: keep skb->dev consistent
 on the arp-queue path
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, victor@mojatatu.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, stable@vger.kernel.org, sashiko-bot@kernel.org
Date: Mon, 02 Nov 2026 16:30:03 +0000
Message-ID: <179363700308.3131.11778179538290251434@kernel.org>
In-Reply-To: <QDISC-6HS9.v2.r0.20261101105945-2@mojatatu.com>
References: <QDISC-6HS9.v2.r0.20261101105945-2@mojatatu.com>
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

Critical: 0 · High: 0 (1) · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new gate in neigh_update_process_arp_queue()
  (net/core/neighbour.c:1343-1344), `if (!n1->dev->header_ops) skb->dev…
- [Medium] teql_master_xmit() now sets skb->dev = slave before
  teql_resolve() (sch_teql.c:371).
- [Low] The commit message's reproducer cannot show the use-after-free
  the patch says it fixes.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but
  teql_qdisc_init() (net/sched/sch_teql.c:194-253) never checks that the…

--

net/sched: sch_teql: keep skb->dev consistent on the arp-queue path

This patch moves skb->dev = slave ahead of teql_resolve(). An skb parked
on the slave's arp_queue then names the slave instead of the teql master.
It also restores skb->dev = n1->dev in neigh_update_process_arp_queue()
when the top-level neighbour's device has no header_ops, so the skb goes
back through teql_master_xmit().

Link: https://lore.kernel.org/netdev/20260824115928.4099988-1-victor@mojatatu.com/
Link: https://lore.kernel.org/netdev/20261026160747.283702-1-horms@kernel.org/
Link: https://lore.kernel.org/netdev/20261031165925.780930-1-horms@kernel.org/

> Conditions to recreate the bug:
> CONFIG_NET_SCH_TEQL=y, CONFIG_VETH=y, run as root. Create a veth pair,
> make one end a teql slave, give the master an address and a route, flush
> the slave's neighbour entry and send one packet:

[ ... ]

> On the unfixed tree the skb is parked on v0's arp_queue while skb->dev
> still names teql0, so the reinjection can reach a master that teql_exit()
> has freed.

[Severity: Low]
Can this recipe reach the use-after-free it describes?

With CONFIG_NET_SCH_TEQL=y, teql_exit() is __exit and never runs, so no
master is ever freed:

net/sched/sch_teql.c:teql_exit() {
    ...
		unregister_qdisc(&master->qops);
		unregister_netdev(master->dev);
		free_netdev(master->dev);
    ...
}

teql_master_setup() installs no rtnl_link_ops, so "ip link del teql0"
can't free the master either.

Building sch_teql as a module doesn't change this. teql_master_setup()
sets ops->owner = THIS_MODULE, and qdisc_lookup_ops() takes a module
reference through bpf_try_module_get() for each slave qdisc. rmmod
therefore fails while the slave qdisc on v0 exists.

To reach a freed master you seem to need sch_teql as a module, then
"tc qdisc del dev v0 root", then "rmmod sch_teql". All of this has to
happen while the skb is still parked on v0's arp_queue. None of these
steps are in the recipe. Could the recipe be updated to match?

Also, the message only names the reinjection path. Commit dc4b95b8fee9
showed this KASAN-confirmed path for a stale skb->dev:

neigh_invalidate()->arp_error_report()->ipv4_link_failure()->__icmp_send()

Here __icmp_send() reads skb_in->dev. This patch covers that path too,
because the parked skb now names the slave. Would it be worth saying so
in the message?

> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index d6e9c7c59a892..541cf699abae4 100644
> --- a/net/core/neighbour.c
> +++ b/net/core/neighbour.c
> @@ -1339,6 +1339,9 @@ static void neigh_update_process_arp_queue(struct neighbour *neigh)
>  			if (n2)
>  				n1 = n2;
>  		}
> +		/* headerless outputs (teql, shaper) transmit on skb->dev */
> +		if (!n1->dev->header_ops)
> +			skb->dev = n1->dev;
>  		READ_ONCE(n1->output)(n1, skb);

[Severity: Medium]
Is this check narrow enough to match only teql?

n1 comes from dst_neigh_lookup_skb() on the skb's retained dst. It does
not come from neigh, the neighbour the skb was parked on. Nothing checks
that neigh->dev is a teql slave of n1->dev, so any headerless route
device matches.

Two producers park the skb on another device Y's neighbour while keeping
the original route's dst:

- nft "fwd ... neigh", via nft_fwd_neigh_eval(). nft_fwd_validate()
  allows it at NF_NETDEV_EGRESS.
- bpf_redirect_neigh() with an explicit nexthop.
  __bpf_redirect_neigh_v4/v6 only replace the dst when nh == NULL.

Suppose such a forward runs at the egress hook of a headerless device X
and the neighbour on Y is unresolved:

__neigh_event_send()
  skb_dst_force(skb)                    /* dst->dev is still X */
  queue on Y's arp_queue

neigh_update_process_arp_queue()
  n1 = dst_neigh_lookup_skb(dst, skb)   /* X's neighbour */
  skb->dev = n1->dev                    /* X */
  neigh_direct_output()->dev_queue_xmit(X)

nf_skip_egress was reset after sch_handle_egress(), so nf_hook_egress()
runs X's egress chain a second time.

The forward then runs twice. nft_fwd_neigh_eval() decrements TTL again,
so a TTL=2 packet that should leave Y with TTL 1 is dropped here on the
second pass:

		if (iph->ttl <= 1) {
			verdict = NF_DROP;
			goto out;
		}

Quota, limit and counter state are charged twice. The second pass may
also decide differently, for example with numgen, an expired set element
or a ruleset change. The packet then leaves through X, the route the
forward was meant to bypass.

Devices that match as X include:

- point-to-point ipgre with a unicast remote, and collect_md gre
  (ipgre_tunnel_init() leaves header_ops NULL)
- ppp, eql and teql

Tunnels using ip_tunnel_header_ops (wireguard, tun, ipip, sit, xfrmi and
so on) don't match. Before this patch these skbs left Y without a link
header. That was broken, but they never re-entered X.

The commit message acknowledges this and leaves the producer fix to a
separate change. This net/core change is going to stable under a
sch_teql subject. Could the producer fix be included, or the gate
narrowed, for example by requiring neigh->dev to be a teql slave of
n1->dev?

> diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
> index ed8faa848f184..4eac1f9c8ddf6 100644
> --- a/net/sched/sch_teql.c
> +++ b/net/sched/sch_teql.c
> @@ -368,13 +368,13 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
>  			continue;
>  		}
>  
> +		skb->dev = slave;
>  		switch (teql_resolve(skb, skb_res, slave, slave_txq, &hlen)) {

[Severity: Medium]
What happens to an skb parked here if the neighbour then fails?

In case 1 of teql_resolve(), teql_master_xmit() returns before the
skb->dev = dev restore at the bottom of the loop. The skb therefore sits
on the slave's arp_queue with skb->dev = slave.

Only neigh_update_process_arp_queue() was changed to put the master back.
The other consumer of the queue passes the skb on unchanged:

net/core/neighbour.c:neigh_invalidate() {
    ...
	while (neigh->nud_state == NUD_FAILED &&
	       (skb = __skb_dequeue(&neigh->arp_queue)) != NULL) {
		write_unlock(&neigh->lock);
		neigh->ops->error_report(neigh, skb);
    ...
}

For IPv6 the call chain is:

ndisc_error_report()->dst_link_failure()->ip6_link_failure()->
icmpv6_send()->icmp6_send()

icmp6_send() takes its context from skb->dev:

	net = dev_net_rcu(skb->dev);
	...
		iif = l3mdev_master_ifindex(skb->dev);

It also uses ipv6_chk_addr(net, &hdr->daddr, skb->dev, 0), and
icmp6_iif(skb) for link-local sources. That iif becomes flowi6_oif for
the route lookup of the error.

These values used to come from the teql master. Now they come from the
slave, which changes the result in these setups:

- teql0 in a VRF with the slave outside it: the ICMPv6 Destination
  Unreachable is routed in the main table instead of the VRF table.
- A link-local source on teql0: the oif becomes the slave.
- A slave in another netns: the error is built in that netns.

Can the local sender's error be dropped or misrouted in these setups?

Would restoring skb->dev on this path as well avoid this? One option is
skb_dst(skb)->dev, which dst_dev_put() keeps valid.

[Severity: High]
This isn't a bug introduced by this patch, but should teql_qdisc_init()
check that the slave and the master are in the same network namespace?

The teql Qdisc_ops are on the global qdisc_base list, so
qdisc_lookup_ops() finds "teql0" from any netns. rtnetlink_rcv_msg()
only checks netlink_net_capable(skb, CAP_NET_ADMIN) against the caller's
own netns. teql_qdisc_init() then checks only hard_header_len,
m->dev == dev and the root parent:

net/sched/sch_teql.c:teql_qdisc_init() {
    ...
	if (dev->hard_header_len > m->dev->hard_header_len)
		return -EINVAL;

	if (m->dev == dev)
		return -ELOOP;
    ...
		m->dev->mtu = dev->mtu;
		m->dev->flags = (m->dev->flags&~FMASK)|(dev->flags&FMASK);
    ...
}

As a result, root inside an unprivileged user+net namespace can run
"tc qdisc add dev <own veth> root teql0". That enslaves its own device
to the init_net master. If it is the first slave, it also overwrites the
master's mtu and flags.

teql_master_xmit() then round-robins init_net traffic routed through
teql0 onto that device. __teql_resolve() creates the neighbour there, so
the namespace can read or drop that traffic and controls neighbour
resolution for parked skbs. This needs sch_teql loaded or built in by
the host. There is no MODULE_ALIAS for autoloading.

With this patch, parked skbs also carry skb->dev = slave. ICMPv6 errors
from neighbour failure that quote the init_net packet are therefore
built in that namespace, through dev_net_rcu(skb->dev) in icmp6_send().

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-6HS9.v2.r0.20261101105945%40mojatatu.com

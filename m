Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795438885;
	b=JBU7lIwhNLZmNFbgBigFBROfmaFlAS3pqVzNhRQAKKeHQ6daR5Ry6J8Re3YSNgTIda18
	 x+oIvlgmATuI/TzSh+JI7nKQePpCakYU9CJWrCV6DF1TNlXq58CWZU0Pt98JZyoeS5nvX
	 Dr5Q//xOxiPjM74nW3t4hrAA+prIMZB1IRGGWy0fGKHdVS1ZFtr6OpvixELrbv3dlvNv5
	 iIXbljIt7G2DlrVsxyEmr1BGkK80+oCPNsSkx7ojVcQyR37Kn4ViuyJakBTjRQ91qaBsg
	 iBz9EU39hYzvNh8VjS1Z2BDfyCfmMTxoGeud/RwvIwZMCBD/MXn8GQ4H3INz2AHqhSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795438885;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=7B0XGPs9uQAsvxEAzDDGWL2g9UjuSldtpIV18hZUoF0=;
	b=5DqmxhgO8YhQrZdMWgpBneM4qnX8ZVXC4AH9EATqhMxbJXsTfjAHrRv1bcOJfDyV5XHV
	 4WIXYyVDWrnOGNzPvkju4BaUx9oNQODMjqytrgqs9KpbB8o4yvv2B5FFYkOx9ajQFqrqn
	 ju2GCCs+nFYtAPOVpFLueBdde6VUXEXaDEbzvZcPozQbxC8QpCVK/LCfWxHEjkqMnOHQe
	 WK/wH9c6LQIQUl4yR4zjjiXhDY1yXs08ZCdTkoMz2emrVleaYwNVJ4LzSpkcRByrW8h3l
	 fvqWCiEvbYJYXAMzLkAkFvyXUHtwwAagT3YWkBR6V0bVwwx+kCwBhs5sUoK+VozTOcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J4e6GJQT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386CC606A330;
	Mon, 23 Nov 2026 13:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J4e6GJQT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A8CD1F000F2;
	Mon, 23 Nov 2026 13:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795438885;
	bh=7B0XGPs9uQAsvxEAzDDGWL2g9UjuSldtpIV18hZUoF0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=J4e6GJQTCi2Z6ebF2SY20q9EtAjBapek8PSi16zF9j0gkzSpATxochrc6tq5ngTSa
	 xfKjhfNv4vCdf6OCYWeGevGUlHRgu9+asjOKGxFitkZfE5jDKgKykGrEuaw4lIUIwq
	 HEm6GdPLoNKA+P2G80juOViELVD81hAfzfQh/3CrNizIVWmeSuKnZpOZ2LJllkDc/B
	 LXkvc5vbWUe1KLT4NnxbQ30p+nfjzrHAxDfeD413SUJ6+gTkXIfA02U9Le3iBE72E3
	 ZQszWkwaInlhpVP3TziOW9D4bdiUHTPFrMZkxvrBNV4lWxHfL9BODiPaQqzdk8IxtR
	 NwOR/svaTCC2Q==
Subject: Re: [PATCH net v6 3/3] net/sched: sch_teql: keep skb->dev consistent
 on the arp-queue path
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, victor@mojatatu.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, stable@vger.kernel.org, sashiko-bot@kernel.org
Date: Mon, 23 Nov 2026 13:01:24 +0000
Message-ID: <179543888407.3135.9702684913821781475@kernel.org>
In-Reply-To: <QDISC-6HS9.v6.r0.20261119070330-3@mojatatu.com>
References: <QDISC-6HS9.v6.r0.20261119070330-3@mojatatu.com>
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The use-after-free class this patch claims to close is still
  reachable, and is now easier to trigger.
- [Medium] Wrong egress device when a parked skb whose dst points at a
  third device is reinjected.
- [Medium] The stable tags do not record that this patch depends on
  another.
- [Low] The commit message understates how the move changes ICMPv6 error
  generation.

--

net/sched: sch_teql: keep skb->dev consistent on the arp-queue path

This patch moves the skb->dev = slave assignment in teql_master_xmit()
ahead of teql_resolve(). An skb parked on the slave neighbour's arp_queue
then names the slave rather than the teql master, which avoids a
use-after-free when teql_exit() frees the master on module unload. It
depends on an earlier patch that changes neigh_update_process_arp_queue()
to reinject parked skbs through a headerless output device.

Link: https://lore.kernel.org/netdev/20260824115928.4099988-1-victor@mojatatu.com/
Link: https://lore.kernel.org/netdev/20261026160747.283702-1-horms@kernel.org/
Link: https://lore.kernel.org/netdev/20261031165925.780930-1-horms@kernel.org/
Link: https://lore.kernel.org/netdev/179363700308.3131.11778179538290251434@kernel.org/
Link: https://lore.kernel.org/netdev/20261110101908.2e64e8e9@kernel.org/

> The error now names the slave, so it is also routed for the slave: IPv4
> takes the ICMP output interface from icmp_get_route_lookup_dev() and IPv6
> from skb->dev. A teql master enslaved to a VRF had its host-unreachable
> looked up in the VRF and now has it looked up in the main tables with
> oif 0.

[Severity: Low]
Does this cover everything that changes on the IPv6 side? On the
neigh_invalidate()->ndisc_error_report()->dst_link_failure()->
ip6_link_failure() path, icmp6_send() takes more than the l3mdev from
skb->dev:

net/ipv6/icmp.c:icmp6_send() {
    ...
	net = dev_net_rcu(skb->dev);
    ...
	if (ipv6_chk_addr(net, &hdr->daddr, skb->dev, 0) ||
	    ipv6_chk_acast_addr_src(net, skb->dev, &hdr->daddr))
		saddr = &hdr->daddr;
    ...
	if (__ipv6_addr_needs_scope_id(addr_type)) {
		iif = icmp6_iif(skb);
    ...
}

teql_qdisc_init() checks that master and slave share a netns only when the
slave is attached. teql_master_setup() does not set netns_immutable. If the
master is moved later, the error is now generated, rate-limited and routed
in the slave's namespace.

For a source that needs a scope id (link-local), iif is now the slave's
ifindex rather than 0, so "oif 0" doesn't hold there.

The saddr check through ipv6_chk_addr() and ipv6_chk_acast_addr_src() also
runs against the slave now.

Could the commit message describe these effects as well?

> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

[ ... ]

> Cc: stable@vger.kernel.org

[Severity: Medium]
The patch has a plain Cc: stable and a Fixes tag that points at the initial
git import. Stable tooling will therefore pick this one-line move for nearly
every stable tree, and it will apply cleanly.

The commit message says this patch is only correct on top of "net:
neighbour: reinject a parked skb through a headerless output device". That
prerequisite changes neigh_update_process_arp_queue(), which only exists
since 705ef89ac986. In older trees the loop is open coded in
__neigh_update(), so the prerequisite won't apply there.

If this patch is backported alone, the parked skb with skb->dev = slave is
reinjected through the master's neighbour. teql_master_setup() sets
ARPHRD_VOID and installs no header_ops, so the output is
neigh_direct_output(). dev_queue_xmit() then sends the skb straight out the
slave with no link header, because __teql_resolve() already pulled it to
the network header.

Would it make sense to record the dependency in the stable tag (for example
"Cc: stable@vger.kernel.org # <version>: <sha>: <subject>"), limit the
versions, or provide a backport of the prerequisite for the open-coded loop
in __neigh_update()?

> diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
> index 44730a5e89178..d1c66bd039d1d 100644
> --- a/net/sched/sch_teql.c
> +++ b/net/sched/sch_teql.c
> @@ -379,13 +379,13 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
>  			continue;
>  		}
>
> +		skb->dev = slave;
>  		switch (teql_resolve(skb, skb_res, slave, slave_txq, &hlen)) {

[Severity: Medium]
What happens when teql0 gets an skb whose dst->dev is another device X
that has header_ops? One way this happens is a tc mirred redirect or mirror
from X's clsact egress. tcf_mirred_to_dev() keeps the dst for egress to
egress, and only drops it for want_ingress && !at_ingress.

The skb is parked like this:

teql_master_xmit()
  skb->dev = slave;
  teql_resolve()
    __teql_resolve()                  /* dst->dev != dev branch */
      neigh_event_send(n, skb_res)    /* parks on the slave's neighbour */

When the slave's neighbour resolves:

neigh_update_process_arp_queue()
  n1 = neighbour looked up from the dst   /* X's neighbour */
  if (!n1->dev->header_ops)
      skb->dev = n1->dev;                 /* not taken, X has header_ops */
  n1->output(n1, skb)
    neigh_resolve_output() / neigh_connected_output()
      dev_hard_header(skb, X, ...)        /* X's MAC and lladdr */
      dev_queue_xmit(skb)                 /* sends on skb->dev == slave */

Does the frame then leave the slave carrying X's link header?

Before this patch skb->dev was still teql0 at that point. dev_queue_xmit()
went back through teql_master_xmit(), which pulled to the network header
and built the slave's own header.

This looks like the mirror-parking scenario that "net/sched: sch_teql:
unshare the header before writing and fix retry strip" uses as its
reproducer. Is that queued frame now sent with the wrong addresses at the
end of the series?

[Severity: High]
Can the same path still lead to a use-after-free, now of the slave instead
of the master?

Continuing from the reinjection above, X's neighbour may not be valid at
that moment. It could be NONE, INCOMPLETE or FAILED, for example after ip
neigh flush dev X, a carrier-down flush, or gc:

neigh_resolve_output()
  neigh_event_send(neigh, skb)    /* queued on X's arp_queue,
                                     skb->dev == slave */

skb->dev holds no device reference. If the slave is then deleted with ip
link del:

neigh_ifdown(slave)
  neigh_flush_dev()               /* walks only the slave's own neighbours */

The skb on X's arp_queue survives this, and the slave's net_device is
freed. When X's neighbour then fails:

neigh_invalidate()
  arp_error_report() / ndisc_error_report()
    dst_link_failure()
      __icmp_send() / icmp6_send()   /* reads skb->dev, the freed slave */

That gives the same KASAN signature as the one in the commit message. If
X's neighbour resolves instead, dev_queue_xmit() would run on the freed
slave.

Before this patch the skb on X's queue named teql0, which only module
unload can free.

The commit message says the parked skb "names the device whose neighbour
owns it". Does that still hold once the skb moves to a different
neighbour's queue? If not, the trigger seems to change from
CAP_SYS_MODULE plus rmmod to an ordinary link deletion.

>  		case 0:
>  			if (__netif_tx_trylock(slave_txq)) {
>  				unsigned int length = qdisc_pkt_len(skb);
>  				int rc = NETDEV_TX_BUSY;
>
> -				skb->dev = slave;
>  				if (!netif_xmit_frozen_or_stopped(slave_txq))
>  					rc = netdev_start_xmit(skb, slave, slave_txq, false);
>  				__netif_tx_unlock(slave_txq);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-6HS9.v6.r0.20261119070330%40mojatatu.com

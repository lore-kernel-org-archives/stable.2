Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795084722;
	b=2PspMUv1HT+ed8/sipJntLi1yX8GIGCNat0DzDb13RhOok495UvgtiWQ0+MmiUb+mCyt
	 Ogf7y1wnSedXH8D7ygETBAiB5RCZblaVuAjCucnOlOk8aAIFOJiVYEibk/85M9Ak3mOSX
	 Mk1L+LUF5rOf3du2mVjSlo8Za36htDL1Onr9AmV+M4C65A3juukP6FQcUc8k1NKqvdUhg
	 O7Ibktc4ojHgawThACoeklLyDiWgoAdi7BE/aE0DqCMRd65O7ZuiqOp1+Ysxv66YIu5sO
	 IwrEx24GrPEiX47kP9oQHBcHOFqT60UZIfwFH7PlEEoIzjP8joqKNUC6nGe1XObQpYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795084722;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=nzKHjSzRWrH9V9MmPTb7bDSHDOandNdhRmo9KqnTcUs=;
	b=mxOU5/3zoBMYUoQ0ljsrAJWDdinuRRGLQpy7swSwL+F03bSDk0VB02qsJdBWSQLlYfUg
	 Ucs+NC3xxe6oAjptJJWfwRyCdthILQ9SDqLGYxOdU6eBoOuZVGGC5uy1X+uUtLOCbJ2aw
	 1Ncfxl5glVh7S5OM6X2iXBPHoTTKjhQXfDKWo6RbdVLxP5QZs6PLLw7tsOzSdnf/K5amM
	 6Q167u9qAlZwcFEje2RnihUA5EaN+ynS2qrNeeqvTWqROs3zWM8Yr3Ny5j6kBqnQn0jV6
	 TtW5Bz/Q2QuI7HhX5/KBQCBgZAGqJDwgu04NNO/X/lfzKzTQ2WBewDjprkIK5cPXrtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QeRlA3cD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A638606A32C;
	Thu, 19 Nov 2026 10:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QeRlA3cD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 254121F000C7;
	Thu, 19 Nov 2026 10:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795084721;
	bh=nzKHjSzRWrH9V9MmPTb7bDSHDOandNdhRmo9KqnTcUs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QeRlA3cDT8Pc2gM234B5g/bsU5q2HTlE5qpGMe4ogmLU5pEsWz1It9/KdbayqcdP5
	 5wnU4zvVXGC77yZq7d87qiWZ6sjcDBYl9YDrfEDaSeGXOfiTTyWKZfAKr3GB62LX+c
	 AjPmICswFKeQ9PzKOisi56PXNs9Oz7QYuzuYWTzaWguIYWNfrqWZPEAalAnzgG+8z4
	 hPgj+im4OCNPIrYC6yn3Aw3TqGfiAiANjkIZ2vvZYBItz5UIBaLytUDBAnRtv345gB
	 KlRwkR0nySMc0WdEw4qri0Y5pT1rhgAtBBrItrS0qZcerENyaaiv1BHML47wtGU/wc
	 MupC3vFHdqVgw==
Subject: Re: [PATCH net v5 3/3] net/sched: sch_teql: keep skb->dev consistent
 on the arp-queue path
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, victor@mojatatu.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, stable@vger.kernel.org, sashiko-bot@kernel.org
Date: Thu, 19 Nov 2026 10:38:40 +0000
Message-ID: <179508472073.3136.1625322377662676881@kernel.org>
In-Reply-To: <QDISC-6HS9.v5.r0.20261116052927-3@mojatatu.com>
References: <QDISC-6HS9.v5.r0.20261116052927-3@mojatatu.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch carries `Cc: stable@vger.kernel.org` and only works
  if a net/core/neighbour.c fix is applied first, but the commit message…
- [Medium] The ICMP error for a failed neighbour resolution is now routed
  in the teql slave's L3 context instead of the master's.

--

net/sched: sch_teql: keep skb->dev consistent on the arp-queue path

This patch moves the skb->dev = slave assignment in teql_master_xmit() so
that it happens before teql_resolve(). An skb parked on the slave's
arp_queue then names the slave instead of the teql master. This avoids a
use-after-free when sch_teql is unloaded and the master is freed while the
skb is still queued.

Link: https://lore.kernel.org/netdev/20260824115928.4099988-1-victor@mojatatu.com/
Link: https://lore.kernel.org/netdev/20261026160747.283702-1-horms@kernel.org/
Link: https://lore.kernel.org/netdev/20261031165925.780930-1-horms@kernel.org/
Link: https://lore.kernel.org/netdev/179363700308.3131.11778179538290251434@kernel.org/
Link: https://lore.kernel.org/netdev/20261110101908.2e64e8e9@kernel.org/

> A parked skb is reinjected by neigh_update_process_arp_queue(), and a
> device that transmits straight on skb->dev has to be handed its skb back
> there. That is a change to net/core/neighbour.c, posted as its own fix,
> and it has to be applied before this one: without it the parked packet
> leaves the slave directly, with no link header, because teql_master_xmit()
> has already pulled it.

[ ... ]

> Cc: stable@vger.kernel.org

[Severity: Medium]
This patch carries Cc: stable, so could the prerequisite be named
explicitly? The text only says the neighbour.c change is "posted as its
own fix". It gives no commit id, subject or Link, and the stable tag has no
"# depends on" note.

The prerequisite looks like "net: neighbour: reinject a parked skb through
a headerless output device". It adds this to
neigh_update_process_arp_queue():

	/* headerless output transmits on skb->dev, not n1->dev */
	if (!n1->dev->header_ops)
		skb->dev = n1->dev;
	READ_ONCE(n1->output)(n1, skb);

neigh_update_process_arp_queue() was only split out of __neigh_update() by
commit 705ef89ac98648 ("net: core: neighbour: Extract ARP queue processing
to a helper function"). So the neighbour fix will not apply cleanly to
older stable trees.

This sch_teql hunk is a one-line move. Given the earlier sch_teql patch
that adds the &hlen argument, it would apply to those trees on its own.

If this patch reaches a stable tree without the neighbour fix, would an skb
parked on the slave's arp_queue go out with no link header?

When the neighbour resolves, neigh_update_process_arp_queue() looks up n1
again from the dst and gets the teql master's neighbour. The master has no
header_ops, so n1->output is neigh_direct_output(). That transmits on
skb->dev, which is now the slave:

neigh_update_process_arp_queue()
  n1->output() == neigh_direct_output()
    dev_queue_xmit(skb)   /* skb->dev == slave, header already pulled */

Would something like "Cc: stable@vger.kernel.org # depends on <commit>"
help keep the two patches together?

> diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
> index 626dc001ec231..e60d8f3b127de 100644
> --- a/net/sched/sch_teql.c
> +++ b/net/sched/sch_teql.c
> @@ -374,13 +374,13 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
>  			continue;
>  		}
>  
> +		skb->dev = slave;
>  		switch (teql_resolve(skb, skb_res, slave, slave_txq, &hlen)) {

[Severity: Medium]
skb->dev is now set to the slave before teql_resolve(). So when
__teql_resolve()->neigh_event_send() parks the skb, skb->dev is the slave
while skb_dst(skb)->dev is still the master.

Does this change the L3 context used to route the ICMP error when
resolution fails?

neigh_invalidate()
  arp_error_report() / ndisc_error_report()
    dst_link_failure()

For IPv4, the path is
ipv4_link_failure()->ipv4_send_dest_unreach()->__icmp_send()->icmp_route_lookup().
icmp_route_lookup() calls icmp_get_route_lookup_dev(), which prefers
skb->dev:

	route_lookup_dev = icmp_get_route_lookup_dev(skb_in);
	fl4->flowi4_oif = l3mdev_master_ifindex(route_lookup_dev);

So the oif and the inet_addr_type_dev_table() checks now come from the
slave rather than the master.

For IPv6, icmp6_send() takes iif from skb->dev:

	if (__ipv6_addr_needs_scope_id(addr_type)) {
		iif = icmp6_iif(skb);
	} else {
		...
		iif = l3mdev_master_ifindex(skb->dev);
	}

icmp6_dev() only falls back to the dst device for loopback or l3 master
devices, so the slave is used as is.

A teql master can be enslaved to a VRF, since vrf_add_slave() only rejects
l3 masters, existing l3 slaves and loopback. The slave is normally not in
the VRF.

In that setup, the host-unreachable error would now be looked up with
oif 0 in the main tables, not in the VRF table that holds the master's
address. Could it then fail routing, or follow a main-table default route
off the box?

The same seems to apply to an IPv6 link-local source on the master. There
the strict oif=slave lookup would not match the master's local route.

Without a VRF and with global addresses, l3mdev_master_ifindex() is 0 for
both devices, so nothing changes in that case.

The commit message says the error path "names the slave on that path too".
It does not mention this change in routing context. Is it intended?

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
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-6HS9.v5.r0.20261116052927%40mojatatu.com

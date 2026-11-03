Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793704760;
	b=bEXCT2c3qHAdmUorNtD+Jv3owrZh07QNvHPexLKum4pNCTcHc4HNUI4P76KIx5n1xLok
	 Cc+uFoZzP15lgqJF3G6SUab+e4VAiNTPnUtDmPnrqF1EfFrxQEGM3tk9n4KwXvyJ0fgJs
	 ArUPqybby8MyUEI0lCs1nbjZvpdcZ3zwonZUATTFcSYV0YvvfxD5BeQZk1Kf9u77l5MtN
	 j2BdtVSurnjmuvFiqoSAvDiXytioMx+8Ow7jKfuHa5PC4ry+PAWgue5pjI50INuEwpuWC
	 E79vMZi+Q23VBtDPE1XuaWltZFoUc47+3oOJvfIlVXNN0dwoGmIqWKH2Ek2AvINz/kQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704760;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=IfDZhl3UbfIFKk2Sle86bKRVHVImjPhRE/0Wh4McLpQ=;
	b=ltV7K5/d20e5wclN9imXxq871wxpQOMuZdWp3TJw2yfzGDXXsLs7w0yQ9LrJun44ePll
	 plf5T2w2j5XoaNU4EdfKXB7BMW+LXeur5M104B0QruKN8VGMFguAjxxauE5GOdX2wx8aZ
	 9IZqZW2QrOOIDSmnlP6PAYQLpHv5YuTVYrPdOSJDnBoPKPVt1ZpdHtj47Imwxyl9LClkS
	 6/uyujtzQfIk9LOK6gXGMBtb0cC9/fCrk0fmvsSBZfjuloKMU/pUgaX3xwR3zcwiOn43L
	 bm+RWAU4nJCLyF7JcuQA2vzTEFg/WVIqT99OK9S3EB3tr75gl7DyIMRAv9fgTIaAJeA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=LTNbI73Q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307FA606BF96
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 11:19:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 307FA606BF96
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=LTNbI73Q
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cd62c570b5dso2686784a12.2
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 03:19:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793704759; cv=none;
        d=google.com; s=arc-20260327;
        b=Uj81e+hudkbCxXPXWmv3fj0NzNL1OZSw5h/desGC2JtIa3VjVXl3hz2FNG0N7NxJ9W
         B1iWgb5k7/WeqPbakkxEAlVdyrXfRsWbVhpclE4UOKP8VWVeay99tJyTPNuNudEFKK1K
         5AWsFjhR64usnf7BND38Rru4m0Rn+p4qlrNfYenNvrp2arGchbeflTBeAz4vv3sp4sT9
         hlyQa1Zs8YwrfUBMV44v0YN6oFV5ItHK48SgnRDPGIbhcKW0bDcRBr93c0dIszK4e8zm
         pqFGj94qFjQzbzA1DzcZZiImQG75p346sshRoNm747vrk21V9ymKS5f1cjLyEvBQKlSo
         0Irg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IfDZhl3UbfIFKk2Sle86bKRVHVImjPhRE/0Wh4McLpQ=;
        fh=TWbkB0T4t/cF2KdlEc6GNq88JskBVckKgQndppjufkw=;
        b=Qihqd1AYQ3oKhgZ2a8WF2hd+KJAPXeSRPwQLbbW/3Z5WQCWubnluqsklQiWrhn97K+
         hYGT+0NUypkwTIItqjnm9dAuBp6VOFds6keHBydmHO2UL7mo55NBt4RVBEe4O7QDnBah
         3dDV8qaiGYYiBw6kxOUDYNuFcn0d+Pp41hjalK9pEzHRmlh0N0wa3nGbE1BBiVrWm+dt
         22kljiyk2rhMMRRKbA6XJ3eSRaxNMkB7chCXmX856OXNOsLWOE0ZTp7uDxMwBPC4vKaW
         8uzKHxRoLnwG9f4kC6e7p+zkgxFamkoVCSIeQz172/Ml1ROQ2mij3VYZUCKKGIFetkIU
         j3lQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793704759; x=1794309559; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IfDZhl3UbfIFKk2Sle86bKRVHVImjPhRE/0Wh4McLpQ=;
        b=LTNbI73QGD6LQwvFVPfZVbd6fHqRof+Tlocrh05M/ELJqWhNUvIqEOA5OZ0ZpIDS5g
         HYME66Xk50Io7vQTsFxd95I/0PcKHUovI8KO8Tb2TEuQIncGV6JGLiFiYyT+dMxKizHT
         INdamY7bOicT6MsudeSBvqm+iDD7MsXex0G88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793704759; x=1794309559;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IfDZhl3UbfIFKk2Sle86bKRVHVImjPhRE/0Wh4McLpQ=;
        b=yx+uipBlaR/dPnl5Xl9T7itl8eNay9q0cPuvL5aUaZEOigDk7VVmrWQSOoknBF+hVT
         X/i9rC4LredEcQXsTbQ4HyAEe/xy0SqKLCwtdkpKaE0a86lrIrPEfZoiPNQp+73rjBH1
         oXW28/Rpfi0qgnvw57v1+nqDc945GvisNzfL0CtN7veMegeMvBkgZTCIhTr/AjUc3afR
         Kay4hQ14niyof01pQC02EKmOlH5pUIKep6EiMWsSEEFFsPviabkMj77gyWfm7qANaR6b
         sLpPtBldyccmeaHcBX7Y+wZtXl89SYsWJgPD1ynudF2WY+zPF57caunYsZwM+MGoWNqD
         3+9g==
X-Forwarded-Encrypted: i=1; AKwUvBwUVFsB936eCIp0UgTltjnkekCqARfKxgx93S4oisQbAcAlBhevKK/3ph4LLQMIBzfj5fqE78g=@vger.kernel.org
X-Gm-Message-State: APuU4Z/YrjjOFk7uX0cZMNHKwB24nmQFfmCsH+avmcdldCaDNs48zgqB
	X3sb1l1HT/f/iSDuzpgkDCpCFuGlPoPGd+SfhAcLgnoQJ2MIUY7/CibWJimX4kbcyleNCwo2a4n
	tLo6LGesNw9bpNWOhcZmoTqROaahhoUou0qZ5codJi8MF/higyeDukQ==
X-Gm-Gg: AYBFou2imk4hNjfrky2msJAWZkewhbJSMuwOxMN3f5DD/xDA5U+jk3hQ1L+ySXIQBlf
	glE8pJ0YdG5hjlBweHtBG1DH+6nW1AP2usemWvJ91QFOuYyUnegoV/i4aI3Azan9i8+f9+/r0D1
	xmAwTS6FsUA7PDv23wysHQVvaSaTsFeUKoKASAQBupPHgjZH/UUETBHCIhPtYcU4C8lQW3a1mys
	pykLIpgGBXvkPeZRPkCjWrhQvHkGx0TxA/8sp9avdubiQt3jLUHe5rbpA/xwltoKnWcU4hFK/Ht
	Hh7/dF3ZHYD3qMGRhIVi0ZyccSEMQdq04v6OzUX5CbI2+kqWUJXsNoSTmT40HQznQ7gXXqm6a53
	bi6D2NXtxEYVF+KgREpYXCXs/vVGvHcw4AH7yJ5KQXb648Ysou84nLRA0vIL6YBQGAHcQaZZk5m
	j5/kKy/szflVnGFz8=
X-Received: by 2002:a05:6a21:9786:b0:3e2:490d:5111 with SMTP id
 adf61e73a8af0-3e928788392mr10583033637.8.1793704759348; Tue, 03 Nov 2026
 03:19:19 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <QDISC-6HS9.v2.r0.20261101105945-2@mojatatu.com> <179363700308.3131.11778179538290251434@kernel.org>
In-Reply-To: <179363700308.3131.11778179538290251434@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 3 Nov 2026 06:19:07 -0500
X-Gm-Features: AclHuK84nGStbIWv-V9gdcDzkQqSl-oPJnTu29B2h8JycRFp0vst_YmN3cnAoaU
Message-ID: <CAM0EoMnSmfEAsY=VUfQ+Nn6PRXhsDfYtGuMHKxpP_s4hxN+zug@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] net/sched: sch_teql: keep skb->dev consistent
 on the arp-queue path
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, victor@mojatatu.com, jiri@resnulli.us, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, stable@vger.kernel.org, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 11:30=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 (1) =C2=B7 Medium: 2 =C2=B7 Low: 1
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] The new gate in neigh_update_process_arp_queue()
>   (net/core/neighbour.c:1343-1344), `if (!n1->dev->header_ops) skb->dev=
=E2=80=A6

This is by design. Covers every headerless neigh_direct_output user.
Nothing to fix.

> - [Medium] teql_master_xmit() now sets skb->dev =3D slave before
>   teql_resolve() (sch_teql.c:371).

No (that renames the master again. Nothing to fix.

> - [Low] The commit message's reproducer cannot show the use-after-free
>   the patch says it fixes.

Sigh. I will send a v3 to fix the messaging. Dammit, dont whine about
something else after you rat bastard.
pw-bot:cr

> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but
>   teql_qdisc_init() (net/sched/sch_teql.c:194-253) never checks that the=
=E2=80=A6

Separate thread. see:
 https://lore.kernel.org/netdev/SER-NSBD.v2.r0.20261101171325-3@mojatatu.co=
m/

cheers,
jamal
> --
>
> net/sched: sch_teql: keep skb->dev consistent on the arp-queue path
>
> This patch moves skb->dev =3D slave ahead of teql_resolve(). An skb parke=
d
> on the slave's arp_queue then names the slave instead of the teql master.
> It also restores skb->dev =3D n1->dev in neigh_update_process_arp_queue()
> when the top-level neighbour's device has no header_ops, so the skb goes
> back through teql_master_xmit().
>
> Link: https://lore.kernel.org/netdev/20260824115928.4099988-1-victor@moja=
tatu.com/
> Link: https://lore.kernel.org/netdev/20261026160747.283702-1-horms@kernel=
.org/
> Link: https://lore.kernel.org/netdev/20261031165925.780930-1-horms@kernel=
.org/
>
> > Conditions to recreate the bug:
> > CONFIG_NET_SCH_TEQL=3Dy, CONFIG_VETH=3Dy, run as root. Create a veth pa=
ir,
> > make one end a teql slave, give the master an address and a route, flus=
h
> > the slave's neighbour entry and send one packet:
>
> [ ... ]
>
> > On the unfixed tree the skb is parked on v0's arp_queue while skb->dev
> > still names teql0, so the reinjection can reach a master that teql_exit=
()
> > has freed.
>
> [Severity: Low]
> Can this recipe reach the use-after-free it describes?
>
> With CONFIG_NET_SCH_TEQL=3Dy, teql_exit() is __exit and never runs, so no
> master is ever freed:
>
> net/sched/sch_teql.c:teql_exit() {
>     ...
>                 unregister_qdisc(&master->qops);
>                 unregister_netdev(master->dev);
>                 free_netdev(master->dev);
>     ...
> }
>
> teql_master_setup() installs no rtnl_link_ops, so "ip link del teql0"
> can't free the master either.
>
> Building sch_teql as a module doesn't change this. teql_master_setup()
> sets ops->owner =3D THIS_MODULE, and qdisc_lookup_ops() takes a module
> reference through bpf_try_module_get() for each slave qdisc. rmmod
> therefore fails while the slave qdisc on v0 exists.
>
> To reach a freed master you seem to need sch_teql as a module, then
> "tc qdisc del dev v0 root", then "rmmod sch_teql". All of this has to
> happen while the skb is still parked on v0's arp_queue. None of these
> steps are in the recipe. Could the recipe be updated to match?
>
> Also, the message only names the reinjection path. Commit dc4b95b8fee9
> showed this KASAN-confirmed path for a stale skb->dev:
>
> neigh_invalidate()->arp_error_report()->ipv4_link_failure()->__icmp_send(=
)
>
> Here __icmp_send() reads skb_in->dev. This patch covers that path too,
> because the parked skb now names the slave. Would it be worth saying so
> in the message?
>
> > diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> > index d6e9c7c59a892..541cf699abae4 100644
> > --- a/net/core/neighbour.c
> > +++ b/net/core/neighbour.c
> > @@ -1339,6 +1339,9 @@ static void neigh_update_process_arp_queue(struct=
 neighbour *neigh)
> >                       if (n2)
> >                               n1 =3D n2;
> >               }
> > +             /* headerless outputs (teql, shaper) transmit on skb->dev=
 */
> > +             if (!n1->dev->header_ops)
> > +                     skb->dev =3D n1->dev;
> >               READ_ONCE(n1->output)(n1, skb);
>
> [Severity: Medium]
> Is this check narrow enough to match only teql?
>
> n1 comes from dst_neigh_lookup_skb() on the skb's retained dst. It does
> not come from neigh, the neighbour the skb was parked on. Nothing checks
> that neigh->dev is a teql slave of n1->dev, so any headerless route
> device matches.
>
> Two producers park the skb on another device Y's neighbour while keeping
> the original route's dst:
>
> - nft "fwd ... neigh", via nft_fwd_neigh_eval(). nft_fwd_validate()
>   allows it at NF_NETDEV_EGRESS.
> - bpf_redirect_neigh() with an explicit nexthop.
>   __bpf_redirect_neigh_v4/v6 only replace the dst when nh =3D=3D NULL.
>
> Suppose such a forward runs at the egress hook of a headerless device X
> and the neighbour on Y is unresolved:
>
> __neigh_event_send()
>   skb_dst_force(skb)                    /* dst->dev is still X */
>   queue on Y's arp_queue
>
> neigh_update_process_arp_queue()
>   n1 =3D dst_neigh_lookup_skb(dst, skb)   /* X's neighbour */
>   skb->dev =3D n1->dev                    /* X */
>   neigh_direct_output()->dev_queue_xmit(X)
>
> nf_skip_egress was reset after sch_handle_egress(), so nf_hook_egress()
> runs X's egress chain a second time.
>
> The forward then runs twice. nft_fwd_neigh_eval() decrements TTL again,
> so a TTL=3D2 packet that should leave Y with TTL 1 is dropped here on the
> second pass:
>
>                 if (iph->ttl <=3D 1) {
>                         verdict =3D NF_DROP;
>                         goto out;
>                 }
>
> Quota, limit and counter state are charged twice. The second pass may
> also decide differently, for example with numgen, an expired set element
> or a ruleset change. The packet then leaves through X, the route the
> forward was meant to bypass.
>
> Devices that match as X include:
>
> - point-to-point ipgre with a unicast remote, and collect_md gre
>   (ipgre_tunnel_init() leaves header_ops NULL)
> - ppp, eql and teql
>
> Tunnels using ip_tunnel_header_ops (wireguard, tun, ipip, sit, xfrmi and
> so on) don't match. Before this patch these skbs left Y without a link
> header. That was broken, but they never re-entered X.
>
> The commit message acknowledges this and leaves the producer fix to a
> separate change. This net/core change is going to stable under a
> sch_teql subject. Could the producer fix be included, or the gate
> narrowed, for example by requiring neigh->dev to be a teql slave of
> n1->dev?
>
> > diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
> > index ed8faa848f184..4eac1f9c8ddf6 100644
> > --- a/net/sched/sch_teql.c
> > +++ b/net/sched/sch_teql.c
> > @@ -368,13 +368,13 @@ static netdev_tx_t teql_master_xmit(struct sk_buf=
f *skb, struct net_device *dev)
> >                       continue;
> >               }
> >
> > +             skb->dev =3D slave;
> >               switch (teql_resolve(skb, skb_res, slave, slave_txq, &hle=
n)) {
>
> [Severity: Medium]
> What happens to an skb parked here if the neighbour then fails?
>
> In case 1 of teql_resolve(), teql_master_xmit() returns before the
> skb->dev =3D dev restore at the bottom of the loop. The skb therefore sit=
s
> on the slave's arp_queue with skb->dev =3D slave.
>
> Only neigh_update_process_arp_queue() was changed to put the master back.
> The other consumer of the queue passes the skb on unchanged:
>
> net/core/neighbour.c:neigh_invalidate() {
>     ...
>         while (neigh->nud_state =3D=3D NUD_FAILED &&
>                (skb =3D __skb_dequeue(&neigh->arp_queue)) !=3D NULL) {
>                 write_unlock(&neigh->lock);
>                 neigh->ops->error_report(neigh, skb);
>     ...
> }
>
> For IPv6 the call chain is:
>
> ndisc_error_report()->dst_link_failure()->ip6_link_failure()->
> icmpv6_send()->icmp6_send()
>
> icmp6_send() takes its context from skb->dev:
>
>         net =3D dev_net_rcu(skb->dev);
>         ...
>                 iif =3D l3mdev_master_ifindex(skb->dev);
>
> It also uses ipv6_chk_addr(net, &hdr->daddr, skb->dev, 0), and
> icmp6_iif(skb) for link-local sources. That iif becomes flowi6_oif for
> the route lookup of the error.
>
> These values used to come from the teql master. Now they come from the
> slave, which changes the result in these setups:
>
> - teql0 in a VRF with the slave outside it: the ICMPv6 Destination
>   Unreachable is routed in the main table instead of the VRF table.
> - A link-local source on teql0: the oif becomes the slave.
> - A slave in another netns: the error is built in that netns.
>
> Can the local sender's error be dropped or misrouted in these setups?
>
> Would restoring skb->dev on this path as well avoid this? One option is
> skb_dst(skb)->dev, which dst_dev_put() keeps valid.
>
> [Severity: High]
> This isn't a bug introduced by this patch, but should teql_qdisc_init()
> check that the slave and the master are in the same network namespace?
>
> The teql Qdisc_ops are on the global qdisc_base list, so
> qdisc_lookup_ops() finds "teql0" from any netns. rtnetlink_rcv_msg()
> only checks netlink_net_capable(skb, CAP_NET_ADMIN) against the caller's
> own netns. teql_qdisc_init() then checks only hard_header_len,
> m->dev =3D=3D dev and the root parent:
>
> net/sched/sch_teql.c:teql_qdisc_init() {
>     ...
>         if (dev->hard_header_len > m->dev->hard_header_len)
>                 return -EINVAL;
>
>         if (m->dev =3D=3D dev)
>                 return -ELOOP;
>     ...
>                 m->dev->mtu =3D dev->mtu;
>                 m->dev->flags =3D (m->dev->flags&~FMASK)|(dev->flags&FMAS=
K);
>     ...
> }
>
> As a result, root inside an unprivileged user+net namespace can run
> "tc qdisc add dev <own veth> root teql0". That enslaves its own device
> to the init_net master. If it is the first slave, it also overwrites the
> master's mtu and flags.
>
> teql_master_xmit() then round-robins init_net traffic routed through
> teql0 onto that device. __teql_resolve() creates the neighbour there, so
> the namespace can read or drop that traffic and controls neighbour
> resolution for parked skbs. This needs sch_teql loaded or built in by
> the host. There is no MODULE_ALIAS for autoloading.
>
> With this patch, parked skbs also carry skb->dev =3D slave. ICMPv6 errors
> from neighbour failure that quote the init_net packet are therefore
> built in that namespace, through dev_net_rcu(skb->dev) in icmp6_send().
>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/QDISC-6HS9.v2.r0.20261101105945%40mojatatu.com

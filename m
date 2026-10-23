Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792772906;
	b=baWKJbvCcrIP78GX03285APwEfhVWabdm4kh/dA/zBzx+WTtrC/nWK1ncKCnewJX/X5d
	 611mFClCLO+CHj1gXCFq0dKZoDN1JQ+ptavakw3+BuHAA7nRZ+iGY728W051ggvIKkYuF
	 r5x0dKnQru7CHmyrnkTsk2VfZWSEMPntADmvlCmxnlEtfaYhJF398pz5LWGHFpII48+oU
	 +xdociMK7dOM4U1Tfn39k85dmQw7VF6vk6BlIeHKKKJ772/LJ5X1i2FcMY33P7jLaZY2B
	 LO9mmZIJDr/RSULuqxeG+TxjXW9ni4ubPmzMZ5VJ8jfGH/D9VPw3715iI1dnGSA6Eew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792772906;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=Co97Y0p41uorR92GJeOhUDahiBIaQEoa0saPKr2noM8=;
	b=W/rVsNUWl2WhJpF1+qWC/vuM/nUin/itpeuUtgK7TMktEMoQq1KIj744nhgj/NeZTs+v
	 223dkV6/eKosGWrLaEJD9s2v/BzVzDsbGuO0hWbdwXV3yDUcBmVqkVmmXfgZDeolm1gu6
	 oEeqXHuoyDJCHodRq5toDIa1dsFOCz3cN/pjWc9t9GVqITr06sGMr25DhBIH1keVRTtKy
	 8ZsGtvXgTlKxVPu6dr+BF3xisVHwMguwKVgX55VcCEgurLkXiar+4knbh0Ssd9cKLmXHc
	 ST9QzkDoAAq2O6HS0cIvE2mp2vh/He4hP51Jd1dnEyPON6FAzGC43Bu208QuY29jjdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OojpiN35;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEB8606A324;
	Fri, 23 Oct 2026 16:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OojpiN35
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAEFC1F01825;
	Fri, 23 Oct 2026 16:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792772906;
	bh=Co97Y0p41uorR92GJeOhUDahiBIaQEoa0saPKr2noM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OojpiN35R5m9Yj0Ve6tqyjOGsScUD1AEIt+CecU0CVUjyrDZnLoNaOlJyH699BiWW
	 Y64Rxr1/hs+JXyrQHG/AuDtFDj1KoAU2VIRD9f/yPvDDkIg2w7Jfeq52ukwgNnzp69
	 VoZGtaIgbUcvWGoRWmG4rLj69/Z92fnq+bqU4IF2n55mBJRlaIUpVJwss/zVy4+92I
	 v+PGgM0xND6gzNNOSv8Fj3WEjL2nPzTech//bKrpdraaMlof0/YqWrYFyF0SAPp/rv
	 pQSb+RD6RLHpuH2nj9/9T9G04ywIiAjS6hQGaW+tofWloizuyQZBxjnqoYKbmEE8J2
	 eXFFL6TCS4+Yg==
Date: Fri, 23 Oct 2026 17:28:21 +0100
From: Simon Horman <horms@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: jhs@mojatatu.com, netdev@vger.kernel.org, owen@verialabs.com,
	jiri@resnulli.us, victor@mojatatu.com, davem@davemloft.net,
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	kaber@trash.net, stable@vger.kernel.org
Subject: Re: [PATCH net 2/2] net/sched: sch_teql: fix use-after-free on lower
 qdisc drop
Message-ID: <20261023162821.GN708417@horms.kernel.org>
References: <QDISC-Y0BY.v1.r0.20261015184107-2@mojatatu.com>
 <179248763469.3135.1739559328868319628@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179248763469.3135.1739559328868319628@kernel.org>

On Tue, Oct 20, 2026 at 09:13:54AM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] In teql_master_xmit() (net/sched/sch_teql.c), the patch
>   replaces `== NETDEV_TX_OK` with `dev_xmit_complete(rc)`.

Hi Jamal,

Maybe things have moved on for some reason.
But this concern does seem to warrant a response.

> 
> --
> 
> net/sched: sch_teql: fix use-after-free on lower qdisc drop
> 
> This patch changes the check on the slave's netdev_start_xmit() return
> value in teql_master_xmit(). It now uses dev_xmit_complete() instead of
> comparing against NETDEV_TX_OK, so a slave that consumes the skb and
> returns NET_XMIT_DROP is no longer treated as still owning it. This fixes
> a use-after-free when a VLAN slave's lower qdisc drops the packet.
> 
> > diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
> > index c7dcec25ef420..b3efd5c281988 100644
> > --- a/net/sched/sch_teql.c
> > +++ b/net/sched/sch_teql.c
> > @@ -350,8 +350,8 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
> >  
> >  				skb->dev = slave;
> >  				if (!netif_xmit_frozen_or_stopped(slave_txq) &&
> > -				    netdev_start_xmit(skb, slave, slave_txq, false) ==
> > -				    NETDEV_TX_OK) {
> > +				    dev_xmit_complete(netdev_start_xmit(skb, slave,
> > +									slave_txq, false))) {
> 
> [Severity: Medium]
> This closes the use-after-free. Does the same condition now also count
> dropped packets as successful transmits on teql0?
> 
> dev_xmit_complete() returns true for any rc < NET_XMIT_MASK. That covers
> NET_XMIT_DROP and negative errno values as well as NETDEV_TX_OK. All of
> these now take the success block in teql_master_xmit():
> 
>     netif_wake_queue(dev);
>     master->tx_packets++;
>     master->tx_bytes += length;
>     rcu_read_unlock();
>     return NETDEV_TX_OK;
> 
> They also advance master->slaves to the next slave.
> 
> teql_master_stats64() copies these counters directly into struct
> rtnl_link_stats64. There, tx_packets is defined as "Number of packets
> successfully transmitted".
> 
> With the reproducer from the commit message (a VLAN slave on a dummy
> device with a pfifo limit 0 root), every packet the lower qdisc drops
> would appear as a good transmit in ip -s link show teql0. tx_dropped and
> tx_errors would stay at zero.
> 
> The VLAN slave counts the same rc as a drop in vlan_dev_hard_start_xmit():
> 
>     if (likely(ret == NET_XMIT_SUCCESS || ret == NET_XMIT_CN)) {
>         ...
>         u64_stats_inc(&stats->tx_packets);
>         ...
>     } else {
>         this_cpu_inc(vlan->vlan_pcpu_stats->tx_dropped);
>     }
> 
> Could the rc be saved once? dev_xmit_complete(rc) would then decide only
> whether the skb is still owned, which keeps the use-after-free fix. In
> that case, tx_packets and tx_bytes would only grow for NETDEV_TX_OK and
> NET_XMIT_CN. The other consumed codes would go to tx_dropped (or
> tx_errors), without touching the skb.
> 
> The commit message describes this only as a use-after-free fix. Could it
> also mention that teql0's counters behave differently now?
> 
> >  					__netif_tx_unlock(slave_txq);
> >  					raw_spin_lock_irqsave(&master->slaves_lock, flags);
> >  					if (rcu_dereference_protected(master->slaves,
> 
> -- 
> Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-Y0BY.v1.r0.20261015184107%40mojatatu.com

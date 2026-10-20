Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792487636;
	b=FTjRmw7RaD+/asR4ksvZ906MV/40WkVI+KoTnscIL9C21Ex2XbuZkWUK9aWO3DtfONor
	 /pXd1vHNufGSdg2n1lxSVnV7DcByQKy4UfBpy+b8pke/2i4ztWaa+f+ze9MdiSsPXNH00
	 z/HlHBBgK9c2uEMngYViEYKzHbjVQnuSjtm+vwX5BCAkveJs5CgLJc6qrK1Om8925I86C
	 uIhlFIbukPuUnIaxRFw9HytMTpyYxbZk+SBoMe6YLkeG8JI25YiNNz11N+l9I+MR8AzMH
	 fuSr/Zh5vpAnppZpX7fpUZxy4Sy16UqGA7uIDVq0dtQlVM52bZZh+R5KvNtj2dgnItg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792487636;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=wR+QGy8NxY6UIZ6A7AByjSRgriA8JzRMJkxzuQ72kpw=;
	b=5ZCbqmFTmen/p1yt4U1fJT8+Jda+4XiGJe6ZZ6Vd+MHmPRB62fiB//fz/uvGZ0xUC4p1
	 TvOZTklIP1YzGjNNV0GZibecdHpAabqg3mpGIbwP6dDfEF7h+tTdzIOOc1mhSgB10sOa6
	 fQDh4EWS0nvfFcMdXiOSu5DhFNr15x/2wly1Y78JybsXYv/7FPuiQyqjxSQJ2qr86bKYP
	 AqPR6Mz3uAIdz2TW08xvALC/IQhzRlLxJnBcISpMoX6e6Ybpz1wb7BtAZna6QivkVpuy6
	 wULQ1iwB5WG31bg4G7oUAYfFI07jDJbj/ownKJg4/mielSBTCpQZqbSBkXsEkPS/a9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DBD7IJ7a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C62606A327;
	Tue, 20 Oct 2026 09:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DBD7IJ7a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D3C11F000C8;
	Tue, 20 Oct 2026 09:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792487635;
	bh=wR+QGy8NxY6UIZ6A7AByjSRgriA8JzRMJkxzuQ72kpw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DBD7IJ7ay2J6j6G21jybk6qhnd8O9ASCI6L4xBpY7PhKhXoMnyXsMqDeb99Nq9r1j
	 Xs4Mah97QlYS3YmGCPSymE3uu2gEDiWcskP+lJ1YGjDyo2dF9GRXrxIUNXya/xjE/a
	 YJxIpxkhX82iJgePFNSMH1ABO4IznPN8NevpnEgfPAUNvMd1KJdm7YP3lQ3gOdqYG+
	 7Wb3Y7pGmsyp7ZxwtMt9gHRDhWhnIWR3CSAfQTjlqq7m7j8yss6Atshd4gg5YXU3ST
	 D3yoAykhUl7D4b+GbQyd+YRVHGHXFQiWI8huhCsnz53P8dOpMy4bFR+MOK7XY73APY
	 +Bbm0rnateuSw==
Subject: Re: [PATCH net 2/2] net/sched: sch_teql: fix use-after-free on lower
 qdisc drop
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, owen@verialabs.com, jiri@resnulli.us,
 victor@mojatatu.com, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kaber@trash.net,
 stable@vger.kernel.org
Date: Tue, 20 Oct 2026 09:13:54 +0000
Message-ID: <179248763469.3135.1739559328868319628@kernel.org>
In-Reply-To: <QDISC-Y0BY.v1.r0.20261015184107-2@mojatatu.com>
References: <QDISC-Y0BY.v1.r0.20261015184107-2@mojatatu.com>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In teql_master_xmit() (net/sched/sch_teql.c), the patch
  replaces `== NETDEV_TX_OK` with `dev_xmit_complete(rc)`.

--

net/sched: sch_teql: fix use-after-free on lower qdisc drop

This patch changes the check on the slave's netdev_start_xmit() return
value in teql_master_xmit(). It now uses dev_xmit_complete() instead of
comparing against NETDEV_TX_OK, so a slave that consumes the skb and
returns NET_XMIT_DROP is no longer treated as still owning it. This fixes
a use-after-free when a VLAN slave's lower qdisc drops the packet.

> diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
> index c7dcec25ef420..b3efd5c281988 100644
> --- a/net/sched/sch_teql.c
> +++ b/net/sched/sch_teql.c
> @@ -350,8 +350,8 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
>  
>  				skb->dev = slave;
>  				if (!netif_xmit_frozen_or_stopped(slave_txq) &&
> -				    netdev_start_xmit(skb, slave, slave_txq, false) ==
> -				    NETDEV_TX_OK) {
> +				    dev_xmit_complete(netdev_start_xmit(skb, slave,
> +									slave_txq, false))) {

[Severity: Medium]
This closes the use-after-free. Does the same condition now also count
dropped packets as successful transmits on teql0?

dev_xmit_complete() returns true for any rc < NET_XMIT_MASK. That covers
NET_XMIT_DROP and negative errno values as well as NETDEV_TX_OK. All of
these now take the success block in teql_master_xmit():

    netif_wake_queue(dev);
    master->tx_packets++;
    master->tx_bytes += length;
    rcu_read_unlock();
    return NETDEV_TX_OK;

They also advance master->slaves to the next slave.

teql_master_stats64() copies these counters directly into struct
rtnl_link_stats64. There, tx_packets is defined as "Number of packets
successfully transmitted".

With the reproducer from the commit message (a VLAN slave on a dummy
device with a pfifo limit 0 root), every packet the lower qdisc drops
would appear as a good transmit in ip -s link show teql0. tx_dropped and
tx_errors would stay at zero.

The VLAN slave counts the same rc as a drop in vlan_dev_hard_start_xmit():

    if (likely(ret == NET_XMIT_SUCCESS || ret == NET_XMIT_CN)) {
        ...
        u64_stats_inc(&stats->tx_packets);
        ...
    } else {
        this_cpu_inc(vlan->vlan_pcpu_stats->tx_dropped);
    }

Could the rc be saved once? dev_xmit_complete(rc) would then decide only
whether the skb is still owned, which keeps the use-after-free fix. In
that case, tx_packets and tx_bytes would only grow for NETDEV_TX_OK and
NET_XMIT_CN. The other consumed codes would go to tx_dropped (or
tx_errors), without touching the skb.

The commit message describes this only as a use-after-free fix. Could it
also mention that teql0's counters behave differently now?

>  					__netif_tx_unlock(slave_txq);
>  					raw_spin_lock_irqsave(&master->slaves_lock, flags);
>  					if (rcu_dereference_protected(master->slaves,

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-Y0BY.v1.r0.20261015184107%40mojatatu.com

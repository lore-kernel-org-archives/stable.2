Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793125766;
	b=Gd8ToRm0h48HvvR5e+lkgFV7oLtG2/7I4vVihsiaHivQVva4zXcHIBL8iMIkV69InsYW
	 YC2fMCkbNjSsHchoOoE9pu5+btVHt4Ximou6Kfu6vpABhom6vN3lMrnKtS+fMemqOJVjs
	 Dtylx+I3+9ZIowkP/7TOIltSfvdKNDcPj3LkdL11BM3ON2vfdeu6Jj9Q5zno9YFJCqnLO
	 o+TaalgS/gPEaSQpjCp+5ODQIoIboB6vxSUkaZg+2Y0KjfMAGtrqs7oyHuBGMl2cW2qpO
	 en/7R0fyAYeX/jK7v9XWH6gBIiHTquOcBLFC3FogrWuF8OpOPhd3C4/L0R3I6VeQhPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793125766;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=3PTtTHc5HD5DW7DQJPcE16Csk4d4BtXbVYfclUnPyE4=;
	b=l3K6xBWMMzNzBNDMRRme7ZCzAhbTt6oIIH2lVaFftLAm+D/OhN9h37jqZLarDwWZfFfP
	 Sm1DvZzXtqpjiIqYUeVJv3yggf35zlfj+vui22rJOpyXgvsEZvNubV0Exfy51M9Bn+Hhc
	 xu98DbtdJU4jz+zzWsRq1s672riW4EOVvevigsbebY1JDACRKr45cb8dSKvABN+9Zsdd6
	 sLWvaIyrsU7Q4lvgoEezL5S8J/HH3gStc25ldoO5XOKfqpNDzqgBo9VIQoV7TDWe6/WA2
	 gmK4P4DS1RKCUqs89A+TcZwe2M0ygbsBHasNze32Obm2tekmzO5lvCi3SM0ZbkdNzeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dSvPOfsx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14927606A31E;
	Tue, 27 Oct 2026 18:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dSvPOfsx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64C891F031E0;
	Tue, 27 Oct 2026 18:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793125765;
	bh=3PTtTHc5HD5DW7DQJPcE16Csk4d4BtXbVYfclUnPyE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dSvPOfsxwbUYPXgfaL6y1eduyKpzlq4vYz23awiakrSk6gZvUZzfrRbthqCaxW7E3
	 j06b5g1ADWs84KEYnBFie+SAe04AAxkk5TqrmOuwI8tfAODtEGfufnFPQaIS/TOLfl
	 /wtIM4twpEPfDoRh9t04+r+ckrzdeMCXcWzo35SarCvk6UAW2X7OZJwMsWfs5LHqww
	 O01qv0AY5uO7wSYeCBFzVFzT3T7zQ0ugSno0qb8IwYvdBd+U+etCnjMzMFyTgfA7CN
	 +IMehYBdG/f6VLU4w6x9IZJqsrlxZONyNi+yifWoSQdr+4xHR2iuXup6p74dduRvIW
	 FV59KdlrLMGzA==
From: Simon Horman <horms@kernel.org>
To: jhs@mojatatu.com
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	owen@verialabs.com,
	jiri@resnulli.us,
	victor@mojatatu.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	sashiko-bot@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v2 2/2] net/sched: sch_teql: fix use-after-free on lower qdisc drop
Date: Tue, 27 Oct 2026 18:26:08 +0000
Message-ID: <20261027182608.448075-1-horms@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <QDISC-Y0BY.v2.r0.20261024060625-2@mojatatu.com>
References: <QDISC-Y0BY.v2.r0.20261024060625-2@mojatatu.com>
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
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-Y0BY.v2.r0.20261024060625-1@mojatatu.com?part=2
---
net/sched: sch_teql: fix use-after-free on lower qdisc drop

This patch changes teql_master_xmit() to use dev_xmit_complete() to decide
whether a slave consumed the skb. Before, a slave such as VLAN could free
the skb and return NET_XMIT_DROP, and the loop would keep using the freed
skb. Consumed results other than NETDEV_TX_OK and NET_XMIT_CN are now
charged to tx_dropped, and the function returns.

Link: https://lore.kernel.org/netdev/179248763469.3135.1739559328868319628@kernel.org/
Link: https://lore.kernel.org/netdev/20261023162821.GN708417@horms.kernel.org/

> Only NETDEV_TX_OK keeps
> the packet counted in tx_packets/tx_bytes and advances the slave; a
> consumed result that is neither a success nor NET_XMIT_CN ends the
> attempt and is charged to tx_dropped, so lower-qdisc drops are no longer
> reported as good transmits. NET_XMIT_CN is counted like success because
> it can accompany acceptance of the current packet: pfifo_head_drop drops
> the old head, enqueues the current skb and returns NET_XMIT_CN.

[Severity: Low]
Is this description accurate? The code sends NET_XMIT_CN down the same
path as NETDEV_TX_OK. So NET_XMIT_CN also advances master->slaves and
increments master->tx_packets and master->tx_bytes. The "Only
NETDEV_TX_OK" sentence seems to contradict the NET_XMIT_CN sentence that
follows it, and the v1 -> v2 notes say the same thing.

Several qdiscs also drop the current skb and still return NET_XMIT_CN.
One example is noop_enqueue():

	dev_core_stats_tx_dropped_inc(skb->dev);
	__qdisc_drop(skb, to_free);
	return NET_XMIT_CN;

Another is red_enqueue():

	qdisc_drop_reason(skb, sch, to_free, reason);
	return NET_XMIT_CN;

choke, gred, fq_pie and sfb behave the same way. When a VLAN or macvlan
slave sits on top of one of these, teql would still count those drops as
good transmits in tx_packets and tx_bytes.

Treating NET_XMIT_CN as success matches net_xmit_eval() and
vlan_dev_hard_start_xmit(), so the code choice is probably fine. Could
the commit message drop the "Only NETDEV_TX_OK" wording? It also says
that lower-qdisc drops "are no longer reported as good transmits", which
does not hold for these qdiscs.

> diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
> index 6764f0dd38dfb..70c948a26f809 100644
> --- a/net/sched/sch_teql.c
> +++ b/net/sched/sch_teql.c
> @@ -360,12 +360,18 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
>  		case 0:
>  			if (__netif_tx_trylock(slave_txq)) {
>  				unsigned int length = qdisc_pkt_len(skb);
> +				int rc = NETDEV_TX_BUSY;
>  
>  				skb->dev = slave;
> -				if (!netif_xmit_frozen_or_stopped(slave_txq) &&
> -				    netdev_start_xmit(skb, slave, slave_txq, false) ==
> -				    NETDEV_TX_OK) {
> -					__netif_tx_unlock(slave_txq);
> +				if (!netif_xmit_frozen_or_stopped(slave_txq))
> +					rc = netdev_start_xmit(skb, slave, slave_txq, false);
> +				__netif_tx_unlock(slave_txq);
> +				if (dev_xmit_complete(rc)) {
> +					if (rc != NETDEV_TX_OK && rc != NET_XMIT_CN) {
> +						master->tx_dropped++;
> +						rcu_read_unlock();
> +						return NETDEV_TX_OK;
> +					}

[Severity: Medium]
Should this drop path also move master->slaves on to NEXT_SLAVE(q)
before it returns?

Only the success block below and the case 1 path rotate master->slaves.
Every call to teql_master_xmit() starts from the same pointer:

	start = rcu_dereference(master->slaves);

If a slave keeps returning NET_XMIT_DROP or a negative errno, each later
packet would go to that slave first and be dropped. The other slaves
would never be tried.

A VLAN slave can do this for a long time. vlan_dev_hard_start_xmit()
returns the raw dev_queue_xmit() result and never stops its own queue:

	ret = dev_queue_xmit(skb);
	...
	return ret;

So neither the netif_xmit_stopped() check nor the netif_running() check
would skip it. macvlan_start_xmit() behaves the same way. This can
happen when the lower device has a pfifo with limit 0, a full fifo or
tbf, or an egress tc or netfilter drop.

When a slave is busy, teql retries the same skb on the next slave. A
dropped skb can't be retried, so without rotation the drops build up on
one slave. If that slave drops every packet, is all traffic through the
teql master lost?

The case 1 path already rotates master->slaves after the skb is consumed
by neighbour queueing:

	case 1:
		raw_spin_lock_irqsave(&master->slaves_lock, flags);
		if (rcu_dereference_protected(master->slaves, ...) == q)
			rcu_assign_pointer(master->slaves, ... NEXT_SLAVE(q) ...);

Would doing the same rotation here keep traffic spread across the slaves?

>  					raw_spin_lock_irqsave(&master->slaves_lock, flags);
>  					if (rcu_dereference_protected(master->slaves,
>  								      lockdep_is_held(&master->slaves_lock)) == q)

[ ... ]

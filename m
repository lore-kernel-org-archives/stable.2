Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794334752;
	b=via3OzOS24JlXbU4s+Q87puN2AIOt+/X3V5Ws8hB1sOUvsrUHTUkpbP8NDq6l1bCh2Qp
	 O/Kj8s6SG0NsE0JNhMNEMXrumIOH0jpmDh0phQK6DcALg/+ltbM9PywrLVLtqi4Xg9UqZ
	 W9NVCfgykwXdsW7Seu/wMWDHS6yIWzQBmztTk96ZWC8IaHk9N+eTuePtjg1EfwjmizBcq
	 roJiRa7Y4VxuqVybPG4ykXKdcJdTn14Ho3USXcFWZS+XEf5wqo4LSGspAaOy6pB1yHSgV
	 iQgtdruCMx8z0I1ROIRNX0tpBeqXlH2D3/0sJvDbO8g4xLeIoF84HnkkWCGqWjR145g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794334752;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Kkii477WueibGtNxsBDBQaaPWSkVNGKlt8PVaDjWSRA=;
	b=CSOwrti4QK7ZECr7YeW+IXBRvlZk6B7xJgm7JtFp+oIs/eMCoFC5BzHBB2MymPmd6Z3H
	 qWDj+XNtH+2uGAjceBdHeGLcRnbe4JSiJfJuBWzjfw5/52tM4XNzdo76qwSxi9/79fCpm
	 7LtO/qRGlErkUGMWZc00JBYa0Zo250V1TUZPbj3mm/mYx5ofGoIvir5xjjKJkeFuKxjlU
	 65yoW8w1gBClk5UcDEjCMEcoL9rrLT4ogcvl1gnk/uJumUixSiJQgoxE8urddsFYvrCF1
	 xbT4fFWJAJE+TMLd3Jt7T8UcGf3bzf+47aPGXP9pazdsRC39Fb74oAAKUptc32NSSKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R6rIaKSB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C94606A320;
	Tue, 10 Nov 2026 18:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R6rIaKSB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 394FD1F0089F;
	Tue, 10 Nov 2026 18:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794334751;
	bh=Kkii477WueibGtNxsBDBQaaPWSkVNGKlt8PVaDjWSRA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=R6rIaKSBJ0mmqqPyIMuEPBjes1JFZG2t9g/N13gg7FWEdvvY+Q99sqdBVcJ06z2JW
	 ovivyfOVLuD7GK3vPcQ+LYuwLIP/SkQYjufrnrN8eD+KjHAZ53gTXEeQzJZe7KIkvV
	 2Z+20+Kw2HHzLzycaZ0rIQApjxRWuIxb9k5MrW1xRMjvqL8lOmKiP1LSmiYghD1apJ
	 uqcSWov37Gl9xx0gf5z7HvlHkCGRGex3g3qeKYFhEuyPpeofuURZ4WOk3GDVRC4ict
	 TlK4lvHC8Ac7z9ppIkAL/960lEh54qrgH3DWWKYIRcqqqTWqFCwT9EV8zm1418Qzgg
	 2iRveiNihlHOg==
Date: Tue, 10 Nov 2026 10:19:08 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, Victor Nogueira <victor@mojatatu.com>, Jiri
 Pirko <jiri@resnulli.us>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, stable@vger.kernel.org, sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 2/2] net/sched: sch_teql: keep skb->dev
 consistent on the arp-queue path
Message-ID: <20261110101908.2e64e8e9@kernel.org>
In-Reply-To: <QDISC-6HS9.v3.r0.20261103062649-2@mojatatu.com>
References: <QDISC-6HS9.v3.r0.20261103062649@mojatatu.com>
	<QDISC-6HS9.v3.r0.20261103062649-2@mojatatu.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  3 Nov 2026 07:39:16 -0500 Jamal Hadi Salim wrote:
> This is a follow-up to commit dc4b95b8fee9 ("net/sched: sch_teql: restore
> skb->dev on the slave failure path") by Victor Nogueira, which covered the
> slave side of the same mismatch.
> 
> The issue:
> teql_master_xmit() sets skb->dev = slave only right before the slave's
> ndo_start_xmit(). If the slave's neighbour is unresolved, teql_resolve()
> parks the skb on the slave's arp_queue with skb->dev still naming the teql
> master. teql_exit() frees the masters on module unload and a slave can
> outlive them, so a queued skb can be reinjected through freed memory.
> 
> The Fix:
> Set skb->dev = slave before teql_resolve() so the parked skb names the
> device whose neighbour owns it, and restore skb->dev = n1->dev at the
> neigh_update_process_arp_queue() reinjection point so the skb goes back
> through teql_master_xmit() instead of leaving headerless.
> 
> The parked skb has a second consumer: when the neighbour fails instead of
> resolving, neigh_invalidate() hands it to error_report() and
> dst_link_failure(), which read skb->dev to report the failure, so it names
> the slave on that path too.
> 
> The restore is limited to a top-level neighbour whose device has no
> header_ops, which is the shaper/eql/sch_teql class: those devices get
> neigh_direct_output() from arp_constructor() and ndisc_constructor(), an
> output that transmits on skb->dev and builds no link header, so the skb
> has to be moved back.
> 
> A forward that steers the skb to another device, nft fwd ... neigh or
> bpf_redirect_neigh() with explicit nexthop parameters, parks it with the
> dst of the original route still attached. The drain looks the neighbour
> up from that dst and not from the forwarding device, so when the original
> route is itself a headerless device this gate matches there and the skb
> goes back out the original device, running its egress hook a second time.
> Those forwards supply their own device and nexthop and do not consult the
> retained dst, so dropping it at those two sites is where that is fixed;
> that is a separate change to the producers, not part of this series.
> 
> Some context:
> Only a module unload frees a master. teql_master_setup() installs no
> rtnl_link_ops and default_device_exit_net() moves the device to init_net
> when its namespace exits, so the window is a parked skb plus CAP_SYS_MODULE
> on an unloaded sch_teql.
> 
> Conditions to recreate the bug:
> CONFIG_NET_SCH_TEQL=m and CONFIG_VETH=y, run as root. Create a veth pair,
> make one end a teql slave, give the master an address and a route, flush
> the slave's neighbour entry and send one packet:
> 
>   ip link add v0 type veth peer name v0p
>   ip link set v0 up;  ip link set v0p up
>   tc qdisc add dev v0 root teql0
>   ip link set teql0 up
>   ip addr add 10.0.0.1/24 dev teql0
>   ip route add 10.0.0.99/32 dev teql0
>   ip neigh flush dev v0
>   ping -I teql0 -c 1 10.0.0.99 &
>   sleep 1
> 
> The skb waits on v0's arp_queue while the solicitation is in flight.
> Remove the qdisc, which drops the module reference it holds, and unload
> the module while the skb still waits:
> 
>   tc qdisc del dev v0 root
>   rmmod sch_teql
> 
> teql_exit() frees teql0 there. When the solicitation then fails,
> neigh_invalidate() drains the queue through arp_error_report() and
> ipv4_link_failure(), whose __icmp_send() reads skb_in->dev; that is the
> freed master before this patch and v0 after it. A resolved neighbour
> drains the same queue through neigh_update_process_arp_queue().
> 
> On the unfixed tree the skb is parked on v0's arp_queue while skb->dev
> still names teql0, so the reinjection can reach a master that teql_exit()
> has freed. Moving skb->dev to the slave without restoring it at the
> reinjection point leaves the packet going out v0 without a link header.
> 
> The park and the headerless delivery reproduce without the unload.
> Freeing the master while the skb waits needs sch_teql built as a module,
> as above.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
> Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260824115928.4099988-1-victor@mojatatu.com
> Link: https://lore.kernel.org/netdev/20260824115928.4099988-1-victor@mojatatu.com/
> Link: https://lore.kernel.org/netdev/20261026160747.283702-1-horms@kernel.org/
> Link: https://lore.kernel.org/netdev/20261031165925.780930-1-horms@kernel.org/
> Link: https://lore.kernel.org/netdev/179363700308.3131.11778179538290251434@kernel.org/
> Cc: stable@vger.kernel.org
> Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> 
> ---
> 
> v2 -> v3:
> - Fix the conditions to recreate the bug: reaching a freed master needs
>   sch_teql built as a module, the slave qdisc removed and the module
>   unloaded while the skb still waits, and say which part of it reproduces
>   without the unload.  Considered comments from Sashiko (nipa).
> - Name the neighbour failure path that drains the same parked skb.
> 
> v1 -> v2:
> - Limit the skb->dev restore in neigh_update_process_arp_queue() to a
>   top-level neighbour whose device has no header_ops: shaper, eql and
>   sch_teql output straight on skb->dev without building a link header, so
>   the skb has to be moved back for them.
> - Say how a master is freed and add the conditions to recreate the bug.
>   Considered comments from Sashiko (nipa) and Sashiko (gemini).
> ---
>  net/core/neighbour.c | 3 +++
>  net/sched/sch_teql.c | 2 +-
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index d6e9c7c59a89..541cf699abae 100644
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
>  		if (n2)
>  			neigh_release(n2);

Looks odd, please split this out to its own fix, and make sure you CC
neigh maintainers.

> diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
> index ed8faa848f18..4eac1f9c8ddf 100644
> --- a/net/sched/sch_teql.c
> +++ b/net/sched/sch_teql.c
> @@ -368,13 +368,13 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
>  			continue;
>  		}
>  
> +		skb->dev = slave;
>  		switch (teql_resolve(skb, skb_res, slave, slave_txq, &hlen)) {
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
pw-bot: cr

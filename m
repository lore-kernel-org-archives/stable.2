Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793466030;
	b=uLnfxf5infC+oGYiem5s3drXXtcAAZKZmgT6mZSXsdOVuTcVQq1//QugV/p2hQyDXLNz
	 qdK7yBXqW/rTGDYOdfq2esgiOB0F3hwZKY19yxvtVmISGTJEaKVgrA/RrvEyz7SZI2pu2
	 zMBGOcW1M28dfVBJp2B53JIA3vEQO0XAQL4x0THhB0Oau+UX0rC4Zn1v6Rce9kvT7h9lQ
	 g2v2/TsuzwSF3lJmj4bsNLXDW68EbkBi3Gybn1gNMWf5MOWIdBevHxIdxuVl8F8+OKv8Y
	 1pKYpFKAlu1knF8d+VKmLChIGKLUVEvHJ63INdK+0jJ340LSkIP/eUxvXY+zZOjB/KA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793466030;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=AAnmPk24Kspt1k8yzROJ4hO/XohbeWA2YR2BpXBepyo=;
	b=PT0HR4GaEB2a0Quv+1GtJQAAF4DMpT2poZv1oDBe3TKDDbOkilTdsD3FIdgX5e7D9QWc
	 8bb4m+VKSsuLBngQaDRV9JeAbewinEJOS5R2XfQY93z+ZmAkuQkguIwTCECC6I4y5NfBZ
	 JPD29etaXU63QSJ7/bqTCLMY4i8mP3SM3ym/hopFSgGjgKX0CSFxKkKl5ABsCpxZE24Lt
	 kMqiRXm7Avf4zNIBzfDH0kR5Tx8svRWKXDFYrnKniKABr0wKaKmq0vCnODWjrcF1qeZZm
	 kdwhwfdPkVh/QRcOBavT/5JQcAX1m2eCRQXrRNVwyNO0TccF9NpqTBmqxSjA8XIiKuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JZT+gA5S;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94AD606A31A;
	Sat, 31 Oct 2026 17:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JZT+gA5S
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42AD11F000C1;
	Sat, 31 Oct 2026 17:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793466029;
	bh=AAnmPk24Kspt1k8yzROJ4hO/XohbeWA2YR2BpXBepyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JZT+gA5SAFjdF9kWmFjkp6ugIXcuaDr6mQw9GGdHlEQxvIbqhGMgvru2UJgUu4IhG
	 XCJ3YxaV8+E1n2/SOZFEpeRIwD2nerI7+aO9P2bbm7Pqa/UvrrLNkxHdJBJBw7SQqW
	 W7Nf43PSStDd907R90ErHXNEGSwuGE5+ph/Jsh5p+vQT+xOHW9Bw4EJu84v2zCZtHG
	 7K4qxEvzAIP59X+364UQQjS+Jfab+k5bw6Nnzd0YuByudxz2U5AtjSKSTapIm+Z30E
	 KaRZkJLVjK/k5cVgp0uEIQsj5+JDsAXmtqKXirnNI6pCtPHS4W+o9qdWgWK2YnlK3e
	 cvofEuF3VhWdg==
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
Subject: Re: [PATCH net 2/2 repost3] net/sched: sch_teql: keep skb->dev consistent on the arp-queue path
Date: Sat, 31 Oct 2026 16:59:25 +0000
Message-ID: <20261031165925.780930-1-horms@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <QDISC-6HS9.v1.r3.20261027034729-2@mojatatu.com>
References: <QDISC-6HS9.v1.r3.20261027034729-2@mojatatu.com>
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
email says "Sorry Jamal, another round of AI-feedback for this one.
It is superficually simliar to the \AI-generated feedback for
repost2, but does raise some specific points that I think warrant
you expressing an opinion on. Thanks!"
Full review at: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-6HS9.v1.r3.20261027034729-1@mojatatu.com?part=2
---
net/sched: sch_teql: keep skb->dev consistent on the arp-queue path

This patch makes teql_master_xmit() set skb->dev to the slave before
calling teql_resolve(). An skb parked on the slave's arp_queue then no
longer points at the teql master. It also makes
neigh_update_process_arp_queue() set skb->dev = n1->dev before it
reinjects queued skbs.

Link: https://lore.kernel.org/netdev/20260824115928.4099988-1-victor@mojatatu.com/

> The master can be freed while the slave lives, so the
> queued skb can dereference freed memory.

[Severity: Low]
Could the commit message say how the master gets freed? As far as I can
tell, teql_exit() is the only place that frees the master net_device, and
it only runs on module unload:

net/sched/sch_teql.c:teql_exit() {
    ...
	unregister_qdisc(&master->qops);
	unregister_netdev(master->dev);
	free_netdev(master->dev);
    ...
}

teql_master_setup() never sets rtnl_link_ops, so rtnl_delete_link()
refuses to delete the master:

	ops = dev->rtnl_link_ops;
	if (!ops || !ops->dellink)
		return -EOPNOTSUPP;

default_device_exit_net() moves devices like this back to init_net
instead of freeing them, so destroying a netns doesn't free it either.

That leaves one window. Every teql qdisc has been removed from the
slaves, an skb is still sitting on a slave neighbour's arp_queue with
skb->dev pointing at the master, and then sch_teql is unloaded. The
unload needs CAP_SYS_MODULE.

This is the justification for a stable-bound change to shared neighbour
reinjection. Would it help to describe this rmmod-only trigger in the
message?

> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index d6e9c7c59a892..120c3369406fb 100644
> --- a/net/core/neighbour.c
> +++ b/net/core/neighbour.c
> @@ -1339,6 +1339,7 @@ static void neigh_update_process_arp_queue(struct neighbour *neigh)
>  			if (n2)
>  				n1 = n2;
>  		}
> +		skb->dev = n1->dev;
>  		READ_ONCE(n1->output)(n1, skb);
>  		if (n2)
>  			neigh_release(n2);

[Severity: Medium]
This runs for every neighbour user, not only sch_teql. Here n1 isn't
always the neighbour the skb was queued on. It comes from
dst_neigh_lookup_skb() on the skb's retained dst, and
ipv4_dst_neigh_lookup() looks it up on dst_dev_rcu(dst).

Two existing parkers set skb->dev to a target device B but leave an
original route dst whose device is A.

The first is bpf_redirect_neigh() with explicit nexthop params.
__bpf_redirect_neigh_v4() and __bpf_redirect_neigh_v6() replace the dst
only when nh is NULL. bpf_out_neigh_v4() and bpf_out_neigh_v6() then set
skb->dev = B and call neigh_output() on B's nexthop neighbour.

The second is nft fwd ... neigh. nft_fwd_neigh_eval() decrements
TTL/hop_limit, sets skb->dev = B and calls neigh_xmit(), and it never
touches the dst. nft_fwd_validate() allows NF_NETDEV_EGRESS.

In __dev_queue_xmit(), nf_hook_egress() and sch_handle_egress() run
before the IFF_XMIT_DST_RELEASE skb_dst_drop(). __neigh_event_send()
also calls skb_dst_force() before queueing. So the dst is still attached
when the skb is parked on B's arp_queue.

The resulting sequence looks like this:

egress on A
  bpf_redirect_neigh(B, params) or nft fwd ... neigh
    skb->dev = B, skb_dst(skb)->dev == A
    __neigh_event_send() on B's NUD_INCOMPLETE neighbour, skb queued

B's neighbour resolves
  neigh_update_process_arp_queue()
    dst_neigh_lookup_skb() -> n1 is A's gateway neighbour
    skb->dev = n1->dev;    /* now A */
    n1->output() -> dev_queue_xmit(A)
      nf_hook_egress() / sch_handle_egress() on A again

Doesn't this run A's egress hooks a second time on packets they already
handled? With nft fwd neigh the TTL is decremented twice, and a packet
that arrived with TTL 2 would hit this in nft_fwd_neigh_eval():

	if (iph->ttl <= 1) {
		verdict = NF_DROP;
		goto out;
	}

Counters and quotas would also count the packet twice. Tc egress BPF
programs would run twice and could apply encap or NAT twice.

The second pass might not redirect again, for example if the first pass
changed a mark the rule depends on. In that case, would the packet leave
on A toward the original gateway instead of the nexthop the policy chose?

Before this patch skb->dev stayed B. These packets went out on B with A's
L2 header. That was already wrong, but they did not go back through A's
egress path.

The bpf_redirect_neigh uAPI docs still say the packet is redirected to
ifindex, and NFTA_FWD_SREG_DEV is still documented as the output
interface. The commit message says only "This is a behaviour change for
those paths", and the patch is Cc: stable.

Could the skb->dev restore be limited to the teql case, or handled in
sch_teql itself, rather than applied to every neighbour user here?

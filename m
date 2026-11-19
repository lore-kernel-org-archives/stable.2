Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795084719;
	b=j7YiZ8eAh8dixRkTi/LCDr2Whdei+fjRnZr9k0ENmZwa7xNrS41bFa/1kF47eqsmK2jx
	 kC5dPzvZlfOqO30tFw7ANY7EbtyMpa7WjOYso64zodnCfj8V3vyr5KVCZ9jQarjCH5KyP
	 /hZBhWNUBABZXCmnUEWKuFKNjrIUbPCpzdocrKx/tXhwDSQYXFd6msVCBsc4ByMTwD8zq
	 QbnlEpvQq7Wzz6N8HXlcIoqMS7V66ZgqvVz2AGDQbD6ReXudyim4aMsyoXHWIMVBSOBs7
	 tH3ZjfG1IFIwaC80o8Xjr7eV7QkggYw0uUMpl1QIINhK16sqJfI/ouqSSnSku33a1nQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795084719;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=hjEdvfgVocBOV4KmDkOIrforBlOl/M8Z8/JkOXSBrAs=;
	b=uV7OjQQfbZqm4Kg2IPFCx8DJlDhZ4zlSRt1wXMPbmTdHHpu0J8CLn6dmMf5G0s9/ge7o
	 88srv/5P2FG5EbVLoWXzKyVjGyMCH2SIg5U8PQJm0+5yO3c4MLmdEZUzxN3jbe0f2GYnT
	 5zq0uazbz886SVhm3tM4qJ9KoNScgTrzUFT6L6fbmsmzDk/+1bDKne5GTV0Kq3AMkwi4r
	 hGGtvKN6mEKkSqOJ3fZDn5xcC/co5j1RuKWMNnVf8YAM5akyT/09w4NKGj4v01N7hWhh8
	 vx1pRPxP7Xb0c4v9FVt0AMVND+uczQ3Q8NPRVq0/IwQjrZPVTbEeWMXVkJmiCKis6/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hf57v2F+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B56606A324;
	Thu, 19 Nov 2026 10:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hf57v2F+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8FC41F000C5;
	Thu, 19 Nov 2026 10:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795084719;
	bh=hjEdvfgVocBOV4KmDkOIrforBlOl/M8Z8/JkOXSBrAs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Hf57v2F+ibzubEBZpj90Q0MsmF+VIHuKYRsvNjDDPsgYDRZKgkNvhYJtidRlZFRIY
	 1iWhCaaY2w8yqrLaKkUpltW+JjZzoUIV+uJkOPUszLtvyNI/JNvaD1TQONtVFnJbP9
	 9ANZFH4fjf5/Y/GU2W3OhE3AoKIo4lITazhv4GKd81CHnXxIDD/jYZp1KSEkRGHRUb
	 oGj7xXegMiIidUo9j1eSx89lhQpmo4SJk6Qg1TdCN53gA+1wzcwTdZ6keCM1u9V0um
	 Pwb0xE80tFM74Y+G2qvnivLdjoGzFgWk2cW2RUsrv/oZ8oPs8iRRq3Q+oxyTjoR44r
	 fluVph+6r3kFg==
Subject: Re: [PATCH net v5 1/3] net/sched: sch_teql: unshare the header before
 writing and fix retry strip
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, victor@mojatatu.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, stable@vger.kernel.org, sashiko-bot@kernel.org
Date: Thu, 19 Nov 2026 10:38:38 +0000
Message-ID: <179508471843.3136.7272721682226577890@kernel.org>
In-Reply-To: <QDISC-6HS9.v5.r0.20261116052927-1@mojatatu.com>
References: <QDISC-6HS9.v5.r0.20261116052927-1@mojatatu.com>
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

- [Medium] This patch changes how teql_master_xmit()
  (net/sched/sch_teql.c) retries when an skb has a dst attached and…

--

net/sched: sch_teql: unshare the header before writing and fix retry strip

This patch calls skb_cow_head() in __teql_resolve() before the slave
neighbour can write or queue the skb, so a cloned header is not
corrupted. It also changes the retry path in teql_master_xmit(). The
retry now pulls back only the bytes the current slave pushed, instead of
pulling to the network header, so AF_PACKET frames without a dst keep
their own link header.

Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-6HS9.v4.r0.20261111094338-1%40mojatatu.com
Link: https://lore.kernel.org/netdev/20260824115928.4099988-1-victor@mojatatu.com/
Link: https://lore.kernel.org/netdev/20261110101908.2e64e8e9@kernel.org/

> diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
> index dc21cd9704a25..626dc001ec231 100644
> --- a/net/sched/sch_teql.c
> +++ b/net/sched/sch_teql.c

[ ... ]

>  	if (neigh_event_send(n, skb_res) == 0) {
> +		int off = skb_network_offset(skb);
>  		char haddr[MAX_ADDR_LEN];
>  
>  		neigh_ha_snapshot(haddr, n, dev);
>  		if (dev_hard_header(skb, dev, ntohs(skb_protocol(skb, false)),
>  				    haddr, NULL, skb->len) < 0)
>  			err = -EINVAL;
> +		/* The bytes prepended above skb->data, pulled back on retry. */
> +		*hlen = skb_network_offset(skb) - off;
>  	} else {
>  		err = (skb_res == NULL) ? -EAGAIN : 1;
>  	}

[ ... ]

> @@ -408,8 +421,10 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
>  			nores = 1;
>  			break;
>  		}
> +		/* Pull back only the header this slave added. */
> +		if (hlen > 0)
> +			__skb_pull(skb, hlen);
>  		skb->dev = dev;
> -		__skb_pull(skb, skb_network_offset(skb));
>  	} while ((q = rcu_dereference(NEXT_SLAVE(q))) != start);

[Severity: Medium]
What happens on retry when the skb has a dst and already carries
link-layer bytes in front of its network header?

The old retry reset skb->data to the network header. That matches what
neigh_resolve_output() and neigh_connected_output() do before building
a header:

net/core/neighbour.c:neigh_resolve_output() {
    ...
		do {
			__skb_pull(skb, skb_network_offset(skb));
			seq = read_seqbegin(&neigh->ha_lock);
			err = dev_hard_header(skb, dev, ntohs(skb->protocol),
					      neigh->ha, NULL, skb->len);
    ...
}

__teql_resolve() pushes the slave header at skb->data without pulling
to the network header first, and hlen only counts that push. So with
the new retry, any L2 bytes already present when teql_master_xmit() was
entered stay in place across every retry.

One path that still delivers such an skb, even with the rest of the
series applied, is nft fwd ... neigh on a netdev egress chain.
nft_fwd_validate() allows NF_NETDEV_EGRESS, and nft_fwd_neigh_eval()
neither pulls to the network header nor drops the dst:

net/netfilter/nft_fwd_netdev.c:nft_fwd_neigh_eval() {
    ...
	skb->dev = dev;
	skb_clear_tstamp(skb);

	nf_dev_xmit_recursion_inc();
	neigh_xmit(neigh_table, dev, addr, skb);
    ...
}

teql0 has no header_ops, so arp_constructor() installs
neigh_direct_output() for it:

nft_fwd_neigh_eval()
  neigh_xmit()
    neigh_direct_output()
      dev_queue_xmit(teql0)
        teql_master_xmit()
          __teql_resolve()

The skb arrives with eth0's header in front of the IP header (network
offset 14) and eth0's route dst still attached. Because dst->dev !=
slave, __teql_resolve() looks up the slave's neighbour. From there:

If the slave neighbour is resolved, dev_hard_header() pushes 14 bytes
and hlen = 14. If the trylock then fails or the slave returns
NETDEV_TX_BUSY, the retry pulls only 14 bytes. The next slave sends
slave header + eth0 header + IP, while the old code pulled 28 bytes
and sent a single header.

If the slave neighbour is unresolved (-EAGAIN, nores), hlen = 0 and
nothing is pulled. The next slave in the same pass gets the double
header, while the old code pulled the stale 14 bytes.

At this commit alone there is a second trigger: an arp_queue skb
drained back into teql0 after neigh_resolve_output() wrote an eth0
header. Here skb->dev = slave is only set inside case 0, so the parked
skb still has skb->dev pointing at teql0.

That second trigger is closed later in the series. "net/sched: sch_teql:
keep skb->dev consistent on the arp-queue path" sets skb->dev = slave
before teql_resolve(). "net: neighbour: reinject a parked skb through a
headerless output device" only reverts skb->dev to a headerless
n1->dev, whose output is neigh_direct_output(), so no header is written
in that case. The nft fwd path above is not affected by either change.

The AF_PACKET case in the commit message only seems to need the
dst == NULL early return in teql_resolve(), where hlen is always 0.
Would it work to keep pulling to the network header for skbs with a
dst? Another option would be to pull to the network header in
__teql_resolve() before dev_hard_header(), as neigh_resolve_output()
does.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-6HS9.v5.r0.20261116052927%40mojatatu.com

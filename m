Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794064585;
	b=ceoWCc0ebmI7Mo2h7k9nIDDs3NJG8VmOJIn8z4SIu+nNUi+l3T0mLOO7QAYjMBlEAIJx
	 dDUHOGaYgTXdFcdohWTFjwjVWmxM8r0yWclzecIdUDS4G9DMnEDNz4268IJJzJMd+wusW
	 PCegYgmZ53S/Xo+ndFnebk0fev+G7r4ehP1QKTADCeyMfnKiLMDSWKlhWrtdosyB25u5n
	 LKiF+x93OwYq6owNxLSiS1khhbBeiWSUF9CoyB7IZ9X/dQovTU7xxYAKvaoRVWTr3iznq
	 k+/lT5c/A1ENG8hK5sQbU0sKBbUShmECWaMouZJZPgZ7n7FF/hxeUEOmtFsy/oL7CVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794064585;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=fmTPVOyd1cQq/DQTsVIa0U0d4oxVcQ44aVcpPa+R3AU=;
	b=Hqiesm+qacwq9MWM06DMfQ1R/Vlzawnu192gCfD/2jDpPedrpv5x6A7dP6X7aFxsapAN
	 lfcgyI+TXwCvr1OxB89ehiMPEJuDQBQnJ78Fi5h6JVC2y6sMoxwXo1DcKHr5iUBFk30dk
	 LNN9KLUvxOGgEtlERbvigh9M+rgdUaY8LHCGX46rJh9ztITxAJqyo9I2Vz0oe7pWc28Wi
	 7R9K8c8/VvQAZypxdrItn4NCuo0+1HiOSBRfWG0dMa75NRJlPAjR+8y+/bUMVPwWde1JN
	 DFi9o5lSHsx+JZwAyTUTyZluehoqZH1LdKEF/oX7T+rlkzf7v0B7ULWkWoD8tdLfwYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hIr3afK1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A61606A9C0;
	Sat,  7 Nov 2026 15:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hIr3afK1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E683D1F008A1;
	Sat,  7 Nov 2026 15:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794064584;
	bh=fmTPVOyd1cQq/DQTsVIa0U0d4oxVcQ44aVcpPa+R3AU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hIr3afK1NEdfK2hUtPa73OpNAiYqypYV3mbFMFhq9F9bMZq6ANRoashrX79qOZqoW
	 mH/iay2XCs1hRG/mRtvy7MQh9T8JJ+Og83+qGBUEBRJPOyV1pRwuBteWEp7tjOd5/0
	 RPvNZPDkPTmSjUQAjsCsnru7Ns+IWwhCHJ4+qv/Va6S4IIO/RDYtUm/9sYcS1/aosY
	 CwlycAC6Abmr8oTuE57AbdUNqpboa/vwnMWmuuUOSE67/YtHRvjVeXTLz4TctQpdBx
	 v5OLDL0ke80B5y44JHtNhvKvHO4gbeDkFeDnWTgr1wmxQzD3Ki3iDXLyXRuWLTqXJp
	 b4/U1CUOuZ2Og==
Subject: Re: [PATCH net v3 2/2] net/sched: sch_teql: keep skb->dev consistent
 on the arp-queue path
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, victor@mojatatu.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, stable@vger.kernel.org, sashiko-bot@kernel.org
Date: Sat, 07 Nov 2026 15:16:23 +0000
Message-ID: <179406458348.994134.6942745655171316289@kernel.org>
In-Reply-To: <QDISC-6HS9.v3.r0.20261103062649-2@mojatatu.com>
References: <QDISC-6HS9.v3.r0.20261103062649-2@mojatatu.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new gate in neigh_update_process_arp_queue()
  (net/core/neighbour.c), `if (!n1->dev->header_ops) skb->dev =…
- [Low] The comment added in neigh_update_process_arp_queue()
  (net/core/neighbour.c), '/* headerless outputs (teql, shaper) transmit…

--

net/sched: sch_teql: keep skb->dev consistent on the arp-queue path

The commit sets skb->dev to the teql slave before teql_resolve(). This
means an skb parked on the slave's arp_queue no longer points at a master
that teql_exit() can free on module unload. It also changes
neigh_update_process_arp_queue() to set skb->dev to the top-level
neighbour's device when that device has no header_ops, so the skb goes
back through teql_master_xmit().

Link: https://lore.kernel.org/netdev/20260824115928.4099988-1-victor@mojatatu.com/
Link: https://lore.kernel.org/netdev/20261026160747.283702-1-horms@kernel.org/
Link: https://lore.kernel.org/netdev/20261031165925.780930-1-horms@kernel.org/
Link: https://lore.kernel.org/netdev/179363700308.3131.11778179538290251434@kernel.org/

> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index d6e9c7c59a892..541cf699abae4 100644
> --- a/net/core/neighbour.c
> +++ b/net/core/neighbour.c
> @@ -1339,6 +1339,9 @@ static void neigh_update_process_arp_queue(struct neighbour *neigh)
>  			if (n2)
>  				n1 = n2;
>  		}
> +		/* headerless outputs (teql, shaper) transmit on skb->dev */

[Severity: Low]
This isn't a bug, but the shaper driver is no longer in the tree. There
is no entry for it in drivers/net/Makefile, and the older comment block
just above also names it.

Would it be clearer to name in-tree devices this gate is meant for, such
as teql and eql?

> +		if (!n1->dev->header_ops)
> +			skb->dev = n1->dev;
> +		READ_ONCE(n1->output)(n1, skb);

[Severity: Medium]
This gate is in generic neighbour code, and it doesn't check whether
sch_teql parked the skb. n1 comes from the skb's retained dst via
dst_neigh_lookup_skb().

Can it fire for any skb parked on an arp_queue whose original route uses
a device with NULL header_ops? Examples include ppp, geneve in L3 mode,
vxlan when header_ops is NULL, rmnet, qmi_wwan, mhi_net, ipa, iosm,
mhi_wwan_mbim, eql and teql.

Two producers park skbs on another device's neighbour while keeping the
original dst.

The first is nft_fwd_neigh_eval(), which nft_fwd_validate() allows on
NF_NETDEV_EGRESS:

	ip_decrease_ttl(iph);
	...
	skb->dev = dev;
	skb_clear_tstamp(skb);

	nf_dev_xmit_recursion_inc();
	neigh_xmit(neigh_table, dev, addr, skb);

The second is bpf_redirect_neigh() with an explicit nexthop.
__bpf_redirect_neigh_v4() replaces the dst only when nh == NULL:

	if (!nh) {
	...
		skb_dst_drop(skb);
		skb_dst_set(skb, &rt->dst);
	}

bpf_out_neigh_v4() then sets skb->dev to the target and calls
neigh_output() with the old dst still attached.

When the target device X's neighbour resolves, the drain takes this path
(Y is the original route device):

neigh_update_process_arp_queue()
  dst_neigh_lookup_skb()  -> Y's neighbour (Y has no header_ops)
  skb->dev = Y
  neigh_direct_output()
    dev_queue_xmit() on Y

Does this run Y's egress hooks a second time? In __dev_queue_xmit(),
nf_hook_egress() runs before nf_skip_egress(skb, true) is set, so the
nft egress chain runs again. sch_handle_egress() and tc BPF also run
again.

For nft fwd, this would decrement TTL/hop_limit twice. A packet that
reaches Y's egress with TTL 2 would then be dropped.

Counters, quotas and limits would also be applied twice. A tc BPF program
that encapsulates could encapsulate twice. If the second pass gives a
different verdict, the packet would leave through Y and not through the
device it was forwarded to.

Before this patch these skbs went out X without a link header, which was
also wrong. Running Y's egress hooks a second time is new, though.

The commit message acknowledges this:

  "Those forwards supply their own device and nexthop and do not consult
  the retained dst, so dropping it at those two sites is where that is
  fixed; that is a separate change to the producers, not part of this
  series."

The patch is tagged Cc: stable. Would stable trees get the new behaviour
without the producer-side fix?

Should the dst drop in nft_fwd_neigh_eval() and in the bpf_redirect_neigh()
explicit nexthop path go in the same series as this change?

>  		if (n2)
>  			neigh_release(n2);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-6HS9.v3.r0.20261103062649%40mojatatu.com

Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B7144F56B
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 20:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790974255; cv=none; b=J3o5Qz7/+2COjSvQecNCQxrq1H2UpPDT9fo93L3/ygrqEOyw1J0EWSqOnvfjE07yYV+7AiY70eX8gvne122m1/jD29aNeWArf+/cHgHt7CWe25cINqO4iwxM+xzhXqM9QJyv17g+c1pph+fxIZN/Ubr9yK9zCOb54K3lPX5/Rcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790974255; c=relaxed/simple;
	bh=qFWyQDH0VtbKHscCgf440WYlDfCIFNxrpuwtwkGoZLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ThrS/d1i+voveI1Ze7trHlROjx35rb19RLY+/PQzNyUtAyi1X9u370fbpzrEkuTwkllI/q4nLmJJDaFVDwb3oVAfJOdLLZBZvJUopKH3jRoWsTILmJau6HXSsX2d7YBSSibB8kXa8ORIu6L/GIlmF2kAkbQvRGhVR9J/o3pKmIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=fe-bounces.ovn.org; dkim=pass (1024-bit key) header.d=ovn.org header.i=@ovn.org header.b=dQWZXryl; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.ovn.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ovn.org header.i=@ovn.org header.b="dQWZXryl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ovn.org;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-13eddc7e57; t=1790974246;
 bh=NedELFyFHThkKe78viH0+VGGS5ACbfyJUUh1kMXANdU=;
 b=dQWZXryl3pn7kBvuN2g0xz6GYM4QD56oBER/VIIjmS0c5eD87SKUV1zw3DKBuXptdGs1lVsn1
 YQFKQXvKq1zEfPUxZzulhIKJh4GUXeae3KYuCjGJbyGqVxRga0o6Wv/MuGnRocfwUrwd1p4zi5m
 5MjoCwutFCAvsIWOM5/ofdY=
X-Forward-Email-ID: 6ac0192625f3c91ad3779f81
X-Forward-Email-Sender: rfc822; i.maximets@ovn.org, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.17.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <892a3d9c-65f7-4216-95c2-e55938254e96@ovn.org>
Date: Fri, 2 Oct 2026 22:50:42 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] openvswitch: fix soft lockup in the netlink flow
 dump
To: "Denis V. Lunev" <den@openvz.org>, netdev@vger.kernel.org
Cc: dev@openvswitch.org, Aaron Conole <aconole@redhat.com>,
 Eelco Chaudron <echaudro@redhat.com>, Ilya Maximets <i.maximets@ovn.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, stable@vger.kernel.org
References: <20260929072519.2803304-1-den@openvz.org>
 <20260929072519.2803304-2-den@openvz.org>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20260929072519.2803304-2-den@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/29/26 9:25 AM, Denis V. Lunev wrote:
> From: Denis V. Lunev <den@openvz.org>
> 
> A production compute node carrying a few thousand datapath flows hit a
> soft lockup inside a single netlink flow dump and panicked.
> 
> ovs_flow_cmd_dump() calls ovs_flow_stats_get() for every flow it
> emits, and that releases stats->lock with spin_unlock_bh() once per
> CPU that has touched the flow. Every release is a local_bh_enable(),
> and each one runs the pending softirq backlog in the dumping thread's
> own context.
> 
> The skb bounds the flows one callback emits, but not the softirq work
> it absorbs. On a CPU that carries the box's packet load the backlog
> refills as fast as it drains, so the dumping thread becomes that CPU's
> softirq engine. It never sleeps and it has no reschedule point, so
> under voluntary preemption nothing can take the CPU away from it:
> neither the ksoftirqd the kernel woke to take the work over, nor the
> stopper thread the softlockup detector dispatches to refresh its
> timestamp.
> 
> Hold BH off across the whole callback instead, the way
> ctnetlink_dump_table() does, so the nested spin_unlock_bh() stop
> draining softirqs. The loop already runs under rcu_read_lock() and
> cannot sleep. What it gives up is preemption under CONFIG_PREEMPT,
> since a BH-off region is not preemptible outside PREEMPT_RT. The
> region stays short: the skb caps the flows one callback emits, and
> empty buckets cost no skb space but are each visited once per dump, as
> the cursor only moves forward. The table grows on insert and shrinks
> only on flush, so the walk is bounded by the largest flow count the
> datapath has held. The softirq backlog the callback used to absorb has
> no bound at all.
> 
> Fixes: 63e7959c4b9b ("openvswitch: Per NUMA node flow stats.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> ---
> v3:
> - add the net prefix, Fixes tag and Cc stable
> - explain why the BH-off walk stays bounded: the cursor visits each
>   empty bucket once per dump and the table shrinks only on flush
> - drop "here" from the comment, add blank lines around the
>   local_bh_disable()/local_bh_enable() pair
> v2: https://lore.kernel.org/netdev/20260915122401.3910188-1-den@openvz.org/
> - leave ovs_vport_cmd_dump() alone: nsid_lock has not been BH-safe
>   since commit aed4969f2bdf ("net: net->nsid_lock does not need BH
>   safety"), so the vport dump never drained softirqs
> - disable BH before the table dereference and say in a comment that
>   the region is not there for safety
> - drop the ovs_flow_stats_get() history, note the empty-bucket walk
>   and the lost CONFIG_PREEMPT preemption in the message
> - move the Cc list out of the commit message
> v1: https://lore.kernel.org/netdev/20260909171920.1001074-1-den@openvz.org/
> 
>  net/openvswitch/datapath.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
> index 631a03136fa1..4fc5d0bebd85 100644
> --- a/net/openvswitch/datapath.c
> +++ b/net/openvswitch/datapath.c
> @@ -1532,6 +1532,12 @@ static int ovs_flow_cmd_dump(struct sk_buff *skb, struct netlink_callback *cb)
>  		return -ENODEV;
>  	}
>  
> +	/*
> +	 * Not needed for safety. Stops every spin_unlock_bh() in
> +	 * ovs_flow_stats_get() from running the softirq backlog.
> +	 */
> +	local_bh_disable();
> +
>  	ti = rcu_dereference(dp->table.ti);
>  	for (;;) {
>  		struct sw_flow *flow;
> @@ -1552,6 +1558,8 @@ static int ovs_flow_cmd_dump(struct sk_buff *skb, struct netlink_callback *cb)
>  		cb->args[0] = bucket;
>  		cb->args[1] = obj;
>  	}
> +
> +	local_bh_enable();
>  	rcu_read_unlock();
>  	return skb->len;
>  }

Reviewed-by: Ilya Maximets <i.maximets@ovn.org>

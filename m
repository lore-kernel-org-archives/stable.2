Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76B23C1D7D
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 20:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790973701; cv=none; b=tA9wP8yhlGONf1sEOAHUUDhr6Ub0UXXaiCqgjgZ5ynq8aixecwBd/xQiMkCDr20UQydMFvt9XCFBjv8zQsZWsNxbNwYk2fhqmUCzEjQiWZFy7bptlCwD7ZILBMyZsD+tCosL9//MT7LZ8WHs1lirP8YmRVFakr99O7dqH+PYLik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790973701; c=relaxed/simple;
	bh=gSGkLWy9yvY7tZZ4ZKWB713JOMXWirdgzdfFvkBGukY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kkXw1sUn8HfppagOBh7AiIAP3w+udn7Yc4BW3IJZgT9PSqmvTdxTIU8o+ISjZAZxeL5rh5CM/U8G1itUJV7xhUDAMHR0KG/bBVBAwVZD1f0P8HZd0bVdrcMvFW02e7u0z6xhP0XqgpMs7SGL/5ke2frVQc7+JyfXf1QWAdLJX/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=fe-bounces.ovn.org; dkim=pass (1024-bit key) header.d=ovn.org header.i=@ovn.org header.b=feJPdnhU; arc=none smtp.client-ip=121.127.44.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.ovn.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ovn.org header.i=@ovn.org header.b="feJPdnhU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ovn.org;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-13eddc7e57; t=1790973697;
 bh=EWYXAp/W3+HiwhItKO7V9bOzZcPqAHsPQdSF1JKL+iU=;
 b=feJPdnhU4/qgxK5A9db1tjowioua/R02qeFHra67jrNJdfD9r8BqJTeyznAXtWWQu92Ys4ac0
 GZZk6LRJLgBHw87VWljF/8sDKPnO0mjQHnFwVyuioMMjhe5DZaQCx+m1iXMesA0RJQY7hyFrlaY
 ZtfoWm1/1usl0TUjnSPs86g=
X-Forward-Email-ID: 6ac01700fd5a2680fad29990
X-Forward-Email-Sender: rfc822; i.maximets@ovn.org, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.17.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <f7b2f1d5-4332-4187-89f8-dbd00ff11e1b@ovn.org>
Date: Fri, 2 Oct 2026 22:41:31 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] openvswitch: fix soft lockup in the netlink flow
 dump
To: netdev-bot+sashiko@kernel.org, den@openvz.org
Cc: netdev@vger.kernel.org, dev@openvswitch.org, aconole@redhat.com,
 echaudro@redhat.com, i.maximets@ovn.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 stable@vger.kernel.org
References: <20260929072519.2803304-2-den@openvz.org>
 <179089366251.434549.18021554028626523205@kernel.org>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <179089366251.434549.18021554028626523205@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/2/26 12:27 AM, netdev-bot+sashiko@kernel.org wrote:
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
> - [Medium] ovs_flow_cmd_dump() (net/openvswitch/datapath.c) now holds BH
>   disabled across the whole dump callback.
> 
> --
> 
> openvswitch: fix soft lockup in the netlink flow dump
> 
> This patch disables BH across the whole table walk in ovs_flow_cmd_dump().
> The goal is to stop the per-CPU spin_unlock_bh() calls in
> ovs_flow_stats_get() from running the softirq backlog in the dumping
> thread's context. That backlog processing led to a soft lockup on a
> heavily loaded compute node.
> 
>> diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
>> index 631a03136fa14..4fc5d0bebd85e 100644
>> --- a/net/openvswitch/datapath.c
>> +++ b/net/openvswitch/datapath.c
>> @@ -1532,6 +1532,12 @@ static int ovs_flow_cmd_dump(struct sk_buff *skb, struct netlink_callback *cb)
>>  		return -ENODEV;
>>  	}
>>  
>> +	/*
>> +	 * Not needed for safety. Stops every spin_unlock_bh() in
>> +	 * ovs_flow_stats_get() from running the softirq backlog.
>> +	 */
>> +	local_bh_disable();
>> +
>>  	ti = rcu_dereference(dp->table.ti);
>>  	for (;;) {
>>  		struct sw_flow *flow;
> 
> [ ... ]
> 
>> @@ -1552,6 +1558,8 @@ static int ovs_flow_cmd_dump(struct sk_buff *skb, struct netlink_callback *cb)
>>  		cb->args[0] = bucket;
>>  		cb->args[1] = obj;
>>  	}
>> +
>> +	local_bh_enable();
>>  	rcu_read_unlock();
>>  	return skb->len;
>>  }
> 
> [Severity: Medium]
> Can a namespace user control how long this BH-off region lasts?
> 
> The region now covers the whole walk in ovs_flow_tbl_dump_next(). When
> buckets are empty, that loop has no exit that depends on skb space:
> 
> net/openvswitch/flow_table.c:ovs_flow_tbl_dump_next() {
>     ...
> 	while (*bucket < ti->n_buckets) {
> 		i = 0;
> 		head = &ti->buckets[*bucket];
> 		hlist_for_each_entry_rcu(flow, head, flow_table.node[ver]) {
> 		...
> 		}
> 		(*bucket)++;
> 		*last = 0;
> 	}
>     ...
> }
> 
> This means one callback can scan the entire bucket array with softirqs held
> off.
> 
> The only cap on n_buckets is the kvmalloc limit, which allows about 2^27
> buckets:
> 
> net/openvswitch/flow_table.c:flow_key_insert() {
>     ...
> 	if (table->count > ti->n_buckets)
> 		new_ti = table_instance_expand(ti, false);
> 	else if (time_after(jiffies, table->last_rehash + REHASH_INTERVAL))
> 		new_ti = table_instance_rehash(ti, ti->n_buckets, false);
>     ...
> }
> 
> The table never gets smaller in normal use:
> 
>   - ovs_flow_tbl_remove() never shrinks it.
>   - The periodic rehash keeps the same size.
>   - Only ovs_flow_tbl_flush() goes back to TBL_MIN_BUCKETS.
> 
> OVS_DP_CMD_NEW and OVS_FLOW_CMD_NEW/DEL only need GENL_UNS_ADMIN_PERM. The
> dump needs no privilege at all:
> 
> net/openvswitch/datapath.c:dp_flow_genl_ops[] {
>     ...
> 	{ .cmd = OVS_FLOW_CMD_GET,
> 	  .validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
> 	  .flags = 0,		    /* OK for unprivileged users. */
> 	  .doit = ovs_flow_cmd_get,
> 	  .dumpit = ovs_flow_cmd_dump
> 	},
>     ...
> }
> 
> Root in an unprivileged user+net namespace could do the following:
> 
>   1. Create a datapath.
>   2. Insert N flows so that n_buckets grows to between N and 2N.
>   3. Delete every flow except one in a high bucket.
>   4. Run the dump repeatedly from threads pinned to each CPU.
> 
> Each dump could then walk up to 1 GB of hlist_heads.

I don't think this is a concern, as the user will have to allocate
hundreds of GBs of flows in the first place before freeing them,
which is likely a larger problem.

> During that walk,
> NET_RX, timers, tasklets and RCU callbacks are all deferred on that CPU. On
> CONFIG_PREEMPT (non-RT) kernels, the walk also can't be preempted.
> 
> Before this patch, softirqs could still run on hardirq exit during the walk,
> and PREEMPT_RCU kernels could preempt it. On PREEMPT_NONE/VOLUNTARY kernels
> the walk was already non-preemptible under rcu_read_lock(), so the only new
> cost there is the softirq deferral.
> 
> Container memcg limits don't cap how far the table can grow:
> 
>   - The sw_flow kmem_cache is created in ovs_flow_init() without
>     SLAB_ACCOUNT.
>   - The bucket array from table_instance_alloc() comes from unaccounted
>     kvmalloc memory.
I have a patch set in works to properly account memory towards the memcg
of the user.  That will cover this case.  However, it's likely a net-next
material as it changes how users need to manage their memory.

Best regards, Ilya Maximets.

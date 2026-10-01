Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D022FD696;
	Thu,  1 Oct 2026 22:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790893665; cv=none; b=NnWEFJmNxHxbGzOwaWKEZA0vHpZw7H+A2J/Fg5GnFeCEuNyaYOnd+WEJ7PeFC8RUWlqYNErRk8psNEXgpL1IAe1v4E6hcyR3k0zklBfuUp5XRWCMQPdXpN6ClKUC6VeGZty9ZzL6UXoEIs0Wy82FOvYrjkLGx1Y/894nl5HCf7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790893665; c=relaxed/simple;
	bh=dc8klTJ2e9NSHPmnNcYIK7Rnuku66KpHNkUpgClzaWg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GnCc9W2pf72uzVv6YnZGyz1fEfug0Q3DAryUKJYOpweeRBCtjVwTgPXZ/ZWqJ3Bi+ZWn3swugCSV8wN0GinaUeM2CQ+QmlrYCJ2Jhm28pbo1b5mYAut+/lm/sFGJ60yQ03BDA7VM9dcU9uSkfVDFk9BXRbpnzmgbDYt9jgL5cP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHJbij1Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHJbij1Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 077EC1F000FF;
	Thu,  1 Oct 2026 22:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790893663;
	bh=P43Ypbud5VdnU1jIetJx+ByMyWZKFBVfi4v1I7f21yc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CHJbij1QRC6raLztwWuppFPGpkDIs9wr1uvRERSlrfYUBy037JuR5TcZ0+kGnz5VJ
	 8b49+RNRvAbu7qCNdKh4Txj1JbyB2ko34XxzFg1dqeeJO+6z6p9z+PakMxnsXY0uu5
	 liZzrHCK19q/qzXVrrhpWM+NXSSxGdvf42U/9s1zAod6fst64E/jLdtXMU5LG/OLbZ
	 1+UlIGlcHMcEzhwBYEwhGupgXglquUeLlYwI2KlTfptPzhZ53jxLmKZeiNzLZ+JbTt
	 q+wZSR+6VXRTXtqTMIVX/nKFk7NyzblvqIo4D+NfqXQs5E3QfhvHFWqGqI5y8qVX2a
	 OgJ7sZb5kgXTg==
Subject:
 Re: [PATCH net v3] openvswitch: fix soft lockup in the netlink flow dump
From: netdev-bot+sashiko@kernel.org
To: den@openvz.org
Cc: netdev@vger.kernel.org, dev@openvswitch.org, aconole@redhat.com,
 echaudro@redhat.com, i.maximets@ovn.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 stable@vger.kernel.org
Date: Thu, 01 Oct 2026 22:27:42 +0000
Message-ID: <179089366251.434549.18021554028626523205@kernel.org>
In-Reply-To: <20260929072519.2803304-2-den@openvz.org>
References: <20260929072519.2803304-2-den@openvz.org>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] ovs_flow_cmd_dump() (net/openvswitch/datapath.c) now holds BH
  disabled across the whole dump callback.

--

openvswitch: fix soft lockup in the netlink flow dump

This patch disables BH across the whole table walk in ovs_flow_cmd_dump().
The goal is to stop the per-CPU spin_unlock_bh() calls in
ovs_flow_stats_get() from running the softirq backlog in the dumping
thread's context. That backlog processing led to a soft lockup on a
heavily loaded compute node.

> diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
> index 631a03136fa14..4fc5d0bebd85e 100644
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

[ ... ]

> @@ -1552,6 +1558,8 @@ static int ovs_flow_cmd_dump(struct sk_buff *skb, struct netlink_callback *cb)
>  		cb->args[0] = bucket;
>  		cb->args[1] = obj;
>  	}
> +
> +	local_bh_enable();
>  	rcu_read_unlock();
>  	return skb->len;
>  }

[Severity: Medium]
Can a namespace user control how long this BH-off region lasts?

The region now covers the whole walk in ovs_flow_tbl_dump_next(). When
buckets are empty, that loop has no exit that depends on skb space:

net/openvswitch/flow_table.c:ovs_flow_tbl_dump_next() {
    ...
	while (*bucket < ti->n_buckets) {
		i = 0;
		head = &ti->buckets[*bucket];
		hlist_for_each_entry_rcu(flow, head, flow_table.node[ver]) {
		...
		}
		(*bucket)++;
		*last = 0;
	}
    ...
}

This means one callback can scan the entire bucket array with softirqs held
off.

The only cap on n_buckets is the kvmalloc limit, which allows about 2^27
buckets:

net/openvswitch/flow_table.c:flow_key_insert() {
    ...
	if (table->count > ti->n_buckets)
		new_ti = table_instance_expand(ti, false);
	else if (time_after(jiffies, table->last_rehash + REHASH_INTERVAL))
		new_ti = table_instance_rehash(ti, ti->n_buckets, false);
    ...
}

The table never gets smaller in normal use:

  - ovs_flow_tbl_remove() never shrinks it.
  - The periodic rehash keeps the same size.
  - Only ovs_flow_tbl_flush() goes back to TBL_MIN_BUCKETS.

OVS_DP_CMD_NEW and OVS_FLOW_CMD_NEW/DEL only need GENL_UNS_ADMIN_PERM. The
dump needs no privilege at all:

net/openvswitch/datapath.c:dp_flow_genl_ops[] {
    ...
	{ .cmd = OVS_FLOW_CMD_GET,
	  .validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
	  .flags = 0,		    /* OK for unprivileged users. */
	  .doit = ovs_flow_cmd_get,
	  .dumpit = ovs_flow_cmd_dump
	},
    ...
}

Root in an unprivileged user+net namespace could do the following:

  1. Create a datapath.
  2. Insert N flows so that n_buckets grows to between N and 2N.
  3. Delete every flow except one in a high bucket.
  4. Run the dump repeatedly from threads pinned to each CPU.

Each dump could then walk up to 1 GB of hlist_heads. During that walk,
NET_RX, timers, tasklets and RCU callbacks are all deferred on that CPU. On
CONFIG_PREEMPT (non-RT) kernels, the walk also can't be preempted.

Before this patch, softirqs could still run on hardirq exit during the walk,
and PREEMPT_RCU kernels could preempt it. On PREEMPT_NONE/VOLUNTARY kernels
the walk was already non-preemptible under rcu_read_lock(), so the only new
cost there is the softirq deferral.

Container memcg limits don't cap how far the table can grow:

  - The sw_flow kmem_cache is created in ovs_flow_init() without
    SLAB_ACCOUNT.
  - The bucket array from table_instance_alloc() comes from unaccounted
    kvmalloc memory.

The commit message says:

    The region stays short: the skb caps the flows one callback emits, and
    empty buckets cost no skb space but are each visited once per dump, as
    the cursor only moves forward. The table grows on insert and shrinks
    only on flush, so the walk is bounded by the largest flow count the
    datapath has held.

That bound is real, but a namespace user chooses it. Is "stays short"
accurate here?

Two ways to keep the soft lockup fix without an unbounded BH-off window:

  - Stop after a fixed number of buckets per callback and resume from
    cb->args.
  - Re-enable and disable BH after each batch of buckets.

Would either of these work?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260929072519.2803304-2-den%40openvz.org

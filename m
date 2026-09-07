Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B26831B130;
	Mon,  7 Sep 2026 04:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788754959; cv=none; b=j3Iuql3i9saMqNUYQomnNut/gXXmo6wFzhkbXGdnLllkZYCl+yivMTQiCRBKnbL43EnYa96P1W1hXNJkIE+uRPeCbFoUQYlURf9DeIu1d4uQH5AvxPse9w6GL13WY5uH4Cw8Bqd6E+x/NxGWkhAnHt25uY6j30NMVHExKbG+q48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788754959; c=relaxed/simple;
	bh=sJLJj9CDwIEk6rzRFvDvLLlO3kWwH141Q6dk7gvUE7E=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kGBKb1FzlI9XOubceSaY0Jy+e0O9JkuhDLqjES8mqQYg7WBlZbED4NSE6NNrICNKoDHn3gI29xXRvh5yniW05gOZu9dcVjuvQktP2dmU7GRwYaDsqBlh8WTOls+KtZYRfJ3rqnM96s7aoBlcJ24QlNBvKLrf6XnbKJRaYaeHQik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y4X0EHj/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y4X0EHj/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18BB31F00A3F;
	Mon,  7 Sep 2026 04:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788754957;
	bh=F94B4Jhd5gxh36HpPdbEWCLz/XKv9H/Kg8yWGQaHx20=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Y4X0EHj/4zTEBUeWbGE98Qfxbkner3q3YbGDwSFTt2K9IJNnwX+9easSYRW1yWZ5W
	 oS2NgakrsF7xX3bvh179M7Az1YZSkAP+wCX/rljz4T1cNI0uT9xJykjLBCCi8eA7fv
	 1tdgo0KmAAvqupenaqS4xAs2+Snfo9B6jZ6nas5n1rGFBb1L5LFKQIowu0wkxrB/K2
	 jMdmf41CIe6GCFfqmlYMoIafugu77ncug0pQf+NUf+P1tMcb8VSvXObOH38+fYvdpf
	 +UFibHsodpqP0HGk0KK2u7pBnVR+V7xTxA3U2Rjj7xmJ7imeWygB5KX41kgGmyO9hY
	 duHYgJpypE8Iw==
Subject: Re: [PATCH net v2 2/2] mptcp: diag: bound listener bucket lock hold
From: netdev-bot+sashiko@kernel.org
To: zihanx@nebusec.ai
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 mptcp@lists.linux.dev, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ncardwell@google.com,
 kuniyu@google.com, matttbe@kernel.org, martineau@kernel.org,
 geliang@kernel.org, gnault@redhat.com, fw@strlen.de, stable@vger.kernel.org,
 vega@nebusec.ai
Date: Mon, 07 Sep 2026 04:22:35 +0000
Message-ID: <178875495568.219967.11621753663025675535@kernel.org>
In-Reply-To:
 <db1f34ca8461c7b0dc5ec504ea1b99c24b909e34.1788248601.git.zihanx@nebusec.ai>
References:
 <db1f34ca8461c7b0dc5ec504ea1b99c24b909e34.1788248601.git.zihanx@nebusec.ai>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 3 · Low: 2

- [High] Use-after-free introduced by the new deferred processing loop in
  mptcp_diag_dump_listeners().
- [Medium] The patch silently changes which MPTCP listeners the dump
  reports, and the commit message does not mention it.
- [Medium] mptcp_diag_dump_listeners() mixes two incompatible counting
  bases for the resume index diag_ctx->l_num.
- [Medium] mptcp_diag_dump_listeners() performs all
  identity/authorization checks on the parent MPTCP socket…
- [Low] Commit message of "mptcp: diag: bound listener bucket lock hold"
  carries Fixes: 4fa39b701ce9 + Cc: stable + Reported-by:, but never…
- [Low] In the new post-lock loop of mptcp_diag_dump_listeners()
  (net/mptcp/mptcp_diag.c), `tmp = ctx ?

--

mptcp: diag: bound listener bucket lock hold

This reworks mptcp_diag_dump_listeners() so that the listener bucket lock is
only held while collecting up to MPTCP_DIAG_BULK_SZ referenced listener
sockets, with the ULP/property re-checks, the parent msk reference and
sk_diag_dump() moved outside the lock.  A referenced dump cursor is kept in
cb->data so later batches resume after the previous listener instead of
rescanning the bucket prefix.

v1 Link: https://lore.kernel.org/all/cover.1785307984.git.zihanx@nebusec.ai/

> diff --git a/include/linux/inet_diag.h b/include/linux/inet_diag.h
> index 6ccd32bc48f91..4859e77a28c7a 100644
> --- a/include/linux/inet_diag.h
> +++ b/include/linux/inet_diag.h
> @@ -39,6 +39,7 @@ enum inet_diag_dump_cursor_type {
>  	INET_DIAG_DUMP_CURSOR_TCP_LISTEN,
>  	INET_DIAG_DUMP_CURSOR_TCP_BIND,
>  	INET_DIAG_DUMP_CURSOR_TCP_EHASH,
> +	INET_DIAG_DUMP_CURSOR_MPTCP_LISTEN,
>  };

[Severity: Low]
Two questions about the changelog for this one.

First, the message says the lock hold time "can therefore grow with the
number of sockets visited", but it never states the observed symptom.  Was
this a soft lockup, an RCU stall, or measured contention on ilb->lock?  Given
the Fixes: 4fa39b701ce9 and Cc: stable tags plus the Reported-by:, could the
symptom be spelled out?

Second, could the backport dependency be mentioned?  enum
inet_diag_dump_cursor_type does not exist in the tree this applies on top of:

  git grep inet_diag_dump_cursor_type <base>   -> no match

The whole enum, cb_data->dump_cursor, dump_cursor_slot, dump_cursor_type and
inet_diag_dump_clear_cursor() come from the immediately preceding patch of
this series, "tcp: diag: bound bucket lock hold in tcp_diag_dump()".  Stable
trees carrying 4fa39b701ce9 cannot take this patch on its own, and nothing in
the message says so.

> diff --git a/net/mptcp/mptcp_diag.c b/net/mptcp/mptcp_diag.c
> index 136c2d05c0eeb..37b33ea5d79de 100644
> --- a/net/mptcp/mptcp_diag.c
> +++ b/net/mptcp/mptcp_diag.c
> @@ -12,6 +12,19 @@
>  #include <net/netlink.h>
>  #include "protocol.h"
>  
> +/* Process a bounded number of listeners per bucket lock hold. */
> +#define MPTCP_DIAG_BULK_SZ 16
> +
> +static void mptcp_diag_save_cursor(struct inet_diag_dump_data *cb_data,
> +				   unsigned int slot, struct sock *sk)
> +{
> +	sock_hold(sk);
> +	inet_diag_dump_clear_cursor(cb_data);
> +	cb_data->dump_cursor = sk;
> +	cb_data->dump_cursor_slot = slot;
> +	cb_data->dump_cursor_type = INET_DIAG_DUMP_CURSOR_MPTCP_LISTEN;
> +}
> +

[ ... ]

> @@ -84,64 +98,102 @@ static void mptcp_diag_dump_listeners(struct sk_buff *skb, struct netlink_callba
>  	hinfo = net->ipv4.tcp_death_row.hashinfo;
>  
>  	for (i = diag_ctx->l_slot; i <= hinfo->lhash2_mask; i++) {
> +		struct sock *tmp, *sk, *sk_arr[MPTCP_DIAG_BULK_SZ];
>  		struct inet_listen_hashbucket *ilb;
> +		int num_arr[MPTCP_DIAG_BULK_SZ];
>  		struct hlist_nulls_node *node;
> -		struct sock *sk;
> -		int num = 0;
> +		int accum, idx, num, ret;
> +		struct sock *cursor;
> +		bool use_cursor;
>  
> +resume_listen_walk:
> +		num = 0;
> +		accum = 0;
>  		ilb = &hinfo->lhash2[i];
> +		ret = 0;
>  
>  		rcu_read_lock();
>  		spin_lock(&ilb->lock);
> -		sk_nulls_for_each(sk, node, &ilb->nulls_head) {
> -			const struct mptcp_subflow_context *ctx = mptcp_subflow_ctx(sk);
> -			struct inet_sock *inet = inet_sk(sk);
> -			int ret;
> -
> -			if (num < diag_ctx->l_num)
> -				goto next_listen;
> -
> -			if (!ctx || strcmp(inet_csk(sk)->icsk_ulp_ops->name, "mptcp"))
> -				goto next_listen;
> -
> -			sk = ctx->conn;
> -			if (!sk || !net_eq(sock_net(sk), net))
> -				goto next_listen;
> -
> -			if (r->sdiag_family != AF_UNSPEC &&
> -			    sk->sk_family != r->sdiag_family)
> -				goto next_listen;
> -
> -			if (r->id.idiag_sport != inet->inet_sport &&
> -			    r->id.idiag_sport)
> +		cursor = cb_data->dump_cursor;
> +		use_cursor = cursor &&
> +			     cb_data->dump_cursor_type ==
> +			     INET_DIAG_DUMP_CURSOR_MPTCP_LISTEN &&
> +			     cb_data->dump_cursor_slot == i &&
> +			     inet_sk_state_load(cursor) == TCP_LISTEN &&
> +			     !hlist_nulls_unhashed(&cursor->sk_nulls_node) &&
> +			     cursor->sk_nulls_node.pprev != LIST_POISON2 &&
> +			     inet_lhash2_bucket_sk(hinfo, cursor) == ilb;
> +		node = use_cursor ? cursor->sk_nulls_node.next :
> +				    ilb->nulls_head.first;
> +		hlist_nulls_for_each_entry_from(sk, node, sk_nulls_node) {
> +			if (!use_cursor && num < diag_ctx->l_num)
>  				goto next_listen;

[Severity: Medium]
Are the two resume mechanisms here using the same counting base for
diag_ctx->l_num?

This test counts entries from the bucket head, but at resume_listen_walk num
is reset to 0 and, when use_cursor is true, the walk starts at
cursor->sk_nulls_node.next, i.e. mid-bucket.  The values stashed in num_arr[]
and later stored are therefore cursor-relative and bounded by 0..15:

	if (ret >= 0) {
		ret = sk_diag_dump(tmp, skb, cb, r, net_admin);
		if (ret < 0)
			num = num_arr[idx];
	}
	...
	if (ret < 0) {
		diag_ctx->l_slot = i;
		diag_ctx->l_num = num;
		return;
	}

Walking a bucket with more than 16 matching listeners:

  batch 1: 16 listeners dumped, cursor saved on e15
  goto resume_listen_walk with diag_ctx->l_num = 0, use_cursor true, so num
    now counts from e16
  skb fills at idx 5, so diag_ctx->l_num = 5 while the real bucket offset
    is 21
  the cursor socket is closed before the next recvmsg(), use_cursor becomes
    false, and the walk resumes at bucket position 5

Does that re-emit e5..e19, and, if entries were removed in the meantime and
positions shifted, silently drop listeners that were never reported?

The peer implementation of the same cursor protocol from the preceding patch,
tcp_diag_dump(), zeroes the positional counter when the cursor is unusable:

	node = use_cursor ? cursor->sk_nulls_node.next : ilb->nulls_head.first;
	if (!use_cursor)
		s_num = 0;

Should mptcp_diag_dump_listeners() do the same so the two bases are never
mixed?  The intra-call restart also forces diag_ctx->l_num = 0 before goto
resume_listen_walk, so a cursor invalidated between lock drops restarts the
bucket at the head within a single dump call.

>  			if (!refcount_inc_not_zero(&sk->sk_refcnt))
>  				goto next_listen;
>  
> -			ret = sk_diag_dump(sk, skb, cb, r, net_admin);
> -
> -			sock_put(sk);
> -
> -			if (ret < 0) {
> -				spin_unlock(&ilb->lock);
> -				rcu_read_unlock();
> -				diag_ctx->l_slot = i;
> -				diag_ctx->l_num = num;
> -				return;
> -			}
> -			diag_ctx->l_num = num + 1;
> -			num = 0;

[Severity: Medium]
Removing this "l_num = num + 1; num = 0;" pair changes which listeners the
dump reports, and the changelog does not mention it.

In the pre-patch loop the skip test was "if (num < diag_ctx->l_num)" while
num was reset to 0 after every successful dump and l_num kept growing, so for
a bucket e0..e6 the emitted set was e0, e1, e3, e6:

  e0 dumped -> l_num = 1, num = 0 then ++num = 1
  e1 dumped -> l_num = 2, num = 1
  e2 hits 1 < 2 and is skipped
  e3 dumped -> l_num = 3
  e4, e5 skipped

The new code keeps num monotonic and applies the skip test only in the
non-cursor fallback, so every collected listener is processed.  Is that the
actual user-visible defect being fixed here?  ss -Ml output changes (more
listeners reported) on any host with three or more MPTCP listeners hashing
into the same lhash2 bucket, and this seems worth stating in the message,
along with whether it belongs in the same patch as the lock-hold change.

> +			num_arr[accum] = num;
> +			sk_arr[accum] = sk;
> +			if (++accum == MPTCP_DIAG_BULK_SZ)
> +				break;
>  next_listen:
>  			++num;
>  		}
>  		spin_unlock(&ilb->lock);
>  		rcu_read_unlock();
>  
> +		for (idx = 0; idx < accum; idx++) {
> +			const struct mptcp_subflow_context *ctx;
> +			const struct tcp_ulp_ops *ulp_ops;
> +			struct inet_sock *inet;
> +
> +			sk = sk_arr[idx];
> +			rcu_read_lock();
> +			ctx = rcu_dereference(inet_csk(sk)->icsk_ulp_data);
> +			ulp_ops = READ_ONCE(inet_csk(sk)->icsk_ulp_ops);
> +			inet = inet_sk(sk);
> +			tmp = ctx ? ctx->conn : NULL;

[Severity: High]
Can this read freed memory?  The rcu_read_lock() here is entered after
spin_unlock(&ilb->lock) and rcu_read_unlock() above, so it cannot extend a
grace period that already started.

The collection loop only took sk_refcnt on the listener subflow, which does
not keep the ULP context alive:

  __tcp_close()
    tcp_set_state(sk, TCP_CLOSE)
    inet_unhash(sk)               /* takes ilb->lock, free once diag drops it */
    inet_csk_destroy_sock()
      sk->sk_prot->destroy(sk)
        tcp_v4_destroy_sock()
          tcp_cleanup_ulp()
            subflow_ulp_release()

and net/mptcp/subflow.c:subflow_ulp_release() drops the msk reference and
frees the context:

	sk = ctx->conn;
	if (sk) {
		...
		sock_put(sk);
	}
	mptcp_subflow_ops_undo_override(ssk);
	if (release)
		kfree_rcu(ctx, rcu);

net/ipv4/tcp_ulp.c:tcp_cleanup_ulp() clears only icsk_ulp_ops:

	if (icsk->icsk_ulp_ops->release)
		icsk->icsk_ulp_ops->release(sk);
	module_put(icsk->icsk_ulp_ops->owner);

	icsk->icsk_ulp_ops = NULL;

icsk_ulp_data is never unpublished on this path (subflow_ulp_fallback() does
rcu_assign_pointer(icsk->icsk_ulp_data, NULL), this path does not).  If
kfree_rcu(ctx) was queued before this loop iteration re-entered
rcu_read_lock(), the grace period does not cover this reader, so
rcu_dereference(inet_csk(sk)->icsk_ulp_data) can return a freed and reused
slab object, and ctx->conn is dereferenced before the !ulp_ops guard is even
evaluated.

The loop is also preemptible for up to 15 preceding sk_diag_dump() /
inet_diag_bc_sk() invocations with request-supplied bytecode, which widens the
window.  Does the commit message claim ("After dropping the lock, read
icsk_ulp_data with rcu_dereference()") hold here, or do ctx and the parent msk
reference have to be acquired while ilb->lock is still held, as the pre-patch
code did?

[Severity: Low]
Separately, is it intentional that ctx->conn is loaded before the check that
the ULP is actually "mptcp"?  The collection loop under ilb->lock no longer
filters by ULP at all, so listeners with a foreign ULP context now reach this
loop, and the read happens at offsetof(struct mptcp_subflow_context, conn)
inside an object of an unrelated type.

net/xfrm/espintcp.c:espintcp_init_sk() publishes its own object with
rcu_assign_pointer(icsk->icsk_ulp_data, ctx) and, unlike tls_init(), has no
TCP-state restriction, so an unprivileged setsockopt(TCP_ULP, "espintcp")
followed by listen() puts such a socket into lhash2.

struct espintcp_ctx is larger than that offset today, so the read stays inside
the allocation and the loaded value is discarded by the failing strcmp().
Still, the pre-patch code did the strcmp() first and never touched a foreign
context.  Could the ctx->conn load be moved after the ULP name check?

> +			if (!ctx || !ulp_ops || strcmp(ulp_ops->name, "mptcp") ||
> +			    !tmp || !net_eq(sock_net(tmp), net) ||
> +			    (r->sdiag_family != AF_UNSPEC &&
> +			     tmp->sk_family != r->sdiag_family) ||
> +			    (r->id.idiag_sport != inet->inet_sport &&
> +			     r->id.idiag_sport) ||
> +			    !refcount_inc_not_zero(&tmp->sk_refcnt)) {
> +				rcu_read_unlock();
> +				goto processed_listener_sk;
> +			}
> +			rcu_read_unlock();
> +			if (ret >= 0) {
> +				ret = sk_diag_dump(tmp, skb, cb, r, net_admin);
> +				if (ret < 0)
> +					num = num_arr[idx];
> +			}
> +			sock_put(tmp);

[Severity: Medium]
Does this need a re-validation after refcount_inc_not_zero(&tmp->sk_refcnt)?

All the identity and scoping checks on the parent msk (net_eq(sock_net(tmp),
net), sdiag_family, idiag_sport) run before the reference is taken, and
nothing is re-checked afterwards.  mptcp_prot uses SLAB_TYPESAFE_BY_RCU:

net/mptcp/protocol.c:
	.slab_flags	= SLAB_TYPESAFE_BY_RCU,

so rcu_read_lock() only guarantees type stability, not identity.  If
subflow_ulp_release() already dropped the last reference via
sock_put(ctx->conn), the object can be recycled as a different MPTCP socket
inside this reader's RCU section, refcount_inc_not_zero() then succeeds, and
sk_diag_dump(tmp, ...) serializes that socket's addresses, ports, uid, cookie
and state into the reply, possibly from another namespace.

The in-tree pattern for this slab, net/mptcp/token.c:mptcp_token_get_sock(),
re-checks after the acquisition:

	if (!refcount_inc_not_zero(&sk->sk_refcnt))
		goto not_found;

	if (READ_ONCE(msk->token) != token ||
	    !net_eq(sock_net(sk), net)) {

Should the same re-check be done here?  Pre-patch the conn read and the msk
refcount acquisition both happened under ilb->lock with the subflow still
hashed, so the reference held by ctx was still alive.

> +processed_listener_sk:
> +			if (ret >= 0)
> +				mptcp_diag_save_cursor(cb_data, i, sk);
> +			sock_put(sk);
> +		}
> +
> +		if (ret < 0) {
> +			diag_ctx->l_slot = i;
> +			diag_ctx->l_num = num;
> +			return;
> +		}
> +
>  		cond_resched();
> +
> +		if (accum == MPTCP_DIAG_BULK_SZ) {
> +			diag_ctx->l_num = 0;
> +			goto resume_listen_walk;
> +		}
> +
> +		inet_diag_dump_clear_cursor(cb_data);
>  		diag_ctx->l_num = 0;
>  	}
>  
> +	inet_diag_dump_clear_cursor(cb_data);
>  	diag_ctx->l_num = 0;
>  	diag_ctx->l_slot = i;
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1788248601.git.zihanx%40nebusec.ai

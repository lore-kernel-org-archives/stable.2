Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD91130BB8A;
	Mon,  7 Sep 2026 04:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788754957; cv=none; b=YbmJsfB/P58Q2uKR9nFubTqPoR3w4NeR+tr0DpBOivuop85KzQJrbPoblff7KBq5B00slHtnWBCFi6KJPVPPp5NlgBjO94sNP/94o/5r9nh6RP9NiYpBt7FhDA1T++FbyomWtmnGm62ZBdjsMaodBLR3IDbhptfVs2Qkmt2mkco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788754957; c=relaxed/simple;
	bh=CwWi8liQaWwljjLCPomMdTzXZZWGU/sFhbewDH88CWE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s9a8/AfXjlQCePGT8vMrPhZhVear4bJM79oTgyHeeFtGsMfyQujMC7pZnA7hhKJpwItLVnHyx0CZvQI150D1AFurs4yY4NWLS2buN7nvOhgXs5fkm/zz2aMikIw6d8LVbYkA5WmbN036g2aNBtJ90AcBc7s1RK0582vqO84/0bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eDnZbNwe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eDnZbNwe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D51B1F00A3A;
	Mon,  7 Sep 2026 04:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788754955;
	bh=6wJRkOL0ldfiOUfQJIThs3qaiWc8EOmFNkFFYLr9YXE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=eDnZbNweAPnhQOuh0hrCDj18qcXg+gvkrP/sQlqu+J6DPDMSLWvr4Zmzu5VoQCAUk
	 +VLY5Ap3v0Xvg3Ry1Yn8SfMMuUVDum5xWA8IHBP1C4PJvEM/X4JYaSSWKzK7RTA8oT
	 d7/Y8ieva6ZoRoA3txog2BZiqH41qMj1W6WwRN8OhABe7LNzCxpWsaeLxSUNAXa1nN
	 f4cRNUOHaDYNA1DjsOnRMtXarlON10CniWDTCMhrCxUgG7Jvvvj3aJ5WDRTsI9Sscc
	 5BMsbJUn5A5p7aID7YcYrB7h62iZlsOQ83RnnzSxbfVWC9DoOtKM71L7uV5sW6GPSK
	 PaJW3koAi3AwA==
Subject:
 Re: [PATCH net v2 1/2] tcp: diag: bound bucket lock hold in tcp_diag_dump()
From: netdev-bot+sashiko@kernel.org
To: zihanx@nebusec.ai
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 mptcp@lists.linux.dev, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ncardwell@google.com,
 kuniyu@google.com, matttbe@kernel.org, martineau@kernel.org,
 geliang@kernel.org, gnault@redhat.com, fw@strlen.de, stable@vger.kernel.org,
 vega@nebusec.ai
Date: Mon, 07 Sep 2026 04:22:34 +0000
Message-ID: <178875495405.219967.5594821749566554418@kernel.org>
In-Reply-To:
 <cdc628415cf10721480a51ce14837f846ec778c2.1788248601.git.zihanx@nebusec.ai>
References:
 <cdc628415cf10721480a51ce14837f846ec778c2.1788248601.git.zihanx@nebusec.ai>
X-sashiko-severity: Critical
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

Critical: 2 · High: 1 · Medium: 2 · Low: 1

- [Critical] Use-after-free / wild-pointer traversal: the new bind-hash
  dump cursor revalidation in tcp_diag_dump() cannot detect that the…
- [Critical] Refcount initialization race: tcp_diag_bind_collect_sock()
  calls sock_hold() unconditionally on every node of tb2->owners,…
- [High] Loss of dump forward progress and duplicate output: the patch
  deletes every positional (`s_num`) resume path in tcp_diag_dump()…
- [Medium] Lockless, unordered reads of cursor state: the listen and
  ehash cursor validations establish "this socket is in the bucket I…
- [Medium] The commit message mischaracterizes the pre-existing defect.
- [Low] Concern that the sibling MPTCP listener dump
  (mptcp_diag_dump_listeners()) keeps evaluating request-supplied…

--

tcp: diag: bound bucket lock hold in tcp_diag_dump()

This reworks the three tcp_diag_dump() hash walks so that only referenced
sockets are collected under each bucket lock, and moves the family/port
filters, inet_diag_bc_sk() bytecode evaluation and the fill work outside the
critical section.  A referenced dump cursor is added to
struct inet_diag_dump_data so a following batch resumes after the previously
reported socket, with per-table validation of the cursor.

v1 Link: https://lore.kernel.org/all/cover.1785307984.git.zihanx@nebusec.ai/

>     inet_diag dumps run request-supplied bytecode through inet_diag_bc_sk().
>     tcp_diag_dump() currently evaluates socket filters and fills replies while
>     holding the listener, bind, and ehash bucket locks.

[Severity: Medium]
Is this description accurate for all three tables?

At the baseline (544d85de4dc2) only the listener walk fills replies under
ilb->lock.  The bind walk already collected at most SKARR_SZ = 16 referenced
sockets under spin_lock_bh(&ibb->lock) and only called inet_sk_diag_fill()
after the lock was dropped:

	pause_bind_walk:
			spin_unlock_bh(&ibb->lock);

			res = 0;
			for (idx = 0; idx < accum; idx++) {
				if (res >= 0) {
					res = inet_sk_diag_fill(sk_arr[idx],
								NULL, skb, cb,
								r, NLM_F_MULTI,
								net_admin);

The ehash walk did the same with sk_diag_fill() after spin_unlock_bh(lock).
What remained under the bind and ehash locks was inet_diag_bc_sk() plus the
cheap family/port comparisons, bounded to 16 sockets per lock hold.

Could the changelog be narrowed to the listener walk, or state explicitly
what part of the bind/ehash work it is moving out?

> diff --git a/include/linux/inet_diag.h b/include/linux/inet_diag.h
> index 704fd415c2b49..6ccd32bc48f91 100644
> --- a/include/linux/inet_diag.h
> +++ b/include/linux/inet_diag.h

[ ... ]

> @@ -32,12 +33,23 @@ struct inet_diag_handler {
>  };
>  
>  struct bpf_sk_storage_diag;
> +
> +enum inet_diag_dump_cursor_type {
> +	INET_DIAG_DUMP_CURSOR_NONE,
> +	INET_DIAG_DUMP_CURSOR_TCP_LISTEN,
> +	INET_DIAG_DUMP_CURSOR_TCP_BIND,
> +	INET_DIAG_DUMP_CURSOR_TCP_EHASH,
> +};
> +

[Severity: Low]
This isn't a bug, but a note for backporters.  The sibling MPTCP listener
dump mptcp_diag_dump_listeners() is converted by the follow-up patch in this
series (INET_DIAG_DUMP_CURSOR_MPTCP_LISTEN, which is why the enum slot and
the exported inet_diag_dump_clear_cursor() appear here), so at the tip of the
series the MPTCP listener walk also drops ilb->lock before calling
sk_diag_dump()/inet_diag_bc_sk().

This patch is Cc: stable, and the commit message body does not mention that
the MPTCP listener walk keeps running request-supplied bytecode under the
same hashinfo->lhash2 bucket lock until the follow-up patch is applied.  Only
the v2 changelog, which is stripped on apply, mentions "Left
INET_DIAG_DUMP_CURSOR_MPTCP_LISTEN to the MPTCP patch".  Could that
dependency be stated in the commit message?

[ ... ]

> diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
> index 6e2fe186d0dcb..d95639ac70c67 100644
> --- a/include/net/inet_hashtables.h
> +++ b/include/net/inet_hashtables.h
> @@ -188,6 +188,24 @@ inet_lhash2_bucket(struct inet_hashinfo *h, u32 hash)
>  	return &h->lhash2[hash & h->lhash2_mask];
>  }
>  
> +static inline struct inet_listen_hashbucket *
> +inet_lhash2_bucket_sk(struct inet_hashinfo *h, struct sock *sk)
> +{
> +	u32 hash;
> +
> +#if IS_ENABLED(CONFIG_IPV6)
> +	if (sk->sk_family == AF_INET6)
> +		hash = ipv6_portaddr_hash(sock_net(sk),
> +					  &sk->sk_v6_rcv_saddr,
> +					  inet_sk(sk)->inet_num);
> +	else
> +#endif
> +		hash = ipv4_portaddr_hash(sock_net(sk),
> +					  inet_sk(sk)->inet_rcv_saddr,
> +					  inet_sk(sk)->inet_num);
> +	return inet_lhash2_bucket(h, hash);
> +}
> +

[ ... ]

> diff --git a/net/ipv4/tcp_diag.c b/net/ipv4/tcp_diag.c
> index ba1fdbe9807fd..842e13ee79e5b 100644
> --- a/net/ipv4/tcp_diag.c
> +++ b/net/ipv4/tcp_diag.c
> @@ -285,6 +285,73 @@ static int sk_diag_fill(struct sock *sk, struct sk_buff *skb,
>  				 net_admin);
>  }
>  

[ ... ]

> +static struct inet_bind2_bucket *tcp_diag_sk_bind2(const struct sock *sk)
> +{
> +	if (sk->sk_state == TCP_TIME_WAIT)
> +		return inet_twsk(sk)->tw_tb2;
> +
> +	return inet_csk(sk)->icsk_bind2_hash;
> +}
> +
> +static bool tcp_diag_bind_collect_sock(struct sock *sk, struct sock **sk_arr,
> +				       int *num_arr, int *accum, int num)
> +{
> +	sock_hold(sk);
> +	num_arr[*accum] = num;
> +	sk_arr[*accum] = sk;
> +
> +	return ++*accum == SKARR_SZ;
> +}
> +
> +static bool tcp_diag_bind_collect_owners(struct hlist_head *owners,
> +					 struct sock **sk_arr, int *num_arr,
> +					 int *accum, int *num, int s_num)
> +{
> +	struct sock *sk;
> +
> +	sk_for_each_bound(sk, owners) {
> +		if (*num < s_num) {
> +			(*num)++;
> +			continue;
> +		}
> +
> +		if (tcp_diag_bind_collect_sock(sk, sk_arr, num_arr, accum, *num))
> +			return true;
> +		(*num)++;
> +	}
> +
> +	return false;
> +}

[Severity: Critical]
Can the unconditional sock_hold() in tcp_diag_bind_collect_sock() hit a
TIME_WAIT socket whose tw_refcnt is still 0?

The changelog says "Bind collection counts TIME_WAIT nodes toward the batch
limit", and tcp_diag_bind_collect_owners() no longer filters on
sk->sk_state != TCP_CLOSE before taking the reference, so every node of
tb2->owners now gets a refcount_inc().

inet_twsk_alloc() starts the object at zero on purpose:

	/*
	 * Because we use RCU lookups, we should not set tw_refcnt
	 * to a non null value before everything is setup for this
	 * timewait socket.
	 */
	refcount_set(&tw->tw_refcnt, 0);

and inet_twsk_hashdance_schedule() publishes it into the bind owners list and
drops both bind locks before initializing the count:

	sk_add_bind_node((struct sock *)tw, &tw->tw_tb2->owners);

	spin_unlock(&bhead2->lock);
	spin_unlock(&bhead->lock);

	spin_lock(lock);

	refcount_set(&tw->tw_refcnt, 3);

A dumper blocked on bhead2->lock acquires it right after that unlock and
immediately walks tb2->owners, so it can observe the published tw with
tw_refcnt == 0.  sock_hold() then calls refcount_inc() on zero, which trips
refcount_warn_saturate() and leaves the counter saturated, after which
refcount_set(&tw->tw_refcnt, 3) discards the dump's reference.  The later
sock_gen_put() from the fill loop then consumes one of the three structural
references (bhash, ehash, timer).

Would using refcount_inc_not_zero() here, or keeping the TCP_CLOSE check
under the lock, be safer?

> @@ -335,8 +402,15 @@ static void tcp_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
>  		for (i = s_i; i <= hashinfo->lhash2_mask; i++) {
>  			struct inet_listen_hashbucket *ilb;
>  			struct hlist_nulls_node *node;
> +			struct sock *sk_arr[SKARR_SZ];
> +			int num_arr[SKARR_SZ];
> +			struct sock *cursor;
> +			int idx, accum, res;
> +			bool use_cursor;
>  
> +resume_listen_walk:
>  			num = 0;
> +			accum = 0;
>  			ilb = &hashinfo->lhash2[i];
>  
>  			if (hlist_nulls_empty(&ilb->nulls_head)) {
> @@ -344,52 +418,81 @@ static void tcp_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
>  				continue;
>  			}
>  			spin_lock(&ilb->lock);
> -			sk_nulls_for_each(sk, node, &ilb->nulls_head) {
> -				struct inet_sock *inet = inet_sk(sk);
> +			cursor = cb_data->dump_cursor;
> +			use_cursor = cursor &&
> +				     cb_data->dump_cursor_type ==
> +				     INET_DIAG_DUMP_CURSOR_TCP_LISTEN &&
> +				     cb_data->dump_cursor_slot == i &&
> +				     inet_sk_state_load(cursor) == TCP_LISTEN &&
> +				     !hlist_nulls_unhashed(&cursor->sk_nulls_node) &&
> +				     cursor->sk_nulls_node.pprev != LIST_POISON2 &&
> +				     inet_lhash2_bucket_sk(hashinfo, cursor) == ilb;
> +			node = use_cursor ? cursor->sk_nulls_node.next :
> +					    ilb->nulls_head.first;

[Severity: Medium]
Is the "cursor is still in this bucket" conclusion sound when every input to
it is read without the lock that publishes it?

In the listener path the recomputation uses sock_net(cursor),
sk_v6_rcv_saddr (a 16-byte non-atomic read) and inet_sk(cursor)->inet_num via
the newly exported inet_lhash2_bucket_sk(), none of which is protected by
ilb->lock, and the pprev test and the bucket computation are separate plain
loads with no barrier between them.

The ehash variant later in this function has the same shape with
cursor->sk_nulls_node.pprev followed by cursor->sk_hash.  The insertion side
sets sk->sk_hash before taking the target bucket lock and linking with
__sk_nulls_add_node_rcu(), and inet_csk_listen_start() stores TCP_LISTEN
before hashing into lhash2, so a reader that observes the new linkage is not
guaranteed to observe the matching sk_hash/sk_state store.  A socket that
left ehash bucket i and called listen() keeps its old sk_hash, so
inet_sk_state_load(cursor) != TCP_LISTEN can still be true while the lhash2
linkage is already visible.

If validation passes on a stale snapshot, the walk then follows
cursor->sk_nulls_node.next into a chain whose spinlock is not held and
sock_hold()s the entries it finds.  On x86 the store order makes the
inconsistent snapshot hard to observe, but is bucket membership something
that can be established from lockless per-socket fields at all?

> +			if (!use_cursor)
> +				s_num = 0;
> +			hlist_nulls_for_each_entry_from(sk, node, sk_nulls_node) {
>  
> -				if (!net_eq(sock_net(sk), net))
> -					continue;
> +				sock_hold(sk);
> +				num_arr[accum] = num;
> +				sk_arr[accum] = sk;
> +				if (++accum == SKARR_SZ)
> +					break;
>  
> -				if (num < s_num) {
> -					num++;
> -					continue;
> -				}
> +				++num;
> +			}
> +			spin_unlock(&ilb->lock);

[Severity: High]
With the num < s_num skip removed from this loop and s_num forced to 0 when
the cursor is rejected, what stops the bucket from being re-dumped from its
head?

All three walks now do:

	if (!use_cursor)
		s_num = 0;

and the batch continuations replace s_num = num + 1 with s_num = 0:

	if (accum == SKARR_SZ) {
		s_num = 0;
		goto resume_listen_walk;
	}

The bind walk and the ehash walk have the same two changes, and the s_num
parameter of tcp_diag_bind_collect_owners() is dead because its only caller
sits in the !use_cursor branch where s_num has just been zeroed.

So whenever cursor validation fails, which the changelog describes as the
"safe restart on mismatch", the walk restarts at ilb->nulls_head.first, at
the head of ibb->chain, or at head->chain.first, and re-emits sockets from
that bucket that were already sent to user space earlier in the same dump.
Before this change s_num = num + 1 guaranteed the restart advanced.

There is a second effect: if all of the re-collected leading SKARR_SZ sockets
are discarded after the lock is dropped (foreign netns, since lhash2 and
ehash are shared across netns, or sdiag_family/port mismatch, or bytecode
rejection), nothing is emitted, res stays 0 and the goto resume_*_walk loop
repeats over the same head with only cond_resched() yielding.

tcp_diag_dump() still loads s_num = num = cb->args[2] on entry and still
stores cb->args[2] = num at the done: label, but num is now a chunk-relative
counter that no resume path consumes.  Should that state be dropped, or
should a positional fallback be kept for the mismatch case?  Also, since the
walk can now repeat objects within a dump, should NLM_F_DUMP_INTR be set via
a generation counter in netlink_callback.seq?

[ ... ]

> @@ -412,34 +517,46 @@ static void tcp_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
>  				continue;
>  			}
>  			spin_lock_bh(&ibb->lock);
> -			inet_bind_bucket_for_each(tb2, &ibb->chain) {
> -				if (!net_eq(ib2_net(tb2), net))
> -					continue;
> -
> -				sk_for_each_bound(sk, &tb2->owners) {
> -					struct inet_sock *inet = inet_sk(sk);
> -
> -					if (num < s_num)
> -						goto next_bind;
> -
> -					if (sk->sk_state != TCP_CLOSE ||
> -					    !inet->inet_num)
> -						goto next_bind;
> -
> -					if (r->sdiag_family != AF_UNSPEC &&
> -					    r->sdiag_family != sk->sk_family)
> -						goto next_bind;
> -
> -					if (!inet_diag_bc_sk(cb_data, sk))
> -						goto next_bind;
> -
> -					sock_hold(sk);
> -					num_arr[accum] = num;
> -					sk_arr[accum] = sk;
> -					if (++accum == SKARR_SZ)
> +			cursor = cb_data->dump_cursor;
> +			use_cursor = cursor &&
> +				     cb_data->dump_cursor_type ==
> +				     INET_DIAG_DUMP_CURSOR_TCP_BIND &&
> +				     cb_data->dump_cursor_slot == i &&
> +				     !hlist_unhashed(&cursor->sk_bind_node) &&
> +				     cursor->sk_bind_node.pprev != LIST_POISON2;
> +			if (use_cursor) {
> +				tb2 = tcp_diag_sk_bind2(cursor);
> +				use_cursor = tb2 &&
> +					     inet_bhashfn_portaddr(hashinfo, cursor,
> +								   sock_net(cursor),
> +								   inet_sk(cursor)->inet_num) ==
> +					     ibb;
> +			}
> +			if (!use_cursor)
> +				s_num = 0;
> +			if (use_cursor) {
> +				sk = cursor;
> +				if (tcp_diag_bind_collect_owners_continue(sk, sk_arr,
> +									  num_arr,
> +									  &accum,
> +									  &num))
> +					goto pause_bind_walk;
> +				hlist_for_each_entry_continue(tb2, node) {
> +					if (tcp_diag_bind_collect_owners(&tb2->owners,
> +									 sk_arr,
> +									 num_arr,
> +									 &accum,
> +									 &num, 0))
> +						goto pause_bind_walk;
> +				}

[Severity: Critical]
Can these two liveness checks ever detect that the cursor left
tb2->owners, and can tb2 here already be freed?

Removal from a bind chain goes through __sk_del_bind_node():

include/net/sock.h:
static inline void __sk_del_bind_node(struct sock *sk)
{
	__hlist_del(&sk->sk_bind_node);
}

__hlist_del() only writes *pprev and next->pprev; it leaves the removed
node's own pprev and next untouched.  So for a socket that was unlinked,
hlist_unhashed(&cursor->sk_bind_node) is false and
cursor->sk_bind_node.pprev != LIST_POISON2 holds, and both tests pass.

The freed-bucket part comes from __inet_bhash2_update_saddr():

net/ipv4/inet_hashtables.c:
	spin_lock(&head2->lock);
	__sk_del_bind_node(sk);
	inet_bind2_bucket_destroy(hinfo->bind2_bucket_cachep, inet_csk(sk)->icsk_bind2_hash);
	spin_unlock(&head2->lock);

	if (reset)
		inet_reset_saddr(sk);
	else
		inet_update_saddr(sk, saddr, family);

icsk_bind2_hash is never cleared, and inet_bind2_bucket_destroy() frees the
bucket immediately with no grace period when it was the sole owner:

	if (hlist_empty(&tb->owners)) {
		__hlist_del(&tb->node);
		__hlist_del(&tb->bhash_node);
		kmem_cache_free(cachep, tb);
		return;
	}

In the window between that spin_unlock() and the address update, the address
is unchanged, so inet_bhashfn_portaddr() still resolves to ibb, and
tcp_diag_sk_bind2(cursor) returns the dangling icsk_bind2_hash.  use_cursor
therefore becomes true.

tcp_diag_bind_collect_owners_continue() then iterates the cursor's stale
sk_bind_node.next, and hlist_for_each_entry_continue(tb2, node) reads
tb2->node.next out of the freed slab object, producing an arbitrary
struct inet_bind2_bucket * whose owners list is walked with sock_hold()
applied to each apparent entry.

Note the dumper holds only hashinfo->bhash2[i].lock and never the primary
bhash head lock, and a cursor is saved for every collected owner including
the ones filtered out afterwards, so a process that dumps with
TCPF_BOUND_INACTIVE while calling connect() on a bound socket in that bucket
can reach this.  Could the cursor instead record a validated tb2 identity
that is re-looked-up under ibb->lock, rather than being derived from
icsk_bind2_hash?

> +			} else {
> +				inet_bind_bucket_for_each(tb2, &ibb->chain) {
> +					if (tcp_diag_bind_collect_owners(&tb2->owners,
> +									 sk_arr,
> +									 num_arr,
> +									 &accum,
> +									 &num, s_num))
>  						goto pause_bind_walk;
> -next_bind:
> -					num++;
>  				}
>  			}
>  pause_bind_walk:

[ ... ]

> @@ -463,13 +598,15 @@ static void tcp_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
>  			cond_resched();
>  
>  			if (accum == SKARR_SZ) {
> -				s_num = num + 1;
> +				s_num = 0;
>  				goto resume_bind_walk;
>  			}
>  
> +			inet_diag_dump_clear_cursor(cb_data);
>  			s_num = 0;
>  		}

[ ... ]

>  		if (accum == SKARR_SZ) {
> -			s_num = num + 1;
> +			s_num = 0;
>  			goto next_chunk;
>  		}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1788248601.git.zihanx%40nebusec.ai

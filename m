Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792906830;
	b=E94ar6fiKgHxgSBCRjhYsAxPluQbWA+QIHb0MsyTYxlYIgBt8V3Y0Iui+prrJCkDl+op
	 b4IIPLRSlDBw6Dfe5ROUfAfjTygDXGW0+Kivx98plyCtizE9WmOLuC3cPKqkMLt2FaSU2
	 0PtgWRBtveDe9kCLMqy5Gg35ZfrFYQA8aoTUCJ2PpJd1nQ73/XLnxCaohKBY8Q+NFPYlj
	 zsfjyI7bXjXdikJZsqAjijjEWvNPljZKFW0Rb6+oLYZ+0XXUSqqjjk20OV3RXAXH+KN1A
	 lyb/ByZM1Q/CyzQBnyR/pryLLZ2HqaLLd56et/3VwegybgjC/Ty1yYOCyRKuzpSvSjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792906830;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=0j0OsJHnbZh3IkhEvkTsV4CA9qlpU5jT/CH5K4pTsCU=;
	b=nImjtjTYURtMiHM5qSz0LrdizGXA+DKFsgzEYqa/0puNVXBXld9TAXJzCdT4Iu+gCr8n
	 ITmRAX/Cj2tMz3TRQWExJEovhd4xA8QE51GpNQrNHcw3ctUPT98SEd46+LBC6A4E/oNoP
	 gaARMpBz1s/PUuRD9RTNcZYO1glHe1JJqlO/4PVQspVfkOnC14/GvV5su490odoOipBhw
	 31fOinWwUOq4nnPAKy8YK8mypnKOAk6NiHcszT03QK2NotcMoypZkHjRskgsGQZP41qM8
	 +wbQ1Oqc2jRSWUe90VfvHqSbQ9mt5a4kdb9CZBmyzdEEVYba6ZLnUSOw0PNK60GyqVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cf7qMw2F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856A4606A320;
	Sun, 25 Oct 2026 05:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cf7qMw2F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 364C11F01828;
	Sun, 25 Oct 2026 05:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792906830;
	bh=0j0OsJHnbZh3IkhEvkTsV4CA9qlpU5jT/CH5K4pTsCU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cf7qMw2FUGWyfN9fUEJPyoN4W/UqsRttr+UY3pjsC2zgDPC6xURLevV6fdQ+3jZwQ
	 gNmR+E8svy06rEymoWj/YcuhxzkpyVqtGcKEB8nRj3hidDtJYka0H2PBYNs+iWqE3K
	 3hW+61j5rLAR7KnSv/1LSKqA9h1GQ8Q28yObnw1wiYfo8+lCNj1LClSbMvZiycHQNx
	 M5TrbUA51xioVzHOzLOlwaF7Pj3dvIdHPAhiBnqrTV9zQp8DaXuykni4bI6K48P4+n
	 D4Lo5IcE9BdFLLvKdRsoFv22GqxbjFGs2OpspDLM/MhA4bgIvOaSaOk3i6uBNrjNpD
	 q0dBZ/bVY3BoA==
Subject: Re: [PATCH net v3 2/2] inet: restore refcount ordering for
 established lookups
From: netdev-bot+sashiko@kernel.org
To: imv4bel@gmail.com
Cc: edumazet@kernel.org, ncardwell@google.com, kuniyu@google.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 martin.lau@linux.dev, john.fastabend@gmail.com, weiwan@google.com,
 sd@queasysnail.net, jiayuan.chen@linux.dev, netdev@vger.kernel.org,
 stable@vger.kernel.org
Date: Sun, 25 Oct 2026 05:40:28 +0000
Message-ID: <179290682873.3134.10437749263853370498@kernel.org>
In-Reply-To: <20261024053720.1147022-3-imv4bel@gmail.com>
References: <20261024053720.1147022-3-imv4bel@gmail.com>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 (1) · Low: 4

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] inet_twsk_purge() (net/ipv4/inet_timewait_sock.c) was left
  unconverted, so the fix is incomplete.
- [Low] The patch carries 'Cc: stable@vger.kernel.org' and 'Fixes:
  fb041bb7c0a9' (v5.5), but the fix depends on…
- [Low] Commit message accuracy.
- [Low] Several converted sites do not follow refcount_set_release()'s
  kernel-doc contract: 'This function should be called only after new…
- [Low] In reqsk_timer_handler() the patch moves
  timer_setup(&nreq->rsk_timer, ...) ahead of the refcount store, and…

Pre-existing issues:
- [Medium] Same ordering bug in MPTCP token lookups.

--

inet: restore refcount ordering for established lookups

This patch makes the IPv4 and IPv6 established hash lookups use
refcount_inc_not_zero_acquire(). It also converts refcount_set() to
refcount_set_release() in the SYN cookie, TCP Fast Open, request
migration and TIME_WAIT paths. The goal is to bring back ordering that
was lost when fb041bb7c0a9 made refcount_inc_not_zero() relaxed on
success.

> inet: restore refcount ordering for established lookups
>
> Before commit fb041bb7c0a9 ("locking/refcount: Consolidate implementations
> of refcount_t"), default builds implemented refcount_inc_not_zero() using
> atomic_add_unless(), which provided full memory ordering on success. The
> commit removed that ordering on weakly ordered architectures, allowing
> validation in established lookups to be reordered before a successful
> reference acquisition.
>
> Use refcount_inc_not_zero_acquire() in the IPv4 and IPv6 established
> lookups. Use refcount_set_release() when setting refcounts in the SYN
> cookie, TCP Fast Open, request migration, and TIME_WAIT paths. Keep the
> existing TIME_WAIT smp_wmb(), which separately orders the refcount store
> before ehash publication.

[Severity: Low]
Is "restore" accurate for the refcount_set_release() hunks?

fb041bb7c0a9 only changed the reader side. The !REFCOUNT_FULL
refcount_inc_not_zero() went from atomic_add_unless() to a relaxed
cmpxchg loop. refcount_set() was a plain atomic_set() both before and
after that commit.

So the six conversions add writer-side ordering that never existed. They
don't restore it. The six are in tcp_get_cookie_sock(),
tcp_fastopen_create_child(), reqsk_timer_handler(),
inet_csk_complete_hashdance(), inet_csk_listen_stop() and
inet_twsk_hashdance_schedule().

The changes themselves look justified. A stale reader using acquire
ordering has to see the pprev = NULL from sk_node_init() and the new tuple
fields before the new refcount. Otherwise it could match an unhashed
syncookie, TFO or migrated req.

Could the changelog explain this? It could also say how recycled request
sock slab memory makes these unhashed reqs reachable at all.

sk_clone_lock() and sock_init_data() already have an smp_wmb() before
their refcount_set(), so leaving those two alone looks right.

> Fixes: fb041bb7c0a9 ("locking/refcount: Consolidate implementations of refcount_t")
> Cc: stable@vger.kernel.org

[Severity: Low]
refcount_inc_not_zero_acquire() and refcount_set_release() were added by
7f8ceea0c58039 ("refcount: provide ops for cases when object's memory can
be reused"). That commit is in v6.15 and not in v6.14.

The Fixes: tag points to v5.5. Without that prerequisite, none of the
touched files will build in the 5.10, 5.15, 6.1, 6.6 and 6.12 stable
trees.

Should the stable tag carry a prerequisite annotation, for example:

Cc: stable@vger.kernel.org # needs 7f8ceea0c580 ("refcount: provide ops ...")

Or is a fallback planned for older trees?

> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
> index 01ecd98a2b501..8faef6c38b364 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
> @@ -1060,8 +1060,8 @@ static void reqsk_timer_handler(struct timer_list *t)
>  		 * hold another count to prevent use-after-free and
>  		 * call reqsk_put() just before return.
>  		 */
> -		refcount_set(&nreq->rsk_refcnt, 2 + 1);
>  		timer_setup(&nreq->rsk_timer, reqsk_timer_handler, TIMER_PINNED);
> +		refcount_set_release(&nreq->rsk_refcnt, 2 + 1);

[Severity: Low]
This isn't a bug, but timer_setup() now runs before the refcount store,
and the changelog doesn't mention the move.

It follows from the refcount_set_release() kernel-doc, which wants
initialisation done before the release. nreq is still private at this
point. A short note in the commit message would be enough.

>  		reqsk_queue_migrated(&inet_csk(nsk)->icsk_accept_queue, req);
>  
>  		req = nreq;

[ ... ]

> diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
> index a1d86026aefb0..5c1bff5a6d4d8 100644
> --- a/net/ipv4/inet_timewait_sock.c
> +++ b/net/ipv4/inet_timewait_sock.c
> @@ -143,7 +143,7 @@ void inet_twsk_hashdance_schedule(struct inet_timewait_sock *tw,
>  	 * Also note that after this point, we lost our implicit reference
>  	 * so we are not allowed to use tw anymore.
>  	 */
> -	refcount_set(&tw->tw_refcnt, 3);
> +	refcount_set_release(&tw->tw_refcnt, 3);

[Severity: High]
Is the fix complete without also converting inet_twsk_purge() in this
same file?

It walks the same ehash chains locklessly under rcu_read_lock(). It
handles the same SLAB_TYPESAFE_BY_RCU TIME_WAIT and request socks, and it
still uses the relaxed variant:

net/ipv4/inet_timewait_sock.c:inet_twsk_purge() {
    ...
			if (check_net(sock_net(sk)))
				continue;

			if (unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
				continue;

			if (check_net(sock_net(sk))) {
				sock_gen_put(sk);
				goto restart;
			}
    ...
				inet_csk_reqsk_queue_drop_and_put(req->rsk_listener,
								  req);
    ...
}

The release store added here only helps readers that pair it with an
acquire. __refcount_add_not_zero() uses atomic_try_cmpxchg_relaxed(). On
arm64 or POWER, the second check_net() and the later req->rsk_listener
load can therefore be satisfied before the CAS.

Can this sequence happen?

CPU0, in tcp_sk_exit_batch()->tcp_twsk_purge()->inet_twsk_purge() for
dying netns D:
  sees socket X in D, and the first check_net() is false

CPU1:
  X is freed
  the slot is reused for a new TIME_WAIT or request sock in live netns L
  the new sock is initialised, gets refcount_set_release(), and is hashed

CPU0:
  refcount_inc_not_zero() succeeds on the new object
  the reordered second check_net() still reads D
  inet_twsk_deschedule_put() or inet_csk_reqsk_queue_drop_and_put() runs

That tears down a TIME_WAIT or pending request sock that belongs to the
live netns L.

req->rsk_listener could also be read stale. It would then be the old
occupant's listener, which may already be released, and
inet_csk_reqsk_queue_drop() would update that listener's accept queue
counters.

An unprivileged user can trigger netns exit through user namespaces. A
remote peer can create TIME_WAIT and request socks in L.

Should inet_twsk_purge() use refcount_inc_not_zero_acquire() too?

[ ... ]

> diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
> index 471c78be55137..e40477b6b5549 100644
> --- a/net/ipv4/tcp_fastopen.c
> +++ b/net/ipv4/tcp_fastopen.c
> @@ -364,7 +364,7 @@ static struct sock *tcp_fastopen_create_child(struct sock *sk,
>  	tcp_reset_xmit_timer(child, ICSK_TIME_RETRANS,
>  			     req->timeout, false);
>  
> -	refcount_set(&req->rsk_refcnt, 2);
> +	refcount_set_release(&req->rsk_refcnt, 2);

[Severity: Low]
The kernel-doc for refcount_set_release() says:

 * This function should be called only after new object is fully initialized.
 * After this call the object should be considered visible to other tasks

Later in tcp_fastopen_create_child(), req is still written after the
release store:

	tcp_rsk(req)->rcv_nxt = tp->rcv_nxt;

The other converted sites have the same ordering:

  tcp_get_cookie_sock(), inet_csk_complete_hashdance() and
  inet_csk_listen_stop() do the release before
  inet_csk_reqsk_queue_add(), which writes req->sk and req->dl_next.

  reqsk_timer_handler() does the release before req->num_timeout++, the
  accecn_fail_mode update and mod_timer() on nreq. nreq is then hashed
  by inet_ehash_insert().

For the reqs that are never hashed, hlist_nulls_unhashed_lockless()
rejects stale established lookups, because sk_node_init() runs before the
release. So the practical exposure seems limited to minor fields such as
num_timeout on the migrated nreq.

These stores had no ordering at all before this patch, so nothing
regresses.

Could the release stores move after the last initialising write? If not,
a comment could explain why the later writes are fine.

> diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
> index aa5fa1dd062f7..1eea584d80df8 100644
> --- a/net/ipv6/inet6_hashtables.c
> +++ b/net/ipv6/inet6_hashtables.c
> @@ -105,7 +105,7 @@ struct sock *__inet6_lookup_established(const struct net *net,
>  			continue;
>  		if (!inet6_match(net, sk, saddr, daddr, ports, dif, sdif))
>  			continue;
> -		if (unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
> +		if (unlikely(!refcount_inc_not_zero_acquire(&sk->sk_refcnt)))
>  			goto out;

[Severity: Medium]
This is a pre-existing issue and was not introduced by this patch, but
the MPTCP token lookups seem to have the same pattern.

mptcp_token_get_sock() in net/mptcp/token.c re-validates after a relaxed
increment:

	if (!refcount_inc_not_zero(&sk->sk_refcnt))
		goto not_found;

	if (READ_ONCE(msk->token) != token ||
	    !net_eq(sock_net(sk), net)) {

mptcp_token_iter_next() does the same thing with its net_eq() check.

mptcp_prot sets SLAB_TYPESAFE_BY_RCU for msk objects. For that reason,
mptcp_subflow_reqsk_clone() in net/mptcp/subflow.c already uses
refcount_inc_not_zero_acquire().

On weakly ordered CPUs, can these lookups return a recycled msk from
another connection or netns?

For MP_JOIN, the later HMAC check would fail and cause a spurious reset.
Through the diag iterator, an msk from another netns could be dumped.

MPTCP was merged in v5.6, after fb041bb7c0a9. These sites never had the
fully ordered behaviour, and they are outside what this patch covers.
Would a separate fix for them make sense?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261024053720.1147022-1-imv4bel%40gmail.com

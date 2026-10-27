Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793080515;
	b=GLhu7POqm/e7+ixL3zquEZ1oqAU8nXIcDgiS8mpo+YCcXoYJiLWpEL+NPLq1OHHCjGvs
	 Azi18BytKEr9K+4hsVcNK1V95XGYvTJSWvzQ0Gq/UwNpZnTfTav3WO6a0LuzWDmZcBODu
	 xOVU+Hm5ipx2EKwYVvIWzxhcgeAbkhSz6acG26X9PFqWRmHazGSTG1wjKaog88j4TxjZQ
	 VK7bGiQJrvDmZrBzIp7lZmTm9kySFGOo8aTazMxVSMncNI3a/d1KKwsyByWbiKLj/z08Y
	 OuuZirZ7h2nlsdftLpwDGBCUFzUtYAEf0CCFsC2svE9emr+ob1JxhtDl2v+2PmJT3bA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793080515;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=952P5W1cLhRjXD7ikPKFwxH/5sjyHEbj+/5fTyALU4g=;
	b=lR23q2xCqBN8B/RWe2BEVr9Th2lO95jS0iJYcCJFFztZnEVV5J391OCBTGQkWyEdeWg3
	 WAzCNmDhEp7q6j/olHfM5fL65uuVmkabYPUXUzikLH74TFdJ4QUSkVdb9lEek23sN1IYm
	 JlbwtSbfEGQo45vAtvHSvA07e2hFPE+a5sVUsAMxgR/TCpn06PiTg3yvc/wDdMq6eaRb+
	 +EZ9xZlGv8bzAqMyjTiZWBHxCJWbqEwSA0NBu++oc+tpmGEQNGk1x8BjYSS47Io85owmw
	 XD4Gdg96fTg7UW6ddM8QqeszUOy7kK771KigLvOr2Zes+STZVb0iGA6u8Wf1SYgTTnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Th7xG9Xl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CEC606A327;
	Tue, 27 Oct 2026 05:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Th7xG9Xl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C971F031E1;
	Tue, 27 Oct 2026 05:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793080515;
	bh=952P5W1cLhRjXD7ikPKFwxH/5sjyHEbj+/5fTyALU4g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Th7xG9XlisFQeYL5f+5/MmmBVu/xVyzwdTUIjFfwjYIdzO4nu+ycJU9cVbRTTyopC
	 cPb4s+Qfl1pz6uymAFd1hdADc72FlKBYfbTBGqdW2r2ElOu2caf5Kii7Ev14eaw+n1
	 wq+BPenvAo7xyiXsdgdo5yfx1gq2zPWDMGudytwfQCeejO6exjMlU97cOey65dS3JW
	 xx7Ljhyvt1YbLcxdIp8sD2O0b5s+YnhHurW1i7HXivAY6gzyXMMWl4XERm3ikTCrZJ
	 dQmenUBk3kiE7bNL5XPUacsIj2C2CMHAyNPpe+2Adds8JBFQVd6cpwmG0DGgPuyZrd
	 h/3YuUMoRa8rQ==
Subject: Re: [PATCH net v2 2/2] inet: restore refcount ordering for
 established lookups
From: netdev-bot+sashiko@kernel.org
To: imv4bel@gmail.com
Cc: edumazet@kernel.org, ncardwell@google.com, kuniyu@google.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 martin.lau@linux.dev, john.fastabend@gmail.com, weiwan@google.com,
 sd@queasysnail.net, jiayuan.chen@linux.dev, netdev@vger.kernel.org,
 stable@vger.kernel.org
Date: Tue, 27 Oct 2026 05:55:13 +0000
Message-ID: <179308051368.3134.18207587911262836061@kernel.org>
In-Reply-To: <20261023052542.3505250-3-imv4bel@gmail.com>
References: <20261023052542.3505250-3-imv4bel@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] inet: premature refcount_set_release() in sk_clone() and
  reqsk_timer_handler()
- [Medium] The patch converts only __inet_lookup_established() and
  __inet6_lookup_established() to refcount_inc_not_zero_acquire().

--

inet: restore refcount ordering for established lookups

This patch converts the IPv4 and IPv6 established hash lookups to
refcount_inc_not_zero_acquire(). It also converts the code that sets
initial refcounts in sk_clone(), SYN cookies, request migration and TCP
Fast Open to refcount_set_release(). The goal is to restore the ordering
that weakly ordered architectures lost after the refcount_t
consolidation in v5.5.

> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> index b0239d203f045..860145d810ed4 100644
> --- a/net/ipv4/inet_hashtables.c
> +++ b/net/ipv4/inet_hashtables.c
> @@ -550,7 +550,7 @@ struct sock *__inet_lookup_established(const struct net *net,
>  		if (sk->sk_hash != hash)
>  			continue;
>  		if (likely(inet_match(net, sk, acookie, ports, dif, sdif))) {
> -			if (unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
> +			if (unlikely(!refcount_inc_not_zero_acquire(&sk->sk_refcnt)))
>  				goto out;

[Severity: Medium]
This converts __inet_lookup_established() and
__inet6_lookup_established(). Other lockless readers of
SLAB_TYPESAFE_BY_RCU sockets take a reference and then revalidate the
object in the same way. Are those readers still using the relaxed
refcount_inc_not_zero()?

inet_twsk_purge() in net/ipv4/inet_timewait_sock.c walks the same ehash
chains and handles TIME_WAIT and NEW_SYN_RECV sockets:

net/ipv4/inet_timewait_sock.c:inet_twsk_purge() {
    ...
			if (unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
				continue;

			if (check_net(sock_net(sk))) {
				sock_gen_put(sk);
				goto restart;
			}
    ...
}

The twsk and request sock slabs are created with prot->slab_flags. For
tcp_prot and tcpv6_prot, that is SLAB_TYPESAFE_BY_RCU. reqsk_timer_handler()
inserts nreq into ehash, and this patch changes it to set nreq's refcount
with refcount_set_release(). inet_twsk_purge() has no matching acquire.

On a weakly ordered CPU, the check_net() load can be satisfied before the
increment. In that case, could inet_twsk_purge() call
inet_twsk_deschedule_put() or inet_csk_reqsk_queue_drop_and_put() on a
recycled object that belongs to a live netns?

It also reads req->rsk_listener after rcu_read_unlock(), with no ordering
against the reference acquisition.

MPTCP has the same pattern on mptcp_sock. mptcp_prot also uses
SLAB_TYPESAFE_BY_RCU in net/mptcp/protocol.c:

net/mptcp/token.c:mptcp_token_get_sock() {
    ...
		if (!refcount_inc_not_zero(&sk->sk_refcnt))
			goto not_found;

		if (READ_ONCE(msk->token) != token ||
		    !net_eq(sock_net(sk), net)) {
    ...
}

net/mptcp/token.c:mptcp_token_iter_next() {
    ...
			if (!refcount_inc_not_zero(&sk->sk_refcnt))
				continue;

			if (!net_eq(sock_net(sk), net)) {
    ...
}

net/mptcp/subflow.c already uses refcount_inc_not_zero_acquire() for the
msk.

__refcount_add_not_zero() uses atomic_try_cmpxchg_relaxed(). The
refcount.h documentation says to use the acquire variant when the
increment is followed by validation on SLAB_TYPESAFE_BY_RCU objects.

Could mptcp_token_get_sock() return the wrong msk for a remote MP_JOIN
SYN? Could mptcp_token_iter_next() return an msk from another netns to
the PM or diag iterators? For the MP_JOIN case, the HMAC check would
most likely reject a wrong msk.

The commit message describes this class of bug as removing "the ordering
required by validation after a successful reference acquisition". Should
these readers also move to refcount_inc_not_zero_acquire(), either in
this patch or in a follow-up?

>  			if (unlikely(hlist_nulls_unhashed_lockless(&sk->sk_nulls_node) ||
>  				     !inet_match(net, sk, acookie, ports, dif,

[ ... ]

> diff --git a/net/core/sock.c b/net/core/sock.c
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -2622,8 +2622,7 @@ struct sock *sk_clone(const struct sock *sk, const gfp_t priority,
>  	/* Before updating sk_refcnt, we must commit prior changes to memory
>  	 * (Documentation/RCU/rculist_nulls.rst for details)
>  	 */
> -	smp_wmb();
> -	refcount_set(&newsk->sk_refcnt, 2);
> +	refcount_set_release(&newsk->sk_refcnt, 2);
>  
>  	sk_set_socket(newsk, NULL);
>  	sk_tx_queue_clear(newsk);

[Severity: High]
Is this release placed late enough to cover the fields that the
established lookup revalidates?

sk_clone() publishes sk_refcnt here, but several stores still follow
it before the socket is linked into ehash. These include
sk_set_socket(newsk, NULL), sk_tx_queue_clear(), sk_rx_queue_clear()
and the sk_wq reset right below. They also include the tuple fields
(sk_daddr, sk_rcv_saddr, inet_dport, inet_num, sk_v6_daddr, ...) and
inet_sk_set_state(newsk, TCP_SYN_RECV) in inet_csk_clone_lock(). The
child setup in tcp_create_openreq_child() and tcp_v4_syn_recv_sock()
or tcp_v6_syn_recv_sock() comes after that.

Only then does inet_ehash_insert() link the socket. The pprev store in
__sk_nulls_add_node_rcu() or sk_nulls_replace_node_init_rcu() is a
plain WRITE_ONCE() and does not touch sk_refcnt.

Consider a reader in __inet_lookup_established() or
__inet6_lookup_established() that picked up the object pointer during
the object's previous life in the SLAB_TYPESAFE_BY_RCU cache. That
reader never traverses the newly published chain link:

  refcount_inc_not_zero_acquire() succeeds and pairs with the
  release in sk_clone()
  hlist_nulls_unhashed_lockless() reads pprev with READ_ONCE()
  inet_match() / inet6_match() read the tuple with relaxed loads

The acquire only orders the reader against stores made before the
release. The pprev and tuple values are written after the release,
so the reader can observe them with no ordering at all.

On a weakly ordered CPU, the lookup could then pass both checks and
return the socket while still seeing values that sock_copy() took
from the listener. Examples are sk_state == TCP_LISTEN, the
listener's sk_socket and sk_wq, or TCP fields that are not yet
initialized. Wouldn't tcp_v4_rcv() or tcp_v6_rcv() then process the
packet against a half-initialized socket?

reqsk_timer_handler() has the same problem. Moving the release after
timer_setup() helps, but several stores still run between
refcount_set_release(&nreq->rsk_refcnt, 2 + 1) and
inet_ehash_insert(req_to_sk(nreq), req_to_sk(oreq), NULL). These are
tcp_rtx_synack(), the accecn_fail_mode update, nreq->num_timeout++
and mod_timer(&nreq->rsk_timer, ...). A stale reader that sees nreq
hashed has no ordering against any of them.

The release cannot simply be moved past mod_timer() either. Once the
timer is armed, it can already drop references.

By contrast, the TIME_WAIT path that the commit message calls
correct does its smp_wmb() and refcount_set() after
inet_twsk_add_node_rcu(), if I read inet_twsk_hashdance_schedule()
correctly. There the refcount only becomes non-zero after the hash
linkage and every earlier store. Documentation/RCU/rculist_nulls.rst
likewise writes the key before the release on the refcount.

This gap already existed with the old smp_wmb() and refcount_set().
This patch sets out to restore the ordering that the lookup
revalidation depends on, though, so it looks incomplete.

How would you like to close the gap? One option is to make sk_refcnt
visible only after the socket is fully initialized and hashed.
Another is to pair an acquire load of pprev in the lookup with a
release store on the insert side. I'm not sure either option fits the
sk_clone() callers and the request timer's refcount requirements.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261023052542.3505250-1-imv4bel%40gmail.com

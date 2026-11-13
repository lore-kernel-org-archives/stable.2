Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794575111;
	b=skBol4w4jKeTcTMHhRVdpO+BdqA7rbuQbaMV4MPirTDH2QaRp0Kg17QKNRVNqJ0KrPTu
	 wcVF+Cz6uYFda9UE/LiFUrrM4+gKGJpU8il+h9KnvNU6d1TOIPNp/LqwVYwl2xaRoOVP6
	 SVaTpywrUSyz0wo7W6xq57ZqGZLrNwJIVFkLMZ9/Q02fWQj95kDyIidRe+hJQ8lK70UUt
	 mBh6r2UTq+woI7lOJHnQKZhjN319Jmhg+FawHBcxv26EUqPtrYIVknu9y3FBg0FoD4UnF
	 5WTVT3YSIlU+CDLlalWvOrvJKKM/ki0uobJGEzH4LXUUi/I1omYqrY1/1gQTJCd568Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794575111;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=EM8ZnpnsteTstTOFyEqAfs+v+bqrEfRmWvONaNCLxe8=;
	b=RWPr5bgiA5Cxy2X6+twzaIS027nkUqdxYQNlsHhorVSROnoxSRk5mS/pRW/jA/a2NA/W
	 tsfPRjuUCYKKCQAcCFAApNvbX5nLBfH9SP1hNvVVVnhUAo0YJ2nuGzepnLjAsAhr/DmrH
	 iMpcH7F5c2QHnnHVZQFgxVxnkKJAckFvrrxlHgJbKxJsJdr8bDJXPMfoy+SEeJUGYjlC/
	 iOQ4KQO51xpl1iCpTILZgEAf3viKhtqKkHLlBghs3mGH6s7gS1U0+ctwQNQ1lzeQJpqCE
	 7LKspB+z7W3pDTzqxPRLZjZSNsX8UlSZmLZLZnHVMwcKviUl/C8biRHoieYkHot1Rgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jlJaOQGR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4E4606A32E;
	Fri, 13 Nov 2026 13:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jlJaOQGR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 444531F000C4;
	Fri, 13 Nov 2026 13:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794575111;
	bh=EM8ZnpnsteTstTOFyEqAfs+v+bqrEfRmWvONaNCLxe8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jlJaOQGRUOYVxQEoQtS2xwULbwTBBVEQRnJhTJK82AZQc2WDH5QTQJpbPfVBX7YD+
	 BNB2PEFo0hxpfCLTkvvA6HRbPVGr2AkXeJp0GE9SQKDJ1RFA2QCRIJ6rz7IO9QM146
	 NiprzNTOpYfX+t7bd7rS1Czxzn6NmpLJ7S/nxKPXktcmAiAlcRKmsoQ/M15VAJWitA
	 +2fvErObhF/4tOShepwObLyFwWwF4ia8KSamBoWjdmCNVdUR0tVcmlOg9XSlsVAuQr
	 iSi9ysECkFDhYqIB9alCprSEN3vM5NnvxO7pYrMm1waDn0KKDgAlJ1h6Zty5tyQMdg
	 BvVFAZa7xS9YQ==
Subject: Re: [PATCH net 1/2] net: mptcp: take token lookup references with
 acquire ordering
From: netdev-bot+sashiko@kernel.org
To: 2122295973@qq.com
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, matttbe@kernel.org,
 martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, willemb@google.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Date: Fri, 13 Nov 2026 13:05:09 +0000
Message-ID: <179457510979.2199510.5244757217297725488@kernel.org>
In-Reply-To: <tencent_28A2BD1631FE531992E91753BA6419FFC506@qq.com>
References: <tencent_28A2BD1631FE531992E91753BA6419FFC506@qq.com>
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] mptcp_token_get_sock() uses the token value as its only liveness
  check, but it accepts a requested token of 0.
- [High] mptcp_token_iter_next() re-checks only net_eq() after taking the
  reference (token.c:376).
- [Medium] The commit message gives the wrong reason for the change, and
  it never mentions the race the change actually closes.
- [Low] net: mptcp: Fixes trailer cites commit predating token.c lockless
  lookups

--

net: mptcp: take token lookup references with acquire ordering

This patch changes mptcp_token_get_sock() and mptcp_token_iter_next() to
use refcount_inc_not_zero_acquire() instead of refcount_inc_not_zero().
The aim is to order the re-validation of msk->token and sock_net() after
the reference is taken, as 5b5d8f351dd9 did for the inet lookups.

> mptcp_token_get_sock() validates the token and the network namespace,
> takes a reference on the socket and then validates them again.  The
> second validation only rejects a socket that is being torn down if it is
> ordered after the reference acquisition: mptcp_token_destroy() unlinks
> the socket and does WRITE_ONCE(msk->token, 0), so a reader that observes
> the token before the acquisition can return a socket whose token has
> already been cleared.

[Severity: Medium]
Is this the race that the acquire ordering actually closes?

mptcp_token_destroy() clears the token without touching sk_refcnt:

net/mptcp/token.c:mptcp_token_destroy() {
    ...
	spin_unlock_bh(&bucket->lock);
	WRITE_ONCE(msk->token, 0);
}

That leaves no release on the refcount for
refcount_inc_not_zero_acquire() to pair with. With or without acquire,
the re-check can still read the old token. mptcp_token_destroy() can also
run right after the re-check succeeds.

The case the acquire does fix looks like object reuse. mptcp_prot uses
SLAB_TYPESAFE_BY_RCU and only listeners set SOCK_RCU_FREE. So an
established msk can be freed and reallocated while an RCU reader still
holds a pointer to it. The new owner publishes the refcount in
sock_init_data_uid():

	smp_wmb();
	refcount_set(&sk->sk_refcnt, 1);

Without acquire, the re-check loads of msk->token and sock_net() can be
satisfied before the increment. They would return the old object's values
while the increment succeeds on the new object. The lookup could then
return an msk from a different connection, possibly in a different netns.
include/linux/refcount.h documents this case as the reason for the
acquire variants.

Since this is tagged for stable, could the commit message describe the
SLAB_TYPESAFE_BY_RCU reuse case instead of the teardown race?

> diff --git a/net/mptcp/token.c b/net/mptcp/token.c
> index e0f2823f92efb..3429b43a9f7c3 100644
> --- a/net/mptcp/token.c
> +++ b/net/mptcp/token.c
> @@ -309,7 +309,7 @@ struct mptcp_sock *mptcp_token_get_sock(struct net *net, u32 token)
>  		    !net_eq(sock_net(sk), net))
>  			continue;
>  
> -		if (!refcount_inc_not_zero(&sk->sk_refcnt))
> +		if (!refcount_inc_not_zero_acquire(&sk->sk_refcnt))
>  			goto not_found;
>  
>  		if (READ_ONCE(msk->token) != token ||

[Severity: Low]
The Fixes tag points at fb041bb7c0a9 ("locking/refcount: Consolidate
implementations of refcount_t"), which landed in v5.5-rc1. At that
point net/mptcp/token.c did not exist yet, so there was no MPTCP code
for that commit to break.

The lockless lookup in mptcp_token_get_sock() came in with
2c5ebd001d4f ("mptcp: refactor token container"). That is the
refcount_inc_not_zero() on sk->sk_refcnt followed by the token and
netns re-check.

mptcp_token_iter_next() came in with 96d890daad05 ("mptcp: add msk
interations helper"). That added its refcount_inc_not_zero() and the
net_eq() re-check.

Both of those are in v5.9-rc1.

Stable tooling uses the Fixes tag to decide which trees get the
backport. Pointing at a v5.5 locking commit would have it try v5.5
through v5.8. In those trees this file is either missing or has no
lockless lookup at all.

Could the tags be changed to:

Fixes: 2c5ebd001d4f ("mptcp: refactor token container")
Fixes: 96d890daad05 ("mptcp: add msk interations helper")

[Severity: High]
What happens in mptcp_token_get_sock() when the requested token is 0?

Token 0 is never assigned, because __token_bucket_busy() treats it as
busy:

	return !token || t->chain_len >= TOKEN_MAX_CHAIN_LEN ||

However, 0 is exactly what mptcp_token_destroy() writes into a dying msk.
It is also what a newly reallocated msk holds, since sk_alloc() zeroes
the object. For token == 0, both the first check and this re-check pass
on a cleared or recycled msk. So the "socket whose token has already been
cleared" case from the commit message can still happen with this patch.

The token comes from the wire. mptcp_parse_option() copies the MP_JOIN
SYN token without checking it, and then:

subflow_check_req()
  subflow_token_join_request()
    mptcp_token_get_sock(net, 0)

Suppose an RCU reader holds a pointer to an msk on bucket 0's chain while
that msk is unhashed, freed and reallocated by inet_create() in the same
netns. Between sock_init_data() and sk_prot->init(), the new msk has
refcount 1, token 0 and the matching netns. It would pass both checks and
be returned.

subflow_check_req() then calls subflow_use_different_sport(). That sees
an inet_sport of 0 and calls mptcp_pm_announced_has_ssk():

	list_for_each_entry(entry, &msk->pm.anno_list, list) {

pm.anno_list is not initialised until mptcp_pm_data_init() runs from
__mptcp_init_sock(), so head->next is still NULL. Can this oops in
softirq?

Even without reuse, a torn-down msk whose token was just cleared would be
returned to the join path and pinned by the request socket.
mptcp_diag_dump_one() with idiag_cookie[0] == 0 and the userspace PM
token lookup seem to have the same problem.

Should mptcp_token_get_sock() return early for token 0, for example:

	if (!token)
		return NULL;

or should the re-check also confirm the msk is still hashed?

> @@ -370,7 +370,7 @@ struct mptcp_sock *mptcp_token_iter_next(const struct net *net, long *s_slot,
>  			if (num <= *s_num)
>  				continue;
>  
> -			if (!refcount_inc_not_zero(&sk->sk_refcnt))
> +			if (!refcount_inc_not_zero_acquire(&sk->sk_refcnt))
>  				continue;
>  
>  			if (!net_eq(sock_net(sk), net)) {

[Severity: High]
The commit message says the iterator "has the same shape and is converted
as well". The re-check in mptcp_token_iter_next() only looks at net_eq(),
though. Can it reject an msk that was torn down or recycled in the same
netns?

With SLAB_TYPESAFE_BY_RCU, a preempted RCU reader in
mptcp_token_iter_next() can hold a pointer to an msk while it is
unhashed, freed and reallocated by inet_create() in the same netns.

There is a window between sock_init_data_uid() publishing the refcount:

	smp_wmb();
	refcount_set(&sk->sk_refcnt, 1);

and __mptcp_init_sock() running:

	INIT_LIST_HEAD(&msk->conn_list);

In that window the msk has refcount 1, the same netns, and zeroed
conn_list and pm state. A zeroed pm.pm_type looks like
MPTCP_PM_TYPE_KERNEL.

The iterator would take the reference, pass the net_eq() check and return
this msk. An endpoint delete then does:

mptcp_nl_remove_subflow_and_signal_addr()
  lock_sock(sk)
  mptcp_pm_has_subflow_saddr()
    mptcp_for_each_subflow(msk, subflow)

Would this walk the zeroed conn_list and dereference a near-NULL entry?

The other iterator users, mptcp_nl_flush_addrs_list(),
mptcp_pm_nl_set_flags_all() and mptcp_nl_remove_id_zero_address(), would
also act on a half-built or unrelated msk.

Should the re-check after the acquire also confirm the msk is still
hashed in this slot, for example:

	!sk_unhashed(sk) && (READ_ONCE(msk->token) & token_mask) == slot

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/tencent_28A2BD1631FE531992E91753BA6419FFC506%40qq.com

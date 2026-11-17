Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794908633;
	b=sLoSPBMoFI26SC7LbnPK3agEhPYmF7E6rGbinNQqswa/UibLMEcXkCbDvoaWX+pZljcJ
	 GBbYFnpVpuWc7wKa7nMduITar/rnPhTuM0tqvklP9Xh7Bs8baMXgPwyFxvX4BCxELdDMe
	 pDtRAlJluEQJlxOWljBfzdKnuGjwotnOAV9Xs+ZnYQRGbF+qFrgJulQb3trytqx9Sy2XC
	 iDbZBQWvuts2ntQOx2i/u+OCNdCwaSoihU3D3JIILxitTSHfD5BpR7ErNJ2Zx2S0r/0Qa
	 3TY0xfQXvMGetQvvHGFyTOGvr3dJkebkNGZ7Wis0nMceu0/e/28zf7gy+G1aWtzYGbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794908633;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=7qo4pDApg6kPCIqnGxTspkdPI4s3aZYTTCU9JPkaMZI=;
	b=N/lfUL2DLBv2DqICWbopnX60KSfEpZDFWOjxkOtGKAKxZ+ZzYs/y2qlrtLqqrMyj1vFz
	 0nsSstrpC0pcxob52ABNGld9K38m0lfulgCjxSEecCnO3Bu3/SFQedIWvbmBhPtTyQd/5
	 pG9GJZ+wyj4+1EL7Tmydt3yoyg3ZTBrUcUPVSFa7PrvqRgZVVO/lpAq/RV5cXcpJ/Jn5G
	 iThpklaQNnHd+NoM2vynP2HmiMgI6LP+EvJqTE/Tlq9WZvxgngXeScTjBNM1Kwbm0CUja
	 euuKTA8n8pbTCRQPRwGMALN4TMZpcfGvZQhQgHSJisdNBbiEKNQyAzqpmywxtOSUWbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UH4+ZZ5P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D3360A5BDE;
	Tue, 17 Nov 2026 09:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UH4+ZZ5P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5379E1F000D2;
	Tue, 17 Nov 2026 09:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794908633;
	bh=7qo4pDApg6kPCIqnGxTspkdPI4s3aZYTTCU9JPkaMZI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UH4+ZZ5PArpyN3to+x7MhXhi/KR1/pe4KrrPG9HYENuJWzlqDvQJWuuhZN69+oQ7g
	 bpUQo34ZZgVvT3Aqk1kBjMmzf82t9KbbEIMK97p3FGzvjRXoa4pafMpVZ8thxLFOzk
	 dO2eTsu0WyRnG+I3NFzttsncqUiOUKJK8/huCLpFucCpJxJvcR4tTN3om9vByrbjhm
	 XoZ8ScrJiDIunhTqIUf7WhjJ7DEZbgTLDolS3u2lg6JU4gWqVNX1xpQ49PfT810m5i
	 8VHyvc4o4DVy7nQ+gkFs/N/h/OXKboRDInXVOFJvvlUfz0ZSQIcynrVvrhAsECB2gl
	 O9HMUSZMOHrQA==
Subject: Re: [PATCH net v4 1/3] net: mptcp: take token lookup references with
 acquire ordering
From: netdev-bot+sashiko@kernel.org
To: 2122295973@qq.com
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, matttbe@kernel.org,
 martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, willemb@google.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Date: Tue, 17 Nov 2026 09:43:51 +0000
Message-ID: <179490863184.3133.11284908359551272618@kernel.org>
In-Reply-To: <tencent_D0DCF4B132B20B70FB5AE2D9272AA4AEAF07@qq.com>
References: <tencent_D0DCF4B132B20B70FB5AE2D9272AA4AEAF07@qq.com>
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

Critical: 0 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete on the passive-open (sk_clone_lock)
  allocation path.
- [Low] The patch is tagged `Cc: stable@vger.kernel.org` with Fixes: tags
  pointing to v5.8-era commits (2c5ebd001d4f, 96d890daad05).

--

net: mptcp: take token lookup references with acquire ordering

This switches the refcount increments in mptcp_token_get_sock() and
mptcp_token_iter_next() to refcount_inc_not_zero_acquire(). The re-check of
msk->token and sock_net(sk) is then ordered after the reference is taken on
a SLAB_TYPESAFE_BY_RCU socket that may have been recycled. It follows what
commit 5b5d8f351dd9 did for the IPv4/IPv6 established lookups.

> Fixes: 2c5ebd001d4f ("mptcp: refactor token container")
> Fixes: 96d890daad05 ("mptcp: add msk interations helper")
> Cc: stable@vger.kernel.org

[Severity: Low]
Will this build on the stable trees these Fixes: tags reach?

refcount_inc_not_zero_acquire() was added to include/linux/refcount.h by
commit 7f8ceea0c580 in 2025. Both 2c5ebd001d4f and 96d890daad05 date from
v5.8. LTS branches that don't have 7f8ceea0c580 also don't have the helper.

Could the stable tag name the prerequisite, for example:

Cc: stable@vger.kernel.org # depends on 7f8ceea0c580

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

[ ... ]

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
Does the acquire ordering also cover the passive-open allocation path?

The commit message covers the sock_init_data_uid() path. On the clone
path, every MPTCP-specific store happens after the refcount is already
live. That includes the token the readers re-check:

sk_clone_lock()
  sk_clone()
    smp_wmb();
    refcount_set(&newsk->sk_refcnt, 2);

mptcp_sk_clone_init()
    __mptcp_init_sock(nsk);
    ...
    WRITE_ONCE(msk->token, subflow_req->token);
    ...
    mptcp_set_state(nsk, TCP_ESTABLISHED);
    WRITE_ONCE(msk->first, ssk);
    list_add(&subflow->node, &msk->conn_list);
    ...
    mptcp_copy_inaddrs(nsk, ssk);
    ...
    if (!mptcp_token_accept(subflow_req, msk)) {

The SLAB_TYPESAFE_BY_RCU comment in include/linux/slab.h says "the newly
allocated object has to be fully initialized *before* its refcount gets
initialized". This path doesn't do that.

Take a reader such as mptcp_diag_dump() walking bucket S through
mptcp_token_iter_next(), holding a chain pointer to msk A. A is closed and
freed, and a clone B for a new incoming MPTCP connection reuses its memory
right away.

refcount_inc_not_zero_acquire() then succeeds on B's refcount of 2. The
following READ_ONCE() of the token can return B's new token simply because
that store has already happened. This is a timing issue, not a reordering
one, so strongly ordered CPUs are affected too.

Even with the later patch in this series ("net: mptcp: verify the token
slot in mptcp_token_iter_next()"), this is the only check after the
increment:

	token = READ_ONCE(mptcp_sk(sk)->token);
	if (!token || (token & token_mask) != slot ||
	    !net_eq(sock_net(sk), net)) {

If B's token hashes to slot S, B is returned while it is on no token chain
and is still being built in softirq. Its sk_state may still be the
TCP_LISTEN copied from the listener. msk->first, conn_list and the
addresses may not be set yet. On weakly ordered CPUs, the
__mptcp_init_sock() and pm init stores may not be visible either.

That looks like the "or one that is not initialised yet" outcome the commit
message says this change removes.

mptcp_token_get_sock() seems to have the same gap when B's token matches
the token being looked up. One example is a peer that sends an MP_JOIN for
that token right after its MPC ACK, while a reader walks a stale pointer to
a recycled object in the same bucket. The lookup then returns B before
mptcp_token_accept() has hashed it. The later "net: mptcp: reject token 0
in mptcp_token_get_sock()" patch doesn't change this.

The precedent cited in the commit message, __inet_lookup_established(),
also rejects unhashed sockets after the acquire increment:

	if (unlikely(!refcount_inc_not_zero_acquire(&sk->sk_refcnt)))
		goto out;
	if (unlikely(hlist_nulls_unhashed_lockless(&sk->sk_nulls_node) ||
		     !inet_match(net, sk, acookie, ports, dif,
				 sdif))) {

sk_clone() calls sk_node_init() before it publishes the refcount, so that
check would reject B.

Should both mptcp sites also re-check
hlist_nulls_unhashed_lockless(&sk->sk_nulls_node) after taking the
reference? Alternatively, could the clone path publish its refcount only
after the MPTCP identity is set?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/tencent_D0DCF4B132B20B70FB5AE2D9272AA4AEAF07%40qq.com

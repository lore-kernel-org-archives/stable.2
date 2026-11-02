Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793657183;
	b=pHpbAW5YqMfu7ZsEm15B8G42PYlLwjZlpb5YoSTWCCVniV751P+BrosB5+EloT2vXJk9
	 RfH1GKt9kIDAs49HZzE8cfxOOsh4IYOySa1pT+mKdU70onkY6s8svOLZWGfr3RblySsIG
	 +MmLzGgcncCHtGYruB5JBRCfQEIUzsj9+CvjKF+bnMrw6Ias/u3iCBe+gYyeXW9pDIee/
	 GHCz2PdnQDRYCt9tCNE5yrhl027WuoMAYCz78jioVTLh9Vma3qcvHBef2xBbuwp+v/xWe
	 SMd747YImARpEVlWDZhjRuHvO8AbDrNFFMJvvwac7S/HHsz+0Bfeb22mqBmrZwthqXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793657183;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=oHVRwxPlSk/JyNscj6Ule5aI2QG99S1MAEWeHilouBQ=;
	b=MKmfd2oqdtUUMTq7laortHmF9Yjx4QoFeXZUh+oX7GNVogrMhiDSJT2mTBecS5o1zLz8
	 M9XJll23pTiHE6ZDQBHgiw2594hqM2KyljFH+twqWtDdIDPIytpU4TdpI8k8JfIGoix8I
	 Iem/p3NmdsNu1rTiID00bVcVy3AERjFIa987O0QFbypxI7obCBvXcUZ0+0UpmmnSz7+fL
	 tKYJbh5wGyIly5GWemI6LB1JCoPY/RMHIRR/cmftzv0b72Yk3ymxK4/hBjC6lPfNaggig
	 FTA3cKb1kcrnLJkoqlt9pN7oPUsX6suvWPW7+YeDcD7wObFbxlz+fxPkGxCAZ17ZZ7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EHFFcE1t;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDB7606A324;
	Mon,  2 Nov 2026 22:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EHFFcE1t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BAA71F00A17;
	Mon,  2 Nov 2026 22:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793657183;
	bh=oHVRwxPlSk/JyNscj6Ule5aI2QG99S1MAEWeHilouBQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EHFFcE1tHXMl2BkkcDa8w7TujxxivdQDMsCcsiHWxnwsdqlBzQCByCbnml55EhnVM
	 iXCGGxJXcUF0jbnrXC4bQY6kzb6uDlWMWZK2MvsEsDcEhDXR67m+/sDHcfSU+aQA4O
	 ouZE+73rOmTRat0zWuH5QkfQSRrwYlGMW9K95bvKOx12zjHp6HyRRpEsTV0eqIoedH
	 Tj/7ieTfuZiPce/wg8ykbsg2gtA8ZBHX2aXVExosx/GGPWX9ffWB0BxXlO/r2qZhdU
	 C2gqfEl6SHTkO8bIarh0a83ARl5J4kgTu8IJbIPAwIiyeAzgXoR66qIOLEbbVBgOrR
	 +fSgRXOozppOw==
Subject: Re: [PATCH net v5 2/2] net: restore refcount ordering for lockless
 socket access
From: netdev-bot+sashiko@kernel.org
To: imv4bel@gmail.com
Cc: edumazet@kernel.org, ncardwell@google.com, kuniyu@google.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 martin.lau@linux.dev, john.fastabend@gmail.com, weiwan@google.com,
 sd@queasysnail.net, jiayuan.chen@linux.dev, netdev@vger.kernel.org,
 stable@vger.kernel.org
Date: Mon, 02 Nov 2026 22:06:21 +0000
Message-ID: <179365718192.3131.3817815695107204474@kernel.org>
In-Reply-To: <20261029214219.1035176-3-imv4bel@gmail.com>
References: <20261029214219.1035176-3-imv4bel@gmail.com>
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

Critical: 0 · High: 2 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The bpf_sk_assign() change in net/core/filter.c does not fix the
  problem that its Fixes: 27e5203bd9c5 tag points at.
- [High] The patch is titled "restore refcount ordering for lockless
  socket access" and converts lockless lookups "where the socket is…

--

net: restore refcount ordering for lockless socket access

This patch switches the IPv4/IPv6 established lookups, inet_twsk_purge()
and bpf_sk_assign() to refcount_inc_not_zero_acquire(). It also uses
refcount_set_release() when setting refcounts in the SYN cookie, TCP Fast
Open, request migration and TIME_WAIT paths.

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 09c60a58c82ab..d832d3332c6f9 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -8022,7 +8022,7 @@ BPF_CALL_3(bpf_sk_assign, struct sk_buff *, skb, struct sock *, sk, u64, flags)
>  	if (sk_unhashed(sk))
>  		return -EOPNOTSUPP;
>  	if (sk_is_refcounted(sk) &&
> -	    unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
> +	    unlikely(!refcount_inc_not_zero_acquire(&sk->sk_refcnt)))
>  		return -ENOENT;
>  
>  	skb_orphan(skb);

[Severity: High]
Does acquire ordering here fix the unreferenced BTF pointer case that the
Fixes: 27e5203bd9c5 tag refers to?

Acquire only orders the accesses that come after the increment. In
bpf_sk_assign(), every check on the socket runs before it:

    if (unlikely(dev_net(skb->dev) != sock_net(sk)))
        return -ENETUNREACH;
    if (sk_unhashed(sk))
        return -EOPNOTSUPP;
    if (sk_is_refcounted(sk) &&
        unlikely(!refcount_inc_not_zero_acquire(&sk->sk_refcnt)))
        return -ENOENT;

    skb_orphan(skb);
    skb->sk = sk;
    skb->destructor = sock_pfree;

After the increment there are only stores. Nothing is checked again.

The verifier's btf_id_sock_common_types accepts plain, untrusted
PTR_TO_BTF_ID. tcp_prot and tcpv6_prot use SLAB_TYPESAFE_BY_RCU, and
sk_destruct() frees sockets without SOCK_RCU_FREE right away through
__sk_destruct().

Given that, can this sequence happen?

  - socket A passes the netns, hashed and sk_is_refcounted() checks
  - A is freed and its slot is reused as socket B (maybe in another
    netns, or not hashed yet), and B's refcount is set
  - refcount_inc_not_zero_acquire() succeeds on B
  - B is attached to the skb without being checked

inet_steal_sock()/skb_steal_sock() then deliver to the prefetched socket
without checking the netns. That would get around the -ENETUNREACH check.

sock_pfree() and skb_steal_sock() also call sk_is_refcounted() again
later. If the reused object's result differs, could the reference taken
here leak?

This race doesn't depend on memory ordering, and it existed even when the
increment was fully ordered. The established lookups changed by this
patch re-check with inet_match()/inet6_match() and
hlist_nulls_unhashed_lockless() after the increment, then call
sock_gen_put() and retry. bpf_sk_assign() has no such step.

Would it work better to redo the netns, hashed and refcounted checks after
taking the reference and call sock_gen_put() on a mismatch? Rejecting
unreferenced pointers here would be another option.

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
>  			if (unlikely(hlist_nulls_unhashed_lockless(&sk->sk_nulls_node) ||
>  				     !inet_match(net, sk, acookie, ports, dif,

[Severity: High]
The commit message says the change targets lookups "where the socket is
validated again after taking a reference". Should the MPTCP token lookups
be converted too? They follow the same pattern but still use plain
refcount_inc_not_zero():

net/mptcp/token.c:mptcp_token_get_sock() {
    ...
		if (!refcount_inc_not_zero(&sk->sk_refcnt))
			goto not_found;

		if (READ_ONCE(msk->token) != token ||
		    !net_eq(sock_net(sk), net)) {
			sock_put(sk);
			goto again;
		}
    ...
}

mptcp_token_iter_next() does the same thing: it increments and then checks
net_eq() again.

mptcp_prot uses SLAB_TYPESAFE_BY_RCU, and mptcp_sk_clone_init() clears
SOCK_RCU_FREE on established msks:

    sock_reset_flag(nsk, SOCK_RCU_FREE);

So an msk can be freed and its slot reused while an RCU reader still holds
the address.

On weakly ordered CPUs, can the token and sk_net loads in the re-check run
before the increment? If so, they could see the old object's values, and
the lookup would return a referenced msk for a different connection or
netns.

Callers include the userspace PM netlink operations that look up by
token, MP_JOIN handling in subflow.c and syncookies.c, and the diag and PM
iterators. HMAC validation would probably reject most of the MP_JOIN
cases.

mptcp_subflow_reqsk_clone() already uses refcount_inc_not_zero_acquire()
on the same msk objects.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261029214219.1035176-1-imv4bel%40gmail.com

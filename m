Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793692063;
	b=igbmkYz1baw3X4nwgC2SqUQtxSNnrRC8TjS7LZd2qSri8U7iePrmrd2bc3BESWZyeP37
	 dZO1hBc6UbI1bZsHF51iIAFNJyRq4zI9lcknavDJ/ATvisF8NKtA/hpjdTlp8TX1GybEX
	 2rn1KNdP+6vxuGfDRmrO0tI6ZjeggWl2aWFkWHXTgmR2N31NSOgGMT5c/xm92at5rp4WH
	 4X5TfyFI7gYBlHe5YeT/mUx0X31oJEcieGoROhKi24I635Y5YotCeRy7cdmUH5ZXWwOgK
	 qP/+cMHKh2lt1o+E/Su8T4FrlHD2w4mUAJ3rW23uMhMhm9qYV21fNmd2kdfQmx0fxJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793692063;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=SiS3bHGXKer+FG4HYVMft9Z05AkVrzfkAsqiHFppr9E=;
	b=yXg2lId2ox5VGiArO2fYaTsucA00ZKVzJnAzutLeLSBBX9+B2wkwz2x6NtK97FaDf2Gx
	 s0ivIg18fHQb1O87YElXtI7o2mgBnmqQan4FyBjGmiRIlKv6RW5HKxgsL/8DiWSC6NfuT
	 fQG1tX9URZTE3Ci9s91b1HREKgX1Bod/caFA7IFeDY35y2OYIEVztNwZFTq5RdoGwBhmW
	 mNqlAcUikVPxVEeIcwg8bAAF16xtl2xUcRtEjMjyLQHz/K34iVa3QfzlB5OUlkDzi09vt
	 eUpMoky5mkZp8lXrGxRzhCpYjSqQEhyOCamKS4E0Sl6r347q4Qqa+5hjYtXfRN27M3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uLflxTNm;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B9D606A324
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 07:47:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85B9D606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uLflxTNm
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ac6794fe45so2833534a91.0
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 23:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793692062; x=1794296862; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SiS3bHGXKer+FG4HYVMft9Z05AkVrzfkAsqiHFppr9E=;
        b=uLflxTNmDCQjk0mxG+MJu8qA+DDnGZnWlIxaijNp1Ja4P9LOWNENStOXpv3DEJKUzW
         VoenYY3KC67voxwUJq/os5zvaoGwyV0Zkrn5YeJiD48joUBIdGXUB8rv//0bxINqGZI/
         9uVB6MCAnCDAZLxSdT0fOSPMN0Qre4NAKgSY9dfQIlKj+7AqzGOeSk2qDNKRmbFVCK4L
         25JSy/ks3M7cqLAp43cwiUg6YFr7fRodlMV5Vlrx+NiReAPLE/CN3Lg9dtGnB6A9Os/N
         vj2dcAE23s18ZUZh4NeeldJoavcJK25ffmu2Gzz+A0riO1OJVmsNXNqRtqFVNuDRxh1+
         Fphw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793692062; x=1794296862;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SiS3bHGXKer+FG4HYVMft9Z05AkVrzfkAsqiHFppr9E=;
        b=qUJAcglQq3q8pkEDfktalZOBpRD/hflJMQg7xpP1m0M3kHreiCZqEHcKIgxLko4FGr
         nQu3VYH9TUc5/0wVUZdMmpGdoDyh1xPZY2G56EsDnEBvcotnpzNGZ5uPBkR24Cw/+CL7
         ztY/2CAvlKZ2w3rhJsrqwCzkOlpvalLx/bnQ6EnxRPA6UBNyG9Mfdpa+hpZY3hPNPwia
         Tf4A82OZ1UTZ/zQ66Bb286kF6A3YeOcqTO5ZWVS6ma/GiD3frRnl7RhOXmSZ0AV38t55
         V2ZVJxHkEIuLOCHjf/zAWclwE/7nBRhUzhM8/TBNBUOYKviK35YTXKlI1l1VD4rl2oQo
         9sIQ==
X-Forwarded-Encrypted: i=1; AKwUvBzMASSYx4sv9GLc0wb9Wo9F33mq75dw+JMDqdK9Q6MRJuEIKVGskC7XQR3zytq3oO2hCoXoVGI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ZR2EAaaPvXJjPS3vx1tUv6S53yWDMOs366qw/mRUCyLR3auHs
	YtLwmCCt5BeceFiSSION6buQiY43CXsEM7iq4rFO2/yzh2Ezk3NsEFjN
X-Gm-Gg: AYBFou20Os5VNRcdzSneAAV3AgcLds+/SRakwsEqs/Z3Z0Yub2wLPaPKVQukOtYw0ed
	zIyAA5dqbYtgr2OGxUncasnzj+6TCdy2QWCxMqEpEngXvlZD0TQcyWGmTEgUNwuRqUNhiU/kK7c
	bWx+mlYO5U4uZNFdWnR/oW04SZe9Bv+eFCBYZ3CyQhhXUx7C1fkw/saIqqC/0Iw6BPbe/D6srL2
	7b0txEp5uDDuYuGHEf0dcguzOTv4e9Xqt25yWzUqhU6wnc/QzFbJBoEdRyQVM+LHvCSmoO2KSXf
	mChnRAWuDvrO67aMeFDb+6eSWZGixYU5so5eSBeQUU2Hh8qyNAx0KsJXrc9PzecjLtwSZW+siur
	6A6fHBosamH3Zl0aplDLdwbrOIx6xGYWtZO2GwLV0YW/QC3DyAnHT/jTu87OY8D6NNF1TR+6F2P
	L/wGxWL260ajKyqnFcn/G/JM3W/muWNENI/TnaV/bh+49l1a66rWR1BkRpQNzt5vfo/F56zFeFr
	UHUv8Vx/bsCxwt7mybtdw9HEL6WJ0BS+LzmeHANpTcGFtgskhmj108A6NPrBtxCLM3++6gokcMv
	243TFWXynYpEF7WZa1LpCKF28B2pHs0edD7J271enUUw+/U=
X-Received: by 2002:a17:90b:2882:b0:3ac:8897:7b9d with SMTP id 98e67ed59e1d1-3ae89574cd6mr10822931a91.1.1793692061739;
        Mon, 02 Nov 2026 23:47:41 -0800 (PST)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb364a04b8sm874530a12.21.2026.11.02.23.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 23:47:41 -0800 (PST)
Date: Tue, 3 Nov 2026 16:47:36 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: edumazet@kernel.org, ncardwell@google.com, kuniyu@google.com,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, martin.lau@linux.dev, john.fastabend@gmail.com,
	weiwan@google.com, sd@queasysnail.net, jiayuan.chen@linux.dev,
	netdev@vger.kernel.org, stable@vger.kernel.org, imv4bel@gmail.com
Subject: Re: [PATCH net v5 2/2] net: restore refcount ordering for lockless
 socket access
Message-ID: <aumRmClW0OQ3iJzz@v4bel>
References: <20261029214219.1035176-3-imv4bel@gmail.com>
 <179365718192.3131.3817815695107204474@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179365718192.3131.3817815695107204474@kernel.org>

On Mon, Nov 02, 2026 at 10:06:21PM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 2 · Medium: 0 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] The bpf_sk_assign() change in net/core/filter.c does not fix the
>   problem that its Fixes: 27e5203bd9c5 tag points at.
> - [High] The patch is titled "restore refcount ordering for lockless
>   socket access" and converts lockless lookups "where the socket is…
> 
> --
> 
> net: restore refcount ordering for lockless socket access
> 
> This patch switches the IPv4/IPv6 established lookups, inet_twsk_purge()
> and bpf_sk_assign() to refcount_inc_not_zero_acquire(). It also uses
> refcount_set_release() when setting refcounts in the SYN cookie, TCP Fast
> Open, request migration and TIME_WAIT paths.
> 
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 09c60a58c82ab..d832d3332c6f9 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -8022,7 +8022,7 @@ BPF_CALL_3(bpf_sk_assign, struct sk_buff *, skb, struct sock *, sk, u64, flags)
> >  	if (sk_unhashed(sk))
> >  		return -EOPNOTSUPP;
> >  	if (sk_is_refcounted(sk) &&
> > -	    unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
> > +	    unlikely(!refcount_inc_not_zero_acquire(&sk->sk_refcnt)))
> >  		return -ENOENT;
> >  
> >  	skb_orphan(skb);
> 
> [Severity: High]
> Does acquire ordering here fix the unreferenced BTF pointer case that the
> Fixes: 27e5203bd9c5 tag refers to?
> 
> Acquire only orders the accesses that come after the increment. In
> bpf_sk_assign(), every check on the socket runs before it:
> 
>     if (unlikely(dev_net(skb->dev) != sock_net(sk)))
>         return -ENETUNREACH;
>     if (sk_unhashed(sk))
>         return -EOPNOTSUPP;
>     if (sk_is_refcounted(sk) &&
>         unlikely(!refcount_inc_not_zero_acquire(&sk->sk_refcnt)))
>         return -ENOENT;
> 
>     skb_orphan(skb);
>     skb->sk = sk;
>     skb->destructor = sock_pfree;
> 
> After the increment there are only stores. Nothing is checked again.
> 
> The verifier's btf_id_sock_common_types accepts plain, untrusted
> PTR_TO_BTF_ID. tcp_prot and tcpv6_prot use SLAB_TYPESAFE_BY_RCU, and
> sk_destruct() frees sockets without SOCK_RCU_FREE right away through
> __sk_destruct().
> 
> Given that, can this sequence happen?
> 
>   - socket A passes the netns, hashed and sk_is_refcounted() checks
>   - A is freed and its slot is reused as socket B (maybe in another
>     netns, or not hashed yet), and B's refcount is set
>   - refcount_inc_not_zero_acquire() succeeds on B
>   - B is attached to the skb without being checked
> 
> inet_steal_sock()/skb_steal_sock() then deliver to the prefetched socket
> without checking the netns. That would get around the -ENETUNREACH check.
> 
> sock_pfree() and skb_steal_sock() also call sk_is_refcounted() again
> later. If the reused object's result differs, could the reference taken
> here leak?
> 
> This race doesn't depend on memory ordering, and it existed even when the
> increment was fully ordered. The established lookups changed by this
> patch re-check with inet_match()/inet6_match() and
> hlist_nulls_unhashed_lockless() after the increment, then call
> sock_gen_put() and retry. bpf_sk_assign() has no such step.
> 
> Would it work better to redo the netns, hashed and refcounted checks after
> taking the reference and call sock_gen_put() on a mismatch? Rejecting
> unreferenced pointers here would be another option.

This is beyond the ordering fix and would complicate the patch. I'll 
address it in a follow-up patch.

> 
> > diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> > index b0239d203f045..860145d810ed4 100644
> > --- a/net/ipv4/inet_hashtables.c
> > +++ b/net/ipv4/inet_hashtables.c
> > @@ -550,7 +550,7 @@ struct sock *__inet_lookup_established(const struct net *net,
> >  		if (sk->sk_hash != hash)
> >  			continue;
> >  		if (likely(inet_match(net, sk, acookie, ports, dif, sdif))) {
> > -			if (unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
> > +			if (unlikely(!refcount_inc_not_zero_acquire(&sk->sk_refcnt)))
> >  				goto out;
> >  			if (unlikely(hlist_nulls_unhashed_lockless(&sk->sk_nulls_node) ||
> >  				     !inet_match(net, sk, acookie, ports, dif,
> 
> [Severity: High]
> The commit message says the change targets lookups "where the socket is
> validated again after taking a reference". Should the MPTCP token lookups
> be converted too? They follow the same pattern but still use plain
> refcount_inc_not_zero():
> 
> net/mptcp/token.c:mptcp_token_get_sock() {
>     ...
> 		if (!refcount_inc_not_zero(&sk->sk_refcnt))
> 			goto not_found;
> 
> 		if (READ_ONCE(msk->token) != token ||
> 		    !net_eq(sock_net(sk), net)) {
> 			sock_put(sk);
> 			goto again;
> 		}
>     ...
> }
> 
> mptcp_token_iter_next() does the same thing: it increments and then checks
> net_eq() again.
> 
> mptcp_prot uses SLAB_TYPESAFE_BY_RCU, and mptcp_sk_clone_init() clears
> SOCK_RCU_FREE on established msks:
> 
>     sock_reset_flag(nsk, SOCK_RCU_FREE);
> 
> So an msk can be freed and its slot reused while an RCU reader still holds
> the address.
> 
> On weakly ordered CPUs, can the token and sk_net loads in the re-check run
> before the increment? If so, they could see the old object's values, and
> the lookup would return a referenced msk for a different connection or
> netns.
> 
> Callers include the userspace PM netlink operations that look up by
> token, MP_JOIN handling in subflow.c and syncookies.c, and the diag and PM
> iterators. HMAC validation would probably reject most of the MP_JOIN
> cases.
> 
> mptcp_subflow_reqsk_clone() already uses refcount_inc_not_zero_acquire()
> on the same msk objects.
> 
> -- 
> Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261029214219.1035176-1-imv4bel%40gmail.com

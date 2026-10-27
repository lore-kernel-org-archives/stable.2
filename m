Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793080514;
	b=btfR3SxLoWVmDMdqqI3ZVupPHz3/sgSg/EYW6bqLaBIQ4VnB7nZZvZde1fPFVP87X59D
	 QpiXAt3chVC9dtCr1ubtCwJpwo7//JiVHkjIGdEOjwr0Ho0d6MM7+XX0SeGyWuhgkZStu
	 QtoASRw8gi22W0cZrbCPDgRBsi14pcLSZgSgNATIUwXopnhH2prDgHyg8yWYhf4M9VhB1
	 i9XTNlLVYM6G6/hk/I+FVBR/RD0ccS0giqddKZXJvNn9OlH7qXBuWvw6+Pys0yfQUyflT
	 lJiQ9J/MbK1yivF0jf2bKIYDKjM8Wc9EYET5pLSDfH7gQS4umgfhTmay+HY1Q6UCXJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793080514;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=2I/jzg7WgJ3LoL18fXMyofGaArzp2mzlrfAX2Uqrog8=;
	b=3mysAWTFKd/n9NTzFDm7l0zSbD9pESl0zF5OFucGDBMymrChTpJ+jRdvCJXgzmpA3ysz
	 /DNIoBdsco9EXQofmoQxxVBM0S4fEYeOJVrB1LInZzHZMdF55TB2WaIwtVYGsjKTTynxo
	 av1Iu8kbGYHRbQOAYGLfweFhtobp2mbP2Wd1AOLXjkBndtDOHrOC8Wqi8Y96B+F6xdLtn
	 c9EwUx0zMrjCss4tuJym1YOlFf9lfOalfI1bVBTSW4+vXpd3GHcCKU4XT3lv3KjYe/L/P
	 t2784l09FzlKWmRwmyKPWtywWGWTmKmVuJBEUkft/oVdG5/T74supH2bYyetSwTm8MA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RTO0YQaW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3913606A322;
	Tue, 27 Oct 2026 05:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RTO0YQaW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0D0B1F01828;
	Tue, 27 Oct 2026 05:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793080513;
	bh=2I/jzg7WgJ3LoL18fXMyofGaArzp2mzlrfAX2Uqrog8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RTO0YQaWKGiuOkNydkjp9F0al4OwblPd0GYhllMy2sm19Y8JqUcgO9O3b1/KdXTIv
	 5/ra9NTHNFcz+DUsB5GzL2ouUTpEUN568x/hf9G2eVZVajy8OSb2G1D3E/QjzZ8ger
	 XDTSy+6YUzw3iKN1K1wdjHxmIQMdWne8faQzUWdh73hGAIk6JKnGSLCjvTsof8k2D3
	 ZBvYhzMwjhOXVIhEEyX8DJ9riNHmKtfxXGvfjrxLPTgc6dv7A8wagr80H0wn2mOMhb
	 ua9tKgcHzReEiJmIOYBg3S9Pt/hKp/tpl4MwgtjHAoH1IKGESgH7b0FzeYa8Aw9J+C
	 RiNxd1KxMjpgQ==
Subject: Re: [PATCH net v2 1/2] inet: reject unhashed sockets during
 established lookups
From: netdev-bot+sashiko@kernel.org
To: imv4bel@gmail.com
Cc: edumazet@kernel.org, ncardwell@google.com, kuniyu@google.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 martin.lau@linux.dev, john.fastabend@gmail.com, weiwan@google.com,
 sd@queasysnail.net, jiayuan.chen@linux.dev, netdev@vger.kernel.org,
 stable@vger.kernel.org
Date: Tue, 27 Oct 2026 05:55:12 +0000
Message-ID: <179308051231.3134.13492846570151635023@kernel.org>
In-Reply-To: <20261023052542.3505250-2-imv4bel@gmail.com>
References: <20261023052542.3505250-2-imv4bel@gmail.com>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] At this commit, the new post-reference checks
  hlist_nulls_unhashed_lockless(&sk->sk_nulls_node) and…

--

inet: reject unhashed sockets during established lookups

This commit adds an hlist_nulls_unhashed_lockless() check after the
reference is taken in __inet_lookup_established() and
__inet6_lookup_established(). A lookup that races with
SLAB_TYPESAFE_BY_RCU reuse of a socket now restarts instead of returning
an unhashed object. The SYN cookie, Fast Open and request migration
failure paths now drop references with reqsk_put() instead of calling
__reqsk_free() directly.

> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> index 5abcb0debb270..b0239d203f045 100644
> --- a/net/ipv4/inet_hashtables.c
> +++ b/net/ipv4/inet_hashtables.c
> @@ -552,8 +552,9 @@ struct sock *__inet_lookup_established(const struct net *net,
>  		if (likely(inet_match(net, sk, acookie, ports, dif, sdif))) {
>  			if (unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
>  				goto out;
> -			if (unlikely(!inet_match(net, sk, acookie,
> -						 ports, dif, sdif))) {
> +			if (unlikely(hlist_nulls_unhashed_lockless(&sk->sk_nulls_node) ||
> +				     !inet_match(net, sk, acookie, ports, dif,
> +						 sdif))) {

[Severity: Low]
On weakly ordered architectures, are the new pprev load and the repeated
tuple check guaranteed to happen after the refcount increment?

refcount_inc_not_zero() is relaxed here. At this commit, the code that
publishes a nonzero refcount on never-hashed request sockets also uses
plain stores:

net/ipv4/syncookies.c:tcp_get_cookie_sock() {
    ...
	if (child) {
		refcount_set(&req->rsk_refcnt, 1);
    ...
}

net/ipv4/tcp_fastopen.c:tcp_fastopen_create_child() {
    ...
	refcount_set(&req->rsk_refcnt, 2);
    ...
}

The inet_reqsk_clone() users do the same. They are reqsk_timer_handler()
(refcount_set(&nreq->rsk_refcnt, 2 + 1)), inet_csk_complete_hashdance()
and inet_csk_listen_stop() (refcount_set(&nreq->rsk_refcnt, 1)).

On arm64 or POWER, the hlist_nulls_unhashed_lockless() and inet_match()
loads could be satisfied before the cmpxchg in refcount_inc_not_zero().
If so, the lookup could still return the recycled, unhashed SYN cookie
reqsk with rsk_listener == NULL. That is the tcp_v4_rcv() crash described
in the commit message. The same applies to __inet6_lookup_established(),
which also uses a relaxed refcount_inc_not_zero() before the new check.

This ordering is older than this patch. It is fully fixed by the next
patch in the series, "inet: restore refcount ordering for established
lookups". That patch switches both lookups to
refcount_inc_not_zero_acquire(), and switches tcp_get_cookie_sock(),
tcp_fastopen_create_child() (moving the set after initialization),
reqsk_timer_handler(), inet_csk_complete_hashdance(),
inet_csk_listen_stop() and sk_clone() to refcount_set_release().

Both patches carry Cc: stable. Should they be marked so that they are
backported together, so that this one is not picked up alone?

>  				sock_gen_put(sk);
>  				goto begin;
>  			}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261023052542.3505250-1-imv4bel%40gmail.com

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793657182;
	b=jf8qOwFioWAuWIdRmvBRYEjmrK+4Y6Lt8cVFCQi6stqUL6OWv7GLvCGeCbn83N2cvqvN
	 ac7NS+ukfhv/VAxYYblBdtKZPZKnRRRi3/NivlctrjGNFDz1qIHoHPT+nl8dEata4avQ/
	 Nsrnuez4+Oi5JhqmtlsfDlsPwEZsSnDW9VJuu/hxYEg+4sjnxxNiNy/XAyOabh1PvoFTn
	 GvmtHbQpb0DMms4zhb7FBTjwRtOoc55z7OqMF9MwmjWxL5vxthW0mwlSfskXn9SKi2Zmv
	 NVb476fgt/77m36MryZQBtVJZ2+V41eNFASQhkTKF/vr1YPPU5Qfd01hLjKdfgZn8mQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793657182;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Um07/kiEpvfKEz+oA0JV8ogF50fMeuEiH91twRDY2rE=;
	b=IQXLLEkOiOmJMRlRhuIwZ0lkvbt2hcxP088KAx2iOUhwHqMTVuj3S5U/aSUh8YTCqkmu
	 6GcjS8zhcFWM5DX9MEbV8zmVeD9vYyla1y8UFDA5dwQSoXQgUVvcpMK+6nYvJO8JUDrAO
	 i7yR73OUU3RrRlSJpsjZ4gynZyYErQhs7+UQKELNPSsU1y5aQ3fPtAzCvPN8BuGzwLH93
	 EpM1cxYsFORtEXi9df8HkcLy7ZjUV22v57Nzib+lsWoGpeU+0GFDvU0k5UtGOSGW6g4Ck
	 JLfM+f4jft+3Yxoarldao3ADt5ZhnzL8TzkmLog7xF7usXOGNB9FQFIXS75IBtkdhZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jw8uLxxn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF63606A329;
	Mon,  2 Nov 2026 22:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jw8uLxxn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07ACE1F00A16;
	Mon,  2 Nov 2026 22:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793657181;
	bh=Um07/kiEpvfKEz+oA0JV8ogF50fMeuEiH91twRDY2rE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Jw8uLxxnoQskGA+iwpftLPclOxu4AuAOvBvwzxu1OBYaSNwMCIvLHTAMEK21uGlkX
	 7P12cuk9IrDK+Qimk4z7l6qVLFK2jxGfgchzRlAfNbhxqVbX0R41/iedGThfqoWEv0
	 jXZ8OVhPiopwo7SQUC5SkH5Fs9H4vXgL9lKLpwPSBkMEVY6DInnriVfgJAMRJ3FOeO
	 aMpUgYpMWbThjMvp2CtC6cD0rvjTX4Fjhjfq45ugsSm0aJEdWk3Wh94QUtn40awBzV
	 X/uwTgQoeErFRmLWtjhNYQ+qgS4j0nHBduPrqgPnI7f4iuSR2wrYlEWMSKYOgIEDCn
	 P7vdF6IKqP63A==
Subject: Re: [PATCH net v5 1/2] inet: reject unhashed sockets during
 established lookups
From: netdev-bot+sashiko@kernel.org
To: imv4bel@gmail.com
Cc: edumazet@kernel.org, ncardwell@google.com, kuniyu@google.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 martin.lau@linux.dev, john.fastabend@gmail.com, weiwan@google.com,
 sd@queasysnail.net, jiayuan.chen@linux.dev, netdev@vger.kernel.org,
 stable@vger.kernel.org
Date: Mon, 02 Nov 2026 22:06:20 +0000
Message-ID: <179365718057.3131.4671197978037510599@kernel.org>
In-Reply-To: <20261029214219.1035176-2-imv4bel@gmail.com>
References: <20261029214219.1035176-2-imv4bel@gmail.com>
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

- [Low] In this commit by itself, the new
  `hlist_nulls_unhashed_lockless(&sk->sk_nulls_node)` check in…

--

inet: reject unhashed sockets during established lookups

This commit adds a hlist_nulls_unhashed_lockless() check after the
reference is taken in __inet_lookup_established() and
__inet6_lookup_established(). A lookup that races with SLAB_TYPESAFE_BY_RCU
reuse can no longer return a request socket that was never hashed. It also
changes the SYN cookie, Fast Open and request migration failure paths to
drop references with reqsk_put() instead of calling __reqsk_free().

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
If this commit is applied by itself, is the new unhashed check ordered
after the refcount increment?

refcount_inc_not_zero() here is a relaxed cmpxchg. The writers that make
never-hashed request sockets referenceable also use a plain refcount_set():

net/ipv4/syncookies.c:tcp_get_cookie_sock() {
    ...
	if (child) {
		refcount_set(&req->rsk_refcnt, 1);
    ...
}

The same applies to tcp_fastopen_create_child(), and to the migration
clones in reqsk_timer_handler(), inet_csk_complete_hashdance() and
inet_csk_listen_stop().

On weakly ordered CPUs, can the pprev load in
hlist_nulls_unhashed_lockless() and the inet_match() reload be satisfied
before the increment? They could then see the old, hashed incarnation,
while the increment succeeds on the new, unhashed SYN cookie request whose
rsk_listener is NULL. That is the tcp_v4_rcv() NULL dereference this
commit describes. __inet6_lookup_established() has the same pattern.

The next patch in the series, "net: restore refcount ordering for lockless
socket access", resolves this. It switches both lookups to
refcount_inc_not_zero_acquire(), and switches tcp_get_cookie_sock(),
tcp_fastopen_create_child() and the three migration writers to
refcount_set_release().

Both patches are tagged Cc: stable. Should the two be backported together,
so stable trees don't pick up this one without the ordering fix?

>  				sock_gen_put(sk);
>  				goto begin;
>  			}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261029214219.1035176-1-imv4bel%40gmail.com

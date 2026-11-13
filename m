Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794575112;
	b=FzctZ2lC86mydcPko9FHXYVI0wSUMfHVfkPuog4xfTldPj9WzSSKibgyRCE+d9UU+lAU
	 sH56HZuNQEyRiG0bgjN0HxwI/ncMbNped8BS44JQjPffjKR872SIXtvNBmz8PVed1m9fo
	 or2KJ5fxA7au1eXqmMy9Bs+s8VMbkGz1rJ7zyyTEHxIM1zfT1vdZy72o/J/hLFBZx6xWH
	 rDZBN0AhCn4CtxnFaXxgRhyXAm9Mm4wxTEStWLgbVENhdJwlTVZQMRwwSH5hVOrGenUsM
	 Uq1dib/JflqkqblEcNRm+mDcG1AiMJC4UjaSEvZE7xTrGTrUNkreiRAm9lGnOap9QYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794575112;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=l9v3zwMWD2nkh/ZKIRfl7G0ROqQEok64RLBR5wNEh5I=;
	b=caiTG0cqtC6lEokyoEq1fSgRle67N0VFYbFUR6pBxz9hIQtTHZ6RYMGeZxgyw5+zvCSL
	 xWQP39bi0/Bm/Ol5oUNzwAfqjo+o/BA8jYTDnmM3P+IfET7CA/Gnw9Z2Xpbz2yyN0Y/c0
	 RNIwJj0HkxaIr1+fDToYVwEkEy8ixyAURp3XW+LFn7x9ueAds4SrZwv2iUUrgsKiqCybX
	 87ffX2ydFxp0Si1L1P9BbcybkrkW9ADeZw8uGL90iI4b3tpcchZeBbeo6+38/cTd3Dqxo
	 KRPt6ye8f9K2mLtL/Vk9uYvwuTN00qaNKv9ggUPWwyqbx+QSNZ4RERCpiU2welrnkCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Px8Cxf1H;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE37606A89B;
	Fri, 13 Nov 2026 13:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Px8Cxf1H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3A661F000C4;
	Fri, 13 Nov 2026 13:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794575112;
	bh=l9v3zwMWD2nkh/ZKIRfl7G0ROqQEok64RLBR5wNEh5I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Px8Cxf1Hxtkyyn3O8M7ApHDT1lRij38hb+z4J454s13ojdy6ZOij5HTe9Groa/gT2
	 yLan5U4EMd266Xnc7i/1Kx2zkHRctMunDsY1sMrkN77+JKcCHYzpb0J1BOE9J+6pq9
	 0Z9ginPxEv0uwPueUCOZhA7M0FjjBLgbO/26SwDz85Pu1jELebiqmA1kVLGkd3CANu
	 OCd8fliUGFriMRX0w0FXYbVKU/u05NxaE/yC9JrrDKaZ9BUUMI/F7XWKKWPeuLVRhQ
	 ZXddcOJMmdmgmQitvy8XsxcYJfzYC4jD6PxplJIUrx6VGhvfmRvGMyKqY+De3xfpV7
	 o0h/P7dYKsmaQ==
Subject: Re: [PATCH net 2/2] net: core: take the reuseport migration reference
 with acquire ordering
From: netdev-bot+sashiko@kernel.org
To: 2122295973@qq.com
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, matttbe@kernel.org,
 martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, willemb@google.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Date: Fri, 13 Nov 2026 13:05:11 +0000
Message-ID: <179457511118.2199510.8206170775718086732@kernel.org>
In-Reply-To: <tencent_AE3D481F5F51E98E657317C2F664C4FA4F08@qq.com>
References: <tencent_AE3D481F5F51E98E657317C2F664C4FA4F08@qq.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message says the reuseport_migrate_sock() refcount
  change prevents a listener that is concurrently removed from the…
- [Low] The comment in inet_reqsk_clone()
  (net/ipv4/inet_connection_sock.c:925) says its sock_put(sk) on the…

--

net: core: take the reuseport migration reference with acquire ordering

This commit changes reuseport_migrate_sock() to take the reference on the
selected listener with refcount_inc_not_zero_acquire() instead of
refcount_inc_not_zero(). The stated goal is to stop callers from observing
a listener in a half-torn-down state when it is removed from the reuseport
group at the same time. The patch carries Fixes: and Cc: stable tags.

> diff --git a/net/core/sock_reuseport.c b/net/core/sock_reuseport.c
> index b9e5648fa4c51..56230aa55a3e2 100644
> --- a/net/core/sock_reuseport.c
> +++ b/net/core/sock_reuseport.c
> @@ -667,7 +667,8 @@ struct sock *reuseport_migrate_sock(struct sock *sk,
>  	if (!nsk)
>  		nsk = reuseport_select_sock_by_hash(reuse, hash, socks);
>  
> -	if (IS_ERR_OR_NULL(nsk) || unlikely(!refcount_inc_not_zero(&nsk->sk_refcnt))) {
> +	if (IS_ERR_OR_NULL(nsk) ||
> +	    unlikely(!refcount_inc_not_zero_acquire(&nsk->sk_refcnt))) {

[Severity: Medium]
What does the acquire ordering on this increment order against? The commit
message says:

  A listener removed from the reuseport group concurrently with that
  lookup must not be observed in a half-torn-down state after the
  reference was successfully taken.

reuseport_migrate_sock() picks nsk from reuse->socks[] while holding
rcu_read_lock(). Every hashed listener gets SOCK_RCU_FREE in
__inet_hash():

net/ipv4/inet_hashtables.c:__inet_hash() {
    ...
	sock_set_flag(sk, SOCK_RCU_FREE);
    ...
}

So the listener's memory cannot be freed or reused for another socket
inside this RCU section. Also, nothing after the increment re-validates
nsk. There is no sk_state or sk_reuseport_cb re-check before nsk is
returned.

The contract for the helper in include/linux/refcount.h limits it to that
reuse case:

  refcount_{add|inc}_not_zero_acquire() and refcount_set_release() provide
  acquire and release ordering for cases when the memory occupied by the
  object might be reused to store another object. This is important for the
  cases where secondary validation is required to detect such reuse, e.g.
  SLAB_TYPESAFE_BY_RCU. The secondary validation checks have to happen after
  the refcount is taken, hence acquire order is necessary.

Neither condition holds here. Commit 5b5d8f351dd9, cited as precedent, only
changed sites where the socket is validated again after the reference is
taken. __inet_lookup_established() re-runs inet_match() and checks the
unhashed state, and inet_twsk_purge() re-checks check_net(). Its
bpf_sk_assign() change had a separate justification: a BTF socket pointer
obtained without a reference.

A listener that is being closed is torn down while the closer still holds
its own reference. That teardown is not published through a release on
sk_refcnt. So even with the acquire, can't a caller still see the closing
listener?

Callers already handle that state with an explicit check, for example in
inet_csk_reqsk_queue_add():

	spin_lock(&queue->rskq_lock);
	if (unlikely(sk->sk_state != TCP_LISTEN)) {
		inet_child_forget(sk, req, child);

The same pattern also exists elsewhere and is left alone. inet_lookup(),
inet6_lookup(), and nf_tproxy_get_sock_v4()/nf_tproxy_get_sock_v6() all
take a reference on an unreferenced listener with plain
refcount_inc_not_zero() and then use it. Those sites look correct for the
same RCU-stable reason, which suggests this one is correct as well without
the change.

Given that, are the Fixes: fb041bb7c0a9 and Cc: stable tags justified?
Could the commit message name a concrete load that can see stale data here,
or include a reproducer? As written, the patch adds a barrier on weakly
ordered architectures but does not change what callers can observe.

>  		nsk = NULL;
>  		goto failure;
>  	}

[Severity: Low]
This isn't a bug, but the comment on the matching release in
inet_reqsk_clone() still names the old primitive:

net/ipv4/inet_connection_sock.c:inet_reqsk_clone() {
    ...
	if (!nreq) {
		__NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMIGRATEREQFAILURE);

		/* paired with refcount_inc_not_zero() in reuseport_migrate_sock() */
		sock_put(sk);
		return NULL;
	}
    ...
}

Should this comment be updated if the switch to
refcount_inc_not_zero_acquire() is kept?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/tencent_28A2BD1631FE531992E91753BA6419FFC506%40qq.com

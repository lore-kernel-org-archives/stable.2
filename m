Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792906829;
	b=e8izMlE5lQpUb+g80dPpSipuR7ywc6TL9/W1fNI7pkBQF79SCDlGsQeRe+9V6JVbu6TW
	 0/XktBymHIoUZTTX1Ptu1NcysayR3yuVhvYKUdNz8EGqqrMa6A3Jocvy20Ebb0G2e9+eB
	 PqDQtq8TDDj9OlHzIUWz1AGFPMT96i6Zq1hN/XQLr1OxfqzuTDC8NrVxr0fM+MbgBlXBX
	 1T7fwuDSXxIbLnSdHPQ76cP1teRPhzEGDnllb1vsbTjwU6PnhtqDpwgTUdr/WAsTfEdnN
	 RAkvAStiHcogEoDVSy2nw9QPMRmOT2EN/4DG9f6477kH8XCqgy9bOfkmeh9Vfaqihpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792906829;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Oyk9A2iyFkq3eDDYq7T87UUW8DmmYChBxVIlTSOMrZo=;
	b=dD66Oz4m7UrXAHvWJl2SAzH5lJjrgK4GgZ/hVeLp8LkpJ4OB8yMa4YtWXbvt3jKekuk0
	 85XHM9ZKKhsIduJmmlWrbqbBXcstwr+3Bpt5oCYq3RYzhn3bJGQdZa8FN+2ZAr3J35pT/
	 UIF6xeeAG8WfAXML4K2vTwZpaFKA2juy6xa2s3pUXUkKNFNTHT7GenRx9wdnFQDYl2FW/
	 lhiFOCV6vx0rYe1oo3qmuK+FNXjDj3sDPZ18FgdJmb/jHUYfMdc04d+eUp+U5i8wp1YJQ
	 0ltWRaHIslyE/TT45jxK9xEds0PotXaRCzWeE9Vnmo06Xl1DTl3tSLTCneNYInvkzlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=khp0Jcs7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19506606A31A;
	Sun, 25 Oct 2026 05:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=khp0Jcs7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC8F41F01825;
	Sun, 25 Oct 2026 05:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792906828;
	bh=Oyk9A2iyFkq3eDDYq7T87UUW8DmmYChBxVIlTSOMrZo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=khp0Jcs7oMZ9Y62iF0XJNq8ejCgPobynPDBwBAYPIp+FRXoa54suxbnrcUU0u4o4B
	 /ekDYf8LHSjjShuxvyllaDNmY4QOqZTQ484sTY3IrvragPfXXg4AZAzH+V0PysSTSu
	 UBH8rSMHRlqP++x3n/fkLUFhw8FHZ0rnChFuLVWBQke0zMzm/d7AKgm+lQxbh4DpmP
	 jXMRUKrS7q6a0GoY9TGnZV5jPJpXhsCUjF1O1BHgY7XHdawsRB6Kd5Ljok+7xWHQ1E
	 aoRId98HpshyXJy75V6qFJ6O2PlaAr2gpKAQnssHcUyiUAIBFqjnG2JQeLsit4KfYe
	 S/gaLguoO2ptQ==
Subject: Re: [PATCH net v3 1/2] inet: reject unhashed sockets during
 established lookups
From: netdev-bot+sashiko@kernel.org
To: imv4bel@gmail.com
Cc: edumazet@kernel.org, ncardwell@google.com, kuniyu@google.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 martin.lau@linux.dev, john.fastabend@gmail.com, weiwan@google.com,
 sd@queasysnail.net, jiayuan.chen@linux.dev, netdev@vger.kernel.org,
 stable@vger.kernel.org
Date: Sun, 25 Oct 2026 05:40:27 +0000
Message-ID: <179290682737.3134.15226698111937751101@kernel.org>
In-Reply-To: <20261024053720.1147022-2-imv4bel@gmail.com>
References: <20261024053720.1147022-2-imv4bel@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The concern: at this commit, __inet_lookup_established() and
  __inet6_lookup_established() take the reference with a relaxed…

--

inet: reject unhashed sockets during established lookups

This patch adds a hlist_nulls_unhashed_lockless() check after the
reference is taken in __inet_lookup_established() and
__inet6_lookup_established(). A SLAB_TYPESAFE_BY_RCU slot that was reused
for an unhashed socket with the same tuple is then rejected. The SYN
cookie, Fast Open and request migration failure paths now use
reqsk_put(), because requests that were never hashed can hold transient
references from stale lookups.

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
>  				sock_gen_put(sk);
>  				goto begin;
>  			}

[Severity: High]
Is the new unhashed check ordered after the refcount increment?

refcount_inc_not_zero() is relaxed. On weakly-ordered CPUs, the loads of
sk->sk_nulls_node.pprev and of the tuple fields in the re-check could
complete before the increment does.

On the writer side, tcp_get_cookie_sock() publishes the refcount of the
never-hashed request (the object reused in the PoC) with a plain store:

net/ipv4/syncookies.c:tcp_get_cookie_sock() {
    ...
	if (child) {
		refcount_set(&req->rsk_refcnt, 1);
    ...
}

tcp_fastopen_create_child() uses the same plain refcount_set() pattern.
So does the cloned nreq in reqsk_timer_handler(),
inet_csk_complete_hashdance() and inet_csk_listen_stop().

According to include/linux/refcount.h, secondary validation under
SLAB_TYPESAFE_BY_RCU needs refcount_inc_not_zero_acquire() paired with
refcount_set_release().

Without that pairing, could a lookup see the new SYN cookie request's
nonzero refcount but still read the old object's non-NULL pprev? It
would then pass both checks and return the unhashed request, with its
NULL rsk_listener, to tcp_v4_rcv(). That is the NULL dereference in the
commit message, here on weakly-ordered architectures.

The same question applies to __inet6_lookup_established().

The next patch in this series, "inet: restore refcount ordering for
established lookups", appears to switch both lookups to
refcount_inc_not_zero_acquire(). It also converts the publishers above to
refcount_set_release(). This patch is tagged for stable. Could the
ordering change be folded into this patch, or could the two patches be
kept together for backports?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261024053720.1147022-1-imv4bel%40gmail.com

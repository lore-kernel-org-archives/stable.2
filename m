Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4521A683D;
	Wed,  5 Aug 2026 00:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785891080; cv=none; b=sQ7B9ttyg6wJ/3OLTVKFX5hizzRe6SRX/kUMJs/4q6nXMyL16gEz/6JyecJd1KKenrSUGLEuZgFleQpiVNQXPhivd9atyOWlnbJwnaq/8f6dsAHTTWpQwpq2CFwQPcDmErO+NOW3g/839Fdj3peRlzT/pm5SdKlxkvRcvR03awM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785891080; c=relaxed/simple;
	bh=fTbST+tLSsf39sdlkpMDK6svcFjRQbdOWE4xII5z0eo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=en+Y6H/VpBLWLZSybqE+aaZmqqGu0HnvcQ4UCTYUe9GvU5PvI+vKvYZTLV9QjRgiPrdh61QtoySIM0MEi70aUysldskCQGN/wys/q+CoUrtx4X67YRYjbQncINVSNPhoHiUxVpAInI+f9qW6mlkNKC/XKq9ExBDmI9UQwlx0u6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QK5XJUmF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QK5XJUmF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 250C71F000E9;
	Wed,  5 Aug 2026 00:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785891078;
	bh=ePPDDaik4Qtf8gXCiiCDMsGPHOTienWAwHlE4JLRsHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QK5XJUmFVYOLJ/OI+AUJ+nJhdhP0TbQs/mHd07EXp3XLtKjIVJmzo+qDx32ztaJX/
	 oD1UC/0hLQUxeTeKZbwxvGpjHbsmWae9MBkZ+ym60M1B+npobujv6shnzq/wjlUg9L
	 7x2IfkvGMTsfxi/BXi3gPLg4A5k6K+7oOiT6gFwkgXfdrNgkRmzJrLuhWG0aukzW1I
	 GNSHrjijiaCig9iculNQb23J2J4hJGQSo7yjO3t03j/o2TIpBEwnxHE9NWy6VLvWsY
	 vRNu3G+OrEn3f5ZWaJDiaW+SzI/88VGH2VCeisSIEubdkqLVlDtiwQa8jKCU+LHa6x
	 4yFYncsAe73YQ==
From: Jakub Kicinski <kuba@kernel.org>
To: nicoyip.dev@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	sbrivio@redhat.com,
	sd@queasysnail.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] ipv4: fix use-after-free in fib_nhc_update_mtu()
Date: Tue,  4 Aug 2026 17:51:16 -0700
Message-ID: <20260805005116.4048739-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731162938.3388534-1-nicoyip.dev@gmail.com>
References: <20260731162938.3388534-1-nicoyip.dev@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email says "Clashiko says we need a real lock?"
---
ipv4: fix use-after-free in fib_nhc_update_mtu()

This wraps the fnhe hash table walk in fib_nhc_update_mtu() with
rcu_read_lock() and switches the pointer loads from
rcu_dereference_protected(..., 1) to rcu_dereference(), so that an fnhe
freed by kfree_rcu() on another CPU cannot be reclaimed while the walk
still holds a pointer to it.

> diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
> index 4f3c0740dde91..6ecc6654427ce 100644
> --- a/net/ipv4/fib_semantics.c
> +++ b/net/ipv4/fib_semantics.c
> @@ -1879,16 +1879,17 @@ void fib_nhc_update_mtu(struct fib_nh_common *nhc, u32 new, u32 orig)
>  	struct fnhe_hash_bucket *bucket;
>  	int i;
>  
> -	bucket = rcu_dereference_protected(nhc->nhc_exceptions, 1);
> +	rcu_read_lock();
> +	bucket = rcu_dereference(nhc->nhc_exceptions);
>  	if (!bucket)
> -		return;
> +		goto out;
>  
>  	for (i = 0; i < FNHE_HASH_SIZE; i++) {
>  		struct fib_nh_exception *fnhe;
>  
> -		for (fnhe = rcu_dereference_protected(bucket[i].chain, 1);
> +		for (fnhe = rcu_dereference(bucket[i].chain);
>  		     fnhe;
> -		     fnhe = rcu_dereference_protected(fnhe->fnhe_next, 1)) {
> +		     fnhe = rcu_dereference(fnhe->fnhe_next)) {
>  			if (fnhe->fnhe_mtu_locked) {
>  				if (new <= fnhe->fnhe_pmtu) {
>  					fnhe->fnhe_pmtu = new;

[Severity: High]
This isn't a race introduced by this patch, but since the patch is
specifically fixing the locking of this walk, is the write side left
unprotected on purpose?

fib_nhc_update_mtu() does not only read the fnhe, it stores to
fnhe->fnhe_pmtu and fnhe->fnhe_mtu_locked, and now does so with only
rcu_read_lock() held. Every other writer of these two fields in
net/ipv4/route.c holds fnhe_lock and treats them as one pair, for example
update_or_create_fnhe():

net/ipv4/route.c:update_or_create_fnhe() {
	spin_lock_bh(&fnhe_lock);
	...
		if (pmtu) {
			fnhe->fnhe_pmtu = pmtu;
			fnhe->fnhe_mtu_locked = lock;
		}
		fnhe->fnhe_expires = max(1UL, expires);
		/* Update all cached dsts too */
		rt = rcu_dereference(fnhe->fnhe_rth_input);
		if (rt)
			fill_route_from_fnhe(rt, fnhe);
	...
}

rt_bind_exception() clears the same pair under fnhe_lock on a genid change,
and fnhe_remove_oldest()/ip_del_fnhe() use
rcu_dereference_protected(..., lockdep_is_held(&fnhe_lock)) for the chain,
which suggests fnhe_lock is the intended write-side lock here.

Can the following interleaving mix the pair?

CPU0: dev_set_mtu() -> netif_set_mtu_ext() -> fib_netdev_event() ->
      fib_sync_mtu() -> fib_nhc_update_mtu()

	} else if (new < fnhe->fnhe_pmtu ||
		   orig == fnhe->fnhe_pmtu) {
		/* fnhe_mtu_locked read as false, condition evaluated */

CPU1: icmp frag-needed in softirq -> __ip_rt_update_pmtu() ->
      update_or_create_fnhe()

	spin_lock_bh(&fnhe_lock);
	fnhe->fnhe_pmtu = pmtu;		/* clamped to ip_rt_min_pmtu */
	fnhe->fnhe_mtu_locked = true;

CPU0 then completes its store:

		fnhe->fnhe_pmtu = new;

leaving fnhe_pmtu set to the device MTU with fnhe_mtu_locked still true,
which neither writer intended. Since ip_mtu_locked() then makes
__ip_rt_update_pmtu() return early, would further PMTU reductions for that
destination be suppressed until the exception expires (ip_rt_mtu_expires,
600s by default, with expiry no longer refreshed because the updates are
skipped)?

The mirror ordering looks like it drops the new device MTU clamp instead,
leaving fnhe_pmtu above the link MTU, which is the condition af7d6cce5369
was added to avoid.

There is also no WRITE_ONCE() on these stores while lockless readers such
as ip_mtu_from_fib_result() consume fnhe_pmtu:

net/ipv4/route.c:ip_mtu_from_fib_result() {
	...
		fnhe = find_exception(nhc, daddr);
		if (fnhe && !time_after_eq(jiffies, fnhe->fnhe_expires))
			mtu = fnhe->fnhe_pmtu;
	...
}

Would taking spin_lock_bh(&fnhe_lock) around the walk (or calling a helper
exported from route.c that does) cover both the reclaim race described in
the changelog and the write-write race, and also keep the
rcu_dereference() annotations honest for a walk that mutates the entries?

The changelog says the change works "without serializing PMTU updates
against the entire hash-table traversal" - is that tradeoff still correct
given the walk writes to the entries it visits?

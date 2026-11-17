Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794909460;
	b=jU8JA3iOmFy0dp3VgzyI02NG74IFqfv9hAKI54MmWm2AEqFUxo3UtDh1b4kGjRpY8Uxd
	 iOjMeSHyMIOcMLvNuaLcL4nLssLFj+pPKetteetbU3Y5Wsy1a4fxQDvobBi8KSLOu0m61
	 AdcJtN8OrBNiympQlDzezpFrXE3Hs6PhhFgFBSaRnj9bAk5peZmGhI2bo+epTHbOmEOwu
	 xBeGXQyzKKcXyr68FBnsSWzxDlxj3qJ8B5Nr3nihNRb2M1RO6eUekqeMVEpB2tZMuyc9I
	 XmxdmmdcCVa7kGBLZBmky5igpH76Z21tJHWfHejhApQ5vSMRfgfbxmD1eHGFsE+4JIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794909460;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=0JQJMqQZzEMkF+mY1cPTdcvEu+ZkGmV0o5FbiuBHi+w=;
	b=5WWu34lMcCOj1ufQgpqG8B9F2NCwbqZQKh9x4gQ2pL3nt3/Ojug/mCbzCTQN/GRMyDnz
	 2GP3fpoxGi2fEh5EJ7hDGxfsbBjZa/e4acUJ6YxtbduR4bljTS7wlE2Ve9ZgwDvJzUAhB
	 wn2ORWkrXUAFVHKwZlztvBh/KBwhp6Lo7j7MIOFH34EWH/NJCzVj+pwlB1rngbxee68E1
	 hpHCs4DR8/VT2VqdznA2jTauXX9icesLEcekf7dThP9msMoYCeVp1EJfF1AqXFSz8J9eE
	 xRIDAd6dV8AfhnPPYp3dwLkQYZwU34RLKqEmtO1TaNxws48ff24fJoD/RxJbq1nK+Gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=BhSj4ci+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B48606A31C
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 09:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=BhSj4ci+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72EBA1F000C6;
	Tue, 17 Nov 2026 09:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1794909459;
	bh=0JQJMqQZzEMkF+mY1cPTdcvEu+ZkGmV0o5FbiuBHi+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BhSj4ci+4wdPPDd+7646E5USh2EVBNXa27jfAcY3X4Ml/ujkLp/MA+DfLYQ77bIU2
	 Hsz3qNikgOwHXqIgb3SHslMfG3J5gkbfyh0Rw9lYWoo8GdMsZIYDJnRuAtRB+J3wIW
	 yV0QOsHbqs3oFtnB0NpYO3FfUmlG3V83kIV+gQ9Y=
Date: Tue, 17 Nov 2026 10:57:23 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: onLeaf <onleaf322@gmail.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH net] netfilter: ipset: exclude add-path GC during resize
Message-ID: <2026111712-unharmed-lugged-b601@gregkh>
References: <20261117092631.14530-1-onleaf322@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261117092631.14530-1-onleaf322@gmail.com>

On Tue, Nov 17, 2026 at 06:26:31PM +0900, onLeaf wrote:
> mtype_resize() copies elements to the new table including their extension
> pointers. Garbage collection of an expired element in the old table after
> the copy therefore frees an extension still referenced by the new table.
> 
> Commit cffcf57bf03c ("netfilter: ipset: exclude gc when resize is in
> progress") prevents the delayed-work collector from running during resize.
> However, mtype_add() also invokes mtype_gc_do() directly when its target
> region is full. The packet path can enter this call while a userspace
> resize is copying the old table. It then frees the old copy's comment, and
> collection of the published copy queues the same object for freeing again.
> 
> An unprivileged process can reach packet-side ipset add with CAP_NET_ADMIN
> in newly created user and network namespaces. The resulting duplicate free
> was reproduced with KASAN on x86-64 and exploited from UID 1000 to UID 0 in
> the initial user namespace on a non-KASAN build.
> 
> Serialize the direct collector with the same GC lock and honor the pinned
> table's resizing flag, just as the delayed-work collector does. The table
> remains pinned by uref while the lock is held.
> 
> The issue was found through AI-assisted source review. On the fixed kernel,
> the same copy/old-GC/publish/new-GC ordering completed without producing a
> duplicate object; /etc/passwd remained unchanged and the test ended in
> LPE_FAIL.
> 
> This change was prepared with assistance from OpenAI Codex.
> 
> Fixes: f66ee0410b1c ("netfilter: ipset: Fix "INFO: rcu detected stall in hash_xxx" reports")
> Cc: stable@vger.kernel.org
> Signed-off-by: onLeaf <onleaf322@gmail.com>
> ---
>  net/netfilter/ipset/ip_set_hash_gen.h | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/net/netfilter/ipset/ip_set_hash_gen.h b/net/netfilter/ipset/ip_set_hash_gen.h
> index 80ca523f304b..70f768ba7b44 100644
> --- a/net/netfilter/ipset/ip_set_hash_gen.h
> +++ b/net/netfilter/ipset/ip_set_hash_gen.h
> @@ -1009,8 +1009,12 @@ mtype_add(struct ip_set *set, void *value, const struct ip_set_ext *ext,
>  	maxelem = t->maxelem;
>  	if (elements >= maxelem) {
>  		u32 e;
> -		if (SET_WITH_TIMEOUT(set))
> -			mtype_gc_do(set, h, t, r);
> +		if (SET_WITH_TIMEOUT(set)) {
> +			spin_lock_bh(&h->gc.lock);
> +			if (!t->resizing)
> +				mtype_gc_do(set, h, t, r);
> +			spin_unlock_bh(&h->gc.lock);
> +		}
>  		maxelem = h->maxelem;
>  		elements = 0;
>  		for (e = 0; e < ahash_numof_locks(t->htable_bits); e++)
> -- 
> 2.43.0
> 
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

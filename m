Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793102130;
	b=EWf+b2nxAeN0A9Q0lt0eYkfX/6XUu0jlkXH6e5Srjnvk2D+cxXFmecOw9oE6i+akhzr0
	 Suce/EFgVxAbej2gPOh9UR83G9xlG3dOTFs2/Y/a9oYrntZXUN/kS0NP6QIqf/np767DF
	 U7BFWCHhuA5t+jsAEfxV12+auGmQwZAT8g9u/a9aEieR+SH7P5zilXAt1CDcfsVeiNLDF
	 gHyn6iNxLB7/kmNAk1kjDjJdMf2fh+zXaNM+GTeKMxPWebqbTJEGp4uJw8YdlitGixyfr
	 Syxf4sOWpPGfD/5IB02SASib9dRqUOYOL5w0qs82EMWHXzrcmvSqnsF/U0fZ5DSwjew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793102130;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=rxmDm29hIYa+G8O63fmxokTTs2LclgKKZv3r9T6ESXM=;
	b=Nj3bXk/nqWs845GQERzMpBVq0B7v0S3Hn9z20jdpTbt0lfAKaMgXt4uldi56J3pSY3Ah
	 Y4hKbjI5Jdbh4MtinPLfgROzDhY77AfxstsaVV+l/w2ZZ8iTW1K38QNFfwk6221bR4mwc
	 fGAsCZ+PGLlptR2OxtAl3CuLp6DV8ET9AqWKMJai2JAgAoFn2gB8uxeKqlpiNf4MfwiZl
	 6TWtf1vJL1TWX+pv6t4J7OkipyVA8x5TlENxi3AjV7hrW8tsbgE2Cxd8pkj8KAE3zSIIx
	 FeXrb4yajitPypAHJ2VUSxDYGmpHxnK0kxIpIaYdyZJO0HdJabzuxazAlQiMjG7vxCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="enn3/JrL";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE3E606A32F;
	Tue, 27 Oct 2026 11:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=enn3/JrL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AE7F1F01825;
	Tue, 27 Oct 2026 11:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793102129;
	bh=rxmDm29hIYa+G8O63fmxokTTs2LclgKKZv3r9T6ESXM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=enn3/JrLknRWmcjTryI3lzsUGgWcSaqpPgbZU+rF8yJBz+1D9xC9zx50/6FozzTse
	 f3sv2hEOkxfTxbFMdLQt6of5wxw6hE4eQ2TnANZJ+onqCF+UhhbQ6xg7koEaQXyKCI
	 hwJVHxIeKy5NLpCZklENjBwgY0Y/+wQvsS7STkzClvQopytNnuUv4a9tnSJwxcKoVL
	 PmJr0s/M60pGIjEpz5b6hK1aBTDfmDj0Q8P6fnttMPe44XMybBiVzCCakOAwZFX7OG
	 y1mfeX+eA1hgnpyR8cOq5zJb3GbQQZ1LzVFdqX0iGqRPBtnoiYteFFini8HXWN7ecd
	 3Ij2aLPHA2n4Q==
Subject:
 Re: [PATCH ipsec] xfrm: fix output state cache TOCTOU in xfrm_state_find()
From: netdev-bot+sashiko@kernel.org
To: tristmd@gmail.com
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, tristan@talencesecurity.com
Date: Tue, 27 Oct 2026 11:55:28 +0000
Message-ID: <179310212860.3134.3705274498786236555@kernel.org>
In-Reply-To: <20261023195323.3528192-1-tristmd@gmail.com>
References: <20261023195323.3528192-1-tristmd@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The race this patch says it fixes cannot happen on this tree,
  because the code the patch changes never runs.

--

xfrm: fix output state cache TOCTOU in xfrm_state_find()

This commit moves the x->km.state == XFRM_STATE_VALID check in
xfrm_state_find() inside xfrm_state_lock, so that inserting a state into
pol->state_cache_list cannot race with __xfrm_state_delete(). It is
described as the output-cache counterpart of commit ddd3d01329203 ("xfrm:
Fix xfrm state cache insertion race"), and it is tagged for stable.

> diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> index 0555e5d796ede..581e6d0d3ae3d 100644
> --- a/net/xfrm/xfrm_state.c
> +++ b/net/xfrm/xfrm_state.c
> @@ -1651,10 +1651,11 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
>  		*err = acquire_in_progress ? -EAGAIN : error;
>  	}
>
> -	if (x && x->km.state == XFRM_STATE_VALID && !cached &&
> +	if (x && !cached &&
>  	    (!(pol->flags & XFRM_POLICY_CPU_ACQUIRE) || x->pcpu_num == pcpu_id)) {
>  		spin_lock_bh(&net->xfrm.xfrm_state_lock);
> -		if (hlist_unhashed(&x->state_cache))
> +		if (x->km.state == XFRM_STATE_VALID &&
> +		    hlist_unhashed(&x->state_cache))
>  			hlist_add_head_rcu(&x->state_cache, &pol->state_cache_list);
>  		spin_unlock_bh(&net->xfrm.xfrm_state_lock);
>  	}

[Severity: Medium]
Can this block run at all? Earlier in xfrm_state_find(), the cached label
sets the flag on every path:

net/xfrm/xfrm_state.c:xfrm_state_find() {
    ...
	if (best)
		goto cached;

	hlist_for_each_entry_rcu(x, &pol->state_cache_list, state_cache) {
		...
	}

cached:
	cached = true;
	if (best)
		goto found;
    ...
}

On a cache hit the code jumps to the label. On a cache miss it falls
through to it. No goto skips the assignment, and cached is only ever set
to false at its declaration.

That makes the !cached test above always false. The hlist_add_head_rcu()
here is the only place that adds to pol->state_cache_list, so the list
always stays empty.

If that's right, the scenario in the commit message cannot happen on this
tree, with or without the patch:

  "Between the check and the lock acquisition, __xfrm_state_delete() can
  transition the state to XFRM_STATE_DEAD. The dead state is then
  inserted into the cache"

  "A subsequent call traversing the cache can then access a freed state"

The unconditional cached = true came in with 0045e3d80613 itself, together
with the !cached guard. So it looks like no tree with this feature can
reach the insertion, and the Fixes: and Cc: stable tags point to a race
that can't be triggered.

This is a separate issue that the patch doesn't introduce, but it follows
that the outbound per-policy cache from 0045e3d80613 is never filled.
Every outbound lookup then falls back to the full bydst and wildcard hash
search.

Doing the km.state check under the lock is still the right pattern if the
insertion is ever made reachable. Should this patch be described as
hardening instead? Or should it be paired with a change that sets cached
only when the state actually came from a state_cache_list search?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261023195323.3528192-1-tristmd%40gmail.com

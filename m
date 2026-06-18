Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1412EA75E;
	Thu, 18 Jun 2026 12:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781787412; cv=none; b=OVCa2N+YtOj0/5+SyQVzVXBga8bcgbgiRdZcduVvQaIjRZpC+XoXSEmNTmW8WDdZPdstArdgBc/ZkOt23uog3ptIO3KDzn3LT8T5PoYVMF13WXCXh5JMN8RE4ado/0NCj4HT+fDMrc8Md1IjMrIuNiRtb2zGc2DJD+oOgYrY5/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781787412; c=relaxed/simple;
	bh=8k4ZcVhARmlUSizzC5Miw5YGCvQGQDofEKBBVlQzXlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hfe8sljv5b4TBw1+veRUv1RcxhPJj4eGRwkk+M60EUxx26Xv4GBCrLHId2/He7KMQa0JDMQeo7XcqSyNovmYliLLW9Jjqg00FgevSeXNsiqLXq3XS2EDi23QOG2MVb7i1uamn0VaCJTxN6gmUqCmp9ckk2QXzYz9YkbSasFUZfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q7Q9GHY3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q7Q9GHY3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5A5B1F000E9;
	Thu, 18 Jun 2026 12:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781787411;
	bh=Jv42qu01ampbeftQ8WwTeludklkYsFzasPHhT/Xd2jk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Q7Q9GHY3frhFxnL0C1oaWfHyGpSrvQL3HtXx7pkI8B7r3jsGXn2vLGchtlOTLQjpD
	 Qt4zydGHMt2MVvN1lCJMsU8wdU5VJo9U62xV/w1bmrjLN7Qy6h3XUaYOo3ZDVKbiVS
	 dYmzwqK51CElJP1TWaYnu+z1gqtU5UIr/7Do3ewtJ43f59bmyQJ5rPcNmUb5NwOaPq
	 D6pcHoQgFadAdI3lOIcaJ09UqrvGfAJ59iFZx8oHmQs9IvUlNwCZ3aRPzhLUtmSwwu
	 m53snDtHFUCIMdBXf0Fl0XNi6pOSQq6AeFjqHIdThL7QEVnh26Pa9NALKMOf+l97x0
	 zAAy3wpzAsCeA==
Date: Thu, 18 Jun 2026 13:56:46 +0100
From: Simon Horman <horms@kernel.org>
To: Doruk Tan Ozturk <doruk@0sec.ai>
Cc: jmaloy@redhat.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, aleksander.lobakin@intel.com,
	tung.quang.nguyen@est.tech, tipc-discussion@lists.sourceforge.net,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v4] tipc: fix slab-use-after-free Read in
 tipc_aead_decrypt_done
Message-ID: <20260618125646.GN827683@horms.kernel.org>
References: <20260617075818.37431-1-doruk@0sec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617075818.37431-1-doruk@0sec.ai>

On Wed, Jun 17, 2026 at 09:58:18AM +0200, Doruk Tan Ozturk wrote:
> tipc_aead_decrypt() goes straight from tipc_bearer_hold(b) to
> crypto_aead_decrypt(req) without taking a reference on the netns, unlike
> the encrypt path. When crypto_aead_decrypt() is offloaded asynchronously
> (e.g. the SIMD aead wrapper queuing to cryptd), the cryptd worker runs
> tipc_aead_decrypt_done() later. If the bearer's netns is torn down in the
> meantime, cleanup_net() -> tipc_exit_net() -> tipc_crypto_stop() frees the
> per-netns tipc_crypto, and the completion then reads it:
> tipc_aead_decrypt_done() dereferences aead->crypto->stats and
> aead->crypto->net, and tipc_crypto_rcv_complete() dereferences
> aead->crypto->aead[] and the node table -- reading freed memory.
> 
> Decoded KASAN splat (v7.1-rc7, CONFIG_KASAN_INLINE + TIPC + TIPC_CRYPTO):
> 
>   BUG: KASAN: slab-use-after-free in tipc_aead_decrypt_done (net/tipc/crypto.c:999)
>   Read of size 8 at addr ffff8881056258a8 by task kworker/u16:2/51
>   Workqueue: events_unbound
>   Call Trace:
>    tipc_aead_decrypt_done (net/tipc/crypto.c:999)
>    process_one_work (kernel/workqueue.c:3314)
>    worker_thread (kernel/workqueue.c:3397 kernel/workqueue.c:3478)
>    kthread (kernel/kthread.c:436)
>    ret_from_fork (arch/x86/kernel/process.c:158)
>    ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
> 
>   Allocated by task 169:
>    __kasan_kmalloc (mm/kasan/common.c:398 mm/kasan/common.c:415)
>    tipc_crypto_start (net/tipc/crypto.c:1502)
>    tipc_init_net (net/tipc/core.c:72)
>    ops_init (net/core/net_namespace.c:137)
>    setup_net (net/core/net_namespace.c:446)
>    copy_net_ns (net/core/net_namespace.c:579)
>    create_new_namespaces (kernel/nsproxy.c:132)
>    __x64_sys_unshare (kernel/fork.c:3316)
>    do_syscall_64 (arch/x86/entry/syscall_64.c:63)
>    entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
> 
>   Freed by task 8:
>    kfree (mm/slub.c:6566)
>    tipc_exit_net (net/tipc/core.c:119)
>    cleanup_net (net/core/net_namespace.c:704)
>    process_one_work (kernel/workqueue.c:3314)
>    kthread (kernel/kthread.c:436)
> 
> This is the same class of bug that commit e279024617134 ("net/tipc: fix
> slab-use-after-free Read in tipc_aead_encrypt_done") fixed for the encrypt
> side. The encrypt path takes maybe_get_net(aead->crypto->net) before
> crypto_aead_encrypt() and drops it with put_net() on the synchronous
> return paths and in tipc_aead_encrypt_done(); the -EINPROGRESS/-EBUSY
> return keeps the reference for the async callback to release. The decrypt
> path was left without the equivalent guard.
> 
> Mirror the encrypt-side fix on the decrypt path: take a net reference
> before crypto_aead_decrypt() (failing with -ENODEV and the matching
> bearer put if it cannot be acquired), keep it across the
> -EINPROGRESS/-EBUSY async return, and drop it with put_net() on the
> synchronous success/error return and at the end of
> tipc_aead_decrypt_done().
> 
> Reproduced under KASAN on v7.1-rc7: a UDP bearer with a cluster key is
> flooded with crafted encrypted frames from an unknown peer (driving the
> cluster-key decrypt path) while the bearer's netns is repeatedly torn
> down. The completion must run asynchronously to outlive
> tipc_crypto_stop(); on x86 the stock aesni gcm(aes) now decrypts
> synchronously, so the async path was exercised via cryptd offload. The
> unguarded aead->crypto dereference in tipc_aead_decrypt_done() is the
> unpatched upstream path; tipc_aead_decrypt() still lacks
> maybe_get_net(aead->crypto->net), so the completion can outlive the free
> on any config where crypto_aead_decrypt() goes async.
> 
> Found by 0sec automated security-research tooling (https://0sec.ai).
> 
> Fixes: fc1b6d6de220 ("tipc: introduce TIPC encryption & authentication")
> Cc: stable@vger.kernel.org
> Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Reviewed-by: Tung Nguyen <tung.quang.nguyen@est.tech>
> ---
> v4:
>  - Use the net parameter for maybe_get_net()/put_net() instead of
>    dereferencing aead->crypto->net, which is the per-netns structure at
>    risk during teardown (per the automated review forwarded by Simon
>    Horman). net == aead->crypto->net here; no functional change.

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>


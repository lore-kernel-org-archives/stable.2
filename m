Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACAF3242BC;
	Tue, 21 Jul 2026 16:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784651847; cv=none; b=BUKPsoNCrfEJgLmAZDlBqbMMYdKiBR6dVCWetkRmp7gwJENBNz2U2fenyRsqdnb043X3wg/toq5Aofn/1flv46jDjOxGNw31ADpTYfdw7HBGrIWvaDAD/L96nif7GiMIbzry/wts6OPiYgMGQFVlEi/lvsKDDzFnlYgSrG/nMRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784651847; c=relaxed/simple;
	bh=TGRXPFVgdEbdmkg0xf4c8T1CfMNAcqsktfaj8aD4Vkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5UrY8g9XqxsPTYgrNMqcAyztQt9HAdZMlxA6mHI5y3fHPphahF6LEtOgd5rQi0RPPQgZ+wkazA5foQxrkZmpv5icUv2Kee5/HR+bUn93xqF63SZlfAT5wsbA+pDd9i9b+6bapJA4ANDuQEKpHsrroxXKEt7vVJyiFX8y+6B2d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXY/lMV5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXY/lMV5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ABEB1F000E9;
	Tue, 21 Jul 2026 16:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784651846;
	bh=+HFeLFiMpt2saQXzTckcp9zHr3aZ9dLPuWwmmJp0sqI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GXY/lMV5LQKzNRnV+C077iSjTzm+1GjerEInR97FxIe3XvMmsBIsvMygiBO/8pQ7f
	 usT47T6nokDReErxzN2SNoz1M64BSTrMxeubf4KASMqPo7CQCxjw17u3O70KSgV3WA
	 mi3DmG0wdqkN5Oj0NPTFcPOpl4NPWHJn0O7S1W+/gUVmPP3scHKaTRuKU7ifc4P+tx
	 4rJEiuKdLlbs6xM6aGTLV9XyVyUw2ZxUpZdH0aLCAY+Oix6JKa/PAL/Vrnxxr+0hHS
	 zDmHv6WZdgNdqPyIVYEi/Y7ctQPrkpL+hjWsn/7MU05nZstbmgeqo/YOv4JpGw/PZm
	 TdeYpLrSkJHUw==
Date: Tue, 21 Jul 2026 17:37:21 +0100
From: Simon Horman <horms@kernel.org>
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: netdev@vger.kernel.org, Jon Maloy <jmaloy@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Tung Quang Nguyen <tung.quang.nguyen@est.tech>,
	Breno Leitao <leitao@debian.org>,
	tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v3] tipc: clear sock->sk on the failed-insert path in
 tipc_sk_create()
Message-ID: <20260721163721.GA418547@horms.kernel.org>
References: <20260714131939.1255974-1-4ncienth@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714131939.1255974-1-4ncienth@gmail.com>

On Tue, Jul 14, 2026 at 10:19:39PM +0900, Daehyeon Ko wrote:
> When tipc_sk_create() fails to insert the new socket (tipc_sk_insert()
> returns non-zero), its error path frees the sk with sk_free() but leaves
> sock->sk pointing at the freed object:
> 
> 	if (tipc_sk_insert(tsk)) {
> 		sk_free(sk);
> 		pr_warn("Socket create failed; port number exhausted\n");
> 		return -EINVAL;
> 	}
> 
> This is harmless for plain socket(): the syscall layer clears sock->ops
> before releasing, so tipc_release() is never called. It is not harmless
> on the accept() path. tipc_accept() creates the pre-allocated child
> socket with tipc_sk_create(net, new_sock, 0, kern); on failure it leaves
> new_sock->sk dangling and new_sock->ops non-NULL, and do_accept() then
> fput()s the new file, so __sock_release() -> tipc_release() runs
> lock_sock(new_sock->sk) on the freed sk -- a use-after-free write of the
> sk_lock spinlock.
> 
> tipc_release() already guards this exact "failed accept() releases a
> pre-allocated child" case with "if (sk == NULL) return 0;", but the
> guard is bypassed because tipc_sk_create() left sock->sk non-NULL
> (dangling) rather than NULL.
> 
> Clear sock->sk on the failed-insert path so the existing tipc_release()
> NULL check fires and the use-after-free is avoided.
> 
> The tipc_sk_insert() failure is reached when the per-netns socket
> rhashtable hits its max_size (tsk_rht_params.max_size = 1048576, ~2M
> elements) -- i.e. once a netns holds ~2M TIPC sockets every insert
> returns -E2BIG.
> 
>   BUG: KASAN: slab-use-after-free in lock_sock_nested (net/core/sock.c:3839)
>   Write of size 8 at addr ffff8880047cdc38 by task init/1
>    lock_sock_nested (net/core/sock.c:3839)
>    tipc_release (net/tipc/socket.c:638)
>    __sock_release (net/socket.c:710)
>    sock_close (net/socket.c:1501)
>    __fput (fs/file_table.c:512)
>   Allocated by task 1:
>    sk_alloc (net/core/sock.c:2308)
>    tipc_sk_create (net/tipc/socket.c:487)
>    tipc_accept (net/tipc/socket.c:2744)
>    do_accept (net/socket.c:2034)
>   Freed by task 1:
>    __sk_destruct (net/core/sock.c:2391)
>    tipc_sk_create (net/tipc/socket.c:504)
>    tipc_accept (net/tipc/socket.c:2744)
>    do_accept (net/socket.c:2034)
> 
> Fixes: 00aff3590fc0 ("net: tipc: fix possible refcount leak in tipc_sk_create()")
> Cc: stable@vger.kernel.org
> Reviewed-by: Tung Nguyen <tung.quang.nguyen@est.tech>
> Reviewed-by: Breno Leitao <leitao@debian.org>
> Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
> ---
> v3: correct the Fixes: tag to 00aff3590fc0 ("net: tipc: fix possible
>     refcount leak in tipc_sk_create()") -- that commit added the sk_free()
>     on the insert-failure path; before it the path leaked sk rather than
>     freeing it, so the use-after-free only exists since then (v5.19+).
>     Thanks Breno. Collect Reviewed-by from Tung and Breno. No code change.
> v2: https://lore.kernel.org/netdev/20260713082342.3803379-1-4ncienth@gmail.com/
> v1: https://lore.kernel.org/netdev/20260710014440.2055584-1-4ncienth@gmail.com/

Reviewed-by: Simon Horman <horms@kernel.org>


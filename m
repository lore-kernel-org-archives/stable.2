Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04083B6363;
	Tue,  8 Sep 2026 20:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788900589; cv=none; b=V4PuYW8z93okZ6CODHn+zS7SCLzkIxfH6GvqfobNUfjlhURskimmEkF6senoamMmsJdzV29bQs7o5l6XLSjdfxCO0uWK9RVNcCYl3LLH3dMI5HF3dsN7gJd8iJLc1tR0EgO9f3ieVc2HcjtsSx2QLJ+k8sJIvKs6UNiMgqT/dsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788900589; c=relaxed/simple;
	bh=jc7TqDe8lS/aD+zyDHIJYEe0pFz97x32pMr7UUlKVO8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M800VuyJqnB3wlJvRE6OvZaUi8qG0dYwB6cfh7rmZjDanew5NqOt6+3u0Ajux6DnZhxlRTizuZFLNEcLMnJTeIid/UmQw5iFQbIWjqmHItjcHugUdANFrNHW1LtkNdDl4KR2N2NDgHn14ap1aWrZbYb6n2fWGLUldjopW4fI3AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZaHWRIx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZaHWRIx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F19761F00A3D;
	Tue,  8 Sep 2026 20:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788900586;
	bh=OgSBOBp6IqZIPjLgNTcqDaELLZvc9xccI/MnvDdto/k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=oZaHWRIx/9HXzTbMnfMiDtyjPmc5TKdjRuT5CLr+EAqah/Wix15bIuKkdyf85bVIk
	 tZyPRhVbXmoWnMhU4xgaNo2pLgwc9q4o6QoRrgqlE0B3CrKSWmHft7ap4+jktcpPnp
	 Sq+QKzXyJKU6QvMFqgEpZ66qZVMiMdIr3ohahpUMLHyUr9x4pKyqvtme46yd8ZzVTw
	 eiPAzNPAJlHpieTG/QJH/LIrCROJJ4uoGJMjwJGgJQ5Ezzwft+ca55pGCthHdX74IR
	 8CjNvhWuOAawkc9XfajlfoLSMeBXBskLTh3bcRf3u7AIOHmZ5YFdr5SXn1k4vlK4+c
	 ++UH1Lxgydx2A==
Subject: Re: [PATCH net v9 09/14] rxrpc: Fix generation of notifications after
 call completion
From: netdev-bot+sashiko@kernel.org
To: dhowells@redhat.com
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
 nicoyip.dev@gmail.com, stable@vger.kernel.org
Date: Tue, 08 Sep 2026 20:49:45 +0000
Message-ID: <178890058557.219967.11776960278332769876@kernel.org>
In-Reply-To: <20260907113743.1453210-10-dhowells@redhat.com>
References: <20260907113743.1453210-10-dhowells@redhat.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 0 · Low: 2

- [Low] Undisclosed behavioural divergence introduced by the refactor:
  the new helper rxrpc_requeue_call() (net/rxrpc/recvmsg.c:22-46), which…
- [Low] Comment vs code mismatch in net/rxrpc/call_state.c: the new
  wrapper rxrpc_notify_socket() (line 54) carries a comment that is a…

--

rxrpc: Fix generation of notifications after call completion

The patch stops AF_RXRPC from generating a second notification after a call
has completed by splitting rxrpc_notify_socket() into a skip-if-completed
wrapper plus an unconditional __rxrpc_notify_socket() in call_state.c.  The
recvmsg path instead gets a new lightweight rxrpc_requeue_call() helper that
only puts the call back on rx->recvmsg_q.

A couple of questions below about the split.

> diff --git a/net/rxrpc/call_state.c b/net/rxrpc/call_state.c
> index 6afb54373ebbf..364810c652766 100644
> --- a/net/rxrpc/call_state.c
> +++ b/net/rxrpc/call_state.c
> @@ -7,6 +7,60 @@
>  
>  #include "ar-internal.h"
>  
> +/*
> + * Post a call for attention by the socket or kernel service.
> + */
> +static void __rxrpc_notify_socket(struct rxrpc_call *call)
> +{
> +	struct rxrpc_sock *rx;
> +	struct sock *sk;
> +	unsigned long flags;
> +
> +	if (test_bit(RXRPC_CALL_RELEASED, &call->flags)) {
> +		rxrpc_see_call(call, rxrpc_call_see_notify_released);
> +		return;
> +	}
> +
> +	rcu_read_lock();
> +
> +	rx = rcu_dereference(call->socket);
> +	sk = &rx->sk;
> +	if (rx && sk->sk_state < RXRPC_CLOSE) {
> +		if (call->notify_rx) {
> +			spin_lock_irqsave(&call->notify_lock, flags);
> +			call->notify_rx(sk, call, call->user_call_ID);
> +			spin_unlock_irqrestore(&call->notify_lock, flags);
> +		} else {
> +			spin_lock_irqsave(&rx->recvmsg_lock, flags);
> +			if (list_empty(&call->recvmsg_link)) {
> +				rxrpc_get_call(call, rxrpc_call_get_notify_socket);
> +				list_add_tail(&call->recvmsg_link, &rx->recvmsg_q);
> +			}
> +			spin_unlock_irqrestore(&rx->recvmsg_lock, flags);
> +
> +			if (!sock_flag(sk, SOCK_DEAD)) {
> +				_debug("call %ps", sk->sk_data_ready);
> +				sk->sk_data_ready(sk);
> +			}
> +		}
> +	}
> +
> +	rcu_read_unlock();
> +}
> +
> +/*
> + * Post a call for attention by the socket or kernel service.
> + */
> +void rxrpc_notify_socket(struct rxrpc_call *call)
> +{
> +	if (rxrpc_call_is_complete(call)) {
> +		rxrpc_see_call(call, rxrpc_call_see_notify_skipped);
> +		return;
> +	}
> +
> +	__rxrpc_notify_socket(call);
> +}

[Severity: Low]
This isn't a bug, but the comment on the new rxrpc_notify_socket() wrapper is
a verbatim copy of the one on __rxrpc_notify_socket(), and the wrapper does
not post anything when rxrpc_call_is_complete(call) is true, it just emits
the rxrpc_call_see_notify_skipped trace and returns.

Since the skip is the only difference between the two functions, and is the
reason rxrpc_set_call_completion() must use the double-underscore variant,
would it be worth mentioning it in the comment?  As it stands, a caller that
needs a completed-but-not-yet-drained call re-posted cannot tell from the
comments which variant to pick.

> diff --git a/net/rxrpc/recvmsg.c b/net/rxrpc/recvmsg.c
> index 56fa324d0962e..28b2148b56936 100644
> --- a/net/rxrpc/recvmsg.c
> +++ b/net/rxrpc/recvmsg.c
> @@ -17,14 +17,12 @@
>  #include "ar-internal.h"
>  
>  /*
> - * Post a call for attention by the socket or kernel service.  Further
> - * notifications are suppressed by putting recvmsg_link on a dummy queue.
> + * Requeue a call for recvmsg() to pick up.
>   */
> -void rxrpc_notify_socket(struct rxrpc_call *call)
> +static void rxrpc_requeue_call(struct socket *sock, struct rxrpc_call *call)
>  {
> -	struct rxrpc_sock *rx;
> -	struct sock *sk;
> -	unsigned long flags;
> +	struct rxrpc_sock *rx = rxrpc_sk(sock->sk);
> +	struct sock *sk = &rx->sk;
>  
>  	_enter("%d", call->debug_id);
>  
> @@ -33,31 +31,18 @@ void rxrpc_notify_socket(struct rxrpc_call *call)
>  		return;
>  	}
>  
> -	rcu_read_lock();
> -
> -	rx = rcu_dereference(call->socket);
> -	sk = &rx->sk;
> -	if (rx && sk->sk_state < RXRPC_CLOSE) {
> -		if (call->notify_rx) {
> -			spin_lock_irqsave(&call->notify_lock, flags);
> -			call->notify_rx(sk, call, call->user_call_ID);
> -			spin_unlock_irqrestore(&call->notify_lock, flags);
> -		} else {
> -			spin_lock_irqsave(&rx->recvmsg_lock, flags);
> -			if (list_empty(&call->recvmsg_link)) {
> -				rxrpc_get_call(call, rxrpc_call_get_notify_socket);
> -				list_add_tail(&call->recvmsg_link, &rx->recvmsg_q);
> -			}
> -			spin_unlock_irqrestore(&rx->recvmsg_lock, flags);
> +	spin_lock_irq(&rx->recvmsg_lock);
> +	if (list_empty(&call->recvmsg_link)) {
> +		rxrpc_get_call(call, rxrpc_call_get_notify_socket);
> +		list_add_tail(&call->recvmsg_link, &rx->recvmsg_q);
> +	}
> +	spin_unlock_irq(&rx->recvmsg_lock);

[Severity: Low]
Is dropping the "rx && sk->sk_state < RXRPC_CLOSE" test intentional here?

rxrpc_requeue_call() keeps only the RXRPC_CALL_RELEASED check, so it will add
the call to rx->recvmsg_q regardless of sk_state, while the other enqueue site
for the same list, __rxrpc_notify_socket() in call_state.c, still requires
sk_state < RXRPC_CLOSE.

The CLOSE transition looks like it was written as a fence for additions to
that list, since rxrpc_shutdown() and rxrpc_release_sock() in af_rxrpc.c set
it under the same lock:

net/rxrpc/af_rxrpc.c:rxrpc_shutdown() {
	...
	if (sk->sk_state < RXRPC_CLOSE) {
		spin_lock_irq(&rx->recvmsg_lock);
		sk->sk_state = RXRPC_CLOSE;
		sk->sk_shutdown = SHUTDOWN_MASK;
		spin_unlock_irq(&rx->recvmsg_lock);
	...
}

The requeue in rxrpc_recvmsg() runs after release_sock(&rx->sk), so a
concurrent shutdown(SHUT_RDWR) on another thread of the same socket can flip
sk_state to RXRPC_CLOSE in that window and the call is requeued anyway, with a
fresh rxrpc_call_get_notify_socket ref.

The consequences look bounded: the extra ref is reclaimed when
rxrpc_release_calls_on_socket() drains rx->recvmsg_q, and handing out
already-queued data after shutdown was possible before this patch too, since
rxrpc_recvmsg() has no RXRPC_CLOSE rejection and the fence never removes
entries that are already queued.

Similarly, the call->notify_rx branch is gone from this path.  That looks safe
today, since notify_rx is only set for kernel service calls and
__rxrpc_notify_socket() never puts those on rx->recvmsg_q, so every call
rxrpc_recvmsg() takes off that queue has notify_rx == NULL.

Would it be worth either restoring the sk_state test so both enqueue sites
agree, or noting in a comment why the requeue path does not need it?

> -			if (!sock_flag(sk, SOCK_DEAD)) {
> -				_debug("call %ps", sk->sk_data_ready);
> -				sk->sk_data_ready(sk);
> -			}
> -		}
> +	if (!sock_flag(sk, SOCK_DEAD)) {
> +		_debug("call %ps", sk->sk_data_ready);
> +		sk->sk_data_ready(sk);
>  	}
>  
> -	rcu_read_unlock();
>  	_leave("");
>  }

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260907113743.1453210-1-dhowells%40redhat.com

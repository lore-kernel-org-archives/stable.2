Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84FD33DEC8;
	Sun, 27 Sep 2026 14:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790521199; cv=none; b=eZe/PgoQ0s1BGjZvf4yvhYSb6KraxYA/VjLhgivJfyGjWrPjYgNq773z2k3fiGp3620pBSWWu7cRLqdYrdcfzZJ0dsApmGzdVWXRzWsMR1FBAksWuG+5bUq7MobsTFY4NP8K/mn16N2H8pufYoZOu/Klh3C+kA3FEc8TWlkaXOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790521199; c=relaxed/simple;
	bh=OvHB4aQy0jJMF0Z6h7CMesGDOPXu3jfrH4vQmnFTWf0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IIH0s1giegyevrkI3zKjzjVnvTiQDdDY69UM5Ccp5AoXrRt0tCQcbIguPRqxWFFRhL350XwrxzOC5HulRHOykO8nG586kumIIsFsN38lQLN1lzXD0hudcXTg6JdDm0TxQf+PC2loL5OUkAgYG3TKaohlOOxhUTGgsrbMZfnCiBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e18ckbT/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e18ckbT/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D54A81F00893;
	Sun, 27 Sep 2026 14:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790521194;
	bh=pWhYh6CbQa5IkgwuLCkQKb6dg55T/o+xW4XtiUmA+CU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=e18ckbT/LXnI1qoH+WKz9nfq4XyyTkDM2dtwnv8HNjRdnXsj40jh65SfRaZXaiiu+
	 +pcbIBzA5Mi5+Jkhj1NTKjB4hr4AfiJ7belJ0m8PrmK3jSZxkBiLDdXYuRs+1n4tW8
	 vb5ts2WC9WuYzYu0jl7ehjOFPB9QhoiqngGkH8kqTrtXUt3HCIaHTMsgRZx+Dt/7Vy
	 XdaA9gQ1IYiVQxmyN/EjUy5avE7wmnSDeDbRhrypzwQ1+pQfchGOzwYzBI2/62tqmB
	 mZ+DGuLJpLfKxRxB26jRTk6/UoBbx6QOwySqJcYowh88TzUVsPIQghn+lQiKfK/h11
	 KrYTPtpoffvRQ==
Subject: Re: [PATCH net v11 09/17] rxrpc: Fix packet encryption error handling
From: netdev-bot+sashiko@kernel.org
To: dhowells@redhat.com
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
 qotmddnjs@ajou.ac.kr, stable@vger.kernel.org
Date: Sun, 27 Sep 2026 14:59:53 +0000
Message-ID: <179052119345.2160803.10650297223669839534@kernel.org>
In-Reply-To: <20260923133706.1496540-10-dhowells@redhat.com>
References: <20260923133706.1496540-10-dhowells@redhat.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The patch renumbers the return-value comment block in
  rxrpc_send_data() (net/rxrpc/sendmsg.c) and adds a new item (5) for…
- [Low] The patch adds a new userspace-visible sendmsg() behaviour on
  AF_RXRPC sockets that Documentation/networking/rxrpc.rst never…

Pre-existing issues:
- [Low] This problem wasn't introduced by this patch, but the
  rxrpc_kernel_send_data documentation block the patch edits…

--

rxrpc: Fix packet encryption error handling

This changes rxrpc_send_data() so that -ENOMEM from ->secure_packet() is
treated as retryable. The data just added to the last packet is removed
again and the iterator is rewound. Any other encryption error sets a new
sticky RXRPC_CALL_TX_ERROR flag, and after that every data send on the
call returns -EIO until the application aborts the call.

Closes: https://sashiko.dev/#/patchset/20260702144919.172295-1-dhowells%40redhat.com

> diff --git a/Documentation/networking/rxrpc.rst b/Documentation/networking/rxrpc.rst
> index 01ad12fdf3058..9b7eeae841485 100644
> --- a/Documentation/networking/rxrpc.rst
> +++ b/Documentation/networking/rxrpc.rst
> @@ -878,8 +878,10 @@ The kernel interface functions are as follows:
>       exclusively to in-kernel virtual addresses.  msg.msg_flags may be given
>       MSG_MORE if there will be subsequent data sends for this call.
>  
> -     The msg must not specify a destination address, control data or any flags
> -     other than MSG_MORE.
> +     msg must not specify a destination address, control data or any flags
> +     other than MSG_MORE.  The last-packet flag will only be set on the
> +     outgoing packet if MSG_MORE is not set and all the data in the iterator is
> +     buffered.
>  
>       notify_end_rx can be NULL or it can be used to specify a function to be
>       called when the call changes state to end the Tx phase.  This function is

[Severity: Low]
This isn't a bug introduced by this patch, but it is in the same
rxrpc_kernel_send_data() block that is being edited. The prototype
documented just above this hunk doesn't match the header:

Documentation/networking/rxrpc.rst:
	typedef void (*rxrpc_notify_end_tx_t)(struct sock *sk,
					      unsigned long user_call_ID,
					      struct sk_buff *skb);

include/net/af_rxrpc.h:
typedef void (*rxrpc_notify_end_tx_t)(struct sock *, struct rxrpc_call *,
				      unsigned long);

rxrpc_notify_end_tx() in net/rxrpc/sendmsg.c calls it as
notify_end_tx(&rx->sk, call, call->user_call_ID), which matches the header.
So the documented version has the wrong argument types and order, and an
sk_buff argument that doesn't exist.

The documentation also calls the parameter notify_end_rx, but the header
calls it notify_end_tx.

Could the documented prototype and parameter name be updated to match
include/net/af_rxrpc.h?

[ ... ]

> diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
> index 80c6afc647870..e3b6347888bfe 100644
> --- a/net/rxrpc/sendmsg.c
> +++ b/net/rxrpc/sendmsg.c

[ ... ]

> @@ -372,6 +373,13 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
>  		ret = -EPROTO;
>  		goto out_unlock;
>  	}
> +	if (unlikely(test_bit(RXRPC_CALL_TX_ERROR, &call->flags))) {
> +		trace_rxrpc_abort(call->debug_id, rxrpc_sendmsg_tx_error,
> +				  call->cid, call->call_id, call->rx_consumed,
> +				  0, -EIO);
> +		ret = -EIO;
> +		goto out_unlock;
> +	}

[Severity: Low]
This changes what userspace sees from sendmsg() on AF_RXRPC sockets. If
->secure_packet() fails with anything other than -ENOMEM,
rxrpc_send_data() sets RXRPC_CALL_TX_ERROR. From then on, every data send
on that call returns -EIO here until the application aborts the call.

Should this be described in Documentation/networking/rxrpc.rst? The only
change there is to the rxrpc_kernel_send_data() paragraph.

The "Notes on sendmsg" section and the client/server walkthroughs don't
say that a call can become unusable for sending, that it then returns
-EIO, or that it has to be aborted explicitly. Right now the only place
this is described is item (5) of the comment in rxrpc_send_data().

The ENOMEM rewind can make a !MSG_MORE sendmsg() return a short count, but
the existing text about returning the amount of data consumed already
covers that. The missing part is mainly the sticky -EIO state and the need
to abort.

[ ... ]

> @@ -481,22 +505,44 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
>  	 *
>  	 * (4) If another sendmsg() has already queued the last packet: -EPROTO.
>  	 *
> -	 * (5) If we queue the last packet: the amount copied (which may be
> +	 * (5) If an error occurs that may have corrupted the transmission
> +	 *     buffer (e.g. crypto failure) or unusable crypto was encountered:
> +	 *     the error given (and RXRPC_CALL_TX_ERROR is set to cause -EIO to
> +	 *     be returned from further calls).
> +	 *
> +	 * (6) If we queue the last packet: the amount copied (which may be
>  	 *     zero).  recvmsg() should be used to collect the result.
>  	 *
> -	 * (6) If some data has been copied by this call: the amount copied
> +	 * (7) If some data has been copied by this call: the amount copied
>  	 *     (which will be greater than zero).
>  	 *
> -	 * (7) Any other error.
> +	 * (8) Any other error.
>  	 *
> -	 * For (1)-(4), there's no point in continuing with the sendmsg().  The
> -	 * app should abort the call (just in case the error came from
> -	 * somewhere else) and then use recvmsg() to collect the final result
> -	 * of the call.
> +	 * For (1)-(6), there's no point in continuing with the sendmsg() and
> +	 * we no longer care how much has been queued as the call is no longer
> +	 * viable.  The app should abort the call (just in case the error came
> +	 * from somewhere else) and then use recvmsg() to collect the final
> +	 * result of the call.

[Severity: Low]
Should this range be (1)-(5)?

After the renumbering, item (6) is the case where the last packet was
queued. That is the normal, successful end of the Tx phase.

Saying the call is no longer viable and should be aborted contradicts
item (6) itself, which says recvmsg() should be used to collect the
result.

It also doesn't match rxrpc_kernel_send_data(), which treats consuming
all the data as success:

	if (msg_data_left(msg) == 0) {
		ret = 0;
		break;
	}

Documentation/networking/rxrpc.rst agrees, saying the function "returns 0
if all the data is queued".

None of the later patches in the series touch net/rxrpc/sendmsg.c, so the
wrong range would stay in the final state.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260923133706.1496540-1-dhowells%40redhat.com

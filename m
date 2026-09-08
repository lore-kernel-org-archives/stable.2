Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D833B05A2;
	Tue,  8 Sep 2026 20:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788900586; cv=none; b=nnAMepCL8vROfMo8TRHuZRjhqXcB71EetXmSxk37ch0QmNTnK7k9qtCX/G+kMth1/Ywf4qzVSREiryqT02ouFoxTOATb8zXJFt4KcxtBmRMWlc74mQ+pfRIhqfG4Z/J4dtUV5DrpqeIR0UpGhu4kDJNu0CEqC0GhHqXYNifh79E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788900586; c=relaxed/simple;
	bh=mq1+iKvUyKV3IZeyUpC1pWUVbRJ+XHlHj2aexaciexw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o616QptNkhnFNZFhunhlW9CTSHkOCNm/RrqdjsQdxN6T7OC2n8yLrhy5wOTrFf0HXFF+nBt+QAfRzpCz1WkiUrcLNk9TqFXHwdjDLHcQOArECvH4ptum2YUaRh8dsPEjmgMeCk3Fa141vIDwkCDd9XLhdaI+RfvTsgQ6XJ16t88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RFzsvEny; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFzsvEny"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F5011F00A3A;
	Tue,  8 Sep 2026 20:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788900584;
	bh=Yo1TIxXUui1dZtNkXjI1YcrDWX82amraS//AWJiEQZo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RFzsvEnyUm2UabpGAd3Bkbw1lMkygqHS9iykcR94Lz2ITMxJ5ScJaP0LMJCfogWDy
	 YpLyZi3vihQoQzUg1hBUEviQk5BE5SpbH5mxyuL0l5kjzRPMVDcwaQ0fGFVBWsXBVW
	 MkZ7sSE4SK6O2PLbeMYfBgDyv/eQplhIUfzsvBU3TvW80V9FzTYK4SZLnS4pW4K24S
	 osIHOQbAIg8el/GTsaYjMEMZfxN7+vuu1k5Urhph+tFyU/5yeLFQcZbr9vzdbA7XjB
	 TrI42XNp+zQoGaGSWjGpTKNCnKO9CdZ2RzKI0ceSYLDDxomokKjWjuy1f42WzudkyO
	 PZ2Hr25apn76A==
Subject: Re: [PATCH net v9 06/14] rxrpc: Fix packet encryption error handling
From: netdev-bot+sashiko@kernel.org
To: dhowells@redhat.com
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
 nicoyip.dev@gmail.com, stable@vger.kernel.org
Date: Tue, 08 Sep 2026 20:49:43 +0000
Message-ID: <178890058323.219967.15646967428677285785@kernel.org>
In-Reply-To: <20260907113743.1453210-7-dhowells@redhat.com>
References: <20260907113743.1453210-7-dhowells@redhat.com>
X-sashiko-severity: Critical
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider:

Critical: 1 · High: 1 · Medium: 2 · Low: 0

- [Critical] rxrpc_send_data() (net/rxrpc/sendmsg.c) publishes an
  uninitialised pointer into call->tx_pending.
- [High] Concurrent sendmsg calls cause maybe_error_rewind to rewind
  another thread's data and revert the msg_iter too far, causing data…
- [Medium] The commit message of "rxrpc: Fix packet encryption error
  handling" states "afs_make_call() and afs_send_simple_reply() are also…
- [Medium] Stale local `txb` after the wait-for-space lock drop: on the
  wait_for_space path rxrpc_send_data() drops call->user_mutex…

--

rxrpc: Fix packet encryption error handling

This changes rxrpc_send_data() so that an -ENOMEM from ->secure_packet() is
treated as retryable (rewinding the last partial packet and the iterator),
while any other encryption error sets a new RXRPC_CALL_TX_ERROR flag and
makes subsequent data adds return -EIO.  The RXRPC_CALL_TX_NO_MORE test is
also moved down to the reload: label so it is rechecked after a
wait-for-space.

Closes: https://sashiko.dev/#/patchset/20260702144919.172295-1-dhowells%40redhat.com

A few questions below.

> rxrpc: Fix packet encryption error handling
>
> [ ... ]
>
> afs_make_call() and afs_send_simple_reply() are also modified to repeat
> calls to rxrpc_kernel_send_data() if less than a full transfer was made.

[Severity: Medium]
Is this paragraph accurate for this commit?  The diffstat only covers
Documentation/networking/rxrpc.rst, include/trace/events/rxrpc.h,
net/rxrpc/ar-internal.h and net/rxrpc/sendmsg.c, with no fs/afs change.

The retry loops in afs_make_call() and afs_send_simple_reply() come from
the earlier series patch bd42a7623ae5 ("afs: Fix lack of loop around
sendmsg() to rxrpc"), and the equivalent rxperf loop from 658684df7eb2
("rxrpc: Fix lack of loop around reply send in rxperf server").

That distinction matters here because this patch carries Fixes:
17926a79320a and cc: stable, and it newly makes rxrpc_send_data() return a
short positive count where it previously returned an error (the
maybe_error_rewind path below).  A caller that treats any non-negative
return as completion, such as an unmodified afs_make_call(), would silently
truncate the request and never queue the last packet:

fs/afs/rxrpc.c:afs_make_call() {
    ...
	do {
		ret = rxrpc_kernel_send_data(call->net->socket, rxcall, &msg,
					     msg_data_left(&msg),
					     afs_notify_end_request_tx);
		if (ret < 0)
			goto error_do_abort;
	} while (msg_data_left(&msg) > 0);
    ...
}

Could the message either drop the afs claim or name bd42a7623ae5 (and
658684df7eb2) as backport prerequisites?

> diff --git a/Documentation/networking/rxrpc.rst b/Documentation/networking/rxrpc.rst
> index 8926dab8e2e60..7df6aff7644c0 100644
> --- a/Documentation/networking/rxrpc.rst
> +++ b/Documentation/networking/rxrpc.rst
> @@ -879,14 +879,21 @@ The kernel interface functions are as follows:
>       notify_end_rx can be NULL or it can be used to specify a function to be
>       called when the call changes state to end the Tx phase.  This function is
>       called with a spinlock held to prevent the last DATA packet from being
>       transmitted until the function returns.
>  
> +     The function returns the amount of data buffered or an error.  It will
> +     return zero only if len is 0 or if msg->msg_iter is empty.  It may also
> +     make a short write, buffering less than the amount of data provided or the
> +     len specified, in which case it should be called again.
> +

[ ... ]

> diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
> index 565799548102c..4ce3ae0ba2e88 100644
> --- a/net/rxrpc/sendmsg.c
> +++ b/net/rxrpc/sendmsg.c
> @@ -330,13 +330,6 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
>  	bool more = msg->msg_flags & MSG_MORE;
>  	int ret, copied = 0;
>  
> -	if (test_bit(RXRPC_CALL_TX_NO_MORE, &call->flags)) {
> -		trace_rxrpc_abort(call->debug_id, rxrpc_sendmsg_late_send,
> -				  call->cid, call->call_id, call->rx_consumed,
> -				  0, -EPROTO);
> -		return -EPROTO;
> -	}
> -
>  	timeo = sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
>  
>  	ret = rxrpc_wait_to_be_connected(call, &timeo);
> @@ -353,6 +346,21 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
>  	sk_clear_bit(SOCKWQ_ASYNC_NOSPACE, sk);
>  
>  reload:
> +	if (unlikely(test_bit(RXRPC_CALL_TX_NO_MORE, &call->flags))) {
> +		trace_rxrpc_abort(call->debug_id, rxrpc_sendmsg_late_send,
> +				  call->cid, call->call_id, call->rx_consumed,
> +				  0, -EPROTO);
> +		ret = -EPROTO;
> +		goto maybe_error;
> +	}
> +	if (unlikely(test_bit(RXRPC_CALL_TX_ERROR, &call->flags))) {
> +		trace_rxrpc_abort(call->debug_id, rxrpc_sendmsg_tx_error,
> +				  call->cid, call->call_id, call->rx_consumed,
> +				  0, -EIO);
> +		ret = -EIO;
> +		goto maybe_error;
> +	}
> +
>  	txb = call->tx_pending;
>  	call->tx_pending = NULL;
>  	if (txb)

[Severity: Critical]
Can these two new gotos store an uninitialised pointer into
call->tx_pending?

The old TX_NO_MORE test did "return -EPROTO" before touching any call
state.  Both new tests instead jump to maybe_error, and they run before the
txb snapshot, while txb is still uninitialised:

net/rxrpc/sendmsg.c:rxrpc_send_data() {
	struct rxrpc_txbuf *txb;		/* no initialiser */
	...
reload:
	if (unlikely(test_bit(RXRPC_CALL_TX_NO_MORE, &call->flags))) {
		...
		goto maybe_error;
	}
	...
	txb = call->tx_pending;			/* never reached */
}

With copied == 0, which is always the case on the first pass, maybe_error
falls straight through to out:

maybe_error:
	if (copied) {
		...
	}
	goto out;

success:
	ret = copied;
out:
	call->tx_pending = txb;

Is the resulting call->tx_pending value indeterminate?  A trigger looks
straightforward from userspace: sendmsg() the whole request without
MSG_MORE, so rxrpc_queue_packet() sets RXRPC_CALL_TX_NO_MORE for the last
packet, then sendmsg() again on the same RXRPC_USER_CALL_ID.
rxrpc_do_sendmsg() still dispatches to rxrpc_send_data() because the call
is in RXRPC_CALL_CLIENT_AWAIT_REPLY, and the state switch there only
rejects UNINITIALISED/PREALLOC/AWAIT_CONN/SERVER_RECV_REQUEST.

The stored value is later consumed at teardown:

net/rxrpc/call_object.c:rxrpc_destroy_call() {
	...
	rxrpc_put_txbuf(call->tx_pending, rxrpc_txbuf_put_cleaned);
	...
}

which dereferences txb->debug_id/call_debug_id/seq, does
__refcount_dec_and_test(&txb->ref) and can then free the buffer.  A further
sendmsg() on the same call would also pick it up via rxrpc_see_txbuf() and
copy user data through "txb->data + txb->offset".

Note that -Wno-maybe-uninitialized is added by scripts/Makefile.warn, so
gcc builds will not flag this.  Would initialising txb = NULL, returning
directly from the two tests, or placing them after the tx_pending fetch be
preferable?

> @@ -441,12 +449,26 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
>  		/* add the packet to the send queue if it's now full */
>  		if (!txb->space ||
>  		    (len == 0 && !more)) {
> -			if (len == 0 && !more)
> -				txb->flags |= RXRPC_LAST_PACKET;
> -
> +			/* Do any required crypto.  If this fails, it could
> +			 * have corrupted the txbuf content with a partial
> +			 * encrypt.  Assume that ENOMEM is retryable, but
> +			 * everything else is terminal.
> +			 */
>  			ret = call->security->secure_packet(call, txb);
> -			if (ret < 0)
> +			if (ret < 0) {
> +				/* Assume that ENOMEM here means that the
> +				 * encryption hasn't happened yet.  The data is
> +				 * aligned to avoid the need for slow buffering
> +				 * in the crypto walk.
> +				 */
> +				if (ret == -ENOMEM)
> +					goto maybe_error_rewind;
> +				set_bit(RXRPC_CALL_TX_ERROR, &call->flags);
>  				goto out;
> +			}
> +

[Severity: Medium]
Can this terminal path lose the txbuf it parks in call->tx_pending when
another sender is sleeping in wait-for-space?

The wait_for_space path drops call->user_mutex, sleeps, retakes the mutex
and jumps back to reload:

net/rxrpc/sendmsg.c:rxrpc_send_data() {
    ...
wait_for_space:
	ret = -EAGAIN;
	if (msg->msg_flags & MSG_DONTWAIT)
		goto maybe_error;
	mutex_unlock(&call->user_mutex);
	*_dropped_lock = true;
	ret = rxrpc_wait_for_tx_window(rx, call, &timeo,
				       msg->msg_flags & MSG_WAITALL);
	...
	goto reload;
}

Since the new flag tests at reload: run before "txb = call->tx_pending",
the local txb is still the stale value from before the sleep, and on this
path it is NULL because wait_for_space is only reachable when !txb.  So:

  thread A: sendmsg(), no Tx space, drops user_mutex, sleeps
  thread B: sendmsg() on the same user_call_ID, copies data,
            ->secure_packet() fails with a non-ENOMEM error, does
            set_bit(RXRPC_CALL_TX_ERROR) and "goto out", leaving its
            txbuf in call->tx_pending
  thread A: retakes user_mutex, hits the new TX_ERROR test, reaches
            out: and does call->tx_pending = txb, i.e. NULL

Does that detach B's txbuf permanently?  Nothing else appears to hold a
reference, and rxrpc_destroy_call() only frees what is left in
call->tx_pending, so the txbuf plus its page fragment would never be
released, along with the data already buffered in it.

Would taking the tx_pending snapshot before the flag tests, or returning
directly from them, avoid this?

> +			if (len == 0 && !more)
> +				txb->flags |= RXRPC_LAST_PACKET;
>  			rxrpc_queue_packet(rx, call, txb, notify_end_tx);
>  			txb = NULL;
>  		}
> @@ -464,6 +486,22 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
>  	_leave(" = %d", call->error);
>  	return call->error;
>  
> +maybe_error_rewind:
> +	/* If we got a retryable error after copying all the supplied data into
> +	 * the last packet, we need to rewind as much as we can so the caller
> +	 * knows they need to retry the sendmsg.
> +	 */
> +	if (copied && !more && !len) {
> +		unsigned int rewind_by = umin(copied, txb->len);
> +
> +		txb->space  += rewind_by;
> +		txb->len    -= rewind_by;
> +		txb->offset -= rewind_by;
> +		copied      -= rewind_by;
> +		if (call->tx_total_len != -1)
> +			call->tx_total_len += rewind_by;
> +		iov_iter_revert(&msg->msg_iter, rewind_by);
> +	}
>  maybe_error:
>  	if (copied) {
>  		if (rxrpc_call_is_complete(call) &&

[Severity: High]
Is rewind_by computed from the right quantity here?

copied is cumulative for the whole call to rxrpc_send_data(): it
accumulates across every iteration of the do-while loop, so it can
cover packets that were already handed to rxrpc_queue_packet(), and it
survives the wait_for_space path, which drops call->user_mutex and
sleeps in rxrpc_wait_for_tx_window() before jumping back to reload:.
txb->len, on the other hand, only describes the one packet in front of
us, and it may contain bytes that this call never copied - a previous
(or concurrent) sendmsg() on the same user_call_ID can have left a
partially filled buffer in call->tx_pending, which we pick up again at
the txb = call->tx_pending snapshot.

So the two arguments to umin() are not measuring the same thing, and
the rewind can be too large in both directions:

  thread A: sendmsg(len=6192), fills and queues txb1 (4096 bytes),
            copied=4096, no Tx space left, drops user_mutex and sleeps
  thread B: sendmsg(len=2000, MSG_MORE) on the same call, copies 2000
            bytes into a fresh txb2 and leaves it in call->tx_pending
  thread A: wakes, reloads txb2, copies its remaining 2096 bytes so
            txb2->len == 4096, len == 0, more == false
  thread A: ->secure_packet() returns -ENOMEM, so
            rewind_by = umin(6192, 4096) == 4096

txb->len then goes to 0, which silently discards the 2000 bytes B had
buffered and told userspace were accepted, and
iov_iter_revert(&msg->msg_iter, 4096) rewinds A past the 2096 bytes it
actually put into txb2 and into the region it already queued in txb1,
so the retry re-sends data that is already on the wire.  Duplication
and loss in the same step.  call->tx_total_len is adjusted by the same
wrong figure.

Even without a second thread, if copied spans more than one txb the
umin() clamp to txb->len can still exceed what this iteration put into
the current buffer whenever the buffer was inherited from an earlier
sendmsg().

Shouldn't the rewind use the number of bytes this pass copied into
this specific txb - e.g. a separate counter updated alongside
txb->offset in the copy_from_iter_full() block - rather than the
cumulative copied?  And should the rewind path be reachable at all
when the buffer may have been shared with another sender, or does that
want the tx_pending ownership question sorted out first?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260907113743.1453210-1-dhowells%40redhat.com

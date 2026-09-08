Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737443A872B;
	Tue,  8 Sep 2026 20:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788900585; cv=none; b=oqP+xpnhm82dEKt60ZDpyCKhWP8o5o+HmRQdkmv6ObDAu6tTLoRdzRyQ7fYTFPJ7+auyf//uGmhdAJ7ZkgsMSKY90u36JGR3aTAjQn0eRcUZ2N75uzTmV6bcPRB/XeRyvuGgc0f7xjSpR3D60DUltRHlbs60hmUwTLKCcr+aPtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788900585; c=relaxed/simple;
	bh=QM0259F94nl28aUwzfRXNkXgvccex6OqDWH81t2llfM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bBBw70qL0bPhYdrmiUfex6tk2l1YOdNbQFwCkho0ypcb/NR9GfV5cJX+FLrTKbcPllC68SutUH+0L5UO6Alyog5LLs+Dg0WAMCiPVb4zdwiy1Xl61WaXFZ9wWwk4wwwgphY/BQZY16kIacRY0CJnZJZcgq1H7UOBF/8sqXqOlEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLZ8JnFI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLZ8JnFI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 692E71F00A3D;
	Tue,  8 Sep 2026 20:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788900583;
	bh=7r0R/63h+FAkfv26iOtLC+2BNev6t0pm6m9CeYQM2jw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZLZ8JnFIpUjWwBorjKUx+/1o2vj8nQuraGl/l6wCSzv2CJlOAzYAcRMAchRygS41e
	 3p6htvaKT9JCzGEsMyqheKv5OcrXz1LrFcRbaIdesPurwwN3ifWo5LrhKYsh41qDNs
	 WVECn4/Zqlg7b0sG286wo6Id3eIvwQDnWELk14VStFsrol2mIpme5p8x6vHW17jHi9
	 4bLrUWHe6IeqfSIYx3oGpDuPg+pTeZRUZHkGwMVXsyZrWfBvsbJNGLWcI/AyjBPUBl
	 +nMHYEzKOizRKh0vx7N0KCzw4fmKn1aSxbIzxRk0lyqFdgRG+6kipkW6Sn5EXnQ60D
	 idBsXCVVRrueQ==
Subject: Re: [PATCH net v9 05/14] rxrpc: Fix sendmsg length
From: netdev-bot+sashiko@kernel.org
To: dhowells@redhat.com
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
 nicoyip.dev@gmail.com, stable@vger.kernel.org
Date: Tue, 08 Sep 2026 20:49:41 +0000
Message-ID: <178890058197.219967.4772442407824691930@kernel.org>
In-Reply-To: <20260907113743.1453210-6-dhowells@redhat.com>
References: <20260907113743.1453210-6-dhowells@redhat.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 0 · Low: 1

- [Low] "rxrpc: Fix sendmsg length" carries a `Fixes:` tag and `cc:
  stable@vger.kernel.org` while its own commit message states…

--

rxrpc: Fix sendmsg length

This makes rxrpc_send_data() consistently use its len argument rather than
msg->msg_iter.count, decrementing len as data is copied, and limits each
copy to the smaller of len and msg_data_left(msg).

> diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
> index 1d66e98081624..565799548102c 100644
> --- a/net/rxrpc/sendmsg.c
> +++ b/net/rxrpc/sendmsg.c
> @@ -379,9 +379,9 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
>  
>  	ret = -EMSGSIZE;
>  	if (call->tx_total_len != -1) {
> -		if (len - copied > call->tx_total_len)
> +		if (len > call->tx_total_len)
>  			goto maybe_error;
> -		if (!more && len - copied != call->tx_total_len)
> +		if (!more && len != call->tx_total_len)
>  			goto maybe_error;
>  	}

[Severity: Low]
This isn't a bug in the code, but a question about the tagging.  The
commit carries:

    Fixes: 382d7974de31 ("RxRPC: Use iov_iter_count() in rxrpc_send_data() instead of the len argument")
    cc: stable@vger.kernel.org

while the message itself says:

    Note that, currently, all the callers have len and msg->msg_iter.count the
    same and so the problem won't occur.

Walking the callers agrees with that statement.  rxrpc_do_sendmsg()
forwards the sendmsg() len that the syscall also used to build msg_iter.
In fs/afs/rxrpc.c, afs_make_call() and afs_send_simple_reply() pass
msg_data_left(&msg):

	ret = rxrpc_kernel_send_data(call->net->socket, rxcall, &msg,
				     msg_data_left(&msg),
				     afs_notify_end_request_tx);

and afs_send_empty_reply() passes 0 for a zero-length iterator.  In
net/rxrpc/rxperf.c, rxperf_process_call() passes the same local len used
to build the iterator:

		iov_iter_bvec(&msg.msg_iter, WRITE, &bv, 1, len);
		msg.msg_flags = MSG_MORE;
		n = rxrpc_kernel_send_data(rxperf_socket, call->rxcall, &msg,
					   len, rxperf_notify_end_reply_tx);

So no in-tree caller can diverge.  Given there is no symptom, reproducer
or affected caller named, are the Fixes: and cc: stable tags intended
here?

What stable trees would pick up instead is a rewrite of the sendmsg data
loop: len becomes mutable and is decremented in the loop, the copy bound
becomes min3(), the loop termination test gains a second clause, and the
-EMSGSIZE re-check that is re-executed via the reload label now tests the
decremented len instead of len - copied.

>  
> @@ -405,7 +405,7 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
>  			 * the security header is going to be in the padded
>  			 * region (enc blocksize), but the trailer is not.
>  			 */
> -			remain = more ? INT_MAX : msg_data_left(msg);
> +			remain = more ? INT_MAX : len;
>  			txb = call->conn->security->alloc_txbuf(call, remain, sk->sk_allocation);
>  			if (!txb) {
>  				ret = -ENOMEM;
> @@ -416,8 +416,8 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
>  		_debug("append");
>  
>  		/* append next segment of data to the current buffer */
> -		if (msg_data_left(msg) > 0) {
> -			size_t copy = umin(txb->space, msg_data_left(msg));
> +		if (len > 0) {
> +			size_t copy = min3(txb->space, len, msg_data_left(msg));
>  
>  			_debug("add %zu", copy);
>  			if (!copy_from_iter_full(txb->data + txb->offset,
> @@ -428,6 +428,7 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
>  			txb->len += copy;
>  			txb->offset += copy;
>  			copied += copy;
> +			len -= copy;
>  			if (call->tx_total_len != -1)
>  				call->tx_total_len -= copy;
>  		}
> @@ -439,8 +440,8 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
>  
>  		/* add the packet to the send queue if it's now full */
>  		if (!txb->space ||
> -		    (msg_data_left(msg) == 0 && !more)) {
> -			if (msg_data_left(msg) == 0 && !more)
> +		    (len == 0 && !more)) {
> +			if (len == 0 && !more)
>  				txb->flags |= RXRPC_LAST_PACKET;
>  
>  			ret = call->security->secure_packet(call, txb);
> @@ -449,7 +450,7 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
>  			rxrpc_queue_packet(rx, call, txb, notify_end_tx);
>  			txb = NULL;
>  		}
> -	} while (msg_data_left(msg) > 0);
> +	} while (len > 0 && msg_data_left(msg) > 0);

Making len mutable also appears to be a prerequisite for the later patch
in the series, "rxrpc: Fix packet encryption error handling", whose rewind
path tests:

	if (copied && !more && !len) {

which only behaves as intended once len is decremented here.  Could that
dependency be mentioned in the commit message?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260907113743.1453210-1-dhowells%40redhat.com

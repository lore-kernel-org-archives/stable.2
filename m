Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4253B442B;
	Tue,  8 Sep 2026 20:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788900587; cv=none; b=IfXVSQFmQoUIbjXIf0okYRiFab+0z7LoBCJYfLuDk/5HL8SABt/IdoQvFXQhKXBp0MW7d5p+KZS4UFhRzm9y991zG+X4691PmEh6yW3eRkL6jlGiXDiAEaeT74ZxERfu3NIb+9/TEItkBzQ7WBGDEtyRx0lyheVTs3UBc9NW/CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788900587; c=relaxed/simple;
	bh=Dng7831vqNk2SZgSqFVsQPCf1ZyMSGSym74azEmt+gM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I1mceGyjOnKSDQvmMqyLGnnmKECy7rPFjBI1TXu83HuKicWZJHXxm6j/GuFfUarxNzd2RmZr2/0F3gFolwPmsWI+DD+3fGpjIia606L2T7YSIO2TTOB6rV/GY61/otBk/T255awg+fRmAKkdPzM+JzExptdyHbX1LU1/0cN7SGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oklRGMHM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oklRGMHM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB4A41F00A3E;
	Tue,  8 Sep 2026 20:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788900585;
	bh=/hswGx65WijV47LY6dkL2gLh2Pm2eltopBe3BPD2/UE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=oklRGMHMSu8+H/66yZVd/pDHY2+EQCtGZZoJne14RKQoeOQxZ2ZoO+px3khUTiKap
	 e32en6i1aKsA+p++scK01AHHxrIRuxJUdyg4p5z1T3lr2G/jXnmiYNnGh3FUgDj2/z
	 QZqHhpXLWoTWGgHImX07IxX5o3mrheoqm4NBsRF5sZ2bmxFJ9cmpOkkUEPbwt8iayI
	 wQBdV52HtSuWWFZd7t+Mo5AYcLPiaRhZweMuRkANU4yzkuD+uMzZQ2e21eiCJeMR7+
	 fgh+owJmiNhsuhRqo1VgYF8OxNj589XrOtvHqCCSarcaZOvG08u9gwbxd5Zm81Eid5
	 ZrdvTK22I1Mvg==
Subject: Re: [PATCH net v9 07/14] rxrpc: Fix update of call->tx_pending
 without holding lock
From: netdev-bot+sashiko@kernel.org
To: dhowells@redhat.com
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
 nicoyip.dev@gmail.com, stable@vger.kernel.org
Date: Tue, 08 Sep 2026 20:49:44 +0000
Message-ID: <178890058440.219967.530648287942294857@kernel.org>
In-Reply-To: <20260907113743.1453210-8-dhowells@redhat.com>
References: <20260907113743.1453210-8-dhowells@redhat.com>
X-sashiko-severity: Critical
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

Critical: 1 · High: 0 · Medium: 0 · Low: 0

- [Critical] rxrpc_send_data() (net/rxrpc/sendmsg.c) can store an
  *indeterminate* pointer into call->tx_pending.

--

rxrpc: Fix update of call->tx_pending without holding lock

This moves the release of call->user_mutex down into rxrpc_send_data() and
drops the _dropped_lock indicator parameter, so the callers no longer have
to work out whether the lock is still held.  The interrupted-reacquire path
in wait_for_space now returns directly instead of falling through the
common exit path, and the exit labels are renamed to out_txb/out_unlock.

Closes: https://sashiko.dev/#/patchset/20260702144919.172295-1-dhowells%40redhat.com

> diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
> index 4ce3ae0ba2e88..8bb327dc2833e 100644
> --- a/net/rxrpc/sendmsg.c
> +++ b/net/rxrpc/sendmsg.c

[ ... ]

> @@ -464,7 +464,7 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
>  				if (ret == -ENOMEM)
>  					goto maybe_error_rewind;
>  				set_bit(RXRPC_CALL_TX_ERROR, &call->flags);
> -				goto out;
> +				goto out_txb;
>  			}
>  
>  			if (len == 0 && !more)
> @@ -476,15 +476,18 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
>  
>  success:
>  	ret = copied;
> -out:
> +out_txb:
>  	call->tx_pending = txb;
> +out_unlock:
> +	mutex_unlock(&call->user_mutex);
>  	_leave(" = %d", ret);
>  	return ret;

[Severity: Critical]

Can out_txb publish an uninitialised txb into call->tx_pending?

txb is declared without an initialiser in rxrpc_send_data():

	struct rxrpc_txbuf *txb;

but the two flag tests at the top of the reload block run before txb is
ever assigned, and both jump out of the function:

reload:
	if (unlikely(test_bit(RXRPC_CALL_TX_NO_MORE, &call->flags))) {
		...
		ret = -EPROTO;
		goto maybe_error;
	}
	if (unlikely(test_bit(RXRPC_CALL_TX_ERROR, &call->flags))) {
		...
		ret = -EIO;
		goto maybe_error;
	}

	txb = call->tx_pending;
	call->tx_pending = NULL;

With copied == 0, which is the case on first entry, maybe_error falls
straight through to "goto out_txb", so "call->tx_pending = txb;" runs on a
never-assigned variable.

A two-sendmsg() sequence on one AF_RXRPC call looks like it reaches this:
the first sendmsg() sends the whole request without MSG_MORE, so
rxrpc_queue_packet() sets RXRPC_CALL_TX_NO_MORE for the last packet; a
second sendmsg() before the call completes passes the
rxrpc_call_is_complete() gate in rxrpc_do_sendmsg(), enters
rxrpc_send_data(), trips the TX_NO_MORE test and returns -EPROTO via
out_txb.

Does call->tx_pending then hold a stale stack value that rxrpc_destroy_call()
hands to rxrpc_put_txbuf()?

net/rxrpc/call_object.c:rxrpc_destroy_call() {
	...
	rxrpc_put_txbuf(call->tx_pending, rxrpc_txbuf_put_cleaned);
	...
}

net/rxrpc/txbuf.c:rxrpc_put_txbuf() {
	if (txb) {
		debug_id = txb->debug_id;
		call_debug_id = txb->call_debug_id;
		seq = txb->seq;
		dead = __refcount_dec_and_test(&txb->ref, &r);
		...
	}
}

That dereferences, decrements and possibly kfree()s whatever was stored.
CONFIG_INIT_STACK_ALL_ZERO would reduce this to a NULL store, but
CONFIG_INIT_STACK_NONE builds would not.

There also looks to be a txbuf reference dropped on the TX_ERROR path even
when the pointer happens to be NULL: the fatal secure_packet() error above
sets RXRPC_CALL_TX_ERROR and stores the affected txbuf into
call->tx_pending via out_txb, and the next sendmsg() overwrites that
pointer from the TX_ERROR branch before "txb = call->tx_pending;" runs, so
the txbuf and its data buffer are never freed.

The two flag tests were placed above the "txb = call->tx_pending;"
assignment by the earlier "rxrpc: Fix packet encryption error handling"
change in this series, and this patch's rename to out_txb keeps the same
path.  Would having those two paths use "goto out_unlock", or initialising
txb to NULL at declaration, be preferable?

> @@ -507,36 +510,38 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
>  		if (rxrpc_call_is_complete(call) &&
>  		    call->error < 0) {
>  			ret = call->error;
> -			goto out;
> +			goto out_txb;
>  		}
>  		goto success;
>  	}
> -	goto out;
> +	goto out_txb;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260907113743.1453210-1-dhowells%40redhat.com

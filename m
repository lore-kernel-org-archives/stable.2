Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29074395AE4;
	Tue,  8 Sep 2026 20:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788900583; cv=none; b=ES6zSTUXQ3ONeGF1g25LH7B7bJLpugxVkxmRBt0vX2gSbDmL3YYBrSjrt2NA8pTcZsLPfxJQxIqCjjAUdiDxozIiphNb1oV+wAZPA1sq4HT8YhUDM48IaaZ25oTdSsO8AzGvwffmHPmSZdW3uxxXplBz3F4FBpj6oKjVXxr+w4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788900583; c=relaxed/simple;
	bh=4SXBkrXUyInid3/nvrXV0O2hS9HnwLvjXpQ2uf7h4B4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bwZXNJgIvTqddnWImozTnc4SJTWOipqW6sSmUtKXvX7K4V7I5jynA1tr/+Xn7wwwb70NOXjVg4+csGdSS6te8UHsf3vEk6hX0z+1zWiRIASSE+uBqjS20iP4A4lpYcEJ9WTzm07ha7TJsGJNdHDrNHKgqyhDCpPOh0Ycpxa3+cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kuRhmF6m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kuRhmF6m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3864B1F00A3A;
	Tue,  8 Sep 2026 20:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788900581;
	bh=9leMSA64tpIiA41G+YX8bMdC5iO0YLft2ZQu5sx7UPw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kuRhmF6mRe14c4407qZn+wXUG8AMEUr7i65XeYg7RYMJuZz1qi05jiXQqyjsDItev
	 0TjtUvP8TAN1dOAgR+enSsOmDF8++9O32NUZZdy/WWBXhejLWeNKYVHZ5avs8jy50I
	 UEzPLsZTcsLLXqVmG6YWPC92BIFY4N5IDrmLYNjfRzLgGBqBIb0FJ2TmDOgoPzpCjI
	 NiijVag1waPSkmOjJ4EPXznqIvBoAufY/uHxcpPr0qT/Ir36e2FFgSjy1i/ASToDig
	 xa5NEdPR2WmY9C9LX6Qsp7nv+vh1RXxUbK6O1pMqk9f7URJ+QCqLezZ5mnbXqqQLhq
	 YC0sCv2BS8kbw==
Subject: Re: [PATCH net v9 04/14] rxrpc: Fix sendmsg to not return an error if
 last packet queued
From: netdev-bot+sashiko@kernel.org
To: dhowells@redhat.com
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
 nicoyip.dev@gmail.com, stable@vger.kernel.org
Date: Tue, 08 Sep 2026 20:49:40 +0000
Message-ID: <178890058081.219967.17230403144391913788@kernel.org>
In-Reply-To: <20260907113743.1453210-5-dhowells@redhat.com>
References: <20260907113743.1453210-5-dhowells@redhat.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0 (2)

- [Medium] rxrpc_send_data() (net/rxrpc/sendmsg.c): the patch deletes the
  call-completion/error check from the *unconditional* `success:` path…

Pre-existing issues:
- [Low] Divergence between Documentation/networking/rxrpc.rst and the
  kernel-doc for rxrpc_kernel_send_data().
- [Low] At this patch, rxrpc_send_data()'s `out:` label writes
  `call->tx_pending = txb` (net/rxrpc/sendmsg.c:456-457) and is…

--

rxrpc: Fix sendmsg to not return an error if last packet queued

This moves the "call completed with an error" check in rxrpc_send_data()
out of the success path and into the partial-send path, so that a sendmsg()
that queued the last packet of a call reports the byte count and leaves the
completion for recvmsg() to report.  The kernel-doc for
rxrpc_kernel_send_data() is updated to document a byte-count return and the
possibility of short sends.

[ ... fs/afs/rxrpc.c hunk snipped, unrelated to the comments below ... ]

> diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
> index ed2c9a51005ad..1d66e98081624 100644
> --- a/net/rxrpc/sendmsg.c
> +++ b/net/rxrpc/sendmsg.c
> @@ -453,9 +453,6 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
>  
>  success:
>  	ret = copied;
> -	if (rxrpc_call_is_complete(call) &&
> -	    call->error < 0)
> -		ret = call->error;
>  out:
>  	call->tx_pending = txb;
>  	_leave(" = %d", ret);

[Severity: Medium]

The commit message describes the change as covering the case where sendmsg
"has successfully queued the last packet of a call", but the check is being
removed from the unconditional success: label in rxrpc_send_data(), which is
reached on every normal exit from the copy loop.  Is the broader scope
intended?

Two cases reach success: without any last packet having been queued:

 - a MSG_MORE send whose data does not fill a txbuf, where the bytes are
   only copied into call->tx_pending and nothing is queued at all;

 - a MSG_MORE send that queues a non-final packet.

For those sends the only completion test left is the one inside the loop:

	/* check for the far side aborting the call or a network error
	 * occurring */
	if (rxrpc_call_is_complete(call))
		goto call_terminated;

If the rxrpc I/O thread completes the call with an abort or network error
after that test and before the loop exits, sendmsg() now returns a positive
byte count for data that will never be transmitted.

The specific error is then not recoverable from the next sendmsg() either,
since rxrpc_do_sendmsg() substitutes a generic code before reaching
rxrpc_send_data():

	if (rxrpc_call_is_complete(call)) {
		/* it's too late for this call */
		ret = -ESHUTDOWN;
		goto out_put_unlock;
	}

so a remote abort delivered as -ECONNABORTED is reported as -ESHUTDOWN, and
userspace has to go to recvmsg() to obtain the abort code.

Since this patch is tagged for stable, would it be worth narrowing the
change to the "last packet queued" case, or describing the MSG_MORE
behaviour change in the commit message?

> @@ -467,8 +464,14 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
>  	return call->error;
>  
>  maybe_error:
> -	if (copied)
> +	if (copied) {
> +		if (rxrpc_call_is_complete(call) &&
> +		    call->error < 0) {
> +			ret = call->error;
> +			goto out;
> +		}
>  		goto success;
> +	}
>  	goto out;
>  
>  efault:

Reinstating the check here does not cover the cases above: once the last
packet has been queued the loop exits straight to success:, so maybe_error
is only reachable for partial or failed sends.

[Severity: Low]

This is a pre-existing issue and not introduced by this patch, but the
rewritten maybe_error block is the entry point for paths that jump to out:,
where the mutex-protected call->tx_pending is stored:

out:
	call->tx_pending = txb;

Is that store always made with call->user_mutex held?  wait_for_space
drops the mutex and then jumps back to maybe_error on failure:

wait_for_space:
	ret = -EAGAIN;
	if (msg->msg_flags & MSG_DONTWAIT)
		goto maybe_error;
	mutex_unlock(&call->user_mutex);
	*_dropped_lock = true;
	ret = rxrpc_wait_for_tx_window(rx, call, &timeo,
				       msg->msg_flags & MSG_WAITALL);
	if (ret < 0)
		goto maybe_error;
	if (call->interruptibility == RXRPC_INTERRUPTIBLE) {
		if (mutex_lock_interruptible(&call->user_mutex) < 0) {
			ret = sock_intr_errno(timeo);
			goto maybe_error;
		}

With two concurrent sendmsg() calls on the same user_call_ID, can the
unlocked store overwrite a partially filled txbuf that the thread actually
holding the mutex has just stored, leaking that rxrpc_txbuf and dropping
the data already copied into it?

For the record, the later commit "rxrpc: Fix update of call->tx_pending
without holding lock" in the same series removes this by moving the store
to an out_txb: label immediately followed by out_unlock: with the
mutex_unlock(), dropping the _dropped_lock parameter and returning the
lock-dropped failure paths via out_nolock: without touching
call->tx_pending.

> @@ -800,9 +803,16 @@ int rxrpc_do_sendmsg(struct rxrpc_sock *rx, struct msghdr *msg, size_t len)
>   * Allow a kernel service to send data on a call.  The call must be in an state
>   * appropriate to sending data.  No control data should be supplied in @msg,
>   * nor should an address be supplied.  MSG_MORE should be flagged if there's
> - * more data to come, otherwise this data will end the transmission phase.
> + * more data to come, otherwise this data will end the transmission phase if
> + * all the data is buffered.
> + *
> + * Note that this function may return a short send, in which case it should be
> + * called again for the remainder of the data or to pick up an error that
> + * caused the short send.
>   *
> - * Return: %0 if successful and a negative error code otherwise.
> + * Return: The number of bytes buffered (could be %0 if @len is 0 or
> + * msg_iter holds 0 bytes) if successful and a negative error code
> + * otherwise.
>   */

[Severity: Low]

This is a pre-existing documentation issue rather than something introduced
here, but Documentation/networking/rxrpc.rst describes a different contract
for rxrpc_kernel_send_data() than this kernel-doc: the rst still says len is
"the total amount of data to transmit" and mentions neither short sends nor
a byte-count return.

That paragraph is rewritten later in the series by "rxrpc: Fix packet
encryption error handling", which changes it to "len is the amount of data
to add to the transmission" and adds the short-write wording, so only one
sentence in the rst is left out of step:

     msg must not specify a destination address, control data or any flags
     other than MSG_MORE.

afs_make_call() passes MSG_WAITALL | MSG_MORE to rxrpc_kernel_send_data(),
which predates this series.  Should the flag restriction in the rst be
updated as well?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260907113743.1453210-1-dhowells%40redhat.com

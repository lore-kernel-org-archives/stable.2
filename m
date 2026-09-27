Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F11345CDA;
	Sun, 27 Sep 2026 14:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790521202; cv=none; b=Hpizo9i2tvYyjvd8k8fmwOGxWaQ+snzKkmkcQ7oXoBnKh9V10BXmL4vY6AvXkHjHCc+byvkZ3Hvj///mid4aPYzfeOwM07/Y5+TvPjRkj9/Q2i6dzlrEda8+mEKfywl8ff+6H/f9nZvj4PVaN/ZlGBZaSw85sziq5ft57u+8Mk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790521202; c=relaxed/simple;
	bh=H0Qmom2tkgwqvJfX7gSGee1fBr113ejIfVBMk+i0nco=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZjmcEYUgk7tEMiZmVi8UcomEIqxJmCGlmo56n71lKIokLGRyLhLQuM0GZXY7/JBs7caIUapwFhAmGT6os3JcTghHiSI+SviANnFwxMSssxs+h/Ve4MTo4/rMIgDN7mIKfDluWSkFCUJTwAcXytF+cz60q36zTcsP0DA3m39PF8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1o2oL09; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1o2oL09"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A4881F00898;
	Sun, 27 Sep 2026 14:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790521195;
	bh=u6XAMhjTJRb6b25i7RK70xnUXdek4cOv1QoXoB7sR54=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=E1o2oL092/L1iWTPYd5cF/pcsrmiFJ3rkQaGknlI32QRhDNaH+c9IPw5FAHGgp1I6
	 jDsHmM7wM+NPFLCMyrgnSIgQpKZWhxPeGAC8qP9AqtQnYEOy+o8gPxSCCMaYP7A190
	 YM1So5ksKC+4TdimrKgZcjpHiL+BeaFM63GYFFDg4HpEEPkQvwIA1U7i/aP7NSiDPt
	 fY95/NGIj2q9NVz6TKKcJQNrr1LD23CLeAZHjxfVdgo1o9cujjb5/0zI+5FZGlvLJ5
	 2cVVEbZe7nFnjiwR4aUyKNNT0BOp8EoNJ7weBaxf0UMAgDS4xKqws/IV+gLYRXXzw8
	 iR5DDW5XLwxrw==
Subject: Re: [PATCH net v11 10/17] rxrpc: Fix return in rxrpc_recvmsg_data()
 for service calls
From: netdev-bot+sashiko@kernel.org
To: dhowells@redhat.com
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
 qotmddnjs@ajou.ac.kr, stable@vger.kernel.org
Date: Sun, 27 Sep 2026 14:59:54 +0000
Message-ID: <179052119462.2160803.1826658379283991416@kernel.org>
In-Reply-To: <20260923133706.1496540-11-dhowells@redhat.com>
References: <20260923133706.1496540-11-dhowells@redhat.com>
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

- [Low] The commit is Cc'd to stable@vger.kernel.org but has no Fixes:
  tag.
- [Low] The patch adds a new normal return value, 2, to the exported
  kernel API rxrpc_kernel_recv_data(), but…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but rxperf can
  leak rxperf_call objects, and the rxrpc_call references they hold,…

--

rxrpc: Fix return in rxrpc_recvmsg_data() for service calls

This patch makes rxrpc_kernel_recv_data() return a new value, 2, when a
service call has received all of its request but has not finished yet. It
no longer returns 1 in that case, which made the call look complete. The
AFS and rxperf callers are updated to handle the new return value.

Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914151340.3227501-1-dhowells%40redhat.com

> cc: linux-afs@lists.infradead.org
> cc: stable@vger.kernel.org

[Severity: Low]
Should this have a Fixes: tag? It is Cc'd to stable, but nothing says
which trees need it.

The behaviour being fixed looks like it came from:

Fixes: 93368b6bd58a ("rxrpc: Move call state changes from recvmsg to I/O thread")

That commit dropped the state switch in rxrpc_kernel_recv_data(). The
switch had a default case that returned -EINPROGRESS for service calls
that were still processing, replying or waiting for the final ACK. In its
place, it added the RXRPC_CALL_RECVMSG_READ_ALL early return in
rxrpc_recvmsg_data(), which returns 1:

    if (test_bit(RXRPC_CALL_RECVMSG_READ_ALL, &call->flags)) {
        seq = call->ackr_window - 1;
        ret = 1;
        goto done;
    }

Since then, the ret == -EINPROGRESS checks in afs_deliver_to_call() and
rxperf_deliver_to_call() have been dead code.

Trees older than v6.2 still use the -EINPROGRESS contract. Without the
tag, stable maintainers could backport this to trees that don't need it.

> diff --git a/net/rxrpc/recvmsg.c b/net/rxrpc/recvmsg.c
> index efcba4b2e74f0..716f7f47d7e46 100644
> --- a/net/rxrpc/recvmsg.c
> +++ b/net/rxrpc/recvmsg.c
> @@ -637,9 +637,11 @@ int rxrpc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
>   * Note that we may return %-EAGAIN to drain empty packets at the end
>   * of the data, even if we've already copied over the requested data.
>   *
> - * Return: %0 if got what was asked for and there's more available, %1
> - * if we got what was asked for and we're at the end of the data and
> - * %-EAGAIN if we need more data.
> + * Return: %0 if got what was asked for and there's more available, %1 if we
> + * got what was asked for and we're at the end of the call, %2 if a service
> + * call received all of the request but is still in progress and %-EAGAIN if we
> + * need more data.  A variety of other errors can be returned if the call
> + * completed with failure.
>   */
>  int rxrpc_kernel_recv_data(struct socket *sock, struct rxrpc_call *call,
>  			   struct iov_iter *iter, size_t *_len,
> @@ -678,6 +680,11 @@ int rxrpc_kernel_recv_data(struct socket *sock, struct rxrpc_call *call,
>  
>  read_phase_complete:
>  	ret = 1;
> +	if (rxrpc_is_service_call(call)) {
> +		if (rxrpc_call_is_complete(call))
> +			goto call_failed;
> +		ret = 2;
> +	}

[Severity: Low]
Should Documentation/networking/rxrpc.rst be updated as well? Its section
on rxrpc_kernel_recv_data() still lists only three normal returns:

      There are three normal returns: 0 if the buffer was filled and want_more
      was true; 1 if the buffer was filled, the last DATA packet has been
      emptied and want_more was false; and -EAGAIN if the function needs to be
      called again.

With this change, a service call in that situation gets 2, or goes to
call_failed if the call has already completed. It no longer gets 1.

The kernel-doc above now lists %2, so the tree describes two different
return contracts for this exported function. A kernel service written from
rxrpc.rst would not know to handle 2.

>  out:
>  	if (_service)
>  		*_service = call->dest_srx.srx_service;
> diff --git a/net/rxrpc/rxperf.c b/net/rxrpc/rxperf.c
> index 5042e8bfca550..6ccfd40b5388c 100644
> --- a/net/rxrpc/rxperf.c
> +++ b/net/rxrpc/rxperf.c
> @@ -300,7 +300,7 @@ static void rxperf_deliver_to_call(struct work_struct *work)
>  						     &len, false, &remote_abort,
>  						     &call->service_id);
>  
> -			if (ret == -EINPROGRESS || ret == -EAGAIN)
> +			if (ret == -EAGAIN || ret == 2)
>  				return;

[Severity: Medium]
This is a pre-existing issue that this patch did not introduce, but can
rxperf leak rxperf_call objects, and the rxrpc_call refs they hold, when
the module is unloaded?

The only place an rxperf_call is freed is the call_complete path in
rxperf_deliver_to_call(). That path runs only when a notify_rx callback
queues the work item.

The teardown in rxperf_close_socket() looks like this:

    kernel_listen(rxperf_socket, 0);
    kernel_sock_shutdown(rxperf_socket, SHUT_RDWR);
    flush_workqueue(rxperf_workqueue);
    sock_release(rxperf_socket);

kernel_sock_shutdown() goes into rxrpc_shutdown(), which sets sk_state to
RXRPC_CLOSE. After that, sock_release()->rxrpc_release_calls_on_socket()
aborts any remaining calls with rxrpc_propose_abort(). The completion
notification is then dropped by this check in rxrpc_notify_socket():

    if (rx && sk->sk_state < RXRPC_CLOSE) {
        if (call->notify_rx) {

rxperf does not keep a list of outstanding calls. So a call still in
flight at unload, such as a partly received request or a call in
SV_AWAIT_ACK, never gets its rxperf_call freed or its rxcall ref dropped.

This patch returns early on ret == 2 in SV_AWAIT_ACK. Such calls now
reliably stay alive until the final ACK or completion arrives, so the
window for this is somewhat longer. The teardown gap itself is older than
this patch.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260923133706.1496540-1-dhowells%40redhat.com

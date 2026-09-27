Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB773340401;
	Sun, 27 Sep 2026 14:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790521195; cv=none; b=e6+V2Gb70n0iqCBw9mdnP+g9uGnd8qeTFYlfEP107FY1KKUNx0+3UtgsKCSjix78lDL8J/Fuih7mRH4oTOYCkAcCSArv2qJIt3nzRum+5azwVKWRbWo/zG3xFyQ/7VGVmy2SVW8sVHnWD04TDre9TmYNg6k4ke4dQCrt9MmC5GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790521195; c=relaxed/simple;
	bh=hfZe8Hi8ntbVnYWJnLBuVEnv3lQIDg69cUYlIweu4lE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZqO6CSf5gqe41BouY91VkL1XqPJ4zQdZ5Fe3aPR5n51HgwnsPW9tOdVC1ky7goigFpk7WX1LQLe3+o8f2x+fHT68gPKTi91nob4rLjRkk93e/sdH02PS39UIHioZOwD1PHRV47uQDI7LCkXmVlp2iawkab23QFK59NxeH5Dr7o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTIn9JfS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTIn9JfS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D381F000FF;
	Sun, 27 Sep 2026 14:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790521193;
	bh=EoUtWeAuUiJeGTH+uL8OFpnh1hfN7jGX+X6wPVqf1oM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kTIn9JfSBhIdxzZyYaW4ixLH73PniW8ZXrbsKLZs2RxRsylHNDShn64de9RQ8NZJX
	 TUdx2SfUvaqRkyme16kSkxFJcOYPo4l69iAiKfRXUMy4pQEtkW/rURbSeyGtCqMgBU
	 WNnT/b4Svw6tuX1lVzN9SuLCPGmCEeO/P4RsQp6QRyaum4KAv+/R9clebbaH6qWh5E
	 LZGvb9dDxVGLJRCqFeYfbJkgPf+ULpmSdy4XZrjqee4i3PMfoQOnz84Q5fIhoz/YOO
	 CmBddRWrLKZO3nQGs7JNoWCFrgMaYis6zTLN0ccJ1oJF6lQ8yqfy8H3F6ITf/Pfyvx
	 J9B+xyEffnZqQ==
Subject:
 Re: [PATCH net v11 08/17] rxrpc: Fix error handling in rxrpc_send_data()
From: netdev-bot+sashiko@kernel.org
To: dhowells@redhat.com
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
 qotmddnjs@ajou.ac.kr, stable@vger.kernel.org
Date: Sun, 27 Sep 2026 14:59:52 +0000
Message-ID: <179052119212.2160803.8225282033493339825@kernel.org>
In-Reply-To: <20260923133706.1496540-9-dhowells@redhat.com>
References: <20260923133706.1496540-9-dhowells@redhat.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix leaves the new -ESHUTDOWN contract incomplete, and this
  breaks AFS abort handling.
- [Medium] At this commit, the new SV_AWAIT_ACK handling in
  rxperf_deliver_to_call() treats a return of 1 from…
- [Medium] rxperf_process_call() now returns void, and
  rxperf_deliver_to_call() returns right after calling it (`case 0:…
- [Low] In rxrpc_send_data(), the new `test_bit(RXRPC_CALL_TX_NO_MORE)`
  branch under maybe_error is dead code, and its comment stops mid-…

--

rxrpc: Fix error handling in rxrpc_send_data()

This commit changes rxrpc_send_data() so that it doesn't return an error
after it has queued the last packet of a call. It also makes it return
-ESHUTDOWN if the call completes before the final packet is queued. The
-ESHUTDOWN to call->error translation is removed from
rxrpc_kernel_send_data(), and afs_make_call() and rxperf are changed to
match.

> diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
> index c38458157eccf..0b9027549580e 100644
> --- a/fs/afs/rxrpc.c
> +++ b/fs/afs/rxrpc.c
> @@ -448,13 +448,14 @@ void afs_make_call(struct afs_call *call, gfp_t gfp)
>  		return;
>  	}
>  
> -	if (ret == -ECONNABORTED) {
> +	if (ret == -ESHUTDOWN) {
>  		len = 0;
>  		iov_iter_kvec(&msg.msg_iter, ITER_DEST, NULL, 0, 0);
> -		rxrpc_kernel_recv_data(call->net->socket, rxcall,
> -				       &msg.msg_iter, &len, false,
> -				       &call->abort_code, &call->service_id);
> -		call->responded = true;
> +		ret = rxrpc_kernel_recv_data(call->net->socket, rxcall,
> +					     &msg.msg_iter, &len, false,
> +					     &call->abort_code, &call->service_id);
> +		if (ret == -ECONNABORTED)
> +			call->responded = true;
>  	}

[Severity: High]
Can rxrpc_kernel_send_data() still return -ECONNABORTED for a call that
the peer has aborted? The translation from -ESHUTDOWN to call->error is
gone. However, some paths in rxrpc_send_data() still return the raw
call->error and never reach the new RXRPC_CALL_COMPLETE case at reload.

rxrpc_wait_to_be_connected() still does:

no_wait:
	if (ret == 0 && rxrpc_call_is_complete(call))
		ret = call->error;

rxrpc_send_data() then goes straight to out_unlock with that value.

The rxrpc_wait_for_tx_window_*() helpers also still do:

		if (rxrpc_call_is_complete(call))
			return call->error;

That value goes to out_nolock. out_nolock returns copied if it is
nonzero, and the raw error otherwise.

Here is one example. The client is blocked in
rxrpc_wait_for_tx_window_nonintr() during a StoreData, and the fileserver
aborts the call with VBUSY or VOFFLINE:

- out_nolock returns copied (> 0).
- rxrpc_kernel_send_data() loops.
- The next rxrpc_send_data() gets -ECONNABORTED from
  rxrpc_wait_to_be_connected().

In that case the check above fails and rxrpc_kernel_recv_data() is not
called. So call->abort_code stays 0 and call->responded stays false.

afs_select_fileserver() then sees -ECONNABORTED with an abort code of 0
and takes the default case. Doesn't that lose the VBUSY/VOFFLINE retry,
the VMOVED handling and the EDQUOT/ENOSPC translation?

Before this patch, those paths all returned -ECONNABORTED, which the old
check here handled.

For userspace AF_RXRPC, an early termination can now show up three ways:
-ESHUTDOWN, the raw call->error, or a positive count from out_nolock.
That doesn't seem to match the new return-value comment in
rxrpc_send_data() or the commit message:

  "return -ESHUTDOWN if the call is now marked complete (e.g. it got
  aborted by the peer)"

Should these helpers return -ESHUTDOWN for a completed call instead, or
should rxrpc_kernel_send_data() keep the translation?

[ ... ]

> diff --git a/net/rxrpc/rxperf.c b/net/rxrpc/rxperf.c
> index 823eedc5d16f9..5042e8bfca550 100644
> --- a/net/rxrpc/rxperf.c
> +++ b/net/rxrpc/rxperf.c

[ ... ]

> @@ -293,18 +293,28 @@ static void rxperf_deliver_to_call(struct work_struct *work)
>  	       state == RXPERF_CALL_SV_AWAIT_ACK
>  	       ) {
>  		if (state == RXPERF_CALL_SV_AWAIT_ACK) {
> -			if (!rxrpc_kernel_check_life(rxperf_socket, call->rxcall))
> +			size_t len = 0;
> +			iov_iter_kvec(&call->iter, ITER_DEST, NULL, 0, 0);
> +			ret = rxrpc_kernel_recv_data(rxperf_socket,
> +						     call->rxcall, &call->iter,
> +						     &len, false, &remote_abort,
> +						     &call->service_id);
> +
> +			if (ret == -EINPROGRESS || ret == -EAGAIN)
> +				return;
> +			if (ret < 0 || ret == 1) {
> +				if (ret == 1)
> +					ret = 0;
>  				goto call_complete;
> +			}

[Severity: Medium]
Does a return of 1 here really mean the call has completed? At this
commit, rxrpc_kernel_recv_data() returns 1 from read_phase_complete once
the request data has been fully read, which can be before the final ACK
arrives:

read_phase_complete:
	ret = 1;

Suppose a requeued work item runs in RXPERF_CALL_SV_AWAIT_ACK while the
reply is still in flight. Wouldn't call_complete then call
rxrpc_kernel_shutdown_call(), rxrpc_kernel_put_call() and kfree(call) on
a call that is still live?

Also, rxrpc_kernel_recv_data() doesn't seem to return -EINPROGRESS, so
that test never matches.

A later commit in the series, "rxrpc: Fix return in rxrpc_recvmsg_data()
for service calls", fixes this. It makes rxrpc_kernel_recv_data() return
2 for a service call that hasn't completed, and changes this test to
check for 2. Could that change be folded in or moved earlier, so that
this commit doesn't have the problem on its own?

>  			return;
>  		}
>  
>  		ret = call->deliver(call);
> -		if (ret == 0)
> -			ret = rxperf_process_call(call);
> -
>  		switch (ret) {
>  		case 0:
> -			continue;
> +			rxperf_process_call(call);
> +			return;

[Severity: Medium]
Can this leak the rxperf_call and its rxrpc_call reference if sending the
reply fails? Before this patch, a send error went to the default case and
then to call_complete. Now teardown relies on a later notify_rx
requeueing the work.

rxperf_close_socket() does:

	kernel_listen(rxperf_socket, 0);
	kernel_sock_shutdown(rxperf_socket, SHUT_RDWR);
	flush_workqueue(rxperf_workqueue);
	sock_release(rxperf_socket);

Suppose a work item is inside rxperf_process_call(), sending a
multi-page reply, when the shutdown happens. The next chunk hits
SEND_SHUTDOWN at reload in rxrpc_send_data() and gets -EPIPE.
rxperf_process_call() then aborts the call and returns.

The completion then goes through __rxrpc_notify_socket(), which skips
notify_rx once the socket is closed:

	if (rx && sk->sk_state < RXRPC_CLOSE) {
		if (call->notify_rx) {

So the work is never requeued, and neither kfree(call) nor
rxrpc_kernel_put_call() runs. Wouldn't rxrpc_destroy_all_calls() then
block in wait_var_event() on rxnet->nr_calls when rxrpc is unloaded?

[ ... ]

> diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
> index 312be27ca75b5..80c6afc647870 100644
> --- a/net/rxrpc/sendmsg.c
> +++ b/net/rxrpc/sendmsg.c

[ ... ]

> @@ -449,31 +451,71 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,

[ ... ]

>  maybe_error:
> -	if (copied)
> -		goto success;
> +	if (copied) {
> +		if (test_bit(RXRPC_CALL_TX_NO_MORE, &call->flags)) {
> +			/* If we've get here, we must have slept waiting for space and .
> +			 */
> +			ret = copied;
> +			goto out_unlock;
> +		}

[Severity: Low]
This isn't a bug, but the comment stops mid-sentence ("waiting for space
and ."), and "we've get" should probably be "we've got".

Can this branch be reached at all? Only rxrpc_queue_packet() sets
RXRPC_CALL_TX_NO_MORE, and only for the last packet. That happens only
when len == 0 && !more, which ends the loop at "ret = copied". After a
sleep, reload rejects TX_NO_MORE with -EPROTO before anything can jump
to maybe_error.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260923133706.1496540-1-dhowells%40redhat.com

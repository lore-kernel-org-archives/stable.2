Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8E84B4865;
	Tue,  8 Sep 2026 20:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788900582; cv=none; b=Nq8TGQVDHTcFIqrMMqAr4PRojtfMPJ0OE0g1yqi7/WqoYsXytx5UJaCjXX42e4i1UVz2PX2NkcphQn9YlJRze9ldJ9Hd8VDUycMYz2jYRdSyuHeKP3fsu05QDY9YJbyayaTolrPFLOAIxLNNjeeFxcr46R3ovrf1WXrtZ2QeGCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788900582; c=relaxed/simple;
	bh=tOn/0dV3de7Yi2VXLiwA8IInIPaJtQehzOYtimwmhbg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jm59NdUTbCmLVrnsecwaD+DZBPWJoVRkxc4t+2iZZ9Mi+ZuH+h3mlyhpWxhyhZlQjCCwWx9g+UvckmZrH4dGqTBZZNumuWyjWs3LLY0zvn2+3f1VjYsyqz2Y3dPOdEYUyLAEtvYtUhnlppH64p2PO6+nTrLoGRDwnDvMGOBvBF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JhXS4jOF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JhXS4jOF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F39641F00A3D;
	Tue,  8 Sep 2026 20:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788900580;
	bh=Viau1CEPdJ5obh1f6435ZoDXLen33I/L3GXQvF9f6Dw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JhXS4jOFmW4Z3V6CKuF7SacjIwDB7uAx6mIxrzMNtvmEZLFnD9QAJWlHJbYuVxwWQ
	 e2ErIBJwwyrwqO7r1xSOmtwUmWk6SQh+f+nCK1ITMGgoHs0RnoHkDVjIAzEgWsAiB+
	 7RtXPAu9lpOZX43t2P1j0nSPCS5Hx1NOiHqk7Qh1Y6TfNj8XWlC67MT5qFPdFQCVdA
	 mPG+a2S8TCzPP/Xpkgj+FcJfWPPZgcaFvaVXjESUJrGK6mL0WVN7Pe/ZKtzBJYyDrs
	 +NO7rwcdGGjePoIyi5OBS1L63n0qDl25lrl9cEwNqvysxgVtK4PhFHpEpIjhftDh/O
	 ENV7NvJL4dCgg==
Subject: Re: [PATCH net v9 03/14] rxrpc: Fix lack of loop around reply send in
 rxperf server
From: netdev-bot+sashiko@kernel.org
To: dhowells@redhat.com
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
 nicoyip.dev@gmail.com, stable@vger.kernel.org
Date: Tue, 08 Sep 2026 20:49:39 +0000
Message-ID: <178890057952.219967.6823866558237895199@kernel.org>
In-Reply-To: <20260907113743.1453210-4-dhowells@redhat.com>
References: <20260907113743.1453210-4-dhowells@redhat.com>
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

- [Low] Claimed infinite loop in the new `do { ... } while (n >= 0 &&
  msg_data_left(&msg) > 0)` retry loop in rxperf_process_call()…

--

rxrpc: Fix lack of loop around reply send in rxperf server

This wraps the magic-cookie send in rxperf_process_call() in a loop so a
short send is retried, and changes the error path to always propose an
abort with the send error rather than only on -ENOMEM.  The
rxperf_abort_oom trace enum is replaced by rxperf_abort_send_error.

Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260824091645.415423-1-dhowells%40redhat.com

> diff --git a/net/rxrpc/rxperf.c b/net/rxrpc/rxperf.c
> index b8df6d22314d6..ebd54222c64ef 100644
> --- a/net/rxrpc/rxperf.c
> +++ b/net/rxrpc/rxperf.c
> @@ -538,15 +538,18 @@ static int rxperf_process_call(struct rxperf_call *call)
>  	iov[0].iov_len	= len;
>  	iov_iter_kvec(&msg.msg_iter, WRITE, iov, 1, len);
>  	msg.msg_flags = 0;
> -	n = rxrpc_kernel_send_data(rxperf_socket, call->rxcall, &msg, len,
> -				   rxperf_notify_end_reply_tx);
> +	do {
> +		n = rxrpc_kernel_send_data(rxperf_socket, call->rxcall,
> +					   &msg, msg_data_left(&msg),
> +					   rxperf_notify_end_reply_tx);
> +	} while (n >= 0 && msg_data_left(&msg) > 0);

[Severity: Low]
This isn't a bug as far as I could tell, but should the new loop also treat
a zero return as a failure the way the reply-payload loop just above it in
rxperf_process_call() does?

The earlier loop in the same function bails out explicitly:

	n = rxrpc_kernel_send_data(rxperf_socket, call->rxcall, &msg,
				   len, rxperf_notify_end_reply_tx);
	if (n < 0)
		return n;
	if (n == 0)
		return -EIO;

whereas the new loop counts n == 0 as progress and re-enters
rxrpc_kernel_send_data() while msg_data_left(&msg) is still non-zero.

I tried to construct a path where rxrpc_kernel_send_data() returns exactly 0
with the four cookie bytes still pending and could not find one in this tree.
A positive return is the number of bytes copied out of msg->msg_iter, every
error path in rxrpc_send_data() returns a strictly negative value, and the
only routes to a zero return are:

net/rxrpc/sendmsg.c:rxrpc_kernel_send_data() {
	...
	if (ret == -ESHUTDOWN)
		ret = call->error;
	...
}

and the call_terminated path returning call->error, both of which need
call->error == 0, i.e. RXRPC_CALL_SUCCEEDED.  For a service call that state
is only reached from RXRPC_CALL_SERVER_AWAIT_ACK in
rxrpc_end_tx_phase()->rxrpc_call_completed(), and AWAIT_ACK is only entered
by rxrpc_close_tx_phase() once a txb carrying RXRPC_LAST_PACKET has been
transmitted, which itself requires the caller's iterator to have been fully
consumed.  So the two conditions look mutually exclusive and the loop
terminates today.

Given that, would adding the same zero-progress escape make the new loop
match its sibling and not depend on that implicit state-machine property?

	do {
		n = rxrpc_kernel_send_data(rxperf_socket, call->rxcall,
					   &msg, msg_data_left(&msg),
					   rxperf_notify_end_reply_tx);
		if (n == 0) {
			n = -EIO;
			break;
		}
	} while (n > 0 && msg_data_left(&msg) > 0);

For reference, the later patch "rxrpc: Fix sendmsg to not return an error if
last packet queued" documents the return contract as the number of bytes
buffered, which can be 0 when the iterator holds 0 bytes; that is consistent
with the loop terminating here.  rxperf.c is not touched again later in the
series, so the loop stays as introduced.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260907113743.1453210-1-dhowells%40redhat.com

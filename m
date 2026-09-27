Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C42B547057;
	Sun, 27 Sep 2026 14:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790521192; cv=none; b=WlS9tQ5hll60pz24uK7P/U2reiEVP+1VnCJnVjWPUhtFMQ/qIm9S6eK8Uz8yd8HFmZxtKyiJAK0PBKVq0ndzJqzsnz9aHQemBEWm4rZb3qI7DLjW/Pbzk2LiUDogxhChy5g8FaiLCFKtxVaPgz/GHv17CoyaDsRJDzeFZHluOKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790521192; c=relaxed/simple;
	bh=JBL/r1ZccMUeV1Qaj2Qx/DS5xAXu6HXhsfFKQ80Ek4k=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k6yk6GMox2/kY70HFKHCv+QCeCCmwXIRFI2nt972hmyh1jd25tsSIzHqqO8RQ7GUPVUIxH3UKBMqODppSYn3/fYANYpK2Gsjg85FZscnaJ/GaOGXbMLGkuyZOsdkTY42/sisVrP8gxRl4U3l9BVo/ERRnAPZAzpwWojca8ZmgDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bjQvu4oL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bjQvu4oL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12A401F000FF;
	Sun, 27 Sep 2026 14:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790521190;
	bh=qfO0cOVHwAD+fvjw1GNXhVW+xDr1dAu1fpPZ7dM/atI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bjQvu4oLu4jhIl/qy5KB/Zm4JMMBILb4e6FUEpvsWoS8twB1+9tXZaDlLdajnkPSv
	 VgICjVUREo7ZHFvWrZI4gCMfgsCeacLOJVKlxI9+EP8oFCvHWjdURaXGd8xTI3GM82
	 XUohKYjCaHyrWPJIwMbDSWt5GkSb9Pr2+dVR0SqnikqMWD6IXVTgYx3Ha6mtrk8jCz
	 Ec9lxw9RZkLOxD7gR6rNz3QtYPLr8ne3DLPZ3e1e2/8+bZhb1GA2/7Ajh58kYd/oL1
	 anNRgmsWtU0MGchZpdkmq696PVOHwziCLrlv7jVi0ycCuUgqxLPEeNLxOHnbBcFuNO
	 SJlstnCdMxavQ==
Subject: Re: [PATCH net v11 04/17] rxrpc: Fix lack of short-send handling in
 rxrpc_kernel_send_data()
From: netdev-bot+sashiko@kernel.org
To: dhowells@redhat.com
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
 qotmddnjs@ajou.ac.kr, stable@vger.kernel.org
Date: Sun, 27 Sep 2026 14:59:49 +0000
Message-ID: <179052118957.2160803.647680873992562494@kernel.org>
In-Reply-To: <20260923133706.1496540-5-dhowells@redhat.com>
References: <20260923133706.1496540-5-dhowells@redhat.com>
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

- [Low] The patch adds this sentence to
  Documentation/networking/rxrpc.rst: rxrpc_kernel_send_data() "returns…

Pre-existing issues:
- [Low] Documentation/networking/rxrpc.rst says the msg passed to
  rxrpc_kernel_send_data() must not carry "any flags other than…

--

rxrpc: Fix lack of short-send handling in rxrpc_kernel_send_data()

This makes rxrpc_kernel_send_data() keep looping after a short send from
rxrpc_send_data() until the iterator is drained. It also drops the len
argument and uses the iterator count instead. On success the function now
returns 0 rather than the amount copied.

Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260824091645.415423-1-dhowells%40redhat.com

> diff --git a/Documentation/networking/rxrpc.rst b/Documentation/networking/rxrpc.rst
> index 8926dab8e2e60..01ad12fdf3058 100644
> --- a/Documentation/networking/rxrpc.rst
> +++ b/Documentation/networking/rxrpc.rst

[ ... ]

> @@ -880,13 +879,16 @@ The kernel interface functions are as follows:
>       MSG_MORE if there will be subsequent data sends for this call.
>  
>       The msg must not specify a destination address, control data or any flags
> -     other than MSG_MORE.  len is the total amount of data to transmit.
> +     other than MSG_MORE.

[Severity: Low]
This is a pre-existing issue, and this patch did not introduce it. Is the
"any flags other than MSG_MORE" restriction still correct? The in-tree
caller afs_make_call() passes MSG_WAITALL:

fs/afs/rxrpc.c:afs_make_call() {
    ...
	msg.msg_flags		= MSG_WAITALL | (call->write_iter ? MSG_MORE : 0);
    ...
}

rxrpc_send_data() also acts on both MSG_DONTWAIT and MSG_WAITALL:

net/rxrpc/sendmsg.c:rxrpc_send_data() {
    ...
	timeo = sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
    ...
wait_for_space:
	ret = -EAGAIN;
	if (msg->msg_flags & MSG_DONTWAIT)
		goto maybe_error;
	...
	ret = rxrpc_wait_for_tx_window(rx, call, &timeo,
				       msg->msg_flags & MSG_WAITALL);
    ...
}

This sentence is already being edited here. Could it be changed to list
the flags that are actually honoured? The same wording is still present
at the end of the series.

>  
>       notify_end_rx can be NULL or it can be used to specify a function to be
>       called when the call changes state to end the Tx phase.  This function is
>       called with a spinlock held to prevent the last DATA packet from being
>       transmitted until the function returns.
>  
> +     It returns 0 if all the data is queued and a negative error code on
> +     failure.

[Severity: Low]
Is "queued" the right word here? Suppose MSG_MORE is set and the data
does not exactly fill a txbuf. In that case rxrpc_send_data() leaves the
partly filled txbuf in call->tx_pending and does not call
rxrpc_queue_packet():

net/rxrpc/sendmsg.c:rxrpc_send_data() {
    ...
		/* add the packet to the send queue if it's now full */
		if (!txb->space ||
		    (msg_data_left(msg) == 0 && !more)) {
			...
			rxrpc_queue_packet(rx, call, txb, notify_end_tx);
			call->tx_pending = NULL;
		}
    ...
}

At that point the iterator is empty, so the new loop in
rxrpc_kernel_send_data() returns 0:

		if (msg_data_left(msg) == 0) {
			ret = 0;
			break;
		}

Two examples of this path are rxperf_process_call() sending ZERO_PAGE
chunks, and afs_make_call() sending the request header before
write_iter.

So a return of 0 seems to mean the data was taken from the iterator and
buffered, not queued in the rxrpc_queue_packet() sense. A later patch in
the series, "rxrpc: Fix sendmsg length", uses the word "buffered" for
this same state in this document.

A negative return can also now follow a partial transfer. An earlier pass
of the loop may consume part of the iterator before a later pass fails.
Should the documentation say so as well?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260923133706.1496540-1-dhowells%40redhat.com

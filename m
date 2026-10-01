Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5623EF0A0;
	Thu,  1 Oct 2026 16:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790872510; cv=none; b=cFTyaWAJjEfqFmfAnWhDsAxB5tEK8YNvd/w9OyEB5axU2AM+6zIOu69fg6xFKT6JXQ2/h7Ql9hTJzAHjdjklfdI0/dMXr51zq3YiVye0+C9ifR3KQyMZ4G2J4jdrYOi0IkxocnAb7OGlmQkc86+re8bvuxiNsBOxzRbZassU80A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790872510; c=relaxed/simple;
	bh=K9ipQYhDUImEGFkWItdOFON/xTYTCacdhdBcgKQDA/Y=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pSNHNEfqed3OWRUqUKP9eJoIUCUrAI2GMHoqbzHgW7eUV9QEtEBPR5AlmVFBkEgLALrTjFjTZ/F0loxS/TgdQgi7fZoHh/ak//cVI00cM1w2P4JiBeJjzu4rtNpm180JkJby9A6P22n8dKziB5nKZCmcntpIYorlBJC8rGCPFLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ebApsIb2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebApsIb2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F1151F000FF;
	Thu,  1 Oct 2026 16:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790872508;
	bh=u32X4VpgmHbk5ebw0Pu1w8aVte2ZcN+S8G/K2mFCaiU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ebApsIb2FOL2jH3V++g/q73QKPEF+WeYpfs7qNi/FzMfzD28r3sXO7LqFtPKaonKW
	 V6G2lKCJBjnacRYaemv80x0CpjdbKe2hMaVP1goEJ/ySyhy12ANiPtQIRjKPGt6tZj
	 niGv0ceupVDlwUpqDtRPLWjWoB0H2OT+ILS6z/1pPTDrEJE5jhwOVtw4bMuvolR/uN
	 mp4+Y8+Gj2ugVa4XR6hcbLYvAU5oQioinGZwlmpmdnLb6e9ZKT5PRXz3tx3ZpMgGVC
	 0whZkjwgqhV9enCE3oNy192dzfed+X+rVquXnHk1ZGFdUyHPv1BfIZp7etd46i6XRq
	 TR3gfWdYgHHPg==
Subject: Re: [PATCH net] vsock/bpf: release sock lock while waiting for data
 in recvmsg
From: netdev-bot+sashiko@kernel.org
To: jrmmhm.kernel@eldare.de
Cc: sgarzare@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 bobby.eshleman@bytedance.com, mst@redhat.com, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 stable@vger.kernel.org
Date: Thu, 01 Oct 2026 16:35:07 +0000
Message-ID: <179087250713.434549.8388772928991296342@kernel.org>
In-Reply-To: <20260929-kbh3-1-022-fix-v1-1-cc97cc95d269@eldare.de>
References: <20260929-kbh3-1-022-fix-v1-1-cc97cc95d269@eldare.de>
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
issue(s) to consider.

Critical: 0 · High: 0 (2) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Because the patch releases the socket lock around wait_woken()
  in vsock_msg_wait_data() (net/vmw_vsock/vsock_bpf.c:52-57), the virtio…

Pre-existing issues:
- [High] In net/vmw_vsock/vsock_bpf.c, vsock_msg_wait_data() stops
  waiting only when the local socket has RCV_SHUTDOWN set (line 43: `if…
- [High] vsock_bpf_recvmsg() in net/vmw_vsock/vsock_bpf.c has no zero-
  length early return.

--

vsock/bpf: release sock lock while waiting for data in recvmsg

This commit drops the socket lock around wait_woken() in
vsock_msg_wait_data(). The transport rx path, virtio_transport_recv_pkt(),
can then take lock_sock() and deliver data while a sockmap reader sleeps.
Before this change, a blocking recv() and the shared vsock delivery worker
deadlocked on the same socket lock.

> diff --git a/net/vmw_vsock/vsock_bpf.c b/net/vmw_vsock/vsock_bpf.c
> index 9049d26486460..bb7d81a95baa6 100644
> --- a/net/vmw_vsock/vsock_bpf.c
> +++ b/net/vmw_vsock/vsock_bpf.c
> @@ -50,7 +50,9 @@ static bool vsock_msg_wait_data(struct sock *sk, struct sk_psock *psock, long ti
>  	sk_set_bit(SOCKWQ_ASYNC_WAITDATA, sk);
>  	ret = vsock_has_data(sk, psock);
>  	if (!ret) {
> +		release_sock(sk);
>  		wait_woken(&wait, TASK_INTERRUPTIBLE, timeo);
> +		lock_sock(sk);
>  		ret = vsock_has_data(sk, psock);

[Severity: Medium]
With the lock dropped here, virtio_transport_recv_pkt() can run while the
reader sleeps. Can it wake the reader for events that carry no data?

The reader sleeps on sk_sleep(sk) with woken_wake_function(), which
ignores the poll key. virtio_transport_recv_pkt() calls sk_write_space()
for every packet when space is available:

net/vmw_vsock/virtio_transport_common.c:virtio_transport_recv_pkt() {
    ...
	if (space_available)
		sk->sk_write_space(sk);
    ...
}

OP_CREDIT_UPDATE in virtio_transport_recv_connected() does the same. For
vsock this is sock_def_write_space(), which calls
wake_up_interruptible_sync_poll() on the same wait queue.

OP_SHUTDOWN and RST call sk_state_change(). An SK_DROP verdict or a
redirect to another socket also wakes the reader through
sk_psock_data_ready(), without queuing anything for it.

After such a wakeup, vsock_has_data() returns false. vsock_msg_wait_data()
then returns false without waiting again for the rest of timeo, and
vsock_bpf_recvmsg() does this:

		if (!vsock_msg_wait_data(sk, psock, timeo)) {
			copied = -EAGAIN;
			break;
		}

Would a blocking recv() with no SO_RCVTIMEO then fail with -EAGAIN as
soon as the peer sends a credit update?

For comparison, vsock_connectible_wait_data() loops until one of these
happens: data arrives, sk_err is set, RCV_SHUTDOWN or peer SEND_SHUTDOWN
is seen, the timeout expires, or a signal is pending. On a signal it
returns sock_intr_errno().

The BPF path also returns -EAGAIN when a signal is pending. That part
existed before this patch.

Should vsock_msg_wait_data() loop the same way that
vsock_connectible_wait_data() does?

>  	}
>  	sk_clear_bit(SOCKWQ_ASYNC_WAITDATA, sk);

[Severity: High]
This is a pre-existing issue and was not introduced by this patch. Can a
blocking recv() still hang after the peer shuts down or resets?

The only exit condition vsock_msg_wait_data() checks is a local shutdown:

	if (sk->sk_shutdown & RCV_SHUTDOWN)
		return true;

The virtio, vhost and loopback transports report a peer shutdown only
through vsk->peer_shutdown:

- virtio_transport_recv_connected() sets it for OP_SHUTDOWN.
- virtio_transport_do_close() sets peer_shutdown = SHUTDOWN_MASK and
  SOCK_DONE for RST or a full close.

sk->sk_shutdown changes only on a local shutdown().

Suppose the peer has shut down and the receive and psock queues are
empty:

- vsock_bpf_recvmsg() skips the native fallback.
- sk_msg_recvmsg() returns 0.
- vsock_msg_wait_data() sleeps in wait_woken().

vsock_remove_sock() has already removed the socket, so no further wakeups
will arrive. The recv() sleeps until a signal arrives or a finite
SO_RCVTIMEO expires.

Meanwhile vsock_poll() reports EPOLLIN | EPOLLRDNORM on peer
SEND_SHUTDOWN. poll() says the socket is readable while recv() blocks.

If the reader is already asleep when the shutdown arrives, the
sk_state_change() wakeup that this patch now allows makes recv() return
-EAGAIN instead of 0. A retry then hangs as described above.

The native vsock_connectible_wait_data() handles this case:

		if (sk->sk_err != 0 ||
		    (sk->sk_shutdown & RCV_SHUTDOWN) ||
		    (vsk->peer_shutdown & SEND_SHUTDOWN)) {
			break;
		}

__vsock_connectible_recvmsg() also returns 0 for a socket that is not
TCP_ESTABLISHED and has SOCK_DONE set.

After this fix, this is the remaining case where a blocking recv() hangs
until a signal arrives. Could it be handled while aligning with
vsock_connectible_wait_data()?

[Severity: High]
This is also a pre-existing issue and was not introduced by this patch.
Can vsock_bpf_recvmsg() spin forever with the socket lock held when len
is 0?

tcp_bpf, udp_bpf and unix_bpf all return early with "if (!len) return 0;",
and __vsock_connectible_recvmsg() handles len == 0 explicitly.
vsock_bpf_recvmsg() does neither.

If psock->ingress_msg is not empty, for example after SK_PASS or an
ingress redirect, sk_psock_queue_empty() is false. The native fallback is
then skipped:

	if (vsock_has_data(sk, psock) && sk_psock_queue_empty(psock)) {

With len == 0, __sk_msg_recvmsg() never enters its
"while (copied != len)" loop. It returns 0 without consuming anything, so
the loop in vsock_bpf_recvmsg() repeats:

	copied = sk_msg_recvmsg(sk, psock, msg, len, flags);
	while (copied == 0) {
		long timeo = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);

		if (!vsock_msg_wait_data(sk, psock, timeo)) {
			copied = -EAGAIN;
			break;
		}
		...
		copied = sk_msg_recvmsg(sk, psock, msg, len, flags);
	}

vsock_msg_wait_data() sees that vsock_has_data() is true and returns true
without sleeping, so the loop never reaches the new release_sock(). The
loop never calls cond_resched() or checks for signals, and it keeps
ownership of lock_sock(sk) the whole time.

Would the vsock-loopback worker or the vhost/virtio rx path then block in
lock_sock() on this socket? That would stop rx for every socket on the
transport, which is the symptom this commit sets out to fix.

Would adding the same "if (!len) return 0;" check that the other *_bpf
recvmsg implementations have be enough here?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260929-kbh3-1-022-fix-v1-1-cc97cc95d269%40eldare.de

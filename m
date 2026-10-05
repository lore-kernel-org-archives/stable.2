Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378B540681D;
	Mon,  5 Oct 2026 21:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791235568; cv=none; b=dr84Vby09Pe+eYx2YaPADTwGoQa9RP4L9QOJGJiDBob9HrEtFAt1yCAeB7pqbeOVGy2+uge9xyVTxudZxFb44K0sHajPbZ2cuV5HYuMGBjAEPV8UKYzesKV3hAaZzJpZOqSZvhv1Zzzc5XOE4sa5Xdo47peQL+x8UtPNZfLd6i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791235568; c=relaxed/simple;
	bh=9NgEtDdJu3j+6pP0gmkv8B/r4M7eIow+qhdMXzrnJpc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iUxp0mHXZiRF7bRT+9PIvUYZV6GJQbJUJ4A3adP5sGcsbdx+eJPZBGJL3ErahkZ0tHoJdbtu9dzHnAX4G+w4Ps5C7fcNZUP9WXAVLBxpOZDZBwWv3518gdhiHEt4e1er/APQ5uGk4GeaDFyp5SDb4xLDdoc2I4NwlvW5b/1vaOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSH+B4XP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSH+B4XP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC0BD1F00893;
	Mon,  5 Oct 2026 21:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791235564;
	bh=8OefnokcNLrZKb9tp0wPND9CYM539M3kIWSCBZ65Krk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lSH+B4XPCI3w9p6prGscAXpaccvgAhpXFFAGoVn2ikp9LU15gnnpDuVZuh3zbzYkB
	 SPpCl5Lhp5RAfHC5EIFV00YN+tqiElFz7UKV7ZQG7WWaYfNfB9bkSzo5jIeVVnZ/1n
	 GdkakOmq5drmG/YTfL7POb+wAB7ketLrT5okyFda5FF12gRP5JM7UPY/zRjKwnLW2Q
	 pVQhZJN58P1FwYgq31AIZaRJs9t0t+naeLsvMk77ToS60oB6N6ktnMZcHk0MHb0ALR
	 nsWFfObhSiFUK4byIe6WCkB6pRPYdfyaIISHsXT1T5J+yxiTHDyyHQW/kHB/z/WF4E
	 r06/n1v52Fp4A==
Subject: Re: [PATCH net v2] vsock/bpf: release sock lock while waiting for
 data in recvmsg
From: netdev-bot+sashiko@kernel.org
To: jrmmhm.kernel@eldare.de
Cc: sgarzare@redhat.com, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, mst@redhat.com,
 bobby.eshleman@bytedance.com, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 mhal@rbox.co, stable@vger.kernel.org
Date: Mon, 05 Oct 2026 21:26:03 +0000
Message-ID: <179123556339.434549.8635789838298158117@kernel.org>
In-Reply-To: <20261001-kbh3-1-022-fix-v2-v1-1-cfae958a1976@eldare.de>
References: <20261001-kbh3-1-022-fix-v2-v1-1-cfae958a1976@eldare.de>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The rewritten vsock_msg_wait_data()
  (net/vmw_vsock/vsock_bpf.c:47-77) detects a reset only through…
- [Low] vsock_bpf_recvmsg() (net/vmw_vsock/vsock_bpf.c:105-109) sends
  only MSG_ERRQUEUE to the native path before the new `if (!len) return…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the patch
  rewrites the code around it.

--

vsock/bpf: release sock lock while waiting for data in recvmsg

This patch changes vsock_msg_wait_data() so it drops the socket lock
around wait_woken(). It also makes the helper loop until data is ready,
an error or shutdown is seen, the timeout expires or a signal is pending.
In vsock_bpf_recvmsg(), MSG_ERRQUEUE now goes to the native path, and
zero-length reads return 0 early.

> diff --git a/net/vmw_vsock/vsock_bpf.c b/net/vmw_vsock/vsock_bpf.c
> index 9049d26486460..127a20429aa6c 100644
> --- a/net/vmw_vsock/vsock_bpf.c
> +++ b/net/vmw_vsock/vsock_bpf.c
> @@ -34,24 +34,46 @@ static bool vsock_has_data(struct sock *sk, struct sk_psock *psock)
>  	return vsock_sk_has_data(sk, psock);
>  }
>  
> -static bool vsock_msg_wait_data(struct sock *sk, struct sk_psock *psock, long timeo)
> +/* Returns 1 if data is ready, 0 on EOF/shutdown, or a negative error. */
> +static int vsock_msg_wait_data(struct sock *sk, struct sk_psock *psock, long timeo)
>  {

[ ... ]

> +	while (1) {
> +		if (vsock_has_data(sk, psock)) {
> +			ret = 1;
> +			break;
> +		}
> +
> +		if (sk->sk_err) {
> +			ret = -sk->sk_err;
> +			break;
> +		}
> +
> +		if ((sk->sk_shutdown & RCV_SHUTDOWN) ||
> +		    (vsk->peer_shutdown & SEND_SHUTDOWN)) {
> +			ret = 0;
> +			break;
> +		}

[Severity: Medium]
Can this loop sleep forever on a connection that has already been reset?

The only reset signal checked here is sk->sk_err. Its value can be cleared
from userspace. virtio_vsock_reset_sock() runs on
VIRTIO_VSOCK_EVENT_TRANSPORT_RESET (for example after live migration) and
on device removal. It sets only the state and the error:

net/vmw_vsock/virtio_transport.c:virtio_vsock_reset_sock() {
	...
	sk->sk_state = TCP_CLOSE;
	sk->sk_err = ECONNRESET;
	sk_error_report(sk);
}

It does not set any sk_shutdown or peer_shutdown bits, and the psock stays
in place.

Suppose the application then calls getsockopt(SO_ERROR). sk_getsockopt()
calls sock_error(), which clears sk_err with xchg(). The next recv() on the
sockmap'd socket with empty queues gets copied == 0 from sk_msg_recvmsg()
and enters this loop. None of the exit conditions is true there. A blocking
call waits until a signal arrives or SO_RCVTIMEO expires, and a
non-blocking call returns -EAGAIN.

The native path handles this case before it ever waits:

net/vmw_vsock/af_vsock.c:__vsock_connectible_recvmsg() {
	...
	if (!transport || sk->sk_state != TCP_ESTABLISHED) {
		...
		if (sock_flag(sk, SOCK_DONE))
			err = 0;
		else
			err = -ENOTCONN;

		goto out;
	}
	...
}

The commit message says this fixes the case where "the socket errored (for
example a reset), recv() did not notice and kept waiting". Should the loop
also check sk->sk_state and SOCK_DONE, so that case still works after the
error has been read?

> +
> +		if (!timeo) {
> +			ret = -EAGAIN;
> +			break;
> +		}
> +
> +		release_sock(sk);
> +		timeo = wait_woken(&wait, TASK_INTERRUPTIBLE, timeo);
> +		lock_sock(sk);

[ ... ]

> @@ -80,6 +102,12 @@ static int vsock_bpf_recvmsg(struct sock *sk, struct msghdr *msg,
>  	struct vsock_sock *vsk;
>  	int copied;
>  
> +	if (unlikely(flags & MSG_ERRQUEUE))
> +		return __vsock_recvmsg(sk, msg, len, flags);
> +
> +	if (!len)
> +		return 0;

[Severity: Low]
Should MSG_OOB be rejected here as well, next to MSG_ERRQUEUE?

With this shortcut, recv(fd, buf, 0, MSG_OOB) on a sockmap'd vsock socket
always returns 0.

Before this patch, the same call reached __vsock_recvmsg() when transport
data was pending and ingress_msg was empty. __vsock_connectible_recvmsg()
then returned -EOPNOTSUPP before its own zero-length check:

	if (flags & MSG_OOB) {
		err = -EOPNOTSUPP;
		goto out;
	}

The commit message cites unix_bpf_recvmsg() as a model, and it does this
before its len == 0 guard:

	if (flags & MSG_OOB)
		return -EOPNOTSUPP;

	if (!len)
		return 0;

There is also an older issue from 634f1a7110b4. With len > 0 and data in
ingress_msg, a MSG_OOB read reaches sk_msg_recvmsg(). That function only
looks at MSG_PEEK, so it copies and consumes ordinary stream bytes. With
empty queues, the read blocks in the wait loop instead of failing right
away. Rejecting MSG_OOB next to the new MSG_ERRQUEUE check would fix both
cases.

> +
>  	psock = sk_psock_get(sk);
>  	if (unlikely(!psock))
>  		return __vsock_recvmsg(sk, msg, len, flags);

[ ... ]

> @@ -101,11 +129,14 @@ static int vsock_bpf_recvmsg(struct sock *sk, struct msghdr *msg,
>  	copied = sk_msg_recvmsg(sk, psock, msg, len, flags);
>  	while (copied == 0) {
>  		long timeo = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
> +		int data = vsock_msg_wait_data(sk, psock, timeo);
>  
> -		if (!vsock_msg_wait_data(sk, psock, timeo)) {
> -			copied = -EAGAIN;
> +		if (data < 0) {
> +			copied = data;
>  			break;
>  		}
> +		if (!data)
> +			break;
>  
>  		if (sk_psock_queue_empty(psock)) {
>  			release_sock(sk);

[Severity: High]
This isn't a bug introduced by this patch, but the patch rewrites the code
around it. Can a blocking recv() hang here while data is waiting in
psock->ingress_msg?

vsock_msg_wait_data() returns 1 whenever vsock_has_data() is true.
vsock_sk_has_data() counts a non-empty psock->ingress_skb as data:

#define vsock_sk_has_data(__sk, __psock)				\
		({	!skb_queue_empty(&(__sk)->sk_receive_queue) ||	\
			!skb_queue_empty(&(__psock)->ingress_skb) ||	\
			!list_empty(&(__psock)->ingress_msg);		\
		})

sk_psock_queue_empty(), however, only checks ingress_msg. The same pair of
checks is also used before the loop:

	if (vsock_has_data(sk, psock) && sk_psock_queue_empty(psock)) {

Redirected-ingress data always passes through ingress_skb first:

net/core/skmsg.c:sk_psock_skb_redirect() {
	...
	skb_queue_tail(&psock_other->ingress_skb, skb);
	schedule_delayed_work(&psock_other->work, 0);
	...
}

If the only pending data is on ingress_skb and sk_psock_backlog() has not
run yet, the reader drops the lock and the psock reference here and falls
into the native path:

__vsock_recvmsg()
  __vsock_connectible_recvmsg()
    __vsock_stream_recvmsg()
      vsock_connectible_wait_data()

That native wait loop only wakes for vsock_connectible_has_data() != 0,
sk_err or a shutdown flag. It never looks at the psock queues. When the
backlog worker later moves the data to ingress_msg and wakes the socket,
the native reader sees transport data == 0 and goes back to sleep.

If the socket also has a verdict program, sk_psock_verdict_data_ready()
pulls new transport data via read_skb, and an SK_PASS verdict queues it on
ingress_msg. The transport count therefore stays at 0. The blocking recv()
then waits until a signal arrives or SO_RCVTIMEO expires.

The reader can enter this window on a fresh recv(). It can also enter it
after a spurious wakeup, such as the credit-update sk_write_space() wakeup
mentioned in the commit message, which now makes the loop re-check.

Should this fallback also take psock->ingress_skb into account?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261001-kbh3-1-022-fix-v2-v1-1-cfae958a1976%40eldare.de

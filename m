Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794470933;
	b=2huG+VRYiu2uufzA2+rj0h4VB+HA3JofdWkN9/7Jl8zGBHinXF5BAwe+Uj+/VEf2rTYZ
	 mpiay6vFz3f4eQu0BLgJSDWCx3Sg6XRvROl9jv4ti18skWg0rRQX8KM1ip7Jb5hiWSmNg
	 cWSlrzP4yRxTbS67Qn3bhBJuKLNxeDepWbRMhzMLPSW3vYEA0lt8/zRVzQGVfuDu+Lo97
	 CFIBYCaW4UD0bXJlGkW5hERVoWzJZefSuteTSnKpvt0TpgbspqZtMDc9MJwtBNRK0odPy
	 osRg9LRLP/qFv9BBD6mOSq8HvFk1malvhkd3StxUXTjzKBX2sRizWI9s41bPfu8sPjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794470933;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=d9RLIovI7owKrDahKOFCTkrcbwtOL6ZwvZYguMj3eOo=;
	b=gq0e0mhirilQ86I4tS+8oMbMQ8xlvzNwI+hSmYNnuNofkwBVaGIdGjxyafjttrB3e8Om
	 CQPKFFP5Cn3cum/vhhSkxaw9+yFxoKJ1eKNeXJYVCSiyCo0/JwAu8kJbNJkgQkdZ1EkuP
	 wlXpwZz31cOdE/NMz0botK5Xg8GyliSt6eUYl6EP9Tn1UvdbY2Kmqs8ynkPW+jQTussng
	 lLQtJZ1lWZSk+vXRfHD3SFsHjgErkuJExx6c24zuUaM7HiIPh3wSQ9b9S9dVSqhoJ5/fI
	 01/DdKqreMrL0LZYxZDXYyq9CVhFTzHoTOtzh4CkqTpyGyLKs+6PENq4uaVU9pBdAMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YW4hO7TO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D280E606A31C;
	Thu, 12 Nov 2026 08:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YW4hO7TO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90A3D1F00A05;
	Thu, 12 Nov 2026 08:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794470933;
	bh=d9RLIovI7owKrDahKOFCTkrcbwtOL6ZwvZYguMj3eOo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YW4hO7TO59JZmKyQZvjsef7NUj5rp++imyIY08mxu0KvSIqNqVC2AOoo2ZZUt3Z1Y
	 Q7xQ+F4fmlDXXUulOcswV9HKUhr7mHkgNyllN4s1AEWU+s7hghAQnnA4ZPX5rPhYU6
	 LLXJEjpGrGYfkL0+M9816i8WQ6/WUh711ALgBQWNkZ1FBJzu6KfhIn9bEBepvBXQxX
	 /MVAQuMMj/nyiXw64xNrn0AHI+dt0PBktNuHHQakFkOfjdvRvTFqLqtI/c76nfb5uL
	 elRAEzsfmecSrts7jim4YVu+CzU6pb+IE1we2OIsKMMijfuascTBq8IRm93xgeyhc4
	 VIHbxUVlAD7gA==
Subject: Re: [PATCH net v5] vsock/bpf: release sock lock while waiting for
 data in recvmsg
From: netdev-bot+sashiko@kernel.org
To: jrmmhm.kernel@eldare.de
Cc: sgarzare@redhat.com, bobbyeshleman@meta.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 mst@redhat.com, ast@kernel.org, mhal@rbox.co, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 stable@vger.kernel.org
Date: Thu, 12 Nov 2026 08:08:52 +0000
Message-ID: <179447093204.2199510.8895677421994612994@kernel.org>
In-Reply-To: <20261109-kbh3-1-022-fix-v2-v5-1-4d9af04f0fad@eldare.de>
References: <20261109-kbh3-1-022-fix-v2-v5-1-4d9af04f0fad@eldare.de>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] vsock_msg_wait_data() now drops the socket lock around
  wait_woken().
- [Low] In vsock_bpf_recvmsg(), a reader asleep during a transport reset
  gets -ENOTCONN, or 0 if SOCK_DONE is set.
- [Low] vsock_msg_wait_data() (net/vmw_vsock/vsock_bpf.c:54-66) checks
  `if (!timeo)` before `signal_pending(current)`.

--

vsock/bpf: release sock lock while waiting for data in recvmsg

This patch drops the socket lock around wait_woken() in
vsock_msg_wait_data(), so the virtio rx worker no longer deadlocks
against a sockmap reader. The wait now loops until one of these
happens: data arrives, the timeout expires, a signal is pending, or
vsock_rx_done() reports a state in which __vsock_recvmsg() would not
wait. Those states, and zero-length, MSG_OOB and MSG_ERRQUEUE reads,
are handed to __vsock_recvmsg().

> diff --git a/net/vmw_vsock/vsock_bpf.c b/net/vmw_vsock/vsock_bpf.c
> index 9049d26486460..c0c9e69860dca 100644
> --- a/net/vmw_vsock/vsock_bpf.c
> +++ b/net/vmw_vsock/vsock_bpf.c
> @@ -34,24 +34,35 @@ static bool vsock_has_data(struct sock *sk, struct sk_psock *psock)
>  	return vsock_sk_has_data(sk, psock);
>  }
>  
> -static bool vsock_msg_wait_data(struct sock *sk, struct sk_psock *psock, long timeo)
> +/* __vsock_recvmsg() doesn't wait in these states and knows what to return. */
> +static bool vsock_rx_done(struct sock *sk)
>  {
> -	bool ret;
> -
> -	DEFINE_WAIT_FUNC(wait, woken_wake_function);
> +	return sk->sk_err || sk->sk_state != TCP_ESTABLISHED ||
> +	       (sk->sk_shutdown & RCV_SHUTDOWN) ||
> +	       (vsock_sk(sk)->peer_shutdown & SEND_SHUTDOWN);
> +}

[Severity: Low]
Does this comment hold for the sk_err case after a transport reset?

virtio_vsock_reset_sock() sets sk_state = TCP_CLOSE and
sk_err = ECONNRESET, then calls sk_error_report(). A reader asleep in
vsock_msg_wait_data() wakes up and finds no data. vsock_rx_done() is
true, so it leaves the loop with ret = 0. vsock_bpf_recvmsg() then
sees sk_psock_queue_empty() and calls __vsock_recvmsg().

__vsock_connectible_recvmsg() checks the state first:

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

So the sk_err conversion in __vsock_stream_recvmsg() is never reached:

	if (sk->sk_err)
		err = -sk->sk_err;

A native reader that is already waiting in
vsock_connectible_wait_data() has passed the state check. It returns
-ECONNRESET on SOCK_STREAM and 0 on SOCK_SEQPACKET.

The commit message already notes this ("a reader asleep at a virtio
transport reset gets -ENOTCONN, where a native socket gets -ECONNRESET
(0 on seqpacket)"). It is also better than the -EAGAIN this reader got
before the patch.

The wait loop stops on sk_err, but the code it hands off to can't
report that error. Could the wait path return the pending error the
way the native path does? If not, could the comment be reworded to
cover this case?

[ ... ]

> +	while (!vsock_has_data(sk, psock) && !vsock_rx_done(sk)) {
> +		if (!timeo) {
> +			ret = -EAGAIN;
> +			break;
> +		}
> +		if (signal_pending(current)) {
> +			ret = sock_intr_errno(timeo);
> +			break;
> +		}

[Severity: Low]
What happens when the timeout and a signal land in the same wakeup?

Say wait_woken() returns 0 because SO_RCVTIMEO ran out, and a signal
is pending at the same time. The next iteration hits the !timeo test
first and returns -EAGAIN. The signal check never runs.

The native vsock_connectible_wait_data() checks for a signal first
after sleeping:

	if (signal_pending(current)) {
		err = sock_intr_errno(timeout);
		break;
	} else if (timeout == 0) {
		err = -EAGAIN;
		break;
	}

That returns -EINTR for a finite timeout. The patch notes list this
case under "Not tested" ("returns -EAGAIN, native -EINTR").

Simply swapping the two checks at the top of the loop would make a
non-blocking read with a pending signal return -EINTR. Would checking
signal_pending() right after wait_woken() returns, as the native loop
does, make this match?

> +		release_sock(sk);
> +		timeo = wait_woken(&wait, TASK_INTERRUPTIBLE, timeo);
> +		lock_sock(sk);
>  	}

[Severity: Medium]
Now that the lock is dropped around wait_woken(), can vsk->transport
be NULL when the loop condition is checked again?

The WARN_ON_ONCE(!vsk->transport) check in vsock_bpf_recvmsg() runs
only once, at entry. After lock_sock(), the loop condition evaluates
vsock_has_data()->vsock_connectible_has_data() before
vsock_rx_done(), and that function has:

	if (WARN_ON(!vsk->transport))
		return 0;

While the reader is unlocked, vsock_connect()->vsock_assign_transport()
can release the old transport, deassign it, and then return early
without assigning a new one:

	vsk->transport->release(vsk);
	vsock_deassign_transport(vsk);
	...
	if (!new_transport->seqpacket_allow ||
	    !new_transport->seqpacket_allow(vsk, remote_cid)) {
		module_put(new_transport->module);
		return -ESOCKTNOSUPPORT;
	}
	...
	ret = new_transport->init(vsk, psk);
	if (ret) {
		module_put(new_transport->module);
		return ret;
	}

One possible sequence:

reader (sockmap socket)          connect thread
vsock_bpf_recvmsg()
  vsock_msg_wait_data()
    release_sock()
    wait_woken()
                                 transport reset: TCP_CLOSE, sk_err set
                                 earlier vsock_connect() retakes the
                                   lock, sees sk_err, sets
                                   SS_UNCONNECTED
                                 connect() again to a CID on another
                                   transport
                                   vsock_assign_transport()
                                     vsock_deassign_transport()
                                     seqpacket_allow() or init() fails
    lock_sock()
    vsock_has_data()
      vsock_connectible_has_data()
        WARN_ON(!vsk->transport)

The visible effect is a WARN splat, or a panic with panic_on_warn.
vsock_connectible_has_data() returns 0, vsock_rx_done() then returns
true, and __vsock_connectible_recvmsg() handles a NULL transport. The
native vsock_connectible_wait_data() checks in the same order.

Before this patch, the lock was held for the whole wait on the BPF
path, so this interleaving could not happen there. Would checking
vsock_rx_done() or !vsk->transport before vsock_has_data() in the loop
condition avoid the warning?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109-kbh3-1-022-fix-v2-v5-1-4d9af04f0fad%40eldare.de

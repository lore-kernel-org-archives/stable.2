Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794088836;
	b=i4aIVWn2X5DKFboRn7wWWEFGn7KU9dJo3e6WgfXoigdH/Hc12Wkk9d/2kTQSY13bCCvy
	 9uoMXt1itgbHL3nwCjiBjeuk3fmkYG9AjPZtuSUdhEUAmBAF9jvqy9eRSGdm9/Wgs9vTX
	 w+2oDcQXE8XYp7Gn8mFwl9xuoPoPyth6cGJEkiRvciGStNL55p0No9NLBEMOxRCIx1yx2
	 BypvcpUGVEfQfilmR9iagyOcaAPF/saQUYsMew0/E7aMfGfU3QMtBXysOZvnYre3f9MWn
	 cg31B3Krnhgew2Yew+Bwluwzf+jgEc65H+nrZSUrny4hs2r05PMrfyG/aCsmACo5uxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794088836;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=l/UcxheLWedm9uCd1/hIZVlErkN27XCN9A3GtmTuCz8=;
	b=dvtWCW5586SAmQ4Qv9p8uiDgV2uYSssvQRdl+kQSur5a3m2yP9TJiO0ZftaftH9bacvZ
	 i003VJSbd/XrlOuXKyiJo5v+QMF6t2Cal1LoMMYAfimK2HUEfLkeZgtyLCyVlCEGHacwT
	 7UbfpOS+5aDAhOYwCtkJLVzwS5ChNCO4t2/sE9ngIzzR8Nlp698B58346tycnxuVKtPHE
	 icog8Wo/OrJgf8DRx+e6MsSVGK4FJzcul0oAMMULgoMq7dD5m9UIsJb+W6eionN8n7jLP
	 aE1Nc3zmSYhWW/4V4X7rTiRsjf0ytfA4Lm486RBmEzAaznnmFWajfES5kL9hJhwsg9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ohxs6pPo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6B0606D807;
	Sat,  7 Nov 2026 22:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ohxs6pPo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3FA31F008A1;
	Sat,  7 Nov 2026 22:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794088835;
	bh=l/UcxheLWedm9uCd1/hIZVlErkN27XCN9A3GtmTuCz8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Ohxs6pPoQabe+V30RpcnbQUE9dxFmA5IJrZt7UYlxNVzif9aGop2IyVMULBO7GRxS
	 hNPdJBXfE0W7y8AO8fbeUIO3Rj0ozVNowiB8qSrgmFvGMfP41uRbxkNP8h3hrA266b
	 TJxjh7gPaz6f0tpSyk7mM6ShSjI97lpesKyQcM5rff+Ycq/ILMY3ARdLd+AgzG5eoY
	 fbA/On3qwIA38oOgF+AXg1XJfWgqO1LSnuQvAq92P3+3CJJDcGNtZsfidjBVxbRRGs
	 pQ8M2Pp2C54J5BUo4E8swNUN8o5eW8T4QPHpi3CuK3IWCWmRs1tR4mLd1mgotTbObk
	 LDka8L84ze88Q==
Subject: Re: [PATCH net v4 2/2] vsock/bpf: fix zero-length, MSG_OOB and
 MSG_ERRQUEUE reads in recvmsg
From: netdev-bot+sashiko@kernel.org
To: jrmmhm.kernel@eldare.de
Cc: sgarzare@redhat.com, bobbyeshleman@meta.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 mst@redhat.com, mhal@rbox.co, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 stable@vger.kernel.org
Date: Sat, 07 Nov 2026 22:00:34 +0000
Message-ID: <179408883423.994134.6215595609708026856@kernel.org>
In-Reply-To: <20261106-kbh3-1-022-fix-v2-v4-2-c7d36703814d@eldare.de>
References: <20261106-kbh3-1-022-fix-v2-v4-2-c7d36703814d@eldare.de>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new early returns in vsock_bpf_recvmsg()
  (net/vmw_vsock/vsock_bpf.c:125-129) skip the transport and sk_state…
- [Low] The new `if (!len) return 0;` in vsock_bpf_recvmsg()
  (net/vmw_vsock/vsock_bpf.c:128-129) returns before the native stream…

--

vsock/bpf: fix zero-length, MSG_OOB and MSG_ERRQUEUE reads in recvmsg

This commit adds checks at the top of vsock_bpf_recvmsg() for three cases.
MSG_ERRQUEUE goes to the native path, MSG_OOB returns -EOPNOTSUPP, and
zero-length reads return 0. Before this, these reads went through
sk_msg_recvmsg() and the sockmap wait, which could spin with the socket
lock held or consume stream bytes.

> diff --git a/net/vmw_vsock/vsock_bpf.c b/net/vmw_vsock/vsock_bpf.c
> index 6d96ff03f28c4..58b32fbc1f4b2 100644
> --- a/net/vmw_vsock/vsock_bpf.c
> +++ b/net/vmw_vsock/vsock_bpf.c
> @@ -119,6 +119,15 @@ static int vsock_bpf_recvmsg(struct sock *sk, struct msghdr *msg,
>  	struct vsock_sock *vsk;
>  	int copied;
>  
> +	if (unlikely(flags & MSG_ERRQUEUE))
> +		return __vsock_recvmsg(sk, msg, len, flags);
> +
> +	if (flags & MSG_OOB)
> +		return -EOPNOTSUPP;
> +
> +	if (!len)
> +		return 0;

[Severity: Medium]
Do these two early returns give the right result on a sockmap'd socket that
is no longer established?

The native __vsock_connectible_recvmsg() checks the transport and socket
state before it looks at MSG_OOB or len:

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

	if (flags & MSG_OOB) {
		err = -EOPNOTSUPP;
		goto out;
	}
    ...
	if (!len) {
		err = 0;
		goto out;
	}
    ...
}

sock_map_sk_state_allowed() requires TCP_ESTABLISHED only when a vsock
STREAM or SEQPACKET socket is inserted. After that, the state can change
while the socket stays in the map. One example is a transport reset:

virtio_vsock_event_handle()
  vsock_for_each_connected_socket()
    virtio_vsock_reset_sock()
      sk->sk_state = TCP_CLOSE;
      sk->sk_err = ECONNRESET;

Another is a peer close through virtio_transport_do_close(), which sets
SOCK_DONE and moves the socket to TCP_CLOSING.

With this patch, the BPF path then returns:

- recv(fd, buf, n, MSG_OOB) after a transport reset: -EOPNOTSUPP, where
  the native path returns -ENOTCONN.
- recv(fd, NULL, 0, 0) after a transport reset: 0, where the native path
  returns -ENOTCONN.
- recv(fd, buf, n, MSG_OOB) after a peer close: -EOPNOTSUPP, where the
  native path returns 0.

The zero-length case also looks like a regression from the behaviour
before this patch. With empty queues, the old code reached
vsock_msg_wait_data(), which returned -ECONNRESET from sk_err. If SO_ERROR
had already cleared sk_err, it returned -ENOTCONN from the state check:

	/* virtio_vsock_reset_sock() sets no shutdown bits, and
	 * SO_ERROR clears sk_err: check the state the way
	 * __vsock_connectible_recvmsg() does.
	 */
	if (sk->sk_state != TCP_ESTABLISHED) {
		ret = sock_flag(sk, SOCK_DONE) ? 0 : -ENOTCONN;

The new early return now reports a successful 0 instead of that error.

unix_bpf can use these returns because its native path has no state check
before them. The vsock native path does have one, and
__vsock_connectible_recvmsg() already handles MSG_OOB and !len in the
right order without touching the psock queues.

Would it work to send both cases to __vsock_recvmsg(), the way MSG_ERRQUEUE
is already handled here?

[Severity: Low]
Does the !len early return also drop the SCM_INQ cmsg and msg_inq hint for
zero-length stream reads?

In the native path, the !len case jumps to out:, which still reports the
hint for SOCK_STREAM:

net/vmw_vsock/af_vsock.c:__vsock_connectible_recvmsg() {
    ...
out:
	if ((vsk->recvmsg_inq || msg->msg_get_inq) && err >= 0 &&
	    sk->sk_type == SOCK_STREAM) {
		msg->msg_inq = vsock_stream_inq_hint(sk);
		...
		do_cmsg = vsk->recvmsg_inq && msg->msg_inq >= 0;
	}
    ...
}

Before this patch, take a zero-length read with SO_INQ set, an empty psock
queue and data in the transport. It matched vsock_has_data() &&
sk_psock_queue_empty() and went to __vsock_recvmsg(), so it got SCM_INQ
and msg_inq. Now it returns 0 with neither.

io_uring sets msg_inq to -1 before most of its recv calls, so there the
hint is missing rather than wrong. Sending !len to __vsock_recvmsg(), as
suggested above, would fix this too.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106-kbh3-1-022-fix-v2-v4-0-c7d36703814d%40eldare.de

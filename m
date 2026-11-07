Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794088834;
	b=H8CtcSQYgirDW34bbmbsiP6ePUU1gK6LwyUGOV0lPedHsHggU3/7r4l1bNU6y6aeUjxZ
	 UfX7HQGJ+DBSYNU7sVx5zI88WyKh5kkYTW7pgJ1thfBvXkDtgQwt4PUVdvjaBlLr8JRtU
	 IzmsXjxczGK2g7uRbsr+PDgpo6d96RudG7WZfrUgnHhGzNcaNJwaCwwW8D3mE0btfQeUZ
	 1p3xzbD8AnuaiSXjjaEELiWsMr8teWv0a977N8NwnRYaTzCKGukm0W3a446yUuo9SGYxB
	 8mvuTvnbZSwB+yKOzH702Qbu2x5cvb66evyfxDDn0okwOPK+ZPAXP+Y8TOm7O6WC43w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794088834;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=VNZGPeMP1H9NcfpnWuuufaSVsJdMZpOEEwuaOwBXqj4=;
	b=aN/XUuySm6Wz/iCXAQxnlJbONmZb1J7fYsw2mtQCTMIIqSbswElKZmXz9H0hjQ7pUqRe
	 RgEMOOSBm/7Mr6aU9zFEE7vnX8kLWoBE+oVPxAfBwRJNcVJ0PE6z2ipmUnhD7H3x8zzO8
	 NKvNos/XNGKz3O+7HsbtfVCy7W4pzBPeDtZnvGt99smz2/73bcH9N13xRff7wmu1Zd9PD
	 o3vRNHGmbegB6ScEIKKSEca79Z89EKxTSDt2gxVMFP0IYiO8zKDEodVYQzLjV7xPGjiOm
	 XG9nAP7rEJvhb2W1In68OGBP4VdMxNvOxIB7ikhG9Gkj0MZN9jmT1NVemnZbAtgwsTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oGHLEmqq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8610D606A32C;
	Sat,  7 Nov 2026 22:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oGHLEmqq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F0BA1F0089F;
	Sat,  7 Nov 2026 22:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794088834;
	bh=VNZGPeMP1H9NcfpnWuuufaSVsJdMZpOEEwuaOwBXqj4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=oGHLEmqqvLjB/zQImYzHgqmIyidOSEwO86DvsCkcCp89QbT8EeaxtBOACUiP93jRX
	 c3imQlcSm5oF0xRt1O1Omwe8e5xKJ3o2FnHB8lylBs+Sl7BJFh7oA+VklXWtsM89F7
	 Y3QfGjLijluCfjfP2E9TR796nYx/A18o2oNZqR55r7k8tZ2uS4dup1drDSapiBGi9R
	 B5MRiHq31BPnaAqAEF4TAQxsrxX/3DQPyLXlCMPR9wveL+CFdZ+lc6y1eSqXazF2JY
	 pHe9FY0TDUAgag/2MCOUjPesmSbhonY6uK1KsgnuFeaH80ZTJQ6QyYzYFyeGjwGAzc
	 e/l9O76Ki8Ftg==
Subject: Re: [PATCH net v4 1/2] vsock/bpf: release sock lock while waiting for
 data in recvmsg
From: netdev-bot+sashiko@kernel.org
To: jrmmhm.kernel@eldare.de
Cc: sgarzare@redhat.com, bobbyeshleman@meta.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 mst@redhat.com, mhal@rbox.co, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 stable@vger.kernel.org
Date: Sat, 07 Nov 2026 22:00:32 +0000
Message-ID: <179408883290.994134.2349835219799185998@kernel.org>
In-Reply-To: <20261106-kbh3-1-022-fix-v2-v4-1-c7d36703814d@eldare.de>
References: <20261106-kbh3-1-022-fix-v2-v4-1-c7d36703814d@eldare.de>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message says that with the series applied the
  reproduced cases 'behave as on a native socket, except for the reset…

--

vsock/bpf: release sock lock while waiting for data in recvmsg

This patch fixes a deadlock in vsock_bpf_recvmsg(). The function held
lock_sock() while it slept in wait_woken(), and the transport needs that
lock to deliver data. The lock is now released around wait_woken(), and
the wait loops until data arrives or one of the native exit conditions
applies (socket error, shutdown, not connected, timeout or signal).

> diff --git a/net/vmw_vsock/vsock_bpf.c b/net/vmw_vsock/vsock_bpf.c
> index 9049d26486460..6d96ff03f28c4 100644
> --- a/net/vmw_vsock/vsock_bpf.c
> +++ b/net/vmw_vsock/vsock_bpf.c

[ ... ]

> +	while (1) {
> +		if (vsock_has_data(sk, psock)) {
> +			ret = 1;
> +			break;
> +		}
> +
> +		/* Stop on a socket error, as vsock_connectible_wait_data()
> +		 * does, so that recv() returns it; the checks below would
> +		 * end the wait with 0 or -ENOTCONN instead.
> +		 */
> +		if (sk->sk_err) {
> +			ret = -sk->sk_err;
> +			break;
> +		}

[Severity: Medium]
Does this match the native path for SOCK_SEQPACKET as well as
SOCK_STREAM?

vsock_connectible_wait_data() stops on sk_err, but it returns 0 rather
than the error:

net/vmw_vsock/af_vsock.c:vsock_connectible_wait_data() {
    ...
		if (sk->sk_err != 0 ||
		    (sk->sk_shutdown & RCV_SHUTDOWN) ||
		    (vsk->peer_shutdown & SEND_SHUTDOWN)) {
			break;
		}
    ...
}

Only __vsock_stream_recvmsg() converts that into -sk->sk_err afterwards.
__vsock_seqpacket_recvmsg() returns the 0 directly:

	err = vsock_connectible_wait_data(sk, &wait, timeout, NULL, 0);
	if (err <= 0)
		goto out;

With this patch, vsock_bpf_recvmsg() passes the return value through
unchanged (copied = data). sock_map accepts vsock SOCK_SEQPACKET sockets.

Take a SEQPACKET socket in a sockmap with a reader blocked in recv(). If
virtio_vsock_reset_sock() runs and sets sk_err = ECONNRESET, the reader
gets -ECONNRESET here, while a native socket returns 0. The same applies
to other sk_err values, such as EPIPE from sk_psock_report_error().

The check order also differs from __vsock_connectible_recvmsg(). That
function checks the state and transport first, then returns 0 on a local
RCV_SHUTDOWN before it waits:

	if (sk->sk_shutdown & RCV_SHUTDOWN) {
		err = 0;
		goto out;
	}

This loop checks sk_err before RCV_SHUTDOWN. So a socket that is still
TCP_ESTABLISHED, has done a local SHUT_RD and has a pending sk_err would
return -sk_err from the BPF path but 0 natively.

The commit message says:

    With the series applied they behave as on
    a native socket, except for the reset case above

and the code comment claims parity with vsock_connectible_wait_data().
Neither holds for SEQPACKET, or for the SHUT_RD plus sk_err case.

Returning the error may be the better behaviour. If so, could the commit
message and comment say so? The alternative is to follow the native
semantics for each socket type. The later patch in the series ("vsock/bpf:
fix zero-length, MSG_OOB and MSG_ERRQUEUE reads in recvmsg") does not
change vsock_msg_wait_data(), so the difference is still there at the end
of the series.

> +
> +		if ((sk->sk_shutdown & RCV_SHUTDOWN) ||
> +		    (vsk->peer_shutdown & SEND_SHUTDOWN)) {
> +			ret = 0;
> +			break;
> +		}

[ ... ]

> @@ -101,9 +140,10 @@ static int vsock_bpf_recvmsg(struct sock *sk, struct msghdr *msg,
>  	copied = sk_msg_recvmsg(sk, psock, msg, len, flags);
>  	while (copied == 0) {
>  		long timeo = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
> +		int data = vsock_msg_wait_data(sk, psock, timeo);
>  
> -		if (!vsock_msg_wait_data(sk, psock, timeo)) {
> -			copied = -EAGAIN;
> +		if (data <= 0) {
> +			copied = data;
>  			break;
>  		}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106-kbh3-1-022-fix-v2-v4-0-c7d36703814d%40eldare.de

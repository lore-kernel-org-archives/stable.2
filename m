Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3858044E650;
	Mon, 28 Sep 2026 09:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790589229; cv=none; b=RtW/i5vPuEz4auoK6N3X2/OhxCyuFLeVQ5ITyY+1mHpjeJB+vFc0WxrjB1bleiEw+WOR3b6VSa09XokcK1kirXIHrbJsAobhkiy+oke/Oi4cuwoXB2Z1KE3GTr7DReByN9xYhtIn37SNxQAC7+GqiCKSPuuBesyASZSRI6ftNPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790589229; c=relaxed/simple;
	bh=+xb9xcIMrr5OJsLec1M/O2inJ9NcaKtqScgVIVaKxu4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NG+GlFHmIOrLUIVZOE2ian2wNBXz63vrXpGvQOLcV0vhA1Qv5Qra1eU5Jdn0abDEqlyUoKq4IrGGymsw2GPl5V/LSNmzruVCA0bnDZKWa1i7h9cueQGJmPN6U2RbzAynHcqUhUa8SdNICA2HQkE5/jPjROJAtBfWDb5jLXIUJIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jtll7qva; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jtll7qva"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 171431F000FF;
	Mon, 28 Sep 2026 09:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790589227;
	bh=LuWhIMowI39Sw9VUbrs0SpvHgk8NlyRSj5QWrKqGrhU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jtll7qva6lDmxuAdmKyWYcxH5sgpT19wKG3TPR+3+T/d5Ii+5OSa0evt+ytfX8hZT
	 dnTSCpofI/iyDf0ySV19BKCw22OyfFp4UrT2vo+yiYnFCm1sq4NYheW0nY4CbJi0Wb
	 7fPpcnInvGIuddgQ0E8i+1HjOPjMb0a2n3LvZXMM/wxuRMuVhRtZBJNf8ax45GRAGl
	 RbidUH0I67F7uTfL8LxNF4aObEYD6AqZiSX8I2NOkUxmC8IJCJ/22aNp0Su0TYOUiF
	 gB9CLBLnO5Ys3Om4m7VkUI0oWy8xtTxJ85fANwY9rymxXbwW3yLBRHK4E9LH1GoKNU
	 /cjVVlahkVZ/w==
Subject: Re: [PATCH net v2] nfc: llcp: prevent resource leak on repeated
 connect after DM
From: netdev-bot+sashiko@kernel.org
To: qwe.aldo@gmail.com
Cc: david@ixit.cz, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, oe-linux-nfc@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 sashiko-bot@kernel.org
Date: Mon, 28 Sep 2026 09:53:46 +0000
Message-ID: <179058922656.3145.17540746696102333949@kernel.org>
In-Reply-To: <20260925184857.357926-1-qwe.aldo@gmail.com>
References: <20260925184857.357926-1-qwe.aldo@gmail.com>
X-sashiko-severity: Critical
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

Critical: 2 · High: 2 (1) · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] The new LLCP_CLOSED cleanup in llcp_sock_connect()
  (net/nfc/llcp_sock.c:725-726, `if (llcp_sock->dev)…
- [Critical] The new cleanup can release resources that a sleeping
  blocking connect() still owns.
- [High] Two paths close a socket but leave it hashed on local->sockets:
  nfc_llcp_recv_disc() (llcp_core.c:1221-1224), and the default branch…
- [High] The leak this patch targets is still reachable through bind().

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the retry
  scenario the patch targets can crash the kernel.

--

nfc: llcp: prevent resource leak on repeated connect after DM

Before llcp_sock_connect() takes new resources, this patch releases the
local reference, reserved SAP, service name and device reference still
held by an LLCP socket in LLCP_CLOSED. It targets a nonblocking connect
that a DM PDU rejects and that is then retried.

Link: https://lore.kernel.org/all/20260923133339.2518641-1-qwe.aldo@gmail.com/

> diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
> index 1e5ee4bcde684..9d76c12aee011 100644
> --- a/net/nfc/llcp_sock.c
> +++ b/net/nfc/llcp_sock.c
> @@ -715,6 +715,23 @@ static int llcp_sock_connect(struct socket *sock, struct sockaddr_unsized *_addr
>  		goto error;
>  	}
>  
> +	if (sk->sk_state == LLCP_CLOSED) {
> +		/* Release resources retained by a previous failed connection. */
> +		if (llcp_sock->local) {
> +			if (llcp_sock->reserved_ssap < LLCP_SAP_MAX)
> +				nfc_llcp_put_ssap(llcp_sock->local, llcp_sock->ssap);
> +			nfc_llcp_local_put(llcp_sock->local);
> +		}

[Severity: Critical]
Can this release resources that a blocking connect() on the same socket
still owns?

While sock_wait_state() sleeps it drops the socket lock. The first caller
keeps local and dev in its own stack frame:

Thread A (blocking connect)
llcp_sock_connect()
  sock_wait_state()
    release_sock(sk);
    timeo = schedule_timeout(timeo);

rx worker
nfc_llcp_recv_dm()
  sk->sk_err = ENXIO;
  sk->sk_state = LLCP_CLOSED;
  sk->sk_state_change(sk);

Thread B (same fd, wins lock_sock first)
llcp_sock_connect()
  sk_state == LLCP_CLOSED, so:
    nfc_llcp_put_ssap(llcp_sock->local, llcp_sock->ssap);
    nfc_llcp_local_put(llcp_sock->local);
    nfc_put_device(llcp_sock->dev);
  nfc_get_device(addr->dev_idx) fails with -ENODEV

Thread A
  lock_sock(sk);
  err = sock_error(sk);   /* still -ENXIO */
  goto sock_unlink
    nfc_llcp_put_ssap(local, llcp_sock->ssap);
    nfc_llcp_local_put(local);
    nfc_put_device(dev);

Thread B clears ->local, ->dev and ->reserved_ssap but not ->ssap. Thread
A then frees the same SAP again, which may already belong to another
socket. It also drops the local and dev references a second time.

Could the nfc_llcp_local and nfc_dev refcounts underflow here? That would
free local while it is still on llcp_devices, and free the nfc_dev while
it is still registered.

Without this patch, thread B's failed connect() left the socket unchanged,
so each resource was released only once.

> +		if (llcp_sock->dev)
> +			nfc_put_device(llcp_sock->dev);

[Severity: Critical]
Does a CLOSED socket with a non-NULL llcp_sock->dev always own an nfc_dev
reference? That seems true only after a nonblocking connect that a
DM(REJ/NOBOUND) rejected.

Several existing paths leave the socket in LLCP_CLOSED with llcp_sock->dev
still set, but with the reference already dropped or never taken.

nfc_llcp_recv_disc() already drops the reference for a connected socket:

	if (sk->sk_state == LLCP_CONNECTED) {
		nfc_put_device(local->dev);
		sk->sk_state = LLCP_CLOSED;

nfc_llcp_socket_release() runs from
nfc_dep_link_down()->nfc_llcp_mac_is_down(), and from local_cleanup() on
unregister. It drops dev for CONNECTED sockets. It then moves every
socket, BOUND and LISTEN ones included, to LLCP_CLOSED without clearing
->dev.

llcp_sock_bind() keeps ->dev as a pointer without holding a reference:

	sk->sk_state = LLCP_BOUND;
	nfc_put_device(dev);

Child sockets accepted in nfc_llcp_recv_connect() also take a reference.
DISC or link down later drops it.

connect() only rejects LLCP_CONNECTED and LLCP_CONNECTING, and this
cleanup runs before the dev_idx lookup. So bind(), then a dep link down,
then connect() (even with a bogus dev_idx) would call nfc_put_device() on
a reference the socket does not own.

Doing this on several sockets looks like it can underflow the nfc_dev
refcount and free the device while it is still registered.

The commit message says:

  "Bound sockets do not hold the device reference, so release it only
  when reconnecting from LLCP_CLOSED."

Bound sockets do reach LLCP_CLOSED on link down, though.
llcp_sock_destruct() also assumes the reference is owned only in
LLCP_CONNECTED:

	if (sk->sk_state == LLCP_CONNECTED)
		nfc_put_device(llcp_sock->dev);

Would it be safer to drop the reference and clear llcp_sock->dev in
nfc_llcp_recv_dm(), at the CONNECTING to CLOSED transition, instead of
guessing ownership from the state here?

> +		kfree(llcp_sock->service_name);
> +		llcp_sock->local = NULL;

[Severity: High]
Is the socket always off local->sockets at this point?

nfc_llcp_recv_disc() moves a connected socket to LLCP_CLOSED but leaves it
on local->sockets. The default branch of nfc_llcp_recv_dm() (any reason
other than NOBOUND/REJ) also closes the socket without unlinking it.

For such a socket, this block frees the SAP, drops the local reference and
sets llcp_sock->local = NULL. The rx worker can still find the socket
through nfc_llcp_sock_get(), and the SAP can be given to another socket.

If connect() then fails early (bad dev_idx, nfc_llcp_find_local()
failure, dep link down, or target_idx mismatch), llcp_sock_release()
returns before it unlinks anything:

	local = llcp_sock->local;
	if (local == NULL) {
		err = -ENODEV;
		goto out;
	}

Wouldn't the orphaned socket stay on local->sockets until a link down or
unregister? Before this patch, ->local was still set on those early error
paths, so close() unlinked the socket.

If connect() goes ahead instead, it reaches:

	nfc_llcp_sock_link(&local->connecting_sockets, sk);

At that point sk_node is still linked in local->sockets. Two different
rwlocks protect the two lists, and both hlists look like they would be
corrupted.

That double link existed before this patch. Since this change prepares
CLOSED sockets for reuse, should it also unlink the socket here?

> +		llcp_sock->dev = NULL;
> +		llcp_sock->service_name = NULL;
> +		llcp_sock->service_name_len = 0;
> +		llcp_sock->reserved_ssap = LLCP_SAP_MAX;
> +	}
> +

[Severity: High]
Can the same leak still happen through bind()?

After a DM(REJ/NOBOUND) rejects a nonblocking connect(), the socket is in
LLCP_CLOSED. It still holds a local reference, a reserved local SAP, the
kmemdup'd service_name and a dev reference.

llcp_sock_bind() accepts that state:

	if (sk->sk_state != LLCP_CLOSED) {
		ret = -EBADFD;
		goto error;
	}

It then overwrites llcp_sock->dev, ->local, ->service_name, ->ssap and
->reserved_ssap without releasing the old values. close() later releases
only what bind() took.

If connect(O_NONBLOCK) -> DM -> bind() -> close() is repeated about 32
times, wouldn't the local SAPs still run out, so that
nfc_llcp_get_local_ssap() fails for every client connect on the device?

Could this cleanup become a helper that llcp_sock_bind() also calls?

llcp_raw_sock_bind() has the same pattern of accepting CLOSED and
overwriting the fields. Raw sockets cannot reach this DM state, though,
because they use sock_no_connect.

[Severity: High]
This is a pre-existing issue, not one introduced by this patch. Still, the
retry path this patch is meant to support can oops the kernel.

nfc_llcp_recv_dm() sets sk->sk_err = ENXIO. Neither connect() nor this
new cleanup clears it. On a blocking retry, sock_wait_state() checks for a
pending error before it checks the state again:

	err = sock_error(sk);
	if (err)
		break;

Suppose the wakeup came from nfc_llcp_recv_cc(). The socket has already
moved to local->sockets and is set to LLCP_CONNECTED, but connect() sees
the stale -ENXIO and takes the sock_unlink path.

That path unlinks the socket from local->sockets while holding the
connecting_sockets lock. It frees the SAP, sets ->local and ->dev to NULL
and drops their references. It leaves sk_state at LLCP_CONNECTED.

On close(), llcp_sock_release() sees local == NULL and jumps to out. Then
llcp_sock_destruct() runs:

	if (sk->sk_state == LLCP_CONNECTED)
		nfc_put_device(llcp_sock->dev);

At this point llcp_sock->dev is NULL. Doesn't that make put_device()
dereference a near-NULL address?

Should the stale sk_err be cleared when reconnecting from LLCP_CLOSED?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260925184857.357926-1-qwe.aldo%40gmail.com

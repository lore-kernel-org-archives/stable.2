Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BBE457E4B;
	Sat, 10 Oct 2026 10:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791626475; cv=none; b=T8pjEAnZivMMYrPY0B2qv49kgex3pHE7mj1OMpcEzzFBIY3p1txTtUugViEzoDY7RrWWYcjvw2+pUOCvr3YJrU0EznrZYXg69xoX5REgIav9gpJQ3dzhkz7h2kQvUrNpdkgYngCzx3BFdGI9uUDA+CbLbsbxplIkY0quPh49DXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791626475; c=relaxed/simple;
	bh=8MwjnvP0TVjnnHUZlWiNSC+MXUJZHZMzE1oLJB5LN2Q=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=upRAFRXjtitkU31tGGd8F8XvplqIhGcWrmca1qypVwJESrjBbcdTULVhHtDMMqqwJqWUN2/KJStFbk6V92lWT/p/yQt4tZESyFv+tfTF8kExnnJR6Ix7wQPdUHB8TtIFjF/6l1lJZnxAxfoTV9TUjR8jQ0IPSHsT4o2U1FuKenE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TVc33rrE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TVc33rrE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27EA71F000FF;
	Sat, 10 Oct 2026 10:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791626473;
	bh=Oet3vwiIyCskbJM+gNxrIIuTXViaOe1c9rWFx0S/x5E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=TVc33rrEm/REdJfESmJL5W94DDahQ5TZ16ho7mc4P1JZDw6/0elR/stuBKgdy0bNc
	 bjx1/zFPKFaWQHH7uocerWpuqApVU0zDtbrkErMd3uStDCYZDa00Bex3j3ur6RuXTs
	 V0NvubwCRt5d/cldHjk94OdKPruREVb3XM4tww58QR6AR9UBZy+yH92O9nQu6mGTwz
	 G574/NLHzsGSJuc9rP7X1e5N5joRNhzGbZuHiCnwEAoxODSK4fg+ZQk67ekKChCVtd
	 X+pRy1kDfrSf4W2KecJCtCxcwFfHqtTyzoWztKFxBqnY68zisLsfnkRpaiANfIKeeO
	 roml5MA+xESog==
Subject: Re: [PATCH] nfc: llcp: fix socket list self-loop and soft lockup on
 bound connect
From: netdev-bot+sashiko@kernel.org
To: bsdhenrymartin@gmail.com
Cc: david@ixit.cz, sameo@linux.intel.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Sat, 10 Oct 2026 10:01:12 +0000
Message-ID: <179162647268.434549.12888490245916744855@kernel.org>
In-Reply-To: <20261009092338.3146149-1-bsdhenrymartin@gmail.com>
References: <20261009092338.3146149-1-bsdhenrymartin@gmail.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 (1) · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete.
- [Low] The commit message says a bound socket "must be closed or unbound
  before connecting to another service".

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it is a
  locking violation that a remote peer can trigger.

--

nfc: llcp: fix socket list self-loop and soft lockup on bound connect

This commit makes llcp_sock_connect() reject sockets in the LLCP_BOUND
state with -EISCONN. Without the check, a bound socket's sk_node gets
linked into both local->sockets and local->connecting_sockets. When the
CC handler then re-adds the node to local->sockets, it turns into a
self-loop.

> diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
> index 1e5ee4bcde684..b1b5b6d319466 100644
> --- a/net/nfc/llcp_sock.c
> +++ b/net/nfc/llcp_sock.c
> @@ -714,6 +714,15 @@ static int llcp_sock_connect(struct socket *sock, struct sockaddr_unsized *_addr
>  		ret = -EINPROGRESS;
>  		goto error;
>  	}
> +	/* A bound socket is already linked into local->sockets; letting
> +	 * it connect() would link the same sk->sk_node into
> +	 * local->connecting_sockets too, and the CC handler's re-add turns
> +	 * it into a self-loop.  Reject like CONNECTED/CONNECTING.
> +	 */
> +	if (sk->sk_state == LLCP_BOUND) {

[Severity: High]
Is checking only LLCP_BOUND enough here? The comment above says the real
problem is that sk->sk_node is already linked into local->sockets. That
is also true in some other states.

llcp_sock_listen() moves a bound socket to LLCP_LISTEN without unlinking
it:

net/nfc/llcp_sock.c:llcp_sock_listen() {
    ...
	if ((sock->type != SOCK_SEQPACKET && sock->type != SOCK_STREAM) ||
	    sk->sk_state != LLCP_BOUND) {
    ...
	sk->sk_state = LLCP_LISTEN;
    ...
}

The sequence socket(AF_NFC, SOCK_STREAM, NFC_SOCKPROTO_LLCP), bind(),
listen(), connect() still gets past all three state checks in
llcp_sock_connect(). It then reaches this call while the node is still
hashed on local->sockets:

	nfc_llcp_sock_link(&local->connecting_sockets, sk);

When CC arrives, nfc_llcp_recv_cc() does:

	nfc_llcp_sock_unlink(&local->connecting_sockets, sk);
	nfc_llcp_sock_link(&local->sockets, sk);

Wouldn't that create the same self-loop, and the same soft lockup in
nfc_llcp_sock_get() and the other sk_for_each() walks of local->sockets?
Only SOCK_RAW requires CAP_NET_RAW, so an unprivileged user seems able to
reach this once a DEP link is up.

LLCP_CLOSED looks like it has the same problem. Connected sockets go onto
local->sockets through nfc_llcp_recv_cc(), or through
nfc_llcp_recv_connect() for accepted children. Later, nfc_llcp_recv_disc()
and nfc_llcp_recv_dm() (for reasons other than NOBOUND/REJ) set the state
to closed without unlinking:

net/nfc/llcp_core.c:nfc_llcp_recv_disc() {
    ...
	if (sk->sk_state == LLCP_CONNECTED) {
		nfc_put_device(local->dev);
		sk->sk_state = LLCP_CLOSED;
		sk->sk_state_change(sk);
	}
    ...
}

The remote peer decides when this happens. A later connect() on the same
fd would pass the new check and link the node a second time.

llcp_sock_bind() has the same gap. It only checks sk->sk_state !=
LLCP_CLOSED before it calls nfc_llcp_sock_link(&local->sockets, sk), and
the node may still be hashed at that point.

On both of these paths, connect() also overwrites llcp_sock->local,
llcp_sock->ssap, llcp_sock->reserved_ssap and llcp_sock->service_name.
Does that leak the earlier nfc_llcp_local reference, the earlier SAP
reservation and the earlier service_name buffer?

If connect() then fails, the sock_unlink label removes the node only from
local->connecting_sockets. Wouldn't local->sockets still point at it?

Would it be more robust to check list membership instead of adding one
more state? For example, connect() could fail unless sk->sk_state ==
LLCP_CLOSED && !sk_hashed(sk) && !llcp_sock->local. Another option is to
have the transitions to LLCP_CLOSED unlink the socket.

> +		ret = -EISCONN;

[Severity: Low]
The commit message says:

  (a bound socket must be closed or unbound before connecting to
  another service)

Is there a way to unbind an LLCP socket? llcp_sock_bind() requires
LLCP_CLOSED. llcp_sock_connect() requires sa_family == AF_NFC, so there
is no AF_UNSPEC disconnect. No user operation moves a socket from
LLCP_BOUND back to LLCP_CLOSED, so closing it seems to be the only
option.

Also, -EISCONN means "Transport endpoint is already connected", but this
socket is only bound. Elsewhere in this file, wrong-state checks such as
those in llcp_sock_bind() and llcp_sock_listen() return -EBADFD.

Could a non-blocking connect loop that treats EISCONN as success mistake
a bound-only socket for a connected one? Would -EBADFD be more
consistent here?

> +		goto error;
> +	}
>  
>  	dev = nfc_get_device(addr->dev_idx);
>  	if (dev == NULL) {

[Severity: High]
This is a pre-existing issue and was not introduced by this patch. The
sock_unlink error path further down in llcp_sock_connect() seems to
assume sk is still on local->connecting_sockets:

sock_unlink:
	nfc_llcp_sock_unlink(&local->connecting_sockets, sk);

sock_wait_state() drops the socket lock while it sleeps:

		release_sock(sk);
		timeo = schedule_timeout(timeo);
		lock_sock(sk);
		set_current_state(TASK_INTERRUPTIBLE);

		err = sock_error(sk);

That gives the rx work a window to move sk between lists. Suppose a peer
sends an AGF frame containing a CC followed by a DM whose reason is not
NOBOUND or REJ. nfc_llcp_recv_agf() handles the two PDUs back to back:

nfc_llcp_recv_cc()
    nfc_llcp_sock_unlink(&local->connecting_sockets, sk);
    nfc_llcp_sock_link(&local->sockets, sk);
    sk->sk_state = LLCP_CONNECTED;

nfc_llcp_recv_dm()
    llcp_sock = nfc_llcp_sock_get(local, dsap, ssap);
    ...
    sk->sk_err = ENXIO;
    sk->sk_state = LLCP_CLOSED;

When the waiter gets the lock back, sock_error() returns -ENXIO and it
jumps to sock_unlink. sock_unlink then calls sk_del_node_init() on a node
that is now on local->sockets, while holding only connecting_sockets.lock.
A DISC combined with a pending signal reaches the same label.

Can this race with code that changes local->sockets under
local->sockets.lock? Examples are bind() or release() on other sockets,
nfc_llcp_accept_dequeue(), and nfc_llcp_recv_connect() handling a later
CONNECT PDU in the same AGF.

If so, a socket could be dropped from the list, or a socket that is about
to be freed could stay linked, which would be a use-after-free.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009092338.3146149-1-bsdhenrymartin%40gmail.com

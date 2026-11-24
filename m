Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795508801;
	b=wnAf/5Mwm32hNJh7xtAwFHAmsUHMYNex7iKf3KtX/luc8jSHTVr8+hOriGA83Gf14p3c
	 wq+LpQrUxzaqfu9vuoNON58o5mEPn4kq35hQUL0ULJXPrvd222Vv4bUnp99AN42cwXoYr
	 Z+xYN63gmoABLwbHNxwryfRBm1DiZLfJ9hbw6XF2vVkNyDk384eDwX09vlPgsUdSONlyo
	 2+uqTOPFwzoIOXUOqvuIBBw3BSRtvsGD1MckASFN49CJNk1FBwr1XmZdQHVNub9LlXM62
	 AMWLHLwphQT8qcMAyfaimVW3+5rIngC7iOJWRwtvJ0mLYqmg1iRofbotOcLw2SYJDuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795508801;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=NIXNWsD1GnWzukxgS94b8Vtpt/UkvIRehEZsYKJ0bvU=;
	b=5QAUXXYdlxQdVk2MDQgB2q9kYZL1tqAq9sBca2LONWtBk9w9fZUZLmsSk4tDVIpHqNJe
	 OQknG1MwNFV9RpPsmz5uY9DU8dMV/RU7PJQuPBkgU6wEAzIRHhrN90OxRR7SrcrDn6v1Q
	 eoZCI7oTgFd5jj3NjLgOL8CCZb5gIJpMJyMKBKTNzKAkx8H+816Uyxj9YlBGqaWhumNBs
	 TucAMkaIq7nQvahRwL9Cwk5/ButBHN/lqH3WjXsX+bDEl1txWItv41h3NbIxCq4GbMOFj
	 I0tWLThndvhyTTOWtwoIdNoi/N86dDxOoYG71TlR1D28tUJy3qm2CbaLsfUuhF321JQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jHXdmBoI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AB9606A31E;
	Tue, 24 Nov 2026 08:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jHXdmBoI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DB271F000CA;
	Tue, 24 Nov 2026 08:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795508800;
	bh=NIXNWsD1GnWzukxgS94b8Vtpt/UkvIRehEZsYKJ0bvU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jHXdmBoImH/yMdINR1oUHELG1cJAB/1ooV1BS/9WCvhE4UnXHXEh0zy1Af2meyXq7
	 2l+/KCeFO3QGiEiLJXBJUov5UOvZOgmaPKoSoxHYo9jV8029eB8AxEp/AvMW35d4Hp
	 bMcOQjO96knFIN2Zy9pOrCYR6PSZQMitHW3R9kVUqe4GgFN5Fu1bJ2luzHS96vgwEX
	 xQL1cy55b3TDgaBmH2jR5LgSjIe6yuQB8cO3qcxSjY3DlIXoZ0RtZyuXlbPh+LixTG
	 6HmWFVZ8oMRxSm4TkAuNMqsQ/Y4KIcBENh1TX/y1EdFfT+noW+S1ZYHbDU/IUSjzKJ
	 NTvlyI2cgm+ZQ==
Subject: Re: [PATCH net v2] nfc: llcp: fix socket list self-loop on connect of
 a linked socket
From: netdev-bot+sashiko@kernel.org
To: bsdhenrymartin@gmail.com
Cc: david@ixit.cz, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, oe-linux-nfc@lists.linux.dev,
 netdev@vger.kernel.org, stable@vger.kernel.org
Date: Tue, 24 Nov 2026 08:26:39 +0000
Message-ID: <179550879966.3135.13090779183406614087@kernel.org>
In-Reply-To: <20261120075908.4064155-1-bsdhenrymartin@gmail.com>
References: <20261120075908.4064155-1-bsdhenrymartin@gmail.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 (1) · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Incomplete fix: the same sk_node double-link, and the same
  endless loop over local->sockets, can still be reached through…
- [Low] The new check in llcp_sock_connect()
  (net/nfc/llcp_sock.c:722-725) returns -EISCONN for any hashed socket,…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it is the same
  shared-sk_node bug class, in the same function, and it is still…

--

nfc: llcp: fix socket list self-loop on connect of a linked socket

This patch makes llcp_sock_connect() reject a socket whose sk_node is
still linked, so that the node is never on both local->sockets and
local->connecting_sockets. Before this, nfc_llcp_recv_cc() could link the
node back into local->sockets and make it point to itself.

Link: https://lore.kernel.org/all/20261009092338.3146149-1-bsdhenrymartin@gmail.com/

> diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
> index 1e5ee4bcde684..01b311d5adda1 100644
> --- a/net/nfc/llcp_sock.c
> +++ b/net/nfc/llcp_sock.c
> @@ -714,6 +714,15 @@ static int llcp_sock_connect(struct socket *sock, struct sockaddr_unsized *_addr
>  		ret = -EINPROGRESS;
>  		goto error;
>  	}
> +	/* A socket that is still linked in local->sockets must not be linked
> +	 * into local->connecting_sockets as well: both lists use sk_node, and
> +	 * the CC handler links the node back into local->sockets, which turns
> +	 * the stale entry into a self-loop.
> +	 */
> +	if (sk_hashed(sk)) {
> +		ret = -EISCONN;
> +		goto error;
> +	}

[Severity: High]
The commit message lists "sockets that a peer moved to LLCP_CLOSED with
DISC or DM" as one of the problem states. Can those sockets still get
their sk_node linked twice through llcp_sock_bind()?

nfc_llcp_recv_disc() moves a connected socket to LLCP_CLOSED but leaves
it linked in local->sockets:

net/nfc/llcp_core.c:nfc_llcp_recv_disc() {
    ...
	if (sk->sk_state == LLCP_CONNECTED) {
		nfc_put_device(local->dev);
		sk->sk_state = LLCP_CLOSED;
		sk->sk_state_change(sk);
	}
    ...
}

For any reason other than LLCP_DM_NOBOUND or LLCP_DM_REJ,
nfc_llcp_recv_dm() looks the socket up on local->sockets through
nfc_llcp_sock_get(). Since connecting is false in that case, the socket
stays linked:

net/nfc/llcp_core.c:nfc_llcp_recv_dm() {
    ...
	if (connecting)
		nfc_llcp_sock_unlink(&local->connecting_sockets, sk);

	sk->sk_err = ENXIO;
	sk->sk_state = LLCP_CLOSED;
    ...
}

That applies to connected sockets, accepted children, and bound or
listening sockets whose ssap/dsap match the DM.

llcp_sock_bind() only checks the state:

	if (sk->sk_state != LLCP_CLOSED) {
		ret = -EBADFD;
		goto error;
	}

nfc_llcp_sock_from_sn() skips CLOSED sockets. With a non-WKS service
name, nfc_llcp_get_sdp_ssap() therefore returns LLCP_SDP_UNBOUND, and
bind() reaches:

	nfc_llcp_sock_link(&local->sockets, sk);

nfc_llcp_sock_link()->sk_add_node()->hlist_add_head() runs on a node that
is already in the list. If the node was first, it now points to itself.
Otherwise the list gets a cycle.

Wouldn't every later sk_for_each() over local->sockets, such as
nfc_llcp_sock_get() in the RX worker or nfc_llcp_sock_from_sn(), then
spin forever with the read lock held? sk_add_node() also takes an extra
sock_hold() that is never released.

Should llcp_sock_bind() get the same sk_hashed() check? Alternatively,
the DISC and DM handlers could unlink the socket from local->sockets.

[Severity: Low]
This returns -EISCONN for any hashed socket, not just LLCP_CONNECTED
ones. That includes LLCP_BOUND and LLCP_LISTEN sockets, and sockets a
peer left in LLCP_CLOSED with DISC or DM. Is -EISCONN the intended errno
in those cases?

In the usual non-blocking connect pattern, a repeated connect() that
returns EISCONN means the socket is connected. After a CC and then a
default-reason DM, connect() would no longer report the pending ENXIO in
sk_err. The application would be told the socket is connected after the
link has gone away.

TCP's __inet_stream_connect() also returns -EISCONN for some
non-connected states, so this may be deliberate. Still, the other
wrong-state checks in this file (llcp_sock_bind(), llcp_sock_listen(),
llcp_sock_accept()) return -EBADFD. The commit message also doesn't
mention this change to the errno userspace sees.

[Severity: High]
This is a pre-existing issue and was not introduced by this patch. It is
the same shared sk_node problem in the same function, further down in
the sock_unlink error path of llcp_sock_connect(). Can that path unlink
the socket from the wrong list and drop the nfc_dev reference twice?

sock_wait_state() releases the socket lock while it sleeps:

		release_sock(sk);
		timeo = schedule_timeout(timeo);
		lock_sock(sk);

While the lock is released, the RX worker can handle a CC.
nfc_llcp_recv_cc() then moves sk to local->sockets and sets
LLCP_CONNECTED:

	nfc_llcp_sock_unlink(&local->connecting_sockets, sk);
	nfc_llcp_sock_link(&local->sockets, sk);

Before the waiter takes the lock again, the worker can also handle a
DISC or a default-reason DM for the same socket. nfc_llcp_recv_agf()
handles aggregated sub-PDUs one after another in a single worker run, so
one AGF frame carrying CC plus DISC would be enough.

After a DM, sock_wait_state() returns -ENXIO. After a DISC, sk_err is not
set, so the waiter sleeps until a signal arrives and returns -ERESTARTSYS
or -EINTR. In both cases connect() then runs:

	if (ret && ret != -EINPROGRESS)
		goto sock_unlink;
	...
sock_unlink:
	nfc_llcp_sock_unlink(&local->connecting_sockets, sk);

This takes connecting_sockets.lock, but sk_del_node_init() removes the
node from local->sockets. Isn't local->sockets then being modified
without local->sockets.lock, racing with its other writers and readers?

In the DISC case, nfc_llcp_recv_disc() has already called
nfc_put_device(local->dev) for the connected state. The error path then
falls through to:

put_dev:
	nfc_put_device(dev);

Could this underflow the nfc_dev refcount and eventually free the
nfc_dev while it is still in use?

The same path also frees service_name, puts the ssap, and clears
llcp_sock->local and llcp_sock->dev on a socket the peer had already
connected.

Should this error path use sk_state, checked under lock_sock(), to decide
which list to unlink from and whether to drop the device reference?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261120075908.4064155-1-bsdhenrymartin%40gmail.com

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA55F4C10DC;
	Mon, 28 Sep 2026 17:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617086; cv=none; b=Pq3UptWM85MVL9BdzdlSSjp1NwAJ/5rVA+iDVB/LS8Q+zXna3ht9Cu1IvlaIvof9htoviYHjZsMocB1MVaLIZnMpOeI7JSdy223TA8XzqCJ8Bz4GoB30nFpJC+Dztnqf33m4ngkYOTpZo4DnDNgYjGmG4yGNu+ACAQJViQxEHGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617086; c=relaxed/simple;
	bh=7bgGvkbBgqdIrTV2Pa46RiGjmjVFupX4w9gypNgpFCw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VaCFvdB5e4E0cfVxvoQ/p9nhC3Vu4v1midEkS2RORK/+i1G8PVdSfuM7f3oDrk/3/7TicTMTIg6uBR0Hn/Pmy/W25UZWicjs3xjr8d+uyBNsKxTXZC7rpLbBY/7CdNnn1OV2jdsEarGUlL9zztGNYvYAtOaStNou+z4G5QVra68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fq3bHI6k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fq3bHI6k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C40A1F000FF;
	Mon, 28 Sep 2026 17:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790617084;
	bh=VFvhxyBwyXWQRkFWEyLnWlqFIdvAR02bthwhHYXPspo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Fq3bHI6kSWQJHeO+dw0FFjAizkVriAQ8Ae7x3Df5yF5khievkYL0cy/YHSMvgqsc7
	 Sif23yY0CAoJy+ulPUOHFX6we8QwQ0t/nkrf5v/tRXTqdi/eBGD+W0BmrBlkAtelkQ
	 cBMzttOdsarhBDmc/SQx9QH5rgBDjgdxfslc9WcSaHWKiS6IK3+2+ueu/tOf2vsGN3
	 MSoZckmueWJc+FJjJ9qObvPIjXDMUL7zB8bVwXV955DSp4eVlyX+r703mR+aNQxqqW
	 Cmc0yZtlPS+bD9jvHhY31+WDATd0MI1bmPiQsvGfZQTpmaqG12kXzNPVcvB0tmsg62
	 WpM5V5wpF1mHw==
Subject: Re: [PATCH net] nfc: llcp: check socket state after locking in
 nfc_llcp_recv_dm()
From: netdev-bot+sashiko@kernel.org
To: qwe.aldo@gmail.com
Cc: david@ixit.cz, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, sashiko-bot@kernel.org
Date: Mon, 28 Sep 2026 17:38:03 +0000
Message-ID: <179061708381.3145.1888668233789067177@kernel.org>
In-Reply-To: <20260925023509.3060096-1-qwe.aldo@gmail.com>
References: <20260925023509.3060096-1-qwe.aldo@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 3 (1) · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Incomplete fix: the new check only skips the unlink, so a stale
  DM still resets the re-bound socket and leaves it hashed but…
- [High] nfc_llcp_recv_cc(), which the comment says recv_dm mirrors,
  still has the same race and unconditionally unlinks the socket from…
- [High] In nfc_llcp_recv_dm() (net/nfc/llcp_core.c:1329-1330), a socket
  in LLCP_CONNECTING may be on a different local's connecting_sockets…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but
  llcp_sock_connect() (net/nfc/llcp_sock.c:709-716) rejects only…

--

nfc: llcp: check socket state after locking in nfc_llcp_recv_dm()

For DM(NOBOUND)/DM(REJ), nfc_llcp_recv_dm() now unlinks the socket from
local->connecting_sockets only if the socket is still LLCP_CONNECTING
after lock_sock(). The goal is to close a race where a failed connect
followed by a re-bind moves the socket onto local->sockets between the
lookup and the lock.

> diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
> index 74bf817007cf2..acf1133114821 100644
> --- a/net/nfc/llcp_core.c
> +++ b/net/nfc/llcp_core.c
> @@ -1326,7 +1326,7 @@ static void nfc_llcp_recv_dm(struct nfc_llcp_local *local,
>  	 * corrupt the connecting_sockets list / desync the socket refcount.
>  	 * This mirrors nfc_llcp_recv_cc().
>  	 */
> -	if (connecting)
> +	if (connecting && sk->sk_state == LLCP_CONNECTING)
>  		nfc_llcp_sock_unlink(&local->connecting_sockets, sk);
>  
>  	sk->sk_err = ENXIO;

[Severity: High]
When the socket is no longer LLCP_CONNECTING, the new check skips only
the unlink. Execution still falls through to:

	sk->sk_err = ENXIO;
	sk->sk_state = LLCP_CLOSED;
	sk->sk_state_change(sk);

In the race the commit message describes, can a stale DM still reset a
socket that has just been re-bound?

llcp_sock_connect()
  lock_sock(sk)
  nfc_llcp_sock_link(&local->connecting_sockets, sk)
                               rx_work: nfc_llcp_recv_dm()
                                 nfc_llcp_connecting_sock_get() finds sk
                                 lock_sock(sk) blocks
  nfc_llcp_send_connect() fails
  goto sock_unlink   /* sk_state is still LLCP_CLOSED */
  release_sock(sk)
llcp_sock_bind()
  sk_state != LLCP_CLOSED check passes
  nfc_llcp_sock_link(&local->sockets, sk)
  sk->sk_state = LLCP_BOUND
                                 lock_sock(sk) acquired
                                 sk_hashed(sk) is true
                                 sk_state != LLCP_CONNECTING, skip unlink
                                 sk_state = LLCP_CLOSED, sk_err = ENXIO

nfc_llcp_send_connect() can fail with -ENOMEM from the TLV or PDU
allocations, or through sock_alloc_send_skb() with MSG_DONTWAIT. The DM
comes from the remote peer. The new ssap is predictable because
nfc_llcp_get_local_ssap() uses find_first_zero_bit().

After this, sk is still hashed on local->sockets but in LLCP_CLOSED. A
later listen() then fails with -EBADFD in llcp_sock_listen() even though
bind() succeeded.

A second bind() also passes the LLCP_CLOSED check in llcp_sock_bind()
and calls nfc_llcp_sock_link(&local->sockets, sk) again. sk_add_node()
is sock_hold() plus hlist_add_head() with no sk_hashed() check. Would
that re-insert an already linked node and create a cycle in
local->sockets?

If so, sk_for_each() in nfc_llcp_sock_get() or nfc_llcp_sock_from_sn()
would never terminate. The second bind() would also leak a sock
reference, the first local kref, the first service_name buffer and any
well-known service bit.

Before this patch, this particular race left the socket unhashed.
Other paths can also leave a socket hashed but LLCP_CLOSED, such as
nfc_llcp_recv_disc() on a connected socket.

When connecting is set but sk_state is not LLCP_CONNECTING, should the
stale DM be ignored completely? The handler could call release_sock()
and nfc_llcp_sock_put() and return, as the !sk_hashed() branch does,
leaving sk_err and sk_state alone.

[Severity: High]
Should the check after lock_sock() also confirm that llcp_sock->local
is still the local the DM was looked up on?

Suppose nfc_llcp_send_connect() fails on local A while A's rx_work is
waiting in lock_sock(). Userspace can then retry connect() on a second
NFC device, local B, and get the lock first:

llcp_sock_connect()   /* retry */
  llcp_sock->local = local;   /* B */
  nfc_llcp_sock_link(&local->connecting_sockets, sk);
  nfc_llcp_send_connect() succeeds
  sk->sk_state = LLCP_CONNECTING;
  sock_wait_state() drops the socket lock

A's DM worker then gets the lock. It sees sk_hashed() true and
sk_state == LLCP_CONNECTING, and calls:

	nfc_llcp_sock_unlink(&local->connecting_sockets, sk);  /* local == A */

That takes A->connecting_sockets.lock, but sk_del_node_init() removes
the node from B's list. Can this race with nfc_llcp_connecting_sock_get()
in B's rx_work, or with connect() and release() on B's list, and corrupt
B->connecting_sockets?

The stale DM from A would also force the connect attempt on B to
LLCP_CLOSED with ENXIO.

[Severity: High]
The comment above this check still says:

	 * For DM(NOBOUND)/DM(REJ) the socket is still linked on the
	 * connecting_sockets list.
	...
	 * This mirrors nfc_llcp_recv_cc().

After this change neither statement is accurate. The code no longer
assumes the socket is on connecting_sockets, and nfc_llcp_recv_cc() has
no matching check.

Does nfc_llcp_recv_cc() have the same race? It also looks up the socket
with nfc_llcp_connecting_sock_get() and calls lock_sock(). It checks
only sk_hashed() and then does:

	/* Unlink from connecting and link to the client array */
	nfc_llcp_sock_unlink(&local->connecting_sockets, sk);
	nfc_llcp_sock_link(&local->sockets, sk);
	llcp_sock->dsap = ssap;
	...
	sk->sk_state = LLCP_CONNECTED;

Take the same failed connect plus re-bind sequence, with the peer
sending a CC instead of a DM. sk is then on local->sockets in
LLCP_BOUND. sk_del_node_init() would remove it from local->sockets
while holding connecting_sockets.lock, not sockets.lock. Nothing
synchronizes that removal with the other users of local->sockets.

The socket would then be re-linked with a peer-chosen dsap and marked
LLCP_CONNECTED, although it never sent a connect PDU.

Should nfc_llcp_recv_cc() get the same revalidation, and the comment be
updated?

[Severity: High]
This isn't a bug introduced by this patch, but the new check assumes
sk_state tells which list the socket is on, and llcp_sock_connect() can
break that. It rejects only two states:

	if (sk->sk_state == LLCP_CONNECTED) {
		ret = -EISCONN;
		goto error;
	}
	if (sk->sk_state == LLCP_CONNECTING) {
		ret = -EINPROGRESS;
		goto error;
	}

A socket in LLCP_BOUND or LLCP_LISTEN is already on local->sockets
because llcp_sock_bind() put it there. If connect() is then called on
that socket, it overwrites llcp_sock->local, ssap and service_name
without releasing the bind-time ones. That leaks a local kref, the
service_name buffer and any well-known service bit.

It then calls:

	nfc_llcp_sock_link(&local->connecting_sockets, sk);

sk_add_node() does sock_hold() and hlist_add_head() without an
sk_hashed() check. This rewrites sk_node while its predecessor on
local->sockets still points at it. Doesn't that cross-link
local->sockets and connecting_sockets?

Any later unlink in nfc_llcp_recv_cc(), nfc_llcp_recv_dm() or
llcp_sock_release() would then work on a node that is on both lists.
An unprivileged user can reach this by calling bind() and then connect()
on the same socket while the DEP link is up.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260925023509.3060096-1-qwe.aldo%40gmail.com

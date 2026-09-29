Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5279131B80E;
	Tue, 29 Sep 2026 02:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790650570; cv=none; b=AuXX+KjAARTNG/5Zw7p7IhGF3zbsN2MTogmNntMqre2JIvV9WDXsEtPQ1duiA/s/7gdVXo2P/YIORKQnz320gg7wxyUldZ9FHcGWe9YJqlISmBr8tGKvmjDbOY9JnkkhZLs3Fc22g8AyTNoc8hvyjpfbjfpguXgIyl0oqD5cLAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790650570; c=relaxed/simple;
	bh=dmYJJdSoHJE3/XiWHK0jVWRPBLPPnX7KIaCceg1r/wM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u3WO+NtS5oOs4N2m/P01buhhfWEwi8zdRlL25gozMHhT3oSxQ2GhMx1tWav1CjBDd//9vFq5wVgoYplVWGE+C2/l03qswnK8udNCrOR3wG12X18xCSrhWEhzS8dK4N5UczHx5McBxToZYV/h5LVOTbWh63U1sBZX4iZM79t/ROA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lzyaz6jk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lzyaz6jk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 372751F000FF;
	Tue, 29 Sep 2026 02:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790650568;
	bh=SHNXDUXvSXm4T3Cq9+zcM3UyGNmTbskniHyZCxLC9Tw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lzyaz6jkZ3vDPqYK31OKYdtVyhoLHwgpOco7PX0T5SyqkPp2nxV8dobq7JOKi6LyG
	 ViPqtiNZ+wa6rUbLtyuQV8cLXfa3DJHd8Z2GWZR7w4iCEuYjVfULJ5e1TGeLH5cZeJ
	 CMEEgBhMc2AGkoarxY7TUOKa2F5KSJ87EQjdI5uPIeqqh7fYcaeJexHZCfFhFqbKc/
	 jKbEg9vssuO3qSg8z90oC30+CUdNLqZyBKnJrDlt/KR8d7c+KQKke/1L/tg1cMwwaF
	 OhBxr3XRxDSZ8R51DH2gMvrltxJbbw8kSIlqPqd/bHP3Wlt4eCd92VO3hbhMuOWJyW
	 vK7uQsRrHf8eQ==
Subject:
 Re: [PATCH net] nfc: llcp: prevent resource leak on repeated connect after DM
From: netdev-bot+sashiko@kernel.org
To: qwe.aldo@gmail.com
Cc: david@ixit.cz, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, sashiko-bot@kernel.org
Date: Tue, 29 Sep 2026 02:56:07 +0000
Message-ID: <179065056776.434549.8549444326582262010@kernel.org>
In-Reply-To: <20260925023527.3065197-1-qwe.aldo@gmail.com>
References: <20260925023527.3065197-1-qwe.aldo@gmail.com>
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

Critical: 1 (1) · High: 2 (1) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] In llcp_sock_connect() (net/nfc/llcp_sock.c:718-733), the
  new cleanup block calls nfc_put_device(llcp_sock->dev) whenever the…
- [High] The fix releases the resources a DM-rejected connect leaves
  behind only when userspace calls connect() again.
- [High] The new cleanup block in llcp_sock_connect()
  (llcp_sock.c:718-733) sets llcp_sock->local and llcp_sock->dev to NULL…
- [Medium] The new cleanup block in llcp_sock_connect()
  (llcp_sock.c:718-733) releases the SSAP, drops the local reference and…

Pre-existing issues:
- [Critical] This problem wasn't introduced by this patch, but it sits on
  the exact 'reconnect from LLCP_CLOSED' path the patch is meant to make…
- [High] This problem wasn't introduced by this patch, but the commit
  message suggests it is handled.

--

nfc: llcp: prevent resource leak on repeated connect after DM

Before llcp_sock_connect() takes new resources, this patch releases the
local reference, SSAP, service name and device reference that an LLCP
socket in LLCP_CLOSED state still holds. It fixes leaks when connect()
is retried after the peer rejects the connection with a DM PDU.

Link: https://lore.kernel.org/all/20260923133339.2518641-1-qwe.aldo@gmail.com/

> Release any resources left on the socket before obtaining resources for a
> new connection.  A closed socket can also retain the device reference held
> by an asynchronous connect, so drop that reference as well.  Bound sockets
> do not hold the device reference, so release it only when reconnecting from
> LLCP_CLOSED.

[Severity: High]
This isn't a bug introduced by this patch, but this wording reads as if
bound sockets are handled and only the device put is limited to
LLCP_CLOSED. In the code, the whole cleanup block is limited to
LLCP_CLOSED.

llcp_sock_connect() rejects only LLCP_CONNECTED and LLCP_CONNECTING.
So connect() on a BOUND or LISTEN socket still overwrites
llcp_sock->local, llcp_sock->ssap and reserved_ssap (the SDP SAP and its
client count), and llcp_sock->service_name set up by llcp_sock_bind().
None of these are released.

It then calls:

	nfc_llcp_sock_link(&local->connecting_sockets, sk);

At that point sk->sk_node is still linked on local->sockets from
llcp_sock_bind(). sk_add_node() rewrites sk_node.next/pprev. Can this
corrupt local->sockets, leaving later entries unreachable or with pprev
pointing into sk? nfc_llcp_sock_get() walks that list, and
nfc_llcp_socket_release() pops from it.

Could the commit message be made clearer? Also, should connect() reject
BOUND/LISTEN sockets or tear them down properly?

> diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
> index 1e5ee4bcde684..9d76c12aee011 100644
> --- a/net/nfc/llcp_sock.c
> +++ b/net/nfc/llcp_sock.c
> @@ -715,6 +715,23 @@ static int llcp_sock_connect(struct socket *sock, struct sockaddr_unsized *_addr
>  		goto error;
>  	}
>  
> +	if (sk->sk_state == LLCP_CLOSED) {

[Severity: High]
This cleanup only runs when connect() is called again. What happens to
the leftover resources if the DM-rejected socket is closed or bound
instead?

For close(): nfc_llcp_recv_dm() sets LLCP_CLOSED without dropping the
device reference taken at connect time. llcp_sock_destruct() puts the
device only for LLCP_CONNECTED:

	if (sk->sk_state == LLCP_CONNECTED)
		nfc_put_device(llcp_sock->dev);

So socket() -> nonblocking connect() -> peer DM(REJ) -> close() seems
to leak one nfc_dev reference per iteration.

For bind(): llcp_sock_bind() only checks:

	if (sk->sk_state != LLCP_CLOSED) {
		ret = -EBADFD;
		goto error;
	}

It then overwrites llcp_sock->dev, llcp_sock->local,
llcp_sock->service_name and llcp_sock->ssap. Doesn't that leak the old
local reference, SSAP, service_name and device reference? That is the
same leak the commit message describes.

nfc_llcp_recv_dm() already holds the socket lock and unlinks the socket.
Would releasing the connect-time device reference there fix connect(),
bind() and close() together? It would also remove the doubt about who
owns llcp_sock->dev, which comes up again below.

> +		/* Release resources retained by a previous failed connection. */
> +		if (llcp_sock->local) {
> +			if (llcp_sock->reserved_ssap < LLCP_SAP_MAX)
> +				nfc_llcp_put_ssap(llcp_sock->local, llcp_sock->ssap);
> +			nfc_llcp_local_put(llcp_sock->local);
> +		}
> +		if (llcp_sock->dev)
> +			nfc_put_device(llcp_sock->dev);

[Severity: Critical]
Does this drop an nfc_dev reference that the socket doesn't own?

Only the DM(NOBOUND/REJ) path in nfc_llcp_recv_dm() moves a socket to
LLCP_CLOSED while it still holds the reference taken by connect().
Other paths leave llcp_sock->dev set on a CLOSED socket whose reference
was already dropped or never taken.

nfc_llcp_recv_disc() in net/nfc/llcp_core.c:

	if (sk->sk_state == LLCP_CONNECTED) {
		nfc_put_device(local->dev);
		sk->sk_state = LLCP_CLOSED;
		sk->sk_state_change(sk);
	}

nfc_llcp_socket_release() runs from nfc_llcp_mac_is_down() and
local_cleanup(). It puts the device only for CONNECTED sockets, then
sets every socket on local->sockets to LLCP_CLOSED, including BOUND and
LISTEN ones.

llcp_sock_bind() stores llcp_sock->dev and then drops the reference:

	sk->sk_state = LLCP_BOUND;
	nfc_put_device(dev);

Accepted child sockets from nfc_llcp_recv_connect() lose their
reference the same way, through either of the first two paths.

In each case, a later connect() on that socket reaches this put again.
This block runs before nfc_get_device(addr->dev_idx) is checked, so
even a connect() with an invalid dev_idx triggers it. With N bound
sockets and one link down, N connect() calls would drop N references
the sockets never held.

Could this bring the refcount of a still-registered nfc_dev to zero and
free it while it is still in use?

The existing code, for example llcp_sock_destruct(), decides ownership
by sk_state, not by whether llcp_sock->dev is non-NULL. Would it be
safer to drop the reference in nfc_llcp_recv_dm(), as
nfc_llcp_recv_disc() does, or to track ownership explicitly?

Before this patch, connect() on these sockets overwrote llcp_sock->dev
without putting it, so the double put is new.

> +		kfree(llcp_sock->service_name);
> +		llcp_sock->local = NULL;

[Severity: Medium]
If llcp_sock->local is cleared here without unlinking the socket from
local->sockets, can the sock be leaked?

Some closed sockets are still hashed on local->sockets, and that link
holds a sock reference. This covers sockets closed by
nfc_llcp_recv_disc(). It also covers sockets closed by
nfc_llcp_recv_dm() with a reason other than REJ/NOBOUND; its default
branch does not unlink.

Suppose the reconnect then fails early, for example because
nfc_get_device() returns NULL for an invalid dev_idx. connect() returns
-ENODEV with llcp_sock->local == NULL, and llcp_sock_release() skips
the unlink:

	local = llcp_sock->local;
	if (local == NULL) {
		err = -ENODEV;
		goto out;
	}

The sock would then stay on local->sockets after close() until the next
link teardown pops it. Its SSAP has already been given back by
nfc_llcp_put_ssap().

Before this patch, an early connect() failure left llcp_sock->local in
place, so close() still unlinked the socket.

> +		llcp_sock->dev = NULL;

[Severity: High]
Can this race with a concurrent sendmsg() on the same socket?

llcp_sock_sendmsg() checks llcp_sock->local and LLCP_CONNECTED under
lock_sock(), then drops the lock before sending:

	release_sock(sk);

	return nfc_llcp_send_i_frame(llcp_sock, msg, len);

nfc_llcp_send_i_frame() checks sock->local once, then calls
memcpy_from_msg(). That call can block on a user page fault, and
userfaultfd or FUSE can make the stall as long as needed.

thread A
llcp_sock_sendmsg()->nfc_llcp_send_i_frame()
    blocks in memcpy_from_msg()

peer
    sends DISC or DM, socket moves to LLCP_CLOSED

thread B
llcp_sock_connect() with an invalid dev_idx
    this block sets llcp_sock->local and llcp_sock->dev to NULL
    returns -ENODEV

thread A
    resumes, nfc_llcp_send_i_frame()->llcp_allocate_pdu()

llcp_allocate_pdu() only checks sock->ssap. That still holds the old
non-zero value, because this block resets only reserved_ssap:

	if (sock->ssap == 0)
		return NULL;

	skb = nfc_alloc_send_skb(sock->dev, &sock->sk, MSG_DONTWAIT,
				 size + LLCP_HEADER_SIZE, &err);

Would nfc_alloc_send_skb() then dereference dev->tx_headroom with dev
NULL?

The older connect() failure paths (sock_llcp_nullify and sock_unlink)
already clear these fields, for example after a connect() interrupted by
a signal. This block adds a new place that clears them, and it runs
before any argument validation.

> +		llcp_sock->service_name = NULL;
> +		llcp_sock->service_name_len = 0;
> +		llcp_sock->reserved_ssap = LLCP_SAP_MAX;
> +	}

[Severity: Critical]
This is a pre-existing issue, but it is on the reconnect from
LLCP_CLOSED path that this patch is meant to make safe.

Some CONNECTED sockets are set to LLCP_CLOSED but stay hashed on
local->sockets: those closed by a peer DISC in nfc_llcp_recv_disc(),
and those closed by a DM with a non-REJ/NOBOUND reason in the default
branch of nfc_llcp_recv_dm().

This block releases the SSAP and the local reference but does not
unlink the socket. Later, llcp_sock_connect() does:

	nfc_llcp_sock_link(&local->connecting_sockets, sk);

and nfc_llcp_sock_link() is only:

	write_lock(&l->lock);
	sk_add_node(sk, &l->head);
	write_unlock(&l->lock);

Doesn't this rewrite sk_node.next/pprev while sk is still reachable
from local->sockets.head? nfc_llcp_sock_get() walks that list under a
different lock.

The previous entry on local->sockets would still point at sk, and the
entries after it would keep pprev pointers into sk. After that, the
unlink in nfc_llcp_recv_cc(), the unlink in llcp_sock_release() or the
pops in nfc_llcp_socket_release() could produce self-loops, writes
through a dangling pprev, or a use-after-free once sk is freed.

Does this cleanup block need an
nfc_llcp_sock_unlink(&llcp_sock->local->sockets, sk)?

> +
>  	dev = nfc_get_device(addr->dev_idx);
>  	if (dev == NULL) {
>  		ret = -ENODEV;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260925023527.3065197-1-qwe.aldo%40gmail.com

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA0249503E;
	Sat, 10 Oct 2026 11:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791633150; cv=none; b=TYobMQnxZhCYzeF7SKMjlCZjZFE0lMVztvekBNcJTMBVHsgS8SWyDG8BUXl14KeWbMUoSSG6lM+2+wKHpD3MCIFWnhJCBFgKFFoP/OD6FR+sCgESGmsv/VzWefOigs9jyDS3gXSaVXus1mAnkXlZ29pAG+9Wk/e9KLjzV6uVOQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791633150; c=relaxed/simple;
	bh=72t8ySfPLIAMt1BG7VcZRcY3TtGZAREt4OV2FdhCVHQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uCggLJiSa9g24dyNcn4d5UUKGMj/moLdv3Qg0rHu3kCcowYsp0ew6DR5bZoNGfMRxVDZaLTP/nBFrSC3zERPtSi2NAkvIz/oFuC5LvgvyCg4uPhpCIccbTh2kpKBpY5Xpl/nFjoV3dsPg9UwXOtOxRF7e+qJU7lJ1DxGhk7GGYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NB10SM9d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NB10SM9d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FEE81F00893;
	Sat, 10 Oct 2026 11:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791633148;
	bh=jWljI0UWlys2ZLmdiSWG6rYFeY9ZHipJlKNgZEpzQHE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NB10SM9dCduzb7IcIwGk7ncjY8TrM417j0jsMTay4J6b4Ya66z0EDHr+toGlfRCu8
	 hPvAtUAT1wZNCTlbcQKxj9K3NqaHEC87428423/HtpxzDYnZlqnDkN/QJ3E/jX/Wgo
	 pJp90VyIx1fJ3ZsVobdxc3dkIyJMtHv/OD8qiy3fZczXVlyWeBAXhXHlCUZzm4F8xo
	 G2UFg9pLZoEIfHFopa4soM/WpC9WKo6rn4djnb/y0sLKfhuHJWOcMt3m6dHAegB68l
	 Roh8KCkYzOCZ29cdVFvYNB+bm80Hh8+fJIEnocRQVq1ZhqC/tjNqhezu3h4noRWEOY
	 JXzvPm2Uy3Jxg==
Subject: Re: [PATCH] rxrpc: fix connection reference leak on aborted CHALLENGE
From: netdev-bot+sashiko@kernel.org
To: bsdhenrymartin@gmail.com
Cc: dhowells@redhat.com, marc.dionne@auristor.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-afs@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Sat, 10 Oct 2026 11:52:27 +0000
Message-ID: <179163314765.434549.17950043539968457233@kernel.org>
In-Reply-To: <20261009115003.3696517-1-bsdhenrymartin@gmail.com>
References: <20261009115003.3696517-1-bsdhenrymartin@gmail.com>
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

Critical: 0 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete.
- [Low] The commit message overstates how the leak is triggered.

--

rxrpc: fix connection reference leak on aborted CHALLENGE

This patch drops the connection reference that rxrpc_post_challenge()
stored in sp->chall.conn when rxrpc_process_event() returns early on an
aborted connection. Without that put, the CHALLENGE skb gets freed while
the reference is still held.

> held, pinning the connection forever; a malicious server repeating
> CHALLENGE-then-ABORT leaks one connection per packet.

[Severity: Low]

Is "one connection per packet" accurate? rxrpc_input_conn_packet() drops
any CHALLENGE that arrives after the conn has been aborted:

net/rxrpc/conn_event.c:rxrpc_input_conn_packet() {
    ...
	case RXRPC_PACKET_TYPE_CHALLENGE:
		rxrpc_see_skb(skb, rxrpc_skb_see_oob_challenge);
		if (rxrpc_is_conn_aborted(conn)) {
			if (conn->completion == RXRPC_CALL_LOCALLY_ABORTED)
				rxrpc_send_conn_abort(conn);
			return true;
		}
    ...
}

The ABORT case also returns early for a conn that is already aborted.

So the leak needs a race. The conn state has to become RXRPC_CONN_ABORTED
after rxrpc_post_challenge() has queued the skb, but before the conn work
runs rxrpc_process_event(). Even then, a given connection can be pinned
only once.

Could the commit message describe that window? The rate would be one
pinned connection per client connection that hits the window, not one per
packet.

> diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
> index 611c790bc6d0c..56503a05d5d7d 100644
> --- a/net/rxrpc/conn_event.c
> +++ b/net/rxrpc/conn_event.c
> @@ -272,8 +272,20 @@ static int rxrpc_process_event(struct rxrpc_connection *conn,
>  	bool secured = false;
>  	int ret;
>  
> -	if (conn->state == RXRPC_CONN_ABORTED)
> +	if (conn->state == RXRPC_CONN_ABORTED) {
> +		/*
> +		 * Drop the ref taken by rxrpc_post_challenge() on this
> +		 * CHALLENGE before bailing out: otherwise the skb is
> +		 * released by the caller with the connection reference
> +		 * still held, pinning the connection forever (leak).
> +		 */
> +		if (sp->chall.conn) {
> +			sp->chall.conn = NULL;
> +			rxrpc_put_connection(conn,
> +					rxrpc_conn_put_challenge_input);
> +		}

[Severity: High]

Is this the only way a CHALLENGE skb on conn->rx_queue can be discarded
while it still holds the sp->chall.conn ref?

This put only runs if the skb is actually dequeued and passed to
rxrpc_process_event(). There seem to be ways for the skb to be left on
conn->rx_queue without that happening.

First, rxrpc_process_connection() skips the drain completely when
__rxrpc_use_local() fails:

net/rxrpc/conn_event.c:rxrpc_process_connection() {
    ...
	if (__rxrpc_use_local(conn->local, rxrpc_local_use_conn_work)) {
		rxrpc_do_process_connection(conn);
		rxrpc_unuse_local(conn->local, rxrpc_local_unuse_conn_work);
	}
}

rxrpc_release_sock() calls flush_workqueue() before rxrpc_unuse_local().
rxrpc_unuse_local() then drops active_users to 0 and calls kthread_stop(),
but the I/O thread keeps draining local->rx_queue after that.

rxkad has no challenge_to_recvmsg, so a CHALLENGE for an idle client conn
goes straight onto the conn queue:

rxrpc_post_challenge()
    sp->chall.conn = rxrpc_get_connection(conn, ...);
    rxrpc_post_packet_to_conn(conn, skb);
        skb_queue_tail(&conn->rx_queue, skb);
        rxrpc_queue_conn(conn, ...);

The conn work then fails __rxrpc_use_local(), and the skb stays queued
with its ref.

Second, rxrpc_queue_conn() does not queue any work when conn->active is
negative:

net/rxrpc/conn_object.c:rxrpc_queue_conn() {
	if (atomic_read(&conn->active) >= 0 &&
	    rxrpc_queue_work(&conn->processor))
		rxrpc_see_connection(conn, why);
}

Client conns reach -1 when they are discarded from the idle list.
rxrpc_input_conn_packet() does not check for this before calling
rxrpc_post_challenge().

In both cases, the only remaining drain is rxrpc_purge_queue() in
rxrpc_clean_up_connection(). That only runs after conn->ref reaches zero,
which the queued skb's own ref prevents.

Even if the purge did run, rxrpc_purge_queue() -> rxrpc_free_skb() does
not drop sp->chall.conn. rxrpc_respond_to_oob() does drop it:

	case RXRPC_OOB_CHALLENGE:
		rxrpc_put_connection(sp->chall.conn, rxrpc_conn_put_oob);

A client conn pinned this way is never removed from local->conn_ids. Could
that trigger the BUG() in rxrpc_destroy_client_conn_ids() when
rxrpc_destroy_local() runs? Or could it hang netns exit in
rxrpc_destroy_all_connections(), which waits for rxnet->nr_conns to reach
zero?

Would a common helper that releases sp->chall.conn give a more complete
fix? It would need to be used everywhere a conn-queued CHALLENGE skb is
freed, including the conn->rx_queue purges.

If not, the commit message's claim that this early return is "the
remaining, still-open one" may need revising.

>  		return -ECONNABORTED;
> +	}
>  
>  	_enter("{%d},{%u,%%%u},", conn->debug_id, sp->hdr.type, sp->hdr.serial);
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009115003.3696517-1-bsdhenrymartin%40gmail.com

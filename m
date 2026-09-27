Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855EF31AABC;
	Sun, 27 Sep 2026 14:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790521203; cv=none; b=By1qq83+DqHHAtD2ECIm3QWYOLn5fLUPzrCr2BQHEcot0+eDi//GZD4PnYXIA3en21I+bGhN3yfsLNCYLlxbDBV3DwKqzA9Wfg8XTd55Ga8cb7m9nYpqWYOp4xgew2YYj+ue4b8z8Z6yzYH4VnUX1EOq853n/Kk0JYtmQ9of0tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790521203; c=relaxed/simple;
	bh=o8A2e4z2JQDecFuamyJ8gr5ncEuH2PfxZ5tCpUBdTh0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FKUB9UX63vWyUJYVYKRAmrtV+y3FElQH4muE3zyZkFNtL3GePblMVzvL2B4NQwKHduLOMNTDWro6IWqoalCcrXlFc3AGNtXXtZg6oZ6IyhpVt8o8F34nnFncgXfzezEUav5lFrRci1/sIAhLs+OLt9gFW/yFrpzehSpWb71hAiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=maHY6Cut; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="maHY6Cut"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97B381F0089A;
	Sun, 27 Sep 2026 14:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790521199;
	bh=/l1PNXKQwltkMjXXqOjr03Ff62+xQlvJKxCiD5MB1Ic=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=maHY6CutmmsswcWc2GaV1KSmXGEKWa5exIbX6227jP2gQ5s1zgGBVzNqv6AigLKfN
	 8o9S/7g7RCGruQSX4hMptCXqqqZbJqby98vKppJCkCK2zV+EUgRKsX7lTKZ5e+A9QY
	 pqDny4Q+CkusuMfXeGPOcmMcXyrs6bU++krMsMUJc2qM0Rqrhz1WYNNSUy2FVFeqp7
	 V/ImMuXx9rmw8SGSh7TXAkawYfh7bp2VYo27X92HJfVSEWcXGtAdisEHysAQlyCc3q
	 1YHcHqYsSMQbmrpCwYImChZxk7RzeYge+2t6nuSxGhVohNJNAf77ft5GF2MIxZa8RX
	 x7poBPssgbpAA==
Subject:
 Re: [PATCH net v11 17/17] rxrpc: fix use-after-free in rxrpc_poke_conn()
From: netdev-bot+sashiko@kernel.org
To: dhowells@redhat.com
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
 qotmddnjs@ajou.ac.kr, stable@vger.kernel.org
Date: Sun, 27 Sep 2026 14:59:58 +0000
Message-ID: <179052119820.2160803.10819328659483521735@kernel.org>
In-Reply-To: <20260923133706.1496540-18-dhowells@redhat.com>
References: <20260923133706.1496540-18-dhowells@redhat.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message misdescribes the fix.

Pre-existing issues:
- [High] Nothing drains local->conn_attend_q after the I/O thread leaves
  its main loop, so a poke that lands in that window leaks the…

--

rxrpc: fix use-after-free in rxrpc_poke_conn()

This patch makes rxrpc_poke_conn() take its poke reference with
rxrpc_get_connection_maybe() in place of rxrpc_get_connection(). If the
refcount is already zero, the connection is no longer added to
local->conn_attend_q. This closes a use-after-free where the I/O thread
touched a freed connection that was still queued.

> Guard rxrpc_poke_conn() with the same liveness/refcount check the sibling
> rxrpc_queue_conn() uses before taking the poke reference, so a connection
> past its last-active point is not poked/requeued after teardown began.

[Severity: Low]
Is this paragraph accurate? rxrpc_queue_conn() checks only the active count
and takes no reference:

net/rxrpc/conn_object.c:rxrpc_queue_conn() {
	if (atomic_read(&conn->active) >= 0 &&
	    rxrpc_queue_work(&conn->processor))
		rxrpc_see_connection(conn, why);
}

The patch never reads conn->active. rxrpc_get_connection_maybe() checks
only the refcount:

	if (__refcount_inc_not_zero(&conn->ref, &r))

That matches what rxrpc_poke_call() does with rxrpc_try_get_call(), not
what rxrpc_queue_conn() does.

Could the message say that the poke reference is now taken with
inc_not_zero, and drop the claim that this copies the conn->active check
in rxrpc_queue_conn()?

> diff --git a/net/rxrpc/conn_object.c b/net/rxrpc/conn_object.c
> index 0ece717db0f85..1be50e0c9cee5 100644
> --- a/net/rxrpc/conn_object.c
> +++ b/net/rxrpc/conn_object.c
> @@ -34,7 +34,10 @@ void rxrpc_poke_conn(struct rxrpc_connection *conn, enum rxrpc_conn_trace why)
>  	spin_lock_irq(&local->lock);
>  	busy = !list_empty(&conn->attend_link);
>  	if (!busy) {
> -		rxrpc_get_connection(conn, why);
> +		if (!rxrpc_get_connection_maybe(conn, why)) {
> +			spin_unlock_irq(&local->lock);
> +			return;
> +		}
>  		list_add_tail(&conn->attend_link, &local->conn_attend_q);

[Severity: High]
This is a pre-existing issue and was not introduced by this patch, but what
happens if a poke arrives after the I/O thread has left its main loop?

rxrpc_io_thread() breaks out of the loop once kthread_should_stop() is set
and conn_attend_q is empty. It then calls rxrpc_destroy_local():

net/rxrpc/io_thread.c:rxrpc_io_thread() {
    ...
		if (should_stop)
			break;
    ...
	rxrpc_destroy_local(local);
    ...
}

rxrpc_destroy_local() sets local->dead and cleans up the client conns, the
socket and rx_queue. It never touches local->conn_attend_q.

A client connection can still have conn->timer armed at that point.
rxrpc_disconnect_client_call() arms the timer for jiffies+2, then puts the
connection on the idle list with a reference held:

net/rxrpc/conn_client.c:rxrpc_disconnect_client_call() {
    ...
		set_bit(RXRPC_CONN_FINAL_ACK_0 + channel, &conn->flags);
		rxrpc_reduce_conn_timer(conn, final_ack_at);
    ...
}

rxrpc_clean_up_local_conns() cancels only local->client_conn_reap_timer
synchronously. It doesn't cancel each connection's own timer before it
drops the unbundle and idle references.

If conn->timer fires in that window, the refcount is still above zero:

rxrpc_connection_timer()
  rxrpc_poke_conn()
    rxrpc_get_connection_maybe()   <- succeeds
    list_add_tail(&conn->attend_link, &local->conn_attend_q)

The only thing that consumes conn_attend_q is the loop that has already
exited. Does this leak the connection and its poke reference, along with
its references on local, peer and bundle and its key?

If so, rxnet->nr_conns never reaches zero. On netns exit,
rxrpc_destroy_all_connections() would then wait forever here:

	wait_var_event(&rxnet->nr_conns, !atomic_read(&rxnet->nr_conns));

AF_RXRPC sockets can be created without privileges. An unprivileged user
could reach this window by closing the socket right after a client call
succeeds.

The old unconditional rxrpc_get_connection() had the same behaviour. The
new inc_not_zero guard doesn't help here because the refcount is nonzero.

Would rxrpc_poke_conn() need a local->dead check under local->lock to close
this? Alternatively, rxrpc_destroy_local() could drain conn_attend_q and
drop the poke references.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260923133706.1496540-1-dhowells%40redhat.com

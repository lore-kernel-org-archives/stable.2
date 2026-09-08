Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F373C09F2;
	Tue,  8 Sep 2026 20:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788900593; cv=none; b=ArAgjEWRJuS9AnnTppIi0/L3C4oFF1JgpBBie6sDiTEgif0drW78DWfQ3jnzrwiMy2ynqEdSfYZkSGsfB0KnxydmJi/NTkephsmayiNSuniz3akylUUaFz4u5oo7D94TovG5mcPOr1XPBTOOSNBSEfgXCWSoatoT7CmpbZ3jzu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788900593; c=relaxed/simple;
	bh=vWNZ/52mC9u46UPEXsqGjcKhl0jFSD/03leV8fRKzDg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ox/WC1gXoU1dqbz+n7Rh2UkmpLr2DafrHnHl6J0D1knSRUa5TfkwJoITBGjHBDA9/JqVd2gLfdDGu2EF+DFLuvn8ozsZQRfd+ozc03rFI072qMFqfaSI3+RPtABeGKNrD+2VGi2znljG2CwgP+XrWMxF8bkPYIDBCCk24n1eSEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CFjQ5oAp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CFjQ5oAp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE26C1F00A3A;
	Tue,  8 Sep 2026 20:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788900591;
	bh=upgPBMfAKThcybnVwcemSLPSP8rSAK1+5xwjstlcFuI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CFjQ5oApQxo+tkaqMzpLAzwvV1MQPlUHTv+wRyHrVMe/hOLoIFr9VywoDOMoGFmVY
	 DcWJfd09+NfPb2TA8/DPvmK6pPdL1brk89PT7S4UVdStqRxpttTFydRA1DtV9Pv/f2
	 WfkvIGhnodgfEOn6tZb14UPBMvQvyasPaFBdMhkXWPQxxJXlW/X6bOSkqmNy4zo0v1
	 RKr1AVDwj2zV8N5opTO5rescG2wKcWnFyMld+nNkEkL56xi55ICzQTYetvgalTzaLX
	 6wQMhoB5TLFRXR2YFjJnHtAjdkvO1f4xxTE1awYaa41GWwsnxl5vPm1E10VAKovVF5
	 YQ3577c2+ffIw==
Subject:
 Re: [PATCH net v9 13/14] rxrpc: fix use-after-free in rxrpc_poke_conn()
From: netdev-bot+sashiko@kernel.org
To: dhowells@redhat.com
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
 nicoyip.dev@gmail.com, stable@vger.kernel.org
Date: Tue, 08 Sep 2026 20:49:50 +0000
Message-ID: <178890059047.219967.10164675967516707934@kernel.org>
In-Reply-To: <20260907113743.1453210-14-dhowells@redhat.com>
References: <20260907113743.1453210-14-dhowells@redhat.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 (1) · Medium: 0 · Low: 1

- [Low] Commit message mischaracterizes the applied fix: it claims to
  guard rxrpc_poke_conn() "with the same liveness/refcount check the…

Pre-existing issues:
- [High] Residual poke-reference leak after the rxrpc I/O thread exits:
  rxrpc_poke_conn() (net/rxrpc/conn_object.c:34-44) still takes a poke…

--

rxrpc: fix use-after-free in rxrpc_poke_conn()

This changes rxrpc_poke_conn() to take the poke reference with
rxrpc_get_connection_maybe() instead of rxrpc_get_connection(), returning
early if the refcount is already zero.  The intent is to stop a connection
being linked into local->conn_attend_q after it has started teardown.

No Link: tags in the commit header.

Two questions below, one about the changelog wording and one about a
pre-existing lifetime issue that this hunk touches.

> Guard rxrpc_poke_conn() with the same liveness/refcount check the sibling
> rxrpc_queue_conn() uses before taking the poke reference, so a connection
> past its last-active point is not poked/requeued after teardown began.

[Severity: Low]
Is this description of the applied change accurate?  rxrpc_queue_conn()
gates on the active count and takes no reference at all:

net/rxrpc/conn_object.c:rxrpc_queue_conn() {
	if (atomic_read(&conn->active) >= 0 &&
	    rxrpc_queue_work(&conn->processor))
		rxrpc_see_connection(conn, why);
}

and rxrpc_see_connection() only does refcount_read() plus a tracepoint.
The patch instead adds a refcount gate
(rxrpc_get_connection_maybe() is __refcount_inc_not_zero()), which is a
different liveness signal.

Also, does the code achieve "a connection past its last-active point is not
poked/requeued"?  rxrpc_service_connection_reaper() sets active to -1 while
the refcount is still non-zero:

net/rxrpc/conn_object.c:rxrpc_service_connection_reaper() {
	...
		active = 0;
		if (!atomic_try_cmpxchg(&conn->active, &active, -1))
			continue;
	...
		rxrpc_put_connection(conn, rxrpc_conn_put_service_reaped);
}

so such a connection still passes the new refcount test and is queued to
the I/O thread.  Would it be clearer to describe the change as a
refcount_inc_not_zero gate rather than the same check as
rxrpc_queue_conn()?

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
>  	}
>  	spin_unlock_irq(&local->lock);

[Severity: High]
This isn't a bug introduced by this patch, but can a poke reference still be
taken after the I/O thread has exited, and if so who drops it?

The only consumer of conn_attend_q is rxrpc_io_thread():

net/rxrpc/io_thread.c:rxrpc_io_thread() {
	...
		while ((conn = list_first_entry_or_null(&conn_attend_q,
						       struct rxrpc_connection,
						       attend_link))) {
			spin_lock_irq(&local->lock);
			list_del_init(&conn->attend_link);
			spin_unlock_irq(&local->lock);
			rxrpc_input_conn_event(conn, NULL);
			rxrpc_put_connection(conn, rxrpc_conn_put_poke);
		}
	...
		if (should_stop)
			break;
	...
	rxrpc_destroy_local(local);
}

After that break, nothing drains conn_attend_q again.  rxrpc_destroy_local()
purges rx_queue and the client conns but never unlinks attend_link or drops
poke refs:

net/rxrpc/local_object.c:rxrpc_destroy_local() {
	local->dead = true;

	mutex_lock(&rxnet->local_mutex);
	hlist_del_init_rcu(&local->link);
	mutex_unlock(&rxnet->local_mutex);

	rxrpc_clean_up_local_conns(local);
	...
	rxrpc_purge_queue(&local->rx_queue);
	rxrpc_purge_client_connections(local);
}

The final-ACK timer armed in rxrpc_disconnect_client_call() has no reference
held for it:

net/rxrpc/conn_client.c:rxrpc_disconnect_client_call() {
	...
		unsigned long final_ack_at = jiffies + 2;
	...
		rxrpc_reduce_conn_timer(conn, final_ack_at);
}

If that timer expires between the I/O thread's last conn_attend_q re-check
and rxrpc_clean_up_local_conns()'s
rxrpc_put_connection(conn, rxrpc_conn_put_local_dead), the idle/bundle refs
are still held, so rxrpc_get_connection_maybe() succeeds and the connection
is queued with a poke ref that nothing will ever drop.

Does conn->ref then never reach zero, leaving conn->proc_link on
rxnet->conn_proc_list, rxnet->nr_conns undecremented and the rxrpc_local
reference held?  At netns exit that would hit

net/rxrpc/conn_object.c:rxrpc_destroy_all_connections() {
	ASSERT(list_empty(&rxnet->conn_proc_list));
	...
	wait_var_event(&rxnet->nr_conns, !atomic_read(&rxnet->nr_conns));
}

either the ASSERT or an indefinite wait on the cleanup_net worker.

Would closing this need a reference held for the armed conn->timer with a
synchronous cancel before the last put, or explicit unlinking of
conn_attend_q entries when the I/O thread exits?  The refcount-only gate
added here does not appear to cover it.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260907113743.1453210-1-dhowells%40redhat.com

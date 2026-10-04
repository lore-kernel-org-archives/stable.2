Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2856F3B8412;
	Sun,  4 Oct 2026 19:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791142049; cv=none; b=OpYTeQLmSlu9GqEEYUoLaNwhs9nxvUS/SjNuO3kv+J8I5Atvw9PnS3/+7AGBBe8G/MfLG/TThrhITOvzZUNemWFAj3JYeSP3oqUE5xTCV+Etl104/FNEGqXGpd5sXYEwxtIY6mBphrrCqCPLR4y1yY756Zi8fKxbPR6WHVZUx2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791142049; c=relaxed/simple;
	bh=fo+kfVYTqykxYEMEyS3xEUOKLVhZpn1Y+X3krlOdjOg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Dtrl1b7/gFXZu5uQ3hjvI+ZnHqtSgI3uf8LwVSNXIuCZFvoZJhRBkNe7b4GZzxr2w2bAfO3Eccy56vGXqpprkMbj07tvXtt5mXU/j7FZV4obYc6ROjtc8hwxAd68sc2vN9+Ez/uBcZeUDAYSpTbABOhOihDKiRSu4gx+qH2ul6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0Oxj1jf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0Oxj1jf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B2111F000FF;
	Sun,  4 Oct 2026 19:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791142044;
	bh=pEsCEEIlhAlv1c9hPn4LM6ZCnsREWSEF/BB4zwo6m68=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=J0Oxj1jftlGKWLqKvWK13t6GANkD7kxE/UY92OQnlrdNweIefajnxDtcNo/3/2TsM
	 EXinakPh5lBnOmOwgWWhKHtIeCg49fxY/aZVVdXuH9qB0u2D6n0QNbOAkL/oPDYNMi
	 t8wQih1mSao7DoSBxv8IpksGf9uFYmn3jHWlCmndRVlRALtGCEQOwfhXtP3jU+1mRU
	 k5osoOVdlWX4it5UA4YDoiG+1TjB515h7mbW2+S2P52fwvymT/44/JyE0esMUgQgMN
	 4gN9NcQAuOLm4Z4DZ1WQfpHOxtauSJXIxEa5lOhfPq51M/KhjCayNYDVbxT8TzhgIT
	 gXOnilWPtPHgg==
Subject: Re: [PATCH] tipc: fix use-after-free in netns teardown
From: netdev-bot+sashiko@kernel.org
To: Jeremy.Jean@oss.cyber.gouv.fr
Cc: tung.quang.nguyen@est.tech, jmaloy@redhat.com, netdev@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, kuba@kernel.org
Date: Sun, 04 Oct 2026 19:27:23 +0000
Message-ID: <179114204389.434549.3724053905057286143@kernel.org>
In-Reply-To: <20261003192530.2414682-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20261003192530.2414682-2-Jeremy.Jean@oss.cyber.gouv.fr>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Because the teardown loop in tipc_topsrv_stop() always
  restarts at the lowest IDR id (line 709, `id = 0`), it can block on…

Pre-existing issues:
- [High] Netns teardown can hit a NULL pointer dereference on a kernel-
  subscription connection.

--

tipc: fix use-after-free in netns teardown

Before walking conn_idr, this patch makes tipc_topsrv_stop() clear the
listener's sk_user_data and cancel the accept work. The idr_find() plus
conn_get() lookup is replaced with idr_get_next() plus
kref_get_unless_zero(). The walk now restarts from id 0 on every pass and
calls cond_resched() between passes.

> diff --git a/net/tipc/topsrv.c b/net/tipc/topsrv.c
> index af530c9ed8402..9ab2349f71190 100644
> --- a/net/tipc/topsrv.c
> +++ b/net/tipc/topsrv.c
> @@ -700,16 +700,23 @@ static void tipc_topsrv_stop(struct net *net)
>  	struct tipc_conn *con;
>  	int id;
>  
> +	write_lock_bh(&lsock->sk->sk_callback_lock);
> +	lsock->sk->sk_user_data = NULL;
> +	write_unlock_bh(&lsock->sk->sk_callback_lock);
> +	cancel_work_sync(&srv->awork);
> +
>  	spin_lock_bh(&srv->idr_lock);
> -	for (id = 0; srv->idr_in_use; id++) {
> -		con = idr_find(&srv->conn_idr, id);
> +	for (id = 0; srv->idr_in_use; id = 0) {
> +		con = idr_get_next(&srv->conn_idr, &id);

[Severity: Medium]

Can restarting from id 0 on every pass livelock the teardown?

rcv_wq is an ordered workqueue:

tipc_topsrv_work_start()
    s->rcv_wq = alloc_ordered_workqueue("tipc_rcv", 0);

Take a lower-id connection A whose rwork is queued behind the running
rwork of a higher-id connection B. The loop closes A, but the reference
held by A's queued rwork keeps A in conn_idr. On every later pass
idr_get_next() returns A again, so the loop never reaches B.

tipc_conn_recv_work() keeps running while B is connected and requests
keep arriving:

    while (connected(con)) {
        if (tipc_conn_rcv_from_sock(con))
            break;
    ...

The cond_resched() here gives up the CPU. A's work still cannot run on
the ordered queue until B's worker returns. If B's receive queue never
empties, idr_in_use never reaches 0 and cleanup_net() spins.

The old loop advanced with id++. It would have cleared CF_CONNECTED on B,
which ends B's worker.

Local peers probably cannot keep this going. The listener is bound with
TIPC_NODE_SCOPE, and local user sockets hold a reference on the netns.

Remote peers are another matter. tipc_net_ops is registered before
tipc_topsrv_net_ops, so the bearers are still up when tipc_topsrv_stop()
runs. The TIPC_LISTEN branch of tipc_sk_filter_connect() has no scope
check. A remote node that knows the listener's port id might be able to
connect and keep sending TIPC_SUB_CANCEL requests. That precondition has
not been confirmed.

Would it work to first walk forward through all entries, using
idr_get_next() from id + 1 and closing each one? The loop could then
retry from 0 only for the entries still waiting on asynchronous release.

> +		if (con && !kref_get_unless_zero(&con->kref))
> +			con = NULL;
> +		spin_unlock_bh(&srv->idr_lock);
>  		if (con) {
> -			conn_get(con);
> -			spin_unlock_bh(&srv->idr_lock);
>  			tipc_conn_close(con);

[Severity: High]

This is a pre-existing issue, but can this call to tipc_conn_close()
dereference a NULL con->sock?

tipc_topsrv_kern_subscr() creates conn_idr entries that have no socket:

    con = tipc_conn_alloc(tipc_topsrv(net), NULL);

tipc_conn_close() dereferences the socket before it tests CF_CONNECTED:

    static void tipc_conn_close(struct tipc_conn *con)
    {
        struct sock *sk = con->sock->sk;

Other code in this file already allows for a NULL sock.
tipc_conn_kref_release() checks if (con->sock). tipc_conn_send_to_sock()
only calls tipc_conn_close() inside its if (con->sock) branch.

Here is a possible sequence:

1. tipc_topsrv_queue_evt() takes a reference on a kernel subscription
   connection K through tipc_conn_lookup(). It then queues K->swork on
   send_wq.

2. Before that work runs, the group socket is closed:
   tipc_release()->tipc_group_delete()->tipc_topsrv_kern_unsubscr().
   This clears CF_CONNECTED and drops two references. K stays in
   conn_idr, held only by the swork reference.

3. cleanup_net()->tipc_topsrv_exit_net()->tipc_topsrv_stop() runs.
   cancel_work_sync(&srv->awork) does not drain send_wq. idr_get_next()
   returns K, kref_get_unless_zero() succeeds, and tipc_conn_close(K)
   dereferences NULL.

The old idr_find() plus conn_get() loop had the same exposure. The new
loop retries until idr_in_use reaches 0, so any socketless entry still in
conn_idr is now guaranteed to reach tipc_conn_close() at least once.

This loop is being rewritten anyway. Could it skip tipc_conn_close() when
con->sock is NULL? Alternatively, tipc_conn_close() could check
con->sock before using it.

>  			conn_put(con);
> -			spin_lock_bh(&srv->idr_lock);
>  		}
> +		cond_resched();
> +		spin_lock_bh(&srv->idr_lock);
>  	}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261003192530.2414682-2-Jeremy.Jean%40oss.cyber.gouv.fr

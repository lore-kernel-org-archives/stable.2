Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A021F5821;
	Thu, 24 Sep 2026 12:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790253761; cv=none; b=Sg5wo3bTgIBJL3hqnm1nKRq28qFvkh12WPQmy9+qIBKPOv7ZUG5H5kLywtBvDTG1pg0AoiYkchgwGrlTLterCLuIRZC/0lsRXzQairShvBIY34nilGEcYgKcZfjX7CQFQ76FHYBKcgXH/aGICS2yUNkVwS5f2xDBUQbrqfvN30s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790253761; c=relaxed/simple;
	bh=DwQwcjU+xTSXEqtFzcSnsL6U7/HL+qh/ergBYUy8oKE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Bm9woGePBnaho6X5ILwkJyxLirbu6PrMh50qjdtJfx8l6DAIp63CVwUY7ZhC4imRUoAoh0Pnnk66GKPn37oRqos/bnHppwzwmNs3AyGlbIQIXLIA9AGuJH6Js/zekO7ji/1rzh7GPUiMAVlMUN9KuJdgCeMnEaWTxTVnr6jTxJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmt87+tN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmt87+tN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F49D1F000FF;
	Thu, 24 Sep 2026 12:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790253759;
	bh=v/uHTZ2wUZB6Gl2bsPRZto5m3qIxtsYlB7rWjL9hfZs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mmt87+tNFHcJpflGJ+wBE0+B2eGuqH4bARNI89Z7GuR6lnFsO1HXm9ye9EUd+3APN
	 777ot6IDtKh6aRKnveRfvAQSGnZlSHXtJIlpDdNMrtmnFZQISE4rkcfwa24dZ1yswj
	 J61TeOEGtAQXkuMAB+gxVSMUQnHLbNV+WpDh1AGGSu8iLxVyy8bb/r4N5lSQ18Dl2A
	 eXpcupWdCWlMvEayRJadKAuyJgeKe/9RQ2NrcbLeT/a02FIvVImXRFrngfovNrzASz
	 Ehb1QhQihfhrSwSmI+ICpVZHzqVnTmxSt1s70FZZKCSA/NjimSO3kyn3Jr/Z9otipA
	 KO+9kZWu1wOVQ==
Subject: Re: [PATCH net v2 2/2] tipc: make conn_idr teardown safe
From: netdev-bot+sashiko@kernel.org
To: xuyuqiabc@gmail.com
Cc: netdev@vger.kernel.org, tung.quang.nguyen@est.tech, jmaloy@redhat.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, ying.xue@windriver.com,
 parthasarathy.bhuvaragan@ericsson.com, kuniyu@google.com,
 stable@vger.kernel.org, vega@nebusec.ai, weir@nebusec.ai, xuyq21@lenovo.com
Date: Thu, 24 Sep 2026 12:42:38 +0000
Message-ID: <179025375856.2160803.8893956225555980903@kernel.org>
In-Reply-To:
 <91e85c3211fd31d24b231e8def5755c0f18b71f4.1789960909.git.xuyuqiabc@gmail.com>
References:
 <91e85c3211fd31d24b231e8def5755c0f18b71f4.1789960909.git.xuyuqiabc@gmail.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 (1) · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] tipc: priority inversion deadlock via cond_resched() in
  tipc_topsrv_stop()

Pre-existing issues:
- [High] NULL pointer dereference of con->sock in tipc_conn_close() when
  the teardown walk in tipc_topsrv_stop() reaches a socket-less…

--

tipc: make conn_idr teardown safe

The teardown walk in tipc_topsrv_stop() now iterates conn_idr with
idr_get_next() instead of incrementing a numeric ID, drops idr_lock and
reschedules when no entry can be taken, and switches from conn_get() to
kref_get_unless_zero() so an entry already being released is not revived.

> diff --git a/net/tipc/topsrv.c b/net/tipc/topsrv.c
> index 908622a3d0fca..9333e36a74de7 100644
> --- a/net/tipc/topsrv.c
> +++ b/net/tipc/topsrv.c
> @@ -710,15 +710,20 @@ static void tipc_topsrv_stop(struct net *net)
>  	cancel_work_sync(&srv->awork);
>  
>  	spin_lock_bh(&srv->idr_lock);
> -	for (id = 0; srv->idr_in_use; id++) {
> -		con = idr_find(&srv->conn_idr, id);
> -		if (con) {
> -			conn_get(con);
> +	for (id = 0; srv->idr_in_use;) {
> +		con = idr_get_next(&srv->conn_idr, &id);
> +		if (!con || !kref_get_unless_zero(&con->kref)) {
>  			spin_unlock_bh(&srv->idr_lock);
> -			tipc_conn_close(con);
> -			conn_put(con);
> +			cond_resched();
>  			spin_lock_bh(&srv->idr_lock);
> +			id = 0;
> +			continue;
>  		}
> +		id++;
> +		spin_unlock_bh(&srv->idr_lock);
> +		tipc_conn_close(con);
> +		conn_put(con);
> +		spin_lock_bh(&srv->idr_lock);
>  	}

[Severity: High]
The not-taken branch turns this walk into a poll loop whose only
forward-progress mechanism is cond_resched(). When idr_get_next()
returns NULL, or when kref_get_unless_zero() fails because the entry is
already on its way out, we drop idr_lock, call cond_resched(), reset id
to 0 and start over, and the loop only terminates once srv->idr_in_use
reaches zero. That counter is decremented in exactly one place:

net/tipc/topsrv.c:tipc_conn_kref_release() {
	spin_lock_bh(&s->idr_lock);
	idr_remove(&s->conn_idr, con->conid);
	s->idr_in_use--;
	spin_unlock_bh(&s->idr_lock);
	...
}

and in the window this branch is spinning in, the last reference is
typically held by a queued rcv_wq/send_wq item (tipc_conn_recv_work()
or tipc_conn_send_work()), i.e. by a SCHED_OTHER kworker. Note that
tipc_topsrv_work_stop() only runs after the walk, so both queues are
still live at this point, and nothing before the walk flushes them --
only srv->awork is cancelled.

So the exit condition of this loop depends on a lower-priority thread
being scheduled. cond_resched() does not yield to lower-priority tasks,
and on full-preemption builds it degenerates into a no-op, so if
tipc_topsrv_stop() is entered from an RT task (netns exit and module
unload can both be driven from a SCHED_FIFO context), on a single CPU
we spin taking and dropping idr_lock forever while the kworker that
would run tipc_conn_kref_release() and drop idr_in_use never gets to
run. That is a livelock rather than a latency glitch. The old
idr_find() loop had its own unbounded-scan problem, but it was not
structured as a retry-from-zero wait, so the patch makes cond_resched()
load-bearing as a synchronisation primitive, which it is not.

What is the intended guarantee here? If the walk really has to wait for
asynchronous releases, a sleeping wait looks more appropriate -- e.g. a
wait_event()/completion signalled from tipc_conn_kref_release() when
idr_in_use hits zero. Alternatively, would it be cleaner to tear down
rcv_wq/send_wq (tipc_topsrv_work_stop()) before walking conn_idr, so
that no async reference can still be outstanding and the loop needs no
retry branch at all? Could you spell out which of these you consider
correct, or why cond_resched() is sufficient in your view?

[Severity: High]
This isn't a bug introduced by this patch, since the old idr_find() plus
conn_get() walk fed tipc_conn_close() the same way, but can this walk hand
a socket-less conn_idr entry to tipc_conn_close() and dereference NULL?

Kernel subscriptions are published into conn_idr with sock == NULL:

net/tipc/topsrv.c:tipc_topsrv_kern_subscr() {
	...
	con = tipc_conn_alloc(tipc_topsrv(net), NULL);
	...
}

and two other users of con->sock treat it as optional:

net/tipc/topsrv.c:tipc_conn_kref_release() {
	...
	if (con->sock)
		sock_release(con->sock);
	...
}

but tipc_conn_close() dereferences it in its first statement, before
CF_CONNECTED is even tested:

net/tipc/topsrv.c:tipc_conn_close() {
	struct sock *sk = con->sock->sk;
	...
}

The ordering I think reaches this after the walk grabs a reference with
kref_get_unless_zero():

  tipc_group_create() -> tipc_topsrv_kern_subscr() creates conn X with
  sock == NULL

  a name table event runs tipc_topsrv_queue_evt(), which keeps its
  tipc_conn_lookup() reference when the work is queued:

	if (queue_work(srv->send_wq, &con->swork))
		return;

  socket close -> tipc_group_delete() -> tipc_topsrv_kern_unsubscr()
  clears CF_CONNECTED and drops its two references without waiting for
  the queued swork, so X stays in conn_idr owned by the pending work

  netns exit -> tipc_topsrv_exit_net() -> tipc_topsrv_stop() runs before
  send_wq has executed that work

Only srv->awork is cancelled before the walk, and send_wq/rcv_wq are
destroyed afterwards in tipc_topsrv_work_stop(), so is there anything that
excludes a still-queued swork keeping a sock == NULL entry alive here?
Would a check for con->sock in tipc_conn_close(), or skipping socket-less
entries in the walk, be appropriate so the three sites touching con->sock
agree?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1789960909.git.xuyuqiabc%40gmail.com

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4A7414429;
	Sun,  4 Oct 2026 13:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791121921; cv=none; b=mCBx9adqmlPoXD5jTcEpfgwgC4AO/MLcry8c0i8jzw4Kn4nHyRUYfBHcgStpFFZmVgPqLYLl0i7nOqJ/ViMydu8OCktT8iW8k90ojWN9uSu0cFnADG+soBZSkeS5x8g8AAHeBhEnuOE1VdgCsIdPOSQ+n1vWQ7VHxRWERRw6EJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791121921; c=relaxed/simple;
	bh=s0hiy5OYhz4Ndzng0x6zSqGNllf91Ny78Cz5Qjy30PI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CJzEsKbYfMcumAoTTmSBo616cqWs8MSnnYbV/uDvN7ZyFkQP/XcVU5M91PyBwrNPTVhVi/kl8+8PwqFkjVM/ukwdDnbtWXDL9nvNtYBbzFjAQ4uIbC5+b4L92Y7iOgKiNBGjwb7mOA/RpQ6t9hVr93kNY8khww8VtyKno8i9nqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IOuh0OPl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IOuh0OPl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29D891F000FF;
	Sun,  4 Oct 2026 13:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791121920;
	bh=HBxIkHX7eeDxI00ootJ3OgpFno/GRxR40OHG91yZNGE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=IOuh0OPl+clS2andzYiFK279vBmHTHGyk+C41VOGTySF+woTBE/XceHPw+cxTdTWy
	 BTYBAurz37r4QltCkNGLbEtz3Fu6yRzuXye9/2yCAoTVSedJdIJ06/DEkrWX+xA4cj
	 LDE6VUImu55+5JmY+o7Qzxt0dU4p0xaz9YQzEGLQ7Ww76mbZiX3VZ5VtxPJViin3Mh
	 Eihl9y04lWmtdA+L3uI7nYIcqfK+jXO6/BIdRzEerG0AV7KmFxouE6s6Tn/cxGaJg/
	 s55cTzgo7FpxnA0r0ilgKPCgFRMr4lU3mv4rzVtrz8Ss+dFQGenVhZIownjsNx76x+
	 U551dE8pYicJg==
Subject:
 Re: [PATCH net v13 1/2] llc: release unaccepted listener child sockets
From: netdev-bot+sashiko@kernel.org
To: zihanx@nebusec.ai
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kees@kernel.org,
 ernestas.k@iconn-networks.com, leitao@debian.org, tim.bird@sony.com,
 shuangpeng.kernel@gmail.com, luoxuanqiang@kylinos.cn, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, vega@nebusec.ai,
 root@tr0jan.top
Date: Sun, 04 Oct 2026 13:51:58 +0000
Message-ID: <179112191866.434549.16775046304606164752@kernel.org>
In-Reply-To:
 <1878b0954c763cf23bb99d7d09118eaae4588c45.1790688018.git.zihanx@nebusec.ai>
References:
 <1878b0954c763cf23bb99d7d09118eaae4588c45.1790688018.git.zihanx@nebusec.ai>
X-sashiko-severity: Critical
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider.

Critical: 1 · High: 0 · Medium: 3 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] The new established-connection lookup in the listener
  receive path does not exclude the listener, so the lookup can return…
- [Medium] The patch uses `llc_data_accept_state()` to decide that an
  unaccepted child is dead.
- [Medium] The new `llc_incoming_sock_work()` item is queued on
  `system_percpu_wq` through `schedule_work()` in…
- [Medium] A blocking accept() can fail with -EINVAL when there is no
  error.
- [Low] The patch adds listen() backlog enforcement to LLC, and the
  commit message does not say so.
- [Low] `llc_ui_connect()` now returns -EINVAL for a socket in
  TCP_LISTEN.
- [Low] This patch left stale comments.

--

llc: release unaccepted listener child sockets

This patch tracks each passive-open LLC child socket until it is accepted
or released. Children are released asynchronously through a work item
when setup fails, when the listener closes, or when the indication is
discarded. It also defers listener frame processing while userspace owns
the listener, and it stops timers synchronously before the SAP and device
references are dropped.

> diff --git a/net/llc/af_llc.c b/net/llc/af_llc.c
> index b0447c33dbf09..6a72a8a601547 100644
> --- a/net/llc/af_llc.c
> +++ b/net/llc/af_llc.c

[ ... ]

> @@ -489,6 +499,9 @@ static int llc_ui_connect(struct socket *sock, struct sockaddr_unsized *uaddr,
>  		goto out;
>  	if (unlikely(sk->sk_type != SOCK_STREAM))
>  		goto out;
> +	rc = -EINVAL;
> +	if (unlikely(sk->sk_state == TCP_LISTEN))
> +		goto out;

[Severity: Low]
This isn't a bug, but connect() on a listening LLC socket now returns
-EINVAL. Before this patch it went ahead and turned the listener into a
connecting socket.

Rejecting it seems reasonable. Could the commit message mention this
userspace-visible change? It currently covers only accept, release,
receive and timer handling.

>  	rc = -EALREADY;
>  	if (unlikely(sock->state == SS_CONNECTING))
>  		goto out;

[ ... ]

> @@ -718,10 +731,19 @@ static int llc_ui_accept(struct socket *sock, struct socket *newsock,
>  		llc_sk(sk)->laddr.lsap);
>  	skb = skb_dequeue(&sk->sk_receive_queue);
>  	rc = -EINVAL;
> -	if (!skb->sk)
> +	if (!skb || !skb->sk || skb->sk == sk)
>  		goto frees;

[Severity: Medium]
Can a blocking accept() return -EINVAL here when nothing has actually
gone wrong?

The skb_queue_empty()/llc_wait_data() check and the skb_dequeue() are
separate steps. Holding the listener with lock_sock() does not stop
softirq processing of child frames.

A DISC for a QUEUED child is handled in llc_conn_handler() while holding
only the child's bh lock:

llc_conn_handler()
  llc_conn_rcv(child)
    llc_conn_state_process()
      llc_release_incoming_sock()
        llc_remove_incoming_skb()  <- unlinks from listener->sk_receive_queue

If that was the only queued indication, skb_dequeue() returns NULL. The
new !skb check then jumps to frees with rc = -EINVAL.

Should accept() wait again here? Or should it at least return
-ECONNABORTED, as the aborted-child path just below does?

[ ... ]

> diff --git a/net/llc/llc_conn.c b/net/llc/llc_conn.c
> index 260460d50f54c..349a7c5b9bb1a 100644
> --- a/net/llc/llc_conn.c
> +++ b/net/llc/llc_conn.c

[ ... ]

> @@ -69,6 +70,15 @@ int llc_conn_state_process(struct sock *sk, struct sk_buff *skb)
>  		goto out_skb_put;
>  	}
>  
> +	/*
> +	 * An unaccepted child that leaves a data-accepting state cannot be
> +	 * delivered by accept(). Release it before processing the indication.
> +	 */
> +	if (unlikely(atomic_read(&llc->incoming_state) ==
> +		     LLC_INCOMING_QUEUED &&
> +		     llc_data_accept_state(READ_ONCE(llc->state))))
> +		llc_release_incoming_sock(skb->sk);

[Severity: Medium]
Is llc_data_accept_state() the right test for deciding that an unaccepted
child is dead?

Its kernel-doc says it tells whether data can be sent in a given state.
It returns true for every state except NORMAL, BUSY and REJ:

	return state != LLC_CONN_STATE_NORMAL && state != LLC_CONN_STATE_BUSY &&
	       state != LLC_CONN_STATE_REJ;

That also covers the connected checkpoint states AWAIT, AWAIT_BUSY and
AWAIT_REJ, plus ERROR and RESET.

For example, suppose the peer sends RNR. llc_conn_ac_set_remote_busy()
arms busy_state_timer. When the timer fires, llc_normal_state_trans_20b
moves the child from NORMAL to AWAIT:

llc_process_tmr_ev()
  llc_conn_state_process()
    llc_conn_service()          <- NORMAL -> AWAIT
    llc_data_accept_state()     <- true
    llc_release_incoming_sock()

The child is set to OUT_OF_SVC and unhashed. Its indication is removed
from the listener queue and the child is freed, and no DISC or DM is
sent. The peer still considers the link up. Without this check,
llc_await_state_trans_8a would have moved the connection back to NORMAL
once the poll was answered.

llc_accept_incoming_sock() uses the same test, so accept() would return
-ECONNABORTED for a child that is only in a checkpoint state.

The commit message says:

    Release an unaccepted child as soon as the connection state machine moves it
    out of a data-accepting state, so a peer disconnect cannot keep an unusable
    child in the listener accept queue.

Should this test only for states where the connection is actually gone,
such as ADM?

> +
>  	switch (ev->ind_prim) {
>  	case LLC_DATA_PRIM:
>  		skb_get(skb);
> @@ -87,7 +97,18 @@ int llc_conn_state_process(struct sock *sk, struct sk_buff *skb)
>  		 * Can't be sock_queue_rcv_skb, because we have to leave the
>  		 * skb->sk pointing to the newly created struct sock in
>  		 * llc_conn_handler. -acme

[Severity: Low]
This isn't a bug, but two comments are now out of date. This one and the
-acme block in llc_conn_handler() still say the child is created in
llc_conn_handler(). With this patch, creation can be deferred to
llc_backlog_rcv() through llc_conn_rcv_listener().

The llc_backlog_rcv() kernel-doc also does not mention the new child
creation path.

Later in the series, "llc: create listener children only for SABME"
rewrites both comments to name llc_conn_rcv_sabme(). After that, only
the incomplete llc_backlog_rcv() kernel-doc would remain.

[ ... ]

> @@ -755,37 +776,257 @@ static struct sock *llc_create_incoming_sock(struct sock *sk,

[ ... ]

> +static int llc_conn_rcv_listener(struct sock *sk, struct sk_buff *skb,
> +			       struct llc_addr *saddr,
> +			       struct llc_addr *daddr)
> +{
> +	struct sock *newsk;
> +	int rc = 0;
> +
> +	local_bh_disable();
> +	newsk = __llc_lookup_established(llc_sk(sk)->sap, saddr, daddr,
> +					 dev_net(skb->dev));
> +	if (newsk) {
> +		sock_put(newsk);
> +		goto drop;
> +	}

[Severity: Critical]
Can __llc_lookup_established() return the listener itself here?

llc_estab_match() compares only the netns, the local and remote LSAPs,
and the local and remote MACs. It does not skip TCP_LISTEN sockets:

	return net_eq(sock_net(sk), net) &&
	       llc->laddr.lsap == laddr->lsap &&
	       llc->daddr.lsap == daddr->lsap &&
	       ether_addr_equal(llc->laddr.mac, laddr->mac) &&
	       ether_addr_equal(llc->daddr.mac, daddr->mac);

A listener's llc->daddr is all zeroes after allocation. Its only writer
is llc_ui_connect(), and the value is never cleared, even when connect()
fails and the socket is then passed to listen():

	llc->daddr.lsap = addr->sllc_sap;
	memcpy(llc->daddr.mac, addr->sllc_mac, IFHWADDRLEN);

So for a listener bound to the device MAC, the lookup would match the
listener for either:

  - a SABME from the peer that an earlier failed connect() targeted, or
  - on a never-connected listener, a frame with source MAC
    00:00:00:00:00:00 and SSAP 0.

In that case llc_conn_rcv_listener() treats the hit as an existing
connection and drops every retry, so that peer can never connect.
Before this patch, a child was created.

Later in the series, "llc: create listener children only for SABME"
changes this hit to call llc_conn_rcv_existing_sabme(sk, newsk, skb)
with newsk == sk. That function starts with bh_lock_sock_nested(newsk),
but llc_conn_handler() already holds bh_lock_sock(sk) on the same
socket:

llc_conn_handler()
  bh_lock_sock(sk)
  llc_conn_rcv_sabme()
    __llc_lookup_established()     <- returns sk
    llc_conn_rcv_existing_sabme()
      bh_lock_sock_nested(sk)      <- same slock

Wouldn't that self-deadlock in softirq? Any L2-adjacent host could
trigger it with a spoofed frame. Should the lookup skip newsk == sk, or
should llc_estab_match() skip TCP_LISTEN sockets?

> +	if (sk_acceptq_is_full(sk))
> +		goto drop;

[Severity: Low]
This isn't a bug, but this adds listen() backlog enforcement that LLC did
not have before, and the commit message does not mention it.

In the baseline, llc_ui_listen() stored sk_max_ack_backlog but nothing
ever checked it. llc_ui_accept() also called sk_acceptq_removed() with
no matching add, so the counter underflowed.

With this patch, listener frames are dropped once the backlog is full.
Released children also keep their slot until llc_incoming_sock_work()
runs.

The commit message only says "update the accept backlog". Since this is
tagged for stable, could it say that connection attempts beyond the
listen() backlog are now dropped, and that the old underflow is fixed?

[ ... ]

> +static void llc_incoming_sock_work(struct work_struct *work)
> +{

[ ... ]

> +	netdev_put(dev, &llc->dev_tracker);
> +	llc_sk_free(sk);
> +	llc_sap_put(sap);
> +	if (listener) {
> +		lock_sock(listener);
> +		sk_acceptq_removed(listener);
> +		release_sock(listener);
> +		sock_put(listener);
> +	}
> +}

[Severity: Medium]
Can this work item still be running llc2 module code after the module has
been freed?

llc_release_incoming_sock() queues incoming_work on system_percpu_wq
with schedule_work(). Nothing in llc2_exit() flushes or cancels it.

At the end of llc_incoming_sock_work(), llc_sk_free(sk) and
sock_put(listener) can drop the last LLC socket reference. llc_proto.owner
is THIS_MODULE, so the final sock_put() runs sk_prot_free() ->
module_put() synchronously. At that point the worker is still executing
llc_incoming_sock_work() in llc2.ko text.

On a preemptible kernel, the worker can be preempted after the last
sock_put(). If rmmod llc2 completes in that window, the worker resumes
in freed module text. The synchronize_rcu() in free_module() does not
wait for a preempted task that is outside an RCU read-side section.

Would a dedicated workqueue that llc2_exit() destroys, or a flush in
llc2_exit(), close this window?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1790688018.git.zihanx%40nebusec.ai

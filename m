Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794531258;
	b=yzODuQczb6E2xaGq4EmdTn9o4age1iB/w51+uiydwvWa7Mv/iHbvrdkyKYrhwZqcGORg
	 d6QilmIGxleSDQkdcoR5SAWprMN1iOWXJocUmHxS/PqCeFk/EkVYhLcRts5MZPOkOJHrp
	 VaG/dC40Ez5MlEQHVK+NokvH+/K8gVb2r3MLjmdj7lXcW0Wg/uOmFql5hIMULOfSumWwE
	 a8cS/ho7Y3KYsclx4TK5YeWrgkZYm69hfeZ6eDaEtexbwB405FYYrDcUShIkdipCqnMf4
	 2CX5vzoicnJMk/vud9TnsGSmkvK2xwimtw3UdyNUH5ZAff2TF971kFDvTkFrIu8I5Qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794531258;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=TLuqgOf8yuQXygKb7frN/8bWRZkfHqL8O+w/0iFk9+g=;
	b=BxiOtMk8QHgD+zuA87salJEfpoYoH/iJ+xmVEKOQOCfUHuV9bCFvGnMXv4viRvGxp3Dt
	 1gLDCTPCRoMj7aQLxwOuny0VPfvuH5KIpBcKsMW0sVaztlqsgdCZ9SPyh64GNSzOYEfZz
	 bguM6EX5bOWID+nZsPhQawkMPIvxjD8EMi8mogikcMl5/3LAficDs/RPUJrwkqA+g1lfv
	 +OfSqdh26hh2zCObfhSYweRMq6eGah1NV3yYQeeXnGDB4v2U/UVhWC6S8mlM6l7FDOJWR
	 b1Ais/ENZ3Y6pbj83NjS5JeOQ2b0dsIWxwUgtrz4w1idMIkSkzHe+J3t3Qpe/Sll9Zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="S70gd/T6";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0A8606A896;
	Fri, 13 Nov 2026 00:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S70gd/T6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 611311F000C4;
	Fri, 13 Nov 2026 00:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794531258;
	bh=TLuqgOf8yuQXygKb7frN/8bWRZkfHqL8O+w/0iFk9+g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=S70gd/T6zkUOOVapfOB0CwYozNrlb4jhLWTx0sl1mWIrMT/8PwM++B4SDyI6gS7Mh
	 Yo2A5simhzlo8Y4Qz7nA5ircPl4egd0eUrxQ+K5ZFeznXvTIB/MRjJX/NGF1VuH/wO
	 G80jfDBvwcZ7qt1TLRcC4ntXFk95PShk6NZrMID9vvAeRVmH+KfE8sByMBkO30guvg
	 +mlAK84bzF8/zV/nbhhLYJRqCn3Lq83LM2GY9O/pue0Hx7EoHDqGpRxPGCr28/NS7J
	 bspRfqREa7vMgaJeWopEclaAQjpATJBKjvZZ39rYxQCN5gyRuh0M1vk7x82gSGSxrL
	 9mbx2QgwN3ilw==
Subject: Re: [PATCH net v9 1/4] can: j1939: serialize cancel and rearm of the
 receive timer
From: netdev-bot+sashiko@kernel.org
To: chaosheng.qu.linux@gmail.com
Cc: robin@protonic.nl, o.rempel@pengutronix.de, socketcan@hartkopp.net,
 mkl@pengutronix.de, kernel@pengutronix.de, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, kuba@kernel.org
Date: Fri, 13 Nov 2026 00:54:16 +0000
Message-ID: <179453125694.488853.2205573161282115259@kernel.org>
In-Reply-To: <20261111-j1939-edpo-v9-v9-1-e779ca334a81@163.com>
References: <20261111-j1939-edpo-v9-v9-1-e779ca334a81@163.com>
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 3 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The rxtimer can still be armed twice, so the session reference
  still leaks.
- [Medium] The patch makes functional changes the commit message does not
  mention, and one statement in the message is wrong.
- [Medium] j1939_session_cancel() now always deactivates a session that
  is already in J1939_SESSION_WAITING_ABORT, whether or not the caller…
- [Medium] can: j1939: race on session->state in j1939_tp_rxtimer()

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the txtimer
  has the same 'hrtimer_start() on an already armed timer leaks the…

--

can: j1939: serialize cancel and rearm of the receive timer

This patch adds j1939_tp_arm_rxtimer_locked(), which cancels and rearms
the session rxtimer under active_session_list_lock using
hrtimer_try_to_cancel(). It also makes j1939_session_cancel()
force-deactivate sessions that are already in WAITING_ABORT. The
second-RTS path in j1939_xtp_rx_rts_session_active() now always
deactivates the session.

> diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> index 8fcfd13e5e6f8..fa23260e1833f 100644
> --- a/net/can/j1939/transport.c
> +++ b/net/can/j1939/transport.c
> @@ -721,15 +721,42 @@ void j1939_tp_schedule_txtimer(struct j1939_session *session, int msec)
>  		      HRTIMER_MODE_REL_SOFT);
>  }
>  

[Severity: High]
This isn't a bug introduced by this patch, but does the txtimer have the
same leak that this patch is trying to close for the rxtimer?

j1939_tp_schedule_txtimer() always takes a reference and calls
hrtimer_start(). It never drops a reference held by an earlier arm:

net/can/j1939/transport.c:j1939_tp_schedule_txtimer() {
	j1939_session_get(session);
	hrtimer_start(&session->txtimer, ms_to_ktime(msec),
		      HRTIMER_MODE_REL_SOFT);
}

On the receiver side, j1939_xtp_rx_dat_one() calls it without any cancel
when a DAT frame completes a block:

	} else if (do_cts_eoma) {
		j1939_tp_set_rxtimeout(session, 1250);
		if (!session->transmission)
			j1939_tp_schedule_txtimer(session, 0);

Suppose the peer resends the block-ending DAT before the soft txtimer has
run. The duplicate passes the checks: pkt.rx is not incremented, but
pkt.rx >= pkt.last still holds. So do_cts_eoma is set again and
j1939_tp_schedule_txtimer() runs a second time.

The txtimer can still be queued at that point in two ways:

  - both frames were handled in the same NET_RX softirq batch, or
  - a CTS send hit -ENOBUFS and the 10-25 ms retry from j1939_tp_txtimer()
    is pending.

Would the second hrtimer_start() then reprogram the queued timer? That
would leave one session reference, and its netdev_hold() reference, that
is never put.

j1939_xtp_rx_cts_one() and the RTS path have a similar pattern. They call
j1939_session_txtimer_cancel() and then j1939_tp_schedule_txtimer(), with
nothing serializing the two calls.

> -static inline void j1939_tp_set_rxtimeout(struct j1939_session *session,
> -					  int msec)
> +/*
> + * Rearm the receive timer as one step under active_session_list_lock.
> + *

[ ... ]

> + * hrtimer_try_to_cancel() does not wait for a running callback, so it can be
> + * called with the lock held even though j1939_tp_rxtimer() takes the same
> + * lock; a callback that is already running drops its own reference.  For the
> + * same reason the return value is only 1 when the timer was queued: when this
> + * runs from j1939_tp_rxtimer() itself, the timer is no longer queued and 0 is
> + * the expected result.
> + */
> +static void j1939_tp_arm_rxtimer_locked(struct j1939_session *session, int msec)
>  {
> -	j1939_session_rxtimer_cancel(session);
> +	if (hrtimer_try_to_cancel(&session->rxtimer) == 1)
> +		j1939_session_put(session);
> +
>  	j1939_session_get(session);
>  	hrtimer_start(&session->rxtimer, ms_to_ktime(msec),
>  		      HRTIMER_MODE_REL_SOFT);
>  }

[Severity: High]
Can the rxtimer still be armed twice while j1939_tp_rxtimer() is running?

hrtimer_try_to_cancel() returns -1 whenever the callback is running. In
that case it does not dequeue the timer, even if the timer has been
requeued:

kernel/time/hrtimer.c:hrtimer_try_to_cancel() {
	...
	if (!hrtimer_callback_running(timer)) {
		ret = remove_hrtimer(timer, base, HRTIMER_STATE_INACTIVE);
	...
}

A timer that is rearmed during its own callback stays on the running base.
switch_hrtimer_base() returns early when hrtimer_callback_running() is
true. So every arm during one callback window sees -1 and takes a fresh
reference.

One possible sequence:

CPU A (rxtimer softirq)
j1939_tp_rxtimer()
  session is J1939_SESSION_ACTIVE, takes the else branch
  j1939_session_list_lock() spins

CPU B (CAN rx softirq, CTS/DAT/DPO from the peer)
j1939_tp_set_rxtimeout()
  j1939_session_list_lock()
  hrtimer_try_to_cancel() == -1, no put
  j1939_session_get()
  hrtimer_start()                 <- timer queued, holds a ref
  j1939_session_list_unlock()

CPU A
  takes the lock, state still < J1939_SESSION_ACTIVE_MAX
  j1939_tp_arm_rxtimer_locked()
    hrtimer_try_to_cancel() == -1, no put
    j1939_session_get()
    hrtimer_start()               <- reprograms the queued timer

That takes two references, but only one expiry will put one. Would that
leak the session and its netdev_hold() reference? If so,
unregister_netdevice() would wait forever for canX to become free.

The same thing looks possible in two other cases:

  - CPU B is j1939_session_cancel() called from j1939_tp_txtimer().
    J1939_SESSION_WAITING_ABORT also passes the
    < J1939_SESSION_ACTIVE_MAX check.
  - Two rx-path j1939_tp_set_rxtimeout() calls happen during one rxtimer
    callback window, for example while the callback spins on the lock in
    its WAITING_ABORT branch.

Before this patch, j1939_tp_set_rxtimeout() used hrtimer_cancel(). That
waited for the callback and then removed the timer the callback had
rearmed, returning 1 and dropping the reference. So the race between the
rx handler and the rx timeout callback used to be balanced. Does this
patch add a new way to hit the leak?

The comment above the helper also says:

    when this runs from j1939_tp_rxtimer() itself, the timer is no longer
    queued and 0 is the expected result.

Is that accurate? hrtimer_active() is true while base->running == timer.
So the result from inside the callback is -1, and another CPU may already
have queued the timer.

Does this need something other than the try_to_cancel() return value? For
example, an armed flag kept under active_session_list_lock, or a
hrtimer_is_queued() check in the -1 case. The later patches in this series
don't appear to touch j1939_tp_arm_rxtimer_locked().

> +static inline void j1939_tp_set_rxtimeout(struct j1939_session *session,
> +					  int msec)
> +{
> +	j1939_session_list_lock(session->priv);
> +	j1939_tp_arm_rxtimer_locked(session, msec);
> +	j1939_session_list_unlock(session->priv);
> +}
> +

[ ... ]

> @@ -1161,18 +1188,29 @@ static void __j1939_session_cancel(struct j1939_session *session,
>  static void j1939_session_cancel(struct j1939_session *session,
>  				 enum j1939_xtp_abort err)
>  {
> +	bool waiting;
> +
>  	j1939_session_list_lock(session->priv);
>  
> +	waiting = session->state == J1939_SESSION_WAITING_ABORT;
>  	if (session->state >= J1939_SESSION_ACTIVE &&
>  	    session->state < J1939_SESSION_WAITING_ABORT) {
> -		j1939_tp_set_rxtimeout(session, J1939_XTP_ABORT_TIMEOUT_MS);
>  		__j1939_session_cancel(session, err);
> +		j1939_tp_arm_rxtimer_locked(session, J1939_XTP_ABORT_TIMEOUT_MS);
>  	}
>  
>  	j1939_session_list_unlock(session->priv);
>  
>  	if (!session->sk)
>  		j1939_sk_errqueue(session, J1939_ERRQUEUE_RX_ABORT);
> +
> +	/* The abort already went out on an earlier call, so this one armed no
> +	 * timer.  Several callers cancel the timers before calling here, which
> +	 * would otherwise leave the session on the list with nothing to finish
> +	 * it off, so deactivate it now.
> +	 */
> +	if (waiting)
> +		j1939_session_deactivate_activate_next(session);
>  }

[Severity: Medium]
Can this deactivation leave a queued abort rxtimer on a session that is
already J1939_SESSION_DONE?

The comment says several callers cancel the timers first. The callers in
j1939_tp_txtimer() don't:

	case -EOVERFLOW:
		j1939_session_cancel(session, J1939_XTP_ABORT_ECTS_TOO_BIG);
	...
	default:
		...
		if (session->skcb.addr.type != J1939_SIMPLE) {
			j1939_session_cancel(session, J1939_XTP_ABORT_OTHER);

Take a receiver session with the txtimer armed:

  1. The rxtimer times out first. j1939_tp_rxtimer() sets WAITING_ABORT
     and arms the abort rxtimer, but leaves the txtimer alone.
  2. The txtimer runs j1939_xtp_txnext_receiver(). An error such as
     -ENOENT from j1939_sk_recv_match(), after the receiving socket is
     closed, reaches the default case.
  3. j1939_session_cancel() sees waiting == true and deactivates the
     session at once. That skips the J1939_XTP_ABORT_TIMEOUT_MS wait and
     activates the next queued session early.
  4. The stale abort rxtimer fires later. The state is
     J1939_SESSION_DONE, so it skips the WAITING_ABORT branch and lands
     in the rx timeout else branch:

		j1939_session_list_unlock(session->priv);

		if (!session->sk)
			j1939_sk_errqueue(session, J1939_ERRQUEUE_RX_ABORT);

Would the receiving sockets then get a second RX_ABORT errqueue
notification? Before this patch, that timer took the WAITING_ABORT branch
and deactivated the session silently.

>  
>  static enum hrtimer_restart j1939_tp_txtimer(struct hrtimer *hrtimer)
> @@ -1279,10 +1317,8 @@ static enum hrtimer_restart j1939_tp_rxtimer(struct hrtimer *hrtimer)
>  		    session->state < J1939_SESSION_ACTIVE_MAX) {
>  			netdev_alert(priv->ndev, "%s: 0x%p: rx timeout, send abort\n",
>  				     __func__, session);
> -			j1939_session_get(session);
> -			hrtimer_start(&session->rxtimer,
> -				      ms_to_ktime(J1939_XTP_ABORT_TIMEOUT_MS),
> -				      HRTIMER_MODE_REL_SOFT);
> +			j1939_tp_arm_rxtimer_locked(session,
> +						    J1939_XTP_ABORT_TIMEOUT_MS);
>  			__j1939_session_cancel(session, J1939_XTP_ABORT_TIMEOUT);
>  		}
>  		j1939_session_list_unlock(session->priv);
> @@ -1729,16 +1765,10 @@ static int j1939_xtp_rx_rts_session_active(struct j1939_session *session,
>  
>  		j1939_session_timers_cancel(session);
>  		j1939_session_cancel(session, J1939_XTP_ABORT_BUSY);
> -		if (session->transmission) {
> -			j1939_session_deactivate_activate_next(session);
> -		} else if (session->state == J1939_SESSION_WAITING_ABORT) {
> -			/* Force deactivation for the receiver.
> -			 * If we rely on the timer starting in j1939_session_cancel,
> -			 * a second RTS call here will cancel that timer and fail
> -			 * to restart it because the state is already WAITING_ABORT.
> -			 */
> -			j1939_session_deactivate_activate_next(session);
> -		}
> +		/* Both roles: the peer is restarting the transfer, so free the
> +		 * slot now rather than wait out the abort timeout.
> +		 */
> +		j1939_session_deactivate_activate_next(session);

[Severity: Medium]
Can j1939_tp_rxtimer() act on a session->state value that a
concurrent j1939_session_cancel() changes underneath it?

The WAITING_ABORT test at the top of the callback runs without
holding active_session_list_lock:

	if (session->state == J1939_SESSION_WAITING_ABORT) {
		...
		j1939_session_deactivate_activate_next(session);

Before this patch, j1939_session_cancel() went through
j1939_tp_set_rxtimeout(). Its hrtimer_cancel() waited for a running
rxtimer callback before __j1939_session_cancel() changed the state,
at the risk of the deadlock the commit message describes.

The new helper uses hrtimer_try_to_cancel(), which returns -1 and
carries on. So j1939_session_cancel() called from j1939_tp_txtimer()
(the -EOVERFLOW and default cases) can now change the state while an
expiring rxtimer callback sits between its unlocked state check and
taking the lock.

Two orderings look possible. In the first one:

CPU A (rxtimer softirq)              CPU B (txtimer softirq)
j1939_tp_rxtimer()                   j1939_session_cancel()
                                       j1939_session_list_lock()
                                       __j1939_session_cancel()
                                         state = WAITING_ABORT
                                       j1939_tp_arm_rxtimer_locked()
                                         abort rxtimer queued
                                       j1939_session_list_unlock()
  state == WAITING_ABORT
  j1939_session_deactivate_activate_next()

Here the expiry of the old rx timeout is treated as the expiry of the
abort timeout. As a result:

  - the session is deactivated at once,
  - the next queued session is activated early, and
  - the abort rxtimer CPU B just armed stays queued on a
    J1939_SESSION_DONE session.

When that timer fires, it falls into the rx timeout else branch and
calls j1939_sk_errqueue() again.

In the other ordering, CPU A reads J1939_SESSION_ACTIVE first, takes
the else branch and spins on the lock while CPU B runs the same
steps. Once CPU A gets the lock, the test
session->state < J1939_SESSION_ACTIVE_MAX still passes for
J1939_SESSION_WAITING_ABORT. CPU A then rearms the rxtimer a second
time, which is the same double reference described above, and calls
__j1939_session_cancel() again. That:

  - sends a second abort frame to the peer,
  - overwrites session->err with the errno for
    J1939_XTP_ABORT_TIMEOUT instead of the error CPU B reported, and
  - calls j1939_sk_send_loop_abort() a second time.

j1939_session_cancel() limits its check to state <
J1939_SESSION_WAITING_ABORT. Should the else branch here use the same
bound? And should the WAITING_ABORT test at the top of the callback be
made under active_session_list_lock, so the callback only acts on a
state it holds the lock for?

[Severity: Medium]
The commit message doesn't seem to describe some of the functional
changes in this patch. That may matter for the Cc: stable backport.

The new waiting logic in j1939_session_cancel() force-deactivates sessions
that are already in WAITING_ABORT. That looks like a fix for a separate
session/netdev refcount leak:

  - j1939_xtp_rx_cts_one(), j1939_xtp_rx_dat_one() and
    j1939_xtp_rx_rts_session_active() call j1939_session_timers_cancel()
    and then j1939_session_cancel() on a session that is already aborting.
  - Before this patch, nothing was left to deactivate that session.

It also changes teardown timing for every caller of
j1939_session_cancel(). Could this be split out, or at least described in
the commit message?

This hunk replaces the role-specific logic and comment added by commit
1809c82aa073 ("net: can: j1939: j1939_xtp_rx_rts_session_active():
deactivate session upon receiving the second rts"), but doesn't refer to
that commit.

For receivers, isn't this explicit deactivate now a no-op? The waiting
branch in j1939_session_cancel() has already deactivated the session.

The commit message also says:

    j1939_session_cancel() calls the helper instead of hand-rolling
    get + hrtimer_start()

Before this patch, j1939_session_cancel() called j1939_tp_set_rxtimeout()
with the lock held. Only j1939_tp_rxtimer() open-coded the get +
hrtimer_start() sequence.

The helper is also called after __j1939_session_cancel() in
j1939_session_cancel(), but before it in j1939_tp_rxtimer(). Is there a
reason for the different order?

>  
>  		return -EBUSY;
>  	}

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261111-j1939-edpo-v9-v9-0-e779ca334a81%40163.com

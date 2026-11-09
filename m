Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794209643;
	b=zKhXnc9P79h0P+WDH5v66nh4PGP37ITQtqcKTihMkDV5FDAvT0TgV/E5F5uiY3zdMSs1
	 8yruJiUhUb+AZeV8Lb9ydU/9/rh75egWIJ2WqPIyOvBz746HM0IYLtzZNai0RZxOc5Ktm
	 1sVO5PVhwyed7DN466qh5un4Nkpqezuilty9BW5tfiJCv3OUhV1j/FjHuDlIhFobAO5dn
	 7lAuXw/nGrNYjdvXak0xnmwg4sGjvAmE7G0aSOM0WIfSi1R1HOyq1xCldt50wAZ8JyRgH
	 hwxEBzly0g9KNOVQChwfDzpsJHX34+YaaXdJjpPeRJ/feqNGbAyzjemH0O0wJBeh9lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794209643;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=xUomCp3G+LfMvtKyqhwJAVOlhjISvM2EjbUQ5TP+saA=;
	b=yL7R+jADtsYkT/VTDThpoFHoZD03tOnQRV/imdXfJN+EEA6k3QkquRNHd33Jx3jL0ECm
	 kmJJ2ewcm+2hMl7vqzHc/LTrewqIsnyrLpQQX5NQCDjEMTQ3cppfDVPJeJ1dD89Flznar
	 sL8HEjEHKRYd+EpQTlHHImZqQwqkol0TnjvLT1kJiQyk5JHxkg2FxInW4E00rV/ph+JrE
	 LmLeLfsdf9uwiIKHvcDf1Lf60TLgrnlkG2hik7KLEUZ8ZkoikZ39Ih5fKoPUIqyPdAPwf
	 Anz1FSJ6M59j4dmYgNyWOvptBzGLxDW2y7k7A9Hvo67vpxg7aspOZ25XdC4B8ahvGUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ofYQ8dJQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55834606A322;
	Mon,  9 Nov 2026 07:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ofYQ8dJQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4410E1F008A1;
	Mon,  9 Nov 2026 07:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794209641;
	bh=xUomCp3G+LfMvtKyqhwJAVOlhjISvM2EjbUQ5TP+saA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ofYQ8dJQMRuSeejKWpsw2KtfaUmurR0LF1MhBod/ZZ3P41TEG4wozg3N48S1aJCzj
	 t9AFBk0ss8klUBmdyPyZclxYESs+j2fT7t1S4CZHEjM1e7dUg2McfxayuCgd7mgkL4
	 0gGmxlmPx/hQsgmz69CaRYPukLtkGR2DCJqzdMQCfv7b6rWiDA+IYM0Do96/wNxA4X
	 Wa2IwtHgwzQ+1U0/2bokoAB8eROTfoR0pJ4MfgoUp/dC9A3HsrClmwbqTYQVGpugnD
	 SQBQ9ImMZIS5t5PrlkBjLj1hNCbvyV0nw8ClQHEQANbUPZXPpFCsVzam2l8TjhxLJQ
	 rVendOyk+RUmg==
Subject: Re: [PATCH net] can: j1939: transport: validate the DPO packet offset
From: netdev-bot+sashiko@kernel.org
To: sunyiqi2@huawei.com
Cc: robin@protonic.nl, o.rempel@pengutronix.de, kernel@pengutronix.de,
 socketcan@hartkopp.net, mkl@pengutronix.de, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, stable@vger.kernel.org,
 luoxiaoxing@huawei.com, kuba@kernel.org
Date: Mon, 09 Nov 2026 07:34:00 +0000
Message-ID: <179420964075.994134.5840863564858819241@kernel.org>
In-Reply-To: <20261105065931.1302-1-sunyiqi2@huawei.com>
References: <20261105065931.1302-1-sunyiqi2@huawei.com>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] When a second out-of-range ETP DPO arrives, the new bad-offset
  branch in j1939_xtp_rx_dpo_one() (net/can/j1939/transport.c) cancels…

--

can: j1939: transport: validate the DPO packet offset

This patch makes j1939_xtp_rx_dpo_one() check the packet offset from a
received ETP DPO against session->pkt.total. An offset that is out of
range is rejected and the session is aborted with
J1939_XTP_ABORT_BAD_EDPO_OFFSET. This prevents a NULL skb from reaching
j1939_sk_recv() when a later EOMA arrives.

> diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> index 8fcfd13e5e6f8..bda50432a72ea 100644
> --- a/net/can/j1939/transport.c
> +++ b/net/can/j1939/transport.c
> @@ -1823,14 +1823,22 @@ static void j1939_xtp_rx_dpo_one(struct j1939_session *session,

[ ... ]

> +	packet = j1939_etp_ctl_to_packet(skb->data);
> +	if (packet >= session->pkt.total) {
> +		j1939_session_timers_cancel(session);
> +		j1939_session_cancel(session, J1939_XTP_ABORT_BAD_EDPO_OFFSET);
> +		return;
> +	}

[Severity: High]
What happens if a second out-of-range DPO arrives while the session is
already in J1939_SESSION_WAITING_ABORT?

After the first bad DPO, j1939_session_cancel() arms the abort rxtimer
and moves the session to WAITING_ABORT. The session stays on
priv->active_session_list. j1939_session_get_by_addr_locked() does not
filter on state, so j1939_xtp_rx_dpo() can still find it.

If a second bad DPO comes in before J1939_XTP_ABORT_TIMEOUT_MS expires,
this branch runs:

j1939_xtp_rx_dpo_one()
  j1939_session_timers_cancel()
    j1939_session_rxtimer_cancel()
      hrtimer_cancel(&session->rxtimer)   <- pending abort timer removed
      j1939_session_put(session)
  j1939_session_cancel()
    if (session->state >= J1939_SESSION_ACTIVE &&
        session->state < J1939_SESSION_WAITING_ABORT) {
        ...                              <- skipped, already WAITING_ABORT
    }

j1939_tp_rxtimer() is the only timeout path that deactivates a session
in WAITING_ABORT:

    if (session->state == J1939_SESSION_WAITING_ABORT) {
        ...
        j1939_session_deactivate_activate_next(session);

Once its timer has been cancelled, that path cannot run. Does the
session then stay on the active list for good, still holding its
reassembly skb and its netdev and j1939_priv references?

Every repeated bad DPO would also queue another J1939_ERRQUEUE_RX_ABORT.

Before this patch, a DPO in WAITING_ABORT only called
j1939_tp_set_rxtimeout(session, 750). That re-armed rxtimer, so the
session was still deactivated later.

j1939_xtp_rx_rts_session_active() already documents this hazard and
works around it:

    } else if (session->state == J1939_SESSION_WAITING_ABORT) {
        /* Force deactivation for the receiver.
         * If we rely on the timer starting in j1939_session_cancel,
         * a second RTS call here will cancel that timer and fail
         * to restart it because the state is already WAITING_ABORT.
         */
        j1939_session_deactivate_activate_next(session);

That workaround came from commit 1809c82aa073 ("net: can: j1939:
j1939_xtp_rx_rts_session_active(): deactivate session upon receiving
the second rts"). It fixed a syzbot refcount leak that showed up as
"unregister_netdevice: waiting for vcan0 to become free".

Any of these could avoid the problem:

- Return early when session->state >= J1939_SESSION_WAITING_ABORT.

- Cancel only the txtimer here. j1939_session_cancel() already cancels
  and re-arms rxtimer through j1939_tp_set_rxtimeout().

- Force j1939_session_deactivate_activate_next() when the state is
  already WAITING_ABORT, as the RTS path does.

The out_session_cancel paths in j1939_xtp_rx_cts_one() and
j1939_xtp_rx_dat_one() use the same cancel-then-noop sequence, so a
shared helper might be a better fix.

>  	/* transmitted without problems */
> -	session->pkt.dpo = j1939_etp_ctl_to_packet(skb->data);
> +	session->pkt.dpo = packet;
>  	session->last_cmd = dat[0];
>  	j1939_tp_set_rxtimeout(session, 750);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261105065931.1302-1-sunyiqi2%40huawei.com

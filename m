Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795040361;
	b=oEHXwdX9aizVO39++jjDeXBNc9Mr7UycIBXn/bYPXJNIWxl/oB+Luz+Qvl1XX7hGC9tv
	 N3CpTo6I6TpzKPXbh0rCsx/MddSWXV0kyoylYvoKzUFtfKKNJGTA2eDaJdMZ+M6uaI95M
	 1t4chzwYbCKQ6jNnYl6pMLaSZaelF4cgogy0hMJhCEno2UoyPBuy0Bzpp/hx1CpPRn3rg
	 gmRvAHMTgtEI6sbQ3lROd2vsmd4id2pWiciChZV62cZFs4Sq9xbf6R4yzdSpnwP1XpTzS
	 BamiqiJhrCHyvUKAstjrQrCDNLO0i7BLibE8pvkZTxxxQa7hJsdZc74fwI4rvwuXVEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795040361;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=/wF5nfxmVRaAwWIreRYmQzkdmrPMsVSsymJcGTGwnHg=;
	b=bES4Y+IcI1SJZyaCEcZU3eK+j/ZhoLFEZu+IjKLTej5Zim/xE5jFPNviFGHtsnhVyz+Z
	 nRJP1WGuGOKeicxvdOl6AugLlNDF3zd+2NR9oTaV089xWobicNA2WPqNkXFq89I6qGp+Q
	 idDLm6Xh5d/X4d0Y14SWYC2xqCOVaSKDnlM/jI9eMbgbTfQKvVM77/q4f288Takmtp303
	 FYTqm5rtld9odmC6gwA+66oVV/xBsziQg3v3C2WGkUUFftHsd/EreKkFqnCFmrk1CY1J7
	 EExKqb6+/XoBP9W/EviLCCBMyUebEbZLEgjZtXpJmx7j/fo8wy6FHmtN44gEqxX1TmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UEg8Q1QJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC6D606A337;
	Wed, 18 Nov 2026 22:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UEg8Q1QJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B99211F000C4;
	Wed, 18 Nov 2026 22:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795040361;
	bh=/wF5nfxmVRaAwWIreRYmQzkdmrPMsVSsymJcGTGwnHg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UEg8Q1QJTVEORLibXsLjtFVC5GnCnKqEZtYdjlPVBuSsXNaG/G2uShFVIwFVVOrCV
	 sCPp89DufJFfYbfp7PF2oqRcNc2NrbiabQUwD8abLo9482j1W2b4FD5JssCJuCyUxq
	 Uy9bVFlM72nYPxBsbHRk3JHV+vtD6nXPGDwoA0toaZxllZTOHX29dBg9hM6nKbeqSN
	 AQNnhvQlX0mKOWAKsVrauVzpD2PZufDiykOzrIP4XvKGZ4j5txGEQK984jKCkPjyJF
	 kKCfP5ohWxmgBVJ/3HL+nU/DNF1UdPOQI8k65mnQH2M1++/5XQqCidX1uO7s+EgwZd
	 JFMdYF5z3Xs3A==
Subject: Re: [PATCH net 07/11] can: isotp: reject socket options while a
 transfer is active
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, zhuling0805@qq.com,
 stable@vger.kernel.org, socketcan@hartkopp.net, mailhol@kernel.org,
 o.rempel@pengutronix.de
Date: Wed, 18 Nov 2026 22:19:20 +0000
Message-ID: <179504036031.3136.7813193141510099541@kernel.org>
In-Reply-To: <20261117220818.1142581-8-mkl@pengutronix.de>
References: <20261117220818.1142581-8-mkl@pengutronix.de>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new -EAGAIN check in isotp_setsockopt_locked()
  (net/can/isotp.c:1732-1734) assumes, as the commit message says, that…
- [Medium] isotp_sendmsg() reads so->opt.flags into 'ae'
  (CAN_ISOTP_EXTEND_ADDR) and 'wait_tx_done' (CAN_ISOTP_WAIT_TX_DONE) at…

--

can: isotp: reject socket options while a transfer is active

This commit adds a check to isotp_setsockopt_locked() that returns -EAGAIN
while so->tx.state or so->rx.state is not ISOTP_IDLE. This matches the check
already done in isotp_bind(). The goal is to stop a concurrent setsockopt()
from changing so->opt, so->ll and so->tx.ll_dl while isotp_sendmsg() is
still building frames after the device was unregistered.

Link: https://patch.msgid.link/20261117-can-bcmlock-memcg-v6-7-6826a6227d36@hartkopp.net

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index 0293d590186c4..32c88749d75e7 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
> @@ -1725,6 +1725,14 @@ static int isotp_setsockopt_locked(struct socket *sock, int optname,
>  	if (so->bound)
>  		return -EISCONN;
>  
> +	/* A transmission or reception that outlived a previous binding
> +	 * (unbound by NETDEV_UNREGISTER) may still be draining and uses the
> +	 * socket options, see isotp_bind().
> +	 */
> +	if (READ_ONCE(so->tx.state) != ISOTP_IDLE ||
> +	    READ_ONCE(so->rx.state) != ISOTP_IDLE)
> +		return -EAGAIN;

[Severity: High]

The commit message says:

  "As the transmission and the reception always end by their timeouts at
  the latest, this state is only temporary."

Is this true for the rx side?

In isotp_rcv_cf(), the rx watchdog is cancelled before the length checks.
Two of the early exits that follow return without resetting so->rx.state
and without re-arming so->rxtimer:

net/can/isotp.c:isotp_rcv_cf() {
    ...
	hrtimer_cancel(&so->rxtimer);
    ...
	/* CFs are never longer than the FF */
	if (cf->len > so->rx.ll_dl)
		return 1;

	/* CFs have usually the LL_DL length */
	if (cf->len < so->rx.ll_dl) {
		/* this is only allowed for the last CF */
		if (so->rx.len - so->rx.idx > so->rx.ll_dl - ae - N_PCI_SZ)
			return 1;
	}
    ...
}

This leaves the socket in ISOTP_WAIT_DATA with no timer armed, so
isotp_rx_timer_handler() never runs to set it back to ISOTP_IDLE. While
the socket is bound, the next SF or FF fixes the state through
isotp_rcv_sf() or isotp_rcv_ff().

On NETDEV_UNREGISTER, isotp_notify() unregisters the isotp_rcv filter and
clears so->bound, but it does not touch so->rx.state:

	so->ifindex = 0;
	WRITE_ONCE(so->bound, 0);
	WRITE_ONCE(so->dev, NULL);

After that, only isotp_release() can bring rx.state back to IDLE.

One possible sequence:

  1) a node on the bus sends a valid FF; isotp_rcv_ff() sets WAIT_DATA
     and arms rxtimer
  2) the same sender sends a malformed CF (classic CAN: a 3 byte CF
     while more than 7 bytes are still missing; CAN FD: an FF with len 8
     followed by a 12 byte CF)
  3) isotp_rcv_cf() cancels rxtimer and returns early, still in WAIT_DATA
  4) the CAN device is unregistered (USB unplug, vcan/vxcan deletion,
     netns teardown)

Would every later setsockopt() on this socket then return -EAGAIN until
the socket is closed?

The matching check in isotp_bind() would also keep returning -EAGAIN. The
socket could then be neither reconfigured nor rebound.

An earlier commit in this series, "can: isotp: always start the rx timeout
in ISOTP_WAIT_DATA state", seems meant to close this class of stuck
states. It only adds hrtimer_start() on the success paths of
isotp_rcv_ff() and isotp_rcv_cf(), and these two early exits are not
covered.

The isotp_bind() comment that this check points to makes the same
assumption:

	 * (unbound by NETDEV_UNREGISTER) may still be draining; the FC/echo
	 * and RX watchdog timers bound how long this takes. Checked together

Could these exits re-arm rxtimer or reset rx.state to ISOTP_IDLE? Another
option would be for isotp_notify() to cancel rxtimer and reset rx.state on
NETDEV_UNREGISTER.

[Severity: Medium]

Does this check fully cover isotp_sendmsg()? The locals derived from the
options are computed at function entry, before so->tx.state is claimed:

net/can/isotp.c:isotp_sendmsg() {
    ...
	int ae = (so->opt.flags & CAN_ISOTP_EXTEND_ADDR) ? 1 : 0;
	int wait_tx_done = (so->opt.flags & CAN_ISOTP_WAIT_TX_DONE) ? 1 : 0;
    ...
	/* so->bound is only checked once above - a wakeup may have
	 * unbound/rebound the socket meanwhile => recheck
	 */
	if (!READ_ONCE(so->bound)) {
    ...
}

The new check only rejects setsockopt() once tx.state != ISOTP_IDLE, so
the window between function entry and the claim is not covered.

Here is how that could play out. isotp_sendmsg() is waiting in the claim
loop (or is preempted) when the device is unregistered. Then
setsockopt(CAN_ISOTP_OPTS) toggles CAN_ISOTP_EXTEND_ADDR or
CAN_ISOTP_WAIT_TX_DONE, and bind() succeeds. In that case the bound
recheck above passes.

The SF/FF size checks, isotp_fill_dataframe() and isotp_create_fframe()
would then use the stale ae with the new so->tx.ll_dl and
so->opt.ext_address. Meanwhile isotp_send_cframe() recomputes ae from the
new flags:

	int ae = (so->opt.flags & CAN_ISOTP_EXTEND_ADDR) ? 1 : 0;

Could the FF and its CFs then use different extended addressing layouts
within one PDU? And would the WAIT_TX_DONE blocking for that sendmsg()
call still follow the old options?

This does not look like an out-of-bounds access. The indices stay bounded
by so->tx.ll_dl, and the skb is sized from so->ll.mtu, which is read after
the claim. It does not quite match the commit message's statement that
"the socket options can only be changed when no transfer is active".

Would moving the ae and wait_tx_done computation after the claim, next to
the bound recheck, close this window?

> +
>  	switch (optname) {
>  	case CAN_ISOTP_OPTS:
>  		memcpy(&so->opt, val, sizeof(so->opt));

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261117220818.1142581-2-mkl%40pengutronix.de

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795478996;
	b=G41nnmVILiahN0S8Vn1A/caLm4/jef+o2lXysBjKk6nYAaaQxLOEnBV3BEidmhAgShaY
	 MCKpdU9WOQl94iHfsjaTedrjkLWZTyfJBMh3ba6YxLRMWHKvmxVgUs4zhe4UkDSlZLie5
	 jchFBrSddFEefmoQomjmXJzrNkL0s+Y8CBHoANliJCxep4qbvS64I2qbydclGN5FZ5bQ4
	 lpmmO8mXCvmQDn2cy9exXcpWvTZl4DRctvrPxB7/dvyNQZC9SvyTcHP8hOjp3UmmdZpiS
	 E44OXxpoMThFZqYdqT+7J7Qtb9FBmvpqfxpz4hgvj+A8KIOSAC/vXT6cYPWTAH4rSYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795478996;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=aRibS1c80/sGL47Wtj3ZQuZsyvDVR3/TNVAZ6s9w4dk=;
	b=uevp4GLRkNq6rJgllAZE/aLFcT/uhg92+A8P7L67aqUNa8qPNPj6fXfZNrzbfoJYUqDP
	 2f9AGIMtQQjWDwCoglhErM0xO4nnovtKgJVWETdi1dWFqUuwx/bt05eWHK1pOcxA3lyLx
	 IMZPLeit8tktC6FJdxlSCshK8hI8EsFo/VNOh3xte0zCD1LoI0Y80+BBHE0v7W8WtTVM4
	 sWzqx67KQXph+d915t2Bln1gPuxVcyKVL28CeYQ36KPLmuWEyRR0mxEcZvVJU7FWRI9Xq
	 tyYZJJcUrCrGRST37Sd8tS3F2+i48TmSFlP+BUS2qDyRgy3WkTjlp7lwCjyh3xM+jTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KG+956wG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7C0606A31E;
	Tue, 24 Nov 2026 00:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KG+956wG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86BD61F000C6;
	Tue, 24 Nov 2026 00:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795478996;
	bh=aRibS1c80/sGL47Wtj3ZQuZsyvDVR3/TNVAZ6s9w4dk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KG+956wGYZH8cn4Syb0MAisKUP/QyRphoKkp6BG+051qArttksuoeqAcQgWuG5TGj
	 UUM/8PCvYTbInfxWdarEV6knWn+vjSblasIBgm+x97lQGOZJ/jrCqr6sD86VTenmfv
	 X794goE+wTBanxHBZ3TadzsWoLUz3R+xQCkYJEgvYBW0YqnX4s1YOe/gJY7qE56V3E
	 TH/9DVnND6guaaMribwZttcKRxM/ETcJS3DcY1m3MNjuC3FZl6vc8S9KXgjBX1sW1d
	 GAMXZ/GqrsVmheLMrBcqDJWrR2XXrrupMz5zRRUly6A6TsnEa5Uek70zUZ+83Hkot9
	 ho4oFHxRnMd1g==
Subject: Re: [PATCH net v2] can: j1939: fix null-ptr-deref in
 j1939_session_completed()
From: netdev-bot+sashiko@kernel.org
To: fuchen.dust@gmail.com
Cc: robin@protonic.nl, o.rempel@pengutronix.de, mkl@pengutronix.de,
 socketcan@hartkopp.net, kernel@pengutronix.de, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, stable@vger.kernel.org,
 kuba@kernel.org
Date: Tue, 24 Nov 2026 00:09:55 +0000
Message-ID: <179547899509.3135.186731755576873205@kernel.org>
In-Reply-To: <20261123000916.181439-1-fuchen.dust@gmail.com>
References: <20261123000916.181439-1-fuchen.dust@gmail.com>
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

Critical: 0 · High: 1 (1) · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] A peer can leave a receive session permanently stranded by
  sending two bad DPOs.
- [Low] The commit message says a bogus DPO can be sent "right before the
  last data packet of an otherwise valid transfer".

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the patch adds
  another caller.

--

can: j1939: fix null-ptr-deref in j1939_session_completed()

This patch makes j1939_xtp_rx_dpo_one() reject an ETP.CM_DPO on a receive
session when the packet number is >= session->pkt.total. It cancels the
session with J1939_XTP_ABORT_BAD_EDPO_OFFSET. It also adds a NULL check
on the reassembled skb in j1939_session_completed() and sets session->err
on that path.

> Any node on the CAN bus can send such a DPO, for example right before
> the last data packet of an otherwise valid transfer, so this is
> remotely triggerable.

[Severity: Low]
Is this reproduction sequence accurate? Once a DPO with packet number
D >= pkt.total is stored, the next data packet goes through
j1939_xtp_rx_dat_one():

	packet = (dat[0] - 1 + session->pkt.dpo);
	if (packet > session->pkt.total ||
	    (session->pkt.rx + 1) > session->pkt.total) {
		...
		goto out_session_cancel;
	}

	se_skb = j1939_session_skb_get_by_offset(session, packet * 7);
	if (!se_skb) {
		...
		goto out_session_cancel;
	}

For any sequence byte dat[0] >= 1, packet is >= pkt.total. If packet is
greater than total, the bound check aborts. If packet equals total, the
offset lookup returns NULL, because the RX skb is only len bytes long.

Either way the session is cancelled and pkt.rx never reaches pkt.total.
No EOMA is sent, and j1939_session_completed() is never called.

As far as I can tell, only two sequences reach the NULL dereference on
the unpatched code:

- The bad DPO arrives after the final data packet but before the
  loopback echo of the receiver's own EOMA reaches
  j1939_xtp_rx_eoma_one()->j1939_session_completed().

- A DPO with D == pkt.total is followed by a data packet with sequence
  byte 0. Then packet == total - 1 and pkt.rx reaches total.

The test in the notes (DPO packet 256 for a 256 packet transfer) seems
to match the second sequence. The new dpo >= session->pkt.total check
blocks both, so only the description seems to be off.

Could the commit message describe a sequence that actually triggers the
crash?

> diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> index 8fcfd13e5e6f8..d3644c8239a4b 100644
> --- a/net/can/j1939/transport.c
> +++ b/net/can/j1939/transport.c

[ ... ]

> @@ -1823,14 +1828,25 @@ static void j1939_xtp_rx_dpo_one(struct j1939_session *session,
>  				 struct sk_buff *skb)
>  {
>  	const u8 *dat = skb->data;
> +	unsigned int dpo;
>  
>  	if (j1939_xtp_rx_cmd_bad_pgn(session, skb))
>  		return;
>  
>  	netdev_dbg(session->priv->ndev, "%s: 0x%p\n", __func__, session);
>  
> +	dpo = j1939_etp_ctl_to_packet(skb->data);
> +	/* a receive session keeps the whole message in a single skb,
> +	 * reject a DPO which does not point into it
> +	 */
> +	if (!session->transmission && dpo >= session->pkt.total) {
> +		j1939_session_timers_cancel(session);
> +		j1939_session_cancel(session, J1939_XTP_ABORT_BAD_EDPO_OFFSET);
> +		return;
> +	}

[Severity: High]
Can a peer strand a receive session by sending two bad DPOs in a row?

j1939_session_cancel() only re-arms the rxtimer while the session is
not yet in WAITING_ABORT:

	if (session->state >= J1939_SESSION_ACTIVE &&
	    session->state < J1939_SESSION_WAITING_ABORT) {
		j1939_tp_set_rxtimeout(session, J1939_XTP_ABORT_TIMEOUT_MS);
		__j1939_session_cancel(session, err);
	}

The sequence would be:

1. The first DPO with packet number >= pkt.total moves the session to
   WAITING_ABORT and arms the 500 ms abort rxtimer.

2. A second bad DPO arrives within 500 ms.
   j1939_session_get_by_addr_locked() does not filter on state, and the
   PGN is unchanged, so j1939_xtp_rx_cmd_bad_pgn() passes.

3. j1939_session_timers_cancel() cancels the pending abort rxtimer and
   drops its reference.

4. j1939_session_cancel() does nothing except queue another RX_ABORT.

Only the WAITING_ABORT branch of j1939_tp_rxtimer() deactivates such a
session, and that timer is now gone. Receive sessions have no sk, so
socket release does not clean them up. The local abort echo carries a
local SA, so it is only dispatched to transmitter sessions.

The session would then stay on active_session_list. It keeps its kref,
its reassembly skb (sized by the peer's RTS, up to tp_max_packet_size),
its netdev tracker and its priv reference. These are only released on
NETDEV_DOWN/UNREGISTER or when an RTS with the same PGN arrives on the
same tuple. An RTS with a different PGN on the same (sa, da) is refused
with BUSY.

Before this patch, a DPO in WAITING_ABORT always went through
j1939_tp_set_rxtimeout(session, 750), which re-armed the timer.

The RTS path already guards against this in
j1939_xtp_rx_rts_session_active():

		} else if (session->state == J1939_SESSION_WAITING_ABORT) {
			/* Force deactivation for the receiver.
			 * If we rely on the timer starting in j1939_session_cancel,
			 * a second RTS call here will cancel that timer and fail
			 * to restart it because the state is already WAITING_ABORT.
			 */
			j1939_session_deactivate_activate_next(session);
		}

Would it make sense to return early here when session->state >=
J1939_SESSION_WAITING_ABORT? Another option is to force
j1939_session_deactivate_activate_next() in that state, as the RTS path
does.

The out_session_cancel path of j1939_xtp_rx_dat_one() has the same
timers_cancel plus cancel pattern, for example with two data frames
whose length is not 8. That copy is pre-existing.

[Severity: High]
This is a pre-existing issue and was not introduced by this patch.
However, the patch adds another caller of j1939_session_cancel(), which
holds the session list lock across a synchronous hrtimer cancel:

j1939_session_cancel()
  j1939_session_list_lock(session->priv)   /* spin_lock_bh */
  j1939_tp_set_rxtimeout()
    j1939_session_rxtimer_cancel()
      hrtimer_cancel(&session->rxtimer)    /* waits for running callback */

The rxtimer callback j1939_tp_rxtimer() takes the same lock in its
non-WAITING_ABORT, non-SIMPLE branch:

	} else {
		j1939_session_list_lock(session->priv);
		if (session->state >= J1939_SESSION_ACTIVE &&
		    session->state < J1939_SESSION_ACTIVE_MAX) {

Suppose the rxtimer fires on CPU B while CPU A is inside
j1939_session_cancel() with the session still ACTIVE. Can B then spin
on the list lock while A spins in hrtimer_cancel() waiting for B's
callback to finish?

The more realistic trigger is the existing
j1939_tp_txtimer()->j1939_session_cancel() path, which does not cancel
the rxtimer first. At this new call site, j1939_session_timers_cancel()
runs just before, so the window is very narrow. The rxtimer would have
to be re-armed from another CPU and expire almost immediately, and all
rxtimeouts are at least 250 ms.

Would it be better to cancel and re-arm the timers outside the list
lock?

> +
>  	/* transmitted without problems */
> -	session->pkt.dpo = j1939_etp_ctl_to_packet(skb->data);
> +	session->pkt.dpo = dpo;
>  	session->last_cmd = dat[0];
>  	j1939_tp_set_rxtimeout(session, 750);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261123000916.181439-1-fuchen.dust%40gmail.com

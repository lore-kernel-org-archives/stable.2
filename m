Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794531259;
	b=KOpg6Ws8gFp7xCSdWZzopgf1k+0tHpEclKGr1KgaSF/Ur/LlZM9HaVWN9MVWoE0DY0Gy
	 eN3HUkILBJjCZW/GdavLaa5Fm0wM98m4fkikQDpVk9QzV0bVdmcIKkQjCcNHzAv2IQD9m
	 3C3+XuJYDBmmpNqA94s1iO38Jk6GMCQWnSMAWIPGMb+5XY/08+annfcLLWqtEBqk/79vf
	 amZ1nf5hb/Vrbt0XRyYUmZGPx0G6dUKPgJzSCYZpKoGaWEw98qRMQ0wKcPURnxFcyG2sD
	 QL0CRzwy+1eIoomLqDOMEE5q+JEqmjMElRvMOks6REGdvHMCkV1Ya8gex7p+gzmrthA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794531259;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=GOIW1g5YZfKsa+KiXw0SvAfigmJeYU1EiL2TqNT/MvI=;
	b=rhkuAj9G8ytl48euq1noshYjD78xDI6VN2w+3JseTbUYFlxfBggPFXLq7lU+I997QfBV
	 JG61c0ZHsr2dL/3Zuq+Tro8CjdG40eMm4SD2c+jjgLglCf04Dlgk3oQskE0KSjD5XQ898
	 Rzv+GNbBd4Ml47C17KrBH7OWF2SoW/2UhEzg6bagVy860SBLTFdXhPl1LEDaeE6GwJydQ
	 zZmz2Ud8x2nGWFjFlVohxYhb0l+Gd9hvtKkZQ7B0bZ8Y23lJbXZqJUByKGeWLlHM5Qhkl
	 ZxQRCG5l+hHthjyYSMMA3ani9gJw3UQEcjgoESyjvTCbrcmKVIylDrbAmzfpafXZoEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k+82RSGU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A677606A32E;
	Fri, 13 Nov 2026 00:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k+82RSGU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94FBB1F000C4;
	Fri, 13 Nov 2026 00:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794531259;
	bh=GOIW1g5YZfKsa+KiXw0SvAfigmJeYU1EiL2TqNT/MvI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=k+82RSGUxD988eRxEeYqmVu7qN/xFfNFKeEIKOt0sZ/VEA6uI0fnCTrKbTc4kO2t/
	 zbjVSb5drfl2+r3xsfWeRwH+1NexauEBd278GmBGF/sASewZL/CJ56vMEBrNIwZ+n4
	 w3auoUQkwU40GKfpDJ8yKX6CsG18vp1IBOadDNB+MArbYPvbVEAe5SG8QL82JcJZ47
	 5rVCBDFNJUDibix22TkLzrOqEMytIMyqFNevhvYZ1Lhp6ppNPlohlzm3s1L3GtZNfn
	 TqkeHprhlYe5GYR9n0MmoDsffUpslMsNiQCmApST844qEA1Z4rX6eW3vMhVFbhlUVe
	 PnrJe+UimAklw==
Subject: Re: [PATCH net v9 2/4] can: j1939: validate the EDPO packet number
From: netdev-bot+sashiko@kernel.org
To: chaosheng.qu.linux@gmail.com
Cc: robin@protonic.nl, o.rempel@pengutronix.de, socketcan@hartkopp.net,
 mkl@pengutronix.de, kernel@pengutronix.de, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, kuba@kernel.org
Date: Fri, 13 Nov 2026 00:54:18 +0000
Message-ID: <179453125814.488853.12291320071537829281@kernel.org>
In-Reply-To: <20261111-j1939-edpo-v9-v9-2-e779ca334a81@163.com>
References: <20261111-j1939-edpo-v9-v9-2-e779ca334a81@163.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In j1939_xtp_rx_dpo_one(), the abort code for transmitter
  sessions rests on a false claim.
- [Low] The new comment in j1939_xtp_rx_dpo_one()
  (net/can/j1939/transport.c, around line 1872 at this commit) points to…

--

can: j1939: validate the EDPO packet number

This commit checks the packet number carried in ETP.CM_DPO in
j1939_xtp_rx_dpo_one(). A value at or past pkt.total now aborts the
session. The session timers are cancelled before the abort, and the
abort code is J1939_XTP_ABORT_ECTS_TOO_BIG for transmitter sessions and
J1939_XTP_ABORT_BAD_EDPO_OFFSET for receiver sessions.

> diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> index fa23260e1833f..2580091827fc6 100644
> --- a/net/can/j1939/transport.c
> +++ b/net/can/j1939/transport.c
> @@ -1853,14 +1853,42 @@ static void j1939_xtp_rx_dpo_one(struct j1939_session *session,
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
> +	dpo = j1939_etp_ctl_to_packet(dat);
> +
> +	/* EDPO is peer controlled.  j1939_xtp_rx_dat_one() places data at
> +	 * "dat[0] - 1 + pkt.dpo", so a value at or past pkt.total moves
> +	 * pkt.dpo past the reassembled buffer, and the ETP completion path
> +	 * then looks up an offset no queued skb covers.
> +	 *
> +	 * This bounds the receiver-side writer only.  j1939_session_tx_dpo()
> +	 * copies pkt.tx_acked, which comes from an ETP.CM_CTS packet number
> +	 * that the responder controls, and 4/4 bounds it where it is parsed.
> +	 */

[Severity: Low]
This isn't a bug, but could this comment name the companion patch by
subject instead of by series position? "4/4" stops meaning anything once
the series is merged or the patches are backported to stable one at a
time. The commit message has the same problem:

  The CTS packet number that feeds the transmitter-side EDPO is bounded in
  4/4, on its own, because it is a different input parsed in a different
  function

At this commit nothing bounds it yet. j1939_xtp_rx_cts_one() still does:

	session->pkt.tx_acked = pkt - 1;

with no check of pkt against pkt.total, and j1939_session_tx_dpo() still
copies that value into pkt.dpo. The bound is added later in the series by
"can: j1939: reject a CTS that names more packets than the message has".

Also, the comment says "This bounds the receiver-side writer only", but
the check right below it also aborts transmitter sessions, and the
session->pkt.dpo = dpo assignment runs for both roles. Could the wording
be changed to match the code?

> +	if (dpo >= session->pkt.total) {
> +		netdev_warn(session->priv->ndev,
> +			    "%s: 0x%p: EDPO %u out of range (total %u), aborting\n",
> +			    __func__, session, dpo, session->pkt.total);
> +		j1939_session_timers_cancel(session);
> +		/* The transmitter only sees this on the echo of an EDPO it built
> +		 * from an oversized ETP.CM_CTS packet number, so it is the
> +		 * responder's CTS that is too big, not the EDPO offset.
> +		 */
> +		j1939_session_cancel(session,
> +				     session->transmission ?
> +				     J1939_XTP_ABORT_ECTS_TOO_BIG :
> +				     J1939_XTP_ABORT_BAD_EDPO_OFFSET);

[Severity: Medium]
Is it true that a transmitter session only reaches this branch through
the echo of its own EDPO?

j1939_can_recv() in net/can/j1939/main.c sets J1939_ECU_LOCAL_SRC from
the source address alone:

	if (j1939_address_is_unicast(skcb->addr.sa) &&
	    priv->ents[skcb->addr.sa].nusers)
		skcb->flags |= J1939_ECU_LOCAL_SRC;

j1939_tp_cmd_recv() then sends every LOCAL_SRC DPO to the transmitter
session:

	case J1939_ETP_CMD_DPO:
		if (skcb->addr.type != J1939_ETP)
			return;

		if (j1939_tp_im_transmitter(skcb))
			j1939_xtp_rx_dpo(priv, skb, true);

So another node on the bus that sends an ETP.CM_DPO with our SA (CAN has
no source authentication, or two ECUs may be configured with the same
address) and a packet number >= pkt.total reaches this branch with
session->transmission == true. That node sent no oversized CTS, but the
session is aborted with J1939_XTP_ABORT_ECTS_TOO_BIG, and that reason goes
out on the bus.

Once the later patch "can: j1939: reject a CTS that names more packets
than the message has" is applied, pkt in j1939_xtp_rx_cts_one() stays
within [1, pkt.total]. tx_acked is then at most pkt.total - 1, and
j1939_session_tx_dpo() always builds an in-range EDPO. The echo case
described in the comment can then no longer happen.

In the final tree, a foreign or spoofed DPO is the only way into the
transmitter branch. Would J1939_XTP_ABORT_BAD_EDPO_OFFSET be the right
reason for both roles? The comment here and the matching paragraph in the
commit message would need the same update.

> +		return;
> +	}
> +

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261111-j1939-edpo-v9-v9-0-e779ca334a81%40163.com

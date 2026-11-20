Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795170955;
	b=Z//q4O1tJUFdy7ivc5jUQoJwcOM0lRQGcLNCsA1p57lbgC0kUdV8zsvnXV6dfWPgLZA8
	 X9kr2JMgUCfznE1HfBg0us1+b7B2LkYkizYCx6AkAZa0Q8NIdIEVksra8u4vYTU5pg1OB
	 zZw5hw+n/j8MzNWyTmAHe4iaYI0lc1i5kKRJHhfPmvmH38jTrLhbzoqyrP4tRM5SmyOH8
	 nZOFVu0M7SSjZ3frwrMM+PcAVZnZzzjZGSO049UXqp2PpVebDha9TqggDJMWbU4ElF8ah
	 AFqA66j65Ld6EsOJ97CYu0LFmjwLh6W034KeUU4AxMBmbgw09UabPI/ONHi26J55qJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795170955;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=/6h6kjv6DzEWQopVb09U0/FFqFvd3pADhGDuIrBHyOg=;
	b=2a3TjFr29x3Zu/7NCM5i8rrXSRB570B1oR5Y4dDmlg5DgBX4FRO+fSfQb9XIFLZC/m0+
	 V+qkH0WQxhgW88K9dG7z9thUrSc4GVSppB0GyZu8SCzdbLZfv6ztUJzSNQmEJ1NV/bKLP
	 eGWAIoYA5J6Mzu5FNfY0fvIc9Cux1Vcx8bGueUt0amkI6oWs1ciTD5muU2xOZjtO0x/pt
	 MB3QWwIzX4cdB7UOzNQN3X1Z524QRJD5c05Ufol9zZ65hRTi85YMdvkjNytEsme6oVAFi
	 tTkrHKBrRHMv/ov2Cvd0cSJrBqwEZg++jqluq17RbIYMeM5tr98nA/oLERy7kaxsIVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HqyRHFzw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44521606A32C;
	Fri, 20 Nov 2026 10:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HqyRHFzw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B46C91F000C6;
	Fri, 20 Nov 2026 10:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795170954;
	bh=/6h6kjv6DzEWQopVb09U0/FFqFvd3pADhGDuIrBHyOg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HqyRHFzwZF9szW0t2JBSkCp90F5fgPsEoHBe1RkkBwJ3jzeRdsRPbN0d8Mu5kwB8T
	 1FFb5VpXCPP+R6aOKTOif3hJmZ8HbPRxgzqGb/cn2L8k+s7DPq3E3s93dLI9JUCHH5
	 sSnwM8S9X2GyxMvajOknN15mgdxDQMijGMGVlVC3BtfiYdDW6lxZXMzUAS2Z1sIC8r
	 eCbRLalOBjmCce17J2m2088uFXy3cITA5jKeoyVZnjjysfKJETtJ7oPyaxvJLnEMtg
	 MLzenA08P7p2Jxm4wc7szkt/HeghRrGlbNCAZYo6wwdWElwRGaWJI7QoZcfAuqPyr7
	 yanY0PLezT6OA==
Subject:
 Re: [PATCH net] can: j1939: fix null-ptr-deref in j1939_session_completed()
From: netdev-bot+sashiko@kernel.org
To: fuchen.dust@gmail.com
Cc: robin@protonic.nl, o.rempel@pengutronix.de, mkl@pengutronix.de,
 socketcan@hartkopp.net, kernel@pengutronix.de, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, stable@vger.kernel.org,
 kuba@kernel.org
Date: Fri, 20 Nov 2026 10:35:53 +0000
Message-ID: <179517095327.3136.15773180395913177394@kernel.org>
In-Reply-To: <20261117103516.535910-1-fuchen.dust@gmail.com>
References: <20261117103516.535910-1-fuchen.dust@gmail.com>
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

Critical: 0 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch fixes the symptom (the NULL deref in
  j1939_session_completed()) but leaves in place the root cause that the…
- [Low] The commit message understates how reachable the bug is.

--

can: j1939: fix null-ptr-deref in j1939_session_completed()

This patch adds a NULL check in j1939_session_completed() on the skb
returned by j1939_session_skb_get(). The check runs before the skb is
passed to j1939_sk_recv() and consume_skb(). Session deactivation and
activation of the next queued session still happen unconditionally.

> An inconsistent ETP session offset can leave the receive buffer lookup
> unsatisfied when the session completes. The DPO receive path does not
> validate the offset against the receive buffer, so completion cannot
> assume that the lookup always succeeds.

[Severity: Low]
Could the commit message say more precisely how this is reached? As far
as I can tell, any node on the CAN bus can trigger the NULL dereference
in the unpatched code:

1. Start a valid ETP transfer to a local address that has a bound J1939
   socket.
2. Send all the data packets.
3. Send an ETP.CM_DPO with dpo * 7 >= total_message_size. This can be
   sent before the receiver's txtimer sends EOMA, or after EOMA is sent
   but before its echo comes back.

The DPO is stored without any check:

j1939_tp_cmd_recv()
  j1939_xtp_rx_dpo(priv, skb, false)
    j1939_xtp_rx_dpo_one()
      session->pkt.dpo = j1939_etp_ctl_to_packet(skb->data);

Then the EOMA echo completes the session:

j1939_tp_cmd_recv()
  j1939_xtp_rx_eoma(priv, skb, false)
    j1939_xtp_rx_eoma_one()
      j1939_session_completed()
        j1939_sk_recv(priv, NULL)
          j1939_sk_recv_one()
            if (oskb->sk == &jsk->sk)

A matching socket must exist, because j1939_session_tx_eoma() won't send
EOMA otherwise. So the loop body in j1939_sk_recv() always runs.

This is a remotely triggerable crash. Would it help stable backporters
and security triage if the commit message said so and included the
trigger sequence?

> diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> index 8fcfd13e5e6f8..ecf7f245f8378 100644
> --- a/net/can/j1939/transport.c
> +++ b/net/can/j1939/transport.c
> @@ -1244,8 +1244,10 @@ static void j1939_session_completed(struct j1939_session *session)
>  	if (!session->transmission) {
>  		se_skb = j1939_session_skb_get(session);
>  		/* distribute among j1939 receivers */
> -		j1939_sk_recv(session->priv, se_skb);
> -		consume_skb(se_skb);
> +		if (se_skb) {
> +			j1939_sk_recv(session->priv, se_skb);
> +			consume_skb(se_skb);
> +		}
>  	}
>  
>  	j1939_session_deactivate_activate_next(session);

[Severity: High]
When se_skb is NULL here, doesn't this drop a fully received message
without any notice and then complete the session as if it succeeded?

session->err is still 0 on this path. j1939_session_destroy() only
queues RX_ABORT when err is set:

net/can/j1939/transport.c:j1939_session_destroy() {
    ...
	} else if (session->err) {
			j1939_sk_errqueue(session, J1939_ERRQUEUE_RX_ABORT);
	}
    ...
}

That has these effects:

- Errqueue listeners that already got J1939_ERRQUEUE_RX_RTS and
  J1939_ERRQUEUE_RX_DPO never get a final event.
- Documentation/networking/j1939.rst describes J1939_EE_INFO_RX_ABORT as
  the event for an aborted reception, and it is never sent here.
- The peer has already been sent EOMA and thinks the transfer succeeded.
- The only trace is a netdev_dbg() in
  j1939_session_skb_get_by_offset().

The other RX lookup site treats the same condition as a fault and
cancels the session:

net/can/j1939/transport.c:j1939_xtp_rx_dat_one() {
    ...
	se_skb = j1939_session_skb_get_by_offset(session, packet * 7);
	if (!se_skb) {
		netdev_warn(priv->ndev, "%s: 0x%p: no skb found\n", __func__,
			    session);
		goto out_session_cancel;
	}
    ...
}

The root cause named in the commit message is still in place.
j1939_xtp_rx_dpo_one() stores the peer's DPO without checking it against
pkt.total, total_message_size or the CTS window:

	/* transmitted without problems */
	session->pkt.dpo = j1939_etp_ctl_to_packet(skb->data);

J1939_XTP_ABORT_BAD_EDPO_OFFSET and J1939_XTP_ABORT_EDPO_OUTOF_CTS are
defined, but nothing sends them.

Also, j1939_session_skb_get() looks up the RX skb using pkt.dpo * 7:

	offset_start = session->pkt.dpo * 7;
	return j1939_session_skb_get_by_offset(session, offset_start);

An RX session only has a single skb, allocated in
j1939_session_fresh_new() and covering [0, total_message_size). So this
lookup only fails when the peer has sent an out-of-range DPO.

Would it be better to validate the DPO in j1939_xtp_rx_dpo_one() and
abort with J1939_XTP_ABORT_BAD_EDPO_OFFSET? Another option is to look up
the RX skb without using dpo.

If the NULL check stays, could this branch at least set session->err, or
cancel the session with an abort? That way the failure is reported
instead of the session completing as a success.

The commit message also doesn't mention this change in behaviour.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261117103516.535910-1-fuchen.dust%40gmail.com

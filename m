Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795531270;
	b=UYLnMCGiGy8J+y2adlSqi7Afik3+xdHEv/w7r/FYPesyLu0IXSHZ0OTAEtMg0p04kCyl
	 8TYREEOir60zq1/5fIwhubItAm1YWyInsR8GFshFgC4AGJa46BN3urbQyUScmvx8Oqrf0
	 aO7YUIUcTaNoF7UzYN9cM9MiDldgAi7nprBZi+uRJm2Wo/VtbJbqVGPFgJHVZrxB9Cd+k
	 SiG7jAuoNWMKIOGRDM0cqBGvbSB+uoFOV05tZbzBfX0K7yJQrvDhhnXv+LVpk21lEpuBc
	 2XP72ibr/f8WTmnG8ZfWQC0xFV439/TMxQ0fJmci8sKxsOQCQ0N1VHXRVemv2sy979A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795531270;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=q4aixxSA4YbX+AKyocTUx+s1rBXdCvRgd5mhuqNcLf4=;
	b=CbHEqS+Gn+kV+kp+/5bMcE/jeWPXC1pTTl7wNxHmbTng6aysVTCEjIhkm3tI5vNppbS9
	 +ecRkTjkq6gmdnzXQf1AtsD5RoiqSxEURO8AlIoobdQHgdcUt3y+pJxNX6P1BP3iJtEUD
	 qG/JW623HlyIiL6Qphym8UYw3qXb7k8Lm7yzzDlVBZK85ubWxiKorCV+dz/iafJjmqSVh
	 WZq+llokntOSasm59nnuT1vSWqCrMc94kKsvm8H1xB9X6ihrBVSB5swYv78PD9u5xB0du
	 WgCxIH38/34+tBd50ri8Y7EIznfr5vYVT2axZeCPOvC7PzC6lFNXO7P5K21ZSnGLWHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h0NnDrGy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87335606A31E;
	Tue, 24 Nov 2026 14:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h0NnDrGy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27BAF1F000C0;
	Tue, 24 Nov 2026 14:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795531269;
	bh=q4aixxSA4YbX+AKyocTUx+s1rBXdCvRgd5mhuqNcLf4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=h0NnDrGyCWmdpe+8fZjohb5qyZj9Ta5CecJ4+LBfz7rH2vlFnB7IlpQosDH14XyE9
	 IMtsi20dEaEhEst/d6Pfm7p63Vddhxr0ZnWPfoiJfS6iOHmPQV0tg6Yxi3he28oYn5
	 bs6VtNWo27+jYXN/VifsGmf9pzl90O2zc4INw2tutIWxQ5+FMMyY/2SApVEEg7tgKZ
	 Q+X4bDbHtimFiiJadVW+ZWVrx+VxfW6f/ww5zEbxleehpuxpxVl1pVnDQi8Ntpchkj
	 ud/hp5PGJl1jrjiFfOOU+DcbkbN7uUOezhC7kEvkZL9pTuZ3esn9t5Ug449hNCA1nV
	 dWFwcXbVnkJAg==
Subject: Re: [PATCH net] can: j1939: do not pass a NULL session skb to the
 socket layer
From: netdev-bot+sashiko@kernel.org
To: piyus@iiitd.ac.in
Cc: robin@protonic.nl, o.rempel@pengutronix.de, socketcan@hartkopp.net,
 mkl@pengutronix.de, linux-can@vger.kernel.org, netdev@vger.kernel.org,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org, kapil@presceralabs.ai,
 stable@vger.kernel.org, kuba@kernel.org
Date: Tue, 24 Nov 2026 14:41:08 +0000
Message-ID: <179553126874.3135.14817947057284289051@kernel.org>
In-Reply-To: <20261123143625.4021586-2-piyus@iiitd.ac.in>
References: <20261123143625.4021586-2-piyus@iiitd.ac.in>
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

- [Medium] The commit message gives the wrong cause for the NULL, and the
  real cause is not fixed.
- [Low] When se_skb is NULL, the new branch in j1939_session_completed()
  still ends the receive session as a success.

--

can: j1939: do not pass a NULL session skb to the socket layer

This patch adds a NULL check on the skb returned by
j1939_session_skb_get() in j1939_session_completed(). A receive session
that completes without a matching skb no longer passes NULL to
j1939_sk_recv(). The session is still deactivated as before.

> j1939_session_skb_get() returns the skb covering the session's current
> offset, or NULL when the queue holds none, and j1939_sk_recv_one() then
> dereferences it on its first statement:

[ ... ]

> A peer reaches this by completing a transport session that has no data
> queued - an EOMA for a connection whose data packets never arrived:

[ ... ]

> Test the skb before using it, as the two other callers of the getter in
> this file already do (j1939_session_tx_dat() returns -ENOBUFS, and
> j1939_xtp_rx_dat_one() warns and cancels the session).

[Severity: Medium]
Is this the actual trigger?  For a receive session, the queue does not
seem able to be empty while the session is alive.

j1939_xtp_rx_rts_session_new()->j1939_session_fresh_new()->
j1939_session_new() queues one skb:

net/can/j1939/transport.c:j1939_session_new() {
    ...
	skb_queue_head_init(&session->skb_queue);
	skb_queue_tail(&session->skb_queue, skb_get(skb));
    ...
}

j1939_session_fresh_new() then sizes that skb to the full message:

	/* alloc data area */
	skb_put_zero(skb, size);

Only j1939_session_skb_drop_old() and j1939_session_destroy() remove skbs
from the queue. drop_old() returns early when fewer than two are queued.

j1939_session_skb_get() looks up the skb by the DPO window, not by
offset 0:

	offset_start = session->pkt.dpo * 7;
	return j1939_session_skb_get_by_offset(session, offset_start);

So for a receive session it returns NULL only when pkt.dpo * 7 is at or
past total_message_size.

For a receive session, pkt.dpo is only written in j1939_xtp_rx_dpo_one().
That function stores the 24-bit value from the peer without checking it
against pkt.total:

	/* transmitted without problems */
	session->pkt.dpo = j1939_etp_ctl_to_packet(skb->data);

j1939_xtp_rx_dat_one() does reject packet > session->pkt.total before it
does its lookup.

That means the splat needs an ETP RTS, then an ETP DPO with an
out-of-range offset, then an EOMA. An EOMA alone with dpo == 0 finds the
zero-filled skb. It then delivers zero or partly filled data to the
matching sockets, both before and after this patch.

Could the commit message describe the DPO trigger instead?

Would it also make sense to fix the cause? j1939_xtp_rx_dpo_one() could
reject or cancel the session when the DPO is >= pkt.total. Another option
is to fetch the RX message at offset 0 in j1939_session_completed(). The
NULL check would then stay as a second guard.

One more point: j1939_session_tx_dat() and j1939_xtp_rx_dat_one() both
call j1939_session_skb_get_by_offset(), not j1939_session_skb_get(). The
only other caller of j1939_session_skb_get() appears to be
j1939_simple_txnext().

> diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> index 8fcfd13e5e6f8..af54e6a6bd714 100644
> --- a/net/can/j1939/transport.c
> +++ b/net/can/j1939/transport.c
> @@ -1243,9 +1243,11 @@ static void j1939_session_completed(struct j1939_session *session)
>  
>  	if (!session->transmission) {
>  		se_skb = j1939_session_skb_get(session);
> -		/* distribute among j1939 receivers */
> -		j1939_sk_recv(session->priv, se_skb);
> -		consume_skb(se_skb);
> +		if (se_skb) {
> +			/* distribute among j1939 receivers */
> +			j1939_sk_recv(session->priv, se_skb);
> +			consume_skb(se_skb);
> +		}
>  	}
>  
>  	j1939_session_deactivate_activate_next(session);

[Severity: Low]
When se_skb is NULL, the receive session still ends as a success. Is
user space told anything at all?

j1939_session_deactivate_locked() sets session->state to
J1939_SESSION_DONE and leaves session->err at 0. j1939_session_destroy()
only queues an abort for a receive session when err is set:

	} else if (session->err) {
			j1939_sk_errqueue(session, J1939_ERRQUEUE_RX_ABORT);
	}

Sockets using the error queue have already seen J1939_ERRQUEUE_RX_RTS and
J1939_ERRQUEUE_RX_DPO for this session. After that they get neither the
data nor J1939_ERRQUEUE_RX_ABORT.

The peer gets no abort frame either, because j1939_session_cancel() is
never called on this path.

j1939_xtp_rx_dat_one() handles a NULL lookup differently. It jumps to
out_session_cancel, which sets err, sends an abort, and later queues
RX_ABORT.

The commit message says cancelling was left out on purpose. Could it also
mention that error-queue users are left with a transfer that never
completes or aborts?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261123143625.4021586-2-piyus%40iiitd.ac.in

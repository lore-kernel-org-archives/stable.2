Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794531260;
	b=YBuGIJ/qmzuQo6+yXDu/UoeOBwApAcTbUC49l3M0nqz5aaBtd+zUVz+pGP+XDIBXFj2d
	 FKgijb95GYa1UFN8CFLeT9W9bIz1dxrAvGv/eD4R6PCwXkFP2yDdb5TGi/77ioxl1fH+p
	 FJNP5ilvetZdmBxw+19pwuwTL7202u9lIXJYqRPj3ItNotDC6V+Dep7xuo7n3473rqfJ7
	 g8jbiKI41vHloISQdXVQxN90NtZRy5vNBefkUEDM583nzeoyCgoymxS3IGByrbnxqcn1A
	 n+ziaVktE6I7PViLUQ3zaruSpEbiQxmryZaC4/gWpnpunFfO0yezlUNLJW9ebOXiJxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794531260;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=rhIOdnO+7z3iJ3nl14eV8COiDecmopXYxcQjfeMYOOo=;
	b=GgLe3v/zPsLSy4q4ZNwZXbEBCTcK2xJw0fUBXu7tItqaqIbJwkQK70arlTyATAy5DjJT
	 PkvMrjDYzrcBnYkfU05ltfJSv45Glq9c7XrGHg/C+yQJXfi5RGNBVhqOMTFBvTpOMwpss
	 Cb+eldbP5yFS8uhZTHn0O5bQaIzzjDO0CsFd5PUW7XFbtAa449+0iTbyMnOIKpMEHzbmr
	 3vuQTPOr/sWNPoY2yLznV9DPTnNADebE2JdGhg5vdfwCi0pYcLxsRm5CXgOKdo9zcQ1AB
	 IE9xF/S4tQq0lzbrpGH0/6sMr59e+Eo1ERCCNzy8QsffZmNihyQzguemJFACefk/tfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q3dNufQB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D30E606A33E;
	Fri, 13 Nov 2026 00:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q3dNufQB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B84141F000CE;
	Fri, 13 Nov 2026 00:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794531260;
	bh=rhIOdnO+7z3iJ3nl14eV8COiDecmopXYxcQjfeMYOOo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Q3dNufQBqyHmO2SuVzp6pbLRNWbaObusq7rV4156b4B43C9GJ6zfcXFcKAu2OrT/r
	 w0o8jT2OQUm6ghc9w+ty/nP0hjrhXG7rs3NyeZMcMJEu0rnAi94olvAxZkKwqMEviO
	 jcJdEX8eeVV9Zz15jclwPDzMDIQ7eyanAmKOGDbuYXN/ZIhaIYGIPTB5WdeT+jK0ga
	 NQYR5A722nJ58CZSZUrivQNDSBXMnmbZ4qVxrZXiOZFhgo4ZoWh3i5nM77GWfhPQWQ
	 i2/0Bqng/egDeYT22BpxsNIr4oD5o2igwDPduQ7XysQCiS+VtSsE0t7AZuU9VYIaIq
	 j9nwN+P2GiSvw==
Subject: Re: [PATCH net v9 4/4] can: j1939: reject a CTS that names more
 packets than the message has
From: netdev-bot+sashiko@kernel.org
To: chaosheng.qu.linux@gmail.com
Cc: robin@protonic.nl, o.rempel@pengutronix.de, socketcan@hartkopp.net,
 mkl@pengutronix.de, kernel@pengutronix.de, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, kuba@kernel.org
Date: Fri, 13 Nov 2026 00:54:19 +0000
Message-ID: <179453125932.488853.14502182027318562364@kernel.org>
In-Reply-To: <20261111-j1939-edpo-v9-v9-4-e779ca334a81@163.com>
References: <20261111-j1939-edpo-v9-v9-4-e779ca334a81@163.com>
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

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message gets the current behaviour wrong.
- [Medium] can: j1939: j1939_xtp_rx_cts_one() rejects standard CTS(0)
  frames
- [Low] The commit message presents the patch as an ETP-only relocation
  of a check that already fires ("the transmitter reports that value…
- [Low] The comment and the role-based abort code in
  j1939_xtp_rx_dpo_one() are stale once this patch lands.
- [Low] The new check in j1939_xtp_rx_cts_one() covers both TP and ETP
  sessions: pkt = dat[2] for J1939_TP_CMD_CTS and…

--

can: j1939: reject a CTS that names more packets than the message has

This patch adds a check to j1939_xtp_rx_cts_one() that rejects a CTS
whose packet number is larger than pkt.total. The session is aborted
with J1939_XTP_ABORT_ECTS_TOO_BIG. The commit message describes this as
moving an existing check from the ETP.CM_DPO path to where the CTS is
parsed.

> That value is what j1939_xtp_rx_dpo_one() now bounds, so an oversized CTS
> is currently caught one step later and reported as a bad EDPO offset.
> Reject it where it originates instead, with the abort code that describes
> it: J1939_XTP_ABORT_ECTS_TOO_BIG, "ECTS requested packets exceeds message
> size".

[Severity: Medium]
Is this description of the current behaviour accurate?

The transmitter handles the CTS in j1939_xtp_rx_cts_one() and builds the
ETP.CM_DPO from pkt.tx_acked in j1939_session_tx_dpo(). It only sees that
DPO again on the local echo. The echo has J1939_ECU_LOCAL_SRC set and
takes this path, with session->transmission set:

j1939_tp_cmd_recv()
  j1939_xtp_rx_dpo(priv, skb, true)
    j1939_xtp_rx_dpo_one()

The bound in j1939_xtp_rx_dpo_one() already picks the ECTS code for the
transmitter:

net/can/j1939/transport.c:j1939_xtp_rx_dpo_one() {
    ...
		j1939_session_cancel(session,
				     session->transmission ?
				     J1939_XTP_ABORT_ECTS_TOO_BIG :
				     J1939_XTP_ABORT_BAD_EDPO_OFFSET);
    ...
}

So the local transmitter already reports J1939_XTP_ABORT_ECTS_TOO_BIG
before this patch. The commit message of the earlier patch in this series,
"can: j1939: validate the EDPO packet number", says the same.

This patch is tagged for stable. Could the changelog describe what
actually changes? The out-of-range DPO no longer goes out on the bus, and
TP sessions are now covered as well.

[Severity: Low]
The changelog presents this as an ETP-only move of a check that already
fires. However, j1939_xtp_rx_cts_one() also handles TP.CM_CTS (pkt =
dat[2]). TP never sends a DPO, so before this patch nothing caught an
oversized TP CTS.

For a TP transmitter, pkt.block is min(j1939_tp_block ?: 255, total). A
CTS with dat[2] > total therefore passes the old checks, and tx_acked and
pkt.tx become pkt - 1 >= total. After that:

j1939_xtp_txnext_transmiter()
  j1939_session_tx_dat()
    se_skb = j1939_session_skb_get_by_offset(session, session->pkt.tx * 7);
    if (!se_skb)
        return -ENOBUFS;

j1939_tp_txtimer() retries on -ENOBUFS every 10-25 ms, up to
J1939_XTP_TX_RETRY_LIMIT times. The 1250 ms rx timeout set in
j1939_xtp_rx_cts_one() normally expires first, and j1939_tp_rxtimer()
then aborts with J1939_XTP_ABORT_TIMEOUT. When the txtimer retries run
out, the session ends with -ENETUNREACH.

For ETP, before this patch the out-of-range ETP.CM_DPO was actually sent
on the bus by j1939_tp_tx_ctl() in j1939_session_tx_dpo(). Only its local
echo triggered the abort.

Could the commit message mention both cases? They look like the
user-visible fixes behind the Cc: stable tag.

> diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> index fc2840f334b5b..377991d36dc6a 100644
> --- a/net/can/j1939/transport.c
> +++ b/net/can/j1939/transport.c
> @@ -1512,6 +1512,15 @@ j1939_xtp_rx_cts_one(struct j1939_session *session, struct sk_buff *skb)
>  		goto out_session_cancel;
>  	else if (dat[1] > session->pkt.block /* 0xff for etp */)
>  		goto out_session_cancel;
> +	else if (pkt > session->pkt.total) {
> +		/* The responder asks for more packets than the message has.
> +		 * pkt - 1 becomes pkt.tx_acked below, and the transmitter
> +		 * reports that value in an ETP.CM_DPO, where it would name a
> +		 * packet past the end of the message.
> +		 */

[Severity: Medium]
This bound is checked before dat[1] is looked at, so it also applies
to a CTS(0). That is the hold message, with dat[1] == 0, that a
responder sends to keep the connection open without taking more data.

SAE J1939-21 and ISO 11783-6 have the responder set the next packet
number in such a hold message to 0xff for TP.CM_CTS and to 0xffffff
for ETP.CM_CTS. dat[2] and j1939_etp_ctl_to_packet() pass those
values through unchanged. For any session whose pkt.total is smaller,
pkt > session->pkt.total is then true, and the session is cancelled
with J1939_XTP_ABORT_ECTS_TOO_BIG.

Before this patch such a frame got past the checks and reached the
CTS(0) branch at the end of j1939_xtp_rx_cts_one(), which only calls
j1939_tp_set_rxtimeout(session, 550). Now a peer that pauses a TP or
ETP transfer this way has the whole transfer aborted. With the
Cc: stable tag, that interoperability regression would also land in
stable kernels.

Should the new bound only apply when dat[1] is non-zero?

The comment just below, "set packet counters only when not CTS(0)",
suggests the tx_acked, last and tx updates were meant to be skipped
for CTS(0) as well. The code does them unconditionally, though.
Before this patch, a 0xff or 0xffffff packet number in a hold message
ended up in pkt.tx_acked and was used by j1939_session_skb_drop_old().

Would it be cleaner to handle CTS(0) before both the new bound and
the counter updates?

[Severity: Low]
This check covers both TP.CM_CTS and ETP.CM_CTS, but the comment only
gives the ETP.CM_DPO reason. For TP, the consequence is that
j1939_session_tx_dat() looks up pkt.tx * 7 past the queued skb.

Could the comment describe the TP case too?

On the abort code: enum j1939_xtp_abort and j1939_xtp_abort_to_str()
document J1939_XTP_ABORT_ECTS_TOO_BIG only as "ECTS requested packets
exceeds message size". The documentation for code 9, by contrast, gives
separate ETP and TP meanings.

The -EOVERFLOW path in j1939_tp_txtimer() already sends this code for TP,
so the choice here matches existing practice. That TP use just isn't
documented anywhere.

> +		err = J1939_XTP_ABORT_ECTS_TOO_BIG;
> +		goto out_session_cancel;
> +	}
>  
>  	/* set packet counters only when not CTS(0) */
>  	session->pkt.tx_acked = pkt - 1;

[Severity: Low]
With this check in place, tx_acked = pkt - 1 is at most pkt.total - 1.
The only other writer is j1939_xtp_rx_eoma_one(), which sets tx_acked =
total but then completes the session.

j1939_session_tx_dpo() copies tx_acked into pkt.dpo. So a DPO the
transmitter built itself can no longer hit "dpo >= session->pkt.total" in
j1939_xtp_rx_dpo_one().

Should the comments that the earlier patch in this series added there be
updated? Both look stale now:

net/can/j1939/transport.c:j1939_xtp_rx_dpo_one() {
    ...
	 * This bounds the receiver-side writer only.  j1939_session_tx_dpo()
	 * copies pkt.tx_acked, which comes from an ETP.CM_CTS packet number
	 * that the responder controls, and 4/4 bounds it where it is parsed.
	 */
    ...
		/* The transmitter only sees this on the echo of an EDPO it built
		 * from an oversized ETP.CM_CTS packet number, so it is the
		 * responder's CTS that is too big, not the EDPO offset.
		 */
    ...
}

"4/4" is a series index and means nothing once merged. Could it name
j1939_xtp_rx_cts_one() instead?

After this patch, the transmitter branch can only be reached by a DPO
that carries a locally claimed SA but was not built by this host. main.c
sets J1939_ECU_LOCAL_SRC for any received frame whose SA is in priv->ents
with users, and that includes a conflicting or spoofing node. In that
case, J1939_XTP_ABORT_ECTS_TOO_BIG blames a responder CTS that was valid.

Should the session->transmission ? ... selection in j1939_xtp_rx_dpo_one()
be revisited as well?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261111-j1939-edpo-v9-v9-0-e779ca334a81%40163.com

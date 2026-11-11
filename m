Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794393473;
	b=cLEpGiMJ5veopgXA/rYEfbV47JYjuR+sd70ahriev9tAt0v3+4Pj+hfxfAyGqr1wAJGo
	 od+plP1XQDDyvUNPVHVXHvYGjTYhfBDhWOyiN7hRoCVTJNO8bbPFxYjPiDo+kxSP9uAHz
	 goC7hAev3Z4XSrr8OfKtHsY72pAZ2r/SA/xyMB/vHQAbVTCiTJA1Yu1UQ+DWb4yS7auEI
	 2DV1qhf8zeo13i0uzCz55xC5/XwaLaOqcUAetSWMupZyeMrVnVaeEnpmye5wCbdgcCuLv
	 qsfdYha/7fovMWq91JhitvgBS+W2pzuhrU1wvp3k3UzUGs6AtFIGHDhpzBgrvQUuWFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794393473;
	h=DMARC-Filter:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-CM-TRANSID:X-Coremail-Antispam:Sender:
	 X-CM-SenderInfo;
	bh=d3FKuqc6u/Y7Kk2Jk+Mpg4j89GV6lD7jgrDIj8trkuE=;
	b=YRtHTQhLM+quLZNwE4AENSiytxcK2AmrOb5+C0vMkuaYWNxbthduWXSBCwVlEHIzavFo
	 e4IUl6xno9qoO4MdLgUff1uVm9UUSggVrDOhfFl6yj0XsLsMkAAJhEkPya/Ge0f5hyeHa
	 S8+3wPMgIg3CymYlFQQ8TKMsTBwJT/FLciDhnjCnI6Luf4vsZoobjYsErTiJ+1J0UryxJ
	 Q/xVR9miqBut3nt7085bgD88IavlikLCNxjLKwMttvOPKRFmz4lqHaY0AJbPfuqoOxdAf
	 ep/pSzNL0yDdgY7F0Fncmz9qeEZ432roA9cGdsM7M0GjkURCVEd01ZmqMKG5DIph9jA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=gmail.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b="n+InSik/";
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CBE606A332;
	Wed, 11 Nov 2026 10:37:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0CBE606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=n+InSik/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Date:Subject:MIME-Version:Content-Type:
	Message-Id:To; bh=d3FKuqc6u/Y7Kk2Jk+Mpg4j89GV6lD7jgrDIj8trkuE=;
	b=n+InSik/pCTGBactsyLDZqen3iv5yu+rrX65WOIj97riEnt6ATOP9OAuhmimCC
	Kuuz4Qb+8LAO/F+PN24sQjV5L4wRP6HNAZHGqv0OR+R86moWldYjxzoKzkGB76K0
	OCbodr4t7cXbJbWo/aAQ1skuGj4ZROJpAZZx/q5VTbfn8=
From: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
Date: Wed, 11 Nov 2026 18:31:23 +0800
Subject: [PATCH net v9 2/4] can: j1939: validate the EDPO packet number
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-j1939-edpo-v9-v9-2-e779ca334a81@163.com>
References: <20261111-j1939-edpo-v9-v9-0-e779ca334a81@163.com>
In-Reply-To: <20261111-j1939-edpo-v9-v9-0-e779ca334a81@163.com>
To: Robin van der Gracht <robin@protonic.nl>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-CM-TRANSID:_____wD3f79uRfRqf2sZGg--.8132S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCF1xWryDXrWfKr18Wr1kAFb_yoWrAr1kpa
	y3KrW3GrnrJr1Iyws3trZYqryayrs3JFWfW3W2q3sakwsxCF4rtFyDKry2gayDJ3y8u345
	uryDX3ZxGr4DXrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UMWl9UUUUU=
Sender: quchaosheng000406@163.com
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC5A9EuWr0RW+jwgAA3D

From: Chaosheng Qu <quchaosheng000406@163.com>

Validate the packet number in ETP.CM_DPO, which is peer controlled and
currently accepted without any check.  It names the packet a transmission
window starts at, and j1939_xtp_rx_dat_one() places incoming data at
"dat[0] - 1 + pkt.dpo", so a value past the end of the message moves
pkt.dpo beyond the reassembled buffer.

The transfer still completes normally in that case.  With
pkt.dpo == pkt.total, a closing ETP.DT frame with dat[0] == 0 evaluates to
packet pkt.total - 1, which is the last in-order packet, so pkt.rx reaches
pkt.total and the receiver emits its own EOMA.  The local loopback of that
EOMA runs j1939_session_completed(), which asks j1939_session_skb_get()
for offset "pkt.dpo * 7" -- one full packet past the end of the queued
skb -- gets NULL, and passes it straight to j1939_sk_recv(), which
dereferences oskb->sk.

Reject a packet number at or past pkt.total and abort the session.  The
check has to be ">=" and not ">": pkt.total is a packet count, so the last
valid packet is pkt.total - 1.  The abort code depends on the role: a
receiver rejects a bad offset with J1939_XTP_ABORT_BAD_EDPO_OFFSET, while a
transmitter only builds an EDPO from pkt.tx_acked, which comes from the
responder's ETP.CM_CTS, so an out-of-range value there is an oversized CTS
and is reported as J1939_XTP_ABORT_ECTS_TOO_BIG.

Cancel the session timers before aborting, as the other receive-path abort
handlers do.  j1939_session_cancel() only rearms the abort timer and
leaves session->txtimer armed, so on the transmitter path the retry timer
keeps firing on an aborting session, retries up to J1939_XTP_TX_RETRY_LIMIT
and overwrites session->err with -ENETUNREACH; on the receiver path the
retries transmit CTS or EOMA and clobber the abort timeout.

The CTS packet number that feeds the transmitter-side EDPO is bounded in
4/4, on its own, because it is a different input parsed in a different
function; this patch only stops an EDPO value from being used as an
offset.

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Chaosheng Qu <quchaosheng000406@163.com>
---
 net/can/j1939/transport.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index fa23260e1..258009182 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1853,14 +1853,42 @@ static void j1939_xtp_rx_dpo_one(struct j1939_session *session,
 				 struct sk_buff *skb)
 {
 	const u8 *dat = skb->data;
+	unsigned int dpo;
 
 	if (j1939_xtp_rx_cmd_bad_pgn(session, skb))
 		return;
 
 	netdev_dbg(session->priv->ndev, "%s: 0x%p\n", __func__, session);
 
+	dpo = j1939_etp_ctl_to_packet(dat);
+
+	/* EDPO is peer controlled.  j1939_xtp_rx_dat_one() places data at
+	 * "dat[0] - 1 + pkt.dpo", so a value at or past pkt.total moves
+	 * pkt.dpo past the reassembled buffer, and the ETP completion path
+	 * then looks up an offset no queued skb covers.
+	 *
+	 * This bounds the receiver-side writer only.  j1939_session_tx_dpo()
+	 * copies pkt.tx_acked, which comes from an ETP.CM_CTS packet number
+	 * that the responder controls, and 4/4 bounds it where it is parsed.
+	 */
+	if (dpo >= session->pkt.total) {
+		netdev_warn(session->priv->ndev,
+			    "%s: 0x%p: EDPO %u out of range (total %u), aborting\n",
+			    __func__, session, dpo, session->pkt.total);
+		j1939_session_timers_cancel(session);
+		/* The transmitter only sees this on the echo of an EDPO it built
+		 * from an oversized ETP.CM_CTS packet number, so it is the
+		 * responder's CTS that is too big, not the EDPO offset.
+		 */
+		j1939_session_cancel(session,
+				     session->transmission ?
+				     J1939_XTP_ABORT_ECTS_TOO_BIG :
+				     J1939_XTP_ABORT_BAD_EDPO_OFFSET);
+		return;
+	}
+
 	/* transmitted without problems */
-	session->pkt.dpo = j1939_etp_ctl_to_packet(skb->data);
+	session->pkt.dpo = dpo;
 	session->last_cmd = dat[0];
 	j1939_tp_set_rxtimeout(session, 750);
 

-- 
2.43.0



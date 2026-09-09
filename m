Received: from out198-12.us.a.mail.aliyun.com (out198-12.us.a.mail.aliyun.com [47.90.198.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F28379C42;
	Wed,  9 Sep 2026 17:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788975420; cv=none; b=Ake0YTPe1U4van96lMOTmv87m0qswtXOoPoc/sHupst9xRVrFtVUmBYb+tzUyJ2Cpbk69ZTUxmphWU4s/zkMmcbBGjYhL76VmYpw9kpK+AJePreH3adFigtfIP1FfMe7ZLoul72MqcIIVl27IQqB6W8XsUdUyYMtLIZX6eXjz+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788975420; c=relaxed/simple;
	bh=5Lm49B6zVwyaOVGoSVRUBFwcAtXY6GIRbIOPfFalVKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E6JkenICRotEbmt3bHLKMesy/DCnYdWnkJqr6yFvDL5Px6898R1CpLbERipV8Oh8w6IaZWnwBu7MIB6xHXmtJ9TB1eEokeVI7BVBpHeZH7wYHrcF5dc+bVoSzd7hqbj6IAmsBuF4OUhcIEeoPyx1GyLIOZtMHzqeV+ueu/1Hwk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=jqd5bT9v; arc=none smtp.client-ip=47.90.198.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="jqd5bT9v"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1788975398; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=IqWNJurljz2sEYQNlRb5yGZBxJR2ATuvv3gT2h+LMz8=;
	b=jqd5bT9vPAsUQou7K569Px2/bWNzna8gXQJTXMuFFTVDLGQSoy7SW0iBVbr+d3N0zDsXa4AhiWG8XQ6p/Hm0R1+wL7bRaBNqpk5Rc892RD2Nz5NyGPUxIZOlrfJmXvDHcfl+0/ZsVEQdZgh8b7fuUCDZJyYtq9TQNrifCWTDWLo=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07438226|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0952803-0.00463008-0.90009;FP=14473300978445122994|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037026024;MF=liuc63@xiaopeng.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.j9p79vc_1788975072;
Received: from localhost(mailfrom:liuc63@xiaopeng.com fp:SMTPD_---.j9p79vc_1788975072 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 10 Sep 2026 01:31:15 +0800
From: Liu Chao <liuc63@xiaopeng.com>
To: Robin van der Gracht <robin@protonic.nl>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: kernel@pengutronix.de,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Liu Chao <liuc63@xiaopeng.com>
Subject: [PATCH net v2 2/2] can: j1939: check received packet count before completing session
Date: Thu, 10 Sep 2026 01:31:04 +0800
Message-ID: <20260909173105.158202-3-liuc63@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260909173105.158202-1-liuc63@xiaopeng.com>
References: <20260909173105.158202-1-liuc63@xiaopeng.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

j1939_xtp_rx_eoma_one() marks a session complete as soon as it sees
an EOMA without verifying that all data packets arrived.  Add a pkt.rx
check so a session with missing packets gets aborted instead of
delivering a short message to userspace.

Also tighten the existing EOMA size-mismatch warning to actually abort
for receive sessions instead of just logging.  The warning itself is
kept for both rx and tx paths so transmitter-side protocol violations
are still logged.

Only unicast receive sessions are gated:

 - Transmitter sessions track pkt.rx via loopback confirmations which
   may legitimately lag behind the real transmit count, so the check
   would cause false aborts on the tx path.

 - BAM (broadcast) sessions never go through EOMA -- they complete via
   the final flag in j1939_xtp_rx_dat_one() when pkt.rx reaches
   pkt.total directly.

The error path skips sessions already in J1939_SESSION_WAITING_ABORT:
cancelling the deactivation timer there would leave the session on
active_session_list forever, since j1939_session_cancel() only re-arms
that timer for sessions which are not yet aborting.  The same failure
mode was previously fixed for the second-RTS path by 1809c82aa073
("net: can: j1939: j1939_xtp_rx_rts_session_active(): deactivate
session upon receiving the second rts").

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Cc: stable@vger.kernel.org
Signed-off-by: Liu Chao <liuc63@xiaopeng.com>
---
 net/can/j1939/transport.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index c40db4337..fe447077b 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1396,6 +1396,7 @@ static void
 j1939_xtp_rx_eoma_one(struct j1939_session *session, struct sk_buff *skb)
 {
 	struct j1939_sk_buff_cb *skcb = j1939_skb_to_cb(skb);
+	unsigned int expected_total;
 	const u8 *dat;
 	int len;
 
@@ -1411,9 +1412,22 @@ j1939_xtp_rx_eoma_one(struct j1939_session *session, struct sk_buff *skb)
 
 	if (session->total_message_size != len) {
 		netdev_warn_once(session->priv->ndev,
-				 "%s: 0x%p: Incorrect size. Expected: %i; got: %i.\n",
+				 "%s: 0x%p: EOMA size mismatch, expected %u got %d\n",
 				 __func__, session, session->total_message_size,
 				 len);
+		if (!session->transmission)
+			goto out_session_cancel;
+	}
+
+	if (!session->transmission) {
+		expected_total = (session->total_message_size + 6) / 7;
+		if (session->pkt.rx < expected_total) {
+			netdev_warn_once(session->priv->ndev,
+					 "%s: 0x%p: EOMA but only %u/%u data packets rx'd\n",
+					 __func__, session,
+					 session->pkt.rx, expected_total);
+			goto out_session_cancel;
+		}
 	}
 
 	netdev_dbg(session->priv->ndev, "%s: 0x%p\n", __func__, session);
@@ -1422,6 +1436,16 @@ j1939_xtp_rx_eoma_one(struct j1939_session *session, struct sk_buff *skb)
 	j1939_session_timers_cancel(session);
 	/* transmitted without problems */
 	j1939_session_completed(session);
+	return;
+
+ out_session_cancel:
+	/* Don't touch timers if the session is already aborting;
+	 * cancelling the deactivation timer here would leak the session.
+	 */
+	if (session->state >= J1939_SESSION_WAITING_ABORT)
+		return;
+	j1939_session_timers_cancel(session);
+	j1939_session_cancel(session, J1939_XTP_ABORT_FAULT);
 }
 
 static void
-- 
2.50.1


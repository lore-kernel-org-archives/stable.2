Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793738618;
	b=he1eFAcYf8eyHDJ1ncscX6qmWDudnu9SS7ioMoyPnXfdOTD2vRjNpkmDFGTjUZuR1H5Q
	 d197qyDBCwQ8hM5c2n0fY2Vrv14nsx/s7vZ8Ps1fjEdjalEpS/Mbb7luEA+8jTLisYelY
	 Y9jdb+zdrIoz92bhPvs4qvJnq/ZfhE6oblcBzW4dYjznw05aIsvkcciY7dQvE2NYwiJsK
	 HAXrJutDZRm2UiBGMpSWEJWXjgTrjp0kE12lUvyq2ggWs2hcr/bkXGGLb2VnKTZWSqYon
	 fDprjchhWL3xdJpvfc8ujp7Rtu1hSBI3RqR60pcUr3ROsVR5un70n1N7H62Q4NhbguQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793738618;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4DKOHHau+kSa3qW/MTES/4J6ggjobYI7BskwRx+K5Hk=;
	b=B08bGz1AMcqAMCXUxVDDjC2dPAOLJ1u9p4/3HIUwPOVvjXRpTXlLqKDn9xczerIKmZT6
	 B1qFyUk5N6qBVrtZIR0hFq9i8N0Kn1MvrJ9RQE70gO/+BxxMttB9sfTfe0ieix9oOlma6
	 uPvehQgfvm2azFOUwBGy/X7KY7TB4mOzCnh/dAw6qWIvkLVuYqqw15gOv8+UFW/iZiWUq
	 5a0x68df5WAWHSRmQQhMYuCl6+DDmIrv3URkoO/uYrDSIcvcnY7gXHUlxIDFTPoOp3Q1f
	 iIBnEu+TwOXfo8ztk1Dww3U4F9Bez5VPug4/1/Gz067gLHo2Yv5K7JniotHMIQB2n/g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=YauPxBiE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AC7606D803;
	Tue,  3 Nov 2026 20:43:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61AC7606D803
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=YauPxBiE
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id C1334202831;
	Tue, 03 Nov 2026 21:43:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793738601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4DKOHHau+kSa3qW/MTES/4J6ggjobYI7BskwRx+K5Hk=;
	b=YauPxBiEJ0UjAwnRdG6ZxI7D6VVcWC+HtpV9Lg/TXnSUO1DeipfueQ8aMriOxJrR0vhDsd
	qUnlR9CmShFXADgLp7/mSEMCqvbOyFYlNyp9rmvVYI/MzKs6V6hCMXmMN3VahmkUyRMAcF
	8JDAWIPN0+dmP60pKIyDjJYRb9bPtvqWXo3OBolywOxDOoAkudvsWFcV74GxnhSzkOOI4C
	gh908jeUHqJXUHeablDNhzeWlzfDs/k4/o9Gm0+QyFh8uBLzP5x/QHYg4reMURwo4O0QlP
	cb9Ku7DiFsN8HKohpNtgxF+/EqzuOAYnsZ8TUiVopVsLYaR9oI4RW66Mdi8RTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793738601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4DKOHHau+kSa3qW/MTES/4J6ggjobYI7BskwRx+K5Hk=;
	b=XU5PrtJoNgLNGz7cl+c8yodCcjK0g9dYUw17aHIS50yEhWxl0rAOkX5110qahpNpqHl0NB
	Mkaxk+u12yt6eY0EzOgLFqjh6eVcHgA7g/kkHqLwLLNgalPKZBFwVE0XQ6Xl0AiLKFzRaa
	9vRgxhslHR5ZggJiegCdfdTS459N+FEMmxJaZGjqsYxehC9pTdHmpeMNUnDYoJGOykh/BG
	AlLwfFofcEMs0PSTKs3WRvgLS3wHD2r/cKmcZV5O/dt8U3TmcJPdu2RtcJE0I3s8RwwEgD
	CH1x2aShDaV6gbgZZwslTChUZhDL3In/fr1yhaf5pFbPXmbyO7QFaMmYU/RHuQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793738601; a=rsa-sha256;
	cv=none;
	b=Ngm3SQgECfVkbEvnvOPmSMguPNy4YuZESF4nW2o7aZ4cHxWApBeAVN/mmNpkYLcd0RQ5xP
	M0wyDw3ZNiI19LAUthOoj1VQDovf02fuw4WqDVhS3SIkh8BiSAvToJPGi+mVq5rqtbAtl+
	GYlkCxpLrrEHfN8ZhGzSBnggkiwjPFin+J3XvICAvnrr2/ccqd1K46ev37Wy1oYIV9/HOE
	34vAHP/p5FGwWL3a+pFynGmGlwzqADpmdoxVHT+pUhr7PLJBRR5crlm3dU3Caa+3oyiTeU
	QgpaYOvyfWaGfIjzo4QAMOhGR5ylXH7bl6DlUPKjTyYQHl1C7x91gR2NApWPCg==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xOLLl-002V8n-29;
	Tue, 03 Nov 2026 21:43:21 +0100
Received: from blackshift.org (unknown [IPv6:2a00:20:73c1:227f:2cd5:5d72:938f:f03c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 5FEEA5DDEC9;
	Tue, 03 Nov 2026 20:43:20 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	stable@vger.kernel.org,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 10/15] can: proc: reset pkg_stats atomics individually
Date: Tue,  3 Nov 2026 21:30:31 +0100
Message-ID: <20261103204305.3211144-11-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261103204305.3211144-1-mkl@pengutronix.de>
References: <20261103204305.3211144-1-mkl@pengutronix.de>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Runyu Xiao <runyu.xiao@seu.edu.cn>

Commit 80b5f90158d1 ("can: statistics: use atomic access in hot path")
converted several members of struct can_pkg_stats to atomic_long_t and
updated the hot TX/RX and procfs read paths to use atomic_long_*()
helpers. However, can_init_stats() still clears the whole struct with
memset().

can_init_stats() is reached from can_stat_update() in timer context and
also from the procfs reset path. Those paths can run while the TX/RX hot
paths are concurrently updating rx_frames, tx_frames, matches and their
*_delta counters. Hitting the whole-struct memset() in that window
performs plain writes to fields that otherwise follow an atomic_long_t
access contract, which can lose or mix live statistics updates.

This issue was found by source-level API-misuse analysis looking for
whole-object resets left behind after atomic_long_t conversions, then
manually audited on Linux v6.18.21.

Replace the whole-struct memset() with a helper that resets the
atomic_long_t counters via atomic_long_set() and clears the derived
scalar statistics explicitly. This preserves the existing reset
semantics for scalar fields while restoring atomic access discipline for
the live counters.

Build-tested by compiling net/can/proc.o on x86_64 netdev/main.
Runtime-tested with a QEMU + vcan setup on Linux v6.18.21 by driving
concurrent traffic and reset_stats reads, which reproduced inconsistent
exported statistics before the fix.

[Hartkopp] can_stat_update() also read the *_delta counters at the
beginning and cleared them with atomic_long_set() at the end. Increments
from the hot path in between were lost for both the current and the next
interval. Use atomic_long_xchg() to fetch and clear the *_delta counters
in one atomic step instead.

On x86_64 atomic_long_set() is a plain store like memset(), so the
memset() is an actual problem only on architectures with lock-based
atomics (e.g. parisc). The inconsistencies seen on x86_64 come from the
*_delta handling and from the stale snapshots, which are fixed in "can:
proc: skip stats calculation after reset in can_stat_update()". As
before, the counters are reset one at a time and the derived scalar
statistics use plain stores.

Fixes: 80b5f90158d1 ("can: statistics: use atomic access in hot path")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://patch.msgid.link/20261027-can-rx-lock-v12-5-eb5afc2d8b9b@hartkopp.net
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/proc.c | 39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/net/can/proc.c b/net/can/proc.c
index de4d05ae3459..70104f13077e 100644
--- a/net/can/proc.c
+++ b/net/can/proc.c
@@ -76,16 +76,39 @@ static const char rx_list_name[][8] = {
  * af_can statistics stuff
  */
 
+static void can_reset_pkg_stats(struct can_pkg_stats *pkg_stats)
+{
+	atomic_long_set(&pkg_stats->rx_frames, 0);
+	atomic_long_set(&pkg_stats->tx_frames, 0);
+	atomic_long_set(&pkg_stats->matches, 0);
+
+	pkg_stats->total_rx_rate = 0;
+	pkg_stats->total_tx_rate = 0;
+	pkg_stats->total_rx_match_ratio = 0;
+
+	pkg_stats->current_rx_rate = 0;
+	pkg_stats->current_tx_rate = 0;
+	pkg_stats->current_rx_match_ratio = 0;
+
+	pkg_stats->max_rx_rate = 0;
+	pkg_stats->max_tx_rate = 0;
+	pkg_stats->max_rx_match_ratio = 0;
+
+	atomic_long_set(&pkg_stats->rx_frames_delta, 0);
+	atomic_long_set(&pkg_stats->tx_frames_delta, 0);
+	atomic_long_set(&pkg_stats->matches_delta, 0);
+}
+
 static void can_init_stats(struct net *net)
 {
 	struct can_pkg_stats *pkg_stats = net->can.pkg_stats;
 	struct can_rcv_lists_stats *rcv_lists_stats = net->can.rcv_lists_stats;
 	/*
-	 * This memset function is called from a timer context (when
+	 * This stats reset is called from a timer context (when
 	 * can_stattimer is active which is the default) OR in a process
 	 * context (reading the proc_fs when can_stattimer is disabled).
 	 */
-	memset(pkg_stats, 0, sizeof(struct can_pkg_stats));
+	can_reset_pkg_stats(pkg_stats);
 	pkg_stats->jiffies_init = jiffies;
 
 	rcv_lists_stats->stats_reset++;
@@ -121,9 +144,10 @@ void can_stat_update(struct timer_list *t)
 	long rx_frames = atomic_long_read(&pkg_stats->rx_frames);
 	long tx_frames = atomic_long_read(&pkg_stats->tx_frames);
 	long matches = atomic_long_read(&pkg_stats->matches);
-	long rx_frames_delta = atomic_long_read(&pkg_stats->rx_frames_delta);
-	long tx_frames_delta = atomic_long_read(&pkg_stats->tx_frames_delta);
-	long matches_delta = atomic_long_read(&pkg_stats->matches_delta);
+	/* fetch and clear values for 'current rate' calculation */
+	long rx_frames_delta = atomic_long_xchg(&pkg_stats->rx_frames_delta, 0);
+	long tx_frames_delta = atomic_long_xchg(&pkg_stats->tx_frames_delta, 0);
+	long matches_delta = atomic_long_xchg(&pkg_stats->matches_delta, 0);
 
 	/* restart counting in timer context on user request */
 	if (user_reset)
@@ -172,11 +196,6 @@ void can_stat_update(struct timer_list *t)
 	if (pkg_stats->max_rx_match_ratio < pkg_stats->current_rx_match_ratio)
 		pkg_stats->max_rx_match_ratio = pkg_stats->current_rx_match_ratio;
 
-	/* clear values for 'current rate' calculation */
-	atomic_long_set(&pkg_stats->tx_frames_delta, 0);
-	atomic_long_set(&pkg_stats->rx_frames_delta, 0);
-	atomic_long_set(&pkg_stats->matches_delta, 0);
-
 	/* restart timer (one second) */
 	mod_timer(&net->can.stattimer, round_jiffies(jiffies + HZ));
 }
-- 
2.53.0


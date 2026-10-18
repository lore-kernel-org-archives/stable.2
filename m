Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745573E7166;
	Sun, 18 Oct 2026 16:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792341869; cv=pass; b=ZFMPOL50RX7lqIuTdJ9DBDwXi2VhM4XpdnRDymiAPzHrti4Eg4VNzy/DxSyBFyL2UHNZm+K8sO/9CS4hjA/b4WB+V1DNoEckZyvObc5b2jSHj7ZzbpqeCaLc2fr9fXhptWqsHRNiWY18beSig3NHrBFLB7XgLEYfM3/cm7+kKGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792341869; c=relaxed/simple;
	bh=dgKHErKsIyVita3zOnCK1mXc/fPgzHpDFHjWQcwpdi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K0e1cXn67Sc1j+oshk98yp2dDNDQ5dOA5IYhc7YKMCRDrnW4MnK0l353P2jO2A8gbLA9QjRU2SKb0nkjNHd9NRtsyfZPpnjQgA+us3JMYkPdDlMLwhB2DAcvUKqUfFRIknDxbJ3h131LHOnjzeHag4Ko46MrseKZuHvhrvCRXM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=EFzjcP9D; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="EFzjcP9D"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 06193202834;
	Sun, 18 Oct 2026 18:44:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792341860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pydj8cHNUhBQw6xhIpT6PBHMjbVNX0FUvQdCoFVhtm8=;
	b=EFzjcP9DaHJ9WqZkRcouWvZ7He7QR3A7B00u0nfiplHCSWLDJ4a1l6BPmpvKNrd+UijEAg
	EUjTOAN3c8Q5+tI+qmA9nKqlhJFAdeoJtgsMNcwJJznoNmMowYP51iB7JfwE+0/zPFccGX
	NLckil1RmKFPrg8KqfjceaBpVO513Anzpcd7eZM7zmSdjLFR/cOb6j6/ymFv7v25AHf+9r
	pUVYaWl01AQ/BjNxEDbJBLsXr/759esvcSpk/oq9iYQmP5YVUE62Qa1Dw8McTFPe4k9RbY
	lc8lQODv+Rl4lnvcJJTscq5Q78VKURWUzeq2a7R73pCAjXBnK7Lho0e7fXUTgQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792341860; a=rsa-sha256;
	cv=none;
	b=VIqEy4Kht8c2czKX1wPTY/K0LkAJ1ouZTdMRS8tOI3MnWEfa195el+nFh5JLJstxnTJVDg
	FVU70s9IE/wHkKmCLyxJ8EOSXCeYZuosfodmTluhNimGwqYDNsX6lbGaD45UruSfPOpeMI
	Sk+96GjpHHBHb0GsqYaqrIMFBn6kpaGF5TyN28I1urjchgo6sjqdvji6fiRlg6x7rSDEkB
	0Pep8lG9il9D7PM/NYSmm++o40PRl93h7AeN3ZDfxBU5Hr2mPZCwBRwqWxubaM7FmJ68R4
	NySdCHACNsdTinMKEFYqzp3/6qIn9TepnGnjzMNmv0HNLRyTCkdBzz8yvtZipA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792341860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pydj8cHNUhBQw6xhIpT6PBHMjbVNX0FUvQdCoFVhtm8=;
	b=dtEpQqczvfY29rukeLYFb/jAGqGw2A46k2TadswqsB9GJBuk1TcKqGLPkW9wyrQ3SFd1Lb
	lGpFRP7hF8Oa+Xsa4GpyYN+CmafzU5LICh2JoqcN8lYXQogr74DmHcwSGpmRS8P7YDOhIx
	A9RxUgi1M4+cvfY0V8foWY8Xre7PITjQx9VvapWQwB/mZQlxXSMfyknSDrNnfkZjiYSU8z
	+GqGvN9/D/3XTX7lDfdHinwBdISyDqiMPsu4K1TVq4ogeL4XFGk10e9WRWQKpjwy+aW6YE
	+/B7M1/Hbtwl4egUe5vN37UzatKJUxMDtEbdEugJebhZJK+xXuwIAdJADK/DBg==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xITzf-0006SN-2y;
	Sun, 18 Oct 2026 18:44:19 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A04745C7D95;
	Sun, 18 Oct 2026 16:44:19 +0000 (UTC)
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
Subject: [PATCH net-next 05/12] can: proc: reset pkg_stats atomics individually
Date: Sun, 18 Oct 2026 18:41:41 +0200
Message-ID: <20261018164417.1540449-6-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261018164417.1540449-1-mkl@pengutronix.de>
References: <20261018164417.1540449-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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

Fixes: 80b5f90158d1 ("can: statistics: use atomic access in hot path")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://patch.msgid.link/20261016110905.422684-1-socketcan@hartkopp.net
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


Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20EE28B7C8;
	Thu, 15 Oct 2026 01:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792029223; cv=pass; b=YQ3u1YTJP30eGxZLdA3W8JdNXaHOwnMCy7/AqSjp22TQZOx4SF7J8bEnww+aWudQvSAqNXmO8I7WdbfxtsC8IaAWr6WN0asNL7e6sTVW36aDLQJXOdsHClLqL+SjElHTBxVY6/ZMck8Z1EqCOYaYe/JGi3c8fdJgzhvOm0QJn5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792029223; c=relaxed/simple;
	bh=4WqM4KHYIgPp50VhN6Z5H13Wq1tP06LU0DmWZcAnruA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PzrMaedReLcb4zh7ecvohCKVxpYYa2x46hUQdz6AmT5hsM1S3HVP4k4/i/1s2b2el+pgW8AAwLR1Rnz9N3wm9B7LYVBfSR+ZiDSLxufZk/NoW/qXt2WACayvj2KooUf8WGkpTY0Cg8H7h1ouWrXOSyvJnjxXgGO8HYJncFpbZoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=AfbsD1ef; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="AfbsD1ef"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id D1237202339;
	Thu, 15 Oct 2026 03:53:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792029219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5L68qtM2YInkegYSK2OIj8sTeZLAq4KkF25qopMAdno=;
	b=AfbsD1efKYZCI+m+RAULzBDpfHjb29fdcZ831M9SAtl3bQxFBYfHtJX1GdzpXi8u7MHRrz
	yeLAyhejW7Xqv0RRLVGhYEWiNvLgWp/m8sbP3WbLD9cQi5HWuLWcC3oHWU0T1nyNbVgC4Q
	ghdw2PvX5AR2TBWT+mlHI//BTGkbLHH9p0ZsOOoBnoDRcmLvmncr5La1HSb/VFur15NOKZ
	qzC/cWaDr4+h9Lg7QCGfxRzN7oYJX7kuhlN7pXlLE7NtXVctpqbFqjea3r1baqwVbQEh1l
	ihNBprpG7n0RajTDTQwe8vxaKX3nbQp4GYEhYad31xZMxo+w0riKZtOvZON+Wg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792029219; a=rsa-sha256;
	cv=none;
	b=ZJYVZQVQ2PNYIpK+JYYtZ3LRhJ4v9qHGC3lehRY+eiWgxfGm68CS356u5Ea/6WXJ8ElZhW
	J/VzqLLTNGSsAFI9lqMBCzaUwnM4GfqBOGw0upggO8nAJ6Qbc5SB7qsKzYqA4+6tKTo0r/
	cQAuDtP3oPYAHonkV2JOH1ZqasLw+4fpy/V4M/h168Ro+qwgEzIk0eKvtZtyw5FNC6klGh
	V0BwPpqe3ccl4C5uSPETUqr0EP319ASZ/AOONVjEnJbi6cLsWAdaNafz/RV0nZIxdetKtE
	xjlq9RXSn/YhHaElXqOv0yezRgLD1AjIB3OTu0zINGPLEArM+a/HgGfZD56TmA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792029219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5L68qtM2YInkegYSK2OIj8sTeZLAq4KkF25qopMAdno=;
	b=M34dwwdbBL/JYDwfzFYU+io6pwS2qchXTZA8JZg2fzLfHa7NiB4OYEr1TrZwl4aKB9UjYR
	Z5jk5EV0YKj7Q3IrTJvDVeOkNms3I7+0UC3vjSxVdgKiFYgHJp8i8lJ6JJrWRE6Yc+/TAM
	ADSqtqYos9xiWGrks4SJ4SM1+e30zZ3Ja7nSHo9qDOOF6uZvq+NBuChpl7EnJCEtuXlq7+
	AXXfQLwONssftfjKjRVFCIlW4kfdBlDMCAon6/smHGGKjAKBGGiHYvTTPL8yj4saX5FPPg
	ej/pdsm/dR4w+Tycr91162X2dIJ4/gVUAnKP/EmkbG39A6iBNLeOS2e//mwzjA==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xHAf5-005wpn-2Q;
	Thu, 15 Oct 2026 03:53:39 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 7C5B25C4777;
	Thu, 15 Oct 2026 01:53:39 +0000 (UTC)
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
Subject: [PATCH net-next 04/37] can: proc: reset pkg_stats atomics individually
Date: Thu, 15 Oct 2026 03:40:02 +0200
Message-ID: <20261015015336.816543-5-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015015336.816543-1-mkl@pengutronix.de>
References: <20261015015336.816543-1-mkl@pengutronix.de>
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

Fixes: 80b5f90158d1 ("can: statistics: use atomic access in hot path")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://patch.msgid.link/20260512133937.21957-1-runyu.xiao@seu.edu.cn
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/proc.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/net/can/proc.c b/net/can/proc.c
index de4d05ae3459..64b3bdc2fa7e 100644
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
-- 
2.53.0


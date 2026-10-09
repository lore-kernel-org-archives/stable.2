Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757C7364949;
	Fri,  9 Oct 2026 13:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553416; cv=pass; b=jW6cx9wE2QxAKhDvXV4yUn4sH+ruKkQsBI1QtODvV27f4MBSH4bXANuCbJE9hdBjavrODOdFkiGZCWuhWjzdpjfVtRlNKFpLXwbSWfl86C4gPnXjbSvg54uQi8y0A4SK1IMaXUKI88MeWgbcW3scWj8gzd/xaSmzxGcN/Yahk68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553416; c=relaxed/simple;
	bh=4WqM4KHYIgPp50VhN6Z5H13Wq1tP06LU0DmWZcAnruA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gWqgFqIkrR0W+X3Y8imafEBFD0rqUdwmBgalCxp+Go56E6/otxmKS8CEN7QOCJ5itHRqLGXwFiaAMLDsbHj+ZfCIy/6BsOW48UiMzCLUQB9F8gYvbNje9mSv3/MdplikMM7QmNo2WU30iOw2b54BMNI9LZuIMKqg3LcRjAYNobw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=Yz/X2Qub; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="Yz/X2Qub"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 9E153202603;
	Fri, 09 Oct 2026 15:43:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791553412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5L68qtM2YInkegYSK2OIj8sTeZLAq4KkF25qopMAdno=;
	b=Yz/X2Qub8E5xZqDtb9WSk/uMVmSzEdTiEae30NXXOQxv2oWj9VQi1AOzuGdGdhQsA5e1mX
	Z0+FX1iu4UN4rDgDGVVchE3d5s0eYoFigOj0QB2JjFZFyvF4yrT7equAomWXdl1SSGy3jB
	HqzVz0V3/0obsIQQgMr6wHhb/50fYcQumgBEOElosIV6KmAkYnKXK3ffmmC3++DR2dG8Av
	q1mSicm25DG6u21zM+4wN/B3ZqkhYFfiP4U1XHxT2EFZHfv0z8aBXxdOoqbukjVhpHCnEK
	5Fuisrm5S0jp6OJchx7hmAZoc0nPJBiQTvws/jeHzFotaxaJSi6jv5d/bjJ3TQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791553412; a=rsa-sha256;
	cv=none;
	b=PQKpii+/F2Fcy6XBAgOab6Bn1Ql8AlZcr6+KVSlyOHpsr1uCCmoBmzKQUhKAt3oU+Na1V7
	ytgJ47J1GjW2IYE49rFdqaTYmina2cTBGbnxp4nS0caN5+R63CzZOADB6fcfOYmT0W4snW
	plb6pxbXn9PzMG7eXvUFmWNYBnvO2TPAAyJxikuaCU/g6aDxUrvFcfGVI0A/wVjR0x2l2K
	A1VEVgSomX+Mxxz/xxcjmMM2WXhJlC+Q4QU03XvknTKjTuqwlhDjDZdmbBR/omoQwxg4WB
	j8nmgh38nWmCIIUHHbrhogDWn2KBbxfPdbJ7bFk+TQU6kpvfIh+HXnbjLTloWw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791553412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5L68qtM2YInkegYSK2OIj8sTeZLAq4KkF25qopMAdno=;
	b=EgfHy6dSpLD/hMn9A2jrKFfkepxeO6p4m9NwpzOV6i6uj9JGEk8FySEmKNDeZbWtcCTaNL
	m77HXk3OEUecetbSzizTye1H11t1Li3fed9WB3G/Zan4B/bwFwD2NsZjhY7dTW6DbUexIB
	e8mP6wx+FB6zvw7FIkj1tGkHzO8tBYrf5Bg+3ItAHltwnREXIiFhFapGN8STa0pZ7G2JnJ
	8H+K3Jo5PQEVLd+Vqoa3Zdk4ZrVlkAnGmMhfjW+ce2q++tBUC2Hm/2BryfXHhIM4+PIT6O
	/KxGFUWTqp9+delROOmMf0hjxgUFfcdbldNXWizIFXoS+k4R6GgdUPCAjsRb7Q==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xFAsm-0053Rk-1h;
	Fri, 09 Oct 2026 15:43:32 +0200
Received: from blackshift.org (90-182-211-1.rcp.o2.cz [90.182.211.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 194FA5BD89F;
	Fri, 09 Oct 2026 13:43:32 +0000 (UTC)
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
Date: Fri,  9 Oct 2026 15:27:36 +0200
Message-ID: <20261009134323.64064-5-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009134323.64064-1-mkl@pengutronix.de>
References: <20261009134323.64064-1-mkl@pengutronix.de>
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


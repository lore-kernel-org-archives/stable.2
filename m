Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=81.169.146.220
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792757909;
	b=MuLvQNoKl9N5bsuJ90eJ7qVtkNLQ6KABGZIoiKXecJAdK1s9jXrtJII8XOQU7R+9tUyC
	 KW0At7yaKZBMDCPjGTtWSKWvdpc5mt/qP41Mj+ToUYOp7fn6kJkRqQ0rIhHwmZm2cGxlL
	 F/iZ0XhYHCxJp5+xCvz+XZDO+MoWfUThHjGLOxCVBFtLPdy3YiA5Tj2CWLormQGM7g9Np
	 QgcqfL6GRgW60QONH3KGU3p7iK2yLrMrbrXRAiyhKoiWR3Ae6Uy/VxX29qdUvl3Qma97d
	 GyXWHSfqwBFuFI42OrFHWWz6JVJZX1rNZ+34wrnY0kIktW8MkWQ5PGeCv3Fu7U8Yp+Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792757909;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=nIXVAY1OU1D7ohN1HEmJkRT/3xMBDrW5js7tDESAf4A=;
	b=xLpautQTjC8wlo3Jnvz9ktDI1Pf5dxHIPpYBeehxkjmOOMzZagFiw30f9fm3oHaPlWLX
	 yu9qfuE29eGZPGx9ExwZ5GQY38cBd3Xxy5QxidULGHcdqClENmMbw6aj8BCvJsqKoZxev
	 j/te78MpL+8NjpNq/S0MKj74XOD81DO+l+wy8lN+s5+C4RhPxvuWsV4zg2azCwctPYRpj
	 YnM5yPXOepGEKGOjkGcaqZEubdGmcoSonLDzH8rcVDA61EaBa4LNBKv9lU6LoEB+keXkr
	 eX6Iz5UJtYBD8t0ZYp8rmM+ZShHWHIICvJhOyGg/tWeP2WE1UW0IUnoOD9itIkJlSsg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=W935Qo1+;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=a09shv+6;
	arc=fail smtp.remote-ip=81.169.146.220
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.220])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72289606A326;
	Fri, 23 Oct 2026 12:18:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72289606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=W935Qo1+;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=a09shv+6
ARC-Seal: i=1; a=rsa-sha256; t=1792757896; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Elr/09m1c6UcT9toorALfEH9BQYvMqFWsA0yxdjg8yDSe+TQ87q7KX5jCJZSSmd4XW
    YGlduhxs3ZtMUPALQO0UHqfJI8r9BS1SH16WXjTFIDqNq7kBOtL1dWO9cL6UE/U+Zdmu
    2CiRNJybZp+tUMqjX1CZrY7rbpl169ZLUiLr7BhSUUeHIubXLhC3UKHLcz+jGl9Zhj9O
    M7d0ZKvc03HF9jZfVfO3a4tt2e0/voh1WtpMlA0bOb6uxjZO/j5Yq5rJaNCdfx9uX93P
    0rl4mbx3qfDITM0aKkO3QfoDtoDAJGUZKTJsrASskisrltQw/MIxWm1OmtACkxo1v6uC
    rvBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792757896;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=nIXVAY1OU1D7ohN1HEmJkRT/3xMBDrW5js7tDESAf4A=;
    b=Ydt82IVmtRbMVOH67PYOARMTsSl0tubZTV59hC5UsSejrMFgDpajQNoekZD0CAHmso
    1a/yMxGpCS8zpZrO6bft3bfEayOTt8IHi1MIWZ45Ll7fwyv1GCPhc8MxJzzu7tMREHJE
    HP87v7AHZOI3R5KZaEfYsRPk2v4RG+1bFHSuZ2Wt7RpXUIg2/BP9bJj46+8d6vz+shzw
    hdm6zKrD0qhlGPtObrxteypvocL0zDtqwDpM6dNY/MFD7dWPTTDfJJ1kdJ6Yz1Y631Kb
    S8Y5rUA2UyxuFHGMaSE2TOQYjAISLXRx+zcWsuQcdNU9MtvkWBDptBSuXDlYVCialv56
    WXiQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792757896;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=nIXVAY1OU1D7ohN1HEmJkRT/3xMBDrW5js7tDESAf4A=;
    b=W935Qo1+kDjd/MZE1DSyitZMbdi97yGvgwqMxUHha9JfRx4tWVbm12TR1Yhvp9h2yJ
    M4jVV5qP3EvbVsuB/kwiCdy+LhR5RJf1c/Jo3WT4SJphAYt/osALyLuQpUg6/Ic+rwOH
    2UIXZTa/xRoPEG12pbvbMqrpi88QA4vdW2S5hehmzc3jz97iRCpqzdKzrg1FfD+fO7RX
    GpAW30AqMJoT2JwkhyZFsUFKB6NU6JtvHb4JTqbKRZ/pzAa+daBIV1hOCsCBJ9csoRpl
    OECCZ52qTjs/3f82sRygWMp4WoYt8NQe3d+iflgU81sg6p+63/YDpixKEJgt9szFKjAA
    wX7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792757896;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=nIXVAY1OU1D7ohN1HEmJkRT/3xMBDrW5js7tDESAf4A=;
    b=a09shv+6OlaGsz9sbzRzLLWRv3djoVAlFampLHnlMjWd/cEesuJE7lWIf5TEa+nhFQ
    0FfqqJeoq7wk5qGU3GAw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29NCIFt5k
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 23 Oct 2026 14:18:15 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	stable@vger.kernel.org,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v8 1/7] can: proc: reset pkg_stats atomics individually
Date: Fri, 23 Oct 2026 14:17:55 +0200
Message-ID: <20261023121801.3052075-2-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261023121801.3052075-1-socketcan@hartkopp.net>
References: <20261023121801.3052075-1-socketcan@hartkopp.net>
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
Content-Type: text/plain; charset="us-ascii"

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
---
 net/can/proc.c | 39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/net/can/proc.c b/net/can/proc.c
index de4d05ae3459..70104f13077e 100644
--- a/net/can/proc.c
+++ b/net/can/proc.c
@@ -74,20 +74,43 @@ static const char rx_list_name[][8] = {
 
 /*
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
 
 	if (user_reset) {
@@ -119,13 +142,14 @@ void can_stat_update(struct timer_list *t)
 	unsigned long j = jiffies; /* snapshot */
 
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
 		can_init_stats(net);
 
@@ -170,15 +194,10 @@ void can_stat_update(struct timer_list *t)
 		pkg_stats->max_rx_rate = pkg_stats->current_rx_rate;
 
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
 
 /*
-- 
2.43.0


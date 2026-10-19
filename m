Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FDA377A9E;
	Mon, 19 Oct 2026 07:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792395969; cv=pass; b=rydj0PBgLoT7EtBuWKzQg6uzengeq8I2HpJGdBKoG6a4hNQPyevO6eFDbkOvk7Jdux9hs280gXB48FF8pJj/8B5HdZLBlRIN5UCQgV83PO06vZptL2Ezm0CcaXpcQf85MWr7y3D0jc8YLTbAqVySJhIjgAAvD8DYxB5FDAiplRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792395969; c=relaxed/simple;
	bh=8V4hIVjsPeE9t3hG66QEJVH5vMuYTuY0N4k4UAsn+t0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S1aR1/lhSyWjhtV2mtOgdaiQ0IfJVzRyrc9CK2bg3VX9PhCNDAvxkzuo0zy4ByJ9ePXGH6RLJVQNGaELYWJ7J8iGgvLio7oohLkiFWxvr/E1/jEdTaPw9kEFvoi7Vb+lZMIoMOJnL4MAyuSuAqsQBfnvZ6Ln1fpNJw8VmJzNPD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=d6o1ZCSK; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=iVrRxHk3; arc=pass smtp.client-ip=85.215.255.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="d6o1ZCSK";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="iVrRxHk3"
ARC-Seal: i=1; a=rsa-sha256; t=1792395776; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=iet4/piyD5cXN3X6qHVBJ/CZ6UbBxohIGDM7IYdK9tYysDkQIGwyJhqU6PaeV4HXpF
    OB64m6OAaF7jYWQXPGV942PrZkw0IzvY0yuu/sxJajXFMs2krekqE+Ee646W91I4Dm8y
    AkYvHQRjuOPdrPzqFzVmtru+zmLJQ9QQWRR7bZF99rd6hBVAYynPeZ9l91G9r788u62O
    xSElFc9qX1JInTVQrEXE2eTAQpuQT2qnJTHp9px96tjLzkKjEJJzv1HkNRASBnyMtHXc
    EP7HBTImWBDux4xzzGgfI0zx/SA4KmTQ1SWMx6fVIogFDD54p3EQPOUiYVAXFUnnLWib
    O3Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792395776;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=nIXVAY1OU1D7ohN1HEmJkRT/3xMBDrW5js7tDESAf4A=;
    b=NqSsIl8f0j+/TI57DHlQAeJ9AOTjWWX+OqstDlM8TlJa2Xv+VqdDEBePiURonifuhq
    ySM2+GICCRP4PsDq8VVVrxDoJ14BXGyWbNjo3aWaTlTHs2uWuT1fyT35nZwFbHgkl4Mf
    Rxpj6+aStcL3dL+knHcL677wJR6MtHZpbqQBheMAiqOHF1c/2PTH8WZs9rbTsnhYQa7S
    loqdC4BxI93P/NnJ00/x9FdumY7uy+V8gmcBbCs34KN/AZ7bXOlV6ohAHpoue3Dfa9qC
    jghEERj2il9htyUNKXLq5Pj6SJn9XRdHyjcG3lyRDRpln5PFvNVYIn7pZ4bU7zziWyHI
    3ROQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792395776;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=nIXVAY1OU1D7ohN1HEmJkRT/3xMBDrW5js7tDESAf4A=;
    b=d6o1ZCSKA3bbjlrGEMPaRZgtqm0kbnv3jXKFaeUs7rTDVUh047Vlw3hRgqs28hux7w
    C0FxekeB/OBw9b6PEQe72GMo07f+he86xNHcd4lTvlCxfZr8D9YOoxKHsyrzbYXgvz8w
    O+BxyUGzOQQQ1rxcmdxS5f7fnMpefF9Jp288TNeltH2wB6FhB1vMxr6QX66nIN5sEa3R
    uiFBpd8v60HRBSnq/hkGgKeQR+KkmICdLOQR0g51c4U6VfWQ28ZMRwM83xtto2cz9kMh
    xYA+CyRkcwUVx87WRM8NwYg7pevaXHJWbU2WGtnMqSkPbYVf/OCrjOxkfdMf3xSepXTC
    N6HQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792395776;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=nIXVAY1OU1D7ohN1HEmJkRT/3xMBDrW5js7tDESAf4A=;
    b=iVrRxHk3+q1ADaM5FKqO+YimwOKFAAzXnThaKmNqRigjBbeCjTJXUL40LrN3bQ0yBC
    p/qRb48MTJecEoJEfaDA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29J7gtUqD
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 19 Oct 2026 09:42:55 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	stable@vger.kernel.org,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH can-next v3 1/4] can: proc: reset pkg_stats atomics individually
Date: Mon, 19 Oct 2026 09:42:40 +0200
Message-ID: <20261019074244.50391-2-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019074244.50391-1-socketcan@hartkopp.net>
References: <20261019074244.50391-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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


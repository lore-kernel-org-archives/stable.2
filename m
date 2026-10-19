Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.164
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792423680;
	b=QeFSuR4her2UUZUmHL2ImF7S3nILECnOTg3OSzFv01PVGgwlsoIcY1S+6O51ZEb7imfE
	 4c/7AH4Lw3aHl2vEMKzzC/gMbE451sehiNFxWzGwel07oroQ25YcbASNuFgJFNmVp4eOL
	 Hg81Udf0TDSKjR5Q4Ol8zc9Oux5ItW4Q4FFB9W2mtxL7Jscm2us450rZhTwL+HrhZBsQ9
	 uuwcwMHQXujzSXRWN0psU6YYgTuQWMmr/wiwPkNfeOUL+fKl9k0wPHyahlaoxpqZuetzR
	 oDmFGarZNp8nWn0LpSPH794yPDxfJceuZBZSpVembP/+mBZZu6KRsR52BTmhZ7fm6iQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792423680;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=nIXVAY1OU1D7ohN1HEmJkRT/3xMBDrW5js7tDESAf4A=;
	b=v6o3NKHTZO8k/IV1XhK0blzu+2SOnddbbgLNGjOQmyqeFgARtgbmrb/CGTG1QzlLhR9u
	 09FBM5LUOZXiZGHVpbO1PuaFVJae76g5jVJ/73Cp1ZoLSQOewGquvFDu56tuQXvs89VTD
	 RE5RXrgrh8uUAD4kBFcmDqr0Qb4VIqcyAJwVRy0qMGtxgPSybmP0f5cbMKeLNMa5ZWghw
	 3bvGD3u2uR5zh2DRX6BXKgT9ty/bx9XkcsFr28xwqNybjhJFTqtJAFKPGxkC1ZJknJSnN
	 xx2qWa4swkgkyMhpCHbCuN8FQ84gmevcvuJ5kcuOaG9L4FxoDX//eyUX9iVqFpo9V7A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=gZwRdT7c;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=vhCJLRqb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.164
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770A160B507D;
	Mon, 19 Oct 2026 15:27:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 770A160B507D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=gZwRdT7c;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=vhCJLRqb
ARC-Seal: i=1; a=rsa-sha256; t=1792423667; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=bmvwdTDIjgmkHwf6p6LKskLAFE/UowFZfkH21Uej0ZHiL6oLeSTn/U6O9VVhQcOJkY
    lGki4FmwYQB+9x1jRZQ5Z9T0DR7/Uy+WNoUy0AmjdAKs96OgWkT/gdzGA6mFeub0LhHC
    TH7AIO8Gri5iqjY723Y+B1Gxk9Jq3jgw/snaA8kjhZLM+r+ECUWJzWChcAHwYH8Nclk2
    D/FrIYQ3Jih4owQoFQ87dS5NRuXp+8lxHD+HwxLkan/FbPYVfEe7P2n8bRonMueME6NQ
    YfVWRrUOfx/bistJ/V93hRbeIq0e2f1MENO/URvbhqmONDXOh/VRMjBWRqvXZooLpCBp
    oFhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792423667;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=nIXVAY1OU1D7ohN1HEmJkRT/3xMBDrW5js7tDESAf4A=;
    b=cbaExNzPN6fY5CcX8xLjRuw9LEjXQ9hkxxyfIdwk00kpSTy6Vinx36iT2czZdHPflA
    GflpOtmacaeFTPEtDDgma3PmDe9Ak9CtP6i2Kj/n/ZLHvF5f8VUIkp0nlGIVajbRrUcB
    hzPwJpiIQd/UFASkAg5rBWahUf9TRlFCGNn6XF4ZYiCB+aM99wEyiroLYryDPqITEJ5n
    o/s6qgp5GirkjJT4Nc8Aab6NmeghJZiwEtM5NKz8Voq4Mg/JrI3tCRpGgeN0nINQLgk6
    5cGVaV2TNLXVPya1YXRq8g0xKYSeT3ZZfuqXx25koD/M3Aa6VJGlGF496fWXPGqBSVUx
    7DfQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792423667;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=nIXVAY1OU1D7ohN1HEmJkRT/3xMBDrW5js7tDESAf4A=;
    b=gZwRdT7ce6CjS7daRrqeiAaYtCpQQLyzDgQUKtbkmWbe65shC7kvAVI6NxoLgdKmWJ
    2tkEKmRwFQCnkwyNAjYZQ979x01rioukAyIIckznH3DjYvFDhPklKrUU9zIPXBza4kam
    odvvIQ9GKwUPQoj2/iMRaZCC2rW4O0pD7T73Q4LvfW1jtPr6Pt3q5/vZiNY/YvUc4fy1
    VE7tB0w4gqPASBQfqWoC/aFQhvE8nlvF82POq95ju+JejKdCUDkMDGFXbwJ3y0M6Ppqp
    YNiMBaygCfWUBRprBq2ngTU1WNE2iYzQYSE6vzMF2xP91/jCXXprhND9nj373/3dTBPX
    Pq9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792423667;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=nIXVAY1OU1D7ohN1HEmJkRT/3xMBDrW5js7tDESAf4A=;
    b=vhCJLRqbNHLtsDGydvj4tTf7ttef86nv3bxepzk9Qnaf02/e6iT31iPJzYJAMC5bkG
    FBObTaXRdI4S0MJtuXBg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29JFRlXY3
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 19 Oct 2026 17:27:47 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	stable@vger.kernel.org,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH can-next v4 1/5] can: proc: reset pkg_stats atomics individually
Date: Mon, 19 Oct 2026 17:27:37 +0200
Message-ID: <20261019152741.54854-2-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019152741.54854-1-socketcan@hartkopp.net>
References: <20261019152741.54854-1-socketcan@hartkopp.net>
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


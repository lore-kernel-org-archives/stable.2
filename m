Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175962FD1AA;
	Fri, 16 Oct 2026 11:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792148974; cv=pass; b=FTClGfi23cVQyFIRSC9oLuvIGSvWUaaddc71FydQ8BScDQTthdDoPU0zfHtRjEJpR9JE3bDy8l6l5zIfeTH7aS8FEhvH9+zLWnIUp6YD2wJ/0Be7l5caQj3mV3bm52qe6rQ9/rT8y0TsJ2a95Lz2lHIOWvJVCeJHGMqqOWwJF/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792148974; c=relaxed/simple;
	bh=vGzZ+MBEPXguplbtxkwYtSBJCG6CCHICV4+5Upj1iJE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pLEzUdNFjHattc4AvaQtAAd/KiXW32QCGmFpQQHKz0+HCAPe9LUg1ZzCaMrQEX41LH1ru3Ubiy6ublFUuWSh5pYRE5w4an9yR44TJAEQ7hS/a1KIo2uwz7cBsE/irQ5o0ZGOFIaq/FqaHgg1SCNGbDAnQ7xwtucKkOIHOmZ4RNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=aJ4jzy8F; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=+jNY2h4f; arc=pass smtp.client-ip=81.169.146.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="aJ4jzy8F";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="+jNY2h4f"
ARC-Seal: i=1; a=rsa-sha256; t=1792148960; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=E+VMoT+uOWWKfvl7KoRBIyctNN5IBY8xx9Difu0Rvrs/NeczQ59ZWJ5k9695sQoBQG
    zVv5PNuPHbXZ/WT5jl1ea2yGPrYMZEW4OLJpekF+VVLOjDGhPbTmFvrD10UgR7/8oih7
    GOL70WKn7iYd4Pw2bmVZq4/vbJZHtlBsnUL4CeojWKmuDswal32z++7ggdlW4SyQ92AA
    FHNHO3dvVerMY0M5J1/SOBnVc52yUEt+xxHbTAp437j3KEUzeFkZoS/GtZ+hsTm8F89C
    FB9dQfUg7+4jtA9SDr68h061HjKjCH55JPTwjkfhF7dtFhuZ4olaE9HpMeIBvIdsIGKl
    UBzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792148960;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=McFrYy+D50eJ+Ysz7OQBvxbjuPSVmBEbgWBKPh7jbWI=;
    b=V0So04FvHvvhQCrbpG9VMz9X+wW+CXk3Utu2i6/FrJLLrEMGNkHMs/ltKnEV7xZX/2
    YbjvKFSjLvWqQq3dypfz9kxF5Q2kuhjpk/Nn7ig8FrSQVIfquw6KsFaqCYdwSJOAgA5i
    cGw+yCgucWeMbyBtiiK3js2mkuDaBdm+ruj8j/AtsUzobxqSFrfnQQ+IPnbm34RC1bfO
    HcrRjXSjOvdr1U1vTI/88jONLtQvoUN+xD9ZYedB2GzcXOmp0LuQFbPwZnWKNcAOphKD
    DoYgyRp3MUA98c3CzMgz5JfMEKpwpcCyhV7+ZMX8RJSP657IuRzXlVakMsHwUHXO+o3N
    sBJg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792148960;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=McFrYy+D50eJ+Ysz7OQBvxbjuPSVmBEbgWBKPh7jbWI=;
    b=aJ4jzy8FvsqwVvXioc3QTb+pe98u+C0hXiKV0SoXM/ezaL/xCo3O7G/ilUTA0Pv/pi
    u3/bqPs3tWXbtGSh3zkadMwEv+rcMyuuZEMFoCwdIH3k0ZSmytDtlVFOQyFMe0rIfqmp
    kx5b+5/a21zXMfAouaJViJEj5Yy7pnKCrALNv43Pns87FIy/bc0QAK7cwEZ0y2yYoodk
    uKRQDQLxXOloyFUsTSY9PLNItbw95nFcCb3uZC/QdKDRBUPrAbTy9PbYlYu38ZS3uhmj
    HqUOyDBbEPqrr8LRsY9EIKqHnSHgjxwlfzTPRKNfzWtHvIsLOVS68rSatqkVv7AzLGxN
    V7eg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792148960;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=McFrYy+D50eJ+Ysz7OQBvxbjuPSVmBEbgWBKPh7jbWI=;
    b=+jNY2h4fdhUBJAJVvRfcrWr5kgiDabMInRiHMoBO6MN397dbn9lCrYTesWWHQb21wJ
    +TZlmo+/OfNL3YgxKFCQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29GB9JLxk
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 16 Oct 2026 13:09:19 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	stable@vger.kernel.org,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH can-next v2] can: proc: reset pkg_stats atomics individually
Date: Fri, 16 Oct 2026 13:09:05 +0200
Message-ID: <20261016110905.422684-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
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
2.53.0


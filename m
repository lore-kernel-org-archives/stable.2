Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.167
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792669345;
	b=YlRvpBWwQGEikZLu9wz0COLyKEu4sUl2YOADhTkUIJHRf+a3N3UoLzlm5/cNrBsfWpWK
	 OgtGFVUTh/tCph0kP4353ALLR9EKi5HYQTBSjl0Hb/Sy+DFAGP21UmuD2+r2gd0fqRsds
	 ZM2C+idG/Cn+Lh68QyKYNbIptr4qMdpwKMNNvrM7chJo1YzRo4wSa9L7oGbbM+79uKbEK
	 Ur8TDBf7H+mBMZO1udNpyIPg+zbHt3y9rUT16yr51YMViByeQTqQf8qzzSPpoDS9ZJ88B
	 ZYpbXVlbK35k14S2UBmvyvEIjQDOeYc0BujvxaHFdL5qfKKmR8mjm0S649armeYnAGA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792669345;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=nIXVAY1OU1D7ohN1HEmJkRT/3xMBDrW5js7tDESAf4A=;
	b=iGtiKxdahQdG61fFJKkl3QzIcgT294gQx1Tuyd6kX3s4lkSx8bjvyx2L4vZnKQK/GhJD
	 xnhmts2xXQ6VP5xq+LQ2UuCY4oIu78g7md78E0QpJSOXOfzHvXQ7I/ZnLQfj6hrOv7UOy
	 ALCsWvr4ngFEKxg7UubMnOOkVSQCkEaJztI1M4R0Al3q0M4QA2Jg9hysITAWYnILbvA4f
	 mVesAhW9zlQnJowuazU3EM37Z+ErOEdSlu90dCdJj685U41bhKlutrhqfphs990+Y4pFa
	 KJNRPNPSQ4rtEXC2goyJf9ZOglvUkacGIUk5fRVW/wtC8PbqM2+UpmrM2qMTUuICKTg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=TOEIyGoz;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=G2rOlnPE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.167
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E994606A319;
	Thu, 22 Oct 2026 11:42:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E994606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=TOEIyGoz;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=G2rOlnPE
ARC-Seal: i=1; a=rsa-sha256; t=1792669338; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=XlWBBUdq8A9b0bQ2niBf4QznszzYcYXgXldaiwK52Emjd0FtOZIyiOxVWj7m1iRhTR
    cKi9VkADr1YYiUy1zXoQ0U4oxSUr2RcafH0+tjsqB0myOd1GGDRAIqbSPmTKct6R9LLZ
    j9lr+EyQRCxWFO16U8f8uKwQrS7gEYlVXW+jSoNBhAZ7or7nJYGZHujq5rXgDdS0T4sf
    gVlvA6v5Dx5/+RF3NEswtEamhfB51/L7/yNwIVKVpGCbh5I6GugwFCYr8dIsBnVY3A3x
    xWI/oKrHtbrhIKir4syaCMh90bJyqgR8CQjusD9C3VCWpuJrYT0fqTKdzIbv/tkdURcD
    mm8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792669338;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=nIXVAY1OU1D7ohN1HEmJkRT/3xMBDrW5js7tDESAf4A=;
    b=VufHRuTUjgZaqvNndgruJEw/q5kucv/PXWsWHS7xyxS5nxIl2bhqhMJ76bnzMKTxhk
    uflkS1V1jSng8/82f4nXmfE5HVAw09JjRtT52g3L1lPqpNugNzFUz/tltbLg6EkaQN7S
    5emgB6bTIIH8zP+5cEClsSp+Tck7MwoMhCGqPs+JaCHvi+7igrkwczFnnPrVVGJsXfDP
    GlegYirmuEFfMbIu55ZGbwIbo/h0Tl8melyTKRgNGsGTm8MLvAuhdZhPJ6K78U3N4TqR
    qReadtbn/M8RepPSYcvon+dKtvhNNd9U8nRFkuqT9eG0VWGb/Odo055ip7qbO0Vpt/4P
    jlWw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792669338;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=nIXVAY1OU1D7ohN1HEmJkRT/3xMBDrW5js7tDESAf4A=;
    b=TOEIyGozrjtXwwpZNL0yGCcMMvxR1VChcoDh5ib838dnBWVKe8I640qslbBDuqfzIS
    NCPyRnfcz1KvwqBrTvHopUU+csgWUTuegvf3FDtt39qfNlJD0kkjYLHXOUWWhgH9c5wE
    ZFMdHa/bJ0PJ+P1Thg5VdTANTq//JOxlFG+WeqiQ+idAfrcM8BkJ1EEN6FDiLpZDEzPZ
    FtrJLZpn8LMhZmtH59dI8EPb6+UFHbv/FVO8qQlrSxQv+reDcv7P29rBCTWBra3p+gni
    ux4r5wjIHpUGPjMTI5o4CGoICfFX3vleKCPgjwIn8nvDEjJE70XwTcW5bt72qzfNT4L4
    sIKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792669338;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=nIXVAY1OU1D7ohN1HEmJkRT/3xMBDrW5js7tDESAf4A=;
    b=G2rOlnPEE1v41MPiBK0SLSVQx+4t29gH4lLPvyN2+Xt3A8s5ESiewOFujRiaiy8FsO
    9EdfqcizUuaNjnwDIjCA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29MBgHo51
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 22 Oct 2026 13:42:17 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	stable@vger.kernel.org,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH can-next v7 1/5] can: proc: reset pkg_stats atomics individually
Date: Thu, 22 Oct 2026 13:41:57 +0200
Message-ID: <20261022114202.180023-2-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261022114202.180023-1-socketcan@hartkopp.net>
References: <20261022114202.180023-1-socketcan@hartkopp.net>
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


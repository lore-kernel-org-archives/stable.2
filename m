Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792624303;
	b=Y/GuWi5KmK2ACA24yjR5kwebRNeEpgyAdQMUZaIj16Au/gdvWybCr+6IzDD4SVjJwcoF
	 0smxEYRvX0GkdfFm8agIuGbAx4XDuHn4gdFJMByevCXp0KAlyTUaKifLFJ4JrFEM/VzHe
	 jfU0FB6i9awUKWuG8J0NGE2uL7cwCkHruVyUs4kFIcfzXkO6SENdSYmM7bKgXud4kGdhB
	 wOobWTdzvK9dKSgjf4ksH+qDpg9O1K7K6CG0LJOla0l119qbvOD/IJUdgd5UAaX9bByC8
	 rGhwXtKv/ZgcQvqtTJ2+38/6IMZFIbrky0ojGkGxKgbXYyzJDOrCd1g6Oh42iOS/NaA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792624303;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hJUTVHoadBGvzH+rQjnuezS2fRQEQHVqgM4qIFKm3wk=;
	b=pnoDwa2yJ8VU+nFkqoVTd4e9xrIbp2VNQoX8wRXfuj4ktWUNbE41TLh2y/RkWRLK3zhs
	 Miv7bhTyDN4WQUVpLagOVR2xsBZIaoVf0t0jWqGm83PVcBM3UfQc1unzKGVk30Yi04TNx
	 IK0PFSCtTqltVJvHLGZQ6oO7lSLBd3im4Jwhr73LY5141N5dePn5LXlDMC4s69PTrUM9q
	 W4+i6UiZms8v1WU91JvBY2bT0viks7aZxJfReJFDakvr5KDvyJWEgCblFhuLrEt3Qk1i4
	 Z2wiPG1wxnlFOlXvtS7r8Jrvn8bgcb8T1z/yguUG5tZonjacZRiS0XvP0zddvaXQxpA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=GNRvzCSh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC22606A33A;
	Wed, 21 Oct 2026 23:11:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DC22606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=GNRvzCSh
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 478EF201E0D;
	Thu, 22 Oct 2026 01:11:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792624296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hJUTVHoadBGvzH+rQjnuezS2fRQEQHVqgM4qIFKm3wk=;
	b=GNRvzCShpSPAIOyD4iw4bfGVYq6GMYhQ4LG4oAQi8uirMJz2txOFt3/kt5I1sk996KGQd0
	OEDXkooVdUW7pC2nNArQ4eSJoqXkGYoFEwPj68Kz7gh8mC2D7GM32tDwuCX4VttMKj9Jc+
	f/lbEbSu7tDfhYH8jDbCXA/9PsOKQNkIGhgU3xIaAZlNYnbnUKliJrhDh3KbB5IBNHCD4C
	kCkZRei/q4yE9sE7WLPYQMisNIrpaRO4cg12TJqMJh1SWyfIRea+LIDKFjrFrsNGp33yaN
	109pujqfBWX6TPHb1dEIoOIj0DVdku2sSm6DDSvoMnPrqKFDwCv8YcnOVrrpNw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792624296; a=rsa-sha256;
	cv=none;
	b=Rr6mPRn/TtVjPIBl+fMGUZ0w6569VKi0inMq1gjXKAUM8QYDzcw5ZIvksEkcOGNsmng+be
	fpL5IDdKiPac5QWT9T961CZOdhCrO0G7jOG2bzT+hf2lfLSbHVT7V+WGyDE8toDzi7IXdH
	en5jrEELN6VUpngrlXNTZabh2Rlkj9z/TMSSz7LGgFfKIMn79EWup5EJSxVhEknR+gezzg
	jLPc7720HAQMgU6TI4RnBgWgO1CqdJw1vseODLdRVD9moD/kKCF5mODYkvGzleI73J1Zte
	SYIwO55yHLksmvIteZ9t842ZU/I7c3hqgqn4R825Vg+qKs4JHJNVFjaVsX+44A==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792624296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hJUTVHoadBGvzH+rQjnuezS2fRQEQHVqgM4qIFKm3wk=;
	b=WK2tdyI8q4yjuuBZ9TKvEzD6qSKBZ0TDk98AiBCqIJarkywx4vtilQn2Tm1A0pc1pvteaD
	F0iThiP6TcPxXfAjk9zHFf+32qy7/h3D1ntlmy7NM0KkMzxIkeOXHfPSBrBz259Rc6LTrD
	yJIxSSy/4m79RUR08SMorECsdIzf+3l7wYd+uERghN8uRmq6xAeOqYd1q1UyJnLZwAMHzY
	ZHquKwiyo1AM7NzaG/pHS0Jvs8hGf+lstVtP8EiztGWudgUcQQtkuq3CeqJxH+x1JUHCKC
	M+UVXUOKG1Eq6MMRgRPqBkh08dN0zAOhyz5xLjRsptdkW5wpazz0i0MSPGsszw==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xJfT6-000cWN-0Z;
	Thu, 22 Oct 2026 01:11:36 +0200
Received: from blackshift.org (unknown [IPv6:2a03:2260:2009::])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 838385D06DB;
	Wed, 21 Oct 2026 23:11:35 +0000 (UTC)
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
Subject: [PATCH net-next 06/11] can: proc: reset pkg_stats atomics individually
Date: Thu, 22 Oct 2026 01:07:53 +0200
Message-ID: <20261021231130.2085690-7-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021231130.2085690-1-mkl@pengutronix.de>
References: <20261021231130.2085690-1-mkl@pengutronix.de>
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

Fixes: 80b5f90158d1 ("can: statistics: use atomic access in hot path")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://patch.msgid.link/20261020203257.230955-2-socketcan@hartkopp.net
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


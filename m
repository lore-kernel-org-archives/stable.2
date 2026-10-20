Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=81.169.146.163
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792528397;
	b=etWNOPVEfMOi6eisA8CKm2IU6EKYdNLoI7q545tmRf6C+HikomlUZdHjP5Bw15o1Eziy
	 RuqKeXZ54quyqk78ksSK5wT8FWxKUIs1+iNFA6P4bT49Ecoi62e5b2GbCYmM6qJluzEkz
	 1N1/CkKSw/Lnmmru2idCxfuY88bUK/3zZyHfYEDh6AV9n4j5SjVj4PYVkcYAWyMf9bIG9
	 /zfDSgSn4VmkqT8A+4ibGfWMVzAig3jYkZ7O58queqKDKO34sy2pjJX8mSTff/Zu5tJjm
	 uvi1MOWbWHrNiw7+TArL+C41cx+A8uZbLEIkVOj9b0ob6ZuFmTVZugqT+M8dZe79GWw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792528397;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=nIXVAY1OU1D7ohN1HEmJkRT/3xMBDrW5js7tDESAf4A=;
	b=ChpR35FPdZG3DejdUf2/pYV9QxA3pIczKrJNDviOsEVYsjjvhWnI9kfCsTK4My76owih
	 /qngjyGMh45Unkvggii6UaFl04K1GPFXrLpw7UpSkrp2Xcnvh3WHD5RDUkpRSQe4rrsEg
	 aIDsO611sa4lnHvycFDOppJYITcsUHGD9azfgzDW3hUsNdhhrbjtqHKRsOq6+WOzEfdD5
	 XAoq3CTAF8V9wW5Hujz/GFiuLx7+4KeS0WtvgcLPzB8kL0a6AZPX1OWozVQBjKqXxt5b1
	 wWa6mpYVRfbaFE3GfKHB4N8Y0LDsUAZROS+xK69qjz5zWLUWPbUOjqvXofqk7bKjO/g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=jzxEvLy1;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=iSIF32Xy;
	arc=fail smtp.remote-ip=81.169.146.163
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3311606A323;
	Tue, 20 Oct 2026 20:33:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3311606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=jzxEvLy1;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=iSIF32Xy
ARC-Seal: i=1; a=rsa-sha256; t=1792528385; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Om02ZkDRxQGpcJAkuyvlfsBXKd72EUUDRWwUsIVXidBNvLuBxXCd8Gihd3qQDtPP0N
    ehEU5cPrc6gmiY9Z4QccpUqaDwbA5XTXnImTphPmQUHT4a8tHNlO68sBx1z3LZ76AczO
    hAoGYnwcUnZTBFUBIm8oq1Xqy10XmnKSmaMQ/WKkVg5T5ZEkfL236JSvfS/2dvxmCxTx
    Hl9bL+16J9x8Zdv8LQh5ZjxsBC3RuJU75HJC1eaWgaOqYQdOdkJ8UFgs+lVJOV3gD/hw
    6XfkFnwoSkUKvMMEHHy8jo2ewZW9VdMUfiYze8EYazNzwQgxFfXR7QGGMHDSrAeKGXWp
    zwUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792528385;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=nIXVAY1OU1D7ohN1HEmJkRT/3xMBDrW5js7tDESAf4A=;
    b=YR9eJfWOfjWsjbN3hAm8Mze+GfX0IxbGH4qclOuWgCutzm/UY3pAffVtc5pAtvly2w
    gPFlqdIBC58VBbDgJ4QoJXCACXhX/x39ugWxzaoizb53Un3UMBBCdUeCzpooteVM8sYu
    vMdZHyiBUew2bPptVihBKsR9aayx+SgY6lHXtRjXl0JPODcD3ZfqWPTVBat/W44NdTAb
    tytNd2tA4xKPe+q6eyNsAQSEKj195sAZKBT34oNi13zuyfPUc56jSvVJAXm0Jyrn8LFj
    +2QWlW8oeRT7FRa/xUM4GUHpLLl77SnVFJobrOdZL5TbvPBJzD6ozzcuDYG8EsT4+u+i
    Lnzw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792528385;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=nIXVAY1OU1D7ohN1HEmJkRT/3xMBDrW5js7tDESAf4A=;
    b=jzxEvLy1GqVgLwvKbr/BidBeJirtgpdYZnE4oMVm+YQV3Xn32yPAffepLuMXJ4Lpr+
    rNTf2zOqoucB51CCgzQyp3lWKio/U1f9AT6egvhBXSvEt5L+aTGyDUKbpG+2vSv/DjP8
    Ioodzl2SsV6dZUqKCI9OZgKP4ZtcALQ4gf6bt/sI638HtYWpTZ/C53FahxOZvnNLPQXr
    jNxmBJ7Th3h7jiyUHjWRLR0UaVy0AS5SunUeTLm4P3J6sF9VxV/8sknY1kuNjHPujz6p
    v336L1mtOWdJu2VWAHAawMMvLmt7pv7eJQyPYkEjwKOPDjDPP0Y6aYGZ6DrGqv3t7oKn
    OigA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792528385;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=nIXVAY1OU1D7ohN1HEmJkRT/3xMBDrW5js7tDESAf4A=;
    b=iSIF32XyUxm3vsJsEVApeuCVQvqQuGpv3OwMbbAmzkSVtf9NhGXsXfuz2KROT585Po
    JqW4579/UROL10Js/oBA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29KKX4dMp
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 20 Oct 2026 22:33:04 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	stable@vger.kernel.org,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH can-next v5 1/5] can: proc: reset pkg_stats atomics individually
Date: Tue, 20 Oct 2026 22:32:53 +0200
Message-ID: <20261020203257.230955-2-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261020203257.230955-1-socketcan@hartkopp.net>
References: <20261020203257.230955-1-socketcan@hartkopp.net>
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


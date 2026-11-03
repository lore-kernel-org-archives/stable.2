Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793738609;
	b=uYaiiW1mioCGzRVMIvapsqCqmFbHS7/4wGCA+q7cMLSMDr3yUjxkY2aMwJ2EOSdVJ8qJ
	 gy8HuXV0BHLpp9ov6SCecoHwm+p7wxcl95LYlzo+cS4xMtN1e2R+t8MiEe2i2JuESbf0K
	 s2sUsQ+dW9y00InkagePhqbPHP3o26dT9RUWhf4VHCMU44rvWRgXWVqx07KeQivTT7EIY
	 ycGli9dTRw8AaeJ42FsXtJCKTqw1p139tukYDQjz69MzStrLSGWN+IIVzH77bKPK3hcyy
	 ExLpTbGhDfij9k86d1XG5rw0O7bOkg9tvIBuB76oD8+ydjJUyoCYMaFQZSmyVmu5Xlw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793738609;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0nEjpSELMP25nGdH2jbVcjwi4nIdOa0kdNDedp0p8Jk=;
	b=InKnnZ1wqXl4hklmrxs+MgYIh1tg5hnJAv/zOS+qznxz9RG7YztL1gd4dtQPcwqW0Zqj
	 +W4bHpoCSupgR0OVwoXV3oIJeBgpnox9tLwFSCgOUQoHSJnWBUD0/LeYS9Y9HrN9xV8xq
	 efZBIxRbN+kvuxBTMtXJOxh7ax2M8UfQXejQaQCyYEgU3jkfd+5l0M7sIZELyK3Vw6X8c
	 z7mebJ6h07rxYAW+u0BHHgH+ZuIJ1rJzf+QEqHz2Su1FXg+ulhbxOhVuXdbaWPGNAOru6
	 JeCxsbacg3hdR9p3h+md1ZmvyekYfKJJadHh1MQrpmwbpkOVWgf0gvkMJ3REwgpmaHw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=O6Pjpfkc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899CC606A335;
	Tue,  3 Nov 2026 20:43:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 899CC606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=O6Pjpfkc
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id EBCCC202BA3;
	Tue, 03 Nov 2026 21:43:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793738602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0nEjpSELMP25nGdH2jbVcjwi4nIdOa0kdNDedp0p8Jk=;
	b=O6Pjpfkc5TX45B3/oJV/COsIBLwuEwWJCJ/OcLm5VhL3+CtT62FTu+uzajexWTIRpZzFdX
	sAMlxFFSANGQ/P7xpyFL/G7K0M7b7RpE/ZaoJtjzhA4d4Ab/rpNpcZNKFqbbdNKs23P2eG
	wB6rpWnGy4xVIQ0pSLA4V45hDCoqd/U51VreaEoHQI0ouH/MKYmG0uVsd5jB5eXHMQiMRv
	i8qfv5X1Brq1E0RSHP9KFILrsJvFSPZQWMt2mFRn66RtK5OX0rW5L95gk3YccPR4Uy2gZ/
	d4POWiQ7AsxYPeHxOzGSr0fAW5/XISaAvUqU8D4vcR4Z97Y2UcWWKAGT1qOR/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793738602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0nEjpSELMP25nGdH2jbVcjwi4nIdOa0kdNDedp0p8Jk=;
	b=fI+ImslSFk+tatGOvvIq2DZT8qWHi1k5VF+0Fvv99/8D54V2k2fUg/eTij4q2mUocZlnxM
	t534q3twoYoOEa/AS4OpwHxNqsi/rDQSFlN9uPKAAA5PRvX66HGC/IZrFa31vYmQ5OQbnt
	xCkHapNZ+OBzi4sXLIW6qKrKBhWVV77gqHFU9eD4ZBbsm6gA846hWdxOHULylfzCWGNF78
	7pTEjQ9WaBoT0YwbeRbYyRMWAO3yQJFtMRFHWVu1TpV2Cghjt769munOZQrCpVlVcNWinU
	pDq/vDlkornBZyualaoymJnNQwoXRlczgwzlH0BqOpKLW1LGYMLCJG5S6Uo6Ow==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793738602; a=rsa-sha256;
	cv=none;
	b=Axp7tpg2gX5MIbmf2dw9s54oH9wwuKUiK/VO1m+9rUKmIT3I865XDohBVMmSK+32Yi1bpD
	wL4o6SPbOEnqOsDqP4i7uh6I2eR+r+nk9e+QWVTb5ntilzIIg2uN5o9a1QfA9HRjfjVb+9
	WgTf/lIIIIWoKX4bc+sugD+RvFIeNYdMDbhsBogwgFnWWIk7DMj8rpssTHxMj+nupJLnhl
	ghyB7yJNCqCtbmt2Y+/k1QDySxCMWO0A2UKsNNQ4UJ41R5VNaRQzXqWkVWrmfa+OpAettD
	7x1fs8PtlA+/Z4p1IWD4IywXd+oz+b4p3t5UWm15rX6yYW6tUXp1eFcnXXlS/g==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xOLLm-002V8s-2j;
	Tue, 03 Nov 2026 21:43:22 +0100
Received: from blackshift.org (unknown [IPv6:2a00:20:73c1:227f:2cd5:5d72:938f:f03c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 92A0B5DDECB;
	Tue, 03 Nov 2026 20:43:21 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	stable@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 11/15] can: proc: skip stats calculation after reset in can_stat_update()
Date: Tue,  3 Nov 2026 21:30:32 +0100
Message-ID: <20261103204305.3211144-12-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261103204305.3211144-1-mkl@pengutronix.de>
References: <20261103204305.3211144-1-mkl@pengutronix.de>
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

From: Oliver Hartkopp <socketcan@hartkopp.net>

Commit 80b5f90158d1 ("can: statistics: use atomic access in hot path")
introduced local snapshots of the statistics counters at the beginning
of can_stat_update(). When can_init_stats() resets the statistics, these
stale pre-reset snapshots are still used for the following total/current
/max calculations and overwrite the freshly reset values. Additionally a
jiffies tick between the snapshot and the reset could trigger a second
can_init_stats() call.

Merge the reset conditions into a single check and skip the calculation
for the current interval when the statistics have been reset.

Fixes: 80b5f90158d1 ("can: statistics: use atomic access in hot path")
Cc: stable@vger.kernel.org
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://patch.msgid.link/20261027-can-rx-lock-v12-6-eb5afc2d8b9b@hartkopp.net
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/proc.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/net/can/proc.c b/net/can/proc.c
index 70104f13077e..fb144d2adc35 100644
--- a/net/can/proc.c
+++ b/net/can/proc.c
@@ -149,25 +149,18 @@ void can_stat_update(struct timer_list *t)
 	long tx_frames_delta = atomic_long_xchg(&pkg_stats->tx_frames_delta, 0);
 	long matches_delta = atomic_long_xchg(&pkg_stats->matches_delta, 0);
 
-	/* restart counting in timer context on user request */
-	if (user_reset)
-		can_init_stats(net);
-
-	/* restart counting on jiffies overflow */
-	if (j < pkg_stats->jiffies_init)
-		can_init_stats(net);
-
-	/* prevent overflow in calc_rate() */
-	if (rx_frames > (LONG_MAX / HZ))
-		can_init_stats(net);
-
-	/* prevent overflow in calc_rate() */
-	if (tx_frames > (LONG_MAX / HZ))
-		can_init_stats(net);
-
-	/* matches overflow - very improbable */
-	if (matches > (LONG_MAX / 100))
+	/*
+	 * Restart counting in timer context on user request, on jiffies
+	 * overflow or to prevent overflows in calc_rate() and in the
+	 * match ratio calculation. The local snapshots are stale after
+	 * the reset, so skip the calculation for this interval.
+	 */
+	if (user_reset || j < pkg_stats->jiffies_init ||
+	    rx_frames > (LONG_MAX / HZ) || tx_frames > (LONG_MAX / HZ) ||
+	    matches > (LONG_MAX / 100)) {
 		can_init_stats(net);
+		goto out;
+	}
 
 	/* calc total values */
 	if (rx_frames)
@@ -196,6 +189,7 @@ void can_stat_update(struct timer_list *t)
 	if (pkg_stats->max_rx_match_ratio < pkg_stats->current_rx_match_ratio)
 		pkg_stats->max_rx_match_ratio = pkg_stats->current_rx_match_ratio;
 
+out:
 	/* restart timer (one second) */
 	mod_timer(&net->can.stattimer, round_jiffies(jiffies + HZ));
 }
-- 
2.53.0


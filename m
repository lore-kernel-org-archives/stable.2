Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792788433;
	b=nqV+IAtHqLnRFhdGT6RabKy3uE/6pKDuUtcpQOuZw/m0WQ/tjbDXTcqh5hlPNzkDcVUJ
	 ezXQa27fdY0DIDzXiO9YCaVe1HGHPkz6Il1TA9oahRTH0INx7nxhM0gL6BhbwOMajLtp0
	 tdn8h8hVyWO7grYatcQyGak9j7Y4MI36OA81F/or8/o4487nwDzeg3++rNKS10cfj9bmI
	 LMZHZtq5RFY6DPCfyTAOsMI+u/oJ7Uz7wmlzO90u2qLQDKoehetzyrP7mu4KLvHjTMmF0
	 GMsAb2IlvxrnsIDpqmSDrImYmkxtvqjg6wRXvbBNw6B0kgwvDgwghiI3LWO07N6oCNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792788433;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=7hhjMhMlf0hWX4EL6DJukBZEvd//7wsBPb4Om2A7D4Y=;
	b=tt7AKSOyeJQupk8uRP+YZOoH5esF6x61LZtmRem7wSLxAjbs2QfvYu9QUcKmJQd4QOuF
	 wD5WonBUvOK1YQWtOmrLDUO+It3RrGRmmTIjSJpScwgOFeDkyIlPd+xjZv5U7t+giv8YN
	 YL0GcTjTHTmKxP4sLK9Crt70NCsPr8XNpfwj0uz+KaursuSCG0ap8gXAKTaQzjBwynYXy
	 SFSTPpWjHHhFCU3VmqCgs1bRYWV8W14oVjMozkNevmN4dJ44fADYQcBtG+CWNWYNFCTke
	 09UrVXazjF/QqzH8wjpBouiQAQqbDuub6kgsdkG+wwywSHHOKDefIaEVnQUAuZm9aoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=DV0Jo9sJ;
	arc=none smtp.remote-ip=209.85.216.72
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4FD60A261C
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 20:47:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E4FD60A261C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=DV0Jo9sJ
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3ade203fd09so680528a91.2
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 13:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792788432; x=1793393232; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7hhjMhMlf0hWX4EL6DJukBZEvd//7wsBPb4Om2A7D4Y=;
        b=DV0Jo9sJOeYtNS+GdqyayVG5BEcagncM8oFKKusfUD1jTkbxCSz9f2owmdAhLsONzI
         6VMo44vULDc77PjPYhWnvIqfY95D2DW6RpH9m/8KFk2ua88Ax9ReUj4hEwwOhmYLM34D
         conUs//z2Y6gVNp8QeIKHxGHHEriQmJcCDqQizmWdirl7O1+c6hDcHFegm+QI1tbI8ay
         b49C8x26cq0VxtGHldPhW5djJsh0ko0ZmaLh8LyPtwDCwH6RqEgYg5APvHFgnO+uKQQB
         USDNSS/EidUR5fBo6uDjxCW+ep084B+S2PdwTOovegRYAVW9vVGZsjVIGohFlAcgTg0A
         ED8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792788432; x=1793393232;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7hhjMhMlf0hWX4EL6DJukBZEvd//7wsBPb4Om2A7D4Y=;
        b=Bu5ho0JjAwAbM8JIavDPdqrM9m2o7cT2c/izfHXnV2MGYWfeTU6vQD+jajHjT7bJtq
         BFxdT731dq30bvgtHOoizcVcRhLcE5A0ws+6uLqLU1s0HQkJXRQB/k0loj89YBUgAvxh
         DuUNvVuxTC2METZM07DV7VUsMtSiPHZZJWsbLCT4+NnXfpConEoHKrVEvrVz7U3rguIV
         MTYyTGkyLn3HDy/zo9IVvNuzOnJZweI00kjEZZF3lEvEX5s0F4OBudA0VKDeTx4y91RW
         DmhaZhzUElUGIrDB49Vw0IoPa8P7aS16cfuqzVmpPX05Xp8XiZJrSIGX5AjsSG7bBkpL
         cE5w==
X-Forwarded-Encrypted: i=1; AKwUvBwhzqVUGLYFNwJaNUWU8CRVZi0rzHLg4ZVqFDGHznnPTbeOD1V0NA0/0KtcrYHtLUUGAFu/aT0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJhA7iC05lMa+GN1NgA1UMS5+86vtR065lwCVsstCkfNiN3y5Uy
	Mgs5uc1qa1BKGrHjpJaUQsz0al7czRWxVvPxwczGtMyzE7gUFB5ASmqfh8S3G9rlN8YO0iC4SXJ
	FmRXu6+3AFfC2YUvvifu9AZ26AA==
X-Received: from pjrn18.prod.google.com ([2002:a17:90a:b812:b0:3ac:3453:b5d5])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:280c:b0:3ad:870d:1bfa with SMTP id 98e67ed59e1d1-3adead57cbfmr304919a91.23.1792788431642;
 Fri, 23 Oct 2026 13:47:11 -0700 (PDT)
Date: Fri, 23 Oct 2026 20:47:06 +0000
In-Reply-To: <20261023204706.3112215-1-hramamurthy@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261023204706.3112215-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
Message-ID: <20261023204706.3112215-5-hramamurthy@google.com>
Subject: [PATCH net v3 4/4] gve: Fix link flap after ethtool ops
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	jordanrhee@google.com, willemb@google.com, przemyslaw.kitszel@intel.com, 
	nktgrg@google.com, maolson@google.com, jacob.e.keller@intel.com, 
	pkaligineedi@google.com, yangchun@google.com, patricion@google.com, 
	awogbemila@google.com, stable@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Pin-yen Lin <treapking@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Pin-yen Lin <treapking@google.com>

When modifying device features via ethtool, GVE causes a short link-down
after the ethtool command completes, which can break scripts that use
the network interface right after the ethtool command.

This issue was discovered and actually triggered by the
drivers/net/ping.py selftest. Modifying checksum offload features via
ethtool caused a transient carrier drop ("Lost carrier", DHCP lease lost),
causing the immediate ping invocation to fail.

Fix it by calling gve_turnup_and_check_status() in gve_queues_start()
instead of deferring the link status update to the service task, so the
carrier status is updated synchronously before returning to userspace.

This change was tested using the DQO RDA queue format.

Cc: stable@vger.kernel.org
Fixes: 3b7cc73628ff ("gve: Use link status register to report link status")
Signed-off-by: Pin-yen Lin <treapking@google.com>
Reviewed-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---

Changes in v3:
- Retitled from "gve: Make ethtool config changes synchronous"
- Fix the Fixes tag
- Refined the commit message

 drivers/net/ethernet/google/gve/gve_main.c | 61 +++++++++++-----------
 1 file changed, 30 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 52c152a986eb..e2a016f4430a 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1423,6 +1423,35 @@ static void gve_queues_stop(struct gve_priv *priv)
 	gve_rx_stop_rings(priv, priv->rx_cfg.num_queues);
 }
 
+static void gve_handle_link_status(struct gve_priv *priv)
+{
+	bool link_up;
+
+	if (!gve_get_napi_enabled(priv))
+		return;
+
+	link_up = READ_ONCE(priv->link_up);
+	if (link_up == netif_carrier_ok(priv->dev))
+		return;
+
+	if (link_up) {
+		netdev_info(priv->dev, "Device link is up.\n");
+		netif_carrier_on(priv->dev);
+	} else {
+		netdev_info(priv->dev, "Device link is down.\n");
+		netif_carrier_off(priv->dev);
+	}
+}
+
+static void gve_turnup_and_check_status(struct gve_priv *priv)
+{
+	const struct gve_ctrl_ops *ops = priv->ctrl_ops;
+
+	gve_turnup(priv);
+	ops->report_link_status(priv);
+	gve_handle_link_status(priv);
+}
+
 /* The passed-in queue memory is stored into priv and the queues are made live.
  * No memory is allocated. Passed-in memory is freed on errors.
  */
@@ -1486,8 +1515,7 @@ static int gve_queues_start(struct gve_priv *priv,
 			  round_jiffies(jiffies +
 				msecs_to_jiffies(priv->stats_report_timer_period)));
 
-	gve_turnup(priv);
-	queue_work(priv->gve_wq, &priv->service_task);
+	gve_turnup_and_check_status(priv);
 	priv->interface_up_cnt++;
 	return 0;
 
@@ -1562,26 +1590,6 @@ static int gve_close(struct net_device *dev)
 	return err;
 }
 
-static void gve_handle_link_status(struct gve_priv *priv)
-{
-	bool link_up;
-
-	if (!gve_get_napi_enabled(priv))
-		return;
-
-	link_up = READ_ONCE(priv->link_up);
-	if (link_up == netif_carrier_ok(priv->dev))
-		return;
-
-	if (link_up) {
-		netdev_info(priv->dev, "Device link is up.\n");
-		netif_carrier_on(priv->dev);
-	} else {
-		netdev_info(priv->dev, "Device link is down.\n");
-		netif_carrier_off(priv->dev);
-	}
-}
-
 static int gve_configure_rings_xdp(struct gve_priv *priv,
 				   u16 num_xdp_rings)
 {
@@ -2056,15 +2064,6 @@ static void gve_turnup(struct gve_priv *priv)
 	gve_set_napi_enabled(priv);
 }
 
-static void gve_turnup_and_check_status(struct gve_priv *priv)
-{
-	const struct gve_ctrl_ops *ops = priv->ctrl_ops;
-
-	gve_turnup(priv);
-	ops->report_link_status(priv);
-	gve_handle_link_status(priv);
-}
-
 static struct gve_notify_block *gve_get_tx_notify_block(struct gve_priv *priv,
 							unsigned int txqueue)
 {
-- 
2.56.0.257.gf7497c7d27-goog


Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29534A3D3F
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 09:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791884337; cv=none; b=s2PzcizeuZlK43IazbrKGjwbCMyjDPD6X4sCGacRswnM7o969ASgOhbeQVKMzOUZ//MsEp7WUdW+o05LHf6CnAutp70BovJfV5rUqJZMXCiGwUouhH4jmRAvfAvkjNOu2QGQ9GyjryRXFuoIsOd9C/Vi7y+Oaj1F+DBp2osoqeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791884337; c=relaxed/simple;
	bh=A4L1ZHBj5M3pQMg4obNX+lCazYmcuKU6CtIWcsZMrUI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=on6YudRG90qoHX0n6Ld1+YoOQ9RgX3Ahg74CdQG9rwjjfkDDXMe0nUQnV1esIElZhuoRmRpUCmzEnQHyi/odXYtNuwdD3hl+OI5zq/RXKWXEFD9JDdckk/RqH7mXX2BpoL8wkRtpF0XYNwnR+RLNPLDjoOUx9e07A6I+r9bOuLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--treapking.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TKfFffvd; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--treapking.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TKfFffvd"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cd0b795aa8cso2867819a12.0
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 02:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791884336; x=1792489136; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xto4NrJscgg0IfJJ81rfegkJvbJiMhteJoYoHHnFQIw=;
        b=TKfFffvdSztREhJO89cDyarosdmXspWjUzosevwC4no8YtR9v0tBgM2T6O4Ob67Hf1
         05a4Zo9EDIQOXIqImGcQk0W+2atjFdfaTVUce5z5vRe4K+EM8sWUKEd9TME/tch1lCu9
         xtIEahS1kbH2SS+ZO7PRCBfaFT5I5E6JxJR6CX3s4vW3fo09WQodZx3XvU1faXIRRmQW
         4Tg5LDXK76Sse3Qf4gzaMYCDgWfM7zCRHA9v0MsGUBlnNsOFqQhd6Ao1cT4YBMXXUCDQ
         KbdOUvzuhw9qo+jbJtFImmskMfESaZDmQttMxm6Zp6XakDnCVXyaDsyunN1kUBpzBsaO
         Ywzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791884336; x=1792489136;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xto4NrJscgg0IfJJ81rfegkJvbJiMhteJoYoHHnFQIw=;
        b=HXFWSEvZyx2ZyrXo5isSG5cK2kjmBboKxKdmClqiHUAE9pyOoAnokdCbJmyDSFmJ7R
         NForcxn35NPDTg5wAY9pYMO4oG+pOlr2n0/Da+xXiXITab2RM0Ecs/zoEnOUQLlJRH3K
         s5b52jC4hycDV/RwoYCBNvtJcqMn43SO94JHRroB3y4/eJUYnNCB2NEsedxe01liIQky
         xizNB69j7HIO8xNHSFasYOTeGn6t/rSUjME+1sj+RoFKB0VTGb3jmkRGpdIa3zX3zwT1
         GDdF2Rk+j8JuenmMML+1jqayhfoXfl7Rjdh1dZ2cG9lIJepWnSUcCK4DR7+VN4E+7tzH
         SwuQ==
X-Gm-Message-State: AFq9FYIfTEqBCKRGePSiPaiGLs/djX8v37w6jto1/yI53kODFcW4Dn7d
	DauwBc0B1d+d/e2k4R8DjE+1F7Y3bkuOBdyIjtRyckHTNy/frhmkRa8ZL8C+OzLNre48Tmw5Eay
	kbT40LXK/nsocsb/E2g==
X-Received: from plct10.prod.google.com ([2002:a17:902:d28a:b0:2e8:ac89:717e])
 (user=treapking job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:32c1:b0:2e5:41d6:178c with SMTP id d9443c01a7336-2e842e0e156mr73013375ad.33.1791884335453;
 Tue, 13 Oct 2026 02:38:55 -0700 (PDT)
Date: Tue, 13 Oct 2026 02:38:35 -0700
In-Reply-To: <20261013093836.1269134-1-treapking@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261013093836.1269134-1-treapking@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261013093836.1269134-5-treapking@google.com>
Subject: [PATCH net v3 4/5] gve: Fix link flap after ethtool ops
From: Pin-yen Lin <treapking@google.com>
To: treapking@google.com
Cc: stable@vger.kernel.org, Joshua Washington <joshwash@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>
Content-Type: text/plain; charset="UTF-8"

When modifying device features via ethtool, GVE causes a short link-down
after the ethtool command completes, which can break scripts that use
the network interface right after the ethtool command.

This issue was discovered and actually triggered by the
drivers/net/ping.py selftest. Modifying checksum offload features via
ethtool caused a transient carrier drop ("Lost carrier", DHCP lease lost),
causing the immediate ping invocation to fail.

Fix it by calling gve_turnup_and_check_status() in gve_queues_start() to
update the carrier status synchronously before returning to userspace,
and move the device_status register read into gve_handle_link_status()
so callers always check the current link status when NAPI is enabled.

This change was tested using the DQO RDA queue format.

Cc: stable@vger.kernel.org
Fixes: 3b7cc73628ff ("gve: Use link status register to report link status")
Signed-off-by: Pin-yen Lin <treapking@google.com>
Reviewed-by: Joshua Washington <joshwash@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
---

Changes in v3:
- Retitled from "gve: Make ethtool config changes synchronous"
- Read device_status inside gve_handle_link_status()
- Fix the Fixes tag
- Refined the commit message

 drivers/net/ethernet/google/gve/gve_main.c | 63 +++++++++++-----------
 1 file changed, 31 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 5bd6549e99b2..f1eb0c6e1f9b 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1442,6 +1442,34 @@ static void gve_queues_mem_remove(struct gve_priv *priv)
 	gve_queues_mem_free(priv, &tx_alloc_cfg, &rx_alloc_cfg);
 }
 
+static void gve_handle_link_status(struct gve_priv *priv)
+{
+	bool link_status;
+	u32 status;
+
+	if (!gve_get_napi_enabled(priv))
+		return;
+
+	status = ioread32be(&priv->reg_bar0->device_status);
+	link_status = GVE_DEVICE_STATUS_LINK_STATUS_MASK & status;
+	if (link_status == netif_carrier_ok(priv->dev))
+		return;
+
+	if (link_status) {
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
+	gve_turnup(priv);
+	gve_handle_link_status(priv);
+}
+
 /* The passed-in queue memory is stored into priv and the queues are made live.
  * No memory is allocated. Passed-in memory is freed on errors.
  */
@@ -1506,8 +1534,7 @@ static int gve_queues_start(struct gve_priv *priv,
 			  round_jiffies(jiffies +
 				msecs_to_jiffies(priv->stats_report_timer_period)));
 
-	gve_turnup(priv);
-	queue_work(priv->gve_wq, &priv->service_task);
+	gve_turnup_and_check_status(priv);
 	priv->interface_up_cnt++;
 	return 0;
 
@@ -1599,23 +1626,6 @@ static int gve_close(struct net_device *dev)
 	return 0;
 }
 
-static void gve_handle_link_status(struct gve_priv *priv, bool link_status)
-{
-	if (!gve_get_napi_enabled(priv))
-		return;
-
-	if (link_status == netif_carrier_ok(priv->dev))
-		return;
-
-	if (link_status) {
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
@@ -1634,7 +1644,6 @@ static int gve_set_xdp(struct gve_priv *priv, struct bpf_prog *prog,
 {
 	struct bpf_prog *old_prog;
 	int err = 0;
-	u32 status;
 
 	old_prog = READ_ONCE(priv->xdp_prog);
 	if (!netif_running(priv->dev)) {
@@ -1661,8 +1670,7 @@ static int gve_set_xdp(struct gve_priv *priv, struct bpf_prog *prog,
 		bpf_prog_put(old_prog);
 
 out:
-	status = ioread32be(&priv->reg_bar0->device_status);
-	gve_handle_link_status(priv, GVE_DEVICE_STATUS_LINK_STATUS_MASK & status);
+	gve_handle_link_status(priv);
 	return err;
 }
 
@@ -2090,15 +2098,6 @@ static void gve_turnup(struct gve_priv *priv)
 	gve_set_napi_enabled(priv);
 }
 
-static void gve_turnup_and_check_status(struct gve_priv *priv)
-{
-	u32 status;
-
-	gve_turnup(priv);
-	status = ioread32be(&priv->reg_bar0->device_status);
-	gve_handle_link_status(priv, GVE_DEVICE_STATUS_LINK_STATUS_MASK & status);
-}
-
 static struct gve_notify_block *gve_get_tx_notify_block(struct gve_priv *priv,
 							unsigned int txqueue)
 {
@@ -2427,7 +2426,7 @@ static void gve_service_task(struct work_struct *work)
 	gve_handle_status(priv, status);
 
 	gve_handle_reset(priv);
-	gve_handle_link_status(priv, GVE_DEVICE_STATUS_LINK_STATUS_MASK & status);
+	gve_handle_link_status(priv);
 }
 
 static void gve_set_netdev_xdp_features(struct gve_priv *priv)
-- 
2.56.0.385.gd3acb90ef8-goog


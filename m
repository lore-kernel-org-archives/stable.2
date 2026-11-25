Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795619808;
	b=E+0OKL3AVIPQqAnmwE4/95YomeI/Msi7hhIpS4ETnLLl9YLK+foLN+7rStsxmilVLUTg
	 u8hQNXGTpv6qcZdulBrQB8VJFxk8/kWwK0p3A/T4Rrc1uP9Go+mdqXPw5kjxxen5imaWV
	 yAQA7yvMrueafgT4GlNCOqr23m6+rB3lBTgqyrUFdVjjRHeOkR9rIx70WoSCrl8P8N1X2
	 6Umj23GgREAN8HKutntKenNm6Y2L4jSL8nY1KUwTOfZImb+95EQsWqWl45BbU2bLx6ZVI
	 3NlACK67ECIqjqYCfYaEQvRKtv0i7xHtY8lJvWSQmcNH6fogy5NDnR3GEriQlXR7sgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795619808;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=lbx9OBL1jxrx8UbrWLOmOaz3Wuim4oASxTOZOdTvyfg=;
	b=oHCKWUmdwFU+xmMUkOGzpnrqAMahF8TyrMrDyUWLFIZLrH6pezPKsgZ9xjfMLuY+eyFZ
	 EQhozXDx8SAVjuICAWTiHzPvDNDUnaKPPMESRFwNhN8fxv8IcPdpeyRjgG63VNuCidKs4
	 oiofspU/v8KbI60634d7hX404lnoDtyr6iO2EHPB9mU86yW077rIqsARy1VjsApcXqm+H
	 WOTdrREbXZUtjHfTjMnZBvx6xsyIzRw2kPk9jW74wJ6bwWGROpeezTjlpTgvA7hwNtei3
	 teYYWAlNz62HjoZfbuDXxzZVxMcZhVa03uKs5D3dWtBOyiWnBwTEcx5chKdd/aiXlfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PGN3bATo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFE0606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 15:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PGN3bATo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84D9B1F000D2;
	Wed, 25 Nov 2026 15:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795619808;
	bh=lbx9OBL1jxrx8UbrWLOmOaz3Wuim4oASxTOZOdTvyfg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PGN3bATo6YWVSgEXdFxvtGjWyFyqbE5b0oQBO8ICYh2bg8kU0FXiKypR0TGOOpPkr
	 Niaho5rYmHyaGbJtZEvbHHwQywnWqKw4G2q7x4BR+S/0nBBP3cD/ymiJjptnEwS89Z
	 8HlBBrpfFec5dx4SkIYijfVi4Xxs6JG6FbrVIFqJH9uYAg2p4Qxb2JodgFO3gN3kdU
	 hM/nfdSWGvAfqqbzaosOaVUBypY2753GkTkTRcoSMeHuef5svqBXQv53IH2EjY5DCK
	 wb9fn3+BLj/PpWaQ7XNZJyQ12nYy8ie6Dvw2k7MPiwcDNNm4HD0jJZ9rvQNMEFnrmr
	 r/iM84CI6Ljsg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Jordan Rhee <jordanrhee@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 5/6] gve: simplify reset logic
Date: Wed, 25 Nov 2026 10:16:38 -0500
Message-ID: <20261125151623.40338-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125151623.40338-1-sashal@kernel.org>
References: <2026112500-overbite-aside-6db0@gregkh>
 <20261125151623.40338-1-sashal@kernel.org>
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

From: Joshua Washington <joshwash@google.com>

[ Upstream commit 23b3b49d204b2c7f6e4a212eacf8ef2af2206919 ]

Current GVE reset logic is quite complex, with a number of methods with
similar names and functionalities. This complexity has allowed a number
of bugs to enter the reset/recovery path, including the potential for
reset loops if an operation fails during teardown.

Simplify the reset path by doing the following:
1) Removing recursive resets. Recursive resets have two major issues.
   First, there is the potential for stack overflows if resets are
   invoked too many times in a row. Second, long recursive calls mean
   that GVE never gives up the RTNL lock, or at the very least holds it
   for too long. Resets triggered by methods as part of the reset path
   are implicitly ignored because gve_reset() now checks if there is a
   reset in progress before proceeding.
2) Removing resets during the teardown portion of reset. This is partly
   covered by removing recursive resets, but the primary goal in this
   case is to allow the driver to complete teardown in a more direct
   manner. Before this patch, gve_close() when called as part of
   gve_shutdown, could end up triggering a hardware reset, then attempt
   to close again. In such a case, destroying hardware queues would
   inevitably fail, causing a loop. gve_close() is no longer called
   directly in gve_reset() breaking any possibility of this loop.
3) Decompose allocation/de-allocation and setup/teardown. Performing
   allocation and setup for each control plane system (RSS, ptype map,
   etc) leaves many more error conditions to handle, causing teardown in
   the case of failures to be much more complex than they need to be.
   This will also be useful to better align a major behavioral change
   in mailbox mode, which will use separate response buffers instead to
   get data from the device instead of a pre-allocated shared memory
   region.

With the new reset functionality, shared resources between the device
and driver are not freed until after the hardware reset has completed
in the event that deconfigure_device_resources() fails, meaning that the
device could potentially still be holding on to shared memory.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
Link: https://patch.msgid.link/20260930190428.1130007-7-hramamurthy@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 7de69da15088 ("gve: Fix race between stats query and queue reconfig")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/google/gve/gve.h         |   2 +-
 drivers/net/ethernet/google/gve/gve_adminq.c  |   9 +-
 drivers/net/ethernet/google/gve/gve_adminq.h  |   1 -
 drivers/net/ethernet/google/gve/gve_ethtool.c |   2 +-
 .../net/ethernet/google/gve/gve_flow_rule.c   |  15 +-
 drivers/net/ethernet/google/gve/gve_main.c    | 531 +++++++++---------
 6 files changed, 298 insertions(+), 262 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 47ecf52858eea..cbbc298a97898 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -1342,7 +1342,7 @@ struct page_pool *gve_rx_create_page_pool(struct gve_priv *priv,
 
 /* Reset */
 void gve_schedule_reset(struct gve_priv *priv);
-int gve_reset(struct gve_priv *priv, bool attempt_teardown);
+int gve_reset(struct gve_priv *priv, bool skip_queue_setup);
 void gve_get_curr_alloc_cfgs(struct gve_priv *priv,
 			     struct gve_tx_alloc_rings_cfg *tx_alloc_cfg,
 			     struct gve_rx_alloc_rings_cfg *rx_alloc_cfg);
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 143a6e85eb77a..57de5feba8f6b 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -365,7 +365,7 @@ int gve_adminq_init(struct gve_priv *priv)
 	return gve_adminq_alloc(priv);
 }
 
-void gve_adminq_release(struct gve_priv *priv)
+static void gve_adminq_release(struct gve_priv *priv)
 {
 	int i = 0;
 
@@ -394,7 +394,6 @@ void gve_adminq_release(struct gve_priv *priv)
 	}
 	gve_clear_device_rings_ok(priv);
 	gve_clear_device_resources_ok(priv);
-	gve_clear_admin_queue_ok(priv);
 }
 
 void gve_adminq_free(struct gve_priv *priv)
@@ -1377,12 +1376,8 @@ gve_adminq_configure_flow_rule(struct gve_priv *priv,
 			sizeof(struct gve_adminq_configure_flow_rule),
 			flow_rule_cmd);
 
-	if (err == -ETIME) {
-		dev_err(&priv->pdev->dev, "Timeout to configure the flow rule, trigger reset");
-		gve_reset(priv, true);
-	} else if (!err) {
+	if (!err)
 		priv->flow_rules_cache.rules_cache_synced = false;
-	}
 
 	return err;
 }
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/ethernet/google/gve/gve_adminq.h
index e294036fb67be..4e0c6bb5217f7 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.h
+++ b/drivers/net/ethernet/google/gve/gve_adminq.h
@@ -621,7 +621,6 @@ static_assert(sizeof(union gve_adminq_command) == 64);
 
 int gve_adminq_init(struct gve_priv *priv);
 void gve_adminq_free(struct gve_priv *priv);
-void gve_adminq_release(struct gve_priv *priv);
 int gve_adminq_describe_device(struct gve_priv *priv);
 int gve_adminq_configure_device_resources(struct gve_priv *priv,
 					  dma_addr_t counter_array_bus_addr,
diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index 8199738ba979e..dd1c44fedc771 100644
--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -651,7 +651,7 @@ static int gve_user_reset(struct net_device *netdev, u32 *flags)
 
 	if (*flags == ETH_RESET_ALL) {
 		*flags = 0;
-		return gve_reset(priv, true);
+		return gve_reset(priv, false);
 	}
 
 	return -EOPNOTSUPP;
diff --git a/drivers/net/ethernet/google/gve/gve_flow_rule.c b/drivers/net/ethernet/google/gve/gve_flow_rule.c
index db8b9a39bfc89..d7f9aa898a803 100644
--- a/drivers/net/ethernet/google/gve/gve_flow_rule.c
+++ b/drivers/net/ethernet/google/gve/gve_flow_rule.c
@@ -279,6 +279,11 @@ int gve_add_flow_rule(struct gve_priv *priv, struct ethtool_rxnfc *cmd)
 		goto out;
 
 	err = gve_adminq_add_flow_rule(priv, rule, fsp->location);
+	if (err == -ETIME) {
+		dev_err(&priv->pdev->dev,
+			"Timeout to add flow rule, trigger reset.");
+		gve_reset(priv, false);
+	}
 
 out:
 	kvfree(rule);
@@ -291,9 +296,17 @@ int gve_add_flow_rule(struct gve_priv *priv, struct ethtool_rxnfc *cmd)
 int gve_del_flow_rule(struct gve_priv *priv, struct ethtool_rxnfc *cmd)
 {
 	struct ethtool_rx_flow_spec *fsp = (struct ethtool_rx_flow_spec *)&cmd->fs;
+	int err;
 
 	if (!priv->max_flow_rules)
 		return -EOPNOTSUPP;
 
-	return gve_adminq_del_flow_rule(priv, fsp->location);
+	err = gve_adminq_del_flow_rule(priv, fsp->location);
+	if (err == -ETIME) {
+		dev_err(&priv->pdev->dev,
+			"Timeout to delete flow rule, trigger reset.");
+		gve_reset(priv, false);
+	}
+
+	return err;
 }
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 28fd4677071da..96848598f082c 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -261,6 +261,7 @@ static void gve_free_stats_report(struct gve_priv *priv)
 		return;
 
 	timer_delete_sync(&priv->stats_report_timer);
+	cancel_work_sync(&priv->stats_report_task);
 	dma_free_coherent(&priv->pdev->dev, priv->stats_report_len,
 			  priv->stats_report, priv->stats_report_bus);
 	priv->stats_report = NULL;
@@ -590,7 +591,80 @@ static void gve_free_notify_blocks(struct gve_priv *priv)
 	priv->msix_vectors = NULL;
 }
 
-static int gve_setup_device_resources(struct gve_priv *priv)
+static void gve_tx_get_curr_alloc_cfg(struct gve_priv *priv,
+				      struct gve_tx_alloc_rings_cfg *cfg)
+{
+	cfg->qcfg = &priv->tx_cfg;
+	cfg->raw_addressing = !gve_is_qpl(priv);
+	cfg->ring_size = priv->tx_desc_cnt;
+	cfg->pages_per_qpl = priv->tx_pages_per_qpl;
+	cfg->num_xdp_rings = cfg->qcfg->num_xdp_queues;
+	cfg->tx = priv->tx;
+}
+
+static void gve_rx_get_curr_alloc_cfg(struct gve_priv *priv,
+				      struct gve_rx_alloc_rings_cfg *cfg)
+{
+	cfg->qcfg_rx = &priv->rx_cfg;
+	cfg->qcfg_tx = &priv->tx_cfg;
+	cfg->raw_addressing = !gve_is_qpl(priv);
+	cfg->enable_header_split = priv->header_split_enabled;
+	cfg->ring_size = priv->rx_desc_cnt;
+	cfg->pages_per_qpl = priv->rx_pages_per_qpl;
+	cfg->packet_buffer_size = priv->rx_cfg.packet_buffer_size;
+	cfg->rx = priv->rx;
+	cfg->xdp = !!cfg->qcfg_tx->num_xdp_queues;
+}
+
+void gve_get_curr_alloc_cfgs(struct gve_priv *priv,
+			     struct gve_tx_alloc_rings_cfg *tx_alloc_cfg,
+			     struct gve_rx_alloc_rings_cfg *rx_alloc_cfg)
+{
+	gve_tx_get_curr_alloc_cfg(priv, tx_alloc_cfg);
+	gve_rx_get_curr_alloc_cfg(priv, rx_alloc_cfg);
+}
+
+static void gve_queues_mem_free(struct gve_priv *priv,
+				struct gve_tx_alloc_rings_cfg *tx_cfg,
+				struct gve_rx_alloc_rings_cfg *rx_cfg)
+{
+	if (gve_is_gqi(priv)) {
+		gve_tx_free_rings_gqi(priv, tx_cfg);
+		gve_rx_free_rings_gqi(priv, rx_cfg);
+	} else {
+		gve_tx_free_rings_dqo(priv, tx_cfg);
+		gve_rx_free_rings_dqo(priv, rx_cfg);
+	}
+}
+
+static void gve_queues_mem_remove(struct gve_priv *priv)
+{
+	struct gve_tx_alloc_rings_cfg tx_alloc_cfg = {0};
+	struct gve_rx_alloc_rings_cfg rx_alloc_cfg = {0};
+
+	gve_get_curr_alloc_cfgs(priv, &tx_alloc_cfg, &rx_alloc_cfg);
+	gve_queues_mem_free(priv, &tx_alloc_cfg, &rx_alloc_cfg);
+	priv->tx = NULL;
+	priv->rx = NULL;
+}
+
+static void gve_free_control_plane_resources(struct gve_priv *priv)
+{
+	bitmap_free(priv->xsk_pools);
+	priv->xsk_pools = NULL;
+
+	kvfree(priv->ptype_lut_dqo);
+	priv->ptype_lut_dqo = NULL;
+
+	gve_teardown_clock(priv);
+	gve_free_stats_report(priv);
+	gve_free_notify_blocks(priv);
+	gve_free_counter_array(priv);
+	gve_free_rss_config_cache(priv);
+	gve_free_flow_rule_caches(priv);
+}
+
+static int gve_alloc_control_plane_resources(struct gve_priv *priv)
 {
 	int err;
 
@@ -599,16 +673,42 @@ static int gve_setup_device_resources(struct gve_priv *priv)
 		return err;
 	err = gve_alloc_rss_config_cache(priv);
 	if (err)
-		goto abort_with_flow_rule_caches;
+		goto abort;
 	err = gve_alloc_counter_array(priv);
 	if (err)
-		goto abort_with_rss_config_cache;
+		goto abort;
 	err = gve_alloc_notify_blocks(priv);
 	if (err)
-		goto abort_with_counter;
+		goto abort;
 	err = gve_alloc_stats_report(priv);
 	if (err)
-		goto abort_with_ntfy_blocks;
+		goto abort;
+
+	if (!gve_is_gqi(priv)) {
+		priv->ptype_lut_dqo = kvzalloc_obj(*priv->ptype_lut_dqo,
+						   GFP_KERNEL);
+		if (!priv->ptype_lut_dqo) {
+			err = -ENOMEM;
+			goto abort;
+		}
+	}
+
+	priv->xsk_pools = bitmap_zalloc(priv->rx_cfg.max_queues, GFP_KERNEL);
+	if (!priv->xsk_pools) {
+		err = -ENOMEM;
+		goto abort;
+	}
+
+	return 0;
+abort:
+	gve_free_control_plane_resources(priv);
+	return err;
+}
+
+static int gve_setup_control_plane_resources(struct gve_priv *priv)
+{
+	int err = 0;
+
 	err = gve_adminq_configure_device_resources(priv,
 						    priv->counter_array_bus,
 						    priv->num_event_counters,
@@ -618,20 +718,15 @@ static int gve_setup_device_resources(struct gve_priv *priv)
 		dev_err(&priv->pdev->dev,
 			"could not setup device_resources: err=%d\n", err);
 		err = -ENXIO;
-		goto abort_with_stats_report;
+		return err;
 	}
 
 	if (!gve_is_gqi(priv)) {
-		priv->ptype_lut_dqo = kvzalloc_obj(*priv->ptype_lut_dqo);
-		if (!priv->ptype_lut_dqo) {
-			err = -ENOMEM;
-			goto abort_with_stats_report;
-		}
 		err = gve_adminq_get_ptype_map_dqo(priv, priv->ptype_lut_dqo);
 		if (err) {
 			dev_err(&priv->pdev->dev,
 				"Failed to get ptype map: err=%d\n", err);
-			goto abort_with_ptype_lut;
+			goto deconfigure_device;
 		}
 	}
 
@@ -646,7 +741,7 @@ static int gve_setup_device_resources(struct gve_priv *priv)
 	err = gve_init_rss_config(priv, priv->rx_cfg.num_queues);
 	if (err) {
 		dev_err(&priv->pdev->dev, "Failed to init RSS config");
-		goto abort_with_clock;
+		goto deconfigure_device;
 	}
 
 	err = gve_adminq_report_stats(priv, priv->stats_report_len,
@@ -658,67 +753,77 @@ static int gve_setup_device_resources(struct gve_priv *priv)
 	gve_set_device_resources_ok(priv);
 	return 0;
 
-abort_with_clock:
-	gve_teardown_clock(priv);
-abort_with_ptype_lut:
-	kvfree(priv->ptype_lut_dqo);
-	priv->ptype_lut_dqo = NULL;
-abort_with_stats_report:
-	gve_free_stats_report(priv);
-abort_with_ntfy_blocks:
-	gve_free_notify_blocks(priv);
-abort_with_counter:
-	gve_free_counter_array(priv);
-abort_with_rss_config_cache:
-	gve_free_rss_config_cache(priv);
-abort_with_flow_rule_caches:
-	gve_free_flow_rule_caches(priv);
-
+deconfigure_device:
+	gve_adminq_deconfigure_device_resources(priv);
 	return err;
 }
 
-static void gve_trigger_reset(struct gve_priv *priv);
-
-static void gve_teardown_device_resources(struct gve_priv *priv)
+/**
+ * gve_teardown_control_plane_resources() - Request the device to release any
+ * shared allocated resources.
+ *
+ * @priv: Pointer to the GVE private device data structure.
+ *
+ * If any part of the teardown step fails, the failure is documented, but is
+ * otherwise ignored. It is expected that a device reset is triggered
+ * immediately after tearing down device resources, which would clear any
+ * lingering state on the device.
+ */
+static void gve_teardown_control_plane_resources(struct gve_priv *priv)
 {
 	int err;
 
+	if (priv->ptp)
+		ptp_cancel_worker_sync(priv->ptp->clock);
+
 	/* Tell device its resources are being freed */
 	if (gve_get_device_resources_ok(priv)) {
 		err = gve_flow_rules_reset(priv);
-		if (err) {
+		if (err)
 			dev_err(&priv->pdev->dev,
 				"Failed to reset flow rules: err=%d\n", err);
-			gve_trigger_reset(priv);
-		}
 		/* detach the stats report */
 		err = gve_adminq_report_stats(priv, 0, 0x0, GVE_STATS_REPORT_TIMER_PERIOD);
-		if (err) {
+		if (err)
 			dev_err(&priv->pdev->dev,
 				"Failed to detach stats report: err=%d\n", err);
-			gve_trigger_reset(priv);
-		}
 		err = gve_adminq_deconfigure_device_resources(priv);
-		if (err) {
+		if (err)
 			dev_err(&priv->pdev->dev,
 				"Could not deconfigure device resources: err=%d\n",
 				err);
-			gve_trigger_reset(priv);
-		}
 	}
 
-	kvfree(priv->ptype_lut_dqo);
-	priv->ptype_lut_dqo = NULL;
-
-	gve_free_flow_rule_caches(priv);
-	gve_free_rss_config_cache(priv);
-	gve_free_counter_array(priv);
-	gve_free_notify_blocks(priv);
-	gve_free_stats_report(priv);
-	gve_teardown_clock(priv);
 	gve_clear_device_resources_ok(priv);
 }
 
+/**
+ * gve_reset_device() - Reset the device
+ *
+ * @priv: Pointer to the GVE private device data structure.
+ *
+ * Once this returns, the device is guaranteed not to access any memory it
+ * shares with the driver, so it is safe for the caller to recycle it. Device
+ * commands in gve_teardown_control_plane_resources() can fail, in which case
+ * the hardware reset triggered by gve_adminq_free() is the only such
+ * guarantee.
+ */
+static void gve_reset_device(struct gve_priv *priv)
+{
+	gve_teardown_control_plane_resources(priv);
+	gve_adminq_free(priv);
+}
+
+static void gve_teardown_device(struct gve_priv *priv)
+{
+	gve_reset_device(priv);
+	/* Free any resources shared with the device only after we have a
+	 * guarantee that the device will not try to access such resources.
+	 */
+	gve_free_control_plane_resources(priv);
+	gve_queues_mem_remove(priv);
+}
+
 static int gve_unregister_qpl(struct gve_priv *priv,
 			      struct gve_queue_page_list *qpl)
 {
@@ -916,17 +1021,6 @@ static void gve_init_sync_stats(struct gve_priv *priv)
 		u64_stats_init(&priv->rx[i].statss);
 }
 
-static void gve_tx_get_curr_alloc_cfg(struct gve_priv *priv,
-				      struct gve_tx_alloc_rings_cfg *cfg)
-{
-	cfg->qcfg = &priv->tx_cfg;
-	cfg->raw_addressing = !gve_is_qpl(priv);
-	cfg->ring_size = priv->tx_desc_cnt;
-	cfg->pages_per_qpl = priv->tx_pages_per_qpl;
-	cfg->num_xdp_rings = cfg->qcfg->num_xdp_queues;
-	cfg->tx = priv->tx;
-}
-
 static void gve_tx_stop_rings(struct gve_priv *priv, int num_rings)
 {
 	int i;
@@ -1044,19 +1138,6 @@ static int gve_destroy_rings(struct gve_priv *priv)
 	return 0;
 }
 
-static void gve_queues_mem_free(struct gve_priv *priv,
-				struct gve_tx_alloc_rings_cfg *tx_cfg,
-				struct gve_rx_alloc_rings_cfg *rx_cfg)
-{
-	if (gve_is_gqi(priv)) {
-		gve_tx_free_rings_gqi(priv, tx_cfg);
-		gve_rx_free_rings_gqi(priv, rx_cfg);
-	} else {
-		gve_tx_free_rings_dqo(priv, tx_cfg);
-		gve_rx_free_rings_dqo(priv, rx_cfg);
-	}
-}
-
 int gve_alloc_page(struct gve_priv *priv, struct device *dev,
 		   struct page **page, dma_addr_t *dma,
 		   enum dma_data_direction dir, gfp_t gfp_flags)
@@ -1157,8 +1238,6 @@ void gve_schedule_reset(struct gve_priv *priv)
 	queue_work(priv->gve_wq, &priv->service_task);
 }
 
-static void gve_reset_and_teardown(struct gve_priv *priv, bool was_up);
-static int gve_reset_recovery(struct gve_priv *priv, bool was_up);
 static void gve_turndown(struct gve_priv *priv);
 static void gve_turnup(struct gve_priv *priv);
 
@@ -1269,37 +1348,16 @@ static int gve_reg_xdp_info(struct gve_priv *priv, struct net_device *dev)
 	return err;
 }
 
-
 static void gve_drain_page_cache(struct gve_priv *priv)
 {
 	int i;
 
+	if (!priv->rx)
+		return;
 	for (i = 0; i < priv->rx_cfg.num_queues; i++)
 		page_frag_cache_drain(&priv->rx[i].page_cache);
 }
 
-static void gve_rx_get_curr_alloc_cfg(struct gve_priv *priv,
-				      struct gve_rx_alloc_rings_cfg *cfg)
-{
-	cfg->qcfg_rx = &priv->rx_cfg;
-	cfg->qcfg_tx = &priv->tx_cfg;
-	cfg->raw_addressing = !gve_is_qpl(priv);
-	cfg->enable_header_split = priv->header_split_enabled;
-	cfg->ring_size = priv->rx_desc_cnt;
-	cfg->pages_per_qpl = priv->rx_pages_per_qpl;
-	cfg->packet_buffer_size = priv->rx_cfg.packet_buffer_size;
-	cfg->rx = priv->rx;
-	cfg->xdp = !!cfg->qcfg_tx->num_xdp_queues;
-}
-
-void gve_get_curr_alloc_cfgs(struct gve_priv *priv,
-			     struct gve_tx_alloc_rings_cfg *tx_alloc_cfg,
-			     struct gve_rx_alloc_rings_cfg *rx_alloc_cfg)
-{
-	gve_tx_get_curr_alloc_cfg(priv, tx_alloc_cfg);
-	gve_rx_get_curr_alloc_cfg(priv, rx_alloc_cfg);
-}
-
 static void gve_rx_start_ring(struct gve_priv *priv, int i)
 {
 	if (gve_is_gqi(priv))
@@ -1335,15 +1393,16 @@ static void gve_rx_stop_rings(struct gve_priv *priv, int num_rings)
 		gve_rx_stop_ring(priv, i);
 }
 
-static void gve_queues_mem_remove(struct gve_priv *priv)
+static void gve_queues_stop(struct gve_priv *priv)
 {
-	struct gve_tx_alloc_rings_cfg tx_alloc_cfg = {0};
-	struct gve_rx_alloc_rings_cfg rx_alloc_cfg = {0};
+	gve_unreg_xdp_info(priv);
+	gve_drain_page_cache(priv);
 
-	gve_get_curr_alloc_cfgs(priv, &tx_alloc_cfg, &rx_alloc_cfg);
-	gve_queues_mem_free(priv, &tx_alloc_cfg, &rx_alloc_cfg);
-	priv->tx = NULL;
-	priv->rx = NULL;
+	timer_delete_sync(&priv->stats_report_timer);
+	cancel_work_sync(&priv->stats_report_task);
+
+	gve_tx_stop_rings(priv, gve_num_tx_queues(priv));
+	gve_rx_stop_rings(priv, priv->rx_cfg.num_queues);
 }
 
 /* The passed-in queue memory is stored into priv and the queues are made live.
@@ -1368,6 +1427,8 @@ static int gve_queues_start(struct gve_priv *priv,
 	priv->rx_desc_cnt = rx_alloc_cfg->ring_size;
 	priv->tx_pages_per_qpl = tx_alloc_cfg->pages_per_qpl;
 	priv->rx_pages_per_qpl = rx_alloc_cfg->pages_per_qpl;
+	priv->header_split_enabled = rx_alloc_cfg->enable_header_split;
+	priv->rx_cfg.packet_buffer_size = rx_alloc_cfg->packet_buffer_size;
 
 	gve_tx_start_rings(priv, gve_num_tx_queues(priv));
 	gve_rx_start_rings(priv, rx_alloc_cfg->qcfg_rx->num_queues);
@@ -1375,14 +1436,14 @@ static int gve_queues_start(struct gve_priv *priv,
 
 	err = netif_set_real_num_tx_queues(dev, priv->tx_cfg.num_queues);
 	if (err)
-		goto stop_and_free_rings;
+		goto stop_rings;
 	err = netif_set_real_num_rx_queues(dev, priv->rx_cfg.num_queues);
 	if (err)
-		goto stop_and_free_rings;
+		goto stop_rings;
 
 	err = gve_reg_xdp_info(priv, dev);
 	if (err)
-		goto stop_and_free_rings;
+		goto stop_rings;
 
 	if (rx_alloc_cfg->reset_rss) {
 		err = gve_init_rss_config(priv, priv->rx_cfg.num_queues);
@@ -1394,9 +1455,6 @@ static int gve_queues_start(struct gve_priv *priv,
 	if (err)
 		goto reset;
 
-	priv->header_split_enabled = rx_alloc_cfg->enable_header_split;
-	priv->rx_cfg.packet_buffer_size = rx_alloc_cfg->packet_buffer_size;
-
 	err = gve_create_rings(priv);
 	if (err)
 		goto reset;
@@ -1415,16 +1473,14 @@ static int gve_queues_start(struct gve_priv *priv,
 
 reset:
 	if (gve_get_reset_in_progress(priv))
-		goto stop_and_free_rings;
-	gve_reset_and_teardown(priv, true);
-	/* if this fails there is nothing we can do so just ignore the return */
-	gve_reset_recovery(priv, false);
-	/* return the original error */
-	return err;
-stop_and_free_rings:
-	gve_tx_stop_rings(priv, gve_num_tx_queues(priv));
-	gve_rx_stop_rings(priv, priv->rx_cfg.num_queues);
-	gve_queues_mem_remove(priv);
+		goto stop_rings;
+
+	/* Attempt to reset. If reset is successful, gve_queues_start was
+	 * successful with the new config.
+	 */
+	return gve_reset(priv, false);
+stop_rings:
+	gve_queues_stop(priv);
 	return err;
 }
 
@@ -1435,70 +1491,55 @@ static int gve_open(struct net_device *dev)
 	struct gve_priv *priv = netdev_priv(dev);
 	int err;
 
+	if (!gve_get_device_resources_ok(priv)) {
+		dev_err(&priv->pdev->dev,
+			"Attempting to open netdev without resources. Device must be reset.");
+		return -ENODEV;
+	}
+
 	gve_get_curr_alloc_cfgs(priv, &tx_alloc_cfg, &rx_alloc_cfg);
 
 	err = gve_queues_mem_alloc(priv, &tx_alloc_cfg, &rx_alloc_cfg);
 	if (err)
 		return err;
 
-	/* No need to free on error: ownership of resources is lost after
-	 * calling gve_queues_start.
-	 */
 	err = gve_queues_start(priv, &tx_alloc_cfg, &rx_alloc_cfg);
-	if (err)
+	if (err) {
+		gve_queues_mem_remove(priv);
 		return err;
+	}
 
 	return 0;
 }
 
-static int gve_queues_stop(struct gve_priv *priv)
+static int gve_close(struct net_device *dev)
 {
+	struct gve_priv *priv = netdev_priv(dev);
 	int err;
 
-	netif_carrier_off(priv->dev);
+	gve_turndown(priv);
+
+	/* Surrender to reset if the queue destroying adminq cmds fail. Reset
+	 * will not re-enable the interface.
+	 */
 	if (gve_get_device_rings_ok(priv)) {
-		gve_turndown(priv);
-		gve_drain_page_cache(priv);
+		gve_clear_device_rings_ok(priv);
 		err = gve_destroy_rings(priv);
 		if (err)
-			goto err;
+			goto reset;
 		err = gve_unregister_qpls(priv);
 		if (err)
-			goto err;
-		gve_clear_device_rings_ok(priv);
+			goto reset;
 	}
-	timer_delete_sync(&priv->stats_report_timer);
-
-	gve_unreg_xdp_info(priv);
-
-	gve_tx_stop_rings(priv, gve_num_tx_queues(priv));
-	gve_rx_stop_rings(priv, priv->rx_cfg.num_queues);
 
+	gve_queues_stop(priv);
+	gve_queues_mem_remove(priv);
 	priv->interface_down_cnt++;
 	return 0;
 
-err:
-	/* This must have been called from a reset due to the rtnl lock
-	 * so just return at this point.
-	 */
-	if (gve_get_reset_in_progress(priv))
-		return err;
-	/* Otherwise reset before returning */
-	gve_reset_and_teardown(priv, true);
-	return gve_reset_recovery(priv, false);
-}
-
-static int gve_close(struct net_device *dev)
-{
-	struct gve_priv *priv = netdev_priv(dev);
-	int err;
-
-	err = gve_queues_stop(priv);
-	if (err)
-		return err;
-
-	gve_queues_mem_remove(priv);
-	return 0;
+reset:
+	err = gve_reset(priv, true);
+	return err;
 }
 
 static void gve_handle_link_status(struct gve_priv *priv, bool link_status)
@@ -1833,9 +1874,7 @@ int gve_adjust_config(struct gve_priv *priv,
 	if (err) {
 		netif_err(priv, drv, priv->dev,
 			  "Adjust config failed to start new queues, !!! DISABLING ALL QUEUES !!!\n");
-		/* No need to free on error: ownership of resources is lost after
-		 * calling gve_queues_start.
-		 */
+		gve_queues_mem_remove(priv);
 		gve_turndown(priv);
 		return err;
 	}
@@ -2149,8 +2188,11 @@ static int gve_set_features(struct net_device *netdev,
 	}
 	if ((netdev->features & NETIF_F_NTUPLE) && !(features & NETIF_F_NTUPLE)) {
 		err = gve_flow_rules_reset(priv);
-		if (err)
+		if (err) {
+			if (err == -ETIME)
+				gve_schedule_reset(priv);
 			goto revert_features;
+		}
 	}
 
 	return 0;
@@ -2235,7 +2277,8 @@ static void gve_handle_reset(struct gve_priv *priv)
 	if (gve_get_do_reset(priv)) {
 		rtnl_lock();
 		netdev_lock(priv->dev);
-		gve_reset(priv, false);
+		if (gve_get_do_reset(priv))
+			gve_reset(priv, false);
 		netdev_unlock(priv->dev);
 		rtnl_unlock();
 	}
@@ -2421,25 +2464,17 @@ static int gve_setup_device(struct gve_priv *priv)
 
 	priv->num_registered_pages = 0;
 
-	priv->xsk_pools = bitmap_zalloc(priv->rx_cfg.max_queues, GFP_KERNEL);
-	if (!priv->xsk_pools) {
-		err = -ENOMEM;
-		goto err;
-	}
-
 	gve_set_netdev_xdp_features(priv);
 	if (!gve_is_gqi(priv))
 		priv->dev->xdp_metadata_ops = &gve_xdp_metadata_ops;
 
-	err = gve_setup_device_resources(priv);
+	err = gve_alloc_control_plane_resources(priv);
 	if (err)
-		goto err_free_xsk_bitmap;
-
+		goto err;
+	err = gve_setup_control_plane_resources(priv);
+	if (err)
+		goto err;
 	return 0;
-
-err_free_xsk_bitmap:
-	bitmap_free(priv->xsk_pools);
-	priv->xsk_pools = NULL;
 err:
 	return err;
 }
@@ -2512,30 +2547,7 @@ static int gve_init_priv(struct gve_priv *priv)
 	return 0;
 }
 
-static void gve_teardown_priv_resources(struct gve_priv *priv)
-{
-	gve_teardown_device_resources(priv);
-	gve_adminq_free(priv);
-	bitmap_free(priv->xsk_pools);
-	priv->xsk_pools = NULL;
-}
-
-static void gve_trigger_reset(struct gve_priv *priv)
-{
-	/* Reset the device by releasing the AQ */
-	gve_adminq_release(priv);
-}
-
-static void gve_reset_and_teardown(struct gve_priv *priv, bool was_up)
-{
-	gve_trigger_reset(priv);
-	/* With the reset having already happened, close cannot fail */
-	if (was_up)
-		gve_close(priv->dev);
-	gve_teardown_priv_resources(priv);
-}
-
-static int gve_reset_recovery(struct gve_priv *priv, bool was_up)
+static int gve_recover(struct gve_priv *priv, bool setup_queues)
 {
 	int err;
 
@@ -2543,62 +2555,79 @@ static int gve_reset_recovery(struct gve_priv *priv, bool was_up)
 	if (err) {
 		dev_err(&priv->pdev->dev,
 			"Failed to alloc admin queue: err=%d\n", err);
-		goto err;
+		goto teardown_device;
 	}
 
 	err = gve_adminq_verify_driver_compatibility(priv);
 	if (err) {
 		dev_err(&priv->pdev->dev,
 			"Could not verify driver compatibility: err=%d\n", err);
-		goto err_free_adminq;
+		goto teardown_device;
 	}
 
 	err = gve_setup_device(priv);
 	if (err)
-		goto err_free_adminq;
-	if (was_up) {
+		goto teardown_device;
+
+	if (setup_queues) {
+		/* On failure, hold on to the control plane to give a
+		 * chance for the queues to be brought up later.
+		 */
 		err = gve_open(priv->dev);
-		if (err)
+		if (err) {
+			dev_err(&priv->pdev->dev,
+				"Failed to start queues: err=%d, !!! DISABLING ALL QUEUES !!!\n",
+				err);
 			return err;
+		}
 	}
+
+	/* undo any detach from an earlier failure */
+	netif_device_attach(priv->dev);
+
 	return 0;
 
-err_free_adminq:
-	gve_adminq_free(priv);
-err:
-	dev_err(&priv->pdev->dev, "Reset failed! !!! DISABLING ALL QUEUES !!!\n");
-	gve_turndown(priv);
+teardown_device:
+	dev_err(&priv->pdev->dev, "Recover failed: err=%d, detaching device\n",
+		err);
+	netif_device_detach(priv->dev);
+	gve_teardown_device(priv);
 	return err;
 }
 
-int gve_reset(struct gve_priv *priv, bool attempt_teardown)
+int gve_reset(struct gve_priv *priv, bool skip_queue_setup)
 {
 	bool was_up = netif_running(priv->dev);
 	int err;
 
+	if (gve_get_reset_in_progress(priv))
+		return 0;
+
 	dev_info(&priv->pdev->dev, "Performing reset\n");
 	gve_clear_do_reset(priv);
 	gve_set_reset_in_progress(priv);
-	/* If we aren't attempting to teardown normally, just go turndown and
-	 * reset right away.
-	 */
-	if (!attempt_teardown) {
+
+	if (was_up) {
 		gve_turndown(priv);
-		gve_reset_and_teardown(priv, was_up);
-	} else {
-		/* Otherwise attempt to close normally */
-		if (was_up) {
-			err = gve_close(priv->dev);
-			/* If that fails reset as we did above */
-			if (err)
-				gve_reset_and_teardown(priv, was_up);
+		if (gve_get_device_rings_ok(priv)) {
+			gve_clear_device_rings_ok(priv);
+			gve_destroy_rings(priv);
+			gve_unregister_qpls(priv);
 		}
-		/* Clean up any remaining resources */
-		gve_teardown_priv_resources(priv);
 	}
 
-	/* Set it all back up */
-	err = gve_reset_recovery(priv, was_up);
+	disable_work(&priv->service_task);
+	gve_reset_device(priv);
+	gve_queues_stop(priv);
+	gve_queues_mem_remove(priv);
+	gve_free_control_plane_resources(priv);
+
+	enable_work(&priv->service_task);
+	err = gve_recover(priv, was_up && !skip_queue_setup);
+	if (err)
+		dev_info(&priv->pdev->dev,
+			 "Failed to recover in reset: %d\n", err);
+
 	gve_clear_reset_in_progress(priv);
 	priv->reset_cnt++;
 	priv->interface_up_cnt = 0;
@@ -2925,7 +2954,7 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (err) {
 		dev_err(&priv->pdev->dev,
 			"Could not setup device: err=%d\n", err);
-		goto abort_with_wq;
+		goto abort_teardown_device;
 	}
 
 	if (!gve_is_gqi(priv) && !gve_is_qpl(priv))
@@ -2933,7 +2962,7 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	err = register_netdev(dev);
 	if (err)
-		goto abort_with_gve_init;
+		goto abort_teardown_device;
 
 	dev_info(&pdev->dev, "GVE version %s\n", gve_version_str);
 	dev_info(&pdev->dev, "GVE queue format %d\n", (int)priv->queue_format);
@@ -2941,8 +2970,9 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	queue_work(priv->gve_wq, &priv->service_task);
 	return 0;
 
-abort_with_gve_init:
-	gve_teardown_priv_resources(priv);
+abort_teardown_device:
+	disable_work_sync(&priv->service_task);
+	gve_teardown_device(priv);
 
 abort_with_wq:
 	destroy_workqueue(priv->gve_wq);
@@ -2974,7 +3004,8 @@ static void gve_remove(struct pci_dev *pdev)
 	void __iomem *reg_bar = priv->reg_bar0;
 
 	unregister_netdev(netdev);
-	gve_teardown_priv_resources(priv);
+	disable_work_sync(&priv->service_task);
+	gve_teardown_device(priv);
 	destroy_workqueue(priv->gve_wq);
 	priv->ctrl_ops->unmap_db_bar(priv);
 	free_netdev(netdev);
@@ -2989,17 +3020,16 @@ static void gve_shutdown(struct pci_dev *pdev)
 	struct gve_priv *priv = netdev_priv(netdev);
 	bool was_up = netif_running(priv->dev);
 
-	netif_device_detach(netdev);
+	disable_work_sync(&priv->service_task);
 
 	rtnl_lock();
 	netdev_lock(netdev);
-	if (was_up && gve_close(priv->dev)) {
-		/* If the dev was up, attempt to close, if close fails, reset */
-		gve_reset_and_teardown(priv, was_up);
-	} else {
-		/* If the dev wasn't up or close worked, finish tearing down */
-		gve_teardown_priv_resources(priv);
-	}
+	if (was_up)
+		gve_close(priv->dev);
+
+	/* detach here because gve_close() might attach in recovery */
+	netif_device_detach(netdev);
+	gve_teardown_device(priv);
 	netdev_unlock(netdev);
 	rtnl_unlock();
 }
@@ -3011,16 +3041,14 @@ static int gve_suspend(struct device *dev)
 	struct gve_priv *priv = netdev_priv(netdev);
 	bool was_up = netif_running(priv->dev);
 
+	disable_work_sync(&priv->service_task);
+
 	priv->suspend_cnt++;
 	rtnl_lock();
 	netdev_lock(netdev);
-	if (was_up && gve_close(priv->dev)) {
-		/* If the dev was up, attempt to close, if close fails, reset */
-		gve_reset_and_teardown(priv, was_up);
-	} else {
-		/* If the dev wasn't up or close worked, finish tearing down */
-		gve_teardown_priv_resources(priv);
-	}
+	if (was_up)
+		gve_close(priv->dev);
+	gve_teardown_device(priv);
 	priv->up_before_suspend = was_up;
 	netdev_unlock(netdev);
 	rtnl_unlock();
@@ -3037,7 +3065,8 @@ static int gve_resume(struct device *dev)
 	priv->resume_cnt++;
 	rtnl_lock();
 	netdev_lock(netdev);
-	err = gve_reset_recovery(priv, priv->up_before_suspend);
+	enable_work(&priv->service_task);
+	err = gve_recover(priv, priv->up_before_suspend);
 	netdev_unlock(netdev);
 	rtnl_unlock();
 	return err;
-- 
2.53.0


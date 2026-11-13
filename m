Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794567530;
	b=TxWvVDphcIulXuwi5aIE1hjzgZQkSlAh5luf/ojHyqkGd+xblXEkF2AF4bWpETKYO10C
	 mhgamkL+MEb9T+1maZOI8BFdQpBBqsblLJi3zcDn9noanys1//cFPDvL9Nem9EMrkEOV6
	 ok5C5rVwPoMNgx+0o6t+aIqzZd//KpUrSOsDcu4Ti8FPFT0aEj78G/DHxph2gF1S37VUV
	 19cudFV6nxnQtlN7K7btZ4e5G6q5SK06f1fD8BPpbJe/iry6BzJJlFNj1X2ZjV2QFW2sK
	 pfVfn+yW1/pfmxxQ40w7uKCLmOtP1cw9Nxbc2JnTxeQQo9DkLlD/ZFT/uk4rFzz4+Sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794567530;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id;
	bh=eABLV8g008jJr2G6ZeA0fIMhAhB4uWtAjm7pWUKqD20=;
	b=y3nW7+r2bYCV5XtUAo9yR2eWY8zxHY/INL2EQRbIQglEv2qLw6eHGQ0KNgKuG97imuRX
	 GrZ2A9O59mNLH1RGxwEV6ua6kDbf7pauKVBSb3ZamfWdIucKijseklaGxA7BXCZ7dJNGm
	 pCgehdcQ9r6INkBCG/z89NnjATnBYF8nP/7LbGYZKzhxxwvFvQQbSaCos9WY2KqvwSbNj
	 1lu4lyJNMoqqyQnsdb9eEC4NIiy3hiTN8m/rTymQco2zDD4tdMv6zDFdZgs2E3m2F2mun
	 w3qobSpA7uQvxuz1sKBJdL0NXzxv9ElXWnF6CdV0YRlNsI92YoR7X+6LbasDO99/Ctg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=CLOkfTMX;
	arc=none smtp.remote-ip=195.10.208.47
Received: from mout-b-107.mailbox.org (mout-b-107.mailbox.org [195.10.208.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2573D606BD8D;
	Fri, 13 Nov 2026 10:58:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2573D606BD8D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=CLOkfTMX
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-107.mailbox.org (Postfix) with ESMTPS id 4jQvPx32Lrz3yZH;
	Fri, 13 Nov 2026 11:58:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1794567525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eABLV8g008jJr2G6ZeA0fIMhAhB4uWtAjm7pWUKqD20=;
	b=CLOkfTMXA1U+ukSdTBtzQH0garR1WQlsXjPQbBIi2CIgiSpbb4M4vhZSMbXWfJY77Rx1sT
	JgpF2zn7VN6f8Q2OSQllZlBEgF4WwPQMYhO54stm8S2msxkxi1VblrtmgaalCtGxq/DRE3
	Zntmof/qXFsu/lkiBLoscIwOJ6Ks0Xen5/WDSNHO7Y//iMP8NpBKUtHQMBBIO94LYjfrGL
	Us6HuCiY22lP2j+G7dNaLwr4TdGbuymYZQa4uQojPrb1cwgu6lF+9gFmvxHWpa26TR5OF+
	89QBNUwZfb7nc64y7rgS5tGfeuR5G5svoJkq1as8wv7HSw2OZucfemburVmnjg==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of antonio@mandelbit.com designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=antonio@mandelbit.com
From: Antonio Quartulli <antonio@mandelbit.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Antonio Quartulli <antonio@mandelbit.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Joe Damato <joe@dama.to>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net 2/3] igb: link queues to NAPIs under RTNL after runtime resume
Date: Fri, 13 Nov 2026 11:58:32 +0100
Message-ID: <20261113105835.3821433-2-antonio@mandelbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261113105835.3821433-1-antonio@mandelbit.com>
References: <20261113105835.3821433-1-antonio@mandelbit.com>
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
X-Rspamd-Queue-Id: 4jQvPx32Lrz3yZH

__igb_open() links queues to NAPIs with netif_queue_set_napi(), which
requires RTNL, but RTNL isn't held when resuming from runtime suspend:
this triggers "RTNL: assertion failed".

Don't link them in __igb_open() when resuming: do it right away on
system resume (RTNL held) and from a work item taking RTNL on runtime
resume. The links can't be kept across a suspend, because
__igb_shutdown() frees the q_vectors. These are only freed under RTNL
with __IGB_DOWN set, so the work item checks __IGB_DOWN under RTNL.

Fixes: b75a1dea500f ("igb: Link queues to NAPI instances")
Cc: stable@vger.kernel.org # 6.16+
Closes: https://bugzilla.ipfire.org/show_bug.cgi?id=13562
Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
---
Note: igc may have the same issue: __igc_open() also links queues to NAPIs
(igc_set_queue_napi()) on the RTNL-less runtime resume path. We didn't
have igc hardware to test a fix with, so no igc patch is sent for now.

 drivers/net/ethernet/intel/igb/igb.h      |  1 +
 drivers/net/ethernet/intel/igb/igb_main.c | 38 +++++++++++++++++++++--
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index 0fff1df..ea2d739 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -585,6 +585,7 @@ struct igb_adapter {
 
 	struct work_struct reset_task;
 	struct work_struct watchdog_task;
+	struct work_struct queue_napi_task;
 	bool fc_autoneg;
 	u8  tx_timeout_factor;
 	struct timer_list blink_timer;
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index bd1185d..4d97399 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -2115,6 +2115,30 @@ void igb_set_queue_napi(struct igb_adapter *adapter, int vector,
 				     NETDEV_QUEUE_TYPE_TX, napi);
 }
 
+static void igb_link_queue_napis(struct igb_adapter *adapter)
+{
+	int i;
+
+	for (i = 0; i < adapter->num_q_vectors; i++)
+		igb_set_queue_napi(adapter, i, &adapter->q_vector[i]->napi);
+}
+
+/* Linking queues to NAPIs requires RTNL, which isn't held when resuming
+ * from runtime suspend: do it from here instead. The q_vectors are only
+ * freed under RTNL with __IGB_DOWN set, so checking it under RTNL is safe.
+ */
+static void igb_queue_napi_task(struct work_struct *work)
+{
+	struct igb_adapter *adapter = container_of(work, struct igb_adapter,
+						   queue_napi_task);
+
+	rtnl_lock();
+	if (!test_bit(__IGB_DOWN, &adapter->state) &&
+	    netif_running(adapter->netdev))
+		igb_link_queue_napis(adapter);
+	rtnl_unlock();
+}
+
 /**
  *  igb_up - Open the interface and prepare it to handle traffic
  *  @adapter: board private structure
@@ -3426,6 +3450,7 @@ static int igb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	INIT_WORK(&adapter->reset_task, igb_reset_task);
 	INIT_WORK(&adapter->watchdog_task, igb_watchdog_task);
+	INIT_WORK(&adapter->queue_napi_task, igb_queue_napi_task);
 
 	/* Initialize link properties that are user-changeable */
 	adapter->fc_autoneg = true;
@@ -3890,6 +3915,7 @@ static void igb_remove(struct pci_dev *pdev)
 
 	cancel_work_sync(&adapter->reset_task);
 	cancel_work_sync(&adapter->watchdog_task);
+	cancel_work_sync(&adapter->queue_napi_task);
 
 #ifdef CONFIG_IGB_DCA
 	if (adapter->flags & IGB_FLAG_DCA_ENABLED) {
@@ -4184,7 +4210,8 @@ static int __igb_open(struct net_device *netdev, bool resuming)
 	for (i = 0; i < adapter->num_q_vectors; i++) {
 		napi = &adapter->q_vector[i]->napi;
 		napi_enable(napi);
-		igb_set_queue_napi(adapter, i, napi);
+		if (!resuming)
+			igb_set_queue_napi(adapter, i, napi);
 	}
 
 	/* Clear any pending interrupts. */
@@ -9631,8 +9658,15 @@ static int __igb_resume(struct device *dev, bool rpm)
 
 	if (!rpm)
 		rtnl_lock();
-	if (!err && netif_running(netdev))
+	if (!err && netif_running(netdev)) {
 		err = __igb_open(netdev, true);
+		if (!err) {
+			if (rpm)
+				schedule_work(&adapter->queue_napi_task);
+			else
+				igb_link_queue_napis(adapter);
+		}
+	}
 
 	if (!err)
 		netif_device_attach(netdev);
-- 
2.56.0


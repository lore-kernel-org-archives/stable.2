Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.61
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795564665;
	b=tzU/E5UCjIDk41oWkWaVOfZaMeGsxE/2Ya4jMB+GCnxs5T6k1NCTGxNp3xckQBs1NDey
	 ymTl5eWmclTOiL01nX6/JBljx8M+QlJsZulXM2/ak0ro1FdSPAuBjONb0nnyNS+oUQn76
	 SPhXmN+ckxifGTA/GeT/W17PmBKewrMyVEyZJjppa7OVLaAIopsTYSirYZdWdi5GORcn5
	 /8wE6C4jcmY2aNxRRUpDa59Qxpvw3O7cDGUTce0nx4FxzXHDBsPLggNZGi9ZckNAoVmuC
	 fxKxycW39JDEpVaogfAaNk/PQ/mo6jp0x/V/I5ioDR9infOk2MPMEL6QL/AMmGSo6Pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795564665;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id;
	bh=NeH4msFzp7KNZlqjZxxwoBpRbytEX5mDF3Plc/IaGJs=;
	b=DBQd/NxDiclNShXHDM/ZSE/RB0WEgHFTmHwBuYqVBASfzrVbJVurWQMax/+i1lTgROXT
	 p0IhNUmrk6sfbVnQOCQKmTJjRZbIDM9j30R0HlzSdhXwFClwCHIBri6f0jcA2ki0TgbRE
	 ht2RvL6pF0tpaJdA3IJp30ukKiG0t4t3biPv21BIQARJPKkLp+1Z+pbQmNTD/IWbQ1udr
	 oQYuMFkSPWk/WNPFoD8yJ4I5maK9AzfGOVZZ9qgGR7XX3QIv+8n/mmePKPJbJQerUqqCZ
	 EgdXZytRyT6AV0yX5got5YJXzmREAMqIDVc51v+jYzedRDBx172AULD1yr+U+o+6x4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=o8lsIACM;
	arc=none smtp.remote-ip=195.10.208.61
Received: from mout-b-201.mailbox.org (mout-b-201.mailbox.org [195.10.208.61])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56339606A696;
	Tue, 24 Nov 2026 23:57:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56339606A696
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=o8lsIACM
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-201.mailbox.org (Postfix) with ESMTPS id 4jZ09W6npszLmZY;
	Wed, 25 Nov 2026 00:57:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1795564656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NeH4msFzp7KNZlqjZxxwoBpRbytEX5mDF3Plc/IaGJs=;
	b=o8lsIACMTombAUPxA3EYNk+avIvK70iDEo9juR+U8nGUVhzzcRSoBFnvLL4EQWlmDgsaKU
	j0SyREf8W6EucBR98SuYpU/Lee0dq9Mo1Zp9EznP/6SJB6jHu8GPVldUlA0AC3XwRaD9D3
	y3hQ5ATjpSheYV4B6/3aedBwvrKFu+gkpKPVwRCYfC2r8WaQt4O/x+zRPuEHnLPXEjUf9z
	5zM5SpmFjSTT4IY3rE9JC3tqdtMp9OHdjDdF6Y9jWvBgsuHLM6X//GglDxtw2nY4n3kzhT
	66SmZqGxujzckuT8zJS3eOzutMjSpIMtfs/5lioUNxeZ+ms9B8UmyepdXxAMIw==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of antonio@mandelbit.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=antonio@mandelbit.com
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
	Janis Edvarts Lacis <janislacis06@gmail.com>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Joe Damato <joe@dama.to>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v5 4/6] igb: link queues to NAPIs under RTNL after runtime resume
Date: Wed, 25 Nov 2026 00:57:19 +0100
Message-ID: <20261124235723.1135808-5-antonio@mandelbit.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124235723.1135808-1-antonio@mandelbit.com>
References: <20261124235723.1135808-1-antonio@mandelbit.com>
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
X-Rspamd-Queue-Id: 4jZ09W6npszLmZY

__igb_open() links queues to NAPIs with netif_queue_set_napi(), which
requires RTNL, but RTNL isn't held when resuming from runtime suspend:
this triggers "RTNL: assertion failed".

Link them in __igb_open() only when RTNL is held, and from the work
item that sets the real queue counts on runtime resume. The links can't
be kept across a suspend, because __igb_shutdown() frees the q_vectors.
A suspend now cancels the work item before freeing them, so it only runs
after the resume that scheduled it allocated them, and it checks
__IGB_DOWN under RTNL for a close in the meantime.

Tested with the 82576 emulated by QEMU.

Fixes: b75a1dea500f ("igb: Link queues to NAPI instances")
Cc: stable@vger.kernel.org # 6.16+
Closes: https://bugzilla.ipfire.org/show_bug.cgi?id=13562
Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
---
v5: cancel the work item before a suspend (Sashiko)
v4: no changes
v3: link the NAPIs from the work item added by the previous patch, and
in __igb_open() whenever RTNL is held (also on system sleep resume);
dropped Joe's Reviewed-by, as the patch changed
v2: no code changes; mention the tested hardware

Note: igc has the same issue: __igc_open() also links queues to NAPIs
(igc_set_queue_napi()) on the RTNL-less runtime resume path. A fix will
follow separately once it has been tested on igc hardware.

 drivers/net/ethernet/intel/igb/igb_main.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 6961646..acd9a33 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -4146,8 +4146,19 @@ static int igb_set_real_num_queues(struct igb_adapter *adapter)
 	return netif_set_real_num_queues(netdev, adapter->num_tx_queues, rxq);
 }
 
+static void igb_link_queue_napis(struct igb_adapter *adapter)
+{
+	int i;
+
+	for (i = 0; i < adapter->num_q_vectors; i++)
+		igb_set_queue_napi(adapter, i, &adapter->q_vector[i]->napi);
+}
+
 /* Some settings need RTNL, which isn't held when resuming from runtime
- * suspend: apply them from here instead, if the device is still up.
+ * suspend: apply them from here instead, if the device is still up. A
+ * suspend cancels this work before freeing the q_vectors, so it only runs
+ * after the resume that scheduled it allocated them; checking __IGB_DOWN
+ * under RTNL covers a close in the meantime.
  */
 static void igb_rtnl_resume_task(struct work_struct *work)
 {
@@ -4160,6 +4171,7 @@ static void igb_rtnl_resume_task(struct work_struct *work)
 		if (igb_set_real_num_queues(adapter))
 			netdev_err(adapter->netdev,
 				   "error setting real queue count\n");
+		igb_link_queue_napis(adapter);
 	}
 	rtnl_unlock();
 }
@@ -4237,7 +4249,8 @@ static int __igb_open(struct net_device *netdev, bool resuming,
 	for (i = 0; i < adapter->num_q_vectors; i++) {
 		napi = &adapter->q_vector[i]->napi;
 		napi_enable(napi);
-		igb_set_queue_napi(adapter, i, napi);
+		if (rtnl_held)
+			igb_set_queue_napi(adapter, i, napi);
 	}
 
 	/* Clear any pending interrupts. */
@@ -9548,6 +9561,11 @@ static int __igb_shutdown(struct pci_dev *pdev, bool *enable_wake,
 	u32 wufc = runtime ? E1000_WUFC_LNKC : adapter->wol;
 	bool wake;
 
+	/* Don't let a work item queued by an earlier resume run once the
+	 * q_vectors are freed or reallocated
+	 */
+	cancel_work_sync(&adapter->rtnl_resume_task);
+
 	rtnl_lock();
 	netif_device_detach(netdev);
 
-- 
2.56.1


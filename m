Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CA635DA41;
	Thu, 17 Sep 2026 15:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789657407; cv=none; b=rfcZaDftXYbCOwLlveOpEfQ8z90ib6cZ0ejaJ6XBJchdtqPx44MUECBb9kwM/9IQHuJjQLuvI+sAgGL9LLlr6kN8s+zAWfwN16pnB4YAhXaCoJ7KK2+ecbdKB4T+CtzjMFJEduPGlyQl5Xw5agpIhTog15LMj521JlwnLsO2DRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789657407; c=relaxed/simple;
	bh=xP8KOV9mibGmwWpNu4BvT0HthivXKZNQ8gu5RcidnzA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DOzBrLzsDHqTAP2RMu6FsUAmcWur7zZJkG8PLUpgBzVuUWCEwUW3Bgxr2G8ovqOzoti51U0xtqyIXI5SxIl3Fu4XQ3DD8a7r9eBxY67bRkhHq9hPd0ETpg9hgQP9KOIHx7tWTsLH+6EN5Zd68eurY1ssLZIdHk93vTlVrQBbvqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=XzhyC205; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="XzhyC205"
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4e2966651;
	Thu, 17 Sep 2026 23:02:56 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: anthony.l.nguyen@intel.com
Cc: alessio.bogani@elettra.eu,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	horms@kernel.org,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	runyu.xiao@seu.edu.cn,
	jianhao.xu@seu.edu.cn
Subject: [PATCH net v2] igb: initialize PTP state before registering PHC
Date: Thu, 17 Sep 2026 23:02:47 +0800
Message-Id: <20260917150247.2562991-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cd12af33-ed01-4eca-88e3-703b59c05453@intel.com>
References: <cd12af33-ed01-4eca-88e3-703b59c05453@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0afe464bc03a1kunmedc4fb9b36b0e0
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZSh9DVhpDSB8YGB4YSB8YTFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUJCSU
	5LVUpLS1VKQktCWQY+
DKIM-Signature: a=rsa-sha256;
	b=XzhyC205B32Mf5pmI+JBcc79zrNKxHnWA4LYoiFwnF/aeRxZa8X/houtANseOcnJRLeobbzXLSdIv6cw6dfTyruIm1O542KeZIvzaykMYQVxbVuCY8CSZs6Ie3fG2sisR7QklGdmDbm7DVZ9fU7btJpwAmvUdql4uUJuae7Kl0w=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=CVA/CWhw4JetoLTPs+u2MtnfUXnMQ1sROVyIw6FlqyI=;
	h=date:mime-version:subject:message-id:from;

igb_ptp_init() currently initializes the PTP lock, work items,
timestamp configuration, and timecounter after ptp_clock_register().
The PHC is published by that call, so PTP callbacks and timestamp
interrupts can run before those objects are ready.

Initialize the complete PTP state before registering the PHC. Skip the
setup when CONFIG_PTP_1588_CLOCK is disabled, since the PTP registration
helper is then a no-op. If PHC registration fails, cancel the work items
queued by igb_ptp_reset() or a timestamp interrupt before returning.

Fixes: b888c510f7b3 ("igb: Avoid starting unnecessary workqueues")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/netdev/20260830154912.2712900-1-runyu.xiao@seu.edu.cn/
Assisted-by: LLM
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>

---
v2:
- Restore all PTP state initialization before PHC registration.
- Skip PTP setup when CONFIG_PTP_1588_CLOCK is disabled.
- Cancel both PTP work items when PHC registration fails.
---
 drivers/net/ethernet/intel/igb/igb_ptp.c | 31 +++++++++++++++---------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
index 638d8242b..1c5581451 100644
--- a/drivers/net/ethernet/intel/igb/igb_ptp.c
+++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
@@ -1307,6 +1307,9 @@ void igb_ptp_init(struct igb_adapter *adapter)
 	struct e1000_hw *hw = &adapter->hw;
 	struct net_device *netdev = adapter->netdev;
 
+	if (!IS_ENABLED(CONFIG_PTP_1588_CLOCK))
+		return;
+
 	switch (hw->mac.type) {
 	case e1000_82576:
 		snprintf(adapter->ptp_caps.name, 16, "%pm", netdev->dev_addr);
@@ -1378,27 +1381,31 @@ void igb_ptp_init(struct igb_adapter *adapter)
 		return;
 	}
 
+	spin_lock_init(&adapter->tmreg_lock);
+	INIT_WORK(&adapter->ptp_tx_work, igb_ptp_tx_work);
+
+	if (adapter->ptp_flags & IGB_PTP_OVERFLOW_CHECK)
+		INIT_DELAYED_WORK(&adapter->ptp_overflow_work,
+				  igb_ptp_overflow_check);
+
+	adapter->tstamp_config.rx_filter = HWTSTAMP_FILTER_NONE;
+	adapter->tstamp_config.tx_type = HWTSTAMP_TX_OFF;
+
+	igb_ptp_reset(adapter);
+
 	adapter->ptp_clock = ptp_clock_register(&adapter->ptp_caps,
 						&adapter->pdev->dev);
 	if (IS_ERR(adapter->ptp_clock)) {
+		if (adapter->ptp_flags & IGB_PTP_OVERFLOW_CHECK)
+			cancel_delayed_work_sync(&adapter->ptp_overflow_work);
+		cancel_work_sync(&adapter->ptp_tx_work);
+
 		adapter->ptp_clock = NULL;
 		dev_err(&adapter->pdev->dev, "ptp_clock_register failed\n");
 	} else if (adapter->ptp_clock) {
 		dev_info(&adapter->pdev->dev, "added PHC on %s\n",
 			 adapter->netdev->name);
 		adapter->ptp_flags |= IGB_PTP_ENABLED;
-
-		spin_lock_init(&adapter->tmreg_lock);
-		INIT_WORK(&adapter->ptp_tx_work, igb_ptp_tx_work);
-
-		if (adapter->ptp_flags & IGB_PTP_OVERFLOW_CHECK)
-			INIT_DELAYED_WORK(&adapter->ptp_overflow_work,
-					  igb_ptp_overflow_check);
-
-		adapter->tstamp_config.rx_filter = HWTSTAMP_FILTER_NONE;
-		adapter->tstamp_config.tx_type = HWTSTAMP_TX_OFF;
-
-		igb_ptp_reset(adapter);
 	}
 }
 
-- 
2.34.1

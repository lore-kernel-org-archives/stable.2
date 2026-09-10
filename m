Received: from mta1.migadu.com (out-232.mta1.migadu.com [95.215.58.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9CB387346
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 03:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789009886; cv=none; b=nTrgRwumhfmZ1jrKEtNNiZPVt3A/Dc5FblwJzob3gkXbpCghV7vinn/dDE0xrmhW8CyRjisKzy+Das0iu3+vhBwNOecp1N7gfg16pXcFn5WIflQqLoxks71rnXwRbLApmxuQtT8pahnTe2eDsXjEaOeJEiEw/ssTjHHcFZnms9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789009886; c=relaxed/simple;
	bh=SIqGZyfsfyKf1E4lLdDLS4ULkhunGBeR5pKAUW45QQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IURnFqhKfy0rFzlykgcRqGzRVyfA5QozUJZNdLLlcbDng5nbvNGe1DVGvP3ajgHV1hSIANEJNlWVnveslTSP+O7LOxWr8Eucqa04eJd6YcjDxhLKL+etN/slUoIF5nclbl5Q38zAHNm/Xjuv+cbh2K45G1OiuuHey4sdIHamypE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca; spf=pass smtp.mailfrom=justthetip.ca; dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b=nfCSucC+; arc=none smtp.client-ip=95.215.58.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b="nfCSucC+"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=SIqGZyfsfyKf1E4lLdDLS4ULkhunGBeR5pKAUW45QQA=;
 c=simple/simple; d=justthetip.ca;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789009875; v=1; x=1789614675;
 b=nfCSucC+/tpQIYTrkLIcAezexRbLqdxlwfltaGNbPHLylIE++3YzOY4/YqMkxO6Xm/bmUBwz
 EllYRHhBQMftf3KFbNO4ZOG7PvhbSJp+BkKo1jAKAMV8A9eDY21Mvr9ZJIJOrJ7GxlWWF9dtTSc
 xGlfgO+WrEzLuVDTblRj+kwvnHIUxxsNSTpgQA9R3Ye3h6jjY+Irv3JafBjlMIoWGusL1smxy9u
 l8UvIrcbVoJ9d+ROEC6zfF20XuBXv8gAbxAeLSpw07yyD1MvulF1+A3Zr2AQ/UJR0+QDCuc9Fgw
 x4iCTPzRQOEq9Th74vIIYe1RmEeL9nZfowC4cDQ+9LHmg==
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6c2ddf06cac6a47b;
	Thu, 10 Sep 2026 03:11:15 +0000
X-Mizu-Trace-ID: 6c2ddf06cac6a47b
X-Migadu-Flow: FLOW_OUT
From: Devin Wittmayer <lucid_duck@justthetip.ca>
To: stable@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>,
	Wentao Guan <guanwentao@uniontech.com>,
	linux-wireless@vger.kernel.org
Subject: [PATCH 7.1.y 2/2] wifi: mt76: mt7925: cancel pending mlo_pm_work
Date: Wed,  9 Sep 2026 20:11:04 -0700
Message-ID: <20260910031106.25906-5-lucid_duck@justthetip.ca>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910031106.25906-1-lucid_duck@justthetip.ca>
References: <20260910031106.25906-1-lucid_duck@justthetip.ca>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wentao Guan <guanwentao@uniontech.com>

commit 2889e84282dda147f10b10d94cf0efd90a349c53 upstream.

If the device is reset, suspended or unregistered within that window,
the pending work can still run and access vif/bss data that may already
be freed, or send MCU commands while the firmware is not available.

Add cancel_delayed_work_sync(&dev->mlo_pm_work) in all relevant teardown
and suspend paths:

 - mt7925_mac_reset_work()        (chip reset recovery)
 - mt7925e_unregister_device()    (PCIe unbind)
 - mt7925_pci_suspend()           (PCIe bus suspend)
 - mt7925_suspend()               (mac80211 suspend)
 - mt7925u_suspend()              (USB bus / runtime suspend)

This ensures the work is stopped before the device state becomes
invalid.

Assisted-by: kimi-cli:kimi-k2.7 code
Assisted-by: atomcode:glm-5.2 #Reported-by

Fixes: 276a568832577 ("wifi: mt76: mt7925: update the power-saving flow")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
Signed-off-by: Devin Wittmayer <lucid_duck@justthetip.ca>
---
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
index f1946ef..c74e134 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
@@ -1314,6 +1314,7 @@ void mt7925_mac_reset_work(struct work_struct *work)
 
 	cancel_delayed_work_sync(&dev->mphy.mac_work);
 	cancel_delayed_work_sync(&pm->ps_work);
+	cancel_delayed_work_sync(&dev->mlo_pm_work);
 	cancel_work_sync(&pm->wake_work);
 
 	for (i = 0; i < 10; i++) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 8050bd7..c20f4a3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1605,6 +1605,7 @@ static int mt7925_suspend(struct ieee80211_hw *hw,
 	cancel_delayed_work_sync(&phy->mt76->mac_work);
 
 	cancel_delayed_work_sync(&dev->pm.ps_work);
+	cancel_delayed_work_sync(&dev->mlo_pm_work);
 	mt76_connac_free_pending_tx_skbs(&dev->pm, NULL);
 
 	mt792x_mutex_acquire(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
index 4883772..b23d014 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
@@ -42,6 +42,7 @@ static void mt7925e_unregister_device(struct mt792x_dev *dev)
 	mt76_for_each_q_rx(&dev->mt76, i)
 		napi_disable(&dev->mt76.napi[i]);
 	cancel_delayed_work_sync(&pm->ps_work);
+	cancel_delayed_work_sync(&dev->mlo_pm_work);
 	cancel_work_sync(&pm->wake_work);
 	cancel_work_sync(&dev->reset_work);
 
@@ -455,6 +456,7 @@ static int mt7925_pci_suspend(struct device *device)
 	dev->hif_resumed = false;
 	flush_work(&dev->reset_work);
 	cancel_delayed_work_sync(&pm->ps_work);
+	cancel_delayed_work_sync(&dev->mlo_pm_work);
 	cancel_work_sync(&pm->wake_work);
 
 	mt7925_roc_abort_sync(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/usb.c b/drivers/net/wireless/mediatek/mt76/mt7925/usb.c
index d9968f0..7ba50c3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/usb.c
@@ -251,6 +251,7 @@ static int mt7925u_suspend(struct usb_interface *intf, pm_message_t state)
 	pm->suspended = true;
 	dev->hif_resumed = false;
 	flush_work(&dev->reset_work);
+	cancel_delayed_work_sync(&dev->mlo_pm_work);
 
 	mt76_connac_mcu_set_hif_suspend(&dev->mt76, true, false);
 	ret = wait_event_timeout(dev->wait,


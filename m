Received: from mta0.migadu.com (out-56.mta0.migadu.com [91.218.175.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57685384CDD
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 03:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789009887; cv=none; b=AbmJuPR2H2ALshOuDm2hziIOfQmiCgscwQ1H61spr+1+EAx7KDdXg/U/SLTThPY6Cw99Oq08ldGE072WLNo3n1uthNcKTB71+qXm6SyyuO1s2wASZiuTk5yQtbc8Tod0AZ+DG2DUenMRX4FgjMGEIYlujlnnRTmgiVbj4WUFink=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789009887; c=relaxed/simple;
	bh=MxuuGjuc+Q7r9CTYgjxjtVmtqA/MKeh1uLKYoDz2iPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e6ka/2w8Pb1OXBD1axi2HH6uuZ0BP5dSGwPS9ZjSneZdg1TIWsrtQ/2eOC7ttmQPj5Ku91QPycRyflobVSovOIQto4fGkP5OuyimFhBXMdL17tekQ0NSC7H4+4A+Ue1rbzBVLVv9u2oDCt8VL9e5AifKiNj/zvt9LMY/ehHOzSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca; spf=pass smtp.mailfrom=justthetip.ca; dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b=ObSLvvmB; arc=none smtp.client-ip=91.218.175.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b="ObSLvvmB"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=MxuuGjuc+Q7r9CTYgjxjtVmtqA/MKeh1uLKYoDz2iPc=;
 c=simple/simple; d=justthetip.ca;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789009878; v=1; x=1789614678;
 b=ObSLvvmBfw27LICYm69nQu+cFkCB1wEmzw5Y/vG+ku+oWlYGB0LQJqV6hd9E8oewWN3FUU0X
 n8pxi7TrPv5tDG2DE470bItBASsYZo4b8sCkp2TFfvEnaRTykkiIxH9VtSR7pOByrlu0HYUU1tt
 MlAo6Y97vfegplViW6kpzv3qDeixLujnHwPdrk8tvd+7E3PUl7F/gsNd7eBzb5SYNT/wM20/lMl
 lHS827bBti2O3/EVyJdjXyYXAqR8a/Zx/LPSqj3wq/j0aq8R+obdL7zu82aKTRLbl2VtILw659j
 Uck82yxGtvmEHpJJmEj08nVLC8P6XJP8KVKF5I9uky2Fw==
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id eaf2dea66643c40a;
	Thu, 10 Sep 2026 03:11:18 +0000
X-Mizu-Trace-ID: eaf2dea66643c40a
X-Migadu-Flow: FLOW_OUT
From: Devin Wittmayer <lucid_duck@justthetip.ca>
To: stable@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>,
	Wentao Guan <guanwentao@uniontech.com>,
	linux-wireless@vger.kernel.org
Subject: [PATCH 7.2.y 2/2] wifi: mt76: mt7925: cancel pending mlo_pm_work
Date: Wed,  9 Sep 2026 20:11:06 -0700
Message-ID: <20260910031106.25906-7-lucid_duck@justthetip.ca>
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
index c7a07c7..9b58ffe 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
@@ -1323,6 +1323,7 @@ void mt7925_mac_reset_work(struct work_struct *work)
 
 	cancel_delayed_work_sync(&dev->mphy.mac_work);
 	cancel_delayed_work_sync(&pm->ps_work);
+	cancel_delayed_work_sync(&dev->mlo_pm_work);
 	cancel_work_sync(&pm->wake_work);
 
 	for (i = 0; i < 10; i++) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 61c9c30..3beb2c1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1640,6 +1640,7 @@ static int mt7925_suspend(struct ieee80211_hw *hw,
 	cancel_delayed_work_sync(&phy->mt76->mac_work);
 
 	cancel_delayed_work_sync(&dev->pm.ps_work);
+	cancel_delayed_work_sync(&dev->mlo_pm_work);
 	mt76_connac_free_pending_tx_skbs(&dev->pm, NULL);
 
 	mt792x_mutex_acquire(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
index ea64303..084baad 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
@@ -48,6 +48,7 @@ static void mt7925e_unregister_device(struct mt792x_dev *dev)
 	mt76_for_each_q_rx(&dev->mt76, i)
 		napi_disable(&dev->mt76.napi[i]);
 	cancel_delayed_work_sync(&pm->ps_work);
+	cancel_delayed_work_sync(&dev->mlo_pm_work);
 	cancel_work_sync(&pm->wake_work);
 	cancel_work_sync(&dev->reset_work);
 
@@ -517,6 +518,7 @@ static int mt7925_pci_suspend(struct device *device)
 	dev->hif_resumed = false;
 	flush_work(&dev->reset_work);
 	cancel_delayed_work_sync(&pm->ps_work);
+	cancel_delayed_work_sync(&dev->mlo_pm_work);
 	cancel_work_sync(&pm->wake_work);
 
 	mt7925_roc_abort_sync(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/usb.c b/drivers/net/wireless/mediatek/mt76/mt7925/usb.c
index e9f5849..a798164 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/usb.c
@@ -269,6 +269,7 @@ static int mt7925u_suspend(struct usb_interface *intf, pm_message_t state)
 	pm->suspended = true;
 	dev->hif_resumed = false;
 	flush_work(&dev->reset_work);
+	cancel_delayed_work_sync(&dev->mlo_pm_work);
 
 	mt76_connac_mcu_set_hif_suspend(&dev->mt76, true, false);
 	ret = wait_event_timeout(dev->wait,


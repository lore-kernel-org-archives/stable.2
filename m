Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F263C3F6E
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 20:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785182694; cv=none; b=ZahQ0dabhHDme+EeNJAlMpYWM/PnIIpIGA9gltMrw+mfJPo30DTbr/m5vtk4nsJy3R/qFx4pkp8zymkOGWoxHI8HZquq6cINFGh7KQWljuiHY+2bMaqbJJQm3T/eii45CdFnq1cVraNfLrGUEKqH8EGU8SnErnvpBwaMsdno0dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785182694; c=relaxed/simple;
	bh=k5cbXlw9uwy3cQaYVG3iayE5yJ6IcieVYPaWx5q/LTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t4osJRzyGb6UogMPFgTbUewRwhg3f+bqlLqCc9f19s+wQfcVLDFOHeponDSZgnAhHdhXHcRBME19SqCrNbq4AjIAEiZagmnLMuJjZW6hOTY96ycVl43rWbJ2+zgu3khC0WYAQM+3242RUt+KmzWjXzMDyVUpiN7sqK2406t4XQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y8Qtm/sh; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8Qtm/sh"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4957eefd361so23155175e9.1
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 13:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785182690; x=1785787490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vDIac45RIuvLJRTWSXLnkBc2gzMGU15MkFTMnnrYVY0=;
        b=Y8Qtm/shVUbkrNkgQxH8Cizp7ELUtfYKSvawx3e4DNALnyiock+ufscrEL+rtaPUrN
         LKCgFZXacQFwymqldcUdH/X7KWHrdCbfFoIoPrk8OW85PT8BbkN1RcVWRWdRPbKPxznK
         E4930CWteemYsj6wo0/NjqEbC2U6AGyQ+KxDqbb5vaiydRWaIyDMODhAlyxXMe5Q0D3/
         cHIIyKc+77iWYqqVMo9O5SAekVXm9KnBxbD2zgXaIqIwuW4cDrE8cmvq3Ta03ssUihlx
         /1DX5YQfTeGwAuie/SY3RwPZNzMddFzor3sgucguZLBkdRpG9PRghSNpgMTTabDQ2fiP
         By1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785182690; x=1785787490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vDIac45RIuvLJRTWSXLnkBc2gzMGU15MkFTMnnrYVY0=;
        b=mk6qcA4V4hPDMFow1sgEOagkGbxD4O+qUIE7tq6oFDRvUKLxWILcofxJqsrtQBnNj+
         vxhWm6+wtrUpSC6IUeYy/Wdh+VLjLy7lc5I9yIoWbOqgYede8iYvc0abtUoLty4LISiv
         T2/R7uawBxerySHB7qCGJSOcbI0Bnjcd7vFYFeSzGGhk96oabnA2mEYP8aoXLdkVO0Bt
         B2Mb/3WUTS2fs9fJDpjAum6Y1RVo0z7J9Lj9SZAghExriwNbGbuqul5lqWpNQEMLimo4
         vemC7WrTKLm+JViQIrYF/r3jVc+vqX9pSTTwwzEgL5tWgIkbCaBYFIPue8AC9urGXJob
         ah7g==
X-Forwarded-Encrypted: i=1; AHgh+Rqg32LWgrTmEOkWQ0ryXy7/vy+i/4Uz2JRYlN46rkW3FXI8ryKuuj2LtiomgjnJkowZ/w4E3+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrO0qqsj8g5qOGNOGHZ9Za6/EmcildYpHD98bKTBzK9iZImCya
	gdFHDf0G1m4MmANxAGztuHoo7ZQqYb5koDrITynfjCsJIokO9AHwclI=
X-Gm-Gg: AR+sD10P2x73lFMJRimRMlgUKlZd7/80DlEzC8BndRuf+EA19QBY77gYT9TblK+U12o
	wgmEJN+QSqHD99OswPJQgel23rvLZncukEdUYvjvE5mPRIl5saVE5nG8qw1IHOQQ+Xwkcn/sWQh
	E42gDmDPJquUE7dvYXd73dMwl71Qf/ltmi/dp5LShBdgA117DVT45UTkbaWfzz2pI9wi3pUsQNH
	dqQSqRynAnpMYuNSBzkgOFOB6m8++WMf8kr/11MeBYXeiyQCNpA+Z9JrAJF9gAGkUhWJOQjl5Q5
	Otp8VNm8SxMxycT08VGbpHImOh3x8d3U35fGtjHgDv1J/K3y6KJZo8jy99qkyDv9FVYTSW8867Q
	fWfIoJ4tSNaPoETKRzstv7oPb4eSr+otHvgftpW77KUd3ADrdWun+5Ye3JoeYlJFhP1MJSCo0vM
	3DOEbVfNvtGJ0PSTf9vAZNM5bJz/j27YHme5rzSDsoISmY1dzYCu9pVv15Y4xf5+2/wvtTDQ5b5
	cQ46FI2eZZT8mNy8TaQEf2wsuiFitXdg/AT8/EDYrC676Y/gs8+8nukut9N2l0elZm+IMHAFDd8
	nwYHLboRIEDjw3bIcLU=
X-Received: by 2002:a05:600c:1d0d:b0:495:3de8:33a6 with SMTP id 5b1f17b1804b1-496b56ffdecmr132086755e9.16.1785182690188;
        Mon, 27 Jul 2026 13:04:50 -0700 (PDT)
Received: from dev-debian.lzampier.com (brnt-07-b2-v4wan-169820-cust69.vm7.cable.virginm.net. [81.102.32.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496c46160dfsm18400985e9.10.2026.07.27.13.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 13:04:49 -0700 (PDT)
From: Lucas Zampieri <lcasmz54@gmail.com>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>
Cc: Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	stable@vger.kernel.org
Subject: [PATCH] wifi: mt76: mt7915: keep the tx worker off the txq scheduler during hw restart
Date: Mon, 27 Jul 2026 17:04:48 -0300
Message-ID: <20260727200448.978087-1-lcasmz54@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <6a67b8bd.4bd67053.2727d8.1806@mx.google.com>
References: <6a67b8bd.4bd67053.2727d8.1806@mx.google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mt7915_mac_full_reset() calls ieee80211_restart_hw(), whose asynchronous
mac80211 reconfiguration tears down and rebuilds every station's TXQs.
Nothing keeps the mt76 tx worker off the mac80211 txq scheduler in that
window, so it dereferences freed TXQs and panics in the mt76-tx kthread.

  mt76_txq_schedule_list <- mt76_tx_worker_run <- mt76_tx_worker

Gate the worker at its entry point instead. Add a reset_pending counter
to struct mt76_dev, raised per band in mt7915_mac_full_reset() and
released as each band's reconfig completes in mt7915_reconfig_complete().
mt76_tx_worker_run() returns immediately while the counter is nonzero,
and the worker is kicked once it drops back to zero. A run already in
flight when the reset starts is serialized by the existing
mt76_worker_disable() in mt7915_mac_restart().

The worker cannot simply be parked across the restart. Driver callbacks
invoked during the reconfiguration (mt7915_mcu_add_tx_ba(),
__mt76_set_channel()) pause and unconditionally resume it, and kthread
parking does not nest.

On MT7981 the panic reproduces within a few resets under tx load via the
sys_recovery debugfs knob. With this patch it no longer occurs, across
forced resets and two weeks of production firmware-triggered resets.

The same restart/reconfig pattern exists in mt7996.

Fixes: 8a55712d124f ("wifi: mt76: mt7915: enable full system reset support")
Cc: stable@vger.kernel.org
Signed-off-by: Lucas Zampieri <lcasmz54@gmail.com>
---

Resent from my own address; please disregard the earlier copy of this
patch sent from an unrelated account by mistake.

 mt76.h        | 2 ++
 mt7915/mac.c  | 3 +++
 mt7915/main.c | 5 +++++
 tx.c          | 3 +++
 4 files changed, 13 insertions(+)

diff --git a/mt76.h b/mt76.h
index dda5034b..ed30768f 100644
--- a/mt76.h
+++ b/mt76.h
@@ -974,6 +974,8 @@ struct mt76_dev {
 	enum mt76_hwrro_mode hwrro_mode;
 
 	struct mt76_worker tx_worker;
+	/* nonzero while a hw restart reconfig is rebuilding the TXQs */
+	atomic_t reset_pending;
 	struct napi_struct tx_napi;
 
 	spinlock_t token_lock;
diff --git a/mt7915/mac.c b/mt7915/mac.c
index cd123253..5f459c63 100644
--- a/mt7915/mac.c
+++ b/mt7915/mac.c
@@ -1428,6 +1428,9 @@ mt7915_mac_full_reset(struct mt7915_dev *dev)
 
 	dev->recovery.hw_full_reset = true;
 
+	/* released per band in mt7915_reconfig_complete() */
+	atomic_add(ext_phy ? 2 : 1, &dev->mt76.reset_pending);
+
 	set_bit(MT76_MCU_RESET, &dev->mphy.state);
 	wake_up(&dev->mt76.mcu.wait);
 	ieee80211_stop_queues(mt76_hw(dev));
diff --git a/mt7915/main.c b/mt7915/main.c
index 42c548a3..73479d6c 100644
--- a/mt7915/main.c
+++ b/mt7915/main.c
@@ -1833,6 +1833,11 @@ mt7915_reconfig_complete(struct ieee80211_hw *hw,
 			 enum ieee80211_reconfig_type reconfig_type)
 {
 	struct mt7915_phy *phy = mt7915_hw_phy(hw);
+	struct mt7915_dev *dev = phy->dev;
+
+	if (reconfig_type == IEEE80211_RECONFIG_TYPE_RESTART &&
+	    !atomic_dec_if_positive(&dev->mt76.reset_pending))
+		mt76_worker_schedule(&dev->mt76.tx_worker);
 
 	ieee80211_wake_queues(hw);
 	ieee80211_queue_delayed_work(hw, &phy->mt76->mac_work,
diff --git a/tx.c b/tx.c
index 4507fd15..e8e86e46 100644
--- a/tx.c
+++ b/tx.c
@@ -767,6 +767,9 @@ void mt76_tx_worker_run(struct mt76_dev *dev)
 	struct mt76_phy *phy;
 	int i;
 
+	if (atomic_read(&dev->reset_pending))
+		return;
+
 	mt76_txq_schedule_all(&dev->phy);
 	for (i = 0; i < ARRAY_SIZE(dev->phys); i++) {
 		phy = dev->phys[i];
-- 
2.47.3


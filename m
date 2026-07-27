Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33843C10B4
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 20:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785182413; cv=none; b=LU1zXQp/LwAixmUQg9AXFRAE2QXzoAz01QCnNhDuymWZ/AywbpVnvwvRY5TjS+VC6G1Oqlpobm37SLus821SlHTgFqtmZr0Pror9qatOOoDqJPOiykWxDHgPezyczlHskgmjXzrqhn5VkjLXSVTIu4LkCu4l5R6Q7kgCsNDX00A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785182413; c=relaxed/simple;
	bh=VN2Zu0KQNDzKBJQR88gb83xdcOIPFPUvUXafsoqUygY=;
	h=Message-ID:Date:From:To:Cc:Subject:Content-Type:MIME-Version; b=WVS5gMzUea5I1A+iUrEpZ3vAEAkJC8dAJnmi60WwVnvv104C55DPDRx94CJlzFNBFjiEDu9NrY+N1Fnd8Cf8YgtCrBOQpjrK9UGxwFARxzf59VDJhAYbXUBW2KfI+SBevvr+at0rJT83BFYDM9hMsWq4vB5OwhIGac8WNRExLqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BvA2pMW0; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BvA2pMW0"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49548aebcd8so23177625e9.3
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 13:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785182398; x=1785787198; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:subject:cc:to
         :from:date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HtNOUytS7spqmKL8HBRjl5j9jbmXbkSAtWYLPzNGcyw=;
        b=BvA2pMW0aqIuFdq9BoRQAVHAvaqa1tvlMdGT1BUNZfJYL1WG11nu4a/7Pw5h8RZGu4
         CSIzHZWxMiuRFpqfZX4ezEmICpvOfJIni3D8hAnIxSUYQvs/X+2rbhxbuITJjG3Wacsy
         R3s0VHQ4zFvqJj9/BqTo2+Qpij3uad1fFes5raQjQhjIFg801Zp2iSGPVjbJVQKRzcqF
         DGmaMiX50QpMujMOt2IUC5s4tZOElcQgG+LW6UDATne1p+8jhSYH5U6peVyWxJobLr3E
         z32g1uB7klFphFZcT5BBnFomSxZ2XACnAXD8uAzhoK3ozlnRDU9D0DRN/Jdwjwo0VEFb
         AUXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785182398; x=1785787198;
        h=mime-version:content-transfer-encoding:content-type:subject:cc:to
         :from:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HtNOUytS7spqmKL8HBRjl5j9jbmXbkSAtWYLPzNGcyw=;
        b=lEtbyOb8mJowJ78Bl+S203UZ2++qecX/9gUszENYbi9LUJqKcty3SWmADTu+T72lak
         4hvjOOxXw23rH0yeac5SYC9OsC4+thpdix8K8+Pa9Gw443epuNoy9MEfmk1cC6JkRWav
         /56s8dWF43VD4BHjs8UKheEqKU8tdR94Uu1k434CHzsNaUGm0Wnkj2eW8CT5sMMlZkPM
         QCQ/hffbJUE2TLQa3nAGTQPbFjpGMuXEbO5NF+352GvtN604Q4C8Ftiq1wM34IUg8yLz
         tGMHw8fTHL8y3sp0jm3ii2ue+C48flvo0WzdVf9IQz+/pvk1ElS3ST6gJFBLBOmSVwAs
         +wSg==
X-Forwarded-Encrypted: i=1; AHgh+RqaO1lnBvXuCdZy1pGNwE+RbCkLXtgK+ce07zkEK/n/Q9hKYJadAJVIFpa7X9bODAou8Ur9JL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeEF6COuuNjj7WD4t056kkEIukLRwnpuVJErl9xgd7CuNkP3Ta
	b8v71vJG2r3JxysiA8njbEL1Z5Gcwq6cRXBGu0H6HnfSE0RO4xrzuILu
X-Gm-Gg: AR+sD10oBgE/mYw4+3PmOiRS1hl9Ru41zH8wQzo13Dt4bvYoUWHK8kom3f71KcwOVpw
	8P7sNMO2cQsNOXzl70CCK/170N3LVloSjiGtHxveYDJ4kHNJGoDobpQ9Jwk7thoTWC8WNlcNI4H
	I1/0nkl62HJEz2ZpLZtlNx/Z7G1lSeFJX4WJGyk69qPuI7weuu8dbYOYn3h2JEvf+CTHYoGjtBm
	PhhaN3xeVtLvYzSJjFCueQNltM7xI70oCe1TaSKjahhaKXsVTbqDTNZZcKtM5FQU1Mwx0Fi0evC
	NUY/93TtkysoQ/q0W9uEFfUtw/3272tDpEBlvaLCQAk9uaeyAFq1bZCpWLJBgaQDf54QLzzeFk7
	KLjgRNJ0/s7Di9Vv6AIog+vNJPHYY+NL8dq4efSqZpiPhCJb2sQGHL0u2DR2MWY73TD1+LpVkMc
	c/lAEh3N7CzDXwp8oSAksV66MezJFsi+TARduI61xngGuZnXCfT9Ok737anE8IW4/65LBzmSpzP
	lDZxQFazW5e
X-Received: by 2002:a05:600c:c4a3:b0:495:7538:d4ea with SMTP id 5b1f17b1804b1-496b5670622mr127824895e9.0.1785182398165;
        Mon, 27 Jul 2026 12:59:58 -0700 (PDT)
Received: from mcp-gateway.lzampier.com (brnt-07-b2-v4wan-169820-cust69.vm7.cable.virginm.net. [81.102.32.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496c46240c4sm17066885e9.12.2026.07.27.12.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 12:59:57 -0700 (PDT)
Message-ID: <6a67b8bd.4bd67053.2727d8.1806@mx.google.com>
Date: Mon, 27 Jul 2026 12:59:57 -0700 (PDT)
From: bookmailer3000@gmail.com
To: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Ryder Lee <ryder.lee@mediatek.com>
Cc: Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
 linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
 stable@vger.kernel.org
Subject: [PATCH] wifi: mt76: mt7915: keep the tx worker off the txq scheduler
 during hw restart
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

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

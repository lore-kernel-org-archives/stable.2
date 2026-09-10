Received: from mta1.migadu.com (out-228.mta1.migadu.com [95.215.58.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755BE3803DE
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 03:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789009876; cv=none; b=dEwZr7RBrNu6uFanc8T+hJHKFdQBAZg+kbUJt1KaZb+SQGxuHkROvxI8k8/s8OQglR4I+zNLQpLdVzUWeQ4K4MtDDEEn3pwb6Csp7J01hBst5AeaYpmCFuk7+tHHvQnr5CfMrr88OgzdIGxxdUfgiBq71dftnohkqlwcR80at0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789009876; c=relaxed/simple;
	bh=7KzUFv49w6HE+2wsp3PnziaKu2DGbCjmay2SdfIHDLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fld/n+czLJ+YIODTv58penjo38T/bH1gcfAgahOX5MIozUh22uEdmXA75z3Z63OlFCEshz3dE/5cZZMrR/WreiubFDpgfdwDoQHGHFqqKn8XopmMDiDEmdpjQomM06ALEThypaQjyOeZRJvFVcQDWEL7Y/Oeils/1gAlxRexJ6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca; spf=pass smtp.mailfrom=justthetip.ca; dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b=bLEEzxmW; arc=none smtp.client-ip=95.215.58.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b="bLEEzxmW"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=7KzUFv49w6HE+2wsp3PnziaKu2DGbCjmay2SdfIHDLI=;
 c=simple/simple; d=justthetip.ca;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789009871; v=1; x=1789614671;
 b=bLEEzxmWINUk/EsTxr48Onxrvfy9wt6Uq+CScH6ZXx5Y29mYc+oS0s8u0c2Lrge2C2uta3rE
 MvwqmmYnRJonoDkEkEluDxGbn5arArPlOi2rPKeYMxk+Zj/fW5CIGX4PPISR23oJwBlkK1xxJ0t
 vms09vmeXJ6WX9o8ydz4OZIPvN+vkLqBs1pOVgNR6gjXus8fCvBpQPv+ENc9XSjUeTNdpBZ9n2H
 L6zBoNuR+wlxttjL/5ZWJhSgE6CNYP4YDIlUA6/wloA62HYu28b8JmDAU2Hyx6HcUjLtwN07rM3
 rakPlIZyuIplPODwWBa271UL0uWREX3SPlC4/MfIWj/CQ==
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6d022997a9e88ff3;
	Thu, 10 Sep 2026 03:11:11 +0000
X-Mizu-Trace-ID: 6d022997a9e88ff3
X-Migadu-Flow: FLOW_OUT
From: Devin Wittmayer <lucid_duck@justthetip.ca>
To: stable@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>,
	Wentao Guan <guanwentao@uniontech.com>,
	linux-wireless@vger.kernel.org
Subject: [PATCH 6.18.y 1/2] wifi: mt76: mt7925: cancel mlo_pm_work on stop
Date: Wed,  9 Sep 2026 20:11:01 -0700
Message-ID: <20260910031106.25906-2-lucid_duck@justthetip.ca>
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

From: Devin Wittmayer <lucid_duck@justthetip.ca>

commit 81faf578320df2dfc682a96baa6e85851dd68b6f upstream.

mt7925 queues mlo_pm_work with a 5 second delay during multi-link
power-save setup and never cancels it on the stop path. If the device is
torn down inside that window, the work outlives the teardown and its timer
fires afterwards, trying to queue onto the workqueue that is already gone:

  workqueue: cannot queue mt7925_mlo_pm_work [mt7925_common] on wq phy0
  WARNING: kernel/workqueue.c:2283 at __queue_work+0x59/0xa0, CPU#1: swapper/1/0
   call_timer_fn+0x2a/0x140
   __run_timers+0x203/0x330
   run_timer_softirq+0x86/0xf0

mt7921 already has its own stop callback, so add one for mt7925 that
cancels the work before calling mt792x_stop().

Fixes: 276a56883257 ("wifi: mt76: mt7925: update the power-saving flow")
Cc: stable@vger.kernel.org
Tested-by: Traockl <281473483+Traockl@users.noreply.github.com>
Signed-off-by: Devin Wittmayer <lucid_duck@justthetip.ca>
---
Backport note: the upstream message ends "mt7925_ops backs both the PCIe
and USB drivers, so this covers both." That is wrong and I said so on the
list on 28 July. mt7925u_probe() replaces the stop callback with its own,
so this reaches PCIe only. I dropped the sentence instead of carrying it
into three more trees. The USB gap is a separate fix, not yet sent.

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 910713e..d22e25b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -2180,10 +2180,19 @@ static void mt7925_rfkill_poll(struct ieee80211_hw *hw)
 	wiphy_rfkill_set_hw_state(hw->wiphy, ret == 0);
 }
 
+static void mt7925_stop(struct ieee80211_hw *hw, bool suspend)
+{
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+
+	cancel_delayed_work_sync(&dev->mlo_pm_work);
+
+	mt792x_stop(hw, suspend);
+}
+
 const struct ieee80211_ops mt7925_ops = {
 	.tx = mt792x_tx,
 	.start = mt7925_start,
-	.stop = mt792x_stop,
+	.stop = mt7925_stop,
 	.add_interface = mt7925_add_interface,
 	.remove_interface = mt792x_remove_interface,
 	.config = mt7925_config,


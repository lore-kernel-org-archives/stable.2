Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4A43CB560
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 11:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785237725; cv=none; b=jzfLSqoXigocfhFYgplM/fY0sCSWJMh2BeVRsldXCyDFlHddYPyAo4BQcl8x9nnrUHgOqKQOK9/WiEPGD6hbsPPneKPKcsBHNP5pxHLuiWrW4zrWOEQwnkcncaeAnbcAMnmFcJf/6ZDw5M/37FuB5+ERgLj2vWhqt00/lJRwEVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785237725; c=relaxed/simple;
	bh=VLecZiYysqRR3FyupZ4wmEA6aHz6zuJCznQDTIRVdyY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aHebvX1L3xoWJKfL+1QCls/b1j+dIalPLtN/lLI5srufPObTsGcMVGa2VGvd9dMRlHdP9IbxZYADm6gNEZp8QcIWKwpaYRd5MzSn0iZWxNaM3wmfc19qT5Zxi3an21EdKVp42Fj5dhDDuURCbBstwJqB/rKR+gF1Hrm/Y8QSJ/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DkMO5jFN; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DkMO5jFN"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-848d21bbaffso3870433b3a.0
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 04:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785237724; x=1785842524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yDhlQhwmlcQWIHpZs2yWSme42s37F9gsvsFAdiLtfjA=;
        b=DkMO5jFNjYufgnqiwuTcv+kdfaXwRxbFI8x9KRmYZGwvx11TPQk5I3MHbNz4RzKnRH
         ywpNeQzuGHVOLHDSSJzAzxOqoNgQ/krvvSYvFwhLHeKmlr0XI+o0Ox39+gCj3mDlfU5F
         Qbm+X+/uOvvJkiWr0sBGr1+eXwTm6HdVWxhepoFWd4XqvLo+/3i5ERARFINT/KYgUZoR
         WTFPVPkzbkZ0I4j3h/gJBfLnBZ4wyJ60JmR4ogHE18mZuxK73cK0z7E8cTwJg4hOczLD
         IEY7UHlNlwRy5adlfZIJD+pq+g4BN+xCKp3KQ7fhWF2vIEMaPjXxmdXfSyJrnHj+DyE5
         Cb5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785237724; x=1785842524;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yDhlQhwmlcQWIHpZs2yWSme42s37F9gsvsFAdiLtfjA=;
        b=TQV8vWHvQXWNlO+my2SfwENxBwbHdcLlTg0kBAFl5CeKm8+MFbM8Y6XOIPWBjr09Xd
         0fok9INLwsPgGBidkxOUkSK9JZ8LtrhWBejeflvYDmMRVLpk0MhSG5P3a3D91O1pFGNl
         OW9jrNwJL2yZVtfw81bxn9bj4b2IGiVsSCYii6d1CZVYB0ZRn7AeXoS8eXT7zXQrnt0T
         dUzBonKnsuVeEReHgOh1PgffG/eGuAzk14caedGX0ZhhfYarwmWNo+yPUO3tE7Jb9MxE
         nx1gBk4x5U5sAEcktmjw/+kAVVndb0SFw10ulcXrCogLB9m3h+gKFowz+fLBhQodVZid
         Zm7g==
X-Forwarded-Encrypted: i=1; AHgh+RoUj2aIGE0Z+8VLIE+C3cgmb40O3DSYHJg5BGTR4qjAb1kFmTsMoDcMLdBuEJbzKDUKM5IPR2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJiJTa7iOHxRp1isVGbrJxT4uKo/CBShayUdVMJqgLbSez5+3d
	vSCIJXquxLI8KQiXBmH9qYRJLfiXt5RzngFkL6e1L1dl+9t/SXuPKLOz
X-Gm-Gg: AR+sD11wNoFjRfgElMQPri2l2Mlpt657k7XH32Sj/jd1yfI9pfmeQnpUV9L+gfxf0x6
	8b6IRimUrJm9qndAkLQh15HXeYpXTpaije1Lmr/ApeEfy7xYGaVDG0vkulAmNakURbUKRxNEOEv
	O0sFfvbUfgZ7lvJW0+5bOtmnQuXgjlLfL8X+n5TjvLLKP2T0naSBCiZgG0IFmzvQAyNnHg5UfW4
	EuaH0T7TdYtLA8PtEUrJrxqLj58NE+iGG6fBIPbS+YTreOiCzCDzB3KSsqZBBnecfbdHHeICCsb
	9iDLpgnWPsLv9ZuFf8zAAe4cCF9ZyHAOL2ivzQHa2iUx/4kWelMCe/gjnSfOE1KhjZZdueoHfda
	0wNDH/5tg8ybmWeA75odKQ3FCNNooBo4UBTzx1YVENmIWv4E4WG6wiHlFuodrtoAZGvV2UfuJLe
	L8oY6ZWF6CSg9HGSBFGvRi+rERvUPUmKT0KMqIVl4srOY1
X-Received: by 2002:a05:6a20:7291:b0:3bf:8f49:4038 with SMTP id adf61e73a8af0-3c8ba545920mr2383726637.39.1785237723498;
        Tue, 28 Jul 2026 04:22:03 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([203.208.189.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13e52f0c6f2sm36299720c88.11.2026.07.28.04.22.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Jul 2026 04:22:03 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Ria Thomas <ria.thomas@morsemicro.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] wifi: mac80211: fix tid_tx use-after-free on BA session stop
Date: Tue, 28 Jul 2026 19:21:56 +0800
Message-ID: <20260728112156.96822-1-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ieee80211_stop_tx_ba_cb() hands tid_tx to kfree_rcu() through
ieee80211_remove_tid_tx(), and then reads tid_tx->ndp after dropping
sta->lock:

	ieee80211_remove_tid_tx(sta, tid);	/* kfree_rcu(tid_tx, rcu_head) */
	...
	spin_unlock_bh(&sta->lock);

	if (start_txq)
		ieee80211_agg_start_txq(sta, tid, false);

	if (send_delba)
		ieee80211_send_delba(..., tid_tx->ndp);

That read is not covered by an RCU read-side critical section, and it runs
in preemptible process context: both callers hold the wiphy mutex, reaching
it either from the ieee80211_ba_session_work() wiphy work or from
ieee80211_sta_tear_down_BA_sessions() during station teardown.
Softirqs can run in that window too, both from the local_bh_enable() that
ends ieee80211_agg_start_txq() and from any interrupt exit, so the RCU
callback can free tid_tx before the read.

Driving the function from a test module with the grace period forced into
that window, KASAN reports the read, and the free arrives on the ordinary
RCU softirq path:

  BUG: KASAN: slab-use-after-free in ieee80211_stop_tx_ba_cb+0x3cd/0x400
  Read of size 1 at addr ffff888002b9f52e by task kworker/0:1/10
  [...]
  Freed by task 57:
   __kasan_slab_free+0x47/0x70
   __rcu_free_sheaf_prepare+0x70/0x250
   rcu_free_sheaf_nobarn+0x18/0x40
   rcu_core+0x426/0x1310
   handle_softirqs+0x144/0x590
   __irq_exit_rcu+0xea/0x150
   irq_exit_rcu+0x9/0x20
   sysvec_apic_timer_interrupt+0x6b/0x80
   asm_sysvec_apic_timer_interrupt+0x1a/0x20

send_delba is only set when tx_stop is set, which happens for
AGG_STOP_LOCAL_REQUEST alone, so this is reached on local teardown -
session idle timeout, PTK rekey, suspend, HW reconfig - and not from a
peer's DELBA.

Read ndp into a local before the session is freed, while sta->lock is still
held. tid_tx->ndp has a single writer, in
ieee80211_tx_ba_session_handle_start(), which cannot run concurrently here:
both paths are serialised by the wiphy mutex, and the session is already
marked HT_AGG_STATE_STOPPING at this point. tid_tx->ndp is also the only
tid_tx dereference left after ieee80211_remove_tid_tx() in this function.

Fixes: 98acd4c1d9f7 ("wifi: mac80211: add support for NDP ADDBA/DELBA for S1G")
Assisted-by: Codex:gpt-5.6-sol
Assisted-by: Kimi:K3
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
 net/mac80211/agg-tx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/agg-tx.c b/net/mac80211/agg-tx.c
index 4833b46770b6..a75be7f37748 100644
--- a/net/mac80211/agg-tx.c
+++ b/net/mac80211/agg-tx.c
@@ -917,6 +917,7 @@ void ieee80211_stop_tx_ba_cb(struct sta_info *sta, int tid,
 	struct ieee80211_sub_if_data *sdata = sta->sdata;
 	bool send_delba = false;
 	bool start_txq = false;
+	bool ndp = false;
 
 	ht_dbg(sdata, "Stopping Tx BA session for %pM tid %d\n",
 	       sta->sta.addr, tid);
@@ -933,6 +934,8 @@ void ieee80211_stop_tx_ba_cb(struct sta_info *sta, int tid,
 	if (tid_tx->stop_initiator == WLAN_BACK_INITIATOR && tid_tx->tx_stop)
 		send_delba = true;
 
+	/* ieee80211_remove_tid_tx() hands tid_tx to kfree_rcu() */
+	ndp = tid_tx->ndp;
 	ieee80211_remove_tid_tx(sta, tid);
 	start_txq = true;
 
@@ -946,7 +949,7 @@ void ieee80211_stop_tx_ba_cb(struct sta_info *sta, int tid,
 		ieee80211_send_delba(sdata, sta->sta.addr, tid,
 				     WLAN_BACK_INITIATOR,
 				     WLAN_REASON_QSTA_NOT_USE,
-				     tid_tx->ndp);
+				     ndp);
 }
 
 void ieee80211_stop_tx_ba_cb_irqsafe(struct ieee80211_vif *vif,
-- 
2.50.1 (Apple Git-155)


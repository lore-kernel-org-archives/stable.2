Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4500733998
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 02:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791944616; cv=none; b=imIRJ+YjJimDNPosD3DfCGSmBL9dNPcqapvB45NhU7FKahC41RoBS+9oM3NMMdIG0XC3kFeGglFoO2NFWRNuJ4mC1V6CFtQC5MxvDNqyJj3csa3N4cGz5dO0H9xUBcvfNkFwzLC12PfQ7huZh23qGy30WGmsqHuzqxug0vyw1LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791944616; c=relaxed/simple;
	bh=k4i6/6E6mfIk5NrCq+HVEpuhDDYq34LcZfQdvlEZ+Tc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e2mb/wZ5E3oESvZkzaWsfNHV9LVu6Y1WAp2DELn39pT4Twi46XFxhdPyMcoX4rcjGFImF0deIrjdKHO4Yop0j8px5IAfZBWWMm0pHlxoSINjeJ4yTINLTe+HcxhzFFe3y3bGiKVtg9ufQzsuho7QOpddKT8SE4ZmBGdMuWWFM4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MhpGSJMi; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MhpGSJMi"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cc52c1b8286so2111646a12.1
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 19:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791944614; x=1792549414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Aflk477R2mLIuCy3ibHQIJkx29Vy5FeRyPLK1blRAzU=;
        b=MhpGSJMipsyArQ4blZ1egiB5y72jjJof2lCfeNLErAjTfZgGKBbWVM/ItalH/1nIu6
         1nFhWbGgx5ekuLfT+Hoxs4iSeJnhoP0s0DFl8B0dO0FaTOXlFYj1IZOSnmon089ejqxn
         owdl5ykAn7jF/tVmC/tgqaq2aTz0ZCKvAb0lY9cSJ98FWyDDnUR2rVmwH1ew50sCSepr
         7FwLKSTyfmiFgu7VKf40awPhFwIOd2NY6HWnRs7eOXSl4mA2KTR1SorVRGJculmRUhn/
         nIrYWQ2tHN2XuCM6ZD2kEnxFqz+CdE7WrqDet2Y13QvUonyhr6te1vxZ63FCe9eb8GUE
         gBdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791944614; x=1792549414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Aflk477R2mLIuCy3ibHQIJkx29Vy5FeRyPLK1blRAzU=;
        b=Hq8dccTWyZJ/BcpSUur+ICYaWYDKmXiXeA/HVQdfcKvn7e6dkZcZ93MadzxG3AlMZD
         LUt6QDV3eqt4FE9RRBNGSBOiQQGBDnQooTO/vcd+YqmgQt49BhSDoL77slclbFFwNlC5
         trY3TCTAdba2C3ubrXJaWuXfCSpKzXuEu3H4T4fEAA8elcrp4Z4V8MnymRNhn1Tvpyll
         +o/LVe2rdQ8YXPOJXpp8Wc6HfceU6uASs/foedWDrK3MN/il15M8DOO5hgaifh9Wk+BH
         C7Yx4any1onyAdEAAx663hJ+gKOFlff2FtQzu1W1+sCxHYdCpD8ghtuovRgFG5q9m889
         5apw==
X-Gm-Message-State: AFq9FYKnJLgwMlf1XyOcFfqMVbB9eCAvlAEYx+Skg7FAonxj2GBSfa2i
	iuPT/M/lKAYJoY0BNAheJI/UYWRETlGkx94CUV6j7Jq3cjAjF26sZindU7G45oES
X-Gm-Gg: AYBFou02hj1k4qLioMerwEpEzV00WWjWQ4dec98tyH3xxGHT9/Acltl1tuCGdyLDsyk
	okOWSrmweIZT34+4fMekjQNxAnsvi704FTzNkjck/x6u2W2E7Z5QAW5enE0kUVxB/JFmX1poxyM
	Kl4yjpFMrRtvkdXx/rGxdyCI1+7A7Tu8Ad7LhzVb6kiWxs/k2AreygoPKAWLO32DRDVEw+kIZ7A
	FkjtEbgSkzht9jQ23xsR1S/HX9Mlh0/kco/n7PbqvSpaACpLdPRb+0I23kXfiL88l8HrTDpKUxk
	gcUxT+3gUSabJTAw9D22MvYb0N/XzKNfBgfANW507rclmWi+vu++MK5VianFdTOgioTPpn9mg7q
	7fW+4hDdNbY7iiH0TOUkO0jZpjiGpVs+us7nMn+Qb47oPMsDtjkJ1qPnXP/YdrKad7uPdA8oD6f
	QAIeyWpEpAt/H/jbz0qDjQxYWNkrI91WKmXQRBZv/X+0DxOBSQiEEWaDMzzmYqe1LXZ/CfXjxMM
	yPIVDSXLCraKiQyM7J9UvFhx7iap9Q3l8bugeWVafaFWzdh/A==
X-Received: by 2002:a17:90b:4e8b:b0:3ab:be66:ddd3 with SMTP id 98e67ed59e1d1-3abbe66dfa9mr5676880a91.32.1791944614387;
        Tue, 13 Oct 2026 19:23:34 -0700 (PDT)
Received: from noir.tail7e608.ts.net (97-113-82-198.tukw.qwest.net. [97.113.82.198])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac6304c746sm972463a91.0.2026.10.13.19.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 19:23:33 -0700 (PDT)
From: Evan Severson <eseverson@gmail.com>
To: eseverson@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH] wifi: ath9k: track PS-Poll responses in the BlockAck window
Date: Tue, 13 Oct 2026 19:23:32 -0700
Message-ID: <20261014022332.2223387-1-eseverson@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ath_tx_setup_buffer() takes a sequence number from the TID for every
QoS data frame, but a frame only enters the BlockAck window when it
carries IEEE80211_TX_CTL_AMPDU. Since commit 592234e941f1 ("wifi:
mac80211: Fix iTXQ AMPDU fragmentation handling"), mac80211 sets that
flag only when dequeuing from a TXQ. Frames that reach ath_tx_start()
directly while a session is running, such as PS-Poll responses for a
dozing station, now use up session sequence numbers without being
tracked.

Once seq_next is more than baw_size ahead of seq_start, every frame
the TXQ hands out is outside the window. ath_tx_get_tid_subframe()
puts it back on the retry queue and returns -EINPROGRESS on every
attempt, nothing ever moves the window, and the AP stops sending
unicast data to the station until the session is torn down or the
station reassociates.

Seen on a QCA9563 AP (OpenWrt) with a station that stayed in power
save for several seconds under downlink load: the window was empty
and seq_next was about 2170 ahead of seq_start. With this change, a
90 minute run saw a run of more than 3800 such frames and no stall.

Flag unfragmented QoS data frames of an active session as A-MPDU where
the sequence number is assigned, so they are tracked like any other
session frame. Fragments stay unflagged, as mac80211 intends. A frame
from ath_tx_start() cannot wait for the window, so if it is already
outside it, send it untracked as before rather than set a bit beyond
the window.

A PS-Poll response is sent on the UAPSD queue, and ath_tx_start() held
that queue's lock while it took the TID's sequence number. The sequence
counter and the window belong to the lock of the TID's own queue, which
the TXQ path holds when it adds to or advances the window, so take that
lock for the TID work and the UAPSD queue's lock only to hand the frame
to the hardware, as ath9k_release_buffered_frames() already does.

Fixes: 592234e941f1 ("wifi: mac80211: Fix iTXQ AMPDU fragmentation handling")
Cc: stable@vger.kernel.org
Signed-off-by: Evan Severson <eseverson@gmail.com>
---

Notes:
    An alternative would be to restore IEEE80211_TX_CTL_AMPDU on
    non-fragmented PS-Poll responses in mac80211, which would also cover
    other drivers that track the BA window in software. Happy to rework it
    that way if that's preferred.

 drivers/net/wireless/ath/ath9k/xmit.c | 59 +++++++++++++++++++--------
 1 file changed, 41 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/xmit.c b/drivers/net/wireless/ath/ath9k/xmit.c
index 3413bb4906d..7af9fa7f97c 100644
--- a/drivers/net/wireless/ath/ath9k/xmit.c
+++ b/drivers/net/wireless/ath/ath9k/xmit.c
@@ -54,7 +54,7 @@ static u16 bits_per_symbol[][2] = {
 };
 
 static void ath_tx_send_normal(struct ath_softc *sc, struct ath_txq *txq,
-			       struct ath_atx_tid *tid, struct sk_buff *skb);
+			       struct sk_buff *skb);
 static void ath_tx_complete(struct ath_softc *sc, struct sk_buff *skb,
 			    int tx_flags, struct ath_txq *txq,
 			    struct ieee80211_sta *sta);
@@ -2104,20 +2104,14 @@ static void ath_tx_txqaddbuf(struct ath_softc *sc, struct ath_txq *txq,
 }
 
 static void ath_tx_send_normal(struct ath_softc *sc, struct ath_txq *txq,
-			       struct ath_atx_tid *tid, struct sk_buff *skb)
+			       struct sk_buff *skb)
 {
-	struct ieee80211_tx_info *tx_info = IEEE80211_SKB_CB(skb);
 	struct ath_frame_info *fi = get_frame_info(skb);
 	struct list_head bf_head;
 	struct ath_buf *bf = fi->bf;
 
 	INIT_LIST_HEAD(&bf_head);
 	list_add_tail(&bf->list, &bf_head);
-	bf->bf_state.bf_type = 0;
-	if (tid && (tx_info->flags & IEEE80211_TX_CTL_AMPDU)) {
-		bf->bf_state.bf_type = BUF_AMPDU;
-		ath_tx_addto_baw(tid, bf);
-	}
 
 	bf->bf_next = NULL;
 	bf->bf_lastbf = bf;
@@ -2240,6 +2234,15 @@ static struct ath_buf *ath_tx_setup_buffer(struct ath_softc *sc,
 			INCR(tid->seq_next, IEEE80211_SEQ_MAX);
 
 		bf->bf_state.seqno = seqno;
+
+		/* Frames that bypass the TXQs (e.g. PS-Poll responses) lack
+		 * IEEE80211_TX_CTL_AMPDU but still use a session sequence
+		 * number; track them in the BA window too.
+		 */
+		if (tid->active && !fragno &&
+		    !ieee80211_has_morefrags(hdr->frame_control) &&
+		    ieee80211_is_data_qos(hdr->frame_control))
+			IEEE80211_SKB_CB(skb)->flags |= IEEE80211_TX_CTL_AMPDU;
 	}
 
 	bf->bf_mpdu = skb;
@@ -2356,20 +2359,36 @@ int ath_tx_start(struct ieee80211_hw *hw, struct sk_buff *skb,
 		tid = ath_get_skb_tid(an, skb);
 	}
 
-	ath_txq_lock(sc, txq);
-	if (txq == sc->tx.txq_map[q]) {
-		fi->txq = q;
-		++txq->pending_frames;
-	}
+	/*
+	 * The TID's sequence counter and BlockAck window are protected by
+	 * the lock of the TID's own queue, which is not txq for a PS-Poll
+	 * response. As in ath9k_release_buffered_frames(), do the TID work
+	 * under that lock first and queue to the hardware under txq's lock.
+	 */
+	if (tid)
+		ath_txq_lock(sc, tid->txq);
 
 	bf = ath_tx_setup_buffer(sc, txq, tid, skb);
+	if (bf && tid && (info->flags & IEEE80211_TX_CTL_AMPDU)) {
+		if (BAW_WITHIN(tid->seq_start, tid->baw_size,
+			       bf->bf_state.seqno)) {
+			bf->bf_state.bf_type = BUF_AMPDU;
+			ath_tx_addto_baw(tid, bf);
+		} else {
+			/* Can't wait for the window; send it untracked */
+			info->flags &= ~IEEE80211_TX_CTL_AMPDU;
+		}
+	}
+
+	if (tid)
+		ath_txq_unlock(sc, tid->txq);
+
 	if (!bf) {
-		ath_txq_skb_done(sc, skb);
 		if (txctl->paprd)
 			dev_kfree_skb_any(skb);
 		else
 			ieee80211_free_txskb(sc->hw, skb);
-		goto out;
+		return 0;
 	}
 
 	bf->bf_state.bfs_paprd = txctl->paprd;
@@ -2378,9 +2397,13 @@ int ath_tx_start(struct ieee80211_hw *hw, struct sk_buff *skb,
 		bf->bf_state.bfs_paprd_timestamp = jiffies;
 
 	ath_set_rates(vif, sta, bf);
-	ath_tx_send_normal(sc, txq, tid, skb);
 
-out:
+	ath_txq_lock(sc, txq);
+	if (txq == sc->tx.txq_map[q]) {
+		fi->txq = q;
+		++txq->pending_frames;
+	}
+	ath_tx_send_normal(sc, txq, skb);
 	ath_txq_unlock(sc, txq);
 
 	return 0;
@@ -2949,7 +2972,7 @@ int ath9k_tx99_send(struct ath_softc *sc, struct sk_buff *skb,
 	ath9k_hw_set_desc_link(sc->sc_ah, bf->bf_desc, bf->bf_daddr);
 	ath9k_hw_tx99_start(sc->sc_ah, txctl->txq->axq_qnum);
 
-	ath_tx_send_normal(sc, txctl->txq, NULL, skb);
+	ath_tx_send_normal(sc, txctl->txq, skb);
 
 	return 0;
 }
-- 
2.54.0


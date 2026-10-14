Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F2B3ACA4E
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 02:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791946658; cv=none; b=GEVaYTkvvHk6lxhGBGVEH4ctb8KyqGl3L/2Uv73rr1hPCFB+gUVo8sBz1s04rQr9K0BidzlwzlOVnZAVluADux2h6f/XLQM9rLM3tv5fYnaDD7vWgyDV+6kb3Ap+JaU2xeFZ7gD9ZD/9pJWluvzYjFgM22BogGqvpEWwqdJCwMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791946658; c=relaxed/simple;
	bh=k4i6/6E6mfIk5NrCq+HVEpuhDDYq34LcZfQdvlEZ+Tc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rfrxDJGk/Ek0lr8lJD/Fnb4K9g5Gt3xXZvIVpKu4crwdY2QiwhC76h0VEkbol8i76/1c3ko6gNVUQLOVCOAJjaZcWNzu6rHJT/pc0RtcCMtMlJjvvTHb4n9j7OB+9tAnktoPLg32H5dQ/COHvbQ7Iknr98OnE/FQ1Om8S7X7hJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=miHWr/5z; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="miHWr/5z"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cbedd5aece4so2718828a12.0
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 19:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791946656; x=1792551456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Aflk477R2mLIuCy3ibHQIJkx29Vy5FeRyPLK1blRAzU=;
        b=miHWr/5zvdC5Ac2bFTQpTyyVo+SIaatV0NszyyM619YDMdvROCOaTLXh3cdcGJrMEs
         546Pz/yaNLy0gNWgZQp1aqwWFos7LTwKvPuQ28HiuR+B06ztNn7VGNM2PAE5tUuHlluk
         Qp1JWKsFFzUGilC/2LTw1ZYoh6VEr9fE/38e8hor9I+QqpWPxlm6xTP/a2utoTb0hL7t
         OSvcOrjNzLKlS/VRsCYm3MO9J0QBDO+vM9+Eyuod6SxUymgg2xJ2aY7/YiklzBtiB21G
         Ljv346eHIqFj+AJ3M3LYXLcdOuMP7AISvmgfdFs1gPwl4r6jTNv3Tge+8SeiXHbVT5oU
         gQrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791946656; x=1792551456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Aflk477R2mLIuCy3ibHQIJkx29Vy5FeRyPLK1blRAzU=;
        b=TPBvOCWan6Gl8OHU1Epfnx+CMclwd45PKkAaaFZARmOo27v9O8fMEtg5BlGbZyaPNl
         Wxezy2LaNXDZKO3s4/92g8ADreTTzmtbK7eXE/Ff2xJ4d2F5XHPtQ6yeqyAiKIjdj90O
         ZTfdq89dK0e/GCyNFv7tkhKNBRtr0riJWqv0z/NFPIquw3397zwiJ3YT9ORu4IbCfJKW
         /Fd0E4ob1M5fW7H5QNone0kvEzEWFZmEZnja+vpS804BpDhsZ8znayrF11+jYFijKVEl
         NNFmfTn+T+//wNRm0kHMBuVcEUyRag+EPb2fiJPj1ly0bchMr3e9grba3C/sJmzPsq+M
         d/DQ==
X-Forwarded-Encrypted: i=1; AKwUvBwAINcdJl1P3593z1Tnq/at3coLV9li4be/pAfXdavt290rZwTtJlYMvuiloub8d8+VGnpS4EU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLCoRbG06dU9dekEaiXIB6ZXz5XCEM7kSIyvN7TxWHS5/B+To2C
	8pE/42FiKsNpOOacHQP/v7IW98oU0szOoGlbVFVJcrJHtXrzdhwcowkzDkjAFw==
X-Gm-Gg: AYBFou2TNHSz28TeubxtNWbgwlYD6rpMNyuN8km1xqgdfL6hLRMyiYmJHbamfeRBWW9
	U5vIp6sso8hvHIAzwKm+89Tz/eWfaTzU0zuLM2iSsv0QeQL3aFpoSxv1gAO/YabJMa/2eS9Q/VA
	uK+zkTvJeTyLxOGzvgywGTFqsPwzPsPs7q2VRJ0YDjSG9I2JFjpbRNt85Y26Z28Ps4W3BR5+r6f
	PY7Tj50+Z3P4QVcWgRhTWsJ4FUIEmuQReVWVftKxa2ktaDi/oQ0J0DHHLsY4aZozuKivUFVcpLx
	UZ9n2r+qKaIfk59ouJK9fhBhTlY8tqyA7VO1hcmwHVeSSU4+hP1nR66VrJyy605Ce+uz1Hvxcnk
	LOe2Cf6omcg6X3zOJDZEk0sTzRdVN5LX+fxBXK3MAp/QZ3kNLjVF1JvMukv8d3/bP9IwopC0jN7
	oj/PBHA9/IAL0I00XJ2rHgiP23jRB/F4LB9JfWbiM/5ltpwa6vUnnEFd9fk0+q/0aJxI47bPcnI
	W+ONUnStgqrOmxxjqSzvUUEzak7xkoc4oUIqLA=
X-Received: by 2002:a17:90b:1a82:b0:3a0:d82b:237b with SMTP id 98e67ed59e1d1-3ab3ab209f3mr7397389a91.25.1791946655855;
        Tue, 13 Oct 2026 19:57:35 -0700 (PDT)
Received: from noir.tail7e608.ts.net (97-113-82-198.tukw.qwest.net. [97.113.82.198])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac604b2f7csm2060724a91.10.2026.10.13.19.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 19:57:35 -0700 (PDT)
From: Evan Severson <eseverson@gmail.com>
To: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] wifi: ath9k: track PS-Poll responses in the BlockAck window
Date: Tue, 13 Oct 2026 19:57:34 -0700
Message-ID: <20261014025734.2288693-1-eseverson@gmail.com>
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


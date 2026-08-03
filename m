Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A57434C815
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 22:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785795743; cv=none; b=PtycF7Y13GBNsa93NvDX4EAMUQl6xknqNsXBHPyOFbxNBxPtZ4D+bjJvRXj1E2z7Wdczzy70hDncG997Eo86GL3cN7y4Sfppn5/uyLfbhrVpIZs1Sd+U/hfx/X4Rwla0IxMs9y56DPdRcb9wpkTbTuiSvzGX/xYM8FB5qDnq3eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785795743; c=relaxed/simple;
	bh=sVFYWZ1XuiPfDGKWFK/5tqL6S6klCUn61832Ns2knso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dZvEG/MN/noo7RJ4PlouSnUSbtSLVTDTt5Lgk+M0CvpM6VGBnU62RSjS8O6CpiKdfWeUP4Blyi0+hwSJM3+jDQWYrELsp7naYngv1DwbAFhWx/1DYjKY3dCjNcB6G7ao1GThSDOlNuR33Wf9CIAzvzlPYIV4FFGL7zidHXvYEiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m5XTmZzZ; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5XTmZzZ"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47f6981d244so214813f8f.1
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 15:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785795737; x=1786400537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MuOCmk+tuRMcAT8nRuni6ulgAlSHsEr+xAYylNAkCZU=;
        b=m5XTmZzZxque3/iyX9eLA+46q/KbHptK7y4uxqg+DUchTStWBHnkcOjfcytGFEYbhg
         PRgbv8NZi4RKZF2XafOBoUS9zywVodEYOyhHWmHnc5xETwr8WJ+NMRSEvtgZOFyIGiM4
         2+hyxgt9ihjyM7TG/Q1ygLcjsoki/qyn7W5B+p252U9RZDC4nLV83b/Km6Me+/Vg1CsZ
         0bwdaErieH8uqopCQ6+PQMRWBGayv51UKxP0CPcd7sswy86UzeqYEKX8Fqnly7e9VQJU
         GQc6v5TM73EUi8EuW6UGSrhr5ouf5zIF42k1+NRVoOUh2Y2xWc96Bl+ju6fhYVMglH0X
         gbeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785795737; x=1786400537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MuOCmk+tuRMcAT8nRuni6ulgAlSHsEr+xAYylNAkCZU=;
        b=eMLHy7QGv5tZPjyPSnvoIHefgJjO9GKkHCyo/jvRg0OG5fGd4QcKQqSGQT8GMbhPfj
         16h/18N2mX7xHa8WLpNfGP30Dv0FydulIs+onyHKnHezi1NIme2FnlweQ6sesd77yvln
         TWzFJMJgDdDAthFSdKQBdRLwjVWJUPRtVq+nfU2nAVSYY4ICtuULnuhmLFGVQMXFQBnP
         f34xvqezf2IRIx8jWnrCLip3b2dCfVsmyr9xW3z/Q7EQGk5XtJAibpS8jjVbPrbTcboK
         YhFyfp8N7g0hF5tIP/SowTBZSLsBNVhH1CdhD6IBoZGQTiCG8tb471ocdRxkJGy/cJla
         ef/w==
X-Forwarded-Encrypted: i=1; AHgh+RqxsFdY4YmIcyzgsR8ejjDE9nn76Cj37bmvpcuuSYXObLBfTormodiXtvFkz10nPfRecEm8W2M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw08zOPbv9Bgqlwz05er0DJSRF3s1dFIaaW0E167Vww2zRopOUl
	v/4MqLG44loJucYyCb4zNGExrl9FTlMuhkd4VU6+tee1/vKoIsyxIk+q
X-Gm-Gg: AR+sD118DaEOQ86ZCbEg0sFudXWfKbsl+2CF+Y71hOmf0EUG2voIigH0fA8rQmjKTvg
	r8jVp5+NFoG4pPcSRidg4slzyevwiy5m1TvDJdt9Un4Yx7JHcoko/H5wR5WVeUZy7wWvmk+byqn
	0WV6asveXyfjiwcD+zsQvThHe3Bz1pRbaq1v1RGxeTvaMFEmO76qGgGCk/ipknyoCU3mGB4icyG
	f8Btr6JiPpRGgiVxq+xugx662ASf7bb4mb9mRUuXcCQdcwWx6a/1OclMiutCNVcnt8pQQ5g4CXK
	iDVB7O0hzENbS5HLFHxsrQzslQT9260G/Tsx8//ZVr9wLI1OYN3pLEtUly7XVSqSJd1JfIkk84I
	rEYgPxKn8CP5Pit/3icm/cThqKLPLA9lDq9+GyqcTeb5IAUwvu6BhWCOy15D9Z0aYgvonS1sWhd
	gbGBNtNaiitHfu2wSl8QVkOcMYB7MbamInMeFI9Pg3q3v/s5QvYKBLOdv0mIybq+eACYdZg3nfD
	7CFZ24PgQUobxWrp7wlRZN+RurMxf6EDC7BApi0cADLpZF3u7XzoceW7RldsZnc4xFHuXqMLUcv
	X5QY32Gh/ab0/BeQJ+8=
X-Received: by 2002:a05:600c:1d0a:b0:492:7082:92e9 with SMTP id 5b1f17b1804b1-4980c5ec794mr147276605e9.0.1785795737182;
        Mon, 03 Aug 2026 15:22:17 -0700 (PDT)
Received: from L-022584.energy.envision.com (dynamic-077-012-149-099.77.12.pool.telefonica.de. [77.12.149.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49949fc2da2sm31668145e9.3.2026.08.03.15.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 15:22:16 -0700 (PDT)
From: Xin Xie <xiexinet@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	shuah@kernel.org,
	kees@kernel.org,
	petr.wozniak@gmail.com,
	qingfang.deng@linux.dev,
	fmaurer@redhat.com,
	luka.gejak@linux.dev,
	bigeasy@linutronix.de,
	xiaoliang.yang_1@nxp.com,
	skhawaja@google.com,
	stable@vger.kernel.org,
	sdf.kernel@gmail.com,
	Xin Xie <xiexinet@gmail.com>
Subject: [PATCH net v4 2/4] net: hsr: shrink seqnr_lock to sequence counter updates
Date: Tue,  4 Aug 2026 00:22:09 +0200
Message-ID: <20260803222211.877-3-xiexinet@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260803222211.877-1-xiexinet@gmail.com>
References: <20260803222211.877-1-xiexinet@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hsr->seqnr_lock is currently held across entire hsr_forward_skb()
calls: master TX (hsr_dev_xmit()), interlink RX (hsr_handle_frame()),
and both supervision frame builders hold it while frames are built,
classified, duplicated and forwarded on every port. The only state
that actually needs the lock is the sequence counters themselves
(hsr->sequence_nr / hsr->sup_sequence_nr).

Shrink the locking to the individual counter updates:
handle_std_frame() now takes the lock around its sequence number
allocation (replacing the lockdep assertion), the master TX and
interlink RX paths drop their outer lock, and the supervision
builders release the lock right after updating their counter instead
of holding it across frame construction and forwarding.

Statistics: the outer seqnr_lock also incidentally serialized the
tx_packets/tx_bytes/tx_dropped updates in hsr_forward_skb(), which are
reachable from the concurrently callable master-TX, supervision and
interlink-RX paths. Those updates now use DEV_STATS_INC()/
DEV_STATS_ADD(), the atomic legacy-stat helpers, so narrowing the lock
does not turn them into lossy plain read-modify-writes.

Ordering: with IFF_NO_QUEUE and dev->lltx, hsr_dev_xmit() is
concurrently callable, and this change removes the old
allocation-through-forward ordering guarantee there: master-TX frames
may now be emitted out of sequence-allocation order. On the current
tree this is safe because duplicate discard tracks individual
sequence numbers in sparse bitmaps (commit aae9d6b616b5 ("hsr:
Implement more robust duplicate discard for HSR") and
commit 415e6367512b ("hsr: Implement more robust duplicate discard
for PRP")) rather than requiring monotonic arrival. Sequence numbers
remain unique and monotonically allocated per counter.

This is a latency/critical-section prerequisite for unfolding GSO
super-packets at the forward entry (not a functional prerequisite):
the segmentation work should not extend the global sequence lock's
critical section. Patch 3 depends on this change; their automatic
stable selection is limited to 7.0 and newer, where sparse-bitmap
duplicate discard accepts out-of-order arrival. Older stable branches
require an adapted backport.

History of the lock being narrowed: it was introduced by
commit 06afd2c31d33 ("hsr: Synchronize sending frames to have always
incremented outgoing seq nr.") and briefly removed by
commit b3c9e65eb227 ("net: hsr: remove seqnr_lock") in net. Merge
commit 46ae4d0a4897 ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")
reverted that removal because
commit 430d67bdcb04 ("net: hsr: Use the seqnr lock for frames
received via interlink port.") in net-next had already superseded it
by adding locking for the interlink RX path. All sequence counter
updates remain protected; only the forwarding work moves out of the
critical section.

Cc: <stable@vger.kernel.org> # 7.0.x
Signed-off-by: Xin Xie <xiexinet@gmail.com>
---
 net/hsr/hsr_device.c  | 15 ++++-----------
 net/hsr/hsr_forward.c |  9 +++++----
 net/hsr/hsr_slave.c   | 11 +----------
 3 files changed, 10 insertions(+), 25 deletions(-)

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index 5555b71ab19b..3fd1762d8916 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -232,9 +232,7 @@ static netdev_tx_t hsr_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 		skb->dev = master->dev;
 		skb_reset_mac_header(skb);
 		skb_reset_mac_len(skb);
-		spin_lock_bh(&hsr->seqnr_lock);
 		hsr_forward_skb(skb, master);
-		spin_unlock_bh(&hsr->seqnr_lock);
 	} else {
 		dev_core_stats_tx_dropped_inc(dev);
 		dev_kfree_skb_any(skb);
@@ -335,6 +333,7 @@ static void send_hsr_supervision_frame(struct hsr_port *port,
 		hsr_stag->sequence_nr = htons(hsr->sequence_nr);
 		hsr->sequence_nr++;
 	}
+	spin_unlock_bh(&hsr->seqnr_lock);
 
 	hsr_stag->tlv.HSR_TLV_type = type;
 	/* HSRv0 has 6 unused bytes after the MAC */
@@ -356,14 +355,10 @@ static void send_hsr_supervision_frame(struct hsr_port *port,
 		ether_addr_copy(hsr_sp->macaddress_A, hsr->macaddress_redbox);
 	}
 
-	if (skb_put_padto(skb, ETH_ZLEN)) {
-		spin_unlock_bh(&hsr->seqnr_lock);
+	if (skb_put_padto(skb, ETH_ZLEN))
 		return;
-	}
 
 	hsr_forward_skb(skb, port);
-	spin_unlock_bh(&hsr->seqnr_lock);
-	return;
 }
 
 static void send_prp_supervision_frame(struct hsr_port *master,
@@ -390,6 +385,7 @@ static void send_prp_supervision_frame(struct hsr_port *master,
 	spin_lock_bh(&hsr->seqnr_lock);
 	hsr_stag->sequence_nr = htons(hsr->sup_sequence_nr);
 	hsr->sup_sequence_nr++;
+	spin_unlock_bh(&hsr->seqnr_lock);
 	hsr_stag->tlv.HSR_TLV_type = PRP_TLV_LIFE_CHECK_DD;
 	hsr_stag->tlv.HSR_TLV_length = sizeof(struct hsr_sup_payload);
 
@@ -397,13 +393,10 @@ static void send_prp_supervision_frame(struct hsr_port *master,
 	hsr_sp = skb_put(skb, sizeof(struct hsr_sup_payload));
 	ether_addr_copy(hsr_sp->macaddress_A, master->dev->dev_addr);
 
-	if (skb_put_padto(skb, ETH_ZLEN)) {
-		spin_unlock_bh(&hsr->seqnr_lock);
+	if (skb_put_padto(skb, ETH_ZLEN))
 		return;
-	}
 
 	hsr_forward_skb(skb, master);
-	spin_unlock_bh(&hsr->seqnr_lock);
 }
 
 /* Announce (supervision frame) timer function
diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index 0774981a65c1..87cd72a1dc65 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -621,9 +621,10 @@ static void handle_std_frame(struct sk_buff *skb,
 	if (port->type == HSR_PT_MASTER ||
 	    port->type == HSR_PT_INTERLINK) {
 		/* Sequence nr for the master/interlink node */
-		lockdep_assert_held(&hsr->seqnr_lock);
+		spin_lock_bh(&hsr->seqnr_lock);
 		frame->sequence_nr = hsr->sequence_nr;
 		hsr->sequence_nr++;
+		spin_unlock_bh(&hsr->seqnr_lock);
 	}
 }
 
@@ -746,8 +747,8 @@ void hsr_forward_skb(struct sk_buff *skb, struct hsr_port *port)
 	 * So check and increment stats for master port only here.
 	 */
 	if (port->type == HSR_PT_MASTER || port->type == HSR_PT_INTERLINK) {
-		port->dev->stats.tx_packets++;
-		port->dev->stats.tx_bytes += skb->len;
+		DEV_STATS_INC(port->dev, tx_packets);
+		DEV_STATS_ADD(port->dev, tx_bytes, skb->len);
 	}
 
 	kfree_skb(frame.skb_hsr);
@@ -757,6 +758,6 @@ void hsr_forward_skb(struct sk_buff *skb, struct hsr_port *port)
 
 out_drop:
 	rcu_read_unlock();
-	port->dev->stats.tx_dropped++;
+	DEV_STATS_INC(port->dev, tx_dropped);
 	kfree_skb(skb);
 }
diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
index da06b21cdf51..0ca55d9323c5 100644
--- a/net/hsr/hsr_slave.c
+++ b/net/hsr/hsr_slave.c
@@ -73,16 +73,7 @@ static rx_handler_result_t hsr_handle_frame(struct sk_buff **pskb)
 	}
 	skb_reset_mac_len(skb);
 
-	/* Only the frames received over the interlink port will assign a
-	 * sequence number and require synchronisation vs other sender.
-	 */
-	if (port->type == HSR_PT_INTERLINK) {
-		spin_lock_bh(&hsr->seqnr_lock);
-		hsr_forward_skb(skb, port);
-		spin_unlock_bh(&hsr->seqnr_lock);
-	} else {
-		hsr_forward_skb(skb, port);
-	}
+	hsr_forward_skb(skb, port);
 
 finish_consume:
 	return RX_HANDLER_CONSUMED;
-- 
2.43.0


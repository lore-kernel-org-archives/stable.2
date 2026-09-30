Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3413AFCE8
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 05:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790744619; cv=none; b=cx/RmEDUlygR5vpCkniCcm4XWfTuq3gPr5v8UOLGkk2Oizug2vGYj45+sSCnfxg6f3ZLNQwENTt7Uc0a4CN54ftgCB06LRDR0K4pgEvib/8ggYb90WqBiDlvfsdyt+bFrhNRjUhp7VaiHf70QiENSltOUtlxzVkF7eM/S/wAstY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790744619; c=relaxed/simple;
	bh=3Mnwu+sXhtFGtRdUmy7tiXnD6j70etZr5mAabjbPe3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dnm6hJjeNOUavhZPB6uugua/1cZDEohXmwm5X/oZfp6bfoz7ix32uwITELMKWIud+HDstCvs/BlQjwE1xWmkuF2lOHh5nvnBllbJ8b/0YsfyP3NjJDTwzqmV5vQeQVBHUktqnQ5nr87cTG21wZVNw+RdNKamoSdaFvXbx5ffTQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZDmB4Dae; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDmB4Dae"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-33e630052ebso5573616eec.0
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 22:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790744617; x=1791349417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/Qm/coeDYCF1I+H9ShbgCFI1m/XnrbNwtw1uuQcdh38=;
        b=ZDmB4DaeViwm3BleGBjxPolZJmi7PuvETR/peqDAcFddepfOws+79mP5Z9O0JMr14r
         DOYm8XkMBDQ17+FQjQJZuaRla3cdisHAmhWzC9K0C/uinXidxUKIjYBEA33Fsp6D3JqU
         AxF2XmCv5GLoWTj79Gfvr3PeS2GpKwpdbqfXXQ4K0f5gRtw+Tbyn33wGApxp7sJb7i+M
         9wZn9OK1oREKxquGLU1b9V8p6OiLbiXljunTCai7hY94yjHl6Z0/KC0jMletg3rjOQ9w
         NOPPtcAvrOwr+udumEcigUmgvOWJ6P0DzOywi4V2+KZb/kaq4QHm0ECE7ROUS9PLFsPY
         1idg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790744617; x=1791349417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/Qm/coeDYCF1I+H9ShbgCFI1m/XnrbNwtw1uuQcdh38=;
        b=LhJnvMoCsGtzckFNqEd2WWBjVFiPcCt324pNtYxC6I14UYujXbZ/f8Mh9AjCouhJH/
         GKM/L/P+BlsjrftJmwXGgNarwmRay+j4/rBTHxyCXClStwUQgyEr/7+nR/e6IzZoiJ6c
         cSRNPDNsUxjefO0heHiaVS1mR/jK5DotG7PPIAP37+odagia8WgFeZrlemNC9b8vmC1R
         kXkTWnIZhC0Zlb+uUBFm+Np2724HebrItQu3I+lZZ8FuYKWdUECexMId9T806ISLc2+T
         QUPKKmgBd++4HCxC+dK3gxMq8ttk/eT/U/oMF3tZeqDRBplVypRTLGKhR6dRGiIpeJFF
         02QQ==
X-Forwarded-Encrypted: i=1; AKwUvBzv9qFCmu+huxD6GFzYyjpF2PUqEj4AKbV0O81qsIFnbog5i11KLPnFQWbFTTQ8mfUWNULar/c=@vger.kernel.org
X-Gm-Message-State: AFq9FYKWz6BTYO6sGHrlGLxsBBe1CB/FVWmJMaZIuR8KyjexGBgTV90t
	m2ktSrK/NmgPu5ZP55BQR7pwA1wVkOalN+OQqW9jcgMpdaZk79xpp9/8
X-Gm-Gg: AYBFou0lwnSc7CTQbxBtp+Y9FYZQFPIa4iFtCUkC6r9rH/gf+RAAtGmbSoLYmQjwcq8
	m2FGdiaazrha+fPsLv8oAM8JfYJg+F97JcuybbgA8CS+MawYovxu7XtvjsYkiwpY9FDQWzsZcuF
	SBYGVXoNANMklVTUS9ksWGa2sTPnaQ0C5HeQ/2p05NVkjzTPr4vlGz7oqjWOc0amnh481DfgRgO
	kSPtE22NDRq4ONHzRxCqr+JZkGo1qZSaMWNTXP5zeMzqlK2nnZJvCkLgnd5UcdYXc8jmga0Y8s4
	kGCoR6UI/dyMWk6HgpW4bcBmKs6AtI5/BCNCdOQ3k0kFnBzuBK9pWM3zFKigXY8qwYvfhpyk0/0
	N3axv1Y8EnSmfcgQI9kcYNb2iOgpo9U6tlBnQApNcBVgH8lBEbeW/RBgG7nziZbM/7mYiJz+wt4
	NwtP1G9exB3y1KHkm3WQjYKsJZ//WjwDyJgKWcQDL/zPIYiLQp8SeK6DAonvi/Uw==
X-Received: by 2002:a05:7300:d210:b0:33b:db21:9877 with SMTP id 5a478bee46e88-34cdbbd12camr563634eec.20.1790744616850;
        Tue, 29 Sep 2026 22:03:36 -0700 (PDT)
Received: from fox.. ([43.242.224.196])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34cf4a63ac9sm772160eec.10.2026.09.29.22.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 22:03:35 -0700 (PDT)
From: Roshan Kumar <roshaen09@gmail.com>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	chopps@labn.net,
	linux-kernel@vger.kernel.org,
	lilly@aronleigh.au,
	shubham@octane.security,
	gio@octane.security,
	robert@octane.security,
	paolo@octane.security,
	Roshan Kumar <roshaen09@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v3 2/2] xfrm: iptfs: hold a device reference while packets are queued
Date: Wed, 30 Sep 2026 10:33:07 +0530
Message-ID: <20260930050307.1978654-3-roshaen09@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260930050307.1978654-1-roshaen09@gmail.com>
References: <20260930050307.1978654-1-roshaen09@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IP-TFS can retain received skbs after the input call that owns their
skb->dev reference returns. Out-of-order outer packets are stored in the
reorder window, and an incomplete inner packet is kept for reassembly.
Unregistering the ingress device while either skb is queued leaves a stale
device pointer for later timer or receive-path processing.

Take a device reference when an skb enters the reorder window or becomes
the in-progress reassembly packet. Transfer ownership of that reference
with the skb when the reorder window releases it, and put it only after
ordered processing has finished. In particular, keep the reassembly
reference through xfrm_input(), which reads skb->dev. Release references
on all completion, timeout, abort, and state-destruction paths.

An in-order packet also takes this reference before drop_lock is released,
even when it was never stored in the window, because device unregistration
can race with its subsequent ordered processing. Freelist entries are freed
within the input call and do not own a reference.

A KASAN kernel reproduces the stale access by queuing an out-of-order
packet through a TUN device, closing the device, and allowing the drop
timer to process the packet. With unprivileged user namespaces enabled,
an unprivileged process can create the required TUN and XFRM state in a
private user and network namespace and trigger the same KASAN report.

Reported-by: Shubham Antil <shubham@octane.security>
Link: https://lore.kernel.org/netdev/20260921084743.817859-1-roshaen09@gmail.com/
Reported-by: Giovanni Vignone <gio@octane.security>
Link: https://lore.kernel.org/netdev/20260921084743.817859-1-roshaen09@gmail.com/
Reported-by: Robert van Eijk <robert@octane.security>
Link: https://lore.kernel.org/netdev/20260921084743.817859-1-roshaen09@gmail.com/
Reported-by: Paolo Gentry <paolo@octane.security>
Link: https://lore.kernel.org/netdev/20260921084743.817859-1-roshaen09@gmail.com/
Link: https://lore.kernel.org/netdev/179023970333.2160803.2776986020964028023@kernel.org/
Fixes: 6c82d2433671 ("xfrm: iptfs: add basic receive packet (tunnel egress) handling")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Roshan Kumar <roshaen09@gmail.com>
---
 net/xfrm/xfrm_iptfs.c | 70 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 56 insertions(+), 14 deletions(-)

diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index e538cc98e257..954d28e7ec2e 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -730,10 +730,16 @@ static void iptfs_reset_drop_timer(struct xfrm_iptfs_data *xtfs)
 
 static void __iptfs_reassem_done(struct xfrm_iptfs_data *xtfs, bool free)
 {
+	struct sk_buff *skb = xtfs->ra_newskb;
+
 	assert_spin_locked(&xtfs->drop_lock);
 
-	if (free)
-		kfree_skb(xtfs->ra_newskb);
+	if (free && skb) {
+		struct net_device *dev = skb->dev;
+
+		kfree_skb(skb);
+		netdev_put(dev, NULL);
+	}
 	xtfs->ra_newskb = NULL;
 	xtfs->ra_drop_time = 0;
 	iptfs_reset_drop_timer(xtfs);
@@ -751,10 +757,15 @@ static void iptfs_reassem_abort(struct xfrm_iptfs_data *xtfs)
 /**
  * iptfs_reassem_done() - In-progress packet is complete, clear the state.
  * @xtfs: xtfs state
+ *
+ * Return: device with the reassembly reference still held.
  */
-static void iptfs_reassem_done(struct xfrm_iptfs_data *xtfs)
+static struct net_device *iptfs_reassem_done(struct xfrm_iptfs_data *xtfs)
 {
+	struct net_device *dev = xtfs->ra_newskb->dev;
+
 	__iptfs_reassem_done(xtfs, false);
+	return dev;
 }
 
 /**
@@ -766,6 +777,7 @@ static void iptfs_reassem_done(struct xfrm_iptfs_data *xtfs)
  * @data: offset into sequential packet data
  * @blkoff: packet blkoff value
  * @list: list of skbs to enqueue completed packet on
+ * @dev_to_put: device reference to release after processing @list
  *
  * Process an IPTFS payload that has a non-zero `blkoff` or when we are
  * expecting the continuation b/c we have a runt or in-progress packet.
@@ -774,7 +786,8 @@ static void iptfs_reassem_done(struct xfrm_iptfs_data *xtfs)
  */
 static u32 iptfs_reassem_cont(struct xfrm_iptfs_data *xtfs, u64 seq,
 			      struct skb_seq_state *st, struct sk_buff *skb,
-			      u32 data, u32 blkoff, struct list_head *list)
+			      u32 data, u32 blkoff, struct list_head *list,
+			      struct net_device **dev_to_put)
 {
 	struct iptfs_skb_frag_walk _fragwalk;
 	struct iptfs_skb_frag_walk *fragwalk = NULL;
@@ -870,6 +883,7 @@ static u32 iptfs_reassem_cont(struct xfrm_iptfs_data *xtfs, u64 seq,
 			goto abandon;
 		}
 		xtfs->ra_newskb = newskb;
+		netdev_hold(newskb->dev, NULL, GFP_ATOMIC);
 		xtfs->ra_drop_time = ktime_get_raw_fast_ns() +
 				     xtfs->drop_time_ns;
 		iptfs_reset_drop_timer(xtfs);
@@ -957,7 +971,7 @@ static u32 iptfs_reassem_cont(struct xfrm_iptfs_data *xtfs, u64 seq,
 		xtfs->ra_wantseq++;
 	} else {
 		/* We are done with packet reassembly! */
-		iptfs_reassem_done(xtfs);
+		*dev_to_put = iptfs_reassem_done(xtfs);
 		iptfs_complete_inner_skb(xtfs->x, newskb);
 		list_add_tail(&newskb->list, list);
 	}
@@ -1189,6 +1203,7 @@ static bool __input_process_payload(struct xfrm_state *x, u32 data,
 			spin_lock(&xtfs->drop_lock);
 
 			xtfs->ra_newskb = skb;
+			netdev_hold(skb->dev, NULL, GFP_ATOMIC);
 			xtfs->ra_wantseq = seq + 1;
 			xtfs->ra_drop_time = ktime_get_raw_fast_ns() +
 					     xtfs->drop_time_ns;
@@ -1250,6 +1265,7 @@ static bool __input_process_payload(struct xfrm_state *x, u32 data,
  */
 static void iptfs_input_ordered(struct xfrm_state *x, struct sk_buff *skb)
 {
+	struct net_device *dev_to_put = NULL;
 	struct ip_iptfs_cc_hdr iptcch;
 	struct skb_seq_state skbseq;
 	struct list_head sublist; /* rename this it's just a list */
@@ -1311,7 +1327,8 @@ static void iptfs_input_ordered(struct xfrm_state *x, struct sk_buff *skb)
 		/* check again after lock */
 		if (blkoff || xtfs->ra_runtlen || xtfs->ra_newskb) {
 			data = iptfs_reassem_cont(xtfs, seq, &skbseq, skb, data,
-						  blkoff, &sublist);
+						  blkoff, &sublist,
+						  &dev_to_put);
 		}
 
 		spin_unlock(&xtfs->drop_lock);
@@ -1325,6 +1342,8 @@ static void iptfs_input_ordered(struct xfrm_state *x, struct sk_buff *skb)
 		skb_abort_seq_read(&skbseq);
 		kfree_skb(skb);
 	}
+	if (dev_to_put)
+		netdev_put(dev_to_put, NULL);
 }
 
 /* ------------------------------- */
@@ -1490,6 +1509,7 @@ static void __reorder_future_fits(struct xfrm_iptfs_data *xtfs,
 	}
 
 	xtfs->w_saved[index].skb = inskb;
+	netdev_hold(inskb->dev, NULL, GFP_ATOMIC);
 	xtfs->w_savedlen = max(savedlen, index + 1);
 	iptfs_set_window_drop_times(xtfs, index);
 }
@@ -1625,6 +1645,7 @@ static void __reorder_future_shifts(struct xfrm_iptfs_data *xtfs,
 	/* We've shifted. plug the packet in at the end. */
 	xtfs->w_savedlen = nslots - 1;
 	xtfs->w_saved[xtfs->w_savedlen - 1].skb = inskb;
+	netdev_hold(inskb->dev, NULL, GFP_ATOMIC);
 	iptfs_set_window_drop_times(xtfs, xtfs->w_savedlen - 1);
 
 	/* if we don't have a slot0 then we must wait for it */
@@ -1638,7 +1659,8 @@ static void __reorder_future_shifts(struct xfrm_iptfs_data *xtfs,
 }
 
 /* Receive a new packet into the reorder window. Return a list of ordered
- * packets from the window.
+ * packets from the window. Packets on @list or in w_saved own a device
+ * reference; packets on @freelist do not.
  */
 static void iptfs_input_reorder(struct xfrm_iptfs_data *xtfs,
 				struct sk_buff *inskb, struct list_head *list,
@@ -1656,14 +1678,16 @@ static void iptfs_input_reorder(struct xfrm_iptfs_data *xtfs,
 	}
 	wantseq = xtfs->w_wantseq;
 
-	if (likely(inseq == wantseq))
+	if (likely(inseq == wantseq)) {
+		netdev_hold(inskb->dev, NULL, GFP_ATOMIC);
 		__reorder_this(xtfs, inskb, list);
-	else if (inseq < wantseq)
+	} else if (inseq < wantseq) {
 		__reorder_past(xtfs, inskb, freelist);
-	else if ((inseq - wantseq) < nslots)
+	} else if ((inseq - wantseq) < nslots) {
 		__reorder_future_fits(xtfs, inskb, freelist);
-	else
+	} else {
 		__reorder_future_shifts(xtfs, inskb, list);
+	}
 }
 
 /**
@@ -1721,13 +1745,20 @@ static enum hrtimer_restart iptfs_drop_timer(struct hrtimer *me)
 
 	spin_unlock(&xtfs->drop_lock);
 
-	if (skb)
+	if (skb) {
+		struct net_device *dev = skb->dev;
+
 		kfree_skb_reason(skb, SKB_DROP_REASON_FRAG_REASM_TIMEOUT);
+		netdev_put(dev, NULL);
+	}
 
 	if (count) {
 		list_for_each_entry_safe(skb, next, &list, list) {
+			struct net_device *dev = skb->dev;
+
 			skb_list_del_init(skb);
 			iptfs_input_ordered(x, skb);
+			netdev_put(dev, NULL);
 		}
 	}
 
@@ -1767,8 +1798,11 @@ static int iptfs_input(struct xfrm_state *x, struct sk_buff *skb)
 	spin_unlock(&xtfs->drop_lock);
 
 	list_for_each_entry_safe(skb, next, &list, list) {
+		struct net_device *dev = skb->dev;
+
 		skb_list_del_init(skb);
 		iptfs_input_ordered(x, skb);
+		netdev_put(dev, NULL);
 	}
 
 	list_for_each_entry_safe(skb, next, &freelist, list) {
@@ -2774,12 +2808,20 @@ static void iptfs_destroy_state(struct xfrm_state *x)
 
 	hrtimer_cancel(&xtfs->drop_timer);
 
-	if (xtfs->ra_newskb)
+	if (xtfs->ra_newskb) {
+		struct net_device *dev = xtfs->ra_newskb->dev;
+
 		kfree_skb(xtfs->ra_newskb);
+		netdev_put(dev, NULL);
+	}
 
 	for (s = xtfs->w_saved, se = s + xtfs->w_savedlen; s < se; s++) {
-		if (s->skb)
+		if (s->skb) {
+			struct net_device *dev = s->skb->dev;
+
 			kfree_skb(s->skb);
+			netdev_put(dev, NULL);
+		}
 	}
 
 	kfree_sensitive(xtfs->w_saved);
-- 
2.43.0


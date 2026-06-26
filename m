Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A5B3FADFD
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 16:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490311; cv=none; b=ZJd2gAv0Mwd8QKBFt8Ld5Ac5Uou978fjxSSlG+KklXtK7o4mMBeAaduT7Um9GdjpFjhKG/k69xkXu9RqSJ7Tmyec1IO/tlAryBkLEhSioTS+FfXTtAOplTQC2kRtVH7xLI/F3QBqc7GIhM2B1WIOVbICxtf1VzWVcrQBxQlVhms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490311; c=relaxed/simple;
	bh=vu9l/F8dC+0iXN3OWKe4Kgl7AaPelABUsRfl5Rk0VDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sjiatgQncexAnHAAQvohl8k2x6bI309lQMukDMsgzZOoJsdkpxpjcYqgFsJXmnPuScpe5MgnFiD0hRyWJevMKGBRAvDPQwUIIukE49mdBwBdUx6NnTkV0+ZvUNMULiHCOH/sOTRf+vjhX4jEOjZLmgjHJHV8LBpMgYmbitWtsxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=d0pu5Iwk; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="d0pu5Iwk"
Received: by dvalin.narfation.org (Postfix) id 47A022045E;
	Fri, 26 Jun 2026 16:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782490308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vwe60rpPjQjPk/CXNGQGgTiKOg+R5nPoUSPuzrDfqq8=;
	b=d0pu5IwkmubVCbtItFca7cHUqGrAwVlKMZ6Pl/mX2Q2krhIeKyZQbBTuQTJyeWceumFDSA
	IYHf8xUweBbp9k9z7dMAQDQfr+CwtGXKI95JT3+C+QPXn/SYGaj2epI1vDDk7phMLkeilq
	XOtn94AXgbirX5QKHfAqcLJWLZjLXGM=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 6.6 19/25] batman-adv: tp_meter: prevent parallel modifications of last_recv
Date: Fri, 26 Jun 2026 18:11:33 +0200
Message-ID: <20260626161139.124425-20-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626161139.124425-1-sven@narfation.org>
References: <20260626161139.124425-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 6dde0cfcb36e4d5b3de35b75696937478441eed4 upstream.

When last_recv is updated to store the last receive sequence number, it is
assuming that nothing is modifying in parallel while:

* check for outdated packets is done
* out of order check is performed (and packets are stored in out-of-order
  queue)
* the out-of-order queue was searched for closed gaps
* sequence number for next ack is calculated

Nothing of that was actually protected. It could therefore happen that the
last_recv was updated multiple times in parallel and the final sequence
number was calculated with deltas which had no connection to the sequence
number they were added to.

Lock this whole region with the same lock which was already used to protect
the unacked (out-of-order) list.

Cc: stable@kernel.org
Fixes: 33a3bb4a3345 ("batman-adv: throughput meter implementation")
[ Switch to pre-splitted tp_vars structure names ]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/tp_meter.c | 22 +++++++++++++---------
 net/batman-adv/types.h    |  2 +-
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index b882919a868ca..f745bc09a0496 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -1294,6 +1294,7 @@ static int batadv_tp_send_ack(struct batadv_priv *bat_priv, const u8 *dst,
  */
 static bool batadv_tp_handle_out_of_order(struct batadv_tp_vars *tp_vars,
 					  const struct sk_buff *skb)
+	__must_hold(&tp_vars->unacked_lock)
 {
 	const struct batadv_icmp_tp_packet *icmp;
 	struct batadv_tp_unacked *un, *new;
@@ -1310,12 +1311,11 @@ static bool batadv_tp_handle_out_of_order(struct batadv_tp_vars *tp_vars,
 	payload_len = skb->len - sizeof(struct batadv_unicast_packet);
 	new->len = payload_len;
 
-	spin_lock_bh(&tp_vars->unacked_lock);
 	/* if the list is empty immediately attach this new object */
 	if (list_empty(&tp_vars->unacked_list)) {
 		list_add(&new->list, &tp_vars->unacked_list);
 		tp_vars->unacked_count++;
-		goto out;
+		return true;
 	}
 
 	/* otherwise loop over the list and either drop the packet because this
@@ -1364,9 +1364,6 @@ static bool batadv_tp_handle_out_of_order(struct batadv_tp_vars *tp_vars,
 		tp_vars->unacked_count--;
 	}
 
-out:
-	spin_unlock_bh(&tp_vars->unacked_lock);
-
 	return true;
 }
 
@@ -1376,6 +1373,7 @@ static bool batadv_tp_handle_out_of_order(struct batadv_tp_vars *tp_vars,
  * @tp_vars: the private data of the current TP meter session
  */
 static void batadv_tp_ack_unordered(struct batadv_tp_vars *tp_vars)
+	__must_hold(&tp_vars->unacked_lock)
 {
 	struct batadv_tp_unacked *un, *safe;
 	u32 to_ack;
@@ -1383,7 +1381,6 @@ static void batadv_tp_ack_unordered(struct batadv_tp_vars *tp_vars)
 	/* go through the unacked packet list and possibly ACK them as
 	 * well
 	 */
-	spin_lock_bh(&tp_vars->unacked_lock);
 	list_for_each_entry_safe(un, safe, &tp_vars->unacked_list, list) {
 		/* the list is ordered, therefore it is possible to stop as soon
 		 * there is a gap between the last acked seqno and the seqno of
@@ -1401,7 +1398,6 @@ static void batadv_tp_ack_unordered(struct batadv_tp_vars *tp_vars)
 		kfree(un);
 		tp_vars->unacked_count--;
 	}
-	spin_unlock_bh(&tp_vars->unacked_lock);
 }
 
 /**
@@ -1481,6 +1477,7 @@ static void batadv_tp_recv_msg(struct batadv_priv *bat_priv,
 	const struct batadv_icmp_tp_packet *icmp;
 	struct batadv_tp_vars *tp_vars;
 	size_t packet_size;
+	u32 to_ack;
 	u32 seqno;
 
 	icmp = (struct batadv_icmp_tp_packet *)skb->data;
@@ -1509,6 +1506,8 @@ static void batadv_tp_recv_msg(struct batadv_priv *bat_priv,
 		WRITE_ONCE(tp_vars->last_recv_time, jiffies);
 	}
 
+	spin_lock_bh(&tp_vars->unacked_lock);
+
 	/* if the packet is a duplicate, it may be the case that an ACK has been
 	 * lost. Resend the ACK
 	 */
@@ -1520,8 +1519,10 @@ static void batadv_tp_recv_msg(struct batadv_priv *bat_priv,
 		/* exit immediately (and do not send any ACK) if the packet has
 		 * not been enqueued correctly
 		 */
-		if (!batadv_tp_handle_out_of_order(tp_vars, skb))
+		if (!batadv_tp_handle_out_of_order(tp_vars, skb)) {
+			spin_unlock_bh(&tp_vars->unacked_lock);
 			goto out;
+		}
 
 		/* send a duplicate ACK */
 		goto send_ack;
@@ -1535,11 +1536,14 @@ static void batadv_tp_recv_msg(struct batadv_priv *bat_priv,
 	batadv_tp_ack_unordered(tp_vars);
 
 send_ack:
+	to_ack = tp_vars->last_recv;
+	spin_unlock_bh(&tp_vars->unacked_lock);
+
 	/* send the ACK. If the received packet was out of order, the ACK that
 	 * is going to be sent is a duplicate (the sender will count them and
 	 * possibly enter Fast Retransmit as soon as it has reached 3)
 	 */
-	batadv_tp_send_ack(bat_priv, icmp->orig, tp_vars->last_recv,
+	batadv_tp_send_ack(bat_priv, icmp->orig, to_ack,
 			   icmp->timestamp, icmp->session, icmp->uid);
 out:
 	batadv_tp_vars_put(tp_vars);
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 7c32947414cd8..883da8acae738 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1491,7 +1491,7 @@ struct batadv_tp_vars {
 	/** @unacked_list: list of unacked packets (meta-info only) */
 	struct list_head unacked_list;
 
-	/** @unacked_lock: protect unacked_list */
+	/** @unacked_lock: protect unacked_list + &batadv_tp_receiver.last_recv */
 	spinlock_t unacked_lock;
 
 	/** @unacked_count: number of unacked entries */
-- 
2.47.3


Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A94403B07
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 16:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490376; cv=none; b=HeEHLUShgnJkPVWxgo5rLPKlTfkA2uPDdnweKlR5oxKxfdG7KYlrvh2PC0IZcFDbX32SlXBiiivEJax+w5oIUkwzXfBLOeScBwuUzMv4UuI7SIuxjMGzzwQ6UwlSWDbeAqjig9TdHn308no/YJbfZ2l/5GYDZsoEGnCxksr0jJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490376; c=relaxed/simple;
	bh=juraor4giI4vuGhAVOdnZ7pvTwWBZm/elXrN40QhnRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KjSEbeVWNe0ZSeW18ylu16VWY8Gv12oMHxSWYOgFFGLI000KsUxncWJ5/s+fzjANTSg84+mMQ9Oe0Fe1JmOenaFH0MLGqfNKXp0von4g4Ms43lRgfOLNQVfKYZM7ZesjoseurprY+4OatDxNA0PUyQZD7FGiQZLEcKHq93ePl48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=0Moa7s4X; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="0Moa7s4X"
Received: by dvalin.narfation.org (Postfix) id C86FB20541;
	Fri, 26 Jun 2026 16:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782490370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=di13vFRlRPcNm2avBfav9/47qx8NOqK3KMexpSXCuA0=;
	b=0Moa7s4XiiutxnK3FmTNdZL02vSysLd6LkTQ/Y0L8IzgkI1bPJRniRZMcertGmt7uT557B
	4GxDxoK3PAlHgK0xWlCDvvGZMM+9x109nsL8Oc9U/oSFle8ST4hBCKAQYeAOKOQ7uwKnlm
	oo/iO0DQ6Kf+j67Jp4yiBfK/CQ8VjOY=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 7.1 18/26] batman-adv: tp_meter: restrict number of unacked list entries
Date: Fri, 26 Jun 2026 18:12:33 +0200
Message-ID: <20260626161241.124988-19-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626161241.124988-1-sven@narfation.org>
References: <20260626161241.124988-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit e7c775110e1858e5a7471a23a9c9658c0af9df89 upstream.

When the unacked_list is unbound, an attacker could send messages with
small lengths and appropriated seqno + gaps to force the receiver to
allocate more and more unacked_list entries. And the end either causing an
out-of-memory situation or increase the management overhead for the (large)
list that significant portions of CPU cycles are wasted in searching
through the list.

When limiting the list to a specific number, it is important to still
correctly add a new entry to the list. But if the list became larger than
the limit, the last entry of the list (with the highest seqno) must be
dropped to still allow the earlier seqnos to finish and therefore to
continue the process. Otherwise, the process might get stuck with too high
seqnos which are not handled by batadv_tp_ack_unordered().

Cc: stable@kernel.org
Fixes: 33a3bb4a3345 ("batman-adv: throughput meter implementation")
[ Switch to pre-splitted tp_vars structure names ]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/tp_meter.c | 23 ++++++++++++++++++++++-
 net/batman-adv/types.h    |  3 +++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 397b945635356..4f8af909893ab 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -87,6 +87,11 @@
 #define BATADV_TP_PLEN (BATADV_TP_PACKET_LEN - ETH_HLEN - \
 			sizeof(struct batadv_unicast_packet))
 
+/**
+ * BATADV_TP_MAX_UNACKED - maximum number of packets a receiver didn't yet ack
+ */
+#define BATADV_TP_MAX_UNACKED 100
+
 static u8 batadv_tp_prerandom[4096] __read_mostly;
 
 /**
@@ -1195,6 +1200,7 @@ static void batadv_tp_receiver_shutdown(struct timer_list *t)
 	list_for_each_entry_safe(un, safe, &tp_vars->unacked_list, list) {
 		list_del(&un->list);
 		kfree(un);
+		tp_vars->unacked_count--;
 	}
 	spin_unlock_bh(&tp_vars->unacked_lock);
 
@@ -1308,6 +1314,7 @@ static bool batadv_tp_handle_out_of_order(struct batadv_tp_vars *tp_vars,
 	/* if the list is empty immediately attach this new object */
 	if (list_empty(&tp_vars->unacked_list)) {
 		list_add(&new->list, &tp_vars->unacked_list);
+		tp_vars->unacked_count++;
 		goto out;
 	}
 
@@ -1338,12 +1345,24 @@ static bool batadv_tp_handle_out_of_order(struct batadv_tp_vars *tp_vars,
 		 */
 		list_add(&new->list, &un->list);
 		added = true;
+		tp_vars->unacked_count++;
 		break;
 	}
 
 	/* received packet with smallest seqno out of order; add it to front */
-	if (!added)
+	if (!added) {
 		list_add(&new->list, &tp_vars->unacked_list);
+		tp_vars->unacked_count++;
+	}
+
+	/* remove the last (biggest) unacked seqno when list is too large */
+	if (tp_vars->unacked_count > BATADV_TP_MAX_UNACKED) {
+		un = list_last_entry(&tp_vars->unacked_list,
+				     struct batadv_tp_unacked, list);
+		list_del(&un->list);
+		kfree(un);
+		tp_vars->unacked_count--;
+	}
 
 out:
 	spin_unlock_bh(&tp_vars->unacked_lock);
@@ -1380,6 +1399,7 @@ static void batadv_tp_ack_unordered(struct batadv_tp_vars *tp_vars)
 
 		list_del(&un->list);
 		kfree(un);
+		tp_vars->unacked_count--;
 	}
 	spin_unlock_bh(&tp_vars->unacked_lock);
 }
@@ -1430,6 +1450,7 @@ batadv_tp_init_recv(struct batadv_priv *bat_priv,
 
 	spin_lock_init(&tp_vars->unacked_lock);
 	INIT_LIST_HEAD(&tp_vars->unacked_list);
+	tp_vars->unacked_count = 0;
 
 	kref_get(&tp_vars->refcount);
 	timer_setup(&tp_vars->timer, batadv_tp_receiver_shutdown, 0);
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 765ba71fe8c69..4f9f1820e3a92 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1426,6 +1426,9 @@ struct batadv_tp_vars {
 	/** @unacked_lock: protect unacked_list */
 	spinlock_t unacked_lock;
 
+	/** @unacked_count: number of unacked entries */
+	size_t unacked_count;
+
 	/** @last_recv_time: time (jiffies) a msg was received */
 	unsigned long last_recv_time;
 
-- 
2.47.3


Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714273FF1B8
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 16:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490339; cv=none; b=irKteRw/L79I+CV1M/A0XHh/tPg7HU9QPBZeBslYQg9yn+1OpfsiDBdKozU1GYpwbeKzaiJl7sb8Ms7rzuXPiKHS869CWAiVVjfUafauSKDhn2qkKedSt/nm+XQEKV5E7bI1RQfa1IwtBJXUQfgIEyv3SgzyrA+1kTzvFpeubtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490339; c=relaxed/simple;
	bh=xCUTKS/F8sLQ8bs4qfr3rDsSM4SChJOTmMScZoaV9aI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=INhWQqOWUNcqgZtlDPdT2sv+/oCJqPYrbECDQP45TQEJEtHTlpW37hnkjUnZkC2o3ocLsJLlXPJs++qJLlvUCsc7nwC8ENhK5hZa6IZEFlLUwR/P3dwXY0I4g0H/xaOeXndnN+HfoGtz+KNL5mixB9XJCIXidZaGrj31UEF0KSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=zQWtWOEc; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="zQWtWOEc"
Received: by dvalin.narfation.org (Postfix) id 7971020535;
	Fri, 26 Jun 2026 16:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782490334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s3zuOF7cwQ2nHEqRWPNKPfj0Odh5Qm6m2UKbfcz8jPc=;
	b=zQWtWOEcctu0NkknbyfQTKVwffqLKE8FvKfcSExECzNTP2FIbyhudlqqI3RQNuY+w/VNND
	PrNFQXay8D3hVmvqrNW9zrlLr00/0RQ7lkTDi5nYzRP7Suk1LRxrHBMQCn1LHhxvt1AvFO
	7HZnJMmqJphyg0NbY8biPQfFUL5ZZkQ=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 6.18 08/26] batman-adv: tp_meter: add only finished tp_vars to lists
Date: Fri, 26 Jun 2026 18:11:52 +0200
Message-ID: <20260626161210.124712-9-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626161210.124712-1-sven@narfation.org>
References: <20260626161210.124712-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 15ccbf685222274f5add1387af58c2a41a95f81e upstream.

When the receiver variables (aka "session") are initialized, then they are
added to the list of sessions before the timer is set up. A RCU protected
reader could therefore find the entry and run mod_setup before
batadv_tp_init_recv() finished the timer initialization.

The same is true for batadv_tp_start(), which must first initialize the
finish_work and the test_length to avoid a similar problem.

Cc: stable@kernel.org
Fixes: 33a3bb4a3345 ("batman-adv: throughput meter implementation")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/tp_meter.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 0ebfc4462b8f1..0444aa46b95c2 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -1096,21 +1096,21 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 	tp_vars->prerandom_offset = 0;
 	spin_lock_init(&tp_vars->prerandom_lock);
 
-	kref_get(&tp_vars->refcount);
-	hlist_add_head_rcu(&tp_vars->list, &bat_priv->tp_list);
-	spin_unlock_bh(&bat_priv->tp_list_lock);
-
 	tp_vars->test_length = test_length;
 	if (!tp_vars->test_length)
 		tp_vars->test_length = BATADV_TP_DEF_TEST_LENGTH;
 
+	/* init work item for finished tp tests */
+	INIT_DELAYED_WORK(&tp_vars->finish_work, batadv_tp_sender_finish);
+
+	kref_get(&tp_vars->refcount);
+	hlist_add_head_rcu(&tp_vars->list, &bat_priv->tp_list);
+	spin_unlock_bh(&bat_priv->tp_list_lock);
+
 	batadv_dbg(BATADV_DBG_TP_METER, bat_priv,
 		   "Meter: starting throughput meter towards %pM (length=%ums)\n",
 		   dst, test_length);
 
-	/* init work item for finished tp tests */
-	INIT_DELAYED_WORK(&tp_vars->finish_work, batadv_tp_sender_finish);
-
 	/* start tp kthread. This way the write() call issued from userspace can
 	 * happily return and avoid to block
 	 */
@@ -1430,10 +1430,10 @@ batadv_tp_init_recv(struct batadv_priv *bat_priv,
 	INIT_LIST_HEAD(&tp_vars->unacked_list);
 
 	kref_get(&tp_vars->refcount);
-	hlist_add_head_rcu(&tp_vars->list, &bat_priv->tp_list);
+	timer_setup(&tp_vars->timer, batadv_tp_receiver_shutdown, 0);
 
 	kref_get(&tp_vars->refcount);
-	timer_setup(&tp_vars->timer, batadv_tp_receiver_shutdown, 0);
+	hlist_add_head_rcu(&tp_vars->list, &bat_priv->tp_list);
 
 	batadv_tp_reset_receiver_timer(tp_vars);
 
-- 
2.47.3


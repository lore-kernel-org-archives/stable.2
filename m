Received: from sender-op-o17.zoho.eu (sender-op-o17.zoho.eu [136.143.169.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCA647043D;
	Wed, 22 Jul 2026 10:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784715403; cv=pass; b=tnRdV+0J4D2epF1NyagTmVgdlNhM/iFTQkv1c5U6yhpBiJzfTiPBE7WEjKVYv0U9EVMJbwg9Ir7rh9q0t8G9UgwgS73UL5J1O2Q5E94XQMQnG6YIKyEcbtVbk8wZx4h6LaCRnc4tJ1pXjEkRwH4NZLp+btyorKErfGZNaS2WRDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784715403; c=relaxed/simple;
	bh=yex1mJd/ERybZlo3clQpmxfMFCjnG0UtBmfZ5Sunt4o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=boAwks4KxhUye/VzGWDcw/uT8C74Tv27FgzwynBEiR1pvKPQ8y7Akf67+uqp3RrvJAtuvpbXDoLFs1XN6/YqdIbZItia+8wQPSE+rebhFzD1i/Xd036xomUI+GqUAoiBCg5tQ2QWsPvLgxbxjwVpBHB7hlEPVL32ki38Ys73DkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=auditcode.ai; spf=pass smtp.mailfrom=auditcode.ai; dkim=pass (1024-bit key) header.d=auditcode.ai header.i=security@auditcode.ai header.b=pIiTsw8t; arc=pass smtp.client-ip=136.143.169.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=auditcode.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auditcode.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=auditcode.ai header.i=security@auditcode.ai header.b="pIiTsw8t"
ARC-Seal: i=1; a=rsa-sha256; t=1784715373; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=WIS/wT/kK7IgMUD2SSX6PUE9vzUeT+a/QCz8sRxsirHCfbZ4M05mgpFQxCDZ8hPYL48lOC/umvjgmBbxpVF2vlWffArrcteBxYIsk5Wj6PK0gdjL3RdcITiWWsYsNSxrpd1GOzRooaucgOxxw84X+SS3G3h0E2jun3ln77QH924=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1784715373; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=C4lOxytgR0KsOyq/Jp7BHXLZa/gFViZEf2t1LUgKwts=; 
	b=fH2Eq3UHchQdb/3vkVOoI09OV1ox6ITHTpsSkRVKPwbRI/8eapXFOA1I82EWtnJSgxAqjeuLU5quJ+d0Ixnu+nyPwQJF78kCr89EK0uTjMOxDyj9dUfMy2aZGYxveGZfRKYxvclG4a7EGyHkXbRpYrNUm5uPYDMm7LoFrFUdlv4=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=auditcode.ai;
	spf=pass  smtp.mailfrom=security@auditcode.ai;
	dmarc=pass header.from=<security@auditcode.ai>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784715373;
	s=zmail; d=auditcode.ai; i=security@auditcode.ai;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=C4lOxytgR0KsOyq/Jp7BHXLZa/gFViZEf2t1LUgKwts=;
	b=pIiTsw8tTO3olnPxPzhcjZmbTP49KA9VwEEgJvetQ6WwcSUkUSIL6YyED7XyIRIz
	ZX/ypoJgqs2sBOGHRPNu6QNs27eyBCbSVeVbYtyvS7HzpI+g4T57TxAlBiY3FdNmFt7
	SEMc23+49r3ijbttV9HA9opK7kaMl32oIP7fY//Q=
Received: by mx.zoho.eu with SMTPS id 1784715371230952.2475580867131;
	Wed, 22 Jul 2026 12:16:11 +0200 (CEST)
From: Ibrahim Hashimov <security@auditcode.ai>
To: alex.aring@gmail.com,
	stefan@datenfreihafen.org,
	miquel.raynal@bootlin.com
Cc: horms@kernel.org,
	kuba@kernel.org,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2] mac802154: lock rx_mac_cmd_list and drain it before freeing sdata
Date: Wed, 22 Jul 2026 12:16:08 +0200
Message-ID: <20260722101608.37744-1-security@auditcode.ai>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

rx_mac_cmd_list has no locking. The RX softirq producer in
ieee802154_subif_frame() list_add_tail()s while the mac_wq worker
list_del()s, and the worker dereferences mac_pkt->sdata with no
liveness check.

Removing an interface (or the phy) thus frees its sdata while a queued
packet still points at it, and a later worker run reads freed memory: a
KASAN use-after-free, reproduced by flooding a victim interface with MAC
command frames and deleting it. Meanwhile sibling interfaces on the same
phy keep adding to the list, corrupting it.

Add rx_mac_cmd_lock around every access -- producer, worker (which now
dequeues under the lock and processes the packet after) and the new
mac802154_flush_queued_mac_cmds(). Drain the queue before the sdata is
freed: from ieee802154_if_remove() after the RCU grace period (filtered
to that sdata) and from ieee802154_unregister_hw(). The drain precedes
cancel_work_sync() so a run that already dequeued a matching packet is
waited out while its sdata is still alive.

Fixes: d021d218f6d9 ("mac802154: Handle received BEACON_REQ")
Cc: stable@vger.kernel.org
Signed-off-by: Ibrahim Hashimov <security@auditcode.ai>
Assisted-by: AuditCode-AI:2026.07
---
v2: v1 only added mac802154_flush_queued_mac_cmds() guarded by
    cancel_work_sync(), which cannot fix a race whose corrupting party is
    the lockless softirq producer (not a work item), as the review of v1
    pointed out. Add rx_mac_cmd_lock around every list access and drain
    before cancel_work_sync(). rx_beacon_list has the same lockless
    pattern, but its worker never dereferences sdata, so it is left as a
    separate follow-up to keep this fix minimal.

diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index 8f2bff268392..b497b5abab0a 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -74,6 +74,10 @@ struct ieee802154_local {
 	struct work_struct rx_beacon_work;
 	struct list_head rx_mac_cmd_list;
 	struct work_struct rx_mac_cmd_work;
+	/* protects rx_mac_cmd_list against the RX softirq producer, the
+	 * mac_wq worker and the teardown flush running concurrently
+	 */
+	spinlock_t rx_mac_cmd_lock;
 
 	/* Association */
 	struct ieee802154_pan_device *assoc_dev;
@@ -300,6 +304,8 @@ static inline bool mac802154_is_beaconing(struct ieee802154_local *local)
 }
 
 void mac802154_rx_mac_cmd_worker(struct work_struct *work);
+void mac802154_flush_queued_mac_cmds(struct ieee802154_local *local,
+				     struct ieee802154_sub_if_data *sdata);
 
 int mac802154_perform_association(struct ieee802154_sub_if_data *sdata,
 				  struct ieee802154_pan_device *coord,
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index b823720630e7..82c86f253b5d 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -694,6 +694,13 @@ void ieee802154_if_remove(struct ieee802154_sub_if_data *sdata)
 	mutex_unlock(&sdata->local->iflist_mtx);
 
 	synchronize_rcu();
+
+	/* After the grace period no new rx_mac_cmd_list entry can point at
+	 * @sdata; drop the ones already queued before it is freed below, as
+	 * the mac_wq worker derefs mac_pkt->sdata with no liveness check.
+	 */
+	mac802154_flush_queued_mac_cmds(sdata->local, sdata);
+
 	unregister_netdevice(sdata->dev);
 }
 
diff --git a/net/mac802154/main.c b/net/mac802154/main.c
index ea1efef3572a..24d1e398d3d9 100644
--- a/net/mac802154/main.c
+++ b/net/mac802154/main.c
@@ -91,6 +91,7 @@ ieee802154_alloc_hw(size_t priv_data_len, const struct ieee802154_ops *ops)
 	INIT_LIST_HEAD(&local->interfaces);
 	INIT_LIST_HEAD(&local->rx_beacon_list);
 	INIT_LIST_HEAD(&local->rx_mac_cmd_list);
+	spin_lock_init(&local->rx_mac_cmd_lock);
 	mutex_init(&local->iflist_mtx);
 
 	tasklet_setup(&local->tasklet, ieee802154_tasklet_handler);
@@ -277,6 +278,12 @@ void ieee802154_unregister_hw(struct ieee802154_hw *hw)
 	tasklet_kill(&local->tasklet);
 	flush_workqueue(local->workqueue);
 
+	/* Drain rx_mac_cmd_list before ieee802154_remove_interfaces()
+	 * frees every sdata: the mac_wq worker derefs mac_pkt->sdata and
+	 * is not covered by the flush above (that is the data workqueue).
+	 */
+	mac802154_flush_queued_mac_cmds(local, NULL);
+
 	rtnl_lock();
 
 	ieee802154_remove_interfaces(local);
diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
index cd8f2a11920d..c869c1c0c65f 100644
--- a/net/mac802154/rx.c
+++ b/net/mac802154/rx.c
@@ -76,8 +76,12 @@ void mac802154_rx_mac_cmd_worker(struct work_struct *work)
 	u8 mac_cmd;
 	int rc;
 
+	spin_lock_bh(&local->rx_mac_cmd_lock);
 	mac_pkt = list_first_entry_or_null(&local->rx_mac_cmd_list,
 					   struct cfg802154_mac_pkt, node);
+	if (mac_pkt)
+		list_del(&mac_pkt->node);
+	spin_unlock_bh(&local->rx_mac_cmd_lock);
 	if (!mac_pkt)
 		return;
 
@@ -123,11 +127,48 @@ void mac802154_rx_mac_cmd_worker(struct work_struct *work)
 	}
 
 out:
-	list_del(&mac_pkt->node);
 	kfree_skb(mac_pkt->skb);
 	kfree(mac_pkt);
 }
 
+/**
+ * mac802154_flush_queued_mac_cmds - drop pending rx_mac_cmd_list work
+ * @local: the mac802154 device the queue belongs to
+ * @sdata: interface being torn down, or %NULL to flush unconditionally
+ *
+ * Each queued &struct cfg802154_mac_pkt stashes a raw pointer to the
+ * interface it was received on, which mac802154_rx_mac_cmd_worker() later
+ * dereferences without checking whether that interface is still alive.
+ * Callers must invoke this before freeing @sdata (or before freeing every
+ * interface, when @sdata is %NULL) so the worker never runs against freed
+ * memory. The list is drained under rx_mac_cmd_lock, then cancel_work_sync()
+ * waits out a run that already dequeued a matching packet before the drain.
+ */
+void mac802154_flush_queued_mac_cmds(struct ieee802154_local *local,
+				     struct ieee802154_sub_if_data *sdata)
+{
+	struct cfg802154_mac_pkt *mac_pkt, *tmp;
+
+	spin_lock_bh(&local->rx_mac_cmd_lock);
+	list_for_each_entry_safe(mac_pkt, tmp, &local->rx_mac_cmd_list, node) {
+		if (sdata && mac_pkt->sdata != sdata)
+			continue;
+
+		list_del(&mac_pkt->node);
+		kfree_skb(mac_pkt->skb);
+		kfree(mac_pkt);
+	}
+	spin_unlock_bh(&local->rx_mac_cmd_lock);
+
+	cancel_work_sync(&local->rx_mac_cmd_work);
+
+	/* Other interfaces on @local may still have entries pending. */
+	spin_lock_bh(&local->rx_mac_cmd_lock);
+	if (!list_empty(&local->rx_mac_cmd_list))
+		queue_work(local->mac_wq, &local->rx_mac_cmd_work);
+	spin_unlock_bh(&local->rx_mac_cmd_lock);
+}
+
 static int
 ieee802154_subif_frame(struct ieee802154_sub_if_data *sdata,
 		       struct sk_buff *skb, const struct ieee802154_hdr *hdr)
@@ -233,7 +274,11 @@ ieee802154_subif_frame(struct ieee802154_sub_if_data *sdata,
 
 		mac_pkt->skb = skb_get(skb);
 		mac_pkt->sdata = sdata;
+
+		spin_lock(&sdata->local->rx_mac_cmd_lock);
 		list_add_tail(&mac_pkt->node, &sdata->local->rx_mac_cmd_list);
+		spin_unlock(&sdata->local->rx_mac_cmd_lock);
+
 		queue_work(sdata->local->mac_wq, &sdata->local->rx_mac_cmd_work);
 		return NET_RX_SUCCESS;
 
-- 
2.50.1 (Apple Git-155)

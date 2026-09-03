Received: from mta0.migadu.com (out-81.mta0.migadu.com [91.218.175.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3DF4A49A4
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 12:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788438769; cv=none; b=Ct9O9fkA57caS+EZCZS0XqV9Wrl/iIaPB1xno3+V8cPOoIKv+zHGqgLl/M9UVK830zWsov/FNKngsFuCNlmzhAyAEukXJpCLaVkY3Q/zOnh6Qn/DGXcSWgJBSTeRyGNJLyncHmSV8SqlMVtvade18rzOrs/RErhCR7Er8b2HPzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788438769; c=relaxed/simple;
	bh=ixQKr71X/Ud/HwrSzOrIph9nLjmLhV+az2lfLYT3OYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uhYHfbaoouSx3OtdDsr49Ozz0whp0fPC4eASdM50lvj02rCGt42+3bBZG1KLXngvB/kdNAnRYOipe8haMZuRYVwlbOATNXCLqZLT/WAVFUqiKhvA2JaaLVjDUMog1sik6XlvYdQt2LGw4b5zj1/T8rwiIi07hUAAZ1cL4L/iv1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=e74GLdYc; arc=none smtp.client-ip=91.218.175.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="e74GLdYc"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ixQKr71X/Ud/HwrSzOrIph9nLjmLhV+az2lfLYT3OYY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788438764; v=1; x=1789043564;
 b=e74GLdYcQ/bH09UBOcB/qiGqXCb87Ar/pUoInA109CvyJ8FiDa9lNljSHvIQbZUiGpRA15Sv
 rea3WW2GfsgcsYxpnRtyNFc8ddh2lgV6jSzkhYEr+hbXCLwC8yUXkh9wDK6fGUgshIT98GT7E+e
 3dE0t3GPNzsgLQ7UVE9EP7T0=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b4d47bdebe95483d;
	Thu, 03 Sep 2026 12:32:44 +0000
X-Mizu-Trace-ID: b4d47bdebe95483d
X-Migadu-Flow: FLOW_OUT
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
To: linux-wpan@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alex.aring@gmail.com,
	stefan@datenfreihafen.org,
	miquel.raynal@bootlin.com,
	david.girault@qorvo.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	stable@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: [PATCH net v2 1/2] mac802154: serialize and drain queued RX descriptors
Date: Thu,  3 Sep 2026 20:32:01 +0800
Message-ID: <20260903123202.60152-2-xuanqiang.luo@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903123202.60152-1-xuanqiang.luo@linux.dev>
References: <20260903123202.60152-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

queue_work() coalesces attempts to queue an already pending work item.
The RX workers, however, consume only one descriptor per invocation. A
burst can therefore leave later descriptors queued until another frame
arrives, while the final descriptor may remain queued indefinitely.

The RX tasklet, workers, and scan cleanup also access the descriptor
lists without synchronization.

Protect both lists with a spinlock. Publish each descriptor and queue its
work while holding the lock. Remove each descriptor from the list before
processing it and, if another descriptor remains, queue the work again so
it runs after the current invocation.

Fixes: 57588c71177f ("mac802154: Handle passive scanning")
Fixes: d021d218f6d9 ("mac802154: Handle received BEACON_REQ")
Cc: stable@vger.kernel.org
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 net/mac802154/ieee802154_i.h |  2 ++
 net/mac802154/main.c         |  1 +
 net/mac802154/rx.c           | 32 ++++++++++++++++++++++++++------
 net/mac802154/scan.c         |  7 ++++++-
 4 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index 8f2bff268392b..096e6f0340dc7 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -74,6 +74,8 @@ struct ieee802154_local {
 	struct work_struct rx_beacon_work;
 	struct list_head rx_mac_cmd_list;
 	struct work_struct rx_mac_cmd_work;
+	/* Protects rx_beacon_list and rx_mac_cmd_list. */
+	spinlock_t rx_lists_lock;
 
 	/* Association */
 	struct ieee802154_pan_device *assoc_dev;
diff --git a/net/mac802154/main.c b/net/mac802154/main.c
index ea1efef3572ae..a6a976b0dea56 100644
--- a/net/mac802154/main.c
+++ b/net/mac802154/main.c
@@ -91,6 +91,7 @@ ieee802154_alloc_hw(size_t priv_data_len, const struct ieee802154_ops *ops)
 	INIT_LIST_HEAD(&local->interfaces);
 	INIT_LIST_HEAD(&local->rx_beacon_list);
 	INIT_LIST_HEAD(&local->rx_mac_cmd_list);
+	spin_lock_init(&local->rx_lists_lock);
 	mutex_init(&local->iflist_mtx);
 
 	tasklet_setup(&local->tasklet, ieee802154_tasklet_handler);
diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
index cd8f2a11920d0..26da20ea470ef 100644
--- a/net/mac802154/rx.c
+++ b/net/mac802154/rx.c
@@ -29,20 +29,38 @@ static int ieee802154_deliver_skb(struct sk_buff *skb)
 	return netif_receive_skb(skb);
 }
 
+static struct cfg802154_mac_pkt *
+mac802154_rx_dequeue(struct ieee802154_local *local,
+		     struct list_head *rx_list,
+		     struct work_struct *work)
+{
+	struct cfg802154_mac_pkt *mac_pkt;
+
+	spin_lock_bh(&local->rx_lists_lock);
+	mac_pkt = list_first_entry_or_null(rx_list,
+					   struct cfg802154_mac_pkt, node);
+	if (mac_pkt) {
+		list_del(&mac_pkt->node);
+		if (!list_empty(rx_list))
+			queue_work(local->mac_wq, work);
+	}
+	spin_unlock_bh(&local->rx_lists_lock);
+
+	return mac_pkt;
+}
+
 void mac802154_rx_beacon_worker(struct work_struct *work)
 {
 	struct ieee802154_local *local =
 		container_of(work, struct ieee802154_local, rx_beacon_work);
 	struct cfg802154_mac_pkt *mac_pkt;
 
-	mac_pkt = list_first_entry_or_null(&local->rx_beacon_list,
-					   struct cfg802154_mac_pkt, node);
+	mac_pkt = mac802154_rx_dequeue(local, &local->rx_beacon_list, work);
 	if (!mac_pkt)
 		return;
 
 	mac802154_process_beacon(local, mac_pkt->skb, mac_pkt->page, mac_pkt->channel);
 
-	list_del(&mac_pkt->node);
 	kfree_skb(mac_pkt->skb);
 	kfree(mac_pkt);
 }
@@ -76,8 +94,7 @@ void mac802154_rx_mac_cmd_worker(struct work_struct *work)
 	u8 mac_cmd;
 	int rc;
 
-	mac_pkt = list_first_entry_or_null(&local->rx_mac_cmd_list,
-					   struct cfg802154_mac_pkt, node);
+	mac_pkt = mac802154_rx_dequeue(local, &local->rx_mac_cmd_list, work);
 	if (!mac_pkt)
 		return;
 
@@ -123,7 +140,6 @@ void mac802154_rx_mac_cmd_worker(struct work_struct *work)
 	}
 
 out:
-	list_del(&mac_pkt->node);
 	kfree_skb(mac_pkt->skb);
 	kfree(mac_pkt);
 }
@@ -221,8 +237,10 @@ ieee802154_subif_frame(struct ieee802154_sub_if_data *sdata,
 		mac_pkt->sdata = sdata;
 		mac_pkt->page = sdata->local->scan_page;
 		mac_pkt->channel = sdata->local->scan_channel;
+		spin_lock_bh(&sdata->local->rx_lists_lock);
 		list_add_tail(&mac_pkt->node, &sdata->local->rx_beacon_list);
 		queue_work(sdata->local->mac_wq, &sdata->local->rx_beacon_work);
+		spin_unlock_bh(&sdata->local->rx_lists_lock);
 		return NET_RX_SUCCESS;
 
 	case IEEE802154_FC_TYPE_MAC_CMD:
@@ -233,8 +251,10 @@ ieee802154_subif_frame(struct ieee802154_sub_if_data *sdata,
 
 		mac_pkt->skb = skb_get(skb);
 		mac_pkt->sdata = sdata;
+		spin_lock_bh(&sdata->local->rx_lists_lock);
 		list_add_tail(&mac_pkt->node, &sdata->local->rx_mac_cmd_list);
 		queue_work(sdata->local->mac_wq, &sdata->local->rx_mac_cmd_work);
+		spin_unlock_bh(&sdata->local->rx_lists_lock);
 		return NET_RX_SUCCESS;
 
 	case IEEE802154_FC_TYPE_ACK:
diff --git a/net/mac802154/scan.c b/net/mac802154/scan.c
index 005338f89b75e..5fa98e001a8fb 100644
--- a/net/mac802154/scan.c
+++ b/net/mac802154/scan.c
@@ -105,8 +105,13 @@ static unsigned int mac802154_scan_get_channel_time(u8 duration_order,
 static void mac802154_flush_queued_beacons(struct ieee802154_local *local)
 {
 	struct cfg802154_mac_pkt *mac_pkt, *tmp;
+	LIST_HEAD(mac_pkt_list);
 
-	list_for_each_entry_safe(mac_pkt, tmp, &local->rx_beacon_list, node) {
+	spin_lock_bh(&local->rx_lists_lock);
+	list_splice_init(&local->rx_beacon_list, &mac_pkt_list);
+	spin_unlock_bh(&local->rx_lists_lock);
+
+	list_for_each_entry_safe(mac_pkt, tmp, &mac_pkt_list, node) {
 		list_del(&mac_pkt->node);
 		kfree_skb(mac_pkt->skb);
 		kfree(mac_pkt);
-- 
2.43.0


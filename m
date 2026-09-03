Received: from mta0.migadu.com (out-90.mta0.migadu.com [91.218.175.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62ABD4A4851
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 12:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788438780; cv=none; b=GcfbSegpq9VeKgTnRXMR5EDqwuDQBZEVHQdVKRGBBpvcjacDMwlkaRSGnkwNe3WwkDU5g0aWlrLrGctesxNeTislZFx1NGiGX0a8k9lp65Tue/VWVNxKCjSderKzph1/XRp+Z+HNRV5P0yf7uXj4WISDOJPp2b1TIFLG0JYT8K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788438780; c=relaxed/simple;
	bh=1iB/o8bZw94ZM1/04pVnXdKi6vlIvmj3KTplXfVEHY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ry+wEsU9R/PGBOk1h8rGc8BiRbkk/+BHQCHvvNd7zyU0Sjr+WOTN47iXxsfi7ExOhf+zbX14IVaPy+lZNmPzGCZdUOJmVwswF515CQT6b6TGawLUfXhmhKrx5fMEC4m9U5gSEVJMDvk/gr0gjg0XSi6Ad3kNF+CVRc8ki4Zisd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GnYSQNz2; arc=none smtp.client-ip=91.218.175.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GnYSQNz2"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=1iB/o8bZw94ZM1/04pVnXdKi6vlIvmj3KTplXfVEHY8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788438776; v=1; x=1789043576;
 b=GnYSQNz2fQBdKHJRcFxw5U1sEWVwiixC9V32gjo1LlJ39ZAIcQFXVzRgftKIsynpkzKV6N/M
 ITToR34WvDqIdtrTWGvq+VxycuVNQ3H9JVMXPUSr4UglO/hPfoIxtGoq4WrX06opasVv2AvlOmq
 IWlhfn8x7wBYqX59ROL+2Iio=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 88afac023ae83057;
	Thu, 03 Sep 2026 12:32:56 +0000
X-Mizu-Trace-ID: 88afac023ae83057
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
Subject: [PATCH net v2 2/2] mac802154: pin netdevs for queued RX descriptors
Date: Thu,  3 Sep 2026 20:32:02 +0800
Message-ID: <20260903123202.60152-3-xuanqiang.luo@linux.dev>
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

The RX path keeps the receiving sub-interface in queued beacon and MAC
command descriptors after leaving its RCU read-side critical section. An
interface can therefore be unregistered and freed before mac_wq consumes
the descriptor, leading to a use-after-free such as:

  BUG: KASAN: slab-use-after-free in mac802154_rx_mac_cmd_worker+0xc0/0x498 [mac802154]
  Read of size 8 at addr ffff0000c6db0ba8 by task kworker/u16:3/61
  ...
  Call trace:
   show_stack+0x20/0x38 (C)
   dump_stack_lvl+0x78/0x90
   print_address_description.constprop.0+0x88/0x398
   print_report+0xa8/0x278
   kasan_report+0xa8/0xf8
   __asan_load8+0x9c/0xc0
   mac802154_rx_mac_cmd_worker+0xc0/0x498 [mac802154]
   process_one_work+0x334/0x8b8
  ...
  Allocated by task 630:
   kasan_save_stack+0x2c/0x58
   kasan_save_track+0x20/0x40
   kasan_save_alloc_info+0x40/0x58
   __kasan_kmalloc+0xa0/0xb8
   __kvmalloc_node_noprof+0x1e8/0x588
   alloc_netdev_mqs+0x74/0x7f0
   ieee802154_if_add+0xac/0x630 [mac802154]
   ieee802154_register_hw+0x31c/0x3d0 [mac802154]
   fakelb_add_one+0x250/0x318 [fakelb]
  ...
  Freed by task 652:
   kasan_save_stack+0x2c/0x58
   kasan_save_track+0x20/0x40
   kasan_save_free_info+0x4c/0x78
   __kasan_slab_free+0x60/0x90
   kfree+0x194/0x478
   kvfree+0x44/0x60
   netdev_release+0x4c/0x68
   device_release+0xac/0x130
   kobject_cleanup+0x84/0x248
   kobject_put+0x98/0xf8
   netdev_run_todo+0x3a0/0x5e0
   rtnl_unlock+0x18/0x30
   ieee802154_unregister_hw+0x48/0x90 [mac802154]
   fakelb_remove+0xe8/0x148 [fakelb]

Hold the receiving netdev from before a descriptor is queued until the
descriptor is released. Since sdata is the netdev's private data, this also
keeps sdata valid while a worker or scan cleanup accesses the descriptor.

Fixes: 57588c71177f ("mac802154: Handle passive scanning")
Fixes: d021d218f6d9 ("mac802154: Handle received BEACON_REQ")
Cc: stable@vger.kernel.org
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 include/net/cfg802154.h | 2 ++
 net/mac802154/rx.c      | 4 ++++
 net/mac802154/scan.c    | 1 +
 3 files changed, 7 insertions(+)

diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
index 76d2cd2e2b309..57343762d7f0b 100644
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -369,6 +369,7 @@ struct cfg802154_beacon_request {
  * @node: MAC packets to process list member
  * @skb: the received sk_buff
  * @sdata: the interface on which @skb was received
+ * @dev_tracker: netdev reference held until the descriptor is released
  * @page: page configuration when @skb was received
  * @channel: channel configuration when @skb was received
  */
@@ -376,6 +377,7 @@ struct cfg802154_mac_pkt {
 	struct list_head node;
 	struct sk_buff *skb;
 	struct ieee802154_sub_if_data *sdata;
+	netdevice_tracker dev_tracker;
 	u8 page;
 	u8 channel;
 };
diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
index 26da20ea470ef..df2f6128ddd4a 100644
--- a/net/mac802154/rx.c
+++ b/net/mac802154/rx.c
@@ -62,6 +62,7 @@ void mac802154_rx_beacon_worker(struct work_struct *work)
 	mac802154_process_beacon(local, mac_pkt->skb, mac_pkt->page, mac_pkt->channel);
 
 	kfree_skb(mac_pkt->skb);
+	netdev_put(mac_pkt->sdata->dev, &mac_pkt->dev_tracker);
 	kfree(mac_pkt);
 }
 
@@ -141,6 +142,7 @@ void mac802154_rx_mac_cmd_worker(struct work_struct *work)
 
 out:
 	kfree_skb(mac_pkt->skb);
+	netdev_put(mac_pkt->sdata->dev, &mac_pkt->dev_tracker);
 	kfree(mac_pkt);
 }
 
@@ -237,6 +239,7 @@ ieee802154_subif_frame(struct ieee802154_sub_if_data *sdata,
 		mac_pkt->sdata = sdata;
 		mac_pkt->page = sdata->local->scan_page;
 		mac_pkt->channel = sdata->local->scan_channel;
+		netdev_hold(sdata->dev, &mac_pkt->dev_tracker, GFP_ATOMIC);
 		spin_lock_bh(&sdata->local->rx_lists_lock);
 		list_add_tail(&mac_pkt->node, &sdata->local->rx_beacon_list);
 		queue_work(sdata->local->mac_wq, &sdata->local->rx_beacon_work);
@@ -251,6 +254,7 @@ ieee802154_subif_frame(struct ieee802154_sub_if_data *sdata,
 
 		mac_pkt->skb = skb_get(skb);
 		mac_pkt->sdata = sdata;
+		netdev_hold(sdata->dev, &mac_pkt->dev_tracker, GFP_ATOMIC);
 		spin_lock_bh(&sdata->local->rx_lists_lock);
 		list_add_tail(&mac_pkt->node, &sdata->local->rx_mac_cmd_list);
 		queue_work(sdata->local->mac_wq, &sdata->local->rx_mac_cmd_work);
diff --git a/net/mac802154/scan.c b/net/mac802154/scan.c
index 5fa98e001a8fb..c3c61ebde1568 100644
--- a/net/mac802154/scan.c
+++ b/net/mac802154/scan.c
@@ -114,6 +114,7 @@ static void mac802154_flush_queued_beacons(struct ieee802154_local *local)
 	list_for_each_entry_safe(mac_pkt, tmp, &mac_pkt_list, node) {
 		list_del(&mac_pkt->node);
 		kfree_skb(mac_pkt->skb);
+		netdev_put(mac_pkt->sdata->dev, &mac_pkt->dev_tracker);
 		kfree(mac_pkt);
 	}
 }
-- 
2.43.0

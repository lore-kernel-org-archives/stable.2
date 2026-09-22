Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C46639183A
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 14:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790088943; cv=none; b=u09/CbzHKbVewKQoHYWyUM0xWYQjuQs0qEGXkxtc+4lKOO3ufVoquLzdKE12ZjSE14lqId+yda+e2UW+vfHMkoSmCPW3FtZJ6j3/3l/1uoPRCqkcw1A68aygqlkqpSJb62ulGTq4XwIfExTp5/WuKWnxYP2NUDc21gyNWzZU2CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790088943; c=relaxed/simple;
	bh=UUQMgiq8HVp9/lLlTJQsjmUWC+U0KM4wl9IYc3ZpcPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kj6fZY0m7YUYr7/AZJ3u7Lbj83noZzCpH+IKaDycz5ScTnHvyG46q9IlLbzT3n01e4bzg8Xu6g+MQdMP+DFKi3xkbrmRb+wehHPvSnElHM4BVEOx0kvhKTCUwUC0tgc3d+QVz9zfq8A3ai1xpaioe6KywwLF8Trrw5xcUiCoPTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/w3pWZI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/w3pWZI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 870981F000FF;
	Tue, 22 Sep 2026 14:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790088941;
	bh=z7n9NiFKDCCZn3KaM8vSTb8SkuwwruK0HsNNFH+LA+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z/w3pWZIWRDGmWNdEwDYWJS600s936QL6FBx+P65iV3uNB0JD6hTP4zNUGP+RgijT
	 WAv8YvuO8FhX8gbeooCKPylboN/3So9q7eyZW5TyO+yLw6Hr2j1QIrTzAOX+JM/uCs
	 awgsy0SZR+gCHSjRGunhcQ4ZMf81zroD5Saeg3KJtPwUH5+0r6HY7XxdVk8+9SplNO
	 6RBvQgCdYLY+4zONoO1GKY1jUVMhC2+Ogqpr7JyOrMl3x2ec7wFQi2vY5vs2UQLPQ6
	 lHDRszcsU4gKNMMCzRiXyNe975rAT6VC68wB3DEaY8afkqWFv0MjTG03605JqOBnKn
	 WEgzJOwXyEiVA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jinjian Song <jinjian.song@fibocom.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] net: wwan: t7xx: Fix napi rx poll issue
Date: Tue, 22 Sep 2026 10:55:37 -0400
Message-ID: <20260922145538.2711877-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092215-sincere-shack-66e6@gregkh>
References: <2026092215-sincere-shack-66e6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jinjian Song <jinjian.song@fibocom.com>

[ Upstream commit 905fe0845bb27e4eed2ca27ea06e6c4847f1b2b1 ]

When driver handles the napi rx polling requests, the netdev might
have been released by the dellink logic triggered by the disconnect
operation on user plane. However, in the logic of processing skb in
polling, an invalid netdev is still being used, which causes a panic.

BUG: kernel NULL pointer dereference, address: 00000000000000f1
Oops: 0000 [#1] PREEMPT SMP NOPTI
RIP: 0010:dev_gro_receive+0x3a/0x620
[...]
Call Trace:
 <IRQ>
 ? __die_body+0x68/0xb0
 ? page_fault_oops+0x379/0x3e0
 ? exc_page_fault+0x4f/0xa0
 ? asm_exc_page_fault+0x22/0x30
 ? __pfx_t7xx_ccmni_recv_skb+0x10/0x10 [mtk_t7xx (HASH:1400 7)]
 ? dev_gro_receive+0x3a/0x620
 napi_gro_receive+0xad/0x170
 t7xx_ccmni_recv_skb+0x48/0x70 [mtk_t7xx (HASH:1400 7)]
 t7xx_dpmaif_napi_rx_poll+0x590/0x800 [mtk_t7xx (HASH:1400 7)]
 net_rx_action+0x103/0x470
 irq_exit_rcu+0x13a/0x310
 sysvec_apic_timer_interrupt+0x56/0x90
 </IRQ>

Fixes: 5545b7b9f294 ("net: wwan: t7xx: Add NAPI support")
Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
Link: https://patch.msgid.link/20250530031648.5592-1-jinjian.song@fibocom.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Backport to 6.1: the receive callback still takes struct t7xx_pci_dev
and delivers packets through netif_rx(), without the upstream NAPI
conversion. Keep that callback interface and add a local ccmni_ctlb
pointer so the READ_ONCE() lookup uses the upstream expression. Retain
the other pointer publication, removal, and notification changes.

This also preserves the receive-side context needed to apply
c7ead9704249 ("net: wwan: t7xx: validate the netif index in
t7xx_ccmni_recv_skb()") unchanged. No new functions are introduced.

Stable-dep-of: c7ead9704249 ("net: wwan: t7xx: validate the netif index in t7xx_ccmni_recv_skb()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wwan/t7xx/t7xx_netdev.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wwan/t7xx/t7xx_netdev.c b/drivers/net/wwan/t7xx/t7xx_netdev.c
index f71d3bc3b237c..c5d974a935903 100644
--- a/drivers/net/wwan/t7xx/t7xx_netdev.c
+++ b/drivers/net/wwan/t7xx/t7xx_netdev.c
@@ -205,7 +205,7 @@ static int t7xx_ccmni_wwan_newlink(void *ctxt, struct net_device *dev, u32 if_id
 	ccmni->ctlb = ctlb;
 	ccmni->dev = dev;
 	atomic_set(&ccmni->usage, 0);
-	ctlb->ccmni_inst[if_id] = ccmni;
+	WRITE_ONCE(ctlb->ccmni_inst[if_id], ccmni);
 
 	ret = register_netdevice(dev);
 	if (ret)
@@ -227,6 +227,7 @@ static void t7xx_ccmni_wwan_dellink(void *ctxt, struct net_device *dev, struct l
 	if (WARN_ON(ctlb->ccmni_inst[if_id] != ccmni))
 		return;
 
+	WRITE_ONCE(ctlb->ccmni_inst[if_id], NULL);
 	unregister_netdevice(dev);
 }
 
@@ -313,6 +314,7 @@ static void init_md_status_notifier(struct t7xx_pci_dev *t7xx_dev)
 
 static void t7xx_ccmni_recv_skb(struct t7xx_pci_dev *t7xx_dev, struct sk_buff *skb)
 {
+	struct t7xx_ccmni_ctrl *ccmni_ctlb = t7xx_dev->ccmni_ctlb;
 	struct t7xx_skb_cb *skb_cb;
 	struct net_device *net_dev;
 	struct t7xx_ccmni *ccmni;
@@ -321,7 +323,7 @@ static void t7xx_ccmni_recv_skb(struct t7xx_pci_dev *t7xx_dev, struct sk_buff *s
 
 	skb_cb = T7XX_SKB_CB(skb);
 	netif_id = skb_cb->netif_idx;
-	ccmni = t7xx_dev->ccmni_ctlb->ccmni_inst[netif_id];
+	ccmni = READ_ONCE(ccmni_ctlb->ccmni_inst[netif_id]);
 	if (!ccmni) {
 		dev_kfree_skb(skb);
 		return;
@@ -344,7 +346,7 @@ static void t7xx_ccmni_recv_skb(struct t7xx_pci_dev *t7xx_dev, struct sk_buff *s
 
 static void t7xx_ccmni_queue_tx_irq_notify(struct t7xx_ccmni_ctrl *ctlb, int qno)
 {
-	struct t7xx_ccmni *ccmni = ctlb->ccmni_inst[0];
+	struct t7xx_ccmni *ccmni = READ_ONCE(ctlb->ccmni_inst[0]);
 	struct netdev_queue *net_queue;
 
 	if (netif_running(ccmni->dev) && atomic_read(&ccmni->usage) > 0) {
@@ -356,7 +358,7 @@ static void t7xx_ccmni_queue_tx_irq_notify(struct t7xx_ccmni_ctrl *ctlb, int qno
 
 static void t7xx_ccmni_queue_tx_full_notify(struct t7xx_ccmni_ctrl *ctlb, int qno)
 {
-	struct t7xx_ccmni *ccmni = ctlb->ccmni_inst[0];
+	struct t7xx_ccmni *ccmni = READ_ONCE(ctlb->ccmni_inst[0]);
 	struct netdev_queue *net_queue;
 
 	if (atomic_read(&ccmni->usage) > 0) {
@@ -374,7 +376,7 @@ static void t7xx_ccmni_queue_state_notify(struct t7xx_pci_dev *t7xx_dev,
 	if (ctlb->md_sta != MD_STATE_READY)
 		return;
 
-	if (!ctlb->ccmni_inst[0]) {
+	if (!READ_ONCE(ctlb->ccmni_inst[0])) {
 		dev_warn(&t7xx_dev->pdev->dev, "No netdev registered yet\n");
 		return;
 	}
-- 
2.53.0


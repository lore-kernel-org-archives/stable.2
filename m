Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179FE3BB13D
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 11:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792237382; cv=none; b=R0kV5Q+Nr3y7JwwvrOl8vbAzlra2WxWqCVqZgG5dg9ARySBOxjuvxGHww7NmdIYtVF3giX/RGSFV9SkmtNdQ4Bkmesgcv0Qierg655iligyiRz7vYbhe8cKi5ZiUm/J6LDuGa9HVRJn2E3M3fz4WddMrIaJn6xr4wdsYxqLz6iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792237382; c=relaxed/simple;
	bh=J8Cw60wlKHa0M+RZVGRfThuU+pMFQ4l3jfsZspjxnx4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tAC2xVEXHUkvMF6m/1jD/kFOHjp8fvqedNoqlVmzoTWR0ZnL48PI5Zaf8LTLHxiPP1IUQuCHDJ8Gmt8aXrikV6h/MDVOusWWdDGZSyb2vJKbpBUmPmkop/x93h/VFHWTIioBStZs9Obopw9JHLbQTW4x03RB7qcEMjfK28UfFkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LQ+FrjmR; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQ+FrjmR"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-16ad92569b5so704108c88.1
        for <stable@vger.kernel.org>; Sat, 17 Oct 2026 04:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792237379; x=1792842179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/NEtd/XspvBJIHQm0kcPRGhqlPpCGmhp+4zMFyvkec0=;
        b=LQ+FrjmRiBrmkwZiew7tTvS0pohugggoXlUc6g9D1evS65lJehstBnMxP7pdl9BQ++
         txdsfYNfJvnGOc4+q0vUBvR36RvPGAK75XYU8a7ku6s3wPOKJZ7cEJT5DM2LOIRCJblW
         q7PXrrg/02n88Qpup77lPUbWZ1ZtBDIHO2dmxO/PSYwNArKDOQo3AMwROxhNu+tcz2Dg
         3YnHPIVqkQ6slo9JzuouCP1yRvlqgwfP+EcV+OowXas/QSoCj7noII7i2v/MSlpjv2Jl
         W3HirFlpnkKacLQdmDB+abp6Wm9bQvsvEEanIfg6O1lJVE7kWCLjVFfyO2fg2JGMbuYl
         Z07w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792237379; x=1792842179;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/NEtd/XspvBJIHQm0kcPRGhqlPpCGmhp+4zMFyvkec0=;
        b=PfFB3mQwLuSyVWvdcxJ7eDfdKwn6C6fwbFHIdq0NCXbEroIb74/gzIpS1TIC2yGK5L
         ccR+CU5tf54BCpTrO98T06p5yIcAFFKv4lxb0V+ekEZR9TH3maZ62MAQ7Bz1aQvDLQ8G
         IEAhReOoU7MoZhRh9or/AAustRqk0Q3ApOXD/9XsqkV02iYocNttDlE+CcTTJiZIk97C
         b06EbFw4YGx3c7WGiHGsZZpG3MyWj0NmkgiYhR2sm+IBLzZg7W2LU6HLvk8UMRBVFBZe
         K73REfhBloxEm1DaC2pgPcBIfs6dSiboyNYs4ZfOg03zKm4+HKHtMuS98TJ7fWRQ6x1J
         YNnQ==
X-Forwarded-Encrypted: i=1; AKwUvBwHGeHMYdQBffvc5eC15bnP02UG5Kcx1y21BQ/vy4yH+eH3LvC8gIc3I4qEaKtVM7y94EQec6s=@vger.kernel.org
X-Gm-Message-State: AFq9FYLBWeCF0pQzZNTjLm6YhCHgKZtWHaL6Je3acriuVSSjWEdLPYgZ
	h5qmF7jcEvGHYCaTP6VGrZ7f2St9pZL+S10YjT6yYedl9dDEsNd93HXo
X-Gm-Gg: AYBFou1QLiJr929jB9TDs1nqVtPmFti20sWkWCMKgqKHGVr854LChrRefAG2SRjInKk
	a4kqufuUTwAt9rQXI7T6EiPf1lZyaMdIbnN1GUj6b84BdnLAQh18cnNE25PrX94nM+phJPYXAN+
	fmV/1C6VujYTYl2TDoAbhcgdpSGW2BKzpk+ERFgYN5opJbDHCSM+Li1Jv7dzoU3q3SqOvGgw5PA
	ZcdfYmMGf2WdBqvQUqfml7l0OZc3I3qEcvMGaH8IrCQOnXO1Pk+VBFaX3uAoizVK+yfnuw9bQ4v
	pugCi25TkcsEaJ6vZvEa7sx2tBaPdCjdi28v5g2ydgi1XrZ7IqnqpaM6RWXKHooouVuqkKSleeK
	UsOnu4OjD7t4/RyHx30Fb/XZsA57AhGVkPt9zGjVDxBOgQXkS5dCW8pjCddbTUIk3DM4iI5zG8I
	5i6sIPcIeabfjrgARa295aKqroiwteIXo9b4IlRUMpw/ZOLre6NLOV2JwSR8fPeiZ8HAHBzebUT
	1k07GiHGTkWkjLIDwZ/+iFGnWvbZfZPPgPypuft9lAOygU=
X-Received: by 2002:a05:701b:4559:20b0:144:eb46:c31 with SMTP id a92af1059eb24-185120abebbmr3391009c88.17.1792237378928;
        Sat, 17 Oct 2026 04:42:58 -0700 (PDT)
Received: from Terra.tail0ac356.ts.net ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831996071csm13759881c88.9.2026.10.17.04.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 04:42:57 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Shannon Nelson <sln@onemain.com>,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	stable@vger.kernel.org,
	co+d17c2bc750a9cbbb@bugs.sh
Subject: [PATCH net] virtio_net: atomically disable rx mode work
Date: Sat, 17 Oct 2026 04:42:38 -0700
Message-ID: <20261017114237.2786302-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtio-net uses a boolean to gate rx_mode_work during device teardown.
The flag is changed under RTNL, but ndo_set_rx_mode checks it under the
address-list lock. A callback can therefore pass the check and enqueue work
after teardown has flushed it. The work is also enabled before late
probe operations that can fail, allowing probe unwind to free the netdev
with work still queued.

KASAN reports the worker using a virtqueue that probe unwind already freed:

  BUG: KASAN: slab-use-after-free in virtqueue_add_split
  Workqueue: events virtnet_rx_mode_work
  Call Trace:
   virtqueue_add_split (drivers/virtio/virtio_ring.c:706)
   virtqueue_add_sgs (drivers/virtio/virtio_ring.c:2839)
   virtnet_send_command_reply (drivers/net/virtio_net.c:3565)
   virtnet_rx_mode_work (drivers/net/virtio_net.c:3833)
   process_one_work (kernel/workqueue.c:3322)
   worker_thread (kernel/workqueue.c:3405)
  Freed by task 119:
   kfree (mm/slub.c:6625)
   vp_del_vq.isra.0 (drivers/virtio/virtio_pci_common.c:259)
   vp_del_vqs (drivers/virtio/virtio_pci_common.c:285)
   virtnet_probe (drivers/net/virtio_net.c:7129)

Use the workqueue disable mechanism to atomically reject new queue attempts
and drain running work. Keep work disabled until probe succeeds or restore
has reattached the netdev, then enable it and replay receive-mode state for
a running interface. Disable it before resource teardown in freeze and
remove.

Fixes: b9f7425239a0 ("virtio-net: convert rx mode setting to use workqueue")
Cc: stable@vger.kernel.org
Reported-by: <co+d17c2bc750a9cbbb@bugs.sh>
Assisted-by: LLM
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 drivers/net/virtio_net.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7d2eeb9b122667..6fa4b7219aa5ac 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -441,9 +441,6 @@ struct virtnet_info {
 	/* Work struct for setting rx mode */
 	struct work_struct rx_mode_work;
 
-	/* OK to queue work setting RX mode? */
-	bool rx_mode_work_enabled;
-
 	/* Does the affinity hint is set for virtqueues? */
 	bool affinity_hint_set;
 
@@ -710,16 +707,13 @@ static void virtnet_rq_free_buf(struct virtnet_info *vi,
 
 static void enable_rx_mode_work(struct virtnet_info *vi)
 {
-	rtnl_lock();
-	vi->rx_mode_work_enabled = true;
-	rtnl_unlock();
+	if (enable_work(&vi->rx_mode_work) && netif_running(vi->dev))
+		schedule_work(&vi->rx_mode_work);
 }
 
 static void disable_rx_mode_work(struct virtnet_info *vi)
 {
-	rtnl_lock();
-	vi->rx_mode_work_enabled = false;
-	rtnl_unlock();
+	disable_work_sync(&vi->rx_mode_work);
 }
 
 static void virtqueue_napi_schedule(struct napi_struct *napi,
@@ -3894,8 +3888,7 @@ static void virtnet_set_rx_mode(struct net_device *dev)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
 
-	if (vi->rx_mode_work_enabled)
-		schedule_work(&vi->rx_mode_work);
+	schedule_work(&vi->rx_mode_work);
 }
 
 static int virtnet_vlan_rx_add_vid(struct net_device *dev,
@@ -5711,7 +5704,6 @@ static void virtnet_freeze_down(struct virtio_device *vdev)
 	/* Make sure no work handler is accessing the device */
 	flush_work(&vi->config_work);
 	disable_rx_mode_work(vi);
-	flush_work(&vi->rx_mode_work);
 
 	if (netif_running(vi->dev)) {
 		rtnl_lock();
@@ -5741,8 +5733,6 @@ static int virtnet_restore_up(struct virtio_device *vdev)
 
 	virtio_device_ready(vdev);
 
-	enable_rx_mode_work(vi);
-
 	if (netif_running(vi->dev)) {
 		rtnl_lock();
 		err = virtnet_open(vi->dev);
@@ -5754,6 +5744,8 @@ static int virtnet_restore_up(struct virtio_device *vdev)
 	netif_tx_lock_bh(vi->dev);
 	netif_device_attach(vi->dev);
 	netif_tx_unlock_bh(vi->dev);
+
+	enable_rx_mode_work(vi);
 	return 0;
 
 err_destroy_pools:
@@ -6849,6 +6841,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 
 	INIT_WORK(&vi->config_work, virtnet_config_changed_work);
 	INIT_WORK(&vi->rx_mode_work, virtnet_rx_mode_work);
+	disable_work(&vi->rx_mode_work);
 
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF)) {
 		vi->mergeable_rx_bufs = true;
@@ -7007,8 +7000,6 @@ static int virtnet_probe(struct virtio_device *vdev)
 	if (vi->has_rss || vi->has_rss_hash_report)
 		virtnet_init_default_rss(vi);
 
-	enable_rx_mode_work(vi);
-
 	for (i = 0; i < ARRAY_SIZE(guest_offloads); i++) {
 		unsigned int fbit;
 
@@ -7112,6 +7103,8 @@ static int virtnet_probe(struct virtio_device *vdev)
 		goto free_unregister_netdev;
 	}
 
+	enable_rx_mode_work(vi);
+
 	pr_debug("virtnet: registered device %s with %d RX and TX vq's\n",
 		 dev->name, max_queue_pairs);
 
@@ -7164,7 +7157,6 @@ static void virtnet_remove(struct virtio_device *vdev)
 	/* Make sure no work handler is accessing the device. */
 	flush_work(&vi->config_work);
 	disable_rx_mode_work(vi);
-	flush_work(&vi->rx_mode_work);
 
 	virtnet_free_irq_moder(vi);
 
-- 
2.55.0


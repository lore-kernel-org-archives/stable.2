Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793837780;
	b=hwZg5hH1UAaK98pyLvLrAGEmdmC7QOCWWqnT2WzvgWMJkASjAFMKPQc8Zfl35ULV2hoO
	 o4ygbfvDz4IoWgtqy49PgisG16crk84UcJk/hwoZyyUDc0qBujVeIarchl6nfe60x7/vw
	 vzyS7hzrZT5vn7H8E1wLQpP4W38Wl/6azViZfU4SWUrSZrAe4YeaRBIzrQOJGQVvwXx4C
	 ntBmQAeCClyjcA59Qg8WCIUz0F38uRw6a3+k8T2i5gGXlJOvdqCUKM1I8jJxCqBlEHA9p
	 QSsh3K+xf/Jfy+9geKVJCHmwoa8aHQlUUvDo9v8PX+sDe+3F2TW75KrLQkaF5YDGMNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793837780;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=UEkf9QcugVz0tKL69cOlKxGK96kCaB6eNfttBbg2Qe4=;
	b=qf8gvvbs9fkHtkcU10IH2DrBSo2kSsS8fUD1KZMMLgf9NqTBCPV50MqbCSDPPbXBxo9s
	 ddz7pytNjNDF0q6vUuhV8JH1HE8+mNFiYtwoREPDrrw/w0UXFci/jSK2/v9gfw54OgICm
	 ttOgkysGzzy3eBoVGt+ffO1ileymo8hRhAa4zvvGna8zqUyHZrlBrb1lxtANfb0vdGYa8
	 dRMTkVGNzWMWByL9R0gi0EIVODOLmtcz9fMzMuLJ5/KYiOXtfHFo+5zZY1QyxpK8Yfy1f
	 5ukP68aAc5aYRR/4wKK6G8Fot+f7yfmpGi0YeaoqoMVso7tXQPgNL+JYZtufY26kctA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ve7YtVku;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F31606A326
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 00:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ve7YtVku
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BBB11F000C1;
	Thu,  5 Nov 2026 00:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793837779;
	bh=UEkf9QcugVz0tKL69cOlKxGK96kCaB6eNfttBbg2Qe4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ve7YtVkuvAlOFWIMHpkvBRUB7f16hWt133ipAOVYGc+miWHVRe2v6KTHn1V4pc5BB
	 I/dXwyT901tg4myBRMB0aTKeXxkJ3oDlm7wcy2cA4ejGCV32bY2wpis+eTUkrjILmR
	 8aHIHtliMSy9Kltw+vQE+JFG4riKv9wW3IgfDKIFYykYp46U+/nYsrvWULuNpLixKT
	 5dpFnmTeH9X1zpyHm+Z+a3OFspiOu81XD+BoQRpI26daY1CNJT78BSkhZJjpERiSFk
	 TM4M1Ikn9Omm/3fi57tF9gROC9vVuMsj0LRIbZvtcMosGLVw2Zc06mbrQtyAoUBQ2E
	 YCxPdazguezLg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Weiming Shi <bestswngs@gmail.com>,
	co+d17c2bc750a9cbbb@bugs.sh,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] virtio_net: atomically disable rx mode work
Date: Wed,  4 Nov 2026 19:16:18 -0500
Message-ID: <20261105001559.950311-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110440-steam-gleeful-8fc6@gregkh>
References: <2026110440-steam-gleeful-8fc6@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weiming Shi <bestswngs@gmail.com>

[ Upstream commit 1234707482053f1d1ac7c5756207d2c29057974c ]

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
Link: https://patch.msgid.link/20261017114237.2786302-2-bestswngs@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ sashal: Adjusted context to preserve existing refill handling and restore error paths. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/virtio_net.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index b7ab57f4e277a..34390befdf8a8 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -458,9 +458,6 @@ struct virtnet_info {
 	/* Work struct for setting rx mode */
 	struct work_struct rx_mode_work;
 
-	/* OK to queue work setting RX mode? */
-	bool rx_mode_work_enabled;
-
 	/* Does the affinity hint is set for virtqueues? */
 	bool affinity_hint_set;
 
@@ -740,16 +737,13 @@ static void disable_delayed_refill(struct virtnet_info *vi)
 
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
@@ -3996,8 +3990,7 @@ static void virtnet_set_rx_mode(struct net_device *dev)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
 
-	if (vi->rx_mode_work_enabled)
-		schedule_work(&vi->rx_mode_work);
+	schedule_work(&vi->rx_mode_work);
 }
 
 static int virtnet_vlan_rx_add_vid(struct net_device *dev,
@@ -5813,7 +5806,6 @@ static void virtnet_freeze_down(struct virtio_device *vdev)
 	/* Make sure no work handler is accessing the device */
 	flush_work(&vi->config_work);
 	disable_rx_mode_work(vi);
-	flush_work(&vi->rx_mode_work);
 
 	if (netif_running(vi->dev)) {
 		rtnl_lock();
@@ -5840,7 +5832,6 @@ static int virtnet_restore_up(struct virtio_device *vdev)
 	virtio_device_ready(vdev);
 
 	enable_delayed_refill(vi);
-	enable_rx_mode_work(vi);
 
 	if (netif_running(vi->dev)) {
 		rtnl_lock();
@@ -5853,6 +5844,8 @@ static int virtnet_restore_up(struct virtio_device *vdev)
 	netif_tx_lock_bh(vi->dev);
 	netif_device_attach(vi->dev);
 	netif_tx_unlock_bh(vi->dev);
+
+	enable_rx_mode_work(vi);
 	return err;
 }
 
@@ -6952,6 +6945,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 
 	INIT_WORK(&vi->config_work, virtnet_config_changed_work);
 	INIT_WORK(&vi->rx_mode_work, virtnet_rx_mode_work);
+	disable_work(&vi->rx_mode_work);
 	spin_lock_init(&vi->refill_lock);
 
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF)) {
@@ -7103,8 +7097,6 @@ static int virtnet_probe(struct virtio_device *vdev)
 	if (vi->has_rss || vi->has_rss_hash_report)
 		virtnet_init_default_rss(vi);
 
-	enable_rx_mode_work(vi);
-
 	/* serialize netdev register + virtio_device_ready() with ndo_open() */
 	rtnl_lock();
 
@@ -7204,6 +7196,8 @@ static int virtnet_probe(struct virtio_device *vdev)
 		goto free_unregister_netdev;
 	}
 
+	enable_rx_mode_work(vi);
+
 	pr_debug("virtnet: registered device %s with %d RX and TX vq's\n",
 		 dev->name, max_queue_pairs);
 
@@ -7255,7 +7249,6 @@ static void virtnet_remove(struct virtio_device *vdev)
 	/* Make sure no work handler is accessing the device. */
 	flush_work(&vi->config_work);
 	disable_rx_mode_work(vi);
-	flush_work(&vi->rx_mode_work);
 
 	virtnet_free_irq_moder(vi);
 
-- 
2.53.0


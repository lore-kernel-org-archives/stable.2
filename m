Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802111;
	b=DDUPjmk5ahpxDraini3R8hM2DcbvzcNxALO3SN5xa91DzuO2LnsGNvDqHQM7Ymb2VzV2
	 Vi6B4kS7ymeNjMzbRow5/OBQD3H1BOHAiq/S8npzeO1jBsRNvTCqmmiAToApurgnBY2tu
	 oiCZkqoX4drdsDKJnWW2X1gIoXEb/NDfwV3ireqNinq4HDJlxlTgKb9zxF0x5DYyORSeB
	 YVv36178d5Iyd/8eTJrYr877cvQ4Ubv6suJGmdvBZtfDqw+dQlekIwaoZQcF1IQib8t1O
	 pSXMW4RVWJbgaTmoqWNdVD1shNZ4eEuXa+JURt/wVSwp2oFReQdiUj3mSwYvYjSA9ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802111;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=mnXy25wPIeSR51Nmn9G4wXgqLJ66F3Kd6VJ6/6zvm0w=;
	b=rfRYN5iqR2nj2qMFzA5wnw9xZxdoT1pTcPu5NgMt1urIoobyuoQFpRYkjFYxPmvutZp1
	 mKfG20rwCmrOxVZpCp88YC9FGmtBUu3q61irs2weT4yOPUPzRBdjaL873j9YiJBgFYu/f
	 VqeQjOZRibeR6LZwasQlShuKOnk/1RMUbbf1srqStzVpm7gneslbHe3iiWy0BU+b+J3OR
	 OkevXpfv/QGE8MXSe997OCd5KPu/lSLAXLNwWAyv+MnCPUd6VZVutoUW0Ej5YzAy0K1Tp
	 bXMDe2in3CQtsohDMWqgbUjAe0u2XSTYQ7mWDLgiiSItS/zvp9L+7FCiP85sUx9OUxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=zSKQ143f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5776606A328
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 14:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=zSKQ143f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 712DA1F00919;
	Wed,  4 Nov 2026 14:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793802110;
	bh=mnXy25wPIeSR51Nmn9G4wXgqLJ66F3Kd6VJ6/6zvm0w=;
	h=Subject:To:Cc:From:Date;
	b=zSKQ143fFZm0MxgtD6BoyPRaB8e/rsEneb9PGCdtNPoA+h+wd4h5koVR/bWbygeJg
	 RD4Ntj2fIMasgLCO2JE6eAL82gVioD8A39QLzJJ+Z1DHYmFJnEoxBDpjUhnjtZEVZe
	 69T46xijWer6WP55irY5rtpV6hfrzUjt3YoRv9Pc=
Subject: FAILED: patch "[PATCH] virtio_net: atomically disable rx mode work" failed to apply to 6.12-stable tree
To: bestswngs@gmail.com,co+d17c2bc750a9cbbb@bugs.sh,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 15:21:40 +0100
Message-ID: <2026110440-coastline-slimness-7973@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 1234707482053f1d1ac7c5756207d2c29057974c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110440-coastline-slimness-7973@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1234707482053f1d1ac7c5756207d2c29057974c Mon Sep 17 00:00:00 2001
From: Weiming Shi <bestswngs@gmail.com>
Date: Sat, 17 Oct 2026 04:42:38 -0700
Subject: [PATCH] virtio_net: atomically disable rx mode work

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

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index daab43ac92ce..4e8a792cec0e 100644
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
@@ -3925,8 +3919,7 @@ static void virtnet_set_rx_mode(struct net_device *dev)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
 
-	if (vi->rx_mode_work_enabled)
-		schedule_work(&vi->rx_mode_work);
+	schedule_work(&vi->rx_mode_work);
 }
 
 static int virtnet_vlan_rx_add_vid(struct net_device *dev,
@@ -5742,7 +5735,6 @@ static void virtnet_freeze_down(struct virtio_device *vdev)
 	/* Make sure no work handler is accessing the device */
 	flush_work(&vi->config_work);
 	disable_rx_mode_work(vi);
-	flush_work(&vi->rx_mode_work);
 
 	if (netif_running(vi->dev)) {
 		rtnl_lock();
@@ -5772,8 +5764,6 @@ static int virtnet_restore_up(struct virtio_device *vdev)
 
 	virtio_device_ready(vdev);
 
-	enable_rx_mode_work(vi);
-
 	if (netif_running(vi->dev)) {
 		rtnl_lock();
 		err = virtnet_open(vi->dev);
@@ -5785,6 +5775,8 @@ static int virtnet_restore_up(struct virtio_device *vdev)
 	netif_tx_lock_bh(vi->dev);
 	netif_device_attach(vi->dev);
 	netif_tx_unlock_bh(vi->dev);
+
+	enable_rx_mode_work(vi);
 	return 0;
 
 err_destroy_pools:
@@ -6880,6 +6872,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 
 	INIT_WORK(&vi->config_work, virtnet_config_changed_work);
 	INIT_WORK(&vi->rx_mode_work, virtnet_rx_mode_work);
+	disable_work(&vi->rx_mode_work);
 
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF)) {
 		vi->mergeable_rx_bufs = true;
@@ -7038,8 +7031,6 @@ static int virtnet_probe(struct virtio_device *vdev)
 	if (vi->has_rss || vi->has_rss_hash_report)
 		virtnet_init_default_rss(vi);
 
-	enable_rx_mode_work(vi);
-
 	for (i = 0; i < ARRAY_SIZE(guest_offloads); i++) {
 		unsigned int fbit;
 
@@ -7143,6 +7134,8 @@ static int virtnet_probe(struct virtio_device *vdev)
 		goto free_unregister_netdev;
 	}
 
+	enable_rx_mode_work(vi);
+
 	pr_debug("virtnet: registered device %s with %d RX and TX vq's\n",
 		 dev->name, max_queue_pairs);
 
@@ -7195,7 +7188,6 @@ static void virtnet_remove(struct virtio_device *vdev)
 	/* Make sure no work handler is accessing the device. */
 	flush_work(&vi->config_work);
 	disable_rx_mode_work(vi);
-	flush_work(&vi->rx_mode_work);
 
 	virtnet_free_irq_moder(vi);
 


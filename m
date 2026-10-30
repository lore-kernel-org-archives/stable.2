Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793365098;
	b=Xim2ObAopO4EUrncX3P12MEPr1oNxjKTmFfbv79uC88vXNmwzdqRNKhMl7r0gdKexvBw
	 f5yExbu+bHyK+EnzAfW0dVmY86udJZOv+BfyA+GuBqjV/TAWbtjV/Br8IFAbiRp1og8oa
	 7BAAIarvbodAeUTPQKgMrOIdn6zQkp0/2FxHkBnZVQgB0EidLqlbRt/6/egQIzZeAMbF7
	 YV0Rj0IeHzO8cyfgmp5kldfaQGHbgCOUvDl9l+rniBzg2rUpSAGu7iqYD5DpITB0cXnwR
	 zbkbRMJBLiINWzf4qOsV60J8ez1QzevyfiU1Pa1z1fQH88aIs+MTUNsKsl9OKU/PfRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793365098;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=81NilSY7C9BCoWllw0UE6v+Txwqg/8k8tiW4Ruu7xO8=;
	b=3cEiEs1xSQiIB1tuu2o5F8fbd0xeWluM8qW1OjTO79Qbozsp3kEYDT8nWCxpW1BxzFp7
	 3V14s6mDl/9VDprlXOL0dZH8r2iHh0dR0+WmM93SPztXzx8621ucZl5gK/mGWblFbpFBh
	 p6/pXvfjkDUFs0w/o7+aaFGvMHUAk+gFeZxKlgD8UspCe3YyCscyBYLeHhOg9i3fsX7+V
	 KCbc+sQOi6u/o/kbnWTfa15iT+mrEEIbE5f91nigUuitw7AxdHz+R7EZmKdIOkz6MWOJc
	 i4zEghdOBkXzvPAD/YnunabEOFr+HltT/Ix53dg8kybDOQ3nthFLYl3Un2AcSoCVwTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=wa0iJTLu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448E960A5BCF;
	Fri, 30 Oct 2026 12:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=wa0iJTLu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01D9F1F0093A;
	Fri, 30 Oct 2026 12:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793365097;
	bh=81NilSY7C9BCoWllw0UE6v+Txwqg/8k8tiW4Ruu7xO8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=wa0iJTLuJYBZzO0qDPCj8MMC35x0WnjXu1ICuw5tlBJktnTyFX1nRhE7mQWn9iMVL
	 sQRcOlRMPtR8Ohz3Bwp5nw0C55qjgHMgr1cF8YLwt3C8LgxwyjLQICSvBftBKl9KeA
	 8oZgH9rIBthLF0Wk/rA8oamtYFpD08oWwwfPT2IA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.18.60
Date: Fri, 30 Oct 2026 13:58:04 +0100
Message-ID: <2026103003-finally-passage-7246@gregkh>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <2026103003-clause-bagpipe-08a2@gregkh>
References: <2026103003-clause-bagpipe-08a2@gregkh>
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

diff --git a/Makefile b/Makefile
index dbe46057221c..7c698d401dd5 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 18
-SUBLEVEL = 59
+SUBLEVEL = 60
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 5c16cf96b97c..a7d3d2e002da 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1413,11 +1413,20 @@ static int disk_alloc_zone_resources(struct gendisk *disk,
 	if (!disk->zone_wplugs_pool)
 		goto free_hash;
 
-	disk->zone_wplugs_wq =
-		alloc_workqueue("%s_zwplugs", WQ_MEM_RECLAIM | WQ_HIGHPRI,
-				pool_size, disk->disk_name);
-	if (!disk->zone_wplugs_wq)
-		goto destroy_pool;
+	/*
+	 * We may already have a zone write plug workqueue as this function may
+	 * be called after disk_free_zone_resources(), which does not destroy
+	 * the workqueue (the zone write plugs workqueue is destroyed at
+	 * disk_release() time).
+	 */
+	if (!disk->zone_wplugs_wq) {
+		disk->zone_wplugs_wq =
+			alloc_workqueue("%s_zwplugs",
+					WQ_MEM_RECLAIM | WQ_HIGHPRI,
+					pool_size, disk->disk_name);
+		if (!disk->zone_wplugs_wq)
+			goto destroy_pool;
+	}
 
 	return 0;
 
@@ -1474,15 +1483,13 @@ static unsigned int disk_set_conv_zones_bitmap(struct gendisk *disk,
 	return nr_conv_zones;
 }
 
-void disk_free_zone_resources(struct gendisk *disk)
+static void disk_free_zone_resources(struct gendisk *disk)
 {
 	if (!disk->zone_wplugs_pool)
 		return;
 
-	if (disk->zone_wplugs_wq) {
-		destroy_workqueue(disk->zone_wplugs_wq);
-		disk->zone_wplugs_wq = NULL;
-	}
+	if (disk->zone_wplugs_wq)
+		drain_workqueue(disk->zone_wplugs_wq);
 
 	disk_destroy_zone_wplugs_hash_table(disk);
 
@@ -1501,6 +1508,16 @@ void disk_free_zone_resources(struct gendisk *disk)
 	disk->nr_zones = 0;
 }
 
+void disk_release_zone_resources(struct gendisk *disk)
+{
+	if (disk->zone_wplugs_wq) {
+		destroy_workqueue(disk->zone_wplugs_wq);
+		disk->zone_wplugs_wq = NULL;
+	}
+
+	disk_free_zone_resources(disk);
+}
+
 static inline bool disk_need_zone_resources(struct gendisk *disk)
 {
 	/*
diff --git a/block/blk.h b/block/blk.h
index 2810b4d086e6..179662b86899 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -499,7 +499,7 @@ static inline void ioc_clear_queue(struct request_queue *q)
 
 #ifdef CONFIG_BLK_DEV_ZONED
 void disk_init_zone_resources(struct gendisk *disk);
-void disk_free_zone_resources(struct gendisk *disk);
+void disk_release_zone_resources(struct gendisk *disk);
 static inline bool bio_zone_write_plugging(struct bio *bio)
 {
 	return bio_flagged(bio, BIO_ZONE_WRITE_PLUGGING);
@@ -552,7 +552,7 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, blk_mode_t mode,
 static inline void disk_init_zone_resources(struct gendisk *disk)
 {
 }
-static inline void disk_free_zone_resources(struct gendisk *disk)
+static inline void disk_release_zone_resources(struct gendisk *disk)
 {
 }
 static inline bool bio_zone_write_plugging(struct bio *bio)
diff --git a/block/genhd.c b/block/genhd.c
index bbcfbd1a363c..6ba0e22ce9df 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1308,7 +1308,7 @@ static void disk_release(struct device *dev)
 
 	disk_release_events(disk);
 	kfree(disk->random);
-	disk_free_zone_resources(disk);
+	disk_release_zone_resources(disk);
 	xa_destroy(&disk->part_tbl);
 
 	kobject_put(&disk->queue_kobj);
diff --git a/crypto/asymmetric_keys/restrict.c b/crypto/asymmetric_keys/restrict.c
index afcd4d101ac5..4988c4ab9722 100644
--- a/crypto/asymmetric_keys/restrict.c
+++ b/crypto/asymmetric_keys/restrict.c
@@ -240,10 +240,14 @@ static int key_or_keyring_common(struct key *dest_keyring,
 			if (IS_ERR(key))
 				key = NULL;
 		} else if (trusted->type == &key_type_asymmetric) {
+			const struct asymmetric_key_ids *kids;
 			const struct asymmetric_key_id **signer_ids;
 
-			signer_ids = (const struct asymmetric_key_id **)
-				asymmetric_key_ids(trusted)->id;
+			kids = asymmetric_key_ids(trusted);
+			if (!kids)
+				return -ENOKEY;
+
+			signer_ids = (const struct asymmetric_key_id **)kids->id;
 
 			/*
 			 * The auth_ids come from the candidate key (the
diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
index 48d15dd785f6..62ab6d7f3721 100644
--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -12,6 +12,7 @@
 #include <linux/bits.h>
 #include <linux/device.h>
 #include <linux/err.h>
+#include <linux/ioport.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/dma-mapping.h>
@@ -71,6 +72,42 @@ static struct notifier_block acpi_platform_notifier = {
 	.notifier_call = acpi_platform_device_remove_notify,
 };
 
+static unsigned int acpi_platform_adjust_resources(struct acpi_device *adev,
+						   struct resource *new_res,
+						   struct resource *resources,
+						   unsigned int count)
+{
+	unsigned int i;
+
+	if (!(new_res->flags & (IORESOURCE_IO | IORESOURCE_MEM)))
+		return count;
+
+	for (i = 0; i < count; ) {
+		struct resource *res = &resources[i];
+
+		/*
+		 * Look for overlaps of resources of the same type that would
+		 * cause resource insertion to fail down the road.
+		 */
+		if (__resource_contains_unbound(res, new_res) ||
+		    __resource_contains_unbound(new_res, res) ||
+		    resource_type(new_res) != resource_type(res) ||
+		    !resource_union(new_res, res, new_res)) {
+			i++;
+			continue;
+		}
+
+		dev_info(&adev->dev, "%pR expanded due to overlap\n", new_res);
+		/*
+		 * Eliminate the previously processed resource that overlapped
+		 * with the new one because it is not necessary any more.
+		 */
+		memmove(res, res + 1, (--count - i) * sizeof(*res));
+	}
+
+	return count;
+}
+
 static void acpi_platform_fill_resource(struct acpi_device *adev,
 	const struct resource *src, struct resource *dest)
 {
@@ -114,10 +151,8 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev,
 	struct platform_device *pdev = NULL;
 	struct platform_device_info pdevinfo;
 	const struct acpi_device_id *match;
-	struct resource_entry *rentry;
-	struct list_head resource_list;
 	struct resource *resources = NULL;
-	int count;
+	int count = 0;
 
 	/* If the ACPI node already has a physical device attached, skip it. */
 	if (adev->physical_node_count)
@@ -137,22 +172,32 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev,
 		}
 	}
 
-	INIT_LIST_HEAD(&resource_list);
-	count = acpi_dev_get_resources(adev, &resource_list, NULL, NULL);
-	if (count < 0)
-		return NULL;
-	if (count > 0) {
-		resources = kcalloc(count, sizeof(*resources), GFP_KERNEL);
-		if (!resources) {
+	if (adev->device_type == ACPI_BUS_TYPE_DEVICE) {
+		struct list_head resource_list = LIST_HEAD_INIT(resource_list);
+
+		count = acpi_dev_get_resources(adev, &resource_list, NULL, NULL);
+		if (count < 0)
+			return ERR_PTR(-ENODATA);
+
+		if (count > 0) {
+			struct resource_entry *rentry;
+
+			resources = kcalloc(count, sizeof(*resources), GFP_KERNEL);
+			if (!resources) {
+				acpi_dev_free_resource_list(&resource_list);
+				return ERR_PTR(-ENOMEM);
+			}
+			count = 0;
+			list_for_each_entry(rentry, &resource_list, node) {
+				count = acpi_platform_adjust_resources(adev,
+								       rentry->res,
+								       resources,
+								       count);
+				acpi_platform_fill_resource(adev, rentry->res,
+							    &resources[count++]);
+			}
 			acpi_dev_free_resource_list(&resource_list);
-			return ERR_PTR(-ENOMEM);
 		}
-		count = 0;
-		list_for_each_entry(rentry, &resource_list, node)
-			acpi_platform_fill_resource(adev, rentry->res,
-						    &resources[count++]);
-
-		acpi_dev_free_resource_list(&resource_list);
 	}
 
 	memset(&pdevinfo, 0, sizeof(pdevinfo));
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 7f9dd2704f63..c382bed50d6c 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2644,6 +2644,8 @@ static void acpi_bus_scan_fixed(void)
 				device_init_wakeup(&adev->dev, true);
 			else
 				dev_dbg(&adev->dev, "No driver\n");
+
+			acpi_default_enumeration(adev);
 		}
 	}
 
@@ -2656,6 +2658,8 @@ static void acpi_bus_scan_fixed(void)
 			adev->flags.match_driver = true;
 			if (device_attach(&adev->dev) < 0)
 				dev_dbg(&adev->dev, "No driver\n");
+
+			acpi_default_enumeration(adev);
 		}
 	}
 }
diff --git a/drivers/acpi/tiny-power-button.c b/drivers/acpi/tiny-power-button.c
index 6353be6fec69..531e65b01bcb 100644
--- a/drivers/acpi/tiny-power-button.c
+++ b/drivers/acpi/tiny-power-button.c
@@ -1,7 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
+#include <linux/acpi.h>
 #include <linux/module.h>
+#include <linux/platform_device.h>
 #include <linux/sched/signal.h>
-#include <linux/acpi.h>
 #include <acpi/button.h>
 
 MODULE_AUTHOR("Josh Triplett");
@@ -35,8 +36,9 @@ static u32 acpi_tiny_power_button_event(void *not_used)
 	return ACPI_INTERRUPT_HANDLED;
 }
 
-static int acpi_tiny_power_button_add(struct acpi_device *device)
+static int acpi_tiny_power_button_probe(struct platform_device *pdev)
 {
+	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
 	acpi_status status;
 
 	if (device->device_type == ACPI_BUS_TYPE_POWER_BUTTON) {
@@ -55,8 +57,10 @@ static int acpi_tiny_power_button_add(struct acpi_device *device)
 	return 0;
 }
 
-static void acpi_tiny_power_button_remove(struct acpi_device *device)
+static void acpi_tiny_power_button_remove(struct platform_device *pdev)
 {
+	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
+
 	if (device->device_type == ACPI_BUS_TYPE_POWER_BUTTON) {
 		acpi_remove_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
 						acpi_tiny_power_button_event);
@@ -67,14 +71,13 @@ static void acpi_tiny_power_button_remove(struct acpi_device *device)
 	acpi_os_wait_events_complete();
 }
 
-static struct acpi_driver acpi_tiny_power_button_driver = {
-	.name = "tiny-power-button",
-	.class = "tiny-power-button",
-	.ids = tiny_power_button_device_ids,
-	.ops = {
-		.add = acpi_tiny_power_button_add,
-		.remove = acpi_tiny_power_button_remove,
+static struct platform_driver acpi_tiny_power_button_driver = {
+	.probe = acpi_tiny_power_button_probe,
+	.remove = acpi_tiny_power_button_remove,
+	.driver = {
+		.name = "acpi-tiny-power-button",
+		.acpi_match_table = tiny_power_button_device_ids,
 	},
 };
 
-module_acpi_driver(acpi_tiny_power_button_driver);
+module_platform_driver(acpi_tiny_power_button_driver);
diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index 2d3d23450783..2e31199546a8 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -599,34 +599,22 @@ static int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
 	};
 	struct device *dev = ice_pf_to_dev(ring->vsi->back);
 	u32 num_bufs = ICE_DESC_UNUSED(ring);
-	u32 rx_buf_len;
 	int err;
 
 	if (ring->vsi->type == ICE_VSI_PF || ring->vsi->type == ICE_VSI_SF ||
 	    ring->vsi->type == ICE_VSI_LB) {
-		if (!xdp_rxq_info_is_reg(&ring->xdp_rxq)) {
-			err = __xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
-						 ring->q_index,
-						 ring->q_vector->napi.napi_id,
-						 ring->rx_buf_len);
-			if (err)
-				return err;
-		}
-
 		ice_rx_xsk_pool(ring);
 		err = ice_realloc_rx_xdp_bufs(ring, ring->xsk_pool);
 		if (err)
 			return err;
 
 		if (ring->xsk_pool) {
-			xdp_rxq_info_unreg(&ring->xdp_rxq);
-
-			rx_buf_len =
-				xsk_pool_get_rx_frame_size(ring->xsk_pool);
+			u32 frag_size =
+				xsk_pool_get_rx_frag_step(ring->xsk_pool);
 			err = __xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
 						 ring->q_index,
 						 ring->q_vector->napi.napi_id,
-						 rx_buf_len);
+						 frag_size);
 			if (err)
 				return err;
 			err = xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
@@ -648,14 +636,13 @@ static int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
 			ring->truesize = fq.truesize;
 			ring->rx_buf_len = fq.buf_len;
 
-			if (!xdp_rxq_info_is_reg(&ring->xdp_rxq)) {
-				err = __xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
-							 ring->q_index,
-							 ring->q_vector->napi.napi_id,
-							 ring->rx_buf_len);
-				if (err)
-					goto err_destroy_fq;
-			}
+			err = __xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
+						 ring->q_index,
+						 ring->q_vector->napi.napi_id,
+						 ring->truesize);
+			if (err)
+				goto err_destroy_fq;
+
 			xdp_rxq_info_attach_page_pool(&ring->xdp_rxq,
 						      ring->pp);
 		}
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 428118475e2f..53284959eda0 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3313,6 +3313,7 @@ ice_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring,
 		rx_rings[i].cached_phctime = pf->ptp.cached_phc_time;
 		rx_rings[i].desc = NULL;
 		rx_rings[i].xdp_buf = NULL;
+		rx_rings[i].xdp_rxq = (struct xdp_rxq_info){ };
 
 		/* this is to allow wr32 to have something to write to
 		 * during early allocation of Rx buffers
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index cc3c07847c35..9752d61a0a5f 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -542,7 +542,9 @@ void ice_clean_rx_ring(struct ice_rx_ring *rx_ring)
 			i = 0;
 	}
 
-	if (rx_ring->vsi->type == ICE_VSI_PF &&
+	if ((rx_ring->vsi->type == ICE_VSI_PF ||
+	     rx_ring->vsi->type == ICE_VSI_SF ||
+	     rx_ring->vsi->type == ICE_VSI_LB) &&
 	    xdp_rxq_info_is_reg(&rx_ring->xdp_rxq)) {
 		xdp_rxq_info_detach_mem_model(&rx_ring->xdp_rxq);
 		xdp_rxq_info_unreg(&rx_ring->xdp_rxq);
diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 989ff1fd9110..102631398af3 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -900,6 +900,9 @@ void ice_xsk_clean_rx_ring(struct ice_rx_ring *rx_ring)
 	u16 ntc = rx_ring->next_to_clean;
 	u16 ntu = rx_ring->next_to_use;
 
+	if (xdp_rxq_info_is_reg(&rx_ring->xdp_rxq))
+		xdp_rxq_info_unreg(&rx_ring->xdp_rxq);
+
 	while (ntc != ntu) {
 		struct xdp_buff *xdp = *ice_xdp_buf(rx_ring, ntc);
 
diff --git a/fs/coredump.c b/fs/coredump.c
index 5c1c381ee380..3e927378bf5b 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -506,7 +506,9 @@ static int zap_threads(struct task_struct *tsk,
 	int nr = -EAGAIN;
 
 	spin_lock_irq(&tsk->sighand->siglock);
-	if (!(signal->flags & SIGNAL_GROUP_EXIT) && !signal->group_exec_task) {
+	/* A freeze requested before the dump would be lost with TIF_SIGPENDING. */
+	if (!(signal->flags & SIGNAL_GROUP_EXIT) && !signal->group_exec_task &&
+	    !freezing(tsk) && !(tsk->jobctl & JOBCTL_TRAP_FREEZE)) {
 		/* Allow SIGKILL, see prepare_signal() */
 		signal->core_state = core_state;
 		nr = zap_process(signal, exit_code);
@@ -560,6 +562,8 @@ static void coredump_finish(bool core_dumped)
 	current->signal->core_state = NULL;
 	spin_unlock_irq(&current->sighand->siglock);
 
+	/* A released thread may exit and be freed before it is woken. */
+	guard(rcu)();
 	while ((curr = next) != NULL) {
 		next = curr->next;
 		task = curr->task;
@@ -568,6 +572,7 @@ static void coredump_finish(bool core_dumped)
 		 * ->task == NULL before we read ->next.
 		 */
 		smp_mb();
+		/* Any wakeup now lets the thread exit, rcu keeps it alive. */
 		curr->task = NULL;
 		wake_up_process(task);
 	}
@@ -575,13 +580,8 @@ static void coredump_finish(bool core_dumped)
 
 static bool dump_interrupted(void)
 {
-	/*
-	 * SIGKILL or freezing() interrupt the coredumping. Perhaps we
-	 * can do try_to_freeze() and check __fatal_signal_pending(),
-	 * but then we need to teach dump_write() to restart and clear
-	 * TIF_SIGPENDING.
-	 */
-	return fatal_signal_pending(current) || freezing(current);
+	/* Only SIGKILL and the freezers set it after zap_threads(). */
+	return task_sigpending(current);
 }
 
 static void wait_for_dump_helpers(struct file *file)
diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index a992c2919f79..e060dfe7cdac 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -678,8 +678,10 @@ static int eventfs_iterate(struct file *file, struct dir_context *ctx)
 		 * Matches the smp_wmb() in free_ei()
 		 */
 		smp_rmb();
-		if (ei->is_freed)
-			return -EINVAL;
+		if (ei->is_freed) {
+			ret = -EINVAL;
+			goto out;
+		}
 
 		if (c > 0) {
 			c--;
diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_types.h
index 4f1607e00359..bdfc3cf7d989 100644
--- a/include/linux/io_uring_types.h
+++ b/include/linux/io_uring_types.h
@@ -445,8 +445,13 @@ struct io_ring_ctx {
 	u32				iowq_limits[2];
 
 	struct callback_head		poll_wq_task_work;
+	/* deferred ->poll_wq wake up for local task_work */
+	struct rcu_head			poll_wq_rcu;
+	atomic_t			poll_wq_rcu_pending;
 	struct list_head		defer_list;
 	unsigned			nr_drained;
+	/* drain request dispatched from ->defer_list, until it completes */
+	struct io_kiocb			*drain_req;
 
 	/* protected by ->completion_lock */
 	unsigned			nr_req_allocated;
diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index e8b2d6aa4013..042628fd735d 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -298,14 +298,28 @@ static inline unsigned long resource_ext_type(const struct resource *res)
 {
 	return res->flags & IORESOURCE_EXT_TYPE_BITS;
 }
-/* True iff r1 completely contains r2 */
-static inline bool resource_contains(const struct resource *r1, const struct resource *r2)
+
+/*
+ * For checking if @r1 completely contains @r2 for resources that have real
+ * addresses but are not yet crafted into the resource tree. Normally
+ * resource_contains() should be used instead of this function as it checks
+ * also IORESOURCE_UNSET flag.
+ */
+static inline bool __resource_contains_unbound(const struct resource *r1,
+					       const struct resource *r2)
 {
 	if (resource_type(r1) != resource_type(r2))
 		return false;
+
+	return r1->start <= r2->start && r1->end >= r2->end;
+}
+/* True iff r1 completely contains r2 */
+static inline bool resource_contains(const struct resource *r1, const struct resource *r2)
+{
 	if (r1->flags & IORESOURCE_UNSET || r2->flags & IORESOURCE_UNSET)
 		return false;
-	return r1->start <= r2->start && r1->end >= r2->end;
+
+	return __resource_contains_unbound(r1, r2);
 }
 
 /* True if any part of r1 overlaps r2 */
diff --git a/include/linux/key-type.h b/include/linux/key-type.h
index 5caf3ce82373..1336c14138ab 100644
--- a/include/linux/key-type.h
+++ b/include/linux/key-type.h
@@ -158,6 +158,7 @@ struct key_type {
 				     const void *in, const void *in2);
 
 	/* internal fields */
+	atomic64_t		index_id;	/* Opaque keyring index ID */
 	struct list_head	link;		/* link in types list */
 	struct lock_class_key	lock_class;	/* key->sem lock class */
 } __randomize_layout;
diff --git a/include/linux/key.h b/include/linux/key.h
index 81b8f05c6898..e40b5267658f 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -107,6 +107,7 @@ struct keyring_name;
 
 struct key_tag {
 	struct rcu_head		rcu;
+	atomic64_t		index_id;	/* Opaque keyring index ID */
 	refcount_t		usage;
 	bool			removed;	/* T when subject removed */
 };
@@ -129,6 +130,8 @@ struct keyring_index_key {
 	struct key_type		*type;
 	struct key_tag		*domain_tag;	/* Domain of operation */
 	const char		*description;
+	u64			type_id;	/* Cached index IDs */
+	u64			domain_id;
 };
 
 union key_payload {
@@ -251,6 +254,8 @@ struct key {
 			struct key_type	*type;		/* type of key */
 			struct key_tag	*domain_tag;	/* Domain of operation */
 			char		*description;
+			u64		type_id;
+			u64		domain_id;
 		};
 	};
 
diff --git a/include/linux/sched.h b/include/linux/sched.h
index e20e0bd7e96b..60e893927ac8 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1764,7 +1764,7 @@ extern struct pid __rcu *cad_pid;
 						 * I am cleaning dirty pages from some other bdi. */
 #define PF_KTHREAD		0x00200000	/* I am a kernel thread */
 #define PF_RANDOMIZE		0x00400000	/* Randomize virtual address space */
-#define PF__HOLE__00800000	0x00800000
+#define PF_NO_NOTIFY_SIGNAL	0x00800000	/* see no_notify_signal_save() */
 #define PF__HOLE__01000000	0x01000000
 #define PF__HOLE__02000000	0x02000000
 #define PF_NO_SETAFFINITY	0x04000000	/* Userland is not allowed to meddle with cpus_mask */
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 6e6e72b7b362..720e617d5bd3 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_SCHED_SIGNAL_H
 #define _LINUX_SCHED_SIGNAL_H
 
+#include <linux/cleanup.h>
 #include <linux/rculist.h>
 #include <linux/signal.h>
 #include <linux/sched.h>
@@ -383,14 +384,36 @@ static inline int task_sigpending(struct task_struct *p)
 	return unlikely(test_tsk_thread_flag(p,TIF_SIGPENDING));
 }
 
+/* Prevent TIF_NOTIFY_SIGNAL from interrupting this task. */
+static inline unsigned int no_notify_signal_save(void)
+{
+	unsigned int flags = current->flags;
+
+	current->flags |= PF_NO_NOTIFY_SIGNAL;
+	return flags;
+}
+
+/* Restore the previous PF_NO_NOTIFY_SIGNAL state. */
+static inline void no_notify_signal_restore(unsigned int flags)
+{
+	current_restore_flags(flags, PF_NO_NOTIFY_SIGNAL);
+}
+
+DEFINE_LOCK_GUARD_0(no_notify_signal,
+		    _T->flags = no_notify_signal_save(),
+		    no_notify_signal_restore(_T->flags),
+		    unsigned int flags)
+
 static inline int signal_pending(struct task_struct *p)
 {
 	/*
 	 * TIF_NOTIFY_SIGNAL isn't really a signal, but it requires the same
 	 * behavior in terms of ensuring that we break out of wait loops
-	 * so that notify signal callbacks can be processed.
+	 * so that notify signal callbacks can be processed. Not for a task
+	 * that asked not to be interrupted by it, see no_notify_signal_save().
 	 */
-	if (unlikely(test_tsk_thread_flag(p, TIF_NOTIFY_SIGNAL)))
+	if (unlikely(test_tsk_thread_flag(p, TIF_NOTIFY_SIGNAL)) &&
+	    likely(!(READ_ONCE(p->flags) & PF_NO_NOTIFY_SIGNAL)))
 		return 1;
 	return task_sigpending(p);
 }
diff --git a/include/net/ax25.h b/include/net/ax25.h
index a7bba42dde15..e3c10a939594 100644
--- a/include/net/ax25.h
+++ b/include/net/ax25.h
@@ -252,6 +252,11 @@ typedef struct ax25_cb {
 	struct sk_buff_head	reseq_queue;
 	struct sk_buff_head	ack_queue;
 	struct sk_buff_head	frag_queue;
+	/* I frames numbered by ax25_kick(), waiting to go to the device */
+	struct sk_buff_head	xmit_queue;
+	/* serialises V(S)/V(A) and the write, ack and xmit queues */
+	spinlock_t		lock;
+	unsigned char		xmit_running;
 	unsigned char		window;
 	struct timer_list	timer, dtimer;
 	struct sock		*sk;		/* Backlink to socket */
@@ -306,6 +311,7 @@ static inline __be16 ax25_type_trans(struct sk_buff *skb, struct net_device *dev
 extern struct hlist_head ax25_list;
 extern spinlock_t ax25_list_lock;
 void ax25_cb_add(ax25_cb *);
+ax25_cb *ax25_cb_add_unique(ax25_cb *ax25);
 struct sock *ax25_find_listener(ax25_address *, int, struct net_device *, int);
 struct sock *ax25_get_socket(ax25_address *, ax25_address *, int);
 ax25_cb *ax25_find_cb(const ax25_address *, ax25_address *, ax25_digi *,
diff --git a/include/net/codel_impl.h b/include/net/codel_impl.h
index 78a27ac73070..b2c359c6dd1b 100644
--- a/include/net/codel_impl.h
+++ b/include/net/codel_impl.h
@@ -158,6 +158,7 @@ static struct sk_buff *codel_dequeue(void *ctx,
 	bool drop;
 
 	if (!skb) {
+		vars->first_above_time = 0;
 		vars->dropping = false;
 		return skb;
 	}
diff --git a/include/net/gso.h b/include/net/gso.h
index 29975440cad5..0749230d414e 100644
--- a/include/net/gso.h
+++ b/include/net/gso.h
@@ -19,10 +19,18 @@ struct skb_gso_cb {
 	int	encap_level;
 	__wsum	csum;
 	__u16	csum_start;
+	/* Number of IPv4/IPv6 GSO handler entries for this packet. */
+	u8	recursion_counter;
 };
 #define SKB_GSO_CB_OFFSET	32
 #define SKB_GSO_CB(skb) ((struct skb_gso_cb *)((skb)->cb + SKB_GSO_CB_OFFSET))
 
+static inline bool gso_recursion_inc_test(struct sk_buff *skb,
+					  unsigned int limit)
+{
+	return ++SKB_GSO_CB(skb)->recursion_counter > limit;
+}
+
 static inline int skb_tnl_header_len(const struct sk_buff *inner_skb)
 {
 	return (skb_mac_header(inner_skb) - inner_skb->head) -
diff --git a/include/net/netrom.h b/include/net/netrom.h
index f0565a5987d1..2b4685d52bd8 100644
--- a/include/net/netrom.h
+++ b/include/net/netrom.h
@@ -46,6 +46,7 @@ enum {
 #define	NR_COND_REJECT			0x02
 #define	NR_COND_PEER_RX_BUSY		0x04
 #define	NR_COND_OWN_RX_BUSY		0x08
+#define	NR_COND_FRAG_DISCARD		0x10
 
 #define NR_DEFAULT_T1			120000		/* Outstanding frames - 120 seconds */
 #define NR_DEFAULT_T2			5000		/* Response delay     - 5 seconds */
@@ -74,7 +75,7 @@ struct nr_sock {
 	unsigned short		vs, vr, va, vl;
 	unsigned char		n2, n2count;
 	unsigned long		t1, t2, t4, idle;
-	unsigned short		fraglen;
+	unsigned int		fraglen;
 	struct timer_list	t1timer;
 	struct timer_list	t2timer;
 	struct timer_list	t4timer;
@@ -114,7 +115,6 @@ struct nr_node {
 	unsigned char		count;
 	struct nr_route		routes[3];
 	refcount_t		refcount;
-	spinlock_t		node_lock;
 };
 
 /*********************************************************************
@@ -144,20 +144,6 @@ static __inline__ void nr_neigh_put(struct nr_neigh *nr_neigh)
 	}
 }
 
-/* nr_node_lock and nr_node_unlock also hold/put the node's refcounter.
- */
-static __inline__ void nr_node_lock(struct nr_node *nr_node)
-{
-	nr_node_hold(nr_node);
-	spin_lock_bh(&nr_node->node_lock);
-}
-
-static __inline__ void nr_node_unlock(struct nr_node *nr_node)
-{
-	spin_unlock_bh(&nr_node->node_lock);
-	nr_node_put(nr_node);
-}
-
 #define nr_neigh_for_each(__nr_neigh, list) \
 	hlist_for_each_entry(__nr_neigh, list, neigh_node)
 
diff --git a/include/net/rose.h b/include/net/rose.h
index 49140668b3dd..2fa0331e36f0 100644
--- a/include/net/rose.h
+++ b/include/net/rose.h
@@ -227,6 +227,8 @@ void rose_setup(struct net_device *);
 
 /* rose_in.c */
 int rose_process_rx_frame(struct sock *, struct sk_buff *);
+int rose_rcv_frame(struct sock *sk, struct sk_buff *skb);
+int rose_backlog_rcv(struct sock *sk, struct sk_buff *skb);
 
 /* rose_link.c */
 void rose_start_ftimer(struct rose_neigh *);
@@ -237,6 +239,8 @@ void rose_link_rx_restart(struct sk_buff *, struct rose_neigh *,
 			  unsigned short);
 void rose_transmit_clear_request(struct rose_neigh *, unsigned int,
 				 unsigned char, unsigned char);
+void rose_link_restart(struct rose_neigh *neigh);
+void rose_link_bring_up(struct rose_neigh *neigh);
 void rose_transmit_link(struct sk_buff *, struct rose_neigh *);
 
 /* rose_loopback.c */
@@ -266,6 +270,7 @@ struct rose_neigh *rose_get_neigh(rose_address *, unsigned char *,
 				  unsigned char *, int);
 int rose_rt_ioctl(unsigned int, void __user *);
 void rose_link_failed(ax25_cb *, int);
+void rose_link_restarted(struct rose_neigh *);
 int rose_route_frame(struct sk_buff *, ax25_cb *);
 void rose_rt_free(void);
 
diff --git a/io_uring/cancel.c b/io_uring/cancel.c
index 299071d28441..50ec818aa19f 100644
--- a/io_uring/cancel.c
+++ b/io_uring/cancel.c
@@ -73,7 +73,16 @@ static bool io_cancel_cb(struct io_wq_work *work, void *data)
 	struct io_kiocb *req = container_of(work, struct io_kiocb, work);
 	struct io_cancel_data *cd = data;
 
-	return io_cancel_req_match(req, cd);
+	if (!io_cancel_req_match(req, cd))
+		return false;
+	/*
+	 * Pending work is gone once it has matched. Work that is running may
+	 * park the request where the same cancellation looks next. Don't make
+	 * it skip the request as one that it has dealt with.
+	 */
+	if (cd->flags & (IORING_ASYNC_CANCEL_ALL | IORING_ASYNC_CANCEL_ANY))
+		req->cancel_seq_set = false;
+	return true;
 }
 
 static int io_async_cancel_one(struct io_uring_task *tctx,
@@ -118,6 +127,8 @@ int io_try_cancel(struct io_uring_task *tctx, struct io_cancel_data *cd,
 	 */
 	if (!ret)
 		return 0;
+	if (ret == -EALREADY)
+		cd->running = true;
 
 	ret = io_poll_cancel(ctx, cd, issue_flags);
 	if (ret != -ENOENT)
@@ -174,6 +185,7 @@ static int __io_async_cancel(struct io_cancel_data *cd,
 	struct io_tctx_node *node;
 	int ret, nr = 0;
 
+	cd->running = false;
 	do {
 		ret = io_try_cancel(tctx, cd, issue_flags);
 		if (ret == -ENOENT)
@@ -187,6 +199,9 @@ static int __io_async_cancel(struct io_cancel_data *cd,
 	io_ring_submit_lock(ctx, issue_flags);
 	ret = -ENOENT;
 	list_for_each_entry(node, &ctx->tctx_list, ctx_node) {
+		/* has been done above, don't count what is running there */
+		if (all && node->task->io_uring == tctx)
+			continue;
 		ret = io_async_cancel_one(node->task->io_uring, cd);
 		if (ret != -ENOENT) {
 			if (!all)
@@ -195,7 +210,15 @@ static int __io_async_cancel(struct io_cancel_data *cd,
 		}
 	}
 	io_ring_submit_unlock(ctx, issue_flags);
-	return all ? nr : ret;
+	if (all)
+		return nr;
+	/*
+	 * The worker may be done with the work that was found running, and
+	 * flagged, above. That isn't the same as not having found it.
+	 */
+	if (ret == -ENOENT && cd->running)
+		ret = -EALREADY;
+	return ret;
 }
 
 int io_async_cancel(struct io_kiocb *req, unsigned int issue_flags)
@@ -299,7 +322,7 @@ int io_sync_cancel(struct io_ring_ctx *ctx, void __user *arg)
 	if (ret != -EALREADY)
 		goto out;
 
-	if (sc.timeout.tv_sec != -1UL || sc.timeout.tv_nsec != -1UL) {
+	if (sc.timeout.tv_sec != -1 || sc.timeout.tv_nsec != -1) {
 		struct timespec64 ts = {
 			.tv_sec		= sc.timeout.tv_sec,
 			.tv_nsec	= sc.timeout.tv_nsec
diff --git a/io_uring/cancel.h b/io_uring/cancel.h
index 1b201a094303..e03a6fb0b7f9 100644
--- a/io_uring/cancel.h
+++ b/io_uring/cancel.h
@@ -11,6 +11,8 @@ struct io_cancel_data {
 	u8 opcode;
 	u32 flags;
 	int seq;
+	/* io_try_cancel() has found it being run by io-wq, and flagged it */
+	bool running;
 };
 
 int io_async_cancel_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe);
diff --git a/io_uring/fdinfo.c b/io_uring/fdinfo.c
index 3585ad830850..23674b0be0d0 100644
--- a/io_uring/fdinfo.c
+++ b/io_uring/fdinfo.c
@@ -125,11 +125,17 @@ static void __io_uring_show_fdinfo(struct io_ring_ctx *ctx, struct seq_file *m)
 	cq_entries = min(cq_tail - cq_head, ctx->cq_entries);
 	for (i = 0; i < cq_entries; i++) {
 		struct io_uring_cqe *cqe;
-		bool cqe32 = false;
+		bool cqe32 = false, two_entries = false;
 
-		cqe = &r->cqes[(cq_head & cq_mask)];
-		if (cqe->flags & IORING_CQE_F_32 || ctx->flags & IORING_SETUP_CQE32)
+		if (ctx->flags & IORING_SETUP_CQE32) {
+			/* all entries have twice the size */
+			cqe = &r->cqes[(cq_head & cq_mask) << 1];
 			cqe32 = true;
+		} else {
+			cqe = &r->cqes[(cq_head & cq_mask)];
+			two_entries = cqe->flags & IORING_CQE_F_32;
+			cqe32 = two_entries;
+		}
 		seq_printf(m, "%5u: user_data:%llu, res:%d, flag:%x",
 			   cq_head & cq_mask, cqe->user_data, cqe->res,
 			   cqe->flags);
@@ -138,7 +144,7 @@ static void __io_uring_show_fdinfo(struct io_ring_ctx *ctx, struct seq_file *m)
 					cqe->big_cqe[0], cqe->big_cqe[1]);
 		seq_printf(m, "\n");
 		cq_head++;
-		if (cqe32) {
+		if (two_entries) {
 			cq_head++;
 			i++;
 		}
diff --git a/io_uring/futex.c b/io_uring/futex.c
index 7f3b97c99692..6f756de08705 100644
--- a/io_uring/futex.c
+++ b/io_uring/futex.c
@@ -149,6 +149,24 @@ int io_futex_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	return 0;
 }
 
+/*
+ * A wait on a private futex does not block the submitter. Even a single
+ * threaded task can go on and have the mm private hash installed by clone()
+ * or prctl(), which does not pick up waiters from the global hash. Make
+ * sure the private hash exists before the first waiter is queued.
+ */
+static int io_futex_prep_private(struct io_kiocb *req)
+{
+	int ret = futex_hash_allocate_default();
+
+	if (unlikely(ret))
+		return ret;
+
+	/* inflight tracking only needed for mm private hash */
+	io_req_track_inflight(req);
+	return 0;
+}
+
 int io_futex_wait_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 {
 	struct io_futex *iof = io_kiocb_to_cmd(req, struct io_futex);
@@ -158,9 +176,8 @@ int io_futex_wait_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	if (unlikely(ret))
 		return ret;
 
-	/* inflight tracking only needed for mm private hash */
 	if (!(iof->futex_flags & FLAGS_SHARED))
-		io_req_track_inflight(req);
+		return io_futex_prep_private(req);
 	return 0;
 }
 
@@ -207,10 +224,13 @@ int io_futexv_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 		return ret;
 	}
 
-	/* inflight tracking only needed for mm private hash */
 	for (i = 0; i < iof->futex_nr; i++) {
 		if (!(futexv[i].w.flags & FLAGS_SHARED)) {
-			io_req_track_inflight(req);
+			ret = io_futex_prep_private(req);
+			if (ret) {
+				kfree(futexv);
+				return ret;
+			}
 			break;
 		}
 	}
@@ -278,6 +298,8 @@ int io_futexv_wait(struct io_kiocb *req, unsigned int issue_flags)
 		 */
 		__set_current_state(TASK_RUNNING);
 		hlist_add_head(&req->hash_node, &ctx->futex_list);
+		if (io_wq_cancel_seen(req, issue_flags))
+			__io_futex_cancel(req);
 	} else {
 		iof->futexv_unqueued = 1;
 		if (woken != -1)
@@ -318,6 +340,8 @@ int io_futex_wait(struct io_kiocb *req, unsigned int issue_flags)
 			       &ifd->q, NULL, NULL);
 	if (!ret) {
 		hlist_add_head(&req->hash_node, &ctx->futex_list);
+		if (io_wq_cancel_seen(req, issue_flags))
+			__io_futex_cancel(req);
 		io_ring_submit_unlock(ctx, issue_flags);
 
 		return IOU_ISSUE_SKIP_COMPLETE;
diff --git a/io_uring/io-wq.c b/io_uring/io-wq.c
index e8b8d2c1cf7f..2ed3eebd0a7b 100644
--- a/io_uring/io-wq.c
+++ b/io_uring/io-wq.c
@@ -54,6 +54,8 @@ struct io_worker {
 	struct io_wq_acct *acct;
 
 	struct io_wq_work *cur_work;
+	/* rest of the hashed chain ->cur_work was taken off the list with */
+	struct io_wq_work *next_work;
 	raw_spinlock_t lock;
 
 	struct completion ref_done;
@@ -465,11 +467,9 @@ static void io_wq_dec_running(struct io_worker *worker)
 
 	if (!atomic_dec_and_test(&acct->nr_running))
 		return;
-	if (!worker->cur_work)
-		return;
 	if (!io_acct_run_queue(acct))
 		return;
-	if (io_wq_hash_defer(worker->cur_work, acct)) {
+	if (worker->cur_work && io_wq_hash_defer(worker->cur_work, acct)) {
 		raw_spin_unlock(&acct->lock);
 		return;
 	}
@@ -581,6 +581,17 @@ static struct io_wq_work *io_get_next_work(struct io_wq_acct *acct,
 	return NULL;
 }
 
+static void __io_assign_current_work(struct io_worker *worker,
+				     struct io_wq_work *work)
+{
+	raw_spin_lock(&worker->lock);
+	worker->cur_work = work;
+	/* stays valid while in between two items of a chain */
+	if (work)
+		worker->next_work = wq_next_work(work);
+	raw_spin_unlock(&worker->lock);
+}
+
 static void io_assign_current_work(struct io_worker *worker,
 				   struct io_wq_work *work)
 {
@@ -589,9 +600,7 @@ static void io_assign_current_work(struct io_worker *worker,
 		cond_resched();
 	}
 
-	raw_spin_lock(&worker->lock);
-	worker->cur_work = work;
-	raw_spin_unlock(&worker->lock);
+	__io_assign_current_work(worker, work);
 }
 
 /*
@@ -622,9 +631,7 @@ static void io_worker_handle_work(struct io_wq_acct *acct,
 			 * work list, but isn't yet discoverable as the
 			 * current work item for this worker.
 			 */
-			raw_spin_lock(&worker->lock);
-			worker->cur_work = work;
-			raw_spin_unlock(&worker->lock);
+			__io_assign_current_work(worker, work);
 		}
 
 		raw_spin_unlock(&acct->lock);
@@ -640,21 +647,28 @@ static void io_worker_handle_work(struct io_wq_acct *acct,
 		/* handle a whole dependent link */
 		do {
 			bool do_kill = test_bit(IO_WQ_BIT_EXIT, &wq->state);
-			struct io_wq_work *next_hashed, *linked;
+			struct io_wq_work *next_hashed, *linked, *done = work;
 			unsigned int work_flags = atomic_read(&work->flags);
 			unsigned int hash = __io_wq_is_hashed(work_flags)
 				? __io_get_work_hash(work_flags)
 				: -1U;
+			bool last;
 
 			next_hashed = wq_next_work(work);
 
-			if (do_kill &&
-			    (work_flags & IO_WQ_WORK_UNBOUND))
+			/*
+			 * io_wq_exit_workers() signals us once, so that we
+			 * don't sleep for ever. If that was before this work
+			 * became the current one, the signal is gone.
+			 */
+			if (do_kill && (work_flags & IO_WQ_WORK_UNBOUND))
 				atomic_or(IO_WQ_WORK_CANCEL, &work->flags);
+			else if (do_kill)
+				set_notify_signal(current);
 			io_wq_submit_work(work);
 			io_assign_current_work(worker, NULL);
 
-			linked = io_wq_free_work(work);
+			last = io_wq_put_work(work, &linked);
 			work = next_hashed;
 			if (!work && linked && !io_wq_is_hashed(linked)) {
 				work = linked;
@@ -663,6 +677,13 @@ static void io_worker_handle_work(struct io_wq_acct *acct,
 			io_assign_current_work(worker, work);
 			if (linked)
 				io_wq_enqueue(wq, linked);
+			/*
+			 * Not before the link is current or pending work again.
+			 * This may be the last time that a task is woken up
+			 * which exits and looks for requests to cancel.
+			 */
+			if (last)
+				io_wq_free_work(done);
 
 			if (hash != -1U && !next_hashed) {
 				/* serialize hash clear with wake_up() */
@@ -681,6 +702,35 @@ static void io_worker_handle_work(struct io_wq_acct *acct,
 	} while (1);
 }
 
+/*
+ * The worker has decided to exit, and has given up its ->nr_workers slot and
+ * its place on the free list. io_wq_enqueue() may have picked it from that
+ * list, or seen it running, after it last looked at the work list. Leave
+ * ->nr_running as well and check again. Returns false if the worker has to
+ * stay.
+ */
+static bool io_worker_retire(struct io_wq_acct *acct, struct io_worker *worker)
+{
+	/* turns io_wq_dec_running() and the scheduler hooks into no-ops */
+	clear_bit(IO_WORKER_F_UP, &worker->flags);
+	atomic_dec(&acct->nr_running);
+	if (!io_acct_run_queue(acct))
+		return true;
+	raw_spin_unlock(&acct->lock);
+
+	raw_spin_lock(&acct->workers_lock);
+	if (acct->nr_workers >= acct->max_workers) {
+		/* a worker was created in our place, the work is its business */
+		raw_spin_unlock(&acct->workers_lock);
+		return true;
+	}
+	acct->nr_workers++;
+	raw_spin_unlock(&acct->workers_lock);
+	atomic_inc(&acct->nr_running);
+	set_bit(IO_WORKER_F_UP, &worker->flags);
+	return false;
+}
+
 static int io_wq_worker(void *data)
 {
 	struct io_worker *worker = data;
@@ -714,19 +764,41 @@ static int io_wq_worker(void *data)
 		 * idle-exit, drop the worker as well. This is used to avoid
 		 * keeping io-wq workers around for tasks that no longer have
 		 * any active io_uring instances.
+		 * Not as long as a request of ours for another worker is
+		 * pending, though. It is accounted as a running worker, which
+		 * others rely on, and io_worker_exit() would cancel it.
 		 */
-		if ((last_timeout && (exit_mask || acct->nr_workers > 1)) ||
-		    test_bit(IO_WQ_BIT_EXIT_ON_IDLE, &wq->state)) {
+		if (((last_timeout && (exit_mask || acct->nr_workers > 1)) ||
+		     test_bit(IO_WQ_BIT_EXIT_ON_IDLE, &wq->state)) &&
+		    !test_bit(0, &worker->create_state)) {
 			acct->nr_workers--;
+			if (test_and_clear_bit(IO_WORKER_F_FREE, &worker->flags))
+				hlist_nulls_del_init_rcu(&worker->nulls_node);
 			raw_spin_unlock(&acct->workers_lock);
 			__set_current_state(TASK_RUNNING);
-			break;
+			if (io_worker_retire(acct, worker))
+				break;
+			last_timeout = false;
+			continue;
 		}
 		last_timeout = false;
 		__io_worker_idle(acct, worker);
 		raw_spin_unlock(&acct->workers_lock);
 		if (io_run_task_work())
 			continue;
+		/*
+		 * io_wq_enqueue() leaves new work to us for as long as we are
+		 * accounted as running. Get out of ->nr_running before taking
+		 * the last look at the work list, rather than when scheduling
+		 * out. No need to ask for another worker then, we can do it.
+		 */
+		clear_bit(IO_WORKER_F_RUNNING, &worker->flags);
+		atomic_dec(&acct->nr_running);
+		if (io_acct_run_queue(acct)) {
+			io_wq_worker_running(current);
+			io_worker_handle_work(acct, worker);
+			continue;
+		}
 		ret = schedule_timeout(WORKER_IDLE_TIMEOUT);
 		if (signal_pending(current)) {
 			struct ksignal ksig;
@@ -994,9 +1066,13 @@ void io_wq_set_exit_on_idle(struct io_wq *wq, bool enable)
 static void io_run_cancel(struct io_wq_work *work, struct io_wq *wq)
 {
 	do {
+		struct io_wq_work *linked;
+
 		atomic_or(IO_WQ_WORK_CANCEL, &work->flags);
 		io_wq_submit_work(work);
-		work = io_wq_free_work(work);
+		if (io_wq_put_work(work, &linked))
+			io_wq_free_work(work);
+		work = linked;
 	} while (work);
 }
 
@@ -1104,6 +1180,7 @@ static bool __io_wq_worker_cancel(struct io_worker *worker,
 static bool io_wq_worker_cancel(struct io_worker *worker, void *data)
 {
 	struct io_cb_cancel_data *match = data;
+	struct io_wq_work *work;
 
 	/*
 	 * Hold the lock to avoid ->cur_work going out of scope, caller
@@ -1112,6 +1189,19 @@ static bool io_wq_worker_cancel(struct io_worker *worker, void *data)
 	raw_spin_lock(&worker->lock);
 	if (__io_wq_worker_cancel(worker, match, worker->cur_work))
 		match->nr_running++;
+	/*
+	 * Hashed work is taken off the work list a chain at a time, what the
+	 * worker hasn't started yet can only be found here. It doesn't move on
+	 * without the lock. Just mark the work, it fails once it is its turn.
+	 */
+	for (work = worker->next_work; work; work = wq_next_work(work)) {
+		if (match->nr_running && !match->cancel_all)
+			break;
+		if (match->fn(work, match->data)) {
+			atomic_or(IO_WQ_WORK_CANCEL, &work->flags);
+			match->nr_running++;
+		}
+	}
 	raw_spin_unlock(&worker->lock);
 
 	return match->nr_running && !match->cancel_all;
@@ -1320,6 +1410,8 @@ static bool io_task_work_match(struct callback_head *cb, void *data)
 void io_wq_exit_start(struct io_wq *wq)
 {
 	set_bit(IO_WQ_BIT_EXIT, &wq->state);
+	/* Pairs with task_work_add() in io_queue_worker_create(). */
+	smp_mb__after_atomic();
 }
 
 static void io_wq_cancel_tw_create(struct io_wq *wq)
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 668662b74d73..04a90824c190 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -48,6 +48,7 @@
 #include <linux/uio.h>
 #include <linux/bits.h>
 
+#include <linux/sched/rt.h>
 #include <linux/sched/signal.h>
 #include <linux/fs.h>
 #include <linux/file.h>
@@ -466,17 +467,46 @@ static void io_prep_async_link(struct io_kiocb *req)
 	}
 }
 
+/* Called for every request that is issued: keep it inline */
+static __always_inline bool io_assign_file(struct io_kiocb *req,
+					   const struct io_issue_def *def,
+					   unsigned int issue_flags)
+{
+	if (req->file || !def->needs_file)
+		return true;
+
+	if (req->flags & REQ_F_FIXED_FILE)
+		req->file = io_file_get_fixed(req, req->cqe.fd, issue_flags);
+	else
+		req->file = io_file_get_normal(req, req->cqe.fd);
+
+	return !!req->file;
+}
+
 static void io_queue_iowq(struct io_kiocb *req)
 {
 	struct io_uring_task *tctx = req->tctx;
 
 	BUG_ON(!tctx);
+	lockdep_assert_held(&req->ctx->uring_lock);
 
 	if ((current->flags & PF_KTHREAD) || !tctx->io_wq) {
 		io_req_task_queue_fail(req, -ECANCELED);
 		return;
 	}
 
+	/*
+	 * The file is looked up as late as possible, as it may be the result
+	 * of an earlier request of the link. This one is up now, and what kind
+	 * of work it is depends on the file. If that fails, leave the error
+	 * handling to the worker.
+	 *
+	 * Not for a splice: whatever it writes to, it may wait for its input
+	 * for ever. It has to remain unbound work that isn't hashed.
+	 */
+	if (req->opcode != IORING_OP_SPLICE)
+		io_assign_file(req, &io_issue_defs[req->opcode], 0);
+
 	/* init ->work of the whole link before punting */
 	io_prep_async_link(req);
 
@@ -515,12 +545,15 @@ unsigned io_linked_nr(struct io_kiocb *req)
 	return nr;
 }
 
-static __cold noinline void io_queue_deferred(struct io_ring_ctx *ctx)
+static __cold noinline bool io_queue_deferred(struct io_ring_ctx *ctx)
 {
-	bool drain_seen = false, first = true;
+	bool drain_seen = false, first = true, drain_queued = false;
 
 	lockdep_assert_held(&ctx->uring_lock);
 	__io_req_caches_free(ctx);
+	/* nothing outside of ->defer_list is alive */
+	if (ctx->nr_req_allocated == ctx->nr_drained)
+		ctx->drain_req = NULL;
 
 	while (!list_empty(&ctx->defer_list)) {
 		struct io_defer_entry *de = list_first_entry(&ctx->defer_list,
@@ -528,14 +561,21 @@ static __cold noinline void io_queue_deferred(struct io_ring_ctx *ctx)
 
 		drain_seen |= de->req->flags & REQ_F_IO_DRAIN;
 		if ((drain_seen || first) && ctx->nr_req_allocated != ctx->nr_drained)
-			return;
+			return drain_queued;
 
 		list_del_init(&de->list);
 		ctx->nr_drained -= io_linked_nr(de->req);
+		if (de->req->flags & REQ_F_IO_DRAIN) {
+			drain_queued = true;
+			/* it runs alone, track its completion unless it's a link */
+			if (!de->req->link)
+				ctx->drain_req = de->req;
+		}
 		io_req_task_queue(de->req);
 		kfree(de);
 		first = false;
 	}
+	return drain_queued;
 }
 
 void __io_commit_cqring_flush(struct io_ring_ctx *ctx)
@@ -780,6 +820,13 @@ bool io_cqe_cache_refill(struct io_ring_ctx *ctx, bool overflow, bool cqe32)
 	if (!overflow && (ctx->check_cq & BIT(IO_CHECK_CQ_OVERFLOW_BIT)))
 		return false;
 
+	/*
+	 * A single entry may be left if a 32b CQE is asked for. It must not be
+	 * handed out later on if this fails, as the CQE is going to overflow.
+	 */
+	ctx->cqe_cached = NULL;
+	ctx->cqe_sentinel = NULL;
+
 	/*
 	 * Post dummy CQE if a 32b CQE is needed and there's only room for a
 	 * 16b CQE before the ring wraps.
@@ -974,9 +1021,11 @@ static void io_req_complete_post(struct io_kiocb *req, unsigned issue_flags)
 
 	/*
 	 * Handle special CQ sync cases via task_work. DEFER_TASKRUN requires
-	 * the submitter task context, IOPOLL protects with uring_lock.
+	 * the submitter task context, IOPOLL protects with uring_lock. A drain
+	 * request ends the drain under uring_lock as its CQE is posted.
 	 */
-	if (ctx->lockless_cq || (req->flags & REQ_F_REISSUE)) {
+	if (ctx->lockless_cq ||
+	    (req->flags & (REQ_F_REISSUE | REQ_F_IO_DRAIN))) {
 defer_complete:
 		req->io_task_work.func = io_req_task_complete;
 		io_req_task_work_add(req);
@@ -1219,6 +1268,37 @@ static void io_ctx_mark_taskrun(struct io_ring_ctx *ctx)
 	}
 }
 
+static void io_poll_wq_wake_rcu(struct rcu_head *rcu)
+{
+	struct io_ring_ctx *ctx = container_of(rcu, struct io_ring_ctx,
+					       poll_wq_rcu);
+
+	atomic_set(&ctx->poll_wq_rcu_pending, 0);
+	io_poll_wq_wake(ctx);
+	percpu_ref_put(&ctx->refs);
+}
+
+/*
+ * io_uring_poll() reports pending local work as EPOLLIN, as it takes a trip to
+ * the kernel to turn it into CQEs. Let those know who are asleep already.
+ */
+static void io_local_work_wake_poll(struct io_ring_ctx *ctx, unsigned int flags)
+{
+	if (!(flags & IOU_F_TWQ_IN_WAKE)) {
+		io_poll_wq_wake(ctx);
+		return;
+	}
+	/*
+	 * Called from a wake up handler with some wait queue lock held, this
+	 * one could lead back to it. Do it from a clean context.
+	 */
+	if (!wq_has_sleeper(&ctx->poll_wq) ||
+	    atomic_xchg(&ctx->poll_wq_rcu_pending, 1))
+		return;
+	percpu_ref_get(&ctx->refs);
+	call_rcu_hurry(&ctx->poll_wq_rcu, io_poll_wq_wake_rcu);
+}
+
 static void io_req_local_work_add(struct io_kiocb *req, unsigned flags)
 {
 	struct io_ring_ctx *ctx = req->ctx;
@@ -1276,6 +1356,9 @@ static void io_req_local_work_add(struct io_kiocb *req, unsigned flags)
 		io_ctx_mark_taskrun(ctx);
 		if (ctx->has_evfd)
 			io_eventfd_signal(ctx, false, flags & IOU_F_TWQ_IN_WAKE);
+		/* whoever sets the flag wakes ->poll_wq afterwards */
+		if (ctx->poll_activated)
+			io_local_work_wake_poll(ctx, flags);
 	}
 
 	nr_wait = atomic_read(&ctx->cq_wait_nr);
@@ -1541,11 +1624,33 @@ static void io_free_batch_list(struct io_ring_ctx *ctx,
 	} while (node);
 }
 
+/*
+ * The dispatched drain request ran alone, and anything submitted after it was
+ * deferred. Once it completed, new requests may run if nothing is waiting.
+ */
+static __cold bool io_drain_req_completed(struct io_ring_ctx *ctx)
+{
+	struct io_wq_work_node *node;
+
+	__wq_list_for_each(node, &ctx->submit_state.compl_reqs) {
+		struct io_kiocb *req = container_of(node, struct io_kiocb,
+					    comp_list);
+
+		/* a requeued request hasn't completed */
+		if (req == ctx->drain_req && !(req->flags & REQ_F_REISSUE)) {
+			ctx->drain_req = NULL;
+			return true;
+		}
+	}
+	return false;
+}
+
 void __io_submit_flush_completions(struct io_ring_ctx *ctx)
 	__must_hold(&ctx->uring_lock)
 {
 	struct io_submit_state *state = &ctx->submit_state;
 	struct io_wq_work_node *node;
+	bool drain_done = false;
 
 	__io_cq_lock(ctx);
 	__wq_list_for_each(node, &state->compl_reqs) {
@@ -1567,13 +1672,21 @@ void __io_submit_flush_completions(struct io_ring_ctx *ctx)
 	}
 	__io_cq_unlock_post(ctx);
 
+	if (unlikely(ctx->drain_active) && ctx->drain_req)
+		drain_done = io_drain_req_completed(ctx);
+
 	if (!wq_list_empty(&state->compl_reqs)) {
 		io_free_batch_list(ctx, state->compl_reqs.first);
 		INIT_WQ_LIST(&state->compl_reqs);
 	}
 
-	if (unlikely(ctx->drain_active))
-		io_queue_deferred(ctx);
+	if (unlikely(ctx->drain_active)) {
+		/* a drain request started from the list keeps the drain going */
+		if (io_queue_deferred(ctx))
+			drain_done = false;
+		if (drain_done && list_empty(&ctx->defer_list))
+			ctx->drain_active = false;
+	}
 
 	ctx->submit_state.cq_flush = false;
 }
@@ -1789,20 +1902,6 @@ static __cold void io_drain_req(struct io_kiocb *req)
 		ctx->drain_active = false;
 }
 
-static bool io_assign_file(struct io_kiocb *req, const struct io_issue_def *def,
-			   unsigned int issue_flags)
-{
-	if (req->file || !def->needs_file)
-		return true;
-
-	if (req->flags & REQ_F_FIXED_FILE)
-		req->file = io_file_get_fixed(req, req->cqe.fd, issue_flags);
-	else
-		req->file = io_file_get_normal(req, req->cqe.fd);
-
-	return !!req->file;
-}
-
 #define REQ_ISSUE_SLOW_FLAGS	(REQ_F_CREDS | REQ_F_ARM_LTIMEOUT)
 
 static inline int __io_issue_sqe(struct io_kiocb *req,
@@ -1849,6 +1948,9 @@ static int io_issue_sqe(struct io_kiocb *req, unsigned int issue_flags)
 	ret = __io_issue_sqe(req, issue_flags, def);
 
 	if (ret == IOU_COMPLETE) {
+		/* not all handlers take care of the internal restart codes */
+		if (unlikely(req->cqe.res <= -ERESTARTSYS))
+			req->cqe.res = io_fixup_restart_res(req->cqe.res);
 		if (issue_flags & IO_URING_F_COMPLETE_DEFER)
 			io_req_complete_defer(req);
 		else
@@ -1864,6 +1966,8 @@ static int io_issue_sqe(struct io_kiocb *req, unsigned int issue_flags)
 		if ((req->ctx->flags & IORING_SETUP_IOPOLL) && def->iopoll_queue)
 			io_iopoll_req_issued(req, issue_flags);
 	}
+	if (unlikely(ret <= -ERESTARTSYS))
+		ret = io_fixup_restart_res(ret);
 	return ret;
 }
 
@@ -1886,17 +1990,30 @@ int io_poll_issue(struct io_kiocb *req, io_tw_token_t tw)
 	return ret;
 }
 
-struct io_wq_work *io_wq_free_work(struct io_wq_work *work)
+/*
+ * io-wq is done with @work. Returns true if it held the last reference, and
+ * hands out the next request of the link then. The caller has to make sure
+ * that cancellations can find the latter before it calls io_wq_free_work().
+ */
+bool io_wq_put_work(struct io_wq_work *work, struct io_wq_work **linked)
 {
 	struct io_kiocb *req = container_of(work, struct io_kiocb, work);
 	struct io_kiocb *nxt = NULL;
 
-	if (req_ref_put_and_test_atomic(req)) {
-		if (req->flags & IO_REQ_LINK_FLAGS)
-			nxt = io_req_find_next(req);
-		io_free_req(req);
-	}
-	return nxt ? &nxt->work : NULL;
+	*linked = NULL;
+	if (!req_ref_put_and_test_atomic(req))
+		return false;
+
+	if (req->flags & IO_REQ_LINK_FLAGS)
+		nxt = io_req_find_next(req);
+	if (nxt)
+		*linked = &nxt->work;
+	return true;
+}
+
+void io_wq_free_work(struct io_wq_work *work)
+{
+	io_free_req(container_of(work, struct io_kiocb, work));
 }
 
 void io_wq_submit_work(struct io_wq_work *work)
@@ -1907,7 +2024,7 @@ void io_wq_submit_work(struct io_wq_work *work)
 	bool needs_poll = false;
 	int ret = 0, err = -ECANCELED;
 
-	/* one will be dropped by io_wq_free_work() after returning to io-wq */
+	/* one will be dropped by io_wq_put_work() after returning to io-wq */
 	if (!(req->flags & REQ_F_REFCOUNT))
 		__io_req_set_refcount(req, 2);
 	else
@@ -2478,7 +2595,8 @@ static int io_wake_function(struct wait_queue_entry *curr, unsigned int mode,
 	 */
 	if (io_should_wake(iowq) || io_has_work(iowq->ctx))
 		return autoremove_wake_function(curr, mode, wake_flags, key);
-	return -1;
+	/* keep going, a waiter further down may be content with less */
+	return 0;
 }
 
 int io_run_task_work_sig(struct io_ring_ctx *ctx)
@@ -2528,9 +2646,16 @@ static enum hrtimer_restart io_cqring_min_timer_wakeup(struct hrtimer *timer)
 	if (iowq->timeout == KTIME_MAX ||
 	    ktime_compare(iowq->min_timeout, iowq->timeout) >= 0)
 		goto out_wake;
-	/* work we may need to run, wake function will see if we need to wake */
-	if (io_has_work(ctx))
-		goto out_wake;
+	/*
+	 * Work we need to run. It isn't known if that is going to post a CQE,
+	 * so this isn't a timeout. Carry on with the normal one if it doesn't.
+	 */
+	if (io_has_work(ctx)) {
+		iowq->min_timeout = 0;
+		iowq->cq_tail = iowq->cq_min_tail + 1;
+		wake_up_process(iowq->wq.private);
+		return HRTIMER_NORESTART;
+	}
 	/* got events since we started waiting, min timeout is done */
 	scoped_guard(rcu) {
 		struct io_rings *rings = io_get_rings(ctx);
@@ -2564,23 +2689,32 @@ static enum hrtimer_restart io_cqring_min_timer_wakeup(struct hrtimer *timer)
 	return io_cqring_timer_wakeup(timer);
 }
 
+/* Same policy as for hrtimer sleepers, see __hrtimer_setup_sleeper(). */
+static enum hrtimer_mode io_cqring_timer_mode(void)
+{
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && rt_or_dl_task_policy(current))
+		return HRTIMER_MODE_ABS_HARD;
+	return HRTIMER_MODE_ABS;
+}
+
 static int io_cqring_schedule_timeout(struct io_wait_queue *iowq,
 				      clockid_t clock_id, ktime_t start_time)
 {
+	enum hrtimer_mode mode = io_cqring_timer_mode();
 	ktime_t timeout;
 
 	if (iowq->min_timeout) {
 		timeout = ktime_add_ns(iowq->min_timeout, start_time);
 		hrtimer_setup_on_stack(&iowq->t, io_cqring_min_timer_wakeup, clock_id,
-				       HRTIMER_MODE_ABS);
+				       mode);
 	} else {
 		timeout = iowq->timeout;
 		hrtimer_setup_on_stack(&iowq->t, io_cqring_timer_wakeup, clock_id,
-				       HRTIMER_MODE_ABS);
+				       mode);
 	}
 
 	hrtimer_set_expires_range_ns(&iowq->t, timeout, 0);
-	hrtimer_start_expires(&iowq->t, HRTIMER_MODE_ABS);
+	hrtimer_start_expires(&iowq->t, mode);
 
 	if (!READ_ONCE(iowq->hit_timeout))
 		schedule();
@@ -2749,9 +2883,18 @@ static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events, u32 flags,
 
 		check_cq = READ_ONCE(ctx->check_cq);
 		if (unlikely(check_cq)) {
-			/* let the caller flush overflows, retry */
-			if (check_cq & BIT(IO_CHECK_CQ_OVERFLOW_BIT))
+			if (check_cq & BIT(IO_CHECK_CQ_OVERFLOW_BIT)) {
 				io_cqring_do_overflow_flush(ctx);
+				/*
+				 * No room for what has overflown. It takes the
+				 * application to change that, so return to it.
+				 */
+				if (test_bit(IO_CHECK_CQ_OVERFLOW_BIT,
+					     &ctx->check_cq)) {
+					ret = 0;
+					break;
+				}
+			}
 			if (check_cq & BIT(IO_CHECK_CQ_DROPPED_BIT)) {
 				ret = -EBADR;
 				break;
@@ -2981,6 +3124,7 @@ struct io_tctx_exit {
 	struct callback_head		task_work;
 	struct completion		completion;
 	struct io_ring_ctx		*ctx;
+	bool				in_cancel;
 };
 
 static __cold void io_tctx_exit_cb(struct callback_head *cb)
@@ -2995,7 +3139,8 @@ static __cold void io_tctx_exit_cb(struct callback_head *cb)
 	 * tctx can be NULL if the queueing of this task_work raced with
 	 * work cancelation off the exec path.
 	 */
-	if (tctx && !atomic_read(&tctx->in_cancel))
+	work->in_cancel = tctx && atomic_read(&tctx->in_cancel);
+	if (tctx && !work->in_cancel)
 		io_uring_del_tctx_node((unsigned long)work->ctx);
 	complete(&work->completion);
 }
@@ -3088,6 +3233,14 @@ static __cold void io_ring_exit_work(struct work_struct *work)
 		 * wait is marked as interruptible.
 		 */
 		wait_for_completion_interruptible(&exit.completion);
+		/*
+		 * The task removes the node when it is done with its
+		 * cancellation. Give it the time for that: it doesn't get back
+		 * to it as long as it finds new task_work each time it has run
+		 * the old one, and we may be one of many who send it.
+		 */
+		if (exit.in_cancel)
+			schedule_timeout_idle(HZ / 20);
 		mutex_lock(&ctx->uring_lock);
 	}
 	mutex_unlock(&ctx->uring_lock);
diff --git a/io_uring/io_uring.h b/io_uring/io_uring.h
index 36918faff5af..922bdf68aec8 100644
--- a/io_uring/io_uring.h
+++ b/io_uring/io_uring.h
@@ -185,7 +185,8 @@ int io_do_iopoll(struct io_ring_ctx *ctx, bool force_nonspin);
 __cold void io_iopoll_try_reap_events(struct io_ring_ctx *ctx);
 void __io_submit_flush_completions(struct io_ring_ctx *ctx);
 
-struct io_wq_work *io_wq_free_work(struct io_wq_work *work);
+bool io_wq_put_work(struct io_wq_work *work, struct io_wq_work **linked);
+void io_wq_free_work(struct io_wq_work *work);
 void io_wq_submit_work(struct io_wq_work *work);
 
 void io_free_req(struct io_kiocb *req);
@@ -333,6 +334,24 @@ static inline void io_req_set_res32(struct io_kiocb *req, s32 res, u32 cflags,
 	req->big_cqe.extra2 = extra2;
 }
 
+static inline ssize_t io_fixup_restart_res(ssize_t ret)
+{
+	switch (ret) {
+	case -ERESTARTSYS:
+	case -ERESTARTNOINTR:
+	case -ERESTARTNOHAND:
+	case -ERESTART_RESTARTBLOCK:
+		/*
+		 * We can't just restart the syscall, since previously
+		 * submitted sqes may already be in progress. Just fail
+		 * this IO with EINTR.
+		 */
+		return -EINTR;
+	default:
+		return ret;
+	}
+}
+
 static inline void *io_uring_alloc_async_data(struct io_alloc_cache *cache,
 					      struct io_kiocb *req)
 {
@@ -395,6 +414,29 @@ static inline void io_ring_submit_lock(struct io_ring_ctx *ctx,
 	lockdep_assert_held(&ctx->uring_lock);
 }
 
+/*
+ * For a handler that is run by io-wq and parks the request on a list where
+ * cancellations find it, rather than completing it. Whoever tried to cancel
+ * the request before that found it running. It has flagged the work item,
+ * has searched the list in vain, and won't come back. To be called with
+ * the lock the search takes held: if the search came first, the flag is
+ * visible. For most lists that is ->uring_lock, timeouts use ->timeout_lock.
+ */
+static inline bool __io_wq_cancel_seen(struct io_kiocb *req,
+				       unsigned int issue_flags)
+{
+	return (issue_flags & IO_URING_F_IOWQ) &&
+	       (atomic_read(&req->work.flags) & IO_WQ_WORK_CANCEL);
+}
+
+static inline bool io_wq_cancel_seen(struct io_kiocb *req,
+				     unsigned int issue_flags)
+{
+	lockdep_assert_held(&req->ctx->uring_lock);
+
+	return __io_wq_cancel_seen(req, issue_flags);
+}
+
 static inline void io_commit_cqring(struct io_ring_ctx *ctx)
 {
 	/* order cqe stores with ring update */
diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
index 9b9f0d369847..e1f4ee872740 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -203,7 +203,7 @@ static struct io_br_sel io_ring_buffer_select(struct io_kiocb *req, size_t *len,
 	if (unlikely(tail == head))
 		return sel;
 
-	if (head + 1 == tail)
+	if ((__u16)(head + 1) == tail)
 		req->flags |= REQ_F_BL_EMPTY;
 
 	buf = io_ring_head_to_buf(br, head, bl->mask);
diff --git a/io_uring/napi.c b/io_uring/napi.c
index 8d68366a4b90..45180b172bec 100644
--- a/io_uring/napi.c
+++ b/io_uring/napi.c
@@ -6,7 +6,7 @@
 #ifdef CONFIG_NET_RX_BUSY_POLL
 
 /* Timeout for cleanout of stale entries. */
-#define NAPI_TIMEOUT		(60 * SEC_CONVERSION)
+#define NAPI_TIMEOUT		(60 * HZ)
 
 struct io_napi_entry {
 	unsigned int		napi_id;
@@ -365,6 +365,8 @@ void __io_napi_busy_loop(struct io_ring_ctx *ctx, struct io_wait_queue *iowq)
 	if (iowq->timeout != KTIME_MAX) {
 		ktime_t dt = ktime_sub(iowq->timeout, io_get_time(ctx));
 
+		/* an absolute timeout may have passed already */
+		dt = max_t(ktime_t, dt, 0);
 		iowq->napi_busy_poll_dt = min_t(u64, iowq->napi_busy_poll_dt, dt);
 	}
 
diff --git a/io_uring/net.c b/io_uring/net.c
index 455a191c9db4..163ded47602d 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -498,6 +498,24 @@ static int io_bundle_nbufs(struct io_async_msghdr *kmsg, int ret)
 	return nbufs;
 }
 
+/*
+ * A receive that is retried after a partial transfer keeps writing to what it
+ * has mapped. io_net_kbuf_recyle() only commits what was filled so far, which
+ * takes a buffer out of circulation if it's a single one that is consumed as a
+ * whole. The tail of an incrementally consumed buffer, or the yet unused
+ * buffers of a bundle, would be up for grabs. They can't be committed in
+ * advance either, the CQE has no way to tell if they end up not being used.
+ */
+static bool io_net_kbuf_can_retry(struct io_kiocb *req,
+				  struct io_buffer_list *bl,
+				  struct io_async_msghdr *kmsg)
+{
+	/* not ring provided, or committed at selection time */
+	if (!(req->flags & REQ_F_BUFFERS_COMMIT))
+		return true;
+	return !(bl->flags & IOBL_INC) && iter_is_ubuf(&kmsg->msg.msg_iter);
+}
+
 static int io_net_kbuf_recyle(struct io_kiocb *req, struct io_buffer_list *bl,
 			      struct io_async_msghdr *kmsg, int len)
 {
@@ -1089,7 +1107,8 @@ int io_recvmsg(struct io_kiocb *req, unsigned int issue_flags)
 			io_kbuf_recycle(req, sel.buf_list, issue_flags);
 			return IOU_RETRY;
 		}
-		if (ret > 0 && io_net_retry(sock, flags)) {
+		if (ret > 0 && io_net_retry(sock, flags) &&
+		    io_net_kbuf_can_retry(req, sel.buf_list, kmsg)) {
 			sr->done_io += ret;
 			return io_net_kbuf_recyle(req, sel.buf_list, kmsg, ret);
 		}
@@ -1176,6 +1195,8 @@ static int io_recv_buf_select(struct io_kiocb *req, struct io_async_msghdr *kmsg
 		*sel = io_buffer_select(req, &len, sr->buf_group, issue_flags);
 		if (!sel->addr)
 			return -ENOBUFS;
+		/* ring provided buffers can be up to 4G, keep len an int */
+		len = min_t(size_t, len, MAX_RW_COUNT);
 		sr->buf = sel->addr;
 		sr->len = len;
 map_ubuf:
@@ -1238,7 +1259,8 @@ int io_recv(struct io_kiocb *req, unsigned int issue_flags)
 			io_kbuf_recycle(req, sel.buf_list, issue_flags);
 			return IOU_RETRY;
 		}
-		if (ret > 0 && io_net_retry(sock, flags)) {
+		if (ret > 0 && io_net_retry(sock, flags) &&
+		    io_net_kbuf_can_retry(req, sel.buf_list, kmsg)) {
 			sr->len -= ret;
 			sr->buf += ret;
 			sr->done_io += ret;
diff --git a/io_uring/openclose.c b/io_uring/openclose.c
index 606ce0664e6a..a7ad98952d0a 100644
--- a/io_uring/openclose.c
+++ b/io_uring/openclose.c
@@ -366,13 +366,16 @@ static int io_pipe_fixed(struct io_kiocb *req, struct file **files,
 	fds[1] = alloc_slot ? ret : slot - 1;
 	files[1] = NULL;
 
-	io_ring_submit_unlock(ctx, issue_flags);
-
-	if (!copy_to_user(p->fds, fds, sizeof(fds)))
+	/*
+	 * Hang on to the lock. If this fails, the slots have to be cleared, and
+	 * they must still hold what was put there.
+	 */
+	if (!copy_to_user(p->fds, fds, sizeof(fds))) {
+		io_ring_submit_unlock(ctx, issue_flags);
 		return 0;
+	}
 
 	ret = -EFAULT;
-	io_ring_submit_lock(ctx, issue_flags);
 err:
 	if (fds[0] != -1)
 		io_fixed_fd_remove(ctx, fds[0]);
diff --git a/io_uring/poll.c b/io_uring/poll.c
index f122a0070155..48381f0cbe32 100644
--- a/io_uring/poll.c
+++ b/io_uring/poll.c
@@ -223,12 +223,14 @@ static inline void io_poll_execute(struct io_kiocb *req, int res,
  */
 static int io_poll_check_events(struct io_kiocb *req, io_tw_token_t tw)
 {
+	bool again;
 	int v;
 
 	if (unlikely(tw.cancel))
 		return -ECANCELED;
 
 	do {
+		again = false;
 		v = atomic_read(&req->poll_refs);
 
 		if (unlikely(v != 1)) {
@@ -290,9 +292,15 @@ static int io_poll_check_events(struct io_kiocb *req, io_tw_token_t tw)
 		} else {
 			int ret;
 
-			/* multiple refs and HUP, ensure we loop once more */
-			if ((req->cqe.res & (POLLHUP | POLLRDHUP)) && v != 1)
-				v--;
+			/*
+			 * Multiple refs and HUP, ensure we loop once more. Drop
+			 * down to one ref now, so the next pass ends unless a
+			 * wake up came in.
+			 */
+			if ((req->cqe.res & (POLLHUP | POLLRDHUP)) && v != 1) {
+				atomic_sub(v - 1, &req->poll_refs);
+				again = true;
+			}
 
 			ret = io_poll_issue(req, tw);
 			if (ret == IOU_COMPLETE)
@@ -310,7 +318,8 @@ static int io_poll_check_events(struct io_kiocb *req, io_tw_token_t tw)
 		 * Release all references, retry if someone tried to restart
 		 * task_work while we were executing it.
 		 */
-	} while (atomic_sub_return(v, &req->poll_refs) & IO_POLL_REF_MASK);
+		v &= IO_POLL_REF_MASK;
+	} while (again || atomic_cmpxchg(&req->poll_refs, v, 0) != v);
 
 	io_napi_add(req);
 	return IOU_POLL_NO_ACTION;
@@ -614,6 +623,18 @@ static int __io_arm_poll_handler(struct io_kiocb *req,
 
 	io_poll_add_hash(req, issue_flags);
 
+	/*
+	 * Whoever tried to cancel the request while io-wq was running it has
+	 * flagged the work item. If it searched the hash table before the
+	 * request got there it found nothing, and it won't come back. Both
+	 * the search and the insertion are done with ->uring_lock held, and
+	 * the flag is set before the search. If the search came first,
+	 * the flag is visible by now.
+	 */
+	if (ipt->owning &&
+	    (atomic_read(&req->work.flags) & IO_WQ_WORK_CANCEL))
+		io_poll_mark_cancelled(req);
+
 	if (mask && (poll->events & EPOLLET) &&
 	    io_poll_can_finish_inline(req, ipt)) {
 		__io_poll_execute(req, mask, 0);
@@ -903,6 +924,15 @@ int io_poll_add(struct io_kiocb *req, unsigned int issue_flags)
 
 	ipt.pt._qproc = io_poll_queue_proc;
 
+	/*
+	 * A poll update or a spurious wake up arms the request again. Forget
+	 * the entries of the previous round like io_arm_apoll() does, a stale
+	 * second entry would be taken for a third wait queue.
+	 */
+	if (req_has_async_data(req))
+		io_req_async_data_free(req);
+	req->flags &= ~(REQ_F_SINGLE_POLL | REQ_F_DOUBLE_POLL);
+
 	ret = __io_arm_poll_handler(req, poll, &ipt, poll->events, issue_flags);
 	if (ret > 0) {
 		io_req_set_res(req, ipt.result_mask, 0);
diff --git a/io_uring/register.c b/io_uring/register.c
index 741cd294773e..de49874e8502 100644
--- a/io_uring/register.c
+++ b/io_uring/register.c
@@ -406,6 +406,7 @@ static int io_register_resize_rings(struct io_ring_ctx *ctx, void __user *arg)
 	size_t size, sq_array_offset;
 	unsigned i, tail, old_head;
 	struct io_uring_params p;
+	bool cqe32_tail = false;
 	int ret;
 
 	/* limited to DEFER_TASKRUN for now */
@@ -514,7 +515,7 @@ static int io_register_resize_rings(struct io_ring_ctx *ctx, void __user *arg)
 	old_head = READ_ONCE(o.rings->sq.head);
 	if (tail - old_head > p.sq_entries)
 		goto overflow;
-	for (i = old_head; i < tail; i++) {
+	for (i = old_head; i != tail; i++) {
 		unsigned index, dst_mask, src_mask;
 		size_t sq_size;
 
@@ -544,7 +545,7 @@ static int io_register_resize_rings(struct io_ring_ctx *ctx, void __user *arg)
 		ret = -EOVERFLOW;
 		goto out;
 	}
-	for (i = old_head; i < tail; i++) {
+	for (i = old_head; i != tail; i++) {
 		unsigned index, dst_mask, src_mask;
 		size_t cq_size;
 
@@ -558,6 +559,21 @@ static int io_register_resize_rings(struct io_ring_ctx *ctx, void __user *arg)
 			src_mask = (ctx->cq_entries << 1) - 1;
 			dst_mask = (p.cq_entries << 1) - 1;
 		}
+		/*
+		 * A 32b CQE on a CQE_MIXED ring takes two contiguous entries
+		 * and must not wrap. A smaller ring may place it on the last
+		 * entry, fail the resize if that happens.
+		 */
+		if (ctx->flags & IORING_SETUP_CQE_MIXED) {
+			if (cqe32_tail) {
+				cqe32_tail = false;
+			} else if (READ_ONCE(o.rings->cqes[index & src_mask].flags) &
+				   IORING_CQE_F_32) {
+				if ((index & dst_mask) == dst_mask)
+					goto overflow;
+				cqe32_tail = true;
+			}
+		}
 		memcpy(&n.rings->cqes[index & dst_mask], &o.rings->cqes[index & src_mask], cq_size);
 	}
 	WRITE_ONCE(n.rings->cq.head, old_head);
diff --git a/io_uring/rw.c b/io_uring/rw.c
index 3666ff3d2e42..f46d08bbe9d8 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -625,24 +625,6 @@ static void io_complete_rw_iopoll(struct kiocb *kiocb, long res)
 	smp_store_release(&req->iopoll_completed, 1);
 }
 
-static inline ssize_t io_fixup_restart_res(ssize_t ret)
-{
-	switch (ret) {
-	case -ERESTARTSYS:
-	case -ERESTARTNOINTR:
-	case -ERESTARTNOHAND:
-	case -ERESTART_RESTARTBLOCK:
-		/*
-		 * We can't just restart the syscall, since previously
-		 * submitted sqes may already be in progress. Just fail
-		 * this IO with EINTR.
-		 */
-		return -EINTR;
-	default:
-		return ret;
-	}
-}
-
 static inline void io_rw_done(struct io_kiocb *req, ssize_t ret)
 {
 	struct io_rw *rw = io_kiocb_to_cmd(req, struct io_rw);
diff --git a/io_uring/sqpoll.c b/io_uring/sqpoll.c
index 74c1a130cd87..448fa81ed87e 100644
--- a/io_uring/sqpoll.c
+++ b/io_uring/sqpoll.c
@@ -390,6 +390,13 @@ static int io_sq_thread(void *data)
 				 */
 				smp_mb__after_atomic();
 
+				/*
+				 * Nothing gets submitted before the ring is
+				 * enabled, which comes with a wake up.
+				 */
+				if (READ_ONCE(ctx->flags) & IORING_SETUP_R_DISABLED)
+					continue;
+
 				if (io_sqring_entries(ctx)) {
 					needs_sched = false;
 					break;
diff --git a/io_uring/timeout.c b/io_uring/timeout.c
index 3d03e178044b..dbbb9615ec9e 100644
--- a/io_uring/timeout.c
+++ b/io_uring/timeout.c
@@ -132,6 +132,14 @@ __cold void io_flush_timeouts(struct io_ring_ctx *ctx)
 	raw_spin_lock_irq(&ctx->timeout_lock);
 	seq = READ_ONCE(ctx->cached_cq_tail) - atomic_read(&ctx->cq_timeouts);
 
+	/*
+	 * A fired timeout bumps ->cq_timeouts before its CQE is posted, which
+	 * leaves the sequence behind the last flush until it is. No event has
+	 * happened then, see io_timeout().
+	 */
+	if ((s32)(seq - ctx->cq_last_tm_flush) < 0)
+		seq = ctx->cq_last_tm_flush;
+
 	list_for_each_entry_safe(timeout, tmp, &ctx->timeout_list, list) {
 		struct io_kiocb *req = cmd_to_io_kiocb(timeout);
 		u32 events_needed, events_got;
@@ -278,22 +286,29 @@ static enum hrtimer_restart io_timeout_fn(struct hrtimer *timer)
 	return HRTIMER_NORESTART;
 }
 
-static struct io_kiocb *io_timeout_extract(struct io_ring_ctx *ctx,
-					   struct io_cancel_data *cd)
+static struct io_kiocb *io_timeout_find(struct io_ring_ctx *ctx,
+					struct io_cancel_data *cd)
 	__must_hold(&ctx->timeout_lock)
 {
 	struct io_timeout *timeout;
-	struct io_timeout_data *io;
-	struct io_kiocb *req = NULL;
 
 	list_for_each_entry(timeout, &ctx->timeout_list, list) {
-		struct io_kiocb *tmp = cmd_to_io_kiocb(timeout);
+		struct io_kiocb *req = cmd_to_io_kiocb(timeout);
 
-		if (io_cancel_req_match(tmp, cd)) {
-			req = tmp;
-			break;
-		}
+		if (io_cancel_req_match(req, cd))
+			return req;
 	}
+	return NULL;
+}
+
+static struct io_kiocb *io_timeout_extract(struct io_ring_ctx *ctx,
+					   struct io_cancel_data *cd)
+	__must_hold(&ctx->timeout_lock)
+{
+	struct io_kiocb *req = io_timeout_find(ctx, cd);
+	struct io_timeout *timeout;
+	struct io_timeout_data *io;
+
 	if (!req)
 		return ERR_PTR(-ENOENT);
 
@@ -335,6 +350,9 @@ static void io_req_task_link_timeout(struct io_tw_req tw_req, io_tw_token_t tw)
 			};
 
 			ret = io_try_cancel(req->tctx, &cd, 0);
+			/* a number of requests for futex and waitid */
+			if (ret > 0)
+				ret = 0;
 		} else {
 			ret = -ECANCELED;
 		}
@@ -426,15 +444,24 @@ static int io_timeout_update(struct io_ring_ctx *ctx, __u64 user_data,
 	__must_hold(&ctx->timeout_lock)
 {
 	struct io_cancel_data cd = { .ctx = ctx, .data = user_data, };
-	struct io_kiocb *req = io_timeout_extract(ctx, &cd);
+	struct io_kiocb *req = io_timeout_find(ctx, &cd);
 	struct io_timeout *timeout = io_kiocb_to_cmd(req, struct io_timeout);
 	struct io_timeout_data *data;
 
-	if (IS_ERR(req))
-		return PTR_ERR(req);
+	if (!req)
+		return -ENOENT;
 
-	timeout->off = 0; /* noseq */
 	data = req->async_data;
+	/* multishot requests only make sense with rel values */
+	if ((data->flags & IORING_TIMEOUT_MULTISHOT) && mode == HRTIMER_MODE_ABS)
+		return -EINVAL;
+
+	req = io_timeout_extract(ctx, &cd);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
+	/* for a multishot request this isn't a sequence, keep the repeats */
+	if (!(data->flags & IORING_TIMEOUT_MULTISHOT))
+		timeout->off = 0; /* noseq */
 	data->ts = *ts;
 
 	list_add_tail(&timeout->list, &ctx->timeout_list);
@@ -601,11 +628,19 @@ int io_timeout(struct io_kiocb *req, unsigned int issue_flags)
 	struct io_timeout *timeout = io_kiocb_to_cmd(req, struct io_timeout);
 	struct io_ring_ctx *ctx = req->ctx;
 	struct io_timeout_data *data = req->async_data;
+	struct io_timeout *first;
 	struct list_head *entry;
-	u32 tail, off = timeout->off;
+	u32 tail, base, off = timeout->off;
 
 	raw_spin_lock_irq(&ctx->timeout_lock);
 
+	/* the list is searched under ->timeout_lock, see io_wq_cancel_seen() */
+	if (__io_wq_cancel_seen(req, issue_flags)) {
+		raw_spin_unlock_irq(&ctx->timeout_lock);
+		io_req_task_queue_fail(req, -ECANCELED);
+		return IOU_ISSUE_SKIP_COMPLETE;
+	}
+
 	/*
 	 * sqe->off holds how many events that need to occur for this
 	 * timeout event to be satisfied. If it isn't set, then this is
@@ -617,13 +652,27 @@ int io_timeout(struct io_kiocb *req, unsigned int issue_flags)
 	}
 
 	tail = data_race(ctx->cached_cq_tail) - atomic_read(&ctx->cq_timeouts);
-	timeout->target_seq = tail + off;
 
-	/* Update the last seq here in case io_flush_timeouts() hasn't.
-	 * This is safe because ->completion_lock is held, and submissions
-	 * and completions are never mixed in the same ->completion_lock section.
+	/*
+	 * Update the last seq here in case io_flush_timeouts() hasn't, it only
+	 * gets called once sequences are in use. Leave it alone if there are
+	 * timeouts waiting for one. CQEs may have been posted since the last
+	 * flush, and a target that has been reached must not fall behind it.
 	 */
-	ctx->cq_last_tm_flush = tail;
+	first = list_first_entry_or_null(&ctx->timeout_list, struct io_timeout,
+					 list);
+	if (!first || io_is_timeout_noseq(cmd_to_io_kiocb(first)))
+		ctx->cq_last_tm_flush = tail;
+	base = ctx->cq_last_tm_flush;
+
+	/*
+	 * A fired timeout bumps ->cq_timeouts before its CQE is posted, which
+	 * leaves the sequence behind the last flush until it is. Nothing else
+	 * separates the two then, so count from the flush.
+	 */
+	if ((s32)(tail - base) < 0)
+		tail = base;
+	timeout->target_seq = tail + off;
 
 	/*
 	 * Insertion sort, ensuring the first entry in the list is always
@@ -635,8 +684,8 @@ int io_timeout(struct io_kiocb *req, unsigned int issue_flags)
 
 		if (io_is_timeout_noseq(nxt))
 			continue;
-		/* nxt.seq is behind @tail, otherwise would've been completed */
-		if (off >= nextt->target_seq - tail)
+		/* no target is behind the last flush, see io_flush_timeouts() */
+		if (timeout->target_seq - base >= nextt->target_seq - base)
 			break;
 	}
 add:
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index d0fec7bb87d4..526fdf103499 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -87,7 +87,7 @@ static void io_uring_cmd_del_cancelable(struct io_uring_cmd *cmd,
 
 	cmd->flags &= ~IORING_URING_CMD_CANCELABLE;
 	io_ring_submit_lock(ctx, issue_flags);
-	hlist_del(&req->hash_node);
+	hlist_del_init(&req->hash_node);
 	io_ring_submit_unlock(ctx, issue_flags);
 }
 
diff --git a/io_uring/waitid.c b/io_uring/waitid.c
index 2b756017423f..172cf770b29b 100644
--- a/io_uring/waitid.c
+++ b/io_uring/waitid.c
@@ -154,9 +154,12 @@ static bool __io_waitid_cancel(struct io_kiocb *req, bool copy_si)
 
 	/*
 	 * Mark us canceled regardless of ownership. This will prevent a
-	 * potential retry from a spurious wakeup.
+	 * potential retry from a spurious wakeup. Only the first cancel
+	 * attempt should take a reference for the ownership handoff.
 	 */
-	atomic_or(IO_WAITID_CANCEL_FLAG, &iw->refs);
+	if (atomic_fetch_or(IO_WAITID_CANCEL_FLAG, &iw->refs) &
+	    IO_WAITID_CANCEL_FLAG)
+		return false;
 
 	/* claim ownership */
 	if (atomic_fetch_inc(&iw->refs) & IO_WAITID_REF_MASK)
@@ -265,12 +268,18 @@ static int io_waitid_wait(struct wait_queue_entry *wait, unsigned mode,
 		return 0;
 
 	list_del_init(&wait->entry);
-	smp_store_release(&iw->head, NULL);
 
-	/* cancel is in progress */
+	/*
+	 * Cancel or issue is in progress. Leave ->head alone, so that whoever
+	 * owns the request has to take the wait queue lock, which we hold,
+	 * before it can complete and free it.
+	 */
 	if (atomic_fetch_inc(&iw->refs) & IO_WAITID_REF_MASK)
 		return 1;
 
+	/* pairs with the smp_load_acquire() in io_waitid_remove_wq() */
+	smp_store_release(&iw->head, NULL);
+
 	req->io_task_work.func = io_waitid_cb;
 	__io_req_task_work_add(req, IOU_F_TWQ_IN_WAKE);
 	return 1;
@@ -343,6 +352,8 @@ int io_waitid(struct io_kiocb *req, unsigned int issue_flags)
 		 * a waitqueue callback, or if someone cancels it.
 		 */
 		if (!io_waitid_drop_issue_ref(req)) {
+			if (io_wq_cancel_seen(req, issue_flags))
+				__io_waitid_cancel(req, true);
 			io_ring_submit_unlock(ctx, issue_flags);
 			return IOU_ISSUE_SKIP_COMPLETE;
 		}
diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index b44d8ba53e59..b725dab91732 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -962,7 +962,7 @@ static bool io_zcrx_queue_cqe(struct io_kiocb *req, struct net_iov *niov,
 		cqe->flags |= IORING_CQE_F_32;
 
 	area = io_zcrx_iov_to_area(niov);
-	offset = off + (net_iov_idx(niov) << ifq->niov_shift);
+	offset = off + ((u64)net_iov_idx(niov) << ifq->niov_shift);
 	rcqe = (struct io_uring_zcrx_cqe *)(cqe + 1);
 	rcqe->off = offset + ((u64)area->area_id << IORING_ZCRX_AREA_SHIFT);
 	rcqe->__pad = 0;
diff --git a/kernel/exit.c b/kernel/exit.c
index 4dac7d188d74..39ce4d610090 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -974,10 +974,11 @@ void __noreturn do_exit(long code)
 
 	exit_sem(tsk);
 	exit_shm(tsk);
-	exit_files(tsk);
-	exit_fs(tsk);
+	/* Hang the tty up before the last close of it can clear the session. */
 	if (group_dead)
 		disassociate_ctty(1);
+	exit_files(tsk);
+	exit_fs(tsk);
 	exit_nsproxy_namespaces(tsk);
 	exit_task_work(tsk);
 	exit_thread(tsk);
diff --git a/kernel/fork.c b/kernel/fork.c
index 7be5736d44c7..6734b9460033 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1595,6 +1595,7 @@ static int copy_files(u64 clone_flags, struct task_struct *tsk,
 
 	if (clone_flags & CLONE_FILES) {
 		atomic_inc(&oldf->count);
+		tsk->files = oldf;
 		return 0;
 	}
 
@@ -2079,6 +2080,8 @@ __latent_entropy struct task_struct *copy_process(
 	INIT_LIST_HEAD(&p->sibling);
 	rcu_copy_process(p);
 	p->vfork_done = NULL;
+	/* Set by copy_files(), exit_files() on the error path skips NULL. */
+	p->files = NULL;
 	spin_lock_init(&p->alloc_lock);
 
 	init_sigpending(&p->pending);
@@ -2175,7 +2178,7 @@ __latent_entropy struct task_struct *copy_process(
 		goto bad_fork_cleanup_semundo;
 	retval = copy_fs(clone_flags, p);
 	if (retval)
-		goto bad_fork_cleanup_files;
+		goto bad_fork_cleanup_semundo;
 	retval = copy_sighand(clone_flags, p);
 	if (retval)
 		goto bad_fork_cleanup_fs;
@@ -2468,8 +2471,6 @@ __latent_entropy struct task_struct *copy_process(
 	__cleanup_sighand(p->sighand);
 bad_fork_cleanup_fs:
 	exit_fs(p); /* blocking */
-bad_fork_cleanup_files:
-	exit_files(p); /* blocking */
 bad_fork_cleanup_semundo:
 	exit_sem(p);
 bad_fork_cleanup_security:
@@ -2480,6 +2481,8 @@ __latent_entropy struct task_struct *copy_process(
 	perf_event_free_task(p);
 bad_fork_sched_cancel_fork:
 	sched_cancel_fork(p);
+	/* ->release() of a file may need scx_fork_rwsem for write. */
+	exit_files(p); /* blocking */
 bad_fork_cleanup_policy:
 	lockdep_free_task(p);
 #ifdef CONFIG_NUMA
diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index a3dd5fc55e85..6aded9f756c8 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -238,9 +238,10 @@ void zap_pid_ns_processes(struct pid_namespace *pid_ns)
 	 * kernel_wait4() will also block until our children traced from the
 	 * parent namespace are detached and become EXIT_DEAD.
 	 */
+	/* Task work must not busy-loop the reaper, see signal_pending(). */
+	guard(no_notify_signal)();
 	do {
 		clear_thread_flag(TIF_SIGPENDING);
-		clear_thread_flag(TIF_NOTIFY_SIGNAL);
 		rc = kernel_wait4(-1, NULL, __WALL, NULL);
 	} while (rc != -ECHILD);
 
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 22b8be2fc43d..4fc881fc02e4 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -1211,6 +1211,12 @@ int ptrace_request(struct task_struct *child, long request,
 	case PTRACE_SETSIGMASK: {
 		sigset_t new_set;
 
+		/* A user worker only ever takes SIGKILL and SIGSTOP. */
+		if (child->flags & PF_USER_WORKER) {
+			ret = -EPERM;
+			break;
+		}
+
 		if (addr != sizeof(sigset_t)) {
 			ret = -EINVAL;
 			break;
diff --git a/kernel/resource.c b/kernel/resource.c
index e4e9bac12e6e..5387c1fdf695 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -705,7 +705,7 @@ static int __find_resource_space(struct resource *root, struct resource *old,
 		/* Check for overflow after ALIGN() */
 		avail.start = ALIGN(tmp.start, constraint->align);
 		avail.end = tmp.end;
-		avail.flags = new->flags & ~IORESOURCE_UNSET;
+		avail.flags = new->flags;
 		if (avail.start >= tmp.start) {
 			alloc.flags = avail.flags;
 			if (alignf) {
@@ -716,7 +716,7 @@ static int __find_resource_space(struct resource *root, struct resource *old,
 			}
 			alloc.end = alloc.start + size - 1;
 			if (alloc.start <= alloc.end &&
-			    resource_contains(&avail, &alloc)) {
+			    __resource_contains_unbound(&avail, &alloc)) {
 				new->start = alloc.start;
 				new->end = alloc.end;
 				return 0;
diff --git a/kernel/signal.c b/kernel/signal.c
index 0d2fcf9d3023..636cbaa26d52 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3178,6 +3178,10 @@ static void retarget_shared_pending(struct task_struct *tsk, sigset_t *which)
 	sigset_t retarget;
 	struct task_struct *t;
 
+	/* Nobody dequeues them in a dying group, see get_signal(). */
+	if (tsk->signal->flags & SIGNAL_GROUP_EXIT)
+		return;
+
 	sigandsets(&retarget, &tsk->signal->shared_pending.signal, which);
 	if (sigisemptyset(&retarget))
 		return;
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 1bb2175ab1af..877871efdc0f 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -4370,9 +4370,9 @@ subsys_initcall(ftrace_check_for_weak_functions);
 
 static int print_rec(struct seq_file *m, unsigned long ip)
 {
-	unsigned long offset;
+	unsigned long offset = 0;
 	char str[KSYM_SYMBOL_LEN];
-	char *modname;
+	char *modname = NULL;
 	const char *ret;
 
 	ret = kallsyms_lookup(ip, NULL, &offset, &modname, str);
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index a76743475e9f..93a97656dee6 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4847,6 +4847,7 @@ static int tracing_single_release_tr(struct inode *inode, struct file *file)
 	return single_release(inode, file);
 }
 
+static bool __update_last_data_if_empty(struct trace_array *tr);
 static bool update_last_data_if_empty(struct trace_array *tr);
 
 static int tracing_open(struct inode *inode, struct file *file)
@@ -5916,7 +5917,7 @@ tracing_set_trace_read(struct file *filp, char __user *ubuf,
 int tracer_init(struct tracer *t, struct trace_array *tr)
 {
 	tracing_reset_online_cpus(&tr->array_buffer);
-	update_last_data_if_empty(tr);
+	__update_last_data_if_empty(tr);
 	return t->init(tr);
 }
 
@@ -6654,8 +6655,10 @@ static int tracing_wait_pipe(struct file *filp)
 	return 1;
 }
 
-static bool update_last_data_if_empty(struct trace_array *tr)
+static bool __update_last_data_if_empty(struct trace_array *tr)
 {
+	lockdep_assert_held(&trace_types_lock);
+
 	if (!(tr->flags & TRACE_ARRAY_FL_LAST_BOOT))
 		return false;
 
@@ -6670,6 +6673,16 @@ static bool update_last_data_if_empty(struct trace_array *tr)
 	return true;
 }
 
+static bool update_last_data_if_empty(struct trace_array *tr)
+{
+	/* Avoid the lock on the read path unless this is a last boot buffer */
+	if (!(tr->flags & TRACE_ARRAY_FL_LAST_BOOT))
+		return false;
+
+	guard(mutex)(&trace_types_lock);
+	return __update_last_data_if_empty(tr);
+}
+
 /*
  * Consumer reader.
  */
@@ -7599,7 +7612,7 @@ int tracing_set_clock(struct trace_array *tr, const char *clockstr)
 		ring_buffer_set_clock(tr->max_buffer.buffer, trace_clocks[i].func);
 	tracing_reset_online_cpus(&tr->max_buffer);
 #endif
-	update_last_data_if_empty(tr);
+	__update_last_data_if_empty(tr);
 
 	if (tr->scratch && !(tr->flags & TRACE_ARRAY_FL_LAST_BOOT)) {
 		struct trace_scratch *tscratch = tr->scratch;
@@ -10693,6 +10706,8 @@ static void trace_module_record(struct module *mod, bool add)
 	struct trace_array *tr;
 	unsigned long flags;
 
+	guard(mutex)(&trace_types_lock);
+
 	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
 		flags = tr->flags & (TRACE_ARRAY_FL_BOOT | TRACE_ARRAY_FL_LAST_BOOT);
 		/* Update any persistent trace array that has already been started */
diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 7985bbdf2ba6..de65fa983399 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -595,6 +595,12 @@ predicate_parse(const char *str, int nr_parens, int nr_preds,
 			top--;					/* #12 */
 		}
 	}
+	/* Only the inner loop can complete a non-empty expression. */
+	if (N) {
+		ret = -EINVAL;
+		parse_error(pe, FILT_ERR_INVALID_FILTER, ptr - str);
+		goto out_free;
+	}
  out:
 	if (top != op_stack) {
 		/* Too many '(' */
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 20d23a08b5b8..9254e6c17d63 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -461,7 +461,7 @@ static u64 hist_field_unary_minus(struct hist_field *hist_field,
 {									\
 	type *addr = (type *)(event + hist_field->field->offset);	\
 									\
-	return (u64)(unsigned long)*addr;				\
+	return (u64)*addr;						\
 }
 
 DEFINE_HIST_FIELD_FN(s64);
@@ -544,7 +544,7 @@ struct field_var {
 };
 
 struct field_var_hist {
-	struct hist_trigger_data	*hist_data;
+	struct trace_event_file		*file;
 	char				*cmd;
 };
 
@@ -3098,8 +3098,8 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
 		return ERR_PTR(-ENOMEM);
 	}
 
-	/* Save the compatible histogram information */
-	var_hist->hist_data = hist_data;
+	/* Needed to remove the histogram when the target goes away */
+	var_hist->file = file;
 
 	/* Create the new histogram with our variable */
 	ret = event_hist_trigger_parse(&trigger_hist_cmd, file,
@@ -3114,20 +3114,18 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
 
 	kfree(cmd);
 
+	n = target_hist_data->n_field_var_hists;
+	target_hist_data->field_var_hists[n] = var_hist;
+	target_hist_data->n_field_var_hists++;
+
 	/* If we can't find the variable, something went wrong */
 	event_var = find_synthetic_field_var(target_hist_data, subsys_name,
 					     event_name, field_name);
 	if (IS_ERR_OR_NULL(event_var)) {
-		kfree(var_hist->cmd);
-		kfree(var_hist);
 		hist_err(tr, HIST_ERR_SYNTH_VAR_NOT_FOUND, errpos(field_name));
 		return ERR_PTR(-EINVAL);
 	}
 
-	n = target_hist_data->n_field_var_hists;
-	target_hist_data->field_var_hists[n] = var_hist;
-	target_hist_data->n_field_var_hists++;
-
 	return event_var;
 }
 
@@ -6327,7 +6325,7 @@ static void unregister_field_var_hists(struct hist_trigger_data *hist_data)
 	int ret;
 
 	for (i = 0; i < hist_data->n_field_var_hists; i++) {
-		file = hist_data->field_var_hists[i]->hist_data->event_file;
+		file = hist_data->field_var_hists[i]->file;
 		cmd = hist_data->field_var_hists[i]->cmd;
 		ret = event_hist_trigger_parse(&trigger_hist_cmd, file,
 					       "!hist", "hist", cmd);
@@ -6755,7 +6753,6 @@ static void hist_unreg_all(struct trace_event_file *file)
 	struct event_trigger_data *test, *n;
 	struct hist_trigger_data *hist_data;
 	struct synth_event *se;
-	const char *se_name;
 
 	lockdep_assert_held(&event_mutex);
 
@@ -6768,8 +6765,7 @@ static void hist_unreg_all(struct trace_event_file *file)
 			list_del_rcu(&test->list);
 			trace_event_trigger_enable_disable(file, 0);
 
-			se_name = trace_event_name(file->event_call);
-			se = find_synth_event(se_name);
+			se = find_synth_event_call(file->event_call);
 			if (se)
 				se->ref--;
 
@@ -6793,7 +6789,6 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
 	struct hist_trigger_data *hist_data;
 	char *param, *filter, *p, *start;
 	struct synth_event *se;
-	const char *se_name;
 	bool remove;
 	int ret = 0;
 
@@ -6887,8 +6882,7 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
 		}
 
 		event_trigger_unregister(cmd_ops, file, glob+1, trigger_data);
-		se_name = trace_event_name(file->event_call);
-		se = find_synth_event(se_name);
+		se = find_synth_event_call(file->event_call);
 		if (se)
 			se->ref--;
 		ret = 0;
@@ -6923,8 +6917,7 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
 	if (ret)
 		goto out_unreg;
 
-	se_name = trace_event_name(file->event_call);
-	se = find_synth_event(se_name);
+	se = find_synth_event_call(file->event_call);
 	if (se)
 		se->ref++;
  out:
@@ -6943,6 +6936,8 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
 
 	trigger_data_free(trigger_data);
 
+	unregister_field_var_hists(hist_data);
+
 	destroy_hist_data(hist_data);
 	goto out;
 }
diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 934dafbb009e..9891dc4753cd 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -848,6 +848,16 @@ struct synth_event *find_synth_event(const char *name)
 	return NULL;
 }
 
+struct synth_event *find_synth_event_call(struct trace_event_call *call)
+{
+	struct synth_event *se;
+	const char *name;
+
+	name = trace_event_name(call);
+	se = find_synth_event(name);
+	return se && &se->call == call ? se : NULL;
+}
+
 static struct trace_event_fields synth_event_fields_array[] = {
 	{ .type = TRACE_FUNCTION_TYPE,
 	  .define_fields = synth_event_define_fields },
diff --git a/kernel/trace/trace_synth.h b/kernel/trace/trace_synth.h
index 43f6fb6078db..d4ebf01b7049 100644
--- a/kernel/trace/trace_synth.h
+++ b/kernel/trace/trace_synth.h
@@ -37,5 +37,6 @@ struct synth_event {
 };
 
 extern struct synth_event *find_synth_event(const char *name);
+extern struct synth_event *find_synth_event_call(struct trace_event_call *call);
 
 #endif /* __TRACE_SYNTH_H */
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 4e6e3d7d0a5c..8fa788b0d709 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -807,15 +807,18 @@ static void damos_commit_quota_goal_union(
 	}
 }
 
-static void damos_commit_quota_goal(
+static int damos_commit_quota_goal(
 		struct damos_quota_goal *dst, struct damos_quota_goal *src)
 {
+	if (!src->target_value)
+		return  -EINVAL;
 	dst->metric = src->metric;
 	dst->target_value = src->target_value;
 	if (dst->metric == DAMOS_QUOTA_USER_INPUT)
 		dst->current_value = src->current_value;
 	/* keep last_psi_total as is, since it will be updated in next cycle */
 	damos_commit_quota_goal_union(dst, src);
+	return 0;
 }
 
 /**
@@ -833,14 +836,17 @@ static void damos_commit_quota_goal(
 int damos_commit_quota_goals(struct damos_quota *dst, struct damos_quota *src)
 {
 	struct damos_quota_goal *dst_goal, *next, *src_goal, *new_goal;
-	int i = 0, j = 0;
+	int i = 0, j = 0, err;
 
 	damos_for_each_quota_goal_safe(dst_goal, next, dst) {
 		src_goal = damos_nth_quota_goal(i++, src);
-		if (src_goal)
-			damos_commit_quota_goal(dst_goal, src_goal);
-		else
+		if (src_goal) {
+			err = damos_commit_quota_goal(dst_goal, src_goal);
+			if (err)
+				return err;
+		} else {
 			damos_destroy_quota_goal(dst_goal);
+		}
 	}
 	damos_for_each_quota_goal_safe(src_goal, next, src) {
 		if (j++ < i)
@@ -849,7 +855,11 @@ int damos_commit_quota_goals(struct damos_quota *dst, struct damos_quota *src)
 				src_goal->metric, src_goal->target_value);
 		if (!new_goal)
 			return -ENOMEM;
-		damos_commit_quota_goal(new_goal, src_goal);
+		err = damos_commit_quota_goal(new_goal, src_goal);
+		if (err) {
+			damos_free_quota_goal(new_goal);
+			return err;
+		}
 		damos_add_quota_goal(dst, new_goal);
 	}
 	return 0;
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 7f52470be36e..3a79d8c89b5b 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1592,6 +1592,20 @@ static int damon_sysfs_repeat_call_fn(void *data)
 	return 0;
 }
 
+static bool damon_sysfs_valid_start_ctx(struct damon_ctx *ctx)
+{
+	struct damos *s;
+	struct damos_quota_goal *g;
+
+	damon_for_each_scheme(s, ctx) {
+		damos_for_each_quota_goal(g, (&s->quota)) {
+			if (!g->target_value)
+				return false;
+		}
+	}
+	return true;
+}
+
 static int damon_sysfs_turn_damon_on(struct damon_sysfs_kdamond *kdamond)
 {
 	struct damon_ctx *ctx;
@@ -1618,6 +1632,11 @@ static int damon_sysfs_turn_damon_on(struct damon_sysfs_kdamond *kdamond)
 		kfree(repeat_call_control);
 		return PTR_ERR(ctx);
 	}
+	if (!damon_sysfs_valid_start_ctx(ctx)) {
+		kfree(repeat_call_control);
+		damon_destroy_ctx(ctx);
+		return -EINVAL;
+	}
 	err = damon_start(&ctx, 1, false);
 	if (err) {
 		kfree(repeat_call_control);
diff --git a/net/ax25/af_ax25.c b/net/ax25/af_ax25.c
index 23c558ff9682..32114f659b8d 100644
--- a/net/ax25/af_ax25.c
+++ b/net/ax25/af_ax25.c
@@ -81,7 +81,17 @@ static void ax25_kill_by_device(struct net_device *dev)
 
 	if ((ax25_dev = ax25_dev_ax25dev(dev)) == NULL)
 		return;
-	ax25_dev->device_up = false;
+	WRITE_ONCE(ax25_dev->device_up, false);
+
+	/*
+	 * ax25_send_frame() and ax25_rcv() create connections that hold no
+	 * reference on the ax25_dev: they rely on the walk below to detach
+	 * them before the ax25_dev is freed. Both run under rcu_read_lock()
+	 * and give up when device_up is clear, so once this returns every
+	 * connection they were setting up is complete and on the list, and
+	 * no new one can appear behind the walk.
+	 */
+	synchronize_rcu();
 
 	spin_lock_bh(&ax25_list_lock);
 again:
@@ -91,7 +101,7 @@ static void ax25_kill_by_device(struct net_device *dev)
 			if (!sk) {
 				spin_unlock_bh(&ax25_list_lock);
 				ax25_disconnect(s, ENETUNREACH);
-				s->ax25_dev = NULL;
+				WRITE_ONCE(s->ax25_dev, NULL);
 				ax25_cb_del(s);
 				spin_lock_bh(&ax25_list_lock);
 				goto again;
@@ -100,7 +110,7 @@ static void ax25_kill_by_device(struct net_device *dev)
 			spin_unlock_bh(&ax25_list_lock);
 			lock_sock(sk);
 			ax25_disconnect(s, ENETUNREACH);
-			s->ax25_dev = NULL;
+			WRITE_ONCE(s->ax25_dev, NULL);
 			if (sk->sk_socket) {
 				netdev_put(ax25_dev->dev,
 					   &s->dev_tracker);
@@ -172,6 +182,7 @@ void ax25_cb_add(ax25_cb *ax25)
 struct sock *ax25_find_listener(ax25_address *addr, int digi,
 	struct net_device *dev, int type)
 {
+	ax25_dev *ax25_dev;
 	ax25_cb *s;
 
 	spin_lock(&ax25_list_lock);
@@ -181,7 +192,8 @@ struct sock *ax25_find_listener(ax25_address *addr, int digi,
 		if (s->sk && !ax25cmp(&s->source_addr, addr) &&
 		    s->sk->sk_type == type && s->sk->sk_state == TCP_LISTEN) {
 			/* If device is null we match any device */
-			if (s->ax25_dev == NULL || s->ax25_dev->dev == dev) {
+			ax25_dev = READ_ONCE(s->ax25_dev);
+			if (ax25_dev == NULL || ax25_dev->dev == dev) {
 				sock_hold(s->sk);
 				spin_unlock(&ax25_list_lock);
 				return s->sk;
@@ -222,18 +234,20 @@ struct sock *ax25_get_socket(ax25_address *my_addr, ax25_address *dest_addr,
  *	Find an AX.25 control block given both ends. It will only pick up
  *	floating AX.25 control blocks or non Raw socket bound control blocks.
  */
-ax25_cb *ax25_find_cb(const ax25_address *src_addr, ax25_address *dest_addr,
-	ax25_digi *digi, struct net_device *dev)
+static ax25_cb *__ax25_find_cb(const ax25_address *src_addr,
+			       ax25_address *dest_addr, ax25_digi *digi,
+			       struct net_device *dev)
 {
+	ax25_dev *ax25_dev;
 	ax25_cb *s;
 
-	spin_lock_bh(&ax25_list_lock);
 	ax25_for_each(s, &ax25_list) {
 		if (s->sk && s->sk->sk_type != SOCK_SEQPACKET)
 			continue;
-		if (s->ax25_dev == NULL)
+		ax25_dev = READ_ONCE(s->ax25_dev);
+		if (ax25_dev == NULL)
 			continue;
-		if (ax25cmp(&s->source_addr, src_addr) == 0 && ax25cmp(&s->dest_addr, dest_addr) == 0 && s->ax25_dev->dev == dev) {
+		if (ax25cmp(&s->source_addr, src_addr) == 0 && ax25cmp(&s->dest_addr, dest_addr) == 0 && ax25_dev->dev == dev) {
 			if (digi != NULL && digi->ndigi != 0) {
 				if (s->digipeat == NULL)
 					continue;
@@ -243,30 +257,67 @@ ax25_cb *ax25_find_cb(const ax25_address *src_addr, ax25_address *dest_addr,
 				if (s->digipeat != NULL && s->digipeat->ndigi != 0)
 					continue;
 			}
-			ax25_cb_hold(s);
-			spin_unlock_bh(&ax25_list_lock);
-
 			return s;
 		}
 	}
-	spin_unlock_bh(&ax25_list_lock);
 
 	return NULL;
 }
 
+ax25_cb *ax25_find_cb(const ax25_address *src_addr, ax25_address *dest_addr,
+		      ax25_digi *digi, struct net_device *dev)
+{
+	ax25_cb *s;
+
+	spin_lock_bh(&ax25_list_lock);
+	s = __ax25_find_cb(src_addr, dest_addr, digi, dev);
+	if (s)
+		ax25_cb_hold(s);
+	spin_unlock_bh(&ax25_list_lock);
+
+	return s;
+}
+
 EXPORT_SYMBOL(ax25_find_cb);
 
+/*
+ *	Add a new connection to the list unless one already exists for the
+ *	same addresses, path and device. Returns NULL when the control block
+ *	has been added, or the existing one, held, when there is one: looking
+ *	it up and adding it are done under the same lock, so that two senders
+ *	cannot both create a connection for the same link.
+ */
+ax25_cb *ax25_cb_add_unique(ax25_cb *ax25)
+{
+	ax25_cb *s;
+
+	spin_lock_bh(&ax25_list_lock);
+	s = __ax25_find_cb(&ax25->source_addr, &ax25->dest_addr,
+			   ax25->digipeat, ax25->ax25_dev->dev);
+	if (s) {
+		ax25_cb_hold(s);
+	} else {
+		ax25_cb_hold(ax25);
+		hlist_add_head(&ax25->ax25_node, &ax25_list);
+	}
+	spin_unlock_bh(&ax25_list_lock);
+
+	return s;
+}
+
 void ax25_send_to_raw(ax25_address *addr, struct sk_buff *skb, int proto)
 {
+	ax25_dev *ax25_dev;
 	ax25_cb *s;
 	struct sk_buff *copy;
 
 	spin_lock(&ax25_list_lock);
 	ax25_for_each(s, &ax25_list) {
+		ax25_dev = READ_ONCE(s->ax25_dev);
 		if (s->sk != NULL && ax25cmp(&s->source_addr, addr) == 0 &&
 		    s->sk->sk_type == SOCK_RAW &&
 		    s->sk->sk_protocol == proto &&
-		    s->ax25_dev->dev == skb->dev &&
+		    ax25_dev && ax25_dev->dev == skb->dev &&
 		    atomic_read(&s->sk->sk_rmem_alloc) <= s->sk->sk_rcvbuf) {
 			if ((copy = skb_clone(skb, GFP_ATOMIC)) == NULL)
 				continue;
@@ -537,6 +588,8 @@ ax25_cb *ax25_create_cb(void)
 	skb_queue_head_init(&ax25->frag_queue);
 	skb_queue_head_init(&ax25->ack_queue);
 	skb_queue_head_init(&ax25->reseq_queue);
+	skb_queue_head_init(&ax25->xmit_queue);
+	spin_lock_init(&ax25->lock);
 
 	ax25_setup_timers(ax25);
 
diff --git a/net/ax25/ax25_ds_in.c b/net/ax25/ax25_ds_in.c
index c62f8fb06189..b78a577760c6 100644
--- a/net/ax25/ax25_ds_in.c
+++ b/net/ax25/ax25_ds_in.c
@@ -58,6 +58,8 @@ static int ax25_ds_state1_machine(ax25_cb *ax25, struct sk_buff *skb, int framet
 		ax25->vr      = 0;
 		ax25->state   = AX25_STATE_3;
 		ax25->n2count = 0;
+		/* I frames left unacknowledged by a link reset: send them again */
+		ax25_requeue_frames(ax25);
 		if (ax25->sk != NULL) {
 			bh_lock_sock(ax25->sk);
 			ax25->sk->sk_state = TCP_ESTABLISHED;
diff --git a/net/ax25/ax25_in.c b/net/ax25/ax25_in.c
index f2d66af86359..1bcb5e321467 100644
--- a/net/ax25/ax25_in.c
+++ b/net/ax25/ax25_in.c
@@ -35,12 +35,22 @@ static int ax25_rx_fragment(ax25_cb *ax25, struct sk_buff *skb)
 {
 	struct sk_buff *skbn, *skbo;
 
+	if (!pskb_may_pull(skb, 1))
+		return 0;
+
 	if (ax25->fragno != 0) {
 		if (!(*skb->data & AX25_SEG_FIRST)) {
 			if ((ax25->fragno - 1) == (*skb->data & AX25_SEG_REM)) {
 				/* Enqueue fragment */
 				ax25->fragno = *skb->data & AX25_SEG_REM;
 				skb_pull(skb, 1);	/* skip fragno */
+				if (ax25->fraglen + skb->len > USHRT_MAX) {
+					kfree_skb(skb);
+					skb_queue_purge(&ax25->frag_queue);
+					ax25->fragno = 0;
+					ax25->fraglen = 0;
+					return 1;
+				}
 				ax25->fraglen += skb->len;
 				skb_queue_tail(&ax25->frag_queue, skb);
 
@@ -104,6 +114,10 @@ int ax25_rx_iframe(ax25_cb *ax25, struct sk_buff *skb)
 
 	if (skb == NULL) return 0;
 
+	/* An I frame must at least carry its PID byte */
+	if (skb->len < 1)
+		return 0;
+
 	ax25_start_idletimer(ax25);
 
 	pid = *skb->data;
@@ -199,6 +213,18 @@ static int ax25_rcv(struct sk_buff *skb, struct net_device *dev,
 	if ((ax25_dev = ax25_dev_ax25dev(dev)) == NULL)
 		goto free;
 
+	if (skb_linearize(skb))
+		goto free;
+
+	/*
+	 * A connection made below on an incoming SABM holds no reference on
+	 * the ax25_dev either. We are called under rcu_read_lock(), which
+	 * ax25_kill_by_device() waits for after it has cleared device_up:
+	 * leave a device that is going down alone.
+	 */
+	if (!READ_ONCE(ax25_dev->device_up))
+		goto free;
+
 	/*
 	 *	Parse the address header.
 	 */
@@ -217,6 +243,9 @@ static int ax25_rcv(struct sk_buff *skb, struct net_device *dev,
 	 */
 	skb_pull(skb, ax25_addr_size(&dp));
 
+	if (skb->len < 1)
+		goto free;
+
 	/* For our port addresses ? */
 	if (ax25cmp(&dest, dev_addr) == 0 && dp.lastrepeat + 1 == dp.ndigi)
 		mine = 1;
@@ -227,6 +256,9 @@ static int ax25_rcv(struct sk_buff *skb, struct net_device *dev,
 
 	/* UI frame - bypass LAPB processing */
 	if ((*skb->data & ~0x10) == AX25_UI && dp.lastrepeat + 1 == dp.ndigi) {
+		if (skb->len < 2)
+			goto free;
+
 		skb_set_transport_header(skb, 2); /* skip control and pid */
 
 		ax25_send_to_raw(&dest, skb, skb->data[1]);
@@ -351,6 +383,24 @@ static int ax25_rcv(struct sk_buff *skb, struct net_device *dev,
 		}
 
 		ax25 = sk_to_ax25(make);
+
+		/*
+		 * Get the digipeater path before the skb goes on the
+		 * listener's queue: once queued it belongs to that queue
+		 * and cannot simply be freed if the allocation fails.
+		 */
+		if (dp.ndigi && !ax25->digipeat) {
+			ax25->digipeat = kmalloc(sizeof(ax25_digi), GFP_ATOMIC);
+			if (!ax25->digipeat) {
+				kfree_skb(skb);
+				ax25_destroy_socket(ax25);
+				bh_unlock_sock(sk);
+				sock_put(sk);
+
+				return 0;
+			}
+		}
+
 		skb_set_owner_r(skb, make);
 		skb_queue_head(&sk->sk_receive_queue, skb);
 
@@ -374,14 +424,13 @@ static int ax25_rcv(struct sk_buff *skb, struct net_device *dev,
 	ax25->dest_addr   = src;
 
 	/*
-	 *	Sort out any digipeated paths.
+	 *	Sort out any digipeated paths. A socket made from a listener
+	 *	already has its path allocated, see above.
 	 */
 	if (dp.ndigi && !ax25->digipeat &&
 	    (ax25->digipeat = kmalloc(sizeof(ax25_digi), GFP_ATOMIC)) == NULL) {
 		kfree_skb(skb);
 		ax25_destroy_socket(ax25);
-		if (sk)
-			sock_put(sk);
 		return 0;
 	}
 
diff --git a/net/ax25/ax25_out.c b/net/ax25/ax25_out.c
index 8bca2ace98e5..7c4ebef5ae6c 100644
--- a/net/ax25/ax25_out.c
+++ b/net/ax25/ax25_out.c
@@ -32,36 +32,36 @@ static DEFINE_SPINLOCK(ax25_frag_lock);
 ax25_cb *ax25_send_frame(struct sk_buff *skb, int paclen, const ax25_address *src, ax25_address *dest, ax25_digi *digi, struct net_device *dev)
 {
 	ax25_dev *ax25_dev;
-	ax25_cb *ax25;
+	ax25_cb *ax25, *existing;
+
+	/*
+	 * The connection made or used here holds no reference on the
+	 * ax25_dev. ax25_kill_by_device() clears device_up, waits for the RCU
+	 * readers and only then detaches the connections of the device: stay
+	 * under the RCU read lock until the frame is queued, and do not start
+	 * anything on a device that is going down.
+	 */
+	rcu_read_lock();
+	ax25_dev = ax25_dev_ax25dev(dev);
+	if (!ax25_dev || !READ_ONCE(ax25_dev->device_up)) {
+		rcu_read_unlock();
+		return NULL;
+	}
 
 	/*
 	 * Take the default packet length for the device if zero is
 	 * specified.
 	 */
-	if (paclen == 0) {
-		rcu_read_lock();
-		ax25_dev = ax25_dev_ax25dev(dev);
-		if (!ax25_dev) {
-			rcu_read_unlock();
-			return NULL;
-		}
+	if (paclen == 0)
 		paclen = ax25_dev->values[AX25_VALUES_PACLEN];
-		rcu_read_unlock();
-	}
 
 	/*
 	 * Look for an existing connection.
 	 */
 	if ((ax25 = ax25_find_cb(src, dest, digi, dev)) != NULL) {
 		ax25_output(ax25, paclen, skb);
-		return ax25;		/* It already existed */
-	}
-
-	rcu_read_lock();
-	ax25_dev = ax25_dev_ax25dev(dev);
-	if (!ax25_dev) {
 		rcu_read_unlock();
-		return NULL;
+		return ax25;		/* It already existed */
 	}
 
 	if ((ax25 = ax25_create_cb()) == NULL) {
@@ -69,7 +69,6 @@ ax25_cb *ax25_send_frame(struct sk_buff *skb, int paclen, const ax25_address *sr
 		return NULL;
 	}
 	ax25_fillin_cb(ax25, ax25_dev);
-	rcu_read_unlock();
 
 	ax25->source_addr = *src;
 	ax25->dest_addr   = *dest;
@@ -78,11 +77,25 @@ ax25_cb *ax25_send_frame(struct sk_buff *skb, int paclen, const ax25_address *sr
 		ax25->digipeat = kmemdup(digi, sizeof(*digi), GFP_ATOMIC);
 		if (ax25->digipeat == NULL) {
 			ax25_cb_put(ax25);
+			rcu_read_unlock();
 			return NULL;
 		}
 	}
 
-	switch (ax25->ax25_dev->values[AX25_VALUES_PROTOCOL]) {
+	/*
+	 * Another sender may have created the connection since the lookup
+	 * above: the list is searched again and the new control block added
+	 * under one lock. If we lost, use the other one.
+	 */
+	existing = ax25_cb_add_unique(ax25);
+	if (existing) {
+		ax25_cb_put(ax25);
+		ax25_output(existing, paclen, skb);
+		rcu_read_unlock();
+		return existing;
+	}
+
+	switch (ax25_dev->values[AX25_VALUES_PROTOCOL]) {
 	case AX25_PROTO_STD_SIMPLEX:
 	case AX25_PROTO_STD_DUPLEX:
 		ax25_std_establish_data_link(ax25);
@@ -104,13 +117,12 @@ ax25_cb *ax25_send_frame(struct sk_buff *skb, int paclen, const ax25_address *sr
 	 */
 	ax25_cb_hold(ax25);
 
-	ax25_cb_add(ax25);
-
 	ax25->state = AX25_STATE_1;
 
 	ax25_start_heartbeat(ax25);
 
 	ax25_output(ax25, paclen, skb);
+	rcu_read_unlock();
 
 	return ax25;			/* We had to create it */
 }
@@ -218,6 +230,11 @@ void ax25_output(ax25_cb *ax25, int paclen, struct sk_buff *skb)
  *  This procedure is passed a buffer descriptor for an iframe. It builds
  *  the rest of the control part of the frame and then writes it out.
  */
+/*
+ *	Number an I frame and queue it for the device. Called by ax25_kick()
+ *	with ax25->lock held: the frame is sent by ax25_run_xmit_queue() once
+ *	the lock is dropped.
+ */
 static void ax25_send_iframe(ax25_cb *ax25, struct sk_buff *skb, int poll_bit)
 {
 	unsigned char *frame;
@@ -245,7 +262,34 @@ static void ax25_send_iframe(ax25_cb *ax25, struct sk_buff *skb, int poll_bit)
 
 	ax25_start_idletimer(ax25);
 
-	ax25_transmit_buffer(ax25, skb, AX25_COMMAND);
+	skb_queue_tail(&ax25->xmit_queue, skb);
+}
+
+/*
+ *	Hand the frames numbered by ax25_kick() to the device, in order. Only
+ *	one context does it at a time, so that frames queued by two senders
+ *	cannot overtake each other; the one already running picks up whatever
+ *	the others have queued. The lock is not held while transmitting.
+ */
+static void ax25_run_xmit_queue(ax25_cb *ax25)
+{
+	struct sk_buff *skb;
+
+	spin_lock_bh(&ax25->lock);
+	if (ax25->xmit_running) {
+		spin_unlock_bh(&ax25->lock);
+		return;
+	}
+	ax25->xmit_running = 1;
+
+	while ((skb = skb_dequeue(&ax25->xmit_queue)) != NULL) {
+		spin_unlock_bh(&ax25->lock);
+		ax25_transmit_buffer(ax25, skb, AX25_COMMAND);
+		spin_lock_bh(&ax25->lock);
+	}
+
+	ax25->xmit_running = 0;
+	spin_unlock_bh(&ax25->lock);
 }
 
 void ax25_kick(ax25_cb *ax25)
@@ -260,14 +304,25 @@ void ax25_kick(ax25_cb *ax25)
 	if (ax25->condition & AX25_COND_PEER_RX_BUSY)
 		return;
 
+	/*
+	 * ax25_kick() is called from process context by the senders and
+	 * from softirq context by the receive path and the timers, possibly
+	 * for several ROSE or NET/ROM circuits sharing this connection. Two
+	 * of them running here at the same time would read the same V(S) and
+	 * send two different frames under the same N(S); the peer keeps one
+	 * and the other is never sent again. Take the frames off the write
+	 * queue and number them under the lock.
+	 */
+	spin_lock_bh(&ax25->lock);
+
 	if (skb_peek(&ax25->write_queue) == NULL)
-		return;
+		goto out;
 
 	start = (skb_peek(&ax25->ack_queue) == NULL) ? ax25->va : ax25->vs;
 	end   = (ax25->va + ax25->window) % ax25->modulus;
 
 	if (start == end)
-		return;
+		goto out;
 
 	/*
 	 * Transmit data until either we're out of data to send or
@@ -281,12 +336,21 @@ void ax25_kick(ax25_cb *ax25)
 	 */
 	skb  = skb_dequeue(&ax25->write_queue);
 	if (!skb)
-		return;
+		goto out;
 
 	ax25->vs = start;
 
 	do {
-		if ((skbn = skb_clone(skb, GFP_ATOMIC)) == NULL) {
+		/*
+		 * Send a private copy, not a clone. The frame stays on the
+		 * ack queue and is sent again after a REJ or a T1 timeout,
+		 * while the previous copy may still be waiting in the device
+		 * queue. A clone shares its data with the original: building
+		 * the frame again would rewrite the control field, and so
+		 * the N(R), of the copy already queued.
+		 */
+		skbn = skb_copy(skb, GFP_ATOMIC);
+		if (!skbn) {
 			skb_queue_head(&ax25->write_queue, skb);
 			break;
 		}
@@ -331,6 +395,11 @@ void ax25_kick(ax25_cb *ax25)
 		ax25_calculate_t1(ax25);
 		ax25_start_t1timer(ax25);
 	}
+
+out:
+	spin_unlock_bh(&ax25->lock);
+
+	ax25_run_xmit_queue(ax25);
 }
 
 void ax25_transmit_buffer(ax25_cb *ax25, struct sk_buff *skb, int type)
diff --git a/net/ax25/ax25_std_in.c b/net/ax25/ax25_std_in.c
index f280683f83fc..d0269ece4fc5 100644
--- a/net/ax25/ax25_std_in.c
+++ b/net/ax25/ax25_std_in.c
@@ -66,6 +66,14 @@ static int ax25_std_state1_machine(ax25_cb *ax25, struct sk_buff *skb, int frame
 			ax25->vr      = 0;
 			ax25->state   = AX25_STATE_3;
 			ax25->n2count = 0;
+			/*
+			 * The link may have been re-established from state
+			 * 3 or 4 with I frames still waiting for their
+			 * acknowledgment. V(S) and V(A) start again from
+			 * zero: send those frames again, as is done when
+			 * the peer resets the link with a SABM.
+			 */
+			ax25_requeue_frames(ax25);
 			if (ax25->sk != NULL) {
 				bh_lock_sock(ax25->sk);
 				ax25->sk->sk_state = TCP_ESTABLISHED;
diff --git a/net/ax25/ax25_subr.c b/net/ax25/ax25_subr.c
index bff4b203a893..a1e33092e6d8 100644
--- a/net/ax25/ax25_subr.c
+++ b/net/ax25/ax25_subr.c
@@ -34,6 +34,7 @@ void ax25_clear_queues(ax25_cb *ax25)
 {
 	skb_queue_purge(&ax25->write_queue);
 	skb_queue_purge(&ax25->ack_queue);
+	skb_queue_purge(&ax25->xmit_queue);
 	skb_queue_purge(&ax25->reseq_queue);
 	skb_queue_purge(&ax25->frag_queue);
 }
@@ -45,31 +46,51 @@ void ax25_clear_queues(ax25_cb *ax25)
  */
 void ax25_frames_acked(ax25_cb *ax25, unsigned short nr)
 {
+	struct sk_buff_head acked;
 	struct sk_buff *skb;
 
+	__skb_queue_head_init(&acked);
+
 	/*
-	 * Remove all the ack-ed frames from the ack queue.
+	 * Remove all the ack-ed frames from the ack queue. ax25_kick() may be
+	 * filling it from another CPU: move V(A) and the queue together, and
+	 * free the frames once the lock is dropped.
 	 */
-	if (ax25->va != nr) {
-		while (skb_peek(&ax25->ack_queue) != NULL && ax25->va != nr) {
-			skb = skb_dequeue(&ax25->ack_queue);
-			kfree_skb(skb);
-			ax25->va = (ax25->va + 1) % ax25->modulus;
-		}
+	spin_lock_bh(&ax25->lock);
+	/*
+	 * ax25_clear_queues() purges the ack queue without ax25->lock: test
+	 * what skb_dequeue() returns, not what skb_peek() saw before it.
+	 */
+	while (ax25->va != nr && (skb = skb_dequeue(&ax25->ack_queue)) != NULL) {
+		__skb_queue_tail(&acked, skb);
+		ax25->va = (ax25->va + 1) % ax25->modulus;
 	}
+	spin_unlock_bh(&ax25->lock);
+
+	__skb_queue_purge(&acked);
 }
 
 void ax25_requeue_frames(ax25_cb *ax25)
 {
+	struct sk_buff_head stale;
 	struct sk_buff *skb;
 
+	__skb_queue_head_init(&stale);
+
 	/*
 	 * Requeue all the un-ack-ed frames on the output queue to be picked
 	 * up by ax25_kick called from the timer. This arrangement handles the
-	 * possibility of an empty output queue.
+	 * possibility of an empty output queue. Copies that ax25_kick() has
+	 * numbered but not sent yet are stale: they will be sent again.
 	 */
+	spin_lock_bh(&ax25->lock);
+	while ((skb = skb_dequeue(&ax25->xmit_queue)) != NULL)
+		__skb_queue_tail(&stale, skb);
 	while ((skb = skb_dequeue_tail(&ax25->ack_queue)) != NULL)
 		skb_queue_head(&ax25->write_queue, skb);
+	spin_unlock_bh(&ax25->lock);
+
+	__skb_queue_purge(&stale);
 }
 
 /*
@@ -102,6 +123,9 @@ int ax25_decode(ax25_cb *ax25, struct sk_buff *skb, int *ns, int *nr, int *pf)
 	frame = skb->data;
 	*ns = *nr = *pf = 0;
 
+	if (skb->len < 1)
+		return frametype;
+
 	if (ax25->modulus == AX25_MODULUS) {
 		if ((frame[0] & AX25_S) == 0) {
 			frametype = AX25_I;			/* I frame - carries NR/NS/PF */
@@ -118,6 +142,10 @@ int ax25_decode(ax25_cb *ax25, struct sk_buff *skb, int *ns, int *nr, int *pf)
 		}
 		skb_pull(skb, 1);
 	} else {
+		/* I and S frames carry a two-byte control field here */
+		if ((frame[0] & AX25_U) != 3 && skb->len < 2)
+			return frametype;
+
 		if ((frame[0] & AX25_S) == 0) {
 			frametype = AX25_I;			/* I frame - carries NR/NS/PF */
 			*ns = (frame[0] >> 1) & 0x7F;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 7d4115603d08..462667a6e6ac 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -625,6 +625,10 @@ void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 	BT_DBG("conn %p, psm 0x%2.2x, dcid 0x%4.4x", conn,
 	       __le16_to_cpu(chan->psm), chan->dcid);
 
+	/* Caller must ensure l2cap_chan is linked to l2cap_conn only once */
+	if (WARN_ON_ONCE(chan->conn || test_bit(FLAG_DEL, &chan->flags)))
+		return;
+
 	conn->disc_reason = HCI_ERROR_REMOTE_USER_TERM;
 
 	chan->conn = l2cap_conn_get(conn);
@@ -7410,7 +7414,8 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 		}
 	}
 
-	if (cid && __l2cap_get_chan_by_dcid(conn, cid)) {
+	if ((cid && __l2cap_get_chan_by_dcid(conn, cid)) || chan->conn ||
+	    test_bit(FLAG_DEL, &chan->flags)) {
 		hci_conn_drop(hcon);
 		err = -EBUSY;
 		goto chan_unlock;
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 9078a672e2dd..e78866e02bfc 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -111,6 +111,7 @@ static int l2cap_sock_bind(struct socket *sock, struct sockaddr_unsized *addr, i
 			return -EINVAL;
 	}
 
+	l2cap_chan_lock(chan);
 	lock_sock(sk);
 
 	if (sk->sk_state != BT_OPEN) {
@@ -176,6 +177,7 @@ static int l2cap_sock_bind(struct socket *sock, struct sockaddr_unsized *addr, i
 
 done:
 	release_sock(sk);
+	l2cap_chan_unlock(chan);
 	return err;
 }
 
diff --git a/net/core/gso.c b/net/core/gso.c
index bcd156372f4d..e96ef6350064 100644
--- a/net/core/gso.c
+++ b/net/core/gso.c
@@ -117,6 +117,7 @@ struct sk_buff *__skb_gso_segment(struct sk_buff *skb,
 
 	SKB_GSO_CB(skb)->mac_offset = skb_headroom(skb);
 	SKB_GSO_CB(skb)->encap_level = 0;
+	SKB_GSO_CB(skb)->recursion_counter = 0;
 
 	skb_reset_mac_header(skb);
 	skb_reset_mac_len(skb);
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 1d1a03fad1f9..5f6f6019b298 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1364,6 +1364,9 @@ struct sk_buff *inet_gso_segment(struct sk_buff *skb,
 	int id;
 
 	skb_reset_network_header(skb);
+	if (unlikely(gso_recursion_inc_test(skb,
+					   IP_TUNNEL_RECURSION_LIMIT)))
+		goto out;
 	nhoff = skb_network_header(skb) - skb_mac_header(skb);
 	if (unlikely(!pskb_may_pull(skb, sizeof(*iph))))
 		goto out;
diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index 6762ce7909c8..1682e1af9fab 100644
--- a/net/ipv6/ip6_offload.c
+++ b/net/ipv6/ip6_offload.c
@@ -17,6 +17,7 @@
 #include <net/udp.h>
 #include <net/gro.h>
 #include <net/gso.h>
+#include <net/ip_tunnels.h>
 
 #include "ip6_offload.h"
 
@@ -120,6 +121,9 @@ static struct sk_buff *ipv6_gso_segment(struct sk_buff *skb,
 	bool gso_partial;
 
 	skb_reset_network_header(skb);
+	if (unlikely(gso_recursion_inc_test(skb,
+					   IP_TUNNEL_RECURSION_LIMIT)))
+		goto out;
 	err = ipv6_hopopt_jumbo_remove(skb);
 	if (err)
 		return ERR_PTR(err);
diff --git a/net/netrom/af_netrom.c b/net/netrom/af_netrom.c
index 33468124d53d..d9c484705c9e 100644
--- a/net/netrom/af_netrom.c
+++ b/net/netrom/af_netrom.c
@@ -162,7 +162,8 @@ static struct sock *nr_find_listener(ax25_address *addr)
 /*
  *	Find a connected NET/ROM socket given my circuit IDs.
  */
-static struct sock *nr_find_socket(unsigned char index, unsigned char id)
+static struct sock *nr_find_socket(unsigned char index, unsigned char id,
+				   const ax25_address *src)
 {
 	struct sock *s;
 
@@ -170,7 +171,8 @@ static struct sock *nr_find_socket(unsigned char index, unsigned char id)
 	sk_for_each(s, &nr_list) {
 		struct nr_sock *nr = nr_sk(s);
 
-		if (nr->my_index == index && nr->my_id == id) {
+		if (nr->my_index == index && nr->my_id == id &&
+		    (!src || !ax25cmp(&nr->dest_addr, src))) {
 			sock_hold(s);
 			goto found;
 		}
@@ -219,7 +221,8 @@ static unsigned short nr_find_next_circuit(void)
 		j = id % 256;
 
 		if (i != 0 && j != 0) {
-			if ((sk=nr_find_socket(i, j)) == NULL)
+			sk = nr_find_socket(i, j, NULL);
+			if (!sk)
 				break;
 			sock_put(sk);
 		}
@@ -885,6 +888,11 @@ int nr_rx_frame(struct sk_buff *skb, struct net_device *dev)
 	 *	skb->data points to the netrom frame start
 	 */
 
+	if (skb_linearize(skb))
+		return 0;
+	if (skb->len < NR_NETWORK_LEN + NR_TRANSPORT_LEN)
+		return 0;
+
 	src  = (ax25_address *)(skb->data + 0);
 	dest = (ax25_address *)(skb->data + 7);
 
@@ -923,10 +931,21 @@ int nr_rx_frame(struct sk_buff *skb, struct net_device *dev)
 		if (frametype == NR_CONNREQ)
 			sk = nr_find_peer(circuit_index, circuit_id, src);
 		else
-			sk = nr_find_socket(circuit_index, circuit_id);
+			sk = nr_find_socket(circuit_index, circuit_id, src);
 	}
 
 	if (sk != NULL) {
+		/*
+		 * nr_state1_machine() reads the window size at byte 20, but
+		 * only for a plain CONNACK. A CONNACK with the choke flag set
+		 * is a refusal or a reset, sent as a 20-byte frame by
+		 * __nr_transmit_reply(), and must not be dropped here.
+		 */
+		if (frametype == NR_CONNACK && !flags &&
+		    skb->len < NR_NETWORK_LEN + NR_TRANSPORT_LEN + 1) {
+			sock_put(sk);
+			return 0;
+		}
 		bh_lock_sock(sk);
 		skb_reset_transport_header(skb);
 
@@ -961,10 +980,14 @@ int nr_rx_frame(struct sk_buff *skb, struct net_device *dev)
 		return 0;
 	}
 
-	sk = nr_find_listener(dest);
+	/* Need window (byte 20) and user address (bytes 21-27) */
+	if (skb->len < NR_NETWORK_LEN + NR_TRANSPORT_LEN + 1 + AX25_ADDR_LEN)
+		return 0;
 
 	user = (ax25_address *)(skb->data + 21);
 
+	sk = nr_find_listener(dest);
+
 	if (sk == NULL || sk_acceptq_is_full(sk) ||
 	    (make = nr_make_new(sk)) == NULL) {
 		nr_transmit_refusal(skb, 0);
diff --git a/net/netrom/nr_in.c b/net/netrom/nr_in.c
index 97944db6b5ac..b90a47dcf165 100644
--- a/net/netrom/nr_in.c
+++ b/net/netrom/nr_in.c
@@ -26,6 +26,9 @@
 #include <linux/interrupt.h>
 #include <net/netrom.h>
 
+/* nr_sendmsg() never sends more than this in one message */
+#define NR_MAX_REASM_LEN	65536
+
 static int nr_queue_rx_frame(struct sock *sk, struct sk_buff *skb, int more)
 {
 	struct sk_buff *skbo, *skbn = skb;
@@ -35,6 +38,29 @@ static int nr_queue_rx_frame(struct sock *sk, struct sk_buff *skb, int more)
 
 	nr_start_idletimer(sk);
 
+	/* Rest of a message already found to be too long: drop it */
+	if (nr->condition & NR_COND_FRAG_DISCARD) {
+		if (!more)
+			nr->condition &= ~NR_COND_FRAG_DISCARD;
+		kfree_skb(skb);
+		return 0;
+	}
+
+	/*
+	 * Give up on a message that would grow beyond what a peer may
+	 * send. The frame is consumed rather than handed back to the
+	 * caller, which would queue it again after skb_pull().
+	 */
+	if ((more || nr->fraglen > 0) &&
+	    nr->fraglen + skb->len > NR_MAX_REASM_LEN) {
+		skb_queue_purge(&nr->frag_queue);
+		nr->fraglen = 0;
+		if (more)
+			nr->condition |= NR_COND_FRAG_DISCARD;
+		kfree_skb(skb);
+		return 0;
+	}
+
 	if (more) {
 		nr->fraglen += skb->len;
 		skb_queue_tail(&nr->frag_queue, skb);
diff --git a/net/netrom/nr_route.c b/net/netrom/nr_route.c
index 9cc29ae85b06..288c4a91ea9b 100644
--- a/net/netrom/nr_route.c
+++ b/net/netrom/nr_route.c
@@ -36,46 +36,58 @@
 
 static unsigned int nr_neigh_no = 1;
 
+/*
+ * nr_route_lock protects both lists and the routing data hanging off them:
+ * which, count and routes[] of every node. It is taken with bottom halves
+ * disabled, is never nested with itself, and may be held while calling into
+ * AX.25 (nr_route_frame() -> ax25_send_frame()), so it must never be taken
+ * with an AX.25 list lock held.
+ */
+static DEFINE_SPINLOCK(nr_route_lock);
 static HLIST_HEAD(nr_node_list);
-static DEFINE_SPINLOCK(nr_node_list_lock);
 static HLIST_HEAD(nr_neigh_list);
-static DEFINE_SPINLOCK(nr_neigh_list_lock);
 
-static struct nr_node *nr_node_get(ax25_address *callsign)
+static struct nr_node *__nr_node_get(ax25_address *callsign)
 {
-	struct nr_node *found = NULL;
 	struct nr_node *nr_node;
 
-	spin_lock_bh(&nr_node_list_lock);
+	lockdep_assert_held(&nr_route_lock);
+
 	nr_node_for_each(nr_node, &nr_node_list)
 		if (ax25cmp(callsign, &nr_node->callsign) == 0) {
 			nr_node_hold(nr_node);
-			found = nr_node;
-			break;
+			return nr_node;
 		}
-	spin_unlock_bh(&nr_node_list_lock);
+	return NULL;
+}
+
+static struct nr_node *nr_node_get(ax25_address *callsign)
+{
+	struct nr_node *found;
+
+	spin_lock_bh(&nr_route_lock);
+	found = __nr_node_get(callsign);
+	spin_unlock_bh(&nr_route_lock);
 	return found;
 }
 
-static struct nr_neigh *nr_neigh_get_dev(ax25_address *callsign,
-					 struct net_device *dev)
+static struct nr_neigh *__nr_neigh_get_dev(ax25_address *callsign,
+					   struct net_device *dev)
 {
-	struct nr_neigh *found = NULL;
 	struct nr_neigh *nr_neigh;
 
-	spin_lock_bh(&nr_neigh_list_lock);
+	lockdep_assert_held(&nr_route_lock);
+
 	nr_neigh_for_each(nr_neigh, &nr_neigh_list)
 		if (ax25cmp(callsign, &nr_neigh->callsign) == 0 &&
 		    nr_neigh->dev == dev) {
 			nr_neigh_hold(nr_neigh);
-			found = nr_neigh;
-			break;
+			return nr_neigh;
 		}
-	spin_unlock_bh(&nr_neigh_list_lock);
-	return found;
+	return NULL;
 }
 
-static void nr_remove_neigh(struct nr_neigh *);
+static void nr_remove_neigh_locked(struct nr_neigh *nr_neigh);
 
 /*      re-sort the routes in quality order.    */
 static void re_sort_routes(struct nr_node *nr_node, int x, int y)
@@ -90,6 +102,66 @@ static void re_sort_routes(struct nr_node *nr_node, int x, int y)
 	}
 }
 
+/*
+ * Allocate a neighbour and link it into nr_neigh_list. The list holds one
+ * reference and the caller gets another one. Called with nr_route_lock held.
+ */
+static struct nr_neigh *nr_neigh_create_locked(ax25_address *callsign,
+					       ax25_digi *ax25_digi,
+					       struct net_device *dev,
+					       unsigned int quality,
+					       unsigned char locked)
+{
+	struct nr_neigh *nr_neigh;
+
+	lockdep_assert_held(&nr_route_lock);
+
+	nr_neigh = kmalloc(sizeof(*nr_neigh), GFP_ATOMIC);
+	if (!nr_neigh)
+		return NULL;
+
+	nr_neigh->callsign = *callsign;
+	nr_neigh->digipeat = NULL;
+	nr_neigh->ax25     = NULL;
+	nr_neigh->dev      = dev;
+	nr_neigh->quality  = quality;
+	nr_neigh->locked   = locked;
+	nr_neigh->count    = 0;
+	nr_neigh->number   = nr_neigh_no++;
+	nr_neigh->failed   = 0;
+	refcount_set(&nr_neigh->refcount, 1);
+
+	if (ax25_digi && ax25_digi->ndigi > 0) {
+		nr_neigh->digipeat = kmemdup(ax25_digi, sizeof(*ax25_digi),
+					     GFP_ATOMIC);
+		if (!nr_neigh->digipeat) {
+			kfree(nr_neigh);
+			return NULL;
+		}
+	}
+
+	hlist_add_head(&nr_neigh->neigh_node, &nr_neigh_list);
+	nr_neigh_hold(nr_neigh);
+
+	return nr_neigh;
+}
+
+/*
+ * Drop one route's use of a neighbour. The neighbour is unlinked when no
+ * route uses it any more and it was not added explicitly; count and locked
+ * are read before the route's reference is dropped, since that reference
+ * may be the last one. Called with nr_route_lock held.
+ */
+static void nr_neigh_route_put_locked(struct nr_neigh *nr_neigh)
+{
+	lockdep_assert_held(&nr_route_lock);
+
+	nr_neigh->count--;
+	if (nr_neigh->count == 0 && !nr_neigh->locked)
+		nr_remove_neigh_locked(nr_neigh);
+	nr_neigh_put(nr_neigh);
+}
+
 /*
  *	Add a new route to a node, and in the process add the node and the
  *	neighbour if it is new.
@@ -100,7 +172,7 @@ static int __must_check nr_add_node(ax25_address *nr, const char *mnemonic,
 {
 	struct nr_node  *nr_node;
 	struct nr_neigh *nr_neigh;
-	int i, found;
+	int i, found, ret = 0;
 	struct net_device *odev;
 
 	if ((odev=nr_dev_get(nr)) != NULL) {	/* Can't add routes to ourself */
@@ -108,9 +180,15 @@ static int __must_check nr_add_node(ax25_address *nr, const char *mnemonic,
 		return -EINVAL;
 	}
 
-	nr_node = nr_node_get(nr);
+	/*
+	 * Look up and update under one critical section, so that a node or
+	 * neighbour found here cannot be unlinked before it is used.
+	 */
+	spin_lock_bh(&nr_route_lock);
+
+	nr_node = __nr_node_get(nr);
 
-	nr_neigh = nr_neigh_get_dev(ax25, dev);
+	nr_neigh = __nr_neigh_get_dev(ax25, dev);
 
 	/*
 	 * The L2 link to a neighbour has failed in the past
@@ -121,16 +199,12 @@ static int __must_check nr_add_node(ax25_address *nr, const char *mnemonic,
 	if (nr_neigh != NULL && nr_neigh->failed != 0 && quality == 0) {
 		struct nr_node *nr_nodet;
 
-		spin_lock_bh(&nr_node_list_lock);
 		nr_node_for_each(nr_nodet, &nr_node_list) {
-			nr_node_lock(nr_nodet);
 			for (i = 0; i < nr_nodet->count; i++)
 				if (nr_nodet->routes[i].neighbour == nr_neigh)
 					if (i < nr_nodet->which)
 						nr_nodet->which = i;
-			nr_node_unlock(nr_nodet);
 		}
-		spin_unlock_bh(&nr_node_list_lock);
 	}
 
 	if (nr_neigh != NULL)
@@ -139,43 +213,19 @@ static int __must_check nr_add_node(ax25_address *nr, const char *mnemonic,
 	if (quality == 0 && nr_neigh != NULL && nr_node != NULL) {
 		nr_neigh_put(nr_neigh);
 		nr_node_put(nr_node);
-		return 0;
+		goto out;
 	}
 
 	if (nr_neigh == NULL) {
-		if ((nr_neigh = kmalloc(sizeof(*nr_neigh), GFP_ATOMIC)) == NULL) {
+		unsigned int q = READ_ONCE(sysctl_netrom_default_path_quality);
+
+		nr_neigh = nr_neigh_create_locked(ax25, ax25_digi, dev, q, 0);
+		if (!nr_neigh) {
 			if (nr_node)
 				nr_node_put(nr_node);
-			return -ENOMEM;
-		}
-
-		nr_neigh->callsign = *ax25;
-		nr_neigh->digipeat = NULL;
-		nr_neigh->ax25     = NULL;
-		nr_neigh->dev      = dev;
-		nr_neigh->quality  = READ_ONCE(sysctl_netrom_default_path_quality);
-		nr_neigh->locked   = 0;
-		nr_neigh->count    = 0;
-		nr_neigh->number   = nr_neigh_no++;
-		nr_neigh->failed   = 0;
-		refcount_set(&nr_neigh->refcount, 1);
-
-		if (ax25_digi != NULL && ax25_digi->ndigi > 0) {
-			nr_neigh->digipeat = kmemdup(ax25_digi,
-						     sizeof(*ax25_digi),
-						     GFP_KERNEL);
-			if (nr_neigh->digipeat == NULL) {
-				kfree(nr_neigh);
-				if (nr_node)
-					nr_node_put(nr_node);
-				return -ENOMEM;
-			}
+			ret = -ENOMEM;
+			goto out;
 		}
-
-		spin_lock_bh(&nr_neigh_list_lock);
-		hlist_add_head(&nr_neigh->neigh_node, &nr_neigh_list);
-		nr_neigh_hold(nr_neigh);
-		spin_unlock_bh(&nr_neigh_list_lock);
 	}
 
 	if (quality != 0 && ax25cmp(nr, ax25) == 0 && !nr_neigh->locked)
@@ -183,9 +233,9 @@ static int __must_check nr_add_node(ax25_address *nr, const char *mnemonic,
 
 	if (nr_node == NULL) {
 		if ((nr_node = kmalloc(sizeof(*nr_node), GFP_ATOMIC)) == NULL) {
-			if (nr_neigh)
-				nr_neigh_put(nr_neigh);
-			return -ENOMEM;
+			nr_neigh_put(nr_neigh);
+			ret = -ENOMEM;
+			goto out;
 		}
 
 		nr_node->callsign = *nr;
@@ -194,7 +244,6 @@ static int __must_check nr_add_node(ax25_address *nr, const char *mnemonic,
 		nr_node->which = 0;
 		nr_node->count = 1;
 		refcount_set(&nr_node->refcount, 1);
-		spin_lock_init(&nr_node->node_lock);
 
 		nr_node->routes[0].quality   = quality;
 		nr_node->routes[0].obs_count = obs_count;
@@ -203,15 +252,12 @@ static int __must_check nr_add_node(ax25_address *nr, const char *mnemonic,
 		nr_neigh_hold(nr_neigh);
 		nr_neigh->count++;
 
-		spin_lock_bh(&nr_node_list_lock);
 		hlist_add_head(&nr_node->node_node, &nr_node_list);
 		/* refcount initialized at 1 */
-		spin_unlock_bh(&nr_node_list_lock);
 
 		nr_neigh_put(nr_neigh);
-		return 0;
+		goto out;
 	}
-	nr_node_lock(nr_node);
 
 	if (quality != 0)
 		strscpy(nr_node->mnemonic, mnemonic);
@@ -242,11 +288,7 @@ static int __must_check nr_add_node(ax25_address *nr, const char *mnemonic,
 		} else {
 			/* It must be better than the worst */
 			if (quality > nr_node->routes[2].quality) {
-				nr_node->routes[2].neighbour->count--;
-				nr_neigh_put(nr_node->routes[2].neighbour);
-
-				if (nr_node->routes[2].neighbour->count == 0 && !nr_node->routes[2].neighbour->locked)
-					nr_remove_neigh(nr_node->routes[2].neighbour);
+				nr_neigh_route_put_locked(nr_node->routes[2].neighbour);
 
 				nr_node->routes[2].quality   = quality;
 				nr_node->routes[2].obs_count = obs_count;
@@ -280,35 +322,28 @@ static int __must_check nr_add_node(ax25_address *nr, const char *mnemonic,
 	}
 
 	nr_neigh_put(nr_neigh);
-	nr_node_unlock(nr_node);
 	nr_node_put(nr_node);
-	return 0;
+out:
+	spin_unlock_bh(&nr_route_lock);
+	return ret;
 }
 
 static void nr_remove_node_locked(struct nr_node *nr_node)
 {
-	lockdep_assert_held(&nr_node_list_lock);
+	lockdep_assert_held(&nr_route_lock);
 
 	hlist_del_init(&nr_node->node_node);
 	nr_node_put(nr_node);
 }
 
-static inline void __nr_remove_neigh(struct nr_neigh *nr_neigh)
+static void nr_remove_neigh_locked(struct nr_neigh *nr_neigh)
 {
+	lockdep_assert_held(&nr_route_lock);
+
 	hlist_del_init(&nr_neigh->neigh_node);
 	nr_neigh_put(nr_neigh);
 }
 
-#define nr_remove_neigh_locked(__neigh) \
-	__nr_remove_neigh(__neigh)
-
-static void nr_remove_neigh(struct nr_neigh *nr_neigh)
-{
-	spin_lock_bh(&nr_neigh_list_lock);
-	__nr_remove_neigh(nr_neigh);
-	spin_unlock_bh(&nr_neigh_list_lock);
-}
-
 /*
  *	"Delete" a node. Strictly speaking remove a route to a node. The node
  *	is only deleted if no routes are left to it.
@@ -317,29 +352,25 @@ static int nr_del_node(ax25_address *callsign, ax25_address *neighbour, struct n
 {
 	struct nr_node  *nr_node;
 	struct nr_neigh *nr_neigh;
-	int i;
+	int i, ret = -EINVAL;
 
-	nr_node = nr_node_get(callsign);
+	spin_lock_bh(&nr_route_lock);
+
+	nr_node = __nr_node_get(callsign);
 
 	if (nr_node == NULL)
-		return -EINVAL;
+		goto out;
 
-	nr_neigh = nr_neigh_get_dev(neighbour, dev);
+	nr_neigh = __nr_neigh_get_dev(neighbour, dev);
 
 	if (nr_neigh == NULL) {
 		nr_node_put(nr_node);
-		return -EINVAL;
+		goto out;
 	}
 
-	spin_lock_bh(&nr_node_list_lock);
-	nr_node_lock(nr_node);
 	for (i = 0; i < nr_node->count; i++) {
 		if (nr_node->routes[i].neighbour == nr_neigh) {
-			nr_neigh->count--;
-			nr_neigh_put(nr_neigh);
-
-			if (nr_neigh->count == 0 && !nr_neigh->locked)
-				nr_remove_neigh(nr_neigh);
+			nr_neigh_route_put_locked(nr_neigh);
 			nr_neigh_put(nr_neigh);
 
 			nr_node->count--;
@@ -357,20 +388,18 @@ static int nr_del_node(ax25_address *callsign, ax25_address *neighbour, struct n
 				case 2:
 					break;
 				}
-				nr_node_put(nr_node);
 			}
-			nr_node_unlock(nr_node);
-			spin_unlock_bh(&nr_node_list_lock);
-
-			return 0;
+			/* Drop the reference taken by __nr_node_get() */
+			nr_node_put(nr_node);
+			ret = 0;
+			goto out;
 		}
 	}
 	nr_neigh_put(nr_neigh);
-	nr_node_unlock(nr_node);
-	spin_unlock_bh(&nr_node_list_lock);
 	nr_node_put(nr_node);
-
-	return -EINVAL;
+out:
+	spin_unlock_bh(&nr_route_lock);
+	return ret;
 }
 
 /*
@@ -380,44 +409,25 @@ static int __must_check nr_add_neigh(ax25_address *callsign,
 	ax25_digi *ax25_digi, struct net_device *dev, unsigned int quality)
 {
 	struct nr_neigh *nr_neigh;
+	int ret = 0;
 
-	nr_neigh = nr_neigh_get_dev(callsign, dev);
+	spin_lock_bh(&nr_route_lock);
+
+	nr_neigh = __nr_neigh_get_dev(callsign, dev);
 	if (nr_neigh) {
 		nr_neigh->quality = quality;
 		nr_neigh->locked  = 1;
-		nr_neigh_put(nr_neigh);
-		return 0;
-	}
-
-	if ((nr_neigh = kmalloc(sizeof(*nr_neigh), GFP_ATOMIC)) == NULL)
-		return -ENOMEM;
-
-	nr_neigh->callsign = *callsign;
-	nr_neigh->digipeat = NULL;
-	nr_neigh->ax25     = NULL;
-	nr_neigh->dev      = dev;
-	nr_neigh->quality  = quality;
-	nr_neigh->locked   = 1;
-	nr_neigh->count    = 0;
-	nr_neigh->number   = nr_neigh_no++;
-	nr_neigh->failed   = 0;
-	refcount_set(&nr_neigh->refcount, 1);
-
-	if (ax25_digi != NULL && ax25_digi->ndigi > 0) {
-		nr_neigh->digipeat = kmemdup(ax25_digi, sizeof(*ax25_digi),
-					     GFP_KERNEL);
-		if (nr_neigh->digipeat == NULL) {
-			kfree(nr_neigh);
-			return -ENOMEM;
-		}
+	} else {
+		nr_neigh = nr_neigh_create_locked(callsign, ax25_digi, dev,
+						  quality, 1);
+		if (!nr_neigh)
+			ret = -ENOMEM;
 	}
+	if (nr_neigh)
+		nr_neigh_put(nr_neigh);
 
-	spin_lock_bh(&nr_neigh_list_lock);
-	hlist_add_head(&nr_neigh->neigh_node, &nr_neigh_list);
-	/* refcount is initialized at 1 */
-	spin_unlock_bh(&nr_neigh_list_lock);
-
-	return 0;
+	spin_unlock_bh(&nr_route_lock);
+	return ret;
 }
 
 /*
@@ -428,17 +438,23 @@ static int nr_del_neigh(ax25_address *callsign, struct net_device *dev, unsigned
 {
 	struct nr_neigh *nr_neigh;
 
-	nr_neigh = nr_neigh_get_dev(callsign, dev);
+	spin_lock_bh(&nr_route_lock);
 
-	if (nr_neigh == NULL) return -EINVAL;
+	nr_neigh = __nr_neigh_get_dev(callsign, dev);
+
+	if (nr_neigh == NULL) {
+		spin_unlock_bh(&nr_route_lock);
+		return -EINVAL;
+	}
 
 	nr_neigh->quality = quality;
 	nr_neigh->locked  = 0;
 
 	if (nr_neigh->count == 0)
-		nr_remove_neigh(nr_neigh);
+		nr_remove_neigh_locked(nr_neigh);
 	nr_neigh_put(nr_neigh);
 
+	spin_unlock_bh(&nr_route_lock);
 	return 0;
 }
 
@@ -454,9 +470,8 @@ static int nr_dec_obs(void)
 	struct hlist_node *nodet;
 	int i;
 
-	spin_lock_bh(&nr_node_list_lock);
+	spin_lock_bh(&nr_route_lock);
 	nr_node_for_each_safe(s, nodet, &nr_node_list) {
-		nr_node_lock(s);
 		for (i = 0; i < s->count; i++) {
 			switch (s->routes[i].obs_count) {
 			case 0:		/* A locked entry */
@@ -465,11 +480,7 @@ static int nr_dec_obs(void)
 			case 1:		/* From 1 -> 0 */
 				nr_neigh = s->routes[i].neighbour;
 
-				nr_neigh->count--;
-				nr_neigh_put(nr_neigh);
-
-				if (nr_neigh->count == 0 && !nr_neigh->locked)
-					nr_remove_neigh(nr_neigh);
+				nr_neigh_route_put_locked(nr_neigh);
 
 				s->count--;
 
@@ -494,9 +505,8 @@ static int nr_dec_obs(void)
 
 		if (s->count <= 0)
 			nr_remove_node_locked(s);
-		nr_node_unlock(s);
 	}
-	spin_unlock_bh(&nr_node_list_lock);
+	spin_unlock_bh(&nr_route_lock);
 
 	return 0;
 }
@@ -511,14 +521,15 @@ void nr_rt_device_down(struct net_device *dev)
 	struct nr_node  *t;
 	int i;
 
-	spin_lock_bh(&nr_neigh_list_lock);
+	spin_lock_bh(&nr_route_lock);
 	nr_neigh_for_each_safe(s, nodet, &nr_neigh_list) {
 		if (s->dev == dev) {
-			spin_lock_bh(&nr_node_list_lock);
 			nr_node_for_each_safe(t, node2t, &nr_node_list) {
-				nr_node_lock(t);
 				for (i = 0; i < t->count; i++) {
 					if (t->routes[i].neighbour == s) {
+						s->count--;
+						nr_neigh_put(s);
+
 						t->count--;
 
 						switch (i) {
@@ -536,14 +547,12 @@ void nr_rt_device_down(struct net_device *dev)
 
 				if (t->count <= 0)
 					nr_remove_node_locked(t);
-				nr_node_unlock(t);
 			}
-			spin_unlock_bh(&nr_node_list_lock);
 
 			nr_remove_neigh_locked(s);
 		}
 	}
-	spin_unlock_bh(&nr_neigh_list_lock);
+	spin_unlock_bh(&nr_route_lock);
 }
 
 /*
@@ -707,36 +716,35 @@ void nr_link_failed(ax25_cb *ax25, int reason)
 	struct nr_neigh *s, *nr_neigh = NULL;
 	struct nr_node  *nr_node = NULL;
 
-	spin_lock_bh(&nr_neigh_list_lock);
+	/*
+	 * nr_route_frame() replaces nr_neigh->ax25 under nr_route_lock;
+	 * clear it and drop its reference under the same lock, so that the
+	 * two paths cannot both put the same ax25_cb.
+	 */
+	spin_lock_bh(&nr_route_lock);
 	nr_neigh_for_each(s, &nr_neigh_list) {
 		if (s->ax25 == ax25) {
-			nr_neigh_hold(s);
 			nr_neigh = s;
 			break;
 		}
 	}
-	spin_unlock_bh(&nr_neigh_list_lock);
 
 	if (nr_neigh == NULL)
-		return;
+		goto out;
 
 	nr_neigh->ax25 = NULL;
 	ax25_cb_put(ax25);
 
-	if (++nr_neigh->failed < READ_ONCE(sysctl_netrom_link_fails_count)) {
-		nr_neigh_put(nr_neigh);
-		return;
-	}
-	spin_lock_bh(&nr_node_list_lock);
+	if (++nr_neigh->failed < READ_ONCE(sysctl_netrom_link_fails_count))
+		goto out;
+
 	nr_node_for_each(nr_node, &nr_node_list) {
-		nr_node_lock(nr_node);
 		if (nr_node->which < nr_node->count &&
 		    nr_node->routes[nr_node->which].neighbour == nr_neigh)
 			nr_node->which++;
-		nr_node_unlock(nr_node);
 	}
-	spin_unlock_bh(&nr_node_list_lock);
-	nr_neigh_put(nr_neigh);
+out:
+	spin_unlock_bh(&nr_route_lock);
 }
 
 /*
@@ -755,10 +763,11 @@ int nr_route_frame(struct sk_buff *skb, ax25_cb *ax25)
 	struct sk_buff *nskb, *oskb;
 
 	/*
-	 * Reject malformed packets early. Check that it contains at least 2
-	 * addresses and 1 byte more for Time-To-Live
+	 * Reject malformed packets early. Check that it contains at least
+	 * the network and transport headers (20 bytes), and that they are
+	 * in the linear part of the skb.
 	 */
-	if (skb->len < 2 * sizeof(ax25_address) + 1)
+	if (!pskb_may_pull(skb, NR_NETWORK_LEN + NR_TRANSPORT_LEN))
 		return 0;
 
 	nr_src  = (ax25_address *)(skb->data + 0);
@@ -792,10 +801,10 @@ int nr_route_frame(struct sk_buff *skb, ax25_cb *ax25)
 	nr_node = nr_node_get(nr_dest);
 	if (nr_node == NULL)
 		return 0;
-	nr_node_lock(nr_node);
+	spin_lock_bh(&nr_route_lock);
 
 	if (nr_node->which >= nr_node->count) {
-		nr_node_unlock(nr_node);
+		spin_unlock_bh(&nr_route_lock);
 		nr_node_put(nr_node);
 		return 0;
 	}
@@ -803,7 +812,7 @@ int nr_route_frame(struct sk_buff *skb, ax25_cb *ax25)
 	nr_neigh = nr_node->routes[nr_node->which].neighbour;
 
 	if ((dev = nr_dev_first()) == NULL) {
-		nr_node_unlock(nr_node);
+		spin_unlock_bh(&nr_route_lock);
 		nr_node_put(nr_node);
 		return 0;
 	}
@@ -814,7 +823,7 @@ int nr_route_frame(struct sk_buff *skb, ax25_cb *ax25)
 	nskb = skb_copy_expand(skb, dev->hard_header_len, 0, GFP_ATOMIC);
 
 	if (!nskb) {
-		nr_node_unlock(nr_node);
+		spin_unlock_bh(&nr_route_lock);
 		nr_node_put(nr_node);
 		dev_put(dev);
 		return 0;
@@ -836,7 +845,7 @@ int nr_route_frame(struct sk_buff *skb, ax25_cb *ax25)
 
 	dev_put(dev);
 	ret = (nr_neigh->ax25 != NULL);
-	nr_node_unlock(nr_node);
+	spin_unlock_bh(&nr_route_lock);
 	nr_node_put(nr_node);
 
 	if (ret)
@@ -848,9 +857,9 @@ int nr_route_frame(struct sk_buff *skb, ax25_cb *ax25)
 #ifdef CONFIG_PROC_FS
 
 static void *nr_node_start(struct seq_file *seq, loff_t *pos)
-	__acquires(&nr_node_list_lock)
+	__acquires(&nr_route_lock)
 {
-	spin_lock_bh(&nr_node_list_lock);
+	spin_lock_bh(&nr_route_lock);
 	return seq_hlist_start_head(&nr_node_list, *pos);
 }
 
@@ -860,9 +869,9 @@ static void *nr_node_next(struct seq_file *seq, void *v, loff_t *pos)
 }
 
 static void nr_node_stop(struct seq_file *seq, void *v)
-	__releases(&nr_node_list_lock)
+	__releases(&nr_route_lock)
 {
-	spin_unlock_bh(&nr_node_list_lock);
+	spin_unlock_bh(&nr_route_lock);
 }
 
 static int nr_node_show(struct seq_file *seq, void *v)
@@ -877,7 +886,6 @@ static int nr_node_show(struct seq_file *seq, void *v)
 		struct nr_node *nr_node = hlist_entry(v, struct nr_node,
 						      node_node);
 
-		nr_node_lock(nr_node);
 		seq_printf(seq, "%-9s %-7s  %d %d",
 			ax2asc(buf, &nr_node->callsign),
 			(nr_node->mnemonic[0] == '\0') ? "*" : nr_node->mnemonic,
@@ -890,7 +898,6 @@ static int nr_node_show(struct seq_file *seq, void *v)
 				nr_node->routes[i].obs_count,
 				nr_node->routes[i].neighbour->number);
 		}
-		nr_node_unlock(nr_node);
 
 		seq_puts(seq, "\n");
 	}
@@ -905,9 +912,9 @@ const struct seq_operations nr_node_seqops = {
 };
 
 static void *nr_neigh_start(struct seq_file *seq, loff_t *pos)
-	__acquires(&nr_neigh_list_lock)
+	__acquires(&nr_route_lock)
 {
-	spin_lock_bh(&nr_neigh_list_lock);
+	spin_lock_bh(&nr_route_lock);
 	return seq_hlist_start_head(&nr_neigh_list, *pos);
 }
 
@@ -917,9 +924,9 @@ static void *nr_neigh_next(struct seq_file *seq, void *v, loff_t *pos)
 }
 
 static void nr_neigh_stop(struct seq_file *seq, void *v)
-	__releases(&nr_neigh_list_lock)
+	__releases(&nr_route_lock)
 {
-	spin_unlock_bh(&nr_neigh_list_lock);
+	spin_unlock_bh(&nr_route_lock);
 }
 
 static int nr_neigh_show(struct seq_file *seq, void *v)
@@ -970,12 +977,9 @@ void nr_rt_free(void)
 	struct nr_node  *t = NULL;
 	struct hlist_node *nodet;
 
-	spin_lock_bh(&nr_neigh_list_lock);
-	spin_lock_bh(&nr_node_list_lock);
+	spin_lock_bh(&nr_route_lock);
 	nr_node_for_each_safe(t, nodet, &nr_node_list) {
-		nr_node_lock(t);
 		nr_remove_node_locked(t);
-		nr_node_unlock(t);
 	}
 	nr_neigh_for_each_safe(s, nodet, &nr_neigh_list) {
 		while(s->count) {
@@ -984,6 +988,5 @@ void nr_rt_free(void)
 		}
 		nr_remove_neigh_locked(s);
 	}
-	spin_unlock_bh(&nr_node_list_lock);
-	spin_unlock_bh(&nr_neigh_list_lock);
+	spin_unlock_bh(&nr_route_lock);
 }
diff --git a/net/rose/af_rose.c b/net/rose/af_rose.c
index 48b82fe3bee1..4fca64156640 100644
--- a/net/rose/af_rose.c
+++ b/net/rose/af_rose.c
@@ -598,6 +598,7 @@ static int rose_create(struct net *net, struct socket *sock, int protocol,
 	rose = rose_sk(sk);
 
 	sock_init_data(sock, sk);
+	sk->sk_backlog_rcv = rose_backlog_rcv;
 
 	skb_queue_head_init(&rose->ack_queue);
 #ifdef M_BIT
@@ -637,6 +638,7 @@ static struct sock *rose_make_new(struct sock *osk)
 	rose = rose_sk(sk);
 
 	sock_init_data(NULL, sk);
+	sk->sk_backlog_rcv = rose_backlog_rcv;
 
 	skb_queue_head_init(&rose->ack_queue);
 #ifdef M_BIT
@@ -1326,7 +1328,10 @@ static int rose_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 	skb_queue_tail(&sk->sk_write_queue, skb);	/* Shove it onto the queue */
 #endif
 
+	/* The receive path and the timers run rose_kick() too */
+	lock_sock(sk);
 	rose_kick(sk);
+	release_sock(sk);
 
 	return len;
 }
diff --git a/net/rose/rose_in.c b/net/rose/rose_in.c
index ac20f318008d..4eec54b24afb 100644
--- a/net/rose/rose_in.c
+++ b/net/rose/rose_in.c
@@ -310,3 +310,34 @@ int rose_process_rx_frame(struct sock *sk, struct sk_buff *skb)
 
 	return queued;
 }
+
+/*
+ * Frames for a socket are processed with the socket locked, as the timers
+ * already do: rose_kick() may be running in rose_sendmsg() on another CPU,
+ * and two of them reading the same V(S) send two different frames under the
+ * same N(S). If a process owns the socket the frame goes to its backlog and
+ * is processed when the socket is released. Returns non-zero if the skb has
+ * been consumed.
+ */
+int rose_rcv_frame(struct sock *sk, struct sk_buff *skb)
+{
+	int queued;
+
+	bh_lock_sock(sk);
+	if (!sock_owned_by_user(sk))
+		queued = rose_process_rx_frame(sk, skb);
+	else
+		queued = !sk_add_backlog(sk, skb, READ_ONCE(sk->sk_rcvbuf) +
+						  READ_ONCE(sk->sk_sndbuf));
+	bh_unlock_sock(sk);
+
+	return queued;
+}
+
+int rose_backlog_rcv(struct sock *sk, struct sk_buff *skb)
+{
+	if (!rose_process_rx_frame(sk, skb))
+		kfree_skb(skb);
+
+	return 0;
+}
diff --git a/net/rose/rose_link.c b/net/rose/rose_link.c
index 36b6778d8e54..1fe48d58726f 100644
--- a/net/rose/rose_link.c
+++ b/net/rose/rose_link.c
@@ -142,6 +142,14 @@ void rose_link_rx_restart(struct sk_buff *skb, struct rose_neigh *neigh, unsigne
 
 	switch (frametype) {
 	case ROSE_RESTART_REQUEST:
+		/*
+		 * A Restart Request on a link that is already up means that
+		 * the other end has lost its virtual circuits, clear ours.
+		 * Nothing is established over a link that is not up yet, and
+		 * the calls waiting in neigh->queue must be left alone.
+		 */
+		if (neigh->restarted)
+			rose_link_restarted(neigh);
 		rose_stop_t0timer(neigh);
 		neigh->restarted = 1;
 		neigh->dce_mode  = (skb->data[3] == ROSE_DTE_ORIGINATED);
@@ -259,6 +267,40 @@ void rose_transmit_clear_request(struct rose_neigh *neigh, unsigned int lci, uns
 		kfree_skb(skb);
 }
 
+/*
+ * A neighbour has just been created while an AX.25 connection to it is
+ * already up, e.g. it was removed from the routing tables and added back.
+ * The other end still regards the link as restarted and will not restart it,
+ * and through calls only use restarted neighbours, so nothing would ever
+ * restart it from this end either: do it now.
+ */
+void rose_link_restart(struct rose_neigh *neigh)
+{
+	if (neigh->loopback || neigh->restarted || rose_t0timer_running(neigh))
+		return;
+
+	if (!rose_link_up(neigh))
+		return;
+
+	rose_transmit_restart_request(neigh);
+	neigh->dce_mode = 0;
+	rose_start_t0timer(neigh);
+}
+
+/*
+ * Start the restart procedure on a link that is down without waiting for
+ * a frame to send over it. Nothing is done while a restart is under way.
+ */
+void rose_link_bring_up(struct rose_neigh *neigh)
+{
+	if (neigh->loopback || neigh->restarted || rose_t0timer_running(neigh))
+		return;
+
+	rose_transmit_restart_request(neigh);
+	neigh->dce_mode = 0;
+	rose_start_t0timer(neigh);
+}
+
 void rose_transmit_link(struct sk_buff *skb, struct rose_neigh *neigh)
 {
 	unsigned char *dptr;
diff --git a/net/rose/rose_loopback.c b/net/rose/rose_loopback.c
index fd4e4795776a..4e4a473910cc 100644
--- a/net/rose/rose_loopback.c
+++ b/net/rose/rose_loopback.c
@@ -107,7 +107,7 @@ static void rose_loopback_timer(struct timer_list *unused)
 
 		sk = rose_find_socket(lci_o, rose_loopback_neigh);
 		if (sk) {
-			if (rose_process_rx_frame(sk, skb) == 0)
+			if (rose_rcv_frame(sk, skb) == 0)
 				kfree_skb(skb);
 			continue;
 		}
diff --git a/net/rose/rose_out.c b/net/rose/rose_out.c
index 9050e33c9604..6672fc65a765 100644
--- a/net/rose/rose_out.c
+++ b/net/rose/rose_out.c
@@ -34,6 +34,7 @@ static void rose_send_iframe(struct sock *sk, struct sk_buff *skb)
 	if (skb == NULL)
 		return;
 
+	skb->data[2] &= ROSE_M_BIT;
 	skb->data[2] |= (rose->vr << 5) & 0xE0;
 	skb->data[2] |= (rose->vs << 1) & 0x0E;
 
diff --git a/net/rose/rose_route.c b/net/rose/rose_route.c
index fd196f2e2fd6..6a1de0055e28 100644
--- a/net/rose/rose_route.c
+++ b/net/rose/rose_route.c
@@ -53,6 +53,7 @@ static int __must_check rose_add_node(struct rose_route_struct *rose_route,
 {
 	struct rose_node  *rose_node, *rose_tmpn, *rose_tmpp;
 	struct rose_neigh *rose_neigh;
+	bool new_neigh = false;
 	int i, res = 0;
 
 	spin_lock_bh(&rose_node_list_lock);
@@ -125,6 +126,7 @@ static int __must_check rose_add_node(struct rose_route_struct *rose_route,
 
 		rose_neigh->next = rose_neigh_list;
 		rose_neigh_list  = rose_neigh;
+		new_neigh        = true;
 	}
 
 	/*
@@ -192,6 +194,14 @@ static int __must_check rose_add_node(struct rose_route_struct *rose_route,
 	}
 
 out:
+	/*
+	 * The AX.25 connection of a neighbour that was removed from the tables
+	 * outlives it. If it is still there, the other end will not restart
+	 * the link: do it from here.
+	 */
+	if (new_neigh && res == 0)
+		rose_link_restart(rose_neigh);
+
 	spin_unlock_bh(&rose_neigh_list_lock);
 	spin_unlock_bh(&rose_node_list_lock);
 
@@ -285,6 +295,49 @@ static void rose_remove_route(struct rose_route *rose_route)
 	}
 }
 
+/*
+ *	A neighbour is being removed from the tables while its link may still
+ *	be up (route deleted or routes cleared by the configuration). Clear the
+ *	through routes using it, on both sides since both can still be reached,
+ *	instead of leaving them in rose_route_list for ever: no frame can reach
+ *	them once the neighbour is gone. Local connections using it are cut too,
+ *	as rose_link_failed() does.
+ *
+ *	Caller is holding rose_node_list_lock and rose_neigh_list_lock, taken
+ *	before rose_route_list_lock as in rose_route_frame() and
+ *	rose_link_failed().
+ */
+static void rose_neigh_clear_routes(struct rose_neigh *rose_neigh)
+{
+	struct rose_route *rose_route, *s;
+
+	spin_lock_bh(&rose_route_list_lock);
+
+	rose_route = rose_route_list;
+	while (rose_route != NULL) {
+		s = rose_route->next;
+
+		if (rose_route->neigh1 == rose_neigh ||
+		    rose_route->neigh2 == rose_neigh) {
+			if (rose_route->neigh1 != NULL)
+				rose_transmit_clear_request(rose_route->neigh1,
+							    rose_route->lci1,
+							    ROSE_OUT_OF_ORDER, 0);
+			if (rose_route->neigh2 != NULL)
+				rose_transmit_clear_request(rose_route->neigh2,
+							    rose_route->lci2,
+							    ROSE_OUT_OF_ORDER, 0);
+			rose_remove_route(rose_route);
+		}
+
+		rose_route = s;
+	}
+
+	spin_unlock_bh(&rose_route_list_lock);
+
+	rose_kill_by_neigh(rose_neigh);
+}
+
 /*
  *	"Delete" a node. Strictly speaking remove a route to a node. The node
  *	is only deleted if no routes are left to it.
@@ -333,6 +386,7 @@ static int rose_del_node(struct rose_route_struct *rose_route,
 			rose_neigh_put(rose_neigh);
 
 			if (rose_neigh->count == 0) {
+				rose_neigh_clear_routes(rose_neigh);
 				rose_remove_neigh(rose_neigh);
 				rose_neigh_put(rose_neigh);
 			}
@@ -547,8 +601,8 @@ void rose_route_device_down(struct net_device *dev)
 #endif
 
 /*
- *	Clear all nodes and neighbours out, except for neighbours with
- *	active connections going through them.
+ *	Clear all nodes and neighbours out, with the through routes and
+ *	connections using those neighbours.
  *  Do not clear loopback neighbour and nodes.
  */
 static int rose_clear_routes(void)
@@ -579,6 +633,7 @@ static int rose_clear_routes(void)
 		rose_neigh = rose_neigh->next;
 
 		if (!s->loopback) {
+			rose_neigh_clear_routes(s);
 			rose_remove_neigh(s);
 			rose_neigh_put(s);
 		}
@@ -686,6 +741,7 @@ struct rose_neigh *rose_get_neigh(rose_address *addr, unsigned char *cause,
 	unsigned char *diagnostic, int route_frame)
 {
 	struct rose_neigh *res = NULL;
+	struct rose_neigh *down = NULL;
 	struct rose_node *node;
 	int failed = 0;
 	int i;
@@ -697,8 +753,21 @@ struct rose_neigh *rose_get_neigh(rose_address *addr, unsigned char *cause,
 				if (node->neighbour[i]->restarted) {
 					res = node->neighbour[i];
 					rose_neigh_hold(node->neighbour[i]);
+					/*
+					 * A neighbour of a more specific route
+					 * was passed over because its link is
+					 * down: this call does not wait for it,
+					 * but have the link brought up for the
+					 * next ones.
+					 */
+					if (down)
+						rose_link_bring_up(down);
 					goto out;
 				}
+				/* The first one is the preferred one. */
+				if (!route_frame && !down &&
+				    !rose_ftimer_running(node->neighbour[i]))
+					down = node->neighbour[i];
 			}
 		}
 	}
@@ -772,19 +841,15 @@ int rose_rt_ioctl(unsigned int cmd, void __user *arg)
 	return 0;
 }
 
-static void rose_del_route_by_neigh(struct rose_neigh *rose_neigh)
+/*
+ *	Blow away the through routes using this neighbour: the half on the
+ *	neighbour is dropped and the other half is told with a Clear Request.
+ *	The caller holds rose_route_list_lock.
+ */
+static void rose_clear_routes_by_neigh(struct rose_neigh *rose_neigh)
 {
 	struct rose_route *rose_route, *s;
 
-	rose_neigh->restarted = 0;
-
-	rose_stop_t0timer(rose_neigh);
-	rose_start_ftimer(rose_neigh);
-
-	skb_queue_purge(&rose_neigh->queue);
-
-	spin_lock_bh(&rose_route_list_lock);
-
 	rose_route = rose_route_list;
 
 	while (rose_route != NULL) {
@@ -811,9 +876,37 @@ static void rose_del_route_by_neigh(struct rose_neigh *rose_neigh)
 
 		rose_route = rose_route->next;
 	}
+}
+
+static void rose_del_route_by_neigh(struct rose_neigh *rose_neigh)
+{
+	rose_neigh->restarted = 0;
+
+	rose_stop_t0timer(rose_neigh);
+	rose_start_ftimer(rose_neigh);
+
+	skb_queue_purge(&rose_neigh->queue);
+
+	spin_lock_bh(&rose_route_list_lock);
+	rose_clear_routes_by_neigh(rose_neigh);
 	spin_unlock_bh(&rose_route_list_lock);
 }
 
+/*
+ *	The neighbour has restarted a link that was up: it has lost every
+ *	virtual circuit that ran over it. Blow away the through routes and
+ *	the connections using this neighbour, the link itself stays up.
+ *	Called from rose_route_frame() with rose_neigh_list_lock and
+ *	rose_route_list_lock held.
+ */
+void rose_link_restarted(struct rose_neigh *rose_neigh)
+{
+	lockdep_assert_held(&rose_route_list_lock);
+
+	rose_clear_routes_by_neigh(rose_neigh);
+	rose_kill_by_neigh(rose_neigh);
+}
+
 /*
  * 	A level 2 link has timed out, therefore it appears to be a poor link,
  *	then don't use that neighbour until it is reset. Blow away all through
@@ -962,7 +1055,7 @@ int rose_route_frame(struct sk_buff *skb, ax25_cb *ax25)
 		}
 		else {
 			skb_reset_transport_header(skb);
-			res = rose_process_rx_frame(sk, skb);
+			res = rose_rcv_frame(sk, skb);
 			goto out;
 		}
 	}
diff --git a/security/keys/key.c b/security/keys/key.c
index aebcf7c66436..6e6cd146e6b8 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -588,11 +588,18 @@ int key_reject_and_link(struct key *key,
 	ret = -EBUSY;
 
 	if (keyring) {
-		if (keyring->restrict_link)
-			return -EPERM;
-
 		link_ret = __key_link_lock(keyring, &key->index_key);
 		if (link_ret == 0) {
+			/*
+			 * Check the restriction under the keyring semaphore.
+			 * keyring_restrict() installs it while holding the
+			 * semaphore, so testing it beforehand races with a
+			 * concurrent restriction install.
+			 */
+			if (keyring->restrict_link) {
+				__key_link_end(keyring, &key->index_key, edit);
+				return -EPERM;
+			}
 			link_ret = __key_link_begin(keyring, &key->index_key, &edit);
 			if (link_ret < 0)
 				__key_link_end(keyring, &key->index_key, edit);
diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 11bedca4e1c6..0fc520de9995 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -677,12 +677,14 @@ long keyctl_describe_key(key_serial_t keyid,
 
 	/* calculate how much information we're going to return */
 	ret = -ENOMEM;
+	down_read(&key->sem);
 	infobuf = kasprintf(GFP_KERNEL,
 			    "%s;%d;%d;%08x;",
 			    key->type->name,
 			    from_kuid_munged(current_user_ns(), key->uid),
 			    from_kgid_munged(current_user_ns(), key->gid),
 			    key->perm);
+	up_read(&key->sem);
 	if (!infobuf)
 		goto error2;
 	infolen = strlen(infobuf);
@@ -806,8 +808,12 @@ static long __keyctl_read_key(struct key *key, char *buffer, size_t buflen)
 
 	down_read(&key->sem);
 	ret = key_validate(key);
-	if (ret == 0)
-		ret = key->type->read(key, buffer, buflen);
+	if (ret == 0) {
+		if (key->type->read)
+			ret = key->type->read(key, buffer, buflen);
+		else
+			ret = -EOPNOTSUPP;
+	}
 	up_read(&key->sem);
 	return ret;
 }
@@ -861,11 +867,6 @@ long keyctl_read_key(key_serial_t keyid, char __user *buffer, size_t buflen)
 
 	/* the key is probably readable - now try to read it */
 can_read_key:
-	if (!key->type->read) {
-		ret = -EOPNOTSUPP;
-		goto key_put_out;
-	}
-
 	if (!buffer || !buflen) {
 		/* Get the key length from the read method */
 		ret = __keyctl_read_key(key, NULL, 0);
diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index fd95a0eb7a46..74ed1372d22c 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -14,6 +14,9 @@
 #include <linux/err.h>
 #include <linux/user_namespace.h>
 #include <linux/nsproxy.h>
+#include <linux/once.h>
+#include <linux/random.h>
+#include <linux/siphash.h>
 #include <keys/keyring-type.h>
 #include <keys/user-type.h>
 #include <linux/assoc_array_priv.h>
@@ -147,49 +150,46 @@ static int keyring_instantiate(struct key *keyring,
 }
 
 /*
- * Multiply 64-bits by 32-bits to 96-bits and fold back to 64-bit.  Ideally we'd
- * fold the carry back too, but that requires inline asm.
+ * Give key types and domains address-independent identities.  Zero means that
+ * an ID has not yet been allocated.  As with inode sequence numbers used by
+ * futexes, this relies on the 64-bit counter not wrapping in a machine's
+ * lifetime.
  */
-static u64 mult_64x32_and_fold(u64 x, u32 y)
+static u64 key_index_id(atomic64_t *id)
 {
-	u64 hi = (u64)(u32)(x >> 32) * y;
-	u64 lo = (u64)(u32)(x) * y;
-	return lo + ((u64)(u32)hi << 32) + (u32)(hi >> 32);
+	static atomic64_t next_id;
+	u64 old, new;
+
+	old = atomic64_read(id);
+	if (likely(old))
+		return old;
+
+	do {
+		new = atomic64_inc_return(&next_id);
+	} while (WARN_ON_ONCE(!new));
+
+	old = 0;
+	if (!atomic64_try_cmpxchg_relaxed(id, &old, new))
+		return old;
+	return new;
 }
 
 /*
- * Hash a key type and description.
+ * Hash a key type, domain and description.  KEYCTL_READ exposes the tree's
+ * traversal order, so no part of the index may contain kernel addresses.
  */
 static void hash_key_type_and_desc(struct keyring_index_key *index_key)
 {
 	const unsigned level_shift = ASSOC_ARRAY_LEVEL_STEP;
 	const unsigned long fan_mask = ASSOC_ARRAY_FAN_MASK;
-	const char *description = index_key->description;
-	unsigned long hash, type;
-	u32 piece;
+	static siphash_key_t hash_key __read_mostly;
+	unsigned long hash;
 	u64 acc;
-	int n, desc_len = index_key->desc_len;
-
-	type = (unsigned long)index_key->type;
-	acc = mult_64x32_and_fold(type, desc_len + 13);
-	acc = mult_64x32_and_fold(acc, 9207);
-	piece = (unsigned long)index_key->domain_tag;
-	acc = mult_64x32_and_fold(acc, piece);
-	acc = mult_64x32_and_fold(acc, 9207);
-
-	for (;;) {
-		n = desc_len;
-		if (n <= 0)
-			break;
-		if (n > 4)
-			n = 4;
-		piece = 0;
-		memcpy(&piece, description, n);
-		description += n;
-		desc_len -= n;
-		acc = mult_64x32_and_fold(acc, piece);
-		acc = mult_64x32_and_fold(acc, 9207);
-	}
+
+	get_random_once(&hash_key, sizeof(hash_key));
+	acc = siphash(index_key->description, index_key->desc_len, &hash_key);
+	acc = siphash_3u64(index_key->type_id, index_key->domain_id, acc,
+			   &hash_key);
 
 	/* Fold the hash down to 32 bits if need be. */
 	hash = acc;
@@ -209,7 +209,7 @@ static void hash_key_type_and_desc(struct keyring_index_key *index_key)
 
 /*
  * Finalise an index key to include a part of the description actually in the
- * index key, to set the domain tag and to calculate the hash.
+ * index key, to set the domain tag and index IDs, and to calculate the hash.
  */
 void key_set_index_key(struct keyring_index_key *index_key)
 {
@@ -225,6 +225,14 @@ void key_set_index_key(struct keyring_index_key *index_key)
 			index_key->domain_tag = &default_domain_tag;
 	}
 
+	/* Preserve the IDs when copying an existing key's index.  In
+	 * particular, its type may already have been unregistered.
+	 */
+	if (!index_key->type_id)
+		index_key->type_id = key_index_id(&index_key->type->index_id);
+	if (!index_key->domain_id)
+		index_key->domain_id = key_index_id(&index_key->domain_tag->index_id);
+
 	hash_key_type_and_desc(index_key);
 }
 
@@ -263,15 +271,19 @@ void key_remove_domain(struct key_tag *domain_tag)
 /*
  * Build the next index key chunk.
  *
+ * The hash and inline description are followed by the 64-bit type and domain
+ * IDs, low word first, and then by the rest of the description.
  * We return it one word-sized chunk at a time.
  */
 static unsigned long keyring_get_key_chunk(const void *data, int level)
 {
+	const unsigned int id_chunks = sizeof(u64) / sizeof(unsigned long);
 	const struct keyring_index_key *index_key = data;
+	int desc_len = index_key->desc_len;
 	unsigned long chunk = 0;
-	const u8 *d;
-	int desc_len = index_key->desc_len, n = sizeof(chunk);
+	int n = sizeof(chunk);
 	unsigned int offset;
+	const u8 *d;
 
 	level /= ASSOC_ARRAY_KEY_CHUNK_SIZE;
 	switch (level) {
@@ -279,27 +291,30 @@ static unsigned long keyring_get_key_chunk(const void *data, int level)
 		return index_key->hash;
 	case 1:
 		return index_key->x;
-	case 2:
-		return (unsigned long)index_key->type;
-	case 3:
-		return (unsigned long)index_key->domain_tag;
-	default:
-		level -= 4;
-		offset = sizeof(index_key->desc) + level * sizeof(long);
-		if (desc_len <= offset)
-			return 0;
-
-		d = index_key->description + offset;
-		desc_len -= offset;
-		if (desc_len > n)
-			desc_len = n;
-		d += desc_len;
-		do {
-			chunk <<= 8;
-			chunk |= *--d;
-		} while (--desc_len > 0);
-		return chunk;
 	}
+
+	level -= 2;
+	if (level < id_chunks)
+		return index_key->type_id >> (level * ASSOC_ARRAY_KEY_CHUNK_SIZE);
+	level -= id_chunks;
+	if (level < id_chunks)
+		return index_key->domain_id >> (level * ASSOC_ARRAY_KEY_CHUNK_SIZE);
+	level -= id_chunks;
+
+	offset = sizeof(index_key->desc) + level * sizeof(long);
+	if (desc_len <= offset)
+		return 0;
+
+	d = index_key->description + offset;
+	desc_len -= offset;
+	if (desc_len > n)
+		desc_len = n;
+	d += desc_len;
+	do {
+		chunk <<= 8;
+		chunk |= *--d;
+	} while (--desc_len > 0);
+	return chunk;
 }
 
 static unsigned long keyring_get_object_key_chunk(const void *object, int level)
@@ -331,6 +346,7 @@ static int keyring_diff_objects(const void *object, const void *data)
 	const struct keyring_index_key *b = data;
 	unsigned long seg_a, seg_b;
 	int level, i;
+	u64 diff;
 
 	level = 0;
 	seg_a = a->hash;
@@ -339,28 +355,22 @@ static int keyring_diff_objects(const void *object, const void *data)
 		goto differ;
 	level += ASSOC_ARRAY_KEY_CHUNK_SIZE / 8;
 
-	/* The number of bits contributed by the hash is controlled by a
-	 * constant in the assoc_array headers.  Everything else thereafter we
-	 * can deal with as being machine word-size dependent.
-	 */
+	/* The inline description contributes one machine-word-sized chunk. */
 	seg_a = a->x;
 	seg_b = b->x;
 	if ((seg_a ^ seg_b) != 0)
 		goto differ;
 	level += sizeof(unsigned long);
 
-	/* The next bit may not work on big endian */
-	seg_a = (unsigned long)a->type;
-	seg_b = (unsigned long)b->type;
-	if ((seg_a ^ seg_b) != 0)
-		goto differ;
-	level += sizeof(unsigned long);
+	diff = a->type_id ^ b->type_id;
+	if (diff)
+		return level * 8 + __ffs64(diff);
+	level += sizeof(u64);
 
-	seg_a = (unsigned long)a->domain_tag;
-	seg_b = (unsigned long)b->domain_tag;
-	if ((seg_a ^ seg_b) != 0)
-		goto differ;
-	level += sizeof(unsigned long);
+	diff = a->domain_id ^ b->domain_id;
+	if (diff)
+		return level * 8 + __ffs64(diff);
+	level += sizeof(u64);
 
 	i = sizeof(a->desc);
 	if (a->desc_len <= i)
@@ -1158,7 +1168,7 @@ struct key *find_keyring_by_name(const char *name, bool uid_keyring)
 	 * grants Search permission and that hasn't been revoked
 	 */
 	list_for_each_entry(keyring, &ns->keyring_name_list, name_link) {
-		if (!kuid_has_mapping(ns, keyring->user->uid))
+		if (!kuid_has_mapping(ns, keyring->uid))
 			continue;
 
 		if (test_bit(KEY_FLAG_REVOKED, &keyring->flags))
diff --git a/security/keys/process_keys.c b/security/keys/process_keys.c
index b5d5333ab330..4b2b8a75eb1f 100644
--- a/security/keys/process_keys.c
+++ b/security/keys/process_keys.c
@@ -556,9 +556,8 @@ key_ref_t search_process_keyrings_rcu(struct keyring_search_context *ctx)
 	    ) {
 		const struct cred *cred = ctx->cred;
 
-		if (key_validate(cred->request_key_auth) == 0) {
-			rka = ctx->cred->request_key_auth->payload.data[0];
-
+		rka = dereference_key_rcu(cred->request_key_auth);
+		if (rka && key_validate(cred->request_key_auth) == 0) {
 			//// was search_process_keyrings() [ie. recursive]
 			ctx->cred = rka->cred;
 			key_ref = search_cred_keyrings_rcu(ctx);
diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
index ea6717da7cba..03a1f289a3c4 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -921,8 +921,10 @@ static int trusted_tpm_unseal(struct trusted_key_payload *p, char *datablob)
 		ret = tpm2_unseal_trusted(chip, p, options);
 	else
 		ret = key_unseal(p, options);
-	if (ret < 0)
+	if (ret < 0) {
 		pr_info("key_unseal failed (%d)\n", ret);
+		goto out;
+	}
 
 	if (options->pcrlock) {
 		ret = pcrlock(options->pcrlock);
diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index aae81332e33d..e841014a44d2 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -124,7 +124,7 @@ static int tpm2_key_decode(struct trusted_key_payload *payload,
 	if (ctx.priv_len + ctx.pub_len > MAX_BLOB_SIZE)
 		return -EINVAL;
 
-	blob = kmalloc(ctx.priv_len + ctx.pub_len + 4, GFP_KERNEL);
+	blob = kmalloc(ctx.priv_len + ctx.pub_len, GFP_KERNEL);
 	if (!blob)
 		return -ENOMEM;
 
diff --git a/tools/testing/selftests/ftrace/test.d/filter/event-filter-incomplete.tc b/tools/testing/selftests/ftrace/test.d/filter/event-filter-incomplete.tc
new file mode 100644
index 000000000000..cc6df762845f
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/filter/event-filter-incomplete.tc
@@ -0,0 +1,24 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: event filter - reject incomplete logical expressions
+# requires: events/sched/sched_switch/filter
+# flags: instance
+
+filter=events/sched/sched_switch/filter
+
+for base in \
+    'common_pid == 1' \
+    'common_pid == 1 || common_pid == 2' \
+    'common_pid == 1 && common_pid == 2' \
+    '!(common_pid == 1 || common_pid == 2)'
+do
+    printf '%s' "$base" > "$filter"
+    for tail in '&&' '||' '&& !' '|| !' '&& !! ' '|| !! '; do
+        if printf '%s' "$base $tail" > "$filter" 2>/dev/null; then
+            echo "Accepted incomplete filter: $base $tail"
+            exit_fail
+        fi
+    done
+done
+
+echo 0 > "$filter"

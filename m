Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3E83D566F
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 09:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788945961; cv=none; b=eOkf9ZEAcRyE7gNasB/7edXADVik/No24eQIafHF7lhzym6VGI1hCJks4LuqbtT0zlVVeXbjMbHeLCpBe6g28OGxYOVdC/+zFPeI9E2eL6NikoE5L3WP33e4KmjA78fnulkqOyhwfAKY2YtV3akzYk7NNHJgtsN4B3mIhidlLkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788945961; c=relaxed/simple;
	bh=W8MzkOpPec4fkM+kJvjeelD08tjGu1mVOJGu+AAy2uQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IsUK2I1u+c9ATB9TizWafDZZfNIvl3w5qXIf/LTfEcUkS7XBhNlCpII7c5d3S93EQcPlQ3dupVZ1UHs/mwnjQxzYYVhB1SxIhIWf5I22jFEbfjVKRiiuBtrpjRO9yOoy16Dwwkgbm3VnXDSGz/rb++pGHMaOwLpYxQZwxmLYVwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQPld5CC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQPld5CC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 445A41F00A3A;
	Wed,  9 Sep 2026 09:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788945959;
	bh=g8Y+/KKdss3r0Xb8j3nvy7SRJffq2J+vlhcyAwRhbxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WQPld5CCZyMe9ZOCLQw+2gz2yaTV4P6LoMobOeK0DS5M91T0fOojJSIvR2QNBN5LK
	 U5jn8z3nUdYlwty8xP8d7u7JtBlLRK3ikxSatYdr/7Ousmqblv+dDWv462+AUlZS0A
	 oGWYh+hNjcVNjGjcCDMslZFZK1pJ4xKKOSFOPHtqrIOfXNK1GKeqo0z2nkpBk0ETwi
	 nxnleSChjaVFGcTTojueydciVcuUxVVxcO4ESCejVmT5x6h9XSI2ElVA0yerzrEy9a
	 p/9ERFoEwhK3c9qbTjdtdoJc7tDT4slLKS1WPjam/Va5eTG5ESSEzX+21FTS9NZOy6
	 7C98+dFu1cyzA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] RDMA/ionic: Embed counter driver data in rdma_counter allocation
Date: Wed,  9 Sep 2026 05:25:57 -0400
Message-ID: <20260909092557.1293246-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090319-cesspool-drapery-a749@gregkh>
References: <2026090319-cesspool-drapery-a749@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Abhijit Gangurde <abhijit.gangurde@amd.com>

[ Upstream commit cf3ebd89e754015625fee90aa938f6bc79a2c974 ]

Commit 7e53b31acc7f ("RDMA/core: Create and destroy rdma_counter using
rdma_zalloc_drv_obj()") requires drivers implementing counter ops to
embed struct rdma_counter in a driver-specific struct, register its size
via INIT_RDMA_OBJ_SIZE, and provide a counter_init callback.

The ionic driver was merged without this adaptation, causing a NULL
pointer dereference in alloc_and_bind() since rdma_zalloc_drv_obj()
allocates zero bytes when size_rdma_counter is unset.

Consolidate struct ionic_counter into a new struct ionic_rdma_counter
that embeds struct rdma_counter, replace the xarray with a lightweight
ida for ID allocation, and add the required counter_init and
INIT_RDMA_OBJ_SIZE declarations.

Fixes: ea4c399642b8 ("RDMA/ionic: Implement device stats ops")
Cc: stable@vger.kernel.org # 6.18
Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
Link: https://patch.msgid.link/20260805053254.4023262-2-abhijit.gangurde@amd.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
[ adapted kzalloc_obj(*cntr) removal to the older kzalloc(sizeof(*cntr), GFP_KERNEL) allocation. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/ionic/ionic_hw_stats.c | 95 +++++++++-----------
 drivers/infiniband/hw/ionic/ionic_ibdev.h    | 11 ++-
 2 files changed, 51 insertions(+), 55 deletions(-)

diff --git a/drivers/infiniband/hw/ionic/ionic_hw_stats.c b/drivers/infiniband/hw/ionic/ionic_hw_stats.c
index 244a80dde08f3..1ed1ee4a209fe 100644
--- a/drivers/infiniband/hw/ionic/ionic_hw_stats.c
+++ b/drivers/infiniband/hw/ionic/ionic_hw_stats.c
@@ -237,35 +237,34 @@ static int ionic_get_hw_stats(struct ib_device *ibdev,
 static struct rdma_hw_stats *
 ionic_counter_alloc_stats(struct rdma_counter *counter)
 {
+	struct ionic_rdma_counter *cntr = to_ionic_rdma_counter(counter);
 	struct ionic_ibdev *dev = to_ionic_ibdev(counter->device);
-	struct ionic_counter *cntr;
-	int err;
+	struct rdma_hw_stats *stats;
+	int id;
 
-	cntr = kzalloc(sizeof(*cntr), GFP_KERNEL);
-	if (!cntr)
-		return NULL;
-
-	/* buffer for current values from the device */
 	cntr->vals = kzalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!cntr->vals)
-		goto err_vals;
+		return NULL;
 
-	err = xa_alloc(&dev->counter_stats->xa_counters, &counter->id,
-		       cntr,
-		       XA_LIMIT(0, IONIC_MAX_QPID),
-		       GFP_KERNEL);
-	if (err)
-		goto err_xa;
+	id = ida_alloc_max(&dev->counter_stats->counter_ida,
+			   IONIC_MAX_QPID, GFP_KERNEL);
+	if (id < 0)
+		goto err_ida;
 
-	INIT_LIST_HEAD(&cntr->qp_list);
+	counter->id = id;
+
+	stats = rdma_alloc_hw_stats_struct(dev->counter_stats->stats_hdrs,
+					   dev->counter_stats->queue_stats_count,
+					   RDMA_HW_STATS_DEFAULT_LIFESPAN);
+	if (!stats)
+		goto err_hw_stats;
+
+	return stats;
 
-	return rdma_alloc_hw_stats_struct(dev->counter_stats->stats_hdrs,
-					 dev->counter_stats->queue_stats_count,
-					 RDMA_HW_STATS_DEFAULT_LIFESPAN);
-err_xa:
+err_hw_stats:
+	ida_free(&dev->counter_stats->counter_ida, id);
+err_ida:
 	kfree(cntr->vals);
-err_vals:
-	kfree(cntr);
 
 	return NULL;
 }
@@ -273,14 +272,10 @@ ionic_counter_alloc_stats(struct rdma_counter *counter)
 static int ionic_counter_dealloc(struct rdma_counter *counter)
 {
 	struct ionic_ibdev *dev = to_ionic_ibdev(counter->device);
-	struct ionic_counter *cntr;
-
-	cntr = xa_erase(&dev->counter_stats->xa_counters, counter->id);
-	if (!cntr)
-		return -EINVAL;
+	struct ionic_rdma_counter *cntr = to_ionic_rdma_counter(counter);
 
+	ida_free(&dev->counter_stats->counter_ida, counter->id);
 	kfree(cntr->vals);
-	kfree(cntr);
 
 	return 0;
 }
@@ -289,13 +284,8 @@ static int ionic_counter_bind_qp(struct rdma_counter *counter,
 				 struct ib_qp *ibqp,
 				 u32 port)
 {
-	struct ionic_ibdev *dev = to_ionic_ibdev(counter->device);
+	struct ionic_rdma_counter *cntr = to_ionic_rdma_counter(counter);
 	struct ionic_qp *qp = to_ionic_qp(ibqp);
-	struct ionic_counter *cntr;
-
-	cntr = xa_load(&dev->counter_stats->xa_counters, counter->id);
-	if (!cntr)
-		return -EINVAL;
 
 	list_add_tail(&qp->qp_list_counter, &cntr->qp_list);
 	ibqp->counter = counter;
@@ -315,29 +305,23 @@ static int ionic_counter_unbind_qp(struct ib_qp *ibqp, u32 port)
 	return 0;
 }
 
-static int ionic_get_qp_stats(struct ib_device *ibdev,
-			      struct rdma_hw_stats *hw_stats,
-			      u32 counter_id)
+static int ionic_counter_update_stats(struct rdma_counter *counter)
 {
-	struct ionic_ibdev *dev = to_ionic_ibdev(ibdev);
-	struct ionic_counter_stats *cs;
-	struct ionic_counter *cntr;
+	struct ionic_rdma_counter *cntr = to_ionic_rdma_counter(counter);
+	struct ionic_ibdev *dev = to_ionic_ibdev(counter->device);
+	struct ionic_counter_stats *cs = dev->counter_stats;
 	dma_addr_t hw_stats_dma;
 	struct ionic_qp *qp;
 	int rc, stat_i = 0;
 
-	cs = dev->counter_stats;
-	cntr = xa_load(&cs->xa_counters, counter_id);
-	if (!cntr)
-		return -EINVAL;
-
 	hw_stats_dma = dma_map_single(dev->lif_cfg.hwdev, cntr->vals,
 				      PAGE_SIZE, DMA_FROM_DEVICE);
 	rc = dma_mapping_error(dev->lif_cfg.hwdev, hw_stats_dma);
 	if (rc)
 		return rc;
 
-	memset(hw_stats->value, 0, sizeof(u64) * hw_stats->num_counters);
+	memset(counter->stats->value, 0,
+	       sizeof(u64) * counter->stats->num_counters);
 
 	list_for_each_entry(qp, &cntr->qp_list, qp_list_counter) {
 		rc = ionic_hw_stats_cmd(dev, hw_stats_dma, PAGE_SIZE,
@@ -347,7 +331,7 @@ static int ionic_get_qp_stats(struct ib_device *ibdev,
 			goto err_cmd;
 
 		for (stat_i = 0; stat_i < cs->queue_stats_count; ++stat_i)
-			hw_stats->value[stat_i] +=
+			counter->stats->value[stat_i] +=
 				ionic_v1_stat_val(&cs->hdr[stat_i],
 						  cntr->vals,
 						  PAGE_SIZE);
@@ -362,11 +346,6 @@ static int ionic_get_qp_stats(struct ib_device *ibdev,
 	return rc;
 }
 
-static int ionic_counter_update_stats(struct rdma_counter *counter)
-{
-	return ionic_get_qp_stats(counter->device, counter->stats, counter->id);
-}
-
 static int ionic_alloc_counters(struct ionic_ibdev *dev)
 {
 	struct ionic_counter_stats *cs = dev->counter_stats;
@@ -427,12 +406,22 @@ static const struct ib_device_ops ionic_hw_stats_ops = {
 	.get_hw_stats = ionic_get_hw_stats,
 };
 
+static void ionic_counter_init(struct rdma_counter *counter)
+{
+	struct ionic_rdma_counter *cntr = to_ionic_rdma_counter(counter);
+
+	INIT_LIST_HEAD(&cntr->qp_list);
+}
+
 static const struct ib_device_ops ionic_counter_stats_ops = {
 	.counter_alloc_stats = ionic_counter_alloc_stats,
 	.counter_dealloc = ionic_counter_dealloc,
 	.counter_bind_qp = ionic_counter_bind_qp,
 	.counter_unbind_qp = ionic_counter_unbind_qp,
 	.counter_update_stats = ionic_counter_update_stats,
+	.counter_init = ionic_counter_init,
+
+	INIT_RDMA_OBJ_SIZE(rdma_counter, ionic_rdma_counter, rdma_counter),
 };
 
 void ionic_stats_init(struct ionic_ibdev *dev)
@@ -462,7 +451,7 @@ void ionic_stats_init(struct ionic_ibdev *dev)
 			return;
 		}
 
-		xa_init_flags(&dev->counter_stats->xa_counters, XA_FLAGS_ALLOC);
+		ida_init(&dev->counter_stats->counter_ida);
 
 		ib_set_device_ops(&dev->ibdev, &ionic_counter_stats_ops);
 	}
@@ -471,7 +460,7 @@ void ionic_stats_init(struct ionic_ibdev *dev)
 void ionic_stats_cleanup(struct ionic_ibdev *dev)
 {
 	if (dev->counter_stats) {
-		xa_destroy(&dev->counter_stats->xa_counters);
+		ida_destroy(&dev->counter_stats->counter_ida);
 		kfree(dev->counter_stats->hdr);
 		kfree(dev->counter_stats->stats_hdrs);
 		kfree(dev->counter_stats);
diff --git a/drivers/infiniband/hw/ionic/ionic_ibdev.h b/drivers/infiniband/hw/ionic/ionic_ibdev.h
index 63828240d6590..1c43344ec93ce 100644
--- a/drivers/infiniband/hw/ionic/ionic_ibdev.h
+++ b/drivers/infiniband/hw/ionic/ionic_ibdev.h
@@ -331,14 +331,21 @@ struct ionic_counter_stats {
 	int queue_stats_count;
 	struct ionic_v1_stat *hdr;
 	struct rdma_stat_desc *stats_hdrs;
-	struct xarray xa_counters;
+	struct ida counter_ida;
 };
 
-struct ionic_counter {
+struct ionic_rdma_counter {
+	struct rdma_counter rdma_counter;
 	void *vals;
 	struct list_head qp_list;
 };
 
+static inline struct ionic_rdma_counter *
+to_ionic_rdma_counter(struct rdma_counter *counter)
+{
+	return container_of(counter, struct ionic_rdma_counter, rdma_counter);
+}
+
 static inline struct ionic_ibdev *to_ionic_ibdev(struct ib_device *ibdev)
 {
 	return container_of(ibdev, struct ionic_ibdev, ibdev);
-- 
2.53.0


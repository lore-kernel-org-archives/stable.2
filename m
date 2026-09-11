Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2115520D4F0
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 01:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789089201; cv=none; b=rgL2so/7dSOlheFz9J6/NFQwVE/4WqEPOmABNpRocUo3C4aqTpDgzmDAnZ4GY30Ytvo2u55VShAygdHz2SXGgfWMQ2UycpJGt7JfWG6fXvQ9uja5Lgh7n2+pOU7Q12/kijGU/FPNgDeCxAmLUg5tSKTqba8KkCwLuJfED+Qi+cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789089201; c=relaxed/simple;
	bh=GMrJEzaO/5SIm99dfvzBGhQqhKr3pXU9M+DSxtYFmKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=krt1mCLnoEw1+4ZryoE8ykeOLeqHcJm3ketPEIKF7kSFedolWlImBv0wx9V0BHBvQyWCT1C6W0/x6T2bFhXcD5fSYy1aVt7JrEHcVydK4Dk8Wr8WSV6md2W++Q2uTEOaKZx8a6Jp+dcnaES89bINn4mUe377C4IHzXOjw9fNd3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwgsynLC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwgsynLC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B82001F00899;
	Fri, 11 Sep 2026 01:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789089197;
	bh=jyVRuQ8aqHiY1rntGf1f3kBtG0GBszhH4uWuWTAbKyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nwgsynLCSsVMxyqa/HiXJpwk3s3nC6c427xujvzwsEB98T3QV7inAYY7NwcF28asZ
	 BMlU5gyW817tWQZeUHZSemba4BACTshKy/ezLhL1Xu6EaIKQ/W4eIdNU5DaKutAH6l
	 3yNrFSIXxI+xjZGVQp9oXg04RXjskRFEJF1BUTvVGEC3ZHrLqNpTqDuFZdVqHXDNHn
	 +/knz8vB1OdZPYZ10AOD7c9EzlPS3GG0FUlJ2Jtz8U6Gpd5xRLy+yMTpqDezS9vu2T
	 t4soXs9WdDx1KQwt56SNPvoM2yJMlNXvZkbXMV8MknGnjv8O23toWtv6ZFH5aZ8G9K
	 A7ne+BBp7obow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Li Chen <me@linux.beauty>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/6] nvdimm: virtio_pmem: stop allocating child flush bio
Date: Thu, 10 Sep 2026 21:13:10 -0400
Message-ID: <20260911011313.4034971-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911011313.4034971-1-sashal@kernel.org>
References: <2026090939-defiance-yelling-974c@gregkh>
 <20260911011313.4034971-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Li Chen <me@linux.beauty>

[ Upstream commit 40f356e610df95728074b1fc2e2ccb54ca1b5659 ]

pmem_submit_bio() passes the parent bio to nvdimm_flush() for
REQ_FUA. For virtio-pmem this makes async_pmem_flush() allocate
and submit a child PREFLUSH bio chained to the parent.

That child allocation is in the block submit path. Making it
blocking with GFP_NOIO can consume the same global bio mempool that
submit_bio() uses, while making it GFP_ATOMIC can fail under
pressure. A forced failure of the child allocation produced:

virtio_pmem: forcing child bio allocation failure for test
Buffer I/O error on dev pmem0, logical block 0, lost sync page write
EXT4-fs (pmem0): I/O error while writing superblock
EXT4-fs (pmem0): mount failed

Avoid the child bio without turning REQ_FUA into a synchronous
submit-path wait. Let provider flush callbacks return
NVDIMM_FLUSH_ASYNC after taking ownership of parent bio completion.
pmem_submit_bio() returns in that case, and virtio-pmem queues an
ordered WQ_MEM_RECLAIM work item that runs the existing host flush
path and completes the parent bio.

This keeps the asynchronous completion model of the child-bio path
while removing the child bio allocation from the submit path.

Signed-off-by: Li Chen <me@linux.beauty>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260630092338.2094628-5-me@linux.beauty>

Backport notes for 6.12:
Drop the freeze callback hunk: this tree does not have the upstream
virtio-pmem freeze/restore callbacks. Keep the workqueue allocation,
probe error cleanup, and removal drain without adding those callbacks.

Use the available kmalloc_obj() helper for the existing request allocation,
matching upstream without changing its GFP_KERNEL behavior. This keeps the
following GFP_NOIO dependency applicable. Correct the existing "repsonse"
comment typo to match the context of the wait-flag dependency. The remaining
request-wakeup and wait-flag dependencies are still needed before the
refcount target.

Stable-dep-of: e57140944b5a ("nvdimm: virtio_pmem: refcount requests for token lifetime")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvdimm/nd_virtio.c   | 58 +++++++++++++++++++++++++-----------
 drivers/nvdimm/pmem.c        |  5 +++-
 drivers/nvdimm/region_devs.c |  2 ++
 drivers/nvdimm/virtio_pmem.c | 14 ++++++++-
 drivers/nvdimm/virtio_pmem.h |  4 +++
 include/linux/libnvdimm.h    |  9 ++++++
 6 files changed, 72 insertions(+), 20 deletions(-)

diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
index e8ac7425c97cd..8e16b7780be1a 100644
--- a/drivers/nvdimm/nd_virtio.c
+++ b/drivers/nvdimm/nd_virtio.c
@@ -9,6 +9,12 @@
 #include "virtio_pmem.h"
 #include "nd.h"
 
+struct virtio_pmem_flush_work {
+	struct work_struct work;
+	struct nd_region *nd_region;
+	struct bio *bio;
+};
+
  /* The interrupt handler */
 void virtio_pmem_host_ack(struct virtqueue *vq)
 {
@@ -55,7 +61,7 @@ static int virtio_pmem_flush(struct nd_region *nd_region)
 		return -EIO;
 	}
 
-	req_data = kmalloc(sizeof(*req_data), GFP_KERNEL);
+	req_data = kmalloc_obj(*req_data);
 	if (!req_data)
 		return -ENOMEM;
 
@@ -98,7 +104,7 @@ static int virtio_pmem_flush(struct nd_region *nd_region)
 		dev_info(&vdev->dev, "failed to send command to virtio pmem device\n");
 		err = -EIO;
 	} else {
-		/* A host repsonse results in "host_ack" getting called */
+		/* A host response results in "host_ack" getting called */
 		wait_event(req_data->host_acked, req_data->done);
 		err = le32_to_cpu(req_data->resp.ret);
 	}
@@ -107,30 +113,46 @@ static int virtio_pmem_flush(struct nd_region *nd_region)
 	return err;
 };
 
+static void virtio_pmem_flush_work(struct work_struct *work)
+{
+	struct virtio_pmem_flush_work *flush;
+	int err;
+
+	flush = container_of(work, struct virtio_pmem_flush_work, work);
+	err = virtio_pmem_flush(flush->nd_region);
+	if (err > 0)
+		err = -EIO;
+	if (err)
+		flush->bio->bi_status = errno_to_blk_status(err);
+	bio_endio(flush->bio);
+	kfree(flush);
+}
+
 /* The asynchronous flush callback function */
 int async_pmem_flush(struct nd_region *nd_region, struct bio *bio)
 {
-	/*
-	 * Create child bio for asynchronous flush and chain with
-	 * parent bio. Otherwise directly call nd_region flush.
-	 */
-	if (bio && bio->bi_iter.bi_sector != -1) {
-		struct bio *child = bio_alloc(bio->bi_bdev, 0,
-					      REQ_OP_WRITE | REQ_PREFLUSH,
-					      GFP_ATOMIC);
+	struct virtio_device *vdev = nd_region->provider_data;
+	struct virtio_pmem *vpmem = vdev->priv;
+	struct virtio_pmem_flush_work *flush;
+	int err;
 
-		if (!child)
+	if (bio && bio->bi_iter.bi_sector != -1) {
+		flush = kmalloc_obj(*flush, GFP_NOIO);
+		if (!flush)
 			return -ENOMEM;
-		bio_clone_blkg_association(child, bio);
-		child->bi_iter.bi_sector = -1;
-		bio_chain(child, bio);
-		submit_bio(child);
-		return 0;
+
+		INIT_WORK(&flush->work, virtio_pmem_flush_work);
+		flush->nd_region = nd_region;
+		flush->bio = bio;
+		queue_work(vpmem->flush_wq, &flush->work);
+		return NVDIMM_FLUSH_ASYNC;
 	}
-	if (virtio_pmem_flush(nd_region))
+
+	err = virtio_pmem_flush(nd_region);
+	if (err > 0)
 		return -EIO;
 
-	return 0;
+	return err;
 };
 EXPORT_SYMBOL_GPL(async_pmem_flush);
 MODULE_DESCRIPTION("Virtio Persistent Memory Driver");
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 58f335dd57464..53f6587674d34 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -236,8 +236,11 @@ static void pmem_submit_bio(struct bio *bio)
 	if (do_acct)
 		bio_end_io_acct(bio, start);
 
-	if ((bio->bi_opf & REQ_FUA) && !bio->bi_status)
+	if ((bio->bi_opf & REQ_FUA) && !bio->bi_status) {
 		ret = nvdimm_flush(nd_region, bio);
+		if (ret == NVDIMM_FLUSH_ASYNC)
+			return;
+	}
 
 	if (ret)
 		bio->bi_status = errno_to_blk_status(ret);
diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index 4e24dccb2ff86..97ad92fbc8e49 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -1113,6 +1113,8 @@ int nvdimm_flush(struct nd_region *nd_region, struct bio *bio)
 		rc = generic_nvdimm_flush(nd_region);
 	else {
 		rc = nd_region->flush(nd_region, bio);
+		if (rc > 0)
+			return rc;
 		if (rc && rc != -ENOMEM)
 			rc = -EIO;
 	}
diff --git a/drivers/nvdimm/virtio_pmem.c b/drivers/nvdimm/virtio_pmem.c
index 89d3d4fc3ce89..94f324ffdc80e 100644
--- a/drivers/nvdimm/virtio_pmem.c
+++ b/drivers/nvdimm/virtio_pmem.c
@@ -67,10 +67,17 @@ static int virtio_pmem_probe(struct virtio_device *vdev)
 	mutex_init(&vpmem->flush_lock);
 	vpmem->vdev = vdev;
 	vdev->priv = vpmem;
+	vpmem->flush_wq = alloc_ordered_workqueue("virtio-pmem-flush",
+						  WQ_MEM_RECLAIM);
+	if (!vpmem->flush_wq) {
+		err = -ENOMEM;
+		goto out_err;
+	}
+
 	err = init_vq(vpmem);
 	if (err) {
 		dev_err(&vdev->dev, "failed to initialize virtio pmem vq's\n");
-		goto out_err;
+		goto out_wq;
 	}
 
 	if (virtio_has_feature(vdev, VIRTIO_PMEM_F_SHMEM_REGION)) {
@@ -131,6 +138,8 @@ static int virtio_pmem_probe(struct virtio_device *vdev)
 	nvdimm_bus_unregister(vpmem->nvdimm_bus);
 out_vq:
 	vdev->config->del_vqs(vdev);
+out_wq:
+	destroy_workqueue(vpmem->flush_wq);
 out_err:
 	return err;
 }
@@ -138,10 +147,13 @@ static int virtio_pmem_probe(struct virtio_device *vdev)
 static void virtio_pmem_remove(struct virtio_device *vdev)
 {
 	struct nvdimm_bus *nvdimm_bus = dev_get_drvdata(&vdev->dev);
+	struct virtio_pmem *vpmem = vdev->priv;
 
 	nvdimm_bus_unregister(nvdimm_bus);
+	drain_workqueue(vpmem->flush_wq);
 	vdev->config->del_vqs(vdev);
 	virtio_reset_device(vdev);
+	destroy_workqueue(vpmem->flush_wq);
 }
 
 static unsigned int features[] = {
diff --git a/drivers/nvdimm/virtio_pmem.h b/drivers/nvdimm/virtio_pmem.h
index f72cf17f9518f..e6dfc10ce0762 100644
--- a/drivers/nvdimm/virtio_pmem.h
+++ b/drivers/nvdimm/virtio_pmem.h
@@ -15,6 +15,7 @@
 #include <linux/libnvdimm.h>
 #include <linux/mutex.h>
 #include <linux/spinlock.h>
+#include <linux/workqueue.h>
 
 struct virtio_pmem_request {
 	struct virtio_pmem_req req;
@@ -39,6 +40,9 @@ struct virtio_pmem {
 	/* Serialize flush requests to the device. */
 	struct mutex flush_lock;
 
+	/* Complete asynchronous FUA flushes outside the submit path. */
+	struct workqueue_struct *flush_wq;
+
 	/* nvdimm bus registers virtio pmem device */
 	struct nvdimm_bus *nvdimm_bus;
 	struct nvdimm_bus_descriptor nd_desc;
diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
index e772aae718431..04043b7d5712a 100644
--- a/include/linux/libnvdimm.h
+++ b/include/linux/libnvdimm.h
@@ -122,6 +122,15 @@ struct nd_mapping_desc {
 };
 
 struct nd_region;
+
+/*
+ * Provider flush callback return values:
+ *   0: flush completed synchronously
+ *  <0: flush failed
+ *  >0: flush completion was queued and @bio will be completed later
+ */
+#define NVDIMM_FLUSH_ASYNC 1
+
 struct nd_region_desc {
 	struct resource *res;
 	struct nd_mapping_desc *mapping;
-- 
2.53.0


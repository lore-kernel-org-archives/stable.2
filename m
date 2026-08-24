Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2A3430CE5
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 14:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787580359; cv=none; b=jJO9nhS3BboSpQWOZgiP8vvBmXh/QlxGdl4G6zyAVu8aLpLlwF/Eu98wTb5YbSIXnvIrFqCJuWOtMyK6zr/PIBzzaM+19ApYH3822M4AYUIdnbpyXeOBJ5C6ZYQ66gO/J6E8a/CWPAYrSNdgLYC0OdROqyQvqFkowA4/R5lCad4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787580359; c=relaxed/simple;
	bh=3dX5246dOzqwp3sEuhvLB2fojLIW6KOzR4g6fIOpJK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z4Nka1hsj2PB1Wevnmgtw+NJkxbjLCYjNruYC2jcfyyyaJgGoDvfnK4xyxiT+V4F3RmC1gPOYuB3r1BE3smrhN7EG6Dw4xL0onQM3V++k+Qg0vJyfMeLzt1dpROxTpziJzGwQTK0ufFexgpd9/N/MPY5wMOhlG/su3fb8OrJIVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cN0rY1qB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cN0rY1qB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE2C11F000E9;
	Mon, 24 Aug 2026 14:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787580357;
	bh=KM/twUv/vmRfGRkU1zENS1631BIYFqw2Kb3MyPSDeFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cN0rY1qBwT6PO2/wGs0mOrJZGU/tFvBd6YZebtuVL8A+/2vEJb+FVcTeLG4F/tHIx
	 nLoIg1CcLQBAB53mWVz+PtEBqChI5EswQ1fSyzx8X1ZM0HWTE+q5snA2WQx6viKcU6
	 AFErSoMgwuxri/VvtA9LhiQREWtdiPV6Rjo+QGsfKLDLbZbYq43SSTJGHItmMwVfJK
	 6AnmkwbNJOqmuFi9e1iBevwgWNZJisjxSDsNcVm6MufZNOEnlFo8S3B5REFlccS8Mb
	 4Qf+iVuZequf2WYOwrLv89PaydH4Ej1E8WLSYHs64Ooi7RRHErLtZliqT9LmYguJl+
	 VlIK+w2HE8hdA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Farman <farman@linux.ibm.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/4] s390/vfio_ccw: Ensure index for read/write regions are within range
Date: Mon, 24 Aug 2026 10:05:52 -0400
Message-ID: <20260824140555.3097579-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082011-underarm-plywood-1b0f@gregkh>
References: <2026082011-underarm-plywood-1b0f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Farman <farman@linux.ibm.com>

[ Upstream commit 9f5f9a78fedc45bc29d6a0a64e3a3472361afae5 ]

The introduction of the capability chain rightly clamped the
region indexes to the range of the capabilities itself, but
neglected to do so for the existing read/write regions which
should also be enforced.

Fixes: db8e5d17ac03 ("vfio-ccw: add capabilities chain")
Cc: stable@vger.kernel.org
Cc: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Stable-dep-of: 16b0798024c0 ("s390/vfio_ccw: Implement a crw lock")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/cio/vfio_ccw_async.c | 16 ++++++++++++++++
 drivers/s390/cio/vfio_ccw_chp.c   | 15 +++++++++++++++
 drivers/s390/cio/vfio_ccw_ops.c   |  7 +++----
 3 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_async.c b/drivers/s390/cio/vfio_ccw_async.c
index 7a838e3d7c0fa..01f8cedc46e2a 100644
--- a/drivers/s390/cio/vfio_ccw_async.c
+++ b/drivers/s390/cio/vfio_ccw_async.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/vfio.h>
+#include <linux/nospec.h>
 #include <linux/mdev.h>
 
 #include "vfio_ccw_private.h"
@@ -25,11 +26,20 @@ static ssize_t vfio_ccw_async_region_read(struct vfio_ccw_private *private,
 		return -EINVAL;
 
 	mutex_lock(&private->io_mutex);
+
+	if (i >= private->num_regions) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	i = array_index_nospec(i, private->num_regions);
 	region = private->region[i].data;
 	if (copy_to_user(buf, (void *)region + pos, count))
 		ret = -EFAULT;
 	else
 		ret = count;
+
+out_unlock:
 	mutex_unlock(&private->io_mutex);
 	return ret;
 }
@@ -49,6 +59,12 @@ static ssize_t vfio_ccw_async_region_write(struct vfio_ccw_private *private,
 	if (!mutex_trylock(&private->io_mutex))
 		return -EAGAIN;
 
+	if (i >= private->num_regions) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	i = array_index_nospec(i, private->num_regions);
 	region = private->region[i].data;
 	if (copy_from_user((void *)region + pos, buf, count)) {
 		ret = -EFAULT;
diff --git a/drivers/s390/cio/vfio_ccw_chp.c b/drivers/s390/cio/vfio_ccw_chp.c
index 13b26a1c79886..11264e2adffcb 100644
--- a/drivers/s390/cio/vfio_ccw_chp.c
+++ b/drivers/s390/cio/vfio_ccw_chp.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/slab.h>
+#include <linux/nospec.h>
 #include <linux/vfio.h>
 #include "vfio_ccw_private.h"
 
@@ -25,6 +26,13 @@ static ssize_t vfio_ccw_schib_region_read(struct vfio_ccw_private *private,
 		return -EINVAL;
 
 	mutex_lock(&private->io_mutex);
+
+	if (i >= private->num_regions) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	i = array_index_nospec(i, private->num_regions);
 	region = private->region[i].data;
 
 	if (cio_update_schib(private->sch)) {
@@ -96,6 +104,12 @@ static ssize_t vfio_ccw_crw_region_read(struct vfio_ccw_private *private,
 		list_del(&crw->next);
 
 	mutex_lock(&private->io_mutex);
+	if (i >= private->num_regions) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	i = array_index_nospec(i, private->num_regions);
 	region = private->region[i].data;
 
 	if (crw)
@@ -108,6 +122,7 @@ static ssize_t vfio_ccw_crw_region_read(struct vfio_ccw_private *private,
 
 	region->crw = 0;
 
+out:
 	mutex_unlock(&private->io_mutex);
 
 	kfree(crw);
diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
index 7f540ad0b568b..b76b0521b456b 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -251,6 +251,7 @@ static ssize_t vfio_ccw_mdev_read(struct mdev_device *mdev,
 		return vfio_ccw_mdev_read_io_region(private, buf, count, ppos);
 	default:
 		index -= VFIO_CCW_NUM_REGIONS;
+		index = array_index_nospec(index, private->num_regions);
 		return private->region[index].ops->read(private, buf, count,
 							ppos);
 	}
@@ -304,6 +305,7 @@ static ssize_t vfio_ccw_mdev_write(struct mdev_device *mdev,
 		return vfio_ccw_mdev_write_io_region(private, buf, count, ppos);
 	default:
 		index -= VFIO_CCW_NUM_REGIONS;
+		index = array_index_nospec(index, private->num_regions);
 		return private->region[index].ops->write(private, buf, count,
 							 ppos);
 	}
@@ -351,11 +353,8 @@ static int vfio_ccw_mdev_get_region_info(struct vfio_region_info *info,
 		    VFIO_CCW_NUM_REGIONS + private->num_regions)
 			return -EINVAL;
 
-		info->index = array_index_nospec(info->index,
-						 VFIO_CCW_NUM_REGIONS +
-						 private->num_regions);
-
 		i = info->index - VFIO_CCW_NUM_REGIONS;
+		i = array_index_nospec(i, private->num_regions);
 
 		info->offset = VFIO_CCW_INDEX_TO_OFFSET(info->index);
 		info->size = private->region[i].size;
-- 
2.53.0


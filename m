Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411253603C7
	for <stable@vger.kernel.org>; Sat, 26 Sep 2026 04:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790396393; cv=none; b=rUyOzOhFUgqY2Y6tBKl7A6ts6/EJWNjplVZzWLuFLi2W45x68+Dl+vg1eZC3c9XUvRm9Vm5DUojL95gRA+XQxNd7BmZ8JHsp6o/GnH9CiacrtvOIszJwJDItKcMBCI/U0gqhWlTQJ1dmA/iF5g9Vxs595iqsAXecm1XyFq+1Jpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790396393; c=relaxed/simple;
	bh=4Y6o1wBsF/eQEgPBi/+abCQE6Kdn5XxfWvwfQFGZyX8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P8gsq2o0qQzK3cyiwwXJqPW+qTYolbp53E08pj9xqX7JE8UQ1bEu5t/P9KiH2whvnr1S9sUrJ55Z8eAPKxY5dm1HOO94pIGu1fgFok2i8DPesYQL34iHe0JNCZIp1Gy5ERtoS9mCFfUHEBNzJURGr/NFoYaF7Sst0NDL+jvBXkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=keoUxYD0; arc=none smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="keoUxYD0"
Received: by mail-qk2-f43.google.com with SMTP id d75a77b69052e-532db7db0c6so13961041cf.2
        for <stable@vger.kernel.org>; Fri, 25 Sep 2026 21:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790396390; x=1791001190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=O714HpujpOiT7ZMzjlfSNzchhvC2uNBRKyYZGVRuelY=;
        b=keoUxYD0P0e00/4AUO8rWEggVmlBjWv7z8K3malOM20KRwQAczsKAB6VeuCmm/iNMH
         8fH86AU96YVB9cQtKIv8WGAUO1oWwOPkWmLJ90AX3mi7DVDVFl6Fwcm8gA38fbXWRnSR
         qPdeuAwgrBiy7/MuXlG6tYzwoge3W3cgf3Ey11zlj6mZ3SOPUCjqEP1rqmGkWQblPReH
         +1QC7zAe489oAiDf4FxzT/4ZCipTGdF6qPHLW8ZD3Lf71Ja1L8n0UnyTo4yMq7nuzBZZ
         /jFigN0Y+lXAGkb8Ec8azkOjYpa2bpxpa62GjIDr5xCh18cy85uj2ehYhiLemBXJns1x
         czAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790396390; x=1791001190;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O714HpujpOiT7ZMzjlfSNzchhvC2uNBRKyYZGVRuelY=;
        b=QIbWZIf4ZJkCb+QP74lswHoKOiirbOaGaGRFIngRxTULvqdsWj9rIoXWl9xFgO25+2
         fURvEGagKN7CkBVnyTfd8J/FQLGOazu/0ytxT5ZOX/0SbM0FML+81xwfy+BsuE7XgKV8
         fAc009Zb2adJaFymK94l/kGoKsFGXNgXK/h9622ClN56PoKWOBbOLH9NnUoYOXijuclN
         nkZMQyD8TEa5p3S93qRfl02KrI2LfyIxYnL5irwklFmK+3NXoSS4V20M/4FZvt0bQOrJ
         RTNBb0AyhmAxmnUEmrdGhxVt0wXNa7UaBwxjL0vQiW8P4ui19q8aKKJsRKs2NgguJFzD
         z5wQ==
X-Forwarded-Encrypted: i=1; AKwUvBzPwDCeeH4d1GGt8PMJZgJxHWpyw3XhlOyZfZxBK8j84Afpqk0cXewlCxXRsDh2AEjyazyVpnk=@vger.kernel.org
X-Gm-Message-State: AFuF++kTGEHxlzQs2JtfZdNgX+YxmqVPUy1xo4GCb1hDIyST61RonALu
	Zc4vZkzHFcaGMflsfITdgfJu8Xe5cWK8MHBbc9NWdR/ZIaoNE03/hr+s
X-Gm-Gg: AYBFou3gY3YMJL8h+tV/+b4eVSxVH6MU9tDSCmlUoPrbBFJ9l3pC1YiBmyvwTSbf6lB
	V5ZnPFf5aWMrko3XzfdvVEd/yYaVBvxzEQ7IOst02YEnKCPccqCoXuztYr/IDYNP7Gk6LmQIkfc
	3h4OyAXuXKRzaO6KDZOCShJO2JAdIOpYu/r2DGnsHGK/cbMZbqaXVf201ZziqNfvCrEgVuoWggh
	2yAIiDBmS2MOzDx1uFOI137L25ZlZc/GpoE+9g0/sYKi7IGj8dMvTSJyJtuAZckwzom2srQJ6OS
	mUeSsOZFtY9mXtPmy9sWD4gCZCNFKdoWZjFKxRPy2dRBbmXAlaCOPIKbf9mj1RMmYrQkHjHiqti
	fFe/IY4qEAYPsq2Wm6ydiWgrJm3aeBWZSN5TdxxDJSyd5ph5fcHi/IEqH6UK4A3s12UNTN8KMLF
	w5OV1lD30w+T3ysjPQ8NEuHgtTenhC383l8cU6fACtOGNG2G8uHYj+mXxjsZ5vSFHqqWReFmqiC
	HBcdGvctebkwC3OflvXfg==
X-Received: by 2002:a05:622a:250c:b0:530:ea12:caad with SMTP id d75a77b69052e-5330b6bfaddmr71181341cf.50.1790396390127;
        Fri, 25 Sep 2026 21:19:50 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53322133f07sm9070031cf.6.2026.09.25.21.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 21:19:48 -0700 (PDT)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>
Cc: linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuho Choi <oss.patchbox@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] remoteproc: virtio: Synchronize virtqueue teardown with rproc_vq_interrupt()
Date: Sat, 26 Sep 2026 00:19:31 -0400
Message-ID: <20260926041943.1124650-1-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rproc_vq_interrupt() looks up rvring->vq and passes it to
vring_interrupt() without synchronizing against __rproc_virtio_del_vqs(),
which clears rvring->vq and frees the virtqueue. rproc_stop() and
__rproc_detach() stop the subdevices, and so delete the virtqueues,
before the remote processor is stopped or detached, so the remote can
still signal a vring meanwhile. The interrupt path can then pass a NULL
or already freed virtqueue to vring_interrupt().

Protect rvring->vq with SRCU: rproc_vq_interrupt() uses the virtqueue
inside a read-side section, and __rproc_virtio_del_vqs() clears the
pointers and waits for readers before freeing the virtqueues. Plain RCU
is not usable because rproc_vq_interrupt() is also called from process
context, where vring callbacks may sleep.

Fixes: 7a186941626d ("remoteproc: remove the single rpmsg vdev limitation")
Cc: stable@vger.kernel.org
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
Changes in v2:
- Rework the fix: v1 only loaded rvring->vq once, which closes the NULL
  window but not the use-after-free once the virtqueue is freed after
  the load (Mathieu Poirier). Use SRCU so __rproc_virtio_del_vqs()
  waits for rproc_vq_interrupt() before freeing the virtqueues.
- Update the subject accordingly.

v1: https://lore.kernel.org/all/20260922190159.509836-1-oss.patchbox@gmail.com/

Compile-tested only (arm64 and x86_64 defconfig + REMOTEPROC/RPMSG_VIRTIO, 
W=1, sparse).

 drivers/remoteproc/remoteproc_virtio.c | 35 +++++++++++++++++++++-----
 include/linux/remoteproc.h             |  2 +-
 2 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
index d5e9ff045a28a..cd8f3a8b4870a 100644
--- a/drivers/remoteproc/remoteproc_virtio.c
+++ b/drivers/remoteproc/remoteproc_virtio.c
@@ -16,6 +16,7 @@
 #include <linux/of_reserved_mem.h>
 #include <linux/platform_device.h>
 #include <linux/remoteproc.h>
+#include <linux/srcu.h>
 #include <linux/virtio.h>
 #include <linux/virtio_config.h>
 #include <linux/virtio_ids.h>
@@ -26,6 +27,14 @@
 
 #include "remoteproc_internal.h"
 
+/*
+ * Protects rproc_vring->vq: rproc_vq_interrupt() uses the virtqueue inside a
+ * read-side section, and __rproc_virtio_del_vqs() waits for those sections to
+ * finish before freeing it. Sleepable RCU is used because vring callbacks may
+ * sleep when rproc_vq_interrupt() is called from process context.
+ */
+DEFINE_STATIC_SRCU(rproc_vq_srcu);
+
 static int copy_dma_range_map(struct device *to, struct device *from)
 {
 	const struct bus_dma_region *map = from->dma_range_map, *new_map, *r;
@@ -88,15 +97,24 @@ static bool rproc_virtio_notify(struct virtqueue *vq)
  */
 irqreturn_t rproc_vq_interrupt(struct rproc *rproc, int notifyid)
 {
+	irqreturn_t ret = IRQ_NONE;
 	struct rproc_vring *rvring;
+	struct virtqueue *vq;
+	int idx;
 
 	dev_dbg(&rproc->dev, "vq index %d is interrupted\n", notifyid);
 
 	rvring = idr_find(&rproc->notifyids, notifyid);
-	if (!rvring || !rvring->vq)
+	if (!rvring)
 		return IRQ_NONE;
 
-	return vring_interrupt(0, rvring->vq);
+	idx = srcu_read_lock(&rproc_vq_srcu);
+	vq = srcu_dereference(rvring->vq, &rproc_vq_srcu);
+	if (vq)
+		ret = vring_interrupt(0, vq);
+	srcu_read_unlock(&rproc_vq_srcu, idx);
+
+	return ret;
 }
 EXPORT_SYMBOL(rproc_vq_interrupt);
 
@@ -153,8 +171,8 @@ static struct virtqueue *rp_find_vq(struct virtio_device *vdev,
 
 	vq->num_max = num;
 
-	rvring->vq = vq;
 	vq->priv = rvring;
+	rcu_assign_pointer(rvring->vq, vq);
 
 	/* Update vring in resource table */
 	rsc = (void *)rproc->table_ptr + rvdev->rsc_offset;
@@ -168,11 +186,16 @@ static void __rproc_virtio_del_vqs(struct virtio_device *vdev)
 	struct virtqueue *vq, *n;
 	struct rproc_vring *rvring;
 
-	list_for_each_entry_safe(vq, n, &vdev->vqs, list) {
+	list_for_each_entry(vq, &vdev->vqs, list) {
 		rvring = vq->priv;
-		rvring->vq = NULL;
-		vring_del_virtqueue(vq);
+		RCU_INIT_POINTER(rvring->vq, NULL);
 	}
+
+	/* Wait for rproc_vq_interrupt() callers still using the virtqueues */
+	synchronize_srcu(&rproc_vq_srcu);
+
+	list_for_each_entry_safe(vq, n, &vdev->vqs, list)
+		vring_del_virtqueue(vq);
 }
 
 static void rproc_virtio_del_vqs(struct virtio_device *vdev)
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index a44368737b39a..919d19fe99198 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -340,7 +340,7 @@ struct rproc_vring {
 	u32 align;
 	int notifyid;
 	struct rproc_vdev *rvdev;
-	struct virtqueue *vq;
+	struct virtqueue __rcu *vq;
 };
 
 /**

base-commit: aa98230e410f0ed212b6788c46b1e4d49e0ff7ca
-- 
2.43.0


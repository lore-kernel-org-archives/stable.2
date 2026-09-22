Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D553F65E0
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 18:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790103076; cv=none; b=QdEKz4lA3jOgdD5gQ977mO20s5mdscyAbz2TEUl+UhNAgjW0zeTc7brkJ9ShhvxrLl5vL8CVfIjEG3blx2lU7g1+LwRenmyyg9RjHCM8wSswwjVuaS/p+QlhTbjyyDNbIFBTjew1qge4OB9priPt8Jj6cqXWtKNeGT35qQZfxDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790103076; c=relaxed/simple;
	bh=RxIZJIuOH7S6E9dEfS5nnZ73/RkMS3mC7LCWG4nlnCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gtSjDFIsOx7HtlQ60tDNiXG3tfyPNfjBjNEr2KZzthU4UGcXSHAinjeSTh2z34mKp8PUQgRd7vHiUlyTZZ/QJgtyh5G5w6SJdxDIkDakbTeMwIKEkzALq4LybaYJqbv+Whgw8C8xEdZugLGE9De3EHmjNpE1jt9JfdtGD5BTrcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WH23yVzr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WH23yVzr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BFBE1F00893;
	Tue, 22 Sep 2026 18:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790103075;
	bh=rV8QmnV0rEBfrjcpbc8X+B00WWqViHE4LAAI3WpTU2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WH23yVzrvNXMmP0Bh7QisxhXY73RJFwUMVzw05zZgA/E+PM25K8IPHyEJDAWoi7x6
	 9hJyX/R0uMeyx2OQC+9xupi65gfGKnhxDATmx5NbGD38JtxgMcKM8ZcpH5mDo0tN5z
	 Qcdk9RR5aEGhcNlYPD4TH+GRE5lef7mxnjGtQLlrzS+FgZupnq4XSuHruytYmUmCC7
	 vIShTAD9M/CCwq39h1uc3EByni6tJUsDzIBX2GC829No9mz+XjRrS3e3me1xBgUIWU
	 sB0f5Gh2UZJsN6+cudh6b6ATTG3WKVO1UEQSOFY2aHCN1NOv6psomliR1zh2WuWlJj
	 E1kuYFbQ/sKWA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mike Lothian <mike@fireburn.co.uk>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] drm/amdgpu: hold a runtime PM reference for P2P dma-buf attachments
Date: Tue, 22 Sep 2026 14:51:12 -0400
Message-ID: <20260922185112.3837468-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922185112.3837468-1-sashal@kernel.org>
References: <2026092254-cactus-employee-2903@gregkh>
 <20260922185112.3837468-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Mike Lothian <mike@fireburn.co.uk>

[ Upstream commit 636139603b99d2e3a18a46cf3f8d39313ce8042e ]

amdgpu_dma_buf_map() adds VRAM to the allowed domains for a peer2peer
attachment.  GTT is only a fallback placement when VRAM is preferred, so
ttm_bo_validate() migrates the buffer from GTT into VRAM.  While the
exporting device is runtime suspended its SDMA rings are down and the
move fails:

  amdgpu: Move buffer fallback to memcpy unavailable

An importer on a second GPU reaches this holding no runtime PM
reference on the exporter, e.g. a compositor on the APU submitting a
frame that references a buffer exported by an idle dGPU:

  amdgpu_cs_ioctl -> amdgpu_cs_parser_bos -> amdgpu_cs_bo_validate
    -> ttm_bo_validate -> amdgpu_bo_move -> dma_buf_map_attachment
      -> amdgpu_dma_buf_map -> ttm_bo_validate -> amdgpu_bo_move

Pinning a dma-buf into VRAM has the same requirement, which
commit 030631e97b20 ("drm/amdgpu: revert "take runtime pm reference
when we attach a buffer" v2") called out as the one case that would
need the reference back.

Take it in attach and drop it in detach.  pm_runtime_get_if_active()
never resumes the device, so it cannot deadlock against the reservation
taken during resume, which is why the old pm_runtime_get_sync() had to
go.  If the device is not active, clear peer2peer instead: the buffer
then stays in GTT, which remains accessible while the GPU is powered
down.  If runtime PM is disabled, take a plain reference so the put in
detach stays balanced.

Fixes: 030631e97b20 ("drm/amdgpu: revert "take runtime pm reference when we attach a buffer" v2")
Suggested-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
Assisted-by: Claude:Opus-5 [Claude Code]
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 062ff15e30a48d14fb7d7558eba84f8dc97197f0)
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 43 ++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index 83fed04436ad7..efa6214eee315 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -42,6 +42,7 @@
 #include <linux/dma-buf.h>
 #include <linux/dma-fence-array.h>
 #include <linux/pci-p2pdma.h>
+#include <linux/pm_runtime.h>
 
 static const struct dma_buf_attach_ops amdgpu_dma_buf_attach_ops;
 
@@ -99,15 +100,54 @@ static int amdgpu_dma_buf_attach(struct dma_buf *dmabuf,
 	    pci_p2pdma_distance(adev->pdev, attach->dev, false) < 0)
 		attach->peer2peer = false;
 
+	/*
+	 * Only allow P2P while the exporter is active, and keep it active
+	 * until detach.  With runtime PM disabled take a plain reference so
+	 * the put in detach stays balanced.
+	 */
+	if (attach->peer2peer) {
+		struct device *dev = adev_to_drm(adev)->dev;
+		int ret = pm_runtime_get_if_active(dev);
+
+		if (!ret)
+			attach->peer2peer = false;
+		else if (ret < 0)
+			pm_runtime_get_noresume(dev);
+	}
+
 	r = dma_resv_lock(bo->tbo.base.resv, NULL);
 	if (r)
-		return r;
+		goto err_pm_put;
 
 	amdgpu_vm_bo_update_shared(bo);
 
 	dma_resv_unlock(bo->tbo.base.resv);
 
 	return 0;
+
+err_pm_put:
+	if (attach->peer2peer)
+		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+	return r;
+}
+
+/**
+ * amdgpu_dma_buf_detach - &dma_buf_ops.detach implementation
+ *
+ * @dmabuf: DMA-buf where we remove the attachment from
+ * @attach: the attachment to remove
+ *
+ * Drop the runtime PM reference taken in amdgpu_dma_buf_attach().
+ */
+static void amdgpu_dma_buf_detach(struct dma_buf *dmabuf,
+				  struct dma_buf_attachment *attach)
+{
+	struct drm_gem_object *obj = dmabuf->priv;
+	struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
+	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
+
+	if (attach->peer2peer)
+		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
 }
 
 /**
@@ -336,6 +376,7 @@ static void amdgpu_dma_buf_vunmap(struct dma_buf *dma_buf, struct iosys_map *map
 
 const struct dma_buf_ops amdgpu_dmabuf_ops = {
 	.attach = amdgpu_dma_buf_attach,
+	.detach = amdgpu_dma_buf_detach,
 	.pin = amdgpu_dma_buf_pin,
 	.unpin = amdgpu_dma_buf_unpin,
 	.map_dma_buf = amdgpu_dma_buf_map,
-- 
2.53.0


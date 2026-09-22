Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E97F44AB82
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 21:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790112223; cv=none; b=X0LP9AkAqJGuBfKOrXUXDhhW6G252didKQp24PYeaCV10BeM5GHScd6lvW7Y93KJmpthgiXJJNNn6gbYsepxbBG4GZkOXiaqUL887mhb8EiOYZoHByuP7ESzcNCt9ylJymOUqNMkWoBFyk+wlbiwzHZmrkU29f6y51VY3zgnwyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790112223; c=relaxed/simple;
	bh=Uzzu0zXAFsFT6EW+3pgxbAnzIZG7Mr2tw9abyLw9O7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ayQiJYqhQiV9/qkTjogfbm0XVWG3MdQvGyK052zUy539VXyfiPb9rLd/47IvEdD1S5BcaMsvFfqd+0fuKJKtT1pQle7iTumOkt0a9Z+edh3Qqzfno8uEzRYfwB/xldAA+EzgC38OZm4doOdrSyTqsT5D7KTlGFZJwx/cJ9rO/R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GDJ0VVbT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GDJ0VVbT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DAB91F0089C;
	Tue, 22 Sep 2026 21:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790112207;
	bh=APT6dQb8ezY9yy3qLQRqIjknZP3pMHPPJ9FKSrSjFh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GDJ0VVbT55HDTbFlp2bhNZJuM+BYEzoDdWll5nEljS71n0mIMpbjn1sHtZbUgAEf+
	 p4xLjWK1UdfDz+E3fFxk0kspz22qSiq9gW6CJLyBHCgCGFMfwLXZd1094m/RPA9SgM
	 /lPIwQoaiUWCeOUMV2bNvKTQnaPMdZlvJobmSpslLRRVZI9bPzk2rp/8S4HunPzRCh
	 Lbga0EB09pbFw3QpTvPbo87zOii5mI8OKzlOWPc1cTQVzq0DV/mWfYmo9VAEOSHrwv
	 ApeFJ7PeMbnfOcvqcKe+fBCiHpCMqVQQ8Blgkm6ZMScZaTpZ5nwFbogvCJFBt/T9me
	 KzZTb31JUqZbw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mike Lothian <mike@fireburn.co.uk>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] drm/amdgpu: hold a runtime PM reference for P2P dma-buf attachments
Date: Tue, 22 Sep 2026 17:23:24 -0400
Message-ID: <20260922212324.752416-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922212324.752416-1-sashal@kernel.org>
References: <2026092255-footer-unscathed-ed09@gregkh>
 <20260922212324.752416-1-sashal@kernel.org>
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
[ omitted err_pm_put cleanup because this branch lacks the reservation-locking failure path. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 36 +++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index 0b576481f2314..e6cc6c88cb60e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -41,6 +41,7 @@
 #include <linux/dma-buf.h>
 #include <linux/dma-fence-array.h>
 #include <linux/pci-p2pdma.h>
+#include <linux/pm_runtime.h>
 
 static const struct dma_buf_attach_ops amdgpu_dma_buf_attach_ops;
 
@@ -97,9 +98,43 @@ static int amdgpu_dma_buf_attach(struct dma_buf *dmabuf,
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
 	return 0;
 }
 
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
+}
+
 /**
  * amdgpu_dma_buf_pin - &dma_buf_ops.pin implementation
  *
@@ -270,6 +305,7 @@ static int amdgpu_dma_buf_begin_cpu_access(struct dma_buf *dma_buf,
 
 const struct dma_buf_ops amdgpu_dmabuf_ops = {
 	.attach = amdgpu_dma_buf_attach,
+	.detach = amdgpu_dma_buf_detach,
 	.pin = amdgpu_dma_buf_pin,
 	.unpin = amdgpu_dma_buf_unpin,
 	.map_dma_buf = amdgpu_dma_buf_map,
-- 
2.53.0


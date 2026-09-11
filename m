Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D97B3E4C6B
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 23:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789169405; cv=none; b=R5xqTtYzJGGnsqAF3/eBPQPKkIhmerJTORDDl3sWfojDIfOCvYBrEdrBwMsINq8zfTW/Rc7zwc6sqoYq0sWPazIVgIxz/aX5HzF3dBUmIxLVcEKyRTDBtxibh0ITeC1AceA0CrxTR6vY2yoZECBfcj7yNXve6IwdCPJgKgwfbPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789169405; c=relaxed/simple;
	bh=GQevWHlNDYqFIqwX/g/DHoeMG/eSbN4YDBoQuBwh72U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mmcegKQqJwrHaq9gmMpUZ6B4LVdolRJilXv9wMGOjToVF0r1ZzcYD2fHeFPq/3nJLS5KmFDwFWICQbiWVm5L+gCNqIArxO9TvzsiJ48+IwTN4c27J2IJcVMaPI/LvyxAKG6wdEKS2qIyPDzpxcgusqxM59ZM4KJ1q8I+hsJCC+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fireburn.co.uk; spf=none smtp.mailfrom=fireburn.co.uk; dkim=pass (2048-bit key) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b=ZLmUSpni; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fireburn.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fireburn.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="ZLmUSpni"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6350f89so47166f8f.3
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 16:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1789169401; x=1789774201; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=maDR2aqOdsCxMDMhneCqVUg2ho2Vb3T2xTiPLWinbKI=;
        b=ZLmUSpniDR+OVd0oaXhXaP21JUbnFXxl/e+eEV9PjttvnboUwkS5Cxf7aYyZYpcLTi
         yHgk12wRmkKJMPLFRW6DIbjJpnShv9losCVxaqfv5xJLnYbefMj4xa6xIvJxHCYTrh5T
         /+ABAiolm28OZRIhdZcM2ehu4+niNsfPT6nbowlA2P+DYar5gfXbE34GJLKypo9NtBbF
         UCjeQ1jNbRw9GKiL3xmIBotT6OHC1YqPJI4CFYZU/3GmhPVK96T107ZmAseX8yqqXOrU
         iHxlPBJBs3Fwz/9LptU8WmPEABwKmrnwOzWYriptvE3YY+MdtcjY3ZwumoM1/QvcJt4Z
         TCzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789169401; x=1789774201;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=maDR2aqOdsCxMDMhneCqVUg2ho2Vb3T2xTiPLWinbKI=;
        b=q0s5sIDz7DRvZ2t7XdKGVDWw4HthHG6kOUEE67MF5fwv8JfOEkChPXO+IesMdaHqWU
         7sS7HeUHyQN6XbNpxV2bR4s3seOsQX4MVw4770BQlUuNfBxHksL5/3GCMa1UcjvsCWrs
         VSgDN7wHlXTFMzWwppNrwQEKdF4iFU91iZujpPHgcM4dsfTe2dVl1fwwWz8nt8MiXwuI
         ZDUsFj4yq+GJ8Su4vT8Cy5ghrk2edV5o5AcNsjBNhlEBL6wO8GD5Dud4C7yTthXJSppN
         f0KMelQzujGPq9kwR9+Cx5x+vjjqb9kW6AtD/tIHRF3a0AxkeUuV09fW+5EIklxoFy+c
         L2Xg==
X-Forwarded-Encrypted: i=1; AKwUvBx5d7NypF+f+rWnfEhrcJnK3zg6R9WORU4W7H8tDt5K6kjBH7/qyBXqifH1AbrR79zTIM4PPss=@vger.kernel.org
X-Gm-Message-State: AFuF++mlYgZuap2F+DgGvNhNLO+5giGJiIVhXWDk/XR0KgPnEARooOBs
	dlRXI0YarvlHRgGFMlqw74kHizoLwUtMopeUx2KNk+AoxDnesg0cfOH5tx59y2+64w==
X-Gm-Gg: AYBFou0Rp1LYnCeEfizrF2C1zwhSYqZoSfOdxHzZhFrJL1MutOZrjWkiQlcotKNASr2
	SZRHAPYfJ4FzDZO//yzPWDh8va5qK3OsaATGiAKu3JeL9ejTPkKvWfocVYA8wjLel40mtfndXKY
	pp6bDxYh4JfuEd1W7uXfj9GJnPxPutOryGHrApIL0OB82lkNnmLv0VO4n+bEtiu1ZAnjSzJEXqT
	eicoxlY03hO2oOut0DlPe7oBo1toXfT0TbJI1EgaaukVtAxwsh6V0mEnh1PKpujX0JwYlGYDFpL
	ISwBvqa1sT3pFgmbR5cT+1tPG2kEGaQhZlqE3EtYYTPeZDJUpdV3/pM3slQtH1yBdxux/+RKs4m
	mBpLPXdyWhdrY5OAKJNOzqau2Iw/nJ3zKhpdyc09lWOHwI5et7KOD72Maart+KjV0fCcbqSrVF5
	QGgFXnGKw1f3WZSZ8JYv76/lxxbqjcBQgQgeVYSWeMxfWbRbLKn6VF2eq2cu1zZb/oWSYVeB0R5
	t7OCHTLAF3HBzCkztd6oCci09A=
X-Received: by 2002:a5d:5f91:0:b0:486:e6a2:2da2 with SMTP id ffacd0b85a97d-486f6bf0cdfmr584543f8f.21.1789169400567;
        Fri, 11 Sep 2026 16:30:00 -0700 (PDT)
Received: from quark ([2a01:4b00:d309:1c00:7807:3ba6:3446:4db2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb33ee5csm9136355f8f.20.2026.09.11.16.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 16:29:59 -0700 (PDT)
From: Mike Lothian <mike@fireburn.co.uk>
To: amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com,
	alexander.deucher@amd.com,
	kevinyang.wang@amd.com,
	dri-devel@lists.freedesktop.org,
	stable@vger.kernel.org,
	Mike Lothian <mike@fireburn.co.uk>
Subject: [PATCH v4] drm/amdgpu: hold a runtime PM reference for P2P dma-buf attachments
Date: Sat, 12 Sep 2026 00:29:08 +0100
Message-ID: <20260911232908.1056738-1-mike@fireburn.co.uk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911183825.935140-1-mike@fireburn.co.uk>
References: <20260911183825.935140-1-mike@fireburn.co.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
Cc: stable@vger.kernel.org
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
Assisted-by: Claude:Opus-5 [Claude Code]
---

v4: take a plain reference when runtime PM is disabled.
    pm_runtime_get_if_active() returns -EINVAL then, and v3 left
    peer2peer set without a reference, so detach dropped one it never
    took.  Reported by Sashiko AI review.
v3: take the reference in attach and drop it in detach, clearing
    peer2peer when the device is not active, as suggested by Christian.
    v2 only covered amdgpu_dma_buf_map() and left VRAM pinning exposed.
v2: use pm_runtime_get_if_active() instead of testing
    adev->mman.buffer_funcs_enabled, which was racy against a
    concurrent suspend.  Reported by Sashiko AI review.

Reproduced on a HawkPoint APU [1002:1900] driving the display with a
Navi 48 [Radeon AI PRO R9700] [1002:7551] on oculink for render
offload.  Without the patch kwin_wayland hits the call chain above
within a minute of the dGPU autosuspending and the desktop stops
repainting until it resumes.

Tested with v3: Chromium rendering on the dGPU and composited by kwin
6.7.5 for five minutes, then closed.  The dGPU stayed active while the
window was on screen and suspended six seconds after Chromium exited,
with no fallback errors or runtime PM usage count underflows.  After
an hour of yuzu render offload the dGPU also suspended once yuzu
exited.  v4 only changes the runtime PM disabled path, which this
machine does not hit.

 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 43 ++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index b33c300e26e2..9adf3eed8822 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -43,6 +43,7 @@
 #include <linux/dma-buf.h>
 #include <linux/dma-fence-array.h>
 #include <linux/pci-p2pdma.h>
+#include <linux/pm_runtime.h>
 
 static const struct dma_buf_attach_ops amdgpu_dma_buf_attach_ops;
 
@@ -100,15 +101,54 @@ static int amdgpu_dma_buf_attach(struct dma_buf *dmabuf,
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
@@ -350,6 +390,7 @@ static void amdgpu_dma_buf_vunmap(struct dma_buf *dma_buf, struct iosys_map *map
 
 const struct dma_buf_ops amdgpu_dmabuf_ops = {
 	.attach = amdgpu_dma_buf_attach,
+	.detach = amdgpu_dma_buf_detach,
 	.pin = amdgpu_dma_buf_pin,
 	.unpin = amdgpu_dma_buf_unpin,
 	.map_dma_buf = amdgpu_dma_buf_map,
-- 
2.55.0


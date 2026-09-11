Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161DA26ED37
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 18:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789151917; cv=none; b=YuUp1FQowhjYaSHJVoVmazPYh8LOzpyYfIf7iMZHWvi+IWkPs69DLQeQC4a9SC9YCHgo1UQUhWmgqjpCCc6yfA+IppVmmBLshAUUjGEyETsmXgCm1XDVq6jVPv8L6Y6f7DVULMdsjyWnyBf32vVbUEbdGcE5n5LKs3D/3v4te+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789151917; c=relaxed/simple;
	bh=acJm8YyyCUIQftd15Ca1RH1IgteKpk+omJ1/AkCX6Ak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uh/vAbOkTPm9s7WzHrdoZiHqXWiBxIaLqNL0Tedt5zG3wpzzCKWn+A2ge95FF6n+P7i1EiU3I87Ou/ZtG7jmzlIGCrjLNSSXWc25Bj3bZDUcGFmvQDyolovKb+9bxuW8/DL2lfV3XLAa0Ulr0odyG5cxux0sn7SiLG5Cye1C2Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fireburn.co.uk; spf=none smtp.mailfrom=fireburn.co.uk; dkim=pass (2048-bit key) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b=QWUCIiOR; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fireburn.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fireburn.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="QWUCIiOR"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-48434392b02so126609f8f.3
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 11:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1789151913; x=1789756713; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bIN1MnaZoYO+k9IvdVDRKIgD4gsx81w6whboS0Ne+GU=;
        b=QWUCIiORNNyS3KyaXk7gVDKqPvKSTjAU0bYFa0omjPvlFzMP3e13p2Wl5zn9+m6JBo
         Asw/jWkkddUw+Rk3fVa/gmkgap9NIbC1i7MlFnMG677scJPkDRPx156yi16PmAlQQJs+
         kqSpISZWC+74U7NmAFxfTTDB6xuLQrep0pL4gdfyS4xKC3fOq9pwA5BVK4IJnYIj92V2
         9R+Y6QKhgtQpVw7TDlhEhJABgFXCQ+33nyJh8sp0u+McUKbLdcqzWljk8HHqM608Yxbe
         nnlW1un6ypVcfVbTDNnpqIolg+ip5sjYp7jEaSVRvQwBlygvyjhbPp00H4qOeFDc/Rm+
         XyoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789151913; x=1789756713;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bIN1MnaZoYO+k9IvdVDRKIgD4gsx81w6whboS0Ne+GU=;
        b=QBKs0M5H90+p+sw83cyMiyv/dZl+oPhxW/JLc+yhh9gZn2wJPBURFy84syNbrEQ4G3
         SYASngduDZWV6VpKPWYQFqAHfCj3+SVvBzhvLbefgTL2HTjAjdy91oYm9tlyiEfdLgiJ
         V0DN6GTf04VJBG48GTv7Zh+kv1JL0TO2UpN4aNXrPzHsQRNMybUozrkdT5sin3HNuqOt
         rePZvR0MoUQfR/6RLMvahaxehwKqKkyzgQzig67K7Wi1OLNdN81HZHI8OlcZv4v8Ons2
         jleTZqxJB5X67m2C5128s2dwHm1xcOrz256gDocjLhdhg0spqMUqKls3LI11dOt7/ig/
         TfPA==
X-Forwarded-Encrypted: i=1; AKwUvByCyvwkyoWAmK6lEET/pcYuTNRrIozKU8AZhF0RLFa6iyEV14D/Yaw9hMtXj90VdF2PLwf3X2w=@vger.kernel.org
X-Gm-Message-State: AFuF++mtdSLUN/WAwibSB2ab6wGtYro0K51RqHTd3DdadL+eMiz8NAdd
	Nt2PHey7AnFWquZ39/SJRifrz/pNeOVlpLmNN/s7IoAAcrC4X/OIaLWZ1I3hlHT0HpquKzqOEqY
	8ZqKM3g==
X-Gm-Gg: AYBFou3ZE8IRG5Z7ZOc4ao7yGWNw3hGaNtXDydzkA5RNgNt3gQLOcaXHHW+XIwjmpvV
	asZ7pru0kQ3ZOqkq85ujetE7zy93ZNAcwxmvg64KFF9wbcQ3F0RVRK4qG4zwwojD3vx34l6sHKU
	c7+sNizpfNBPCpmK7SVfE9Bs/RmHZGvFgpfNgrcaSlWY4+vbNHcNG4KZosBGjsoq0imWxp2LUBW
	loIQ3crOJAyDbf8tZr5gglc4Cv6Z7rIQvy7SRmsnWXyk+emGn4r+YTJzBugjsGkqCJIn1+f5LVH
	2Siv1Vl/36oxIgGki4t0jG1qdDgMI5pLeX2l/cKt/lSPY5qLMzdC0SBe6nFXYcvKjDwh4V2zoe+
	+Sd8qSbOnIFL4jW0fc/m+ncXZJWA8DRahL3MPBsENyVMUVtJu95CSZInsu6xMAmFiMG8GxO9+Qc
	dKDL7pEfGVQ5eeefaiU6YfpIi9HQTL/9mf3VWtv2mWMwBIMy+3cq5rSGgks6xW2kZ6qimg+LHN0
	dohJGSfXS5hs4N+Nfv6Sp5rn1IH
X-Received: by 2002:adf:e991:0:b0:486:e8fa:f9b7 with SMTP id ffacd0b85a97d-486eb31a264mr11917325f8f.13.1789151912576;
        Fri, 11 Sep 2026 11:38:32 -0700 (PDT)
Received: from quark ([2a01:4b00:d309:1c00:7807:3ba6:3446:4db2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb34e608sm8204290f8f.23.2026.09.11.11.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 11:38:31 -0700 (PDT)
From: Mike Lothian <mike@fireburn.co.uk>
To: amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com,
	alexander.deucher@amd.com,
	kevinyang.wang@amd.com,
	dri-devel@lists.freedesktop.org,
	stable@vger.kernel.org,
	Mike Lothian <mike@fireburn.co.uk>
Subject: [PATCH v3] drm/amdgpu: hold a runtime PM reference for P2P dma-buf attachments
Date: Fri, 11 Sep 2026 19:38:25 +0100
Message-ID: <20260911183825.935140-1-mike@fireburn.co.uk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <358a518d-1490-40ba-bbe3-7f3696c1d696@amd.com>
References: <358a518d-1490-40ba-bbe3-7f3696c1d696@amd.com>
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
down.

Fixes: 030631e97b20 ("drm/amdgpu: revert "take runtime pm reference when we attach a buffer" v2")
Cc: stable@vger.kernel.org
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
Assisted-by: Claude:Opus-5 [Claude Code]
---

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
exited.

 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 39 ++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index b33c300e26e2..fae695c3e531 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -43,6 +43,7 @@
 #include <linux/dma-buf.h>
 #include <linux/dma-fence-array.h>
 #include <linux/pci-p2pdma.h>
+#include <linux/pm_runtime.h>
 
 static const struct dma_buf_attach_ops amdgpu_dma_buf_attach_ops;
 
@@ -100,15 +101,50 @@ static int amdgpu_dma_buf_attach(struct dma_buf *dmabuf,
 	    pci_p2pdma_distance(adev->pdev, attach->dev, false) < 0)
 		attach->peer2peer = false;
 
+	/*
+	 * P2P access needs the exporter awake for the lifetime of the
+	 * attachment.  pm_runtime_get_if_active() never resumes the device,
+	 * so it cannot deadlock against the reservation taken during resume.
+	 * A negative return means runtime PM is disabled and the device
+	 * cannot suspend, in which case the put in detach is a no-op.
+	 */
+	if (attach->peer2peer &&
+	    !pm_runtime_get_if_active(adev_to_drm(adev)->dev))
+		attach->peer2peer = false;
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
@@ -350,6 +386,7 @@ static void amdgpu_dma_buf_vunmap(struct dma_buf *dma_buf, struct iosys_map *map
 
 const struct dma_buf_ops amdgpu_dmabuf_ops = {
 	.attach = amdgpu_dma_buf_attach,
+	.detach = amdgpu_dma_buf_detach,
 	.pin = amdgpu_dma_buf_pin,
 	.unpin = amdgpu_dma_buf_unpin,
 	.map_dma_buf = amdgpu_dma_buf_map,
-- 
2.55.0


Received: from mail-qk2-f42.google.com (mail-qk2-f42.google.com [74.125.230.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF537489FD9
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 05:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790055684; cv=none; b=NxGAedVywqxHmo5b+s+wMi0sFntlq9u8FPPyqTLWUiyvj5Pwu57fTzaZ+BGt9uKs9TvI3QLuEmIemP5RdkUxdlZ3RtteVJqdOzfRcgm602tlJVMW+5mclstyK2Yu2DB5OoLyR9JU2ILp53pjwdDtvtporm8NqKqMsrbPpucfuA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790055684; c=relaxed/simple;
	bh=iFLkf+rOhLizaAv8+B8/2aNKubqrFbO1iPrtUYCmcBM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rGbfybjSLqUJXjv5PYWgkzhMzCigNQBImoM4MmzRlLlwWEp1hpDPdQ5+66NotxEI6M7e/2qD0YYpAHALbesuF1EOcOxKshH8Ub/AZ+Sd/ECUUZ6G2g4VVr5635NEgqfSa5UHRmctCzk5/HIaKTxswClURsylGa2zks1T1nyW6Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lkb43kdX; arc=none smtp.client-ip=74.125.230.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lkb43kdX"
Received: by mail-qk2-f42.google.com with SMTP id d75a77b69052e-52fb766bfd8so33953571cf.3
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 22:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790055682; x=1790660482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OCtKANYoOWihnD2FHnwq5WRM5Q7npRAqL2fydivBlQ4=;
        b=lkb43kdXEE9LC504DyqgZ/afe8lw0Bl4z1YlnM/Tag0QABB/RiggqKjvKCk14/HvuN
         zKr6IV1fF/4ZaYLTvryU75+XW4y52SSEwaUXwZ1e0OYf7JqBjULFpY7SXwcdCbnQSuZG
         GsbdRkO2a6nN30DA0XJby4gMBx37lxQsMQl8rjFaAfZYIf7ioeIiq8y+/f2ICsPA2Qlt
         O+9OIUn40wNDrfg2uOx9QxNBJItaStG5UexhoHwcyVQwO8kG39nnxR6aM8Nn5sjz3kng
         peNA2SkOCZGrCJ51kjASB+DZMH4kPDYC8xe3Wi6+Q9Cg6qCblA5owgcQ2aKG9ailxxkt
         6SyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790055682; x=1790660482;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OCtKANYoOWihnD2FHnwq5WRM5Q7npRAqL2fydivBlQ4=;
        b=0uGplAUQwhEemYeemMPocTyRJ77S5PdGoyKxQwLa/Y3H9x4+B6WphKqHw6nN4wIHuP
         Y9Q91wjyFd6pi6KQcrBHFOedwaL29XjKLhiokO4boz/6qdn3i4wYiR0Sx5pY1K5kaG+J
         V8viGDGKdDRBu6Tk1ZNZs+Ny80Cx2ohGyMnAD5d1AWksDQ2CQTH8QqkAvc65mvtuURPp
         M2BbA/FIJui17QepfkTv9seDOVKYoS1CMoiq7ENUmlRJ+YyF1GIFotMu6GJgJbp5Z5Pz
         RGUBDKEjTYak0P5yXLhqIH7QcDkwWaUcTR3lY/mWLlM/fO9RxFoKmm2s3IcwX9CeGOlw
         sZSg==
X-Forwarded-Encrypted: i=1; AKwUvByYVacd6/oTZEJrNEo9C5Dwi3eqBhnJuymaDtY/FJlE5h//hEHdAspdoQjrfYtE77fE9dc3+mc=@vger.kernel.org
X-Gm-Message-State: AFuF++kZDfcacW1RqorSu1rLucwomKF+t0Vk+3Gw2lcRaL0fernBcg1s
	NLvsLnGpzTMn+DdR2TI4RNMNR8JI0PQA4oikx3JWqD8jXIoD7E5hRR9Xc9UkJKDq
X-Gm-Gg: AYBFou1WXdzrznBhG0b6G6k7gt5XWuHEYEjWLg2dlKmxU094eVvkFAKorFVpo4t5ke/
	w/U0iobfFov9BWOR2mtgEK9KUkWIKP7juPneMu7aWHaWi70K9vrN9sp/RD7P2YYl1rXb5OxABLa
	vi7TX3KOXvwQt8xCJthOCDBN0SxB/W7v3LFqpZwCUhu4P+tUFvaNA7bBwHYiHIhOgqOk2CiilEb
	vt0cZm7f3/xcFwxt+UtVeJaXCZB0gpo4PQA4TfhU6IXxtebeKDKlGtiR+1tLgV6umpKaHu96TD8
	EkMgo3BWkRPPELcCwDLVorwAtGCEZrB24hVRcbTASaj/R7oIWu3HklKrqRpFg/fJOWgLVqge9yv
	CtB+mrPETMufNzokQgwvKote/eS5YTIDsdRAMr3NX0rhM8ld+YFBl+NkpB7yscL73/C1M7S6WpE
	dciA0xbZw3W9E97CWmsRigoluPU767Y3G060KS4IYxnUSB9hC3FkTR2lViMKjV0CsdvRkGkjpqT
	DEgVuA93MGVoL+JpnV8Kw==
X-Received: by 2002:a05:622a:1aaa:b0:532:9adc:639f with SMTP id d75a77b69052e-532d8e70943mr39247461cf.67.1790055681695;
        Mon, 21 Sep 2026 22:41:21 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532e192f96dsm4515801cf.23.2026.09.21.22.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 22:41:21 -0700 (PDT)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Jean-Philippe Brucker <jpb@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	virtualization@lists.linux.dev,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH v1] iommu/virtio: Reset device before deleting virtqueues on probe failure
Date: Tue, 22 Sep 2026 01:41:16 -0400
Message-ID: <20260922054116.416333-1-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

viommu_probe() marks the device DRIVER_OK before populating the event
virtqueue and registering the IOMMU device in sysfs.  viommu_fill_evtq()
hands the device a set of device-writable buffers through
virtqueue_add_inbuf(), so from that point on the device may write into
them and into the rings.

If either step fails, the error path deletes the virtqueues without
resetting the device first.  The event buffers are allocated with
devm_kmalloc_array() and are released as probe unwinds, so the device can
go on writing to memory that has been freed.

Reset the device before deleting the virtqueues, the way viommu_remove()
already does.

Fixes: edcd69ab9a32 ("iommu: Add virtio-iommu driver")
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
 drivers/iommu/virtio-iommu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 587fc13197f12..fa72ae23b8afa 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -1227,12 +1227,12 @@ static int viommu_probe(struct virtio_device *vdev)
 	/* Populate the event queue with buffers */
 	ret = viommu_fill_evtq(viommu);
 	if (ret)
-		goto err_free_vqs;
+		goto err_reset_vdev;
 
 	ret = iommu_device_sysfs_add(&viommu->iommu, dev, NULL, "%s",
 				     virtio_bus_name(vdev));
 	if (ret)
-		goto err_free_vqs;
+		goto err_reset_vdev;
 
 	vdev->priv = viommu;
 
@@ -1244,6 +1244,8 @@ static int viommu_probe(struct virtio_device *vdev)
 
 	return 0;
 
+err_reset_vdev:
+	virtio_reset_device(vdev);
 err_free_vqs:
 	vdev->config->del_vqs(vdev);
 

base-commit: f0100363d8c374bd8e9ea7c9ba02744f0b802ca4
-- 
2.43.0


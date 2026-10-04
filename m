Received: from mail-qk2-f41.google.com (mail-qk2-f41.google.com [74.125.230.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059C637267A
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 18:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791138148; cv=none; b=lYC1kLNMuhe0oB7w4de2Stxkmocq4CeZtS9zWRNOmAxV4m9rxXN0ompxjj47efwu9Gt+4fwGrDFyHEnT/eKI0bjtZ6gFawrXqr7T0iXY4wURo3BH3LTWjRLDq22+iGXYumuMkoCyE7bx+gB1KvdkOAK2bmG/Kh+yJD9jM1iLoL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791138148; c=relaxed/simple;
	bh=oWV1x6C2ME/T5Yb2MZ7o3ypqhTuzYDHLFIWMHTAMo24=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CMQC9pWh2mBSLEKlcg4WZqXmRZJb/YkpD70xOdrarJM9CBcr7UvlB8+oOtDywaNnXN0DtAkf4u6imWYD7XQ8V0SwHYYS3sk3adi4528A7xaBcdfWZAV1b25OmklwM6oIaIi/N4nA0OpmH9hyf5jFO8I+suBDCFpkBfA2pysyJaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cLoC9oum; arc=none smtp.client-ip=74.125.230.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLoC9oum"
Received: by mail-qk2-f41.google.com with SMTP id d75a77b69052e-534af4d1a37so9903521cf.2
        for <stable@vger.kernel.org>; Sun, 04 Oct 2026 11:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791138146; x=1791742946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CF4IOObCfjFDOCjh2XXYxYv4lcIPIAWQIMOn46YsfNw=;
        b=cLoC9oumtHi2+NPyQvkumHQwBnwGRT0dJCy7UsbLdoy2ZwygQ8v84QDuBBaytPcLQ3
         xsQ/tQ0G5K6m22T2zAA4NjNlJLJpEqFA9Bh6f8OCbEru4nuSUq5ilL/75fklI9s9cTAQ
         PjHy5rcN+ttEzR9yAEhMJIX9C+mXb2HZnArrq+URcXj90Gk21fyCVszN4dlEEVLACMlp
         OMOwCwzKHNOEtURBUNnKKbeVlPlFURK+Y18dWN+6gtPlaEDNC5o48KBQLzclrwu/PJkg
         tS5Hp6/sxQCjAR6Rn/sevoxvliJwnqbog8C3GihMCfnTVlgDstmEaU8LUTegyNo1w1it
         qsOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791138146; x=1791742946;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CF4IOObCfjFDOCjh2XXYxYv4lcIPIAWQIMOn46YsfNw=;
        b=Tg4bCwPq6jGz5oyV0ck77gYwLFdjLB8YzKsHG5l/dWD3LaKUIHcjBG5mftNFrts9pd
         hdfOd3TJQo6VxNOY5PHL7G/l8/N2sfDKS1F7apNEHWNF8mWesHE6GVirCv2buNMZ/6G3
         6zDJmZtFTmKe4daPPGPqtRUj6SBHK6wJYWYqdhn2jktSWPYfEYa99ZIvdW4X5Qt3fvV1
         Qt5xXLa+QledUodpGB9C5TgoJiAJ7neKdrj2FAb7VyodfkOEkJiYypF15cacYqWwx8lC
         4Qtey72crzvy4pvWLEC43ca30ZNCa0INZ1aGckem5jpGzn8h7lWWLvVPcQcJiFfMhnVF
         2S2Q==
X-Forwarded-Encrypted: i=1; AKwUvBy39SDtcgIHlI4h3Bj/I+7Z5P0lZ9B9Ptbyie0Js74tUTTDMCN0HP0I1R33444THGGTD/BsvjQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nipJ7850p0ueON88Vj1Vdq3l6XnKcmLSt8fV+hPwpy8Ztnpare
	nDkjAhFYfZqX5eib7EVZUXdmwItf6t0OWPoal0MXBXezNGAoUnIOOV1z
X-Gm-Gg: AYBFou0WN8OUZWe/iBYABGN9NKuR20KtErPVlqTenCkTahY74G7GqCZhaHIeZwi2owA
	p57JVAOumwdO3LSHh8rDokMEAc03/BC1Mh/4gWjrblZFgqc8LmHCA3r65bl7nzr9HWnnvv0zlXv
	eI7pCtG+RscYaNmWqePsffuZNmmroU3uO8raIen0vxxm4qEnS/YadakCHtRqfDoEc6ELYYwX/Vs
	iZhVbs8GB8i2WIah5V9dG2CB8+hiR3Bc1GBsoxFpJes/G73D1+16Bk42I7uSVg3ZAW+ENDc8bDC
	R2CKlUfhfAGokkRWf5pN/kONB+NXutkIAcOhd6TkyJDmwsgMIBAx7AVt4LwuOYGNcfJJvz25HD5
	51gbgEFfLy3o/aPpVj4rk1Kvm5/dk0gVygETRmcYp8DMxG3TWxD9DsKvwKdccAFD8VRXgbjUMo1
	PPLBlNTIK4xDW8hGGajpwgi8ClOmFV6xSkQlcLgzHqIrn2pJtKREOvYGp2Qec2rJRWDebmoAUfO
	F403dWxOjt9419zlXXGL9IecpQDRo0f
X-Received: by 2002:a05:622a:618c:b0:531:ab4:c604 with SMTP id d75a77b69052e-533bc652ea4mr174969861cf.1.1791138145927;
        Sun, 04 Oct 2026 11:22:25 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5351fd92b58sm27430061cf.21.2026.10.04.11.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 11:22:25 -0700 (PDT)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Jean-Philippe Brucker <jpb@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Eric Auger <eric.auger@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	virtualization@lists.linux.dev,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yuho Choi <oss.patchbox@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] iommu/virtio: Reset device before deleting virtqueues on probe failure
Date: Sun,  4 Oct 2026 14:21:10 -0400
Message-ID: <20261004182218.177343-1-oss.patchbox@gmail.com>
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
Cc: stable@vger.kernel.org
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
Changes in v2:
- No code change.
- Reword the commit message to explain how the device can write to the
  freed event buffers.
- Add Cc: stable.
- v1 was mistakenly posted twice; this version supersedes both postings.

v1: https://lore.kernel.org/all/20260911011249.1498825-1-oss.patchbox@gmail.com/

Compile-tested only (x86_64 allmodconfig, W=1).

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
 

base-commit: 7704c4c5bb127673b4f0ead839919db573559e38
-- 
2.43.0


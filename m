Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7914375AB8
	for <stable@vger.kernel.org>; Sun,  7 Jun 2026 08:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780822323; cv=none; b=EYj5p9C1J9bEvSS5Jy3SSQyugqdOgaHrBD2GOFGecrMUsJhW+UTxa/sjfzaRLAtLz0VIboGB41LkGDn/12nZcP4vEtUB6+Jy1T5zUj8x380HnsKEpd1H0yuBI/1A2+lxvpabJCHEjESTWJS0C47BAXHvGPrgwLPxAbodTOfGQyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780822323; c=relaxed/simple;
	bh=yZ2GguxlK4Drxdf98CXs/sIfvx5cN1fpDUIlYKB7jkI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=glmgzGAJEM91P4eqrm5M4bJcoHj9Ere8sgRBR2S7ZGOgbcxGf5pbbjoDVZaSqVbeHMufSgFzvXrnmzpm6+UincahFN/aN63Ba44hoCtZGizzlAfQG3Xt/Stf2kqdX1RNl1jQgrfOPvZIKrpDJw6risnMSPhRP360uFoliErBDM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OLhrBk0l; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLhrBk0l"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2bf18c30bb2so22368705ad.0
        for <stable@vger.kernel.org>; Sun, 07 Jun 2026 01:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780822319; x=1781427119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4++l0toGNACfhr7BSQDzAeyeBlGSABMgjc/G9H6+5Yg=;
        b=OLhrBk0ljtaXqDZFBXjtPLeiMLvFubWvx+a06SygiChTitpR0PnMQfWzsmgy72xOeA
         k3FZwh0xlNzmth96XdLe/7A1X2nOYRpKoifJ54jDimMVIf6NI78DQoXum95ulrZQ5Fmv
         /DSB9z096SYGjwzcvlnef6PpGw0L+ngVQeT5z57De2tWvs+tviPDmqDvS/fRi8hgBV3T
         +KQA6YAJTalhAWjLTyQe0BZF38/NEzI7kxyEElFny5Bp04nUGm5XA3tm8Yyg017HWgst
         319vmgdEqUVpO2gokjiTMha1z9C9xpXlWMQC9R1//ejV1BY6cIlMOLTlhiRqM0aJ1zLP
         JyLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780822319; x=1781427119;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4++l0toGNACfhr7BSQDzAeyeBlGSABMgjc/G9H6+5Yg=;
        b=B/gF70uXIW6tKx0hRzQVFl/EHgndQiYDDch7RuqcgoxT0+E6HPFPNedpVL8NAkY3v2
         SYDlKyBtfI8namx6YBxMiCtTpg17AE4DuvszFMu8r7rAUEJv/NNLZbZje1zaW9+IP7A5
         g9uFIEzvzJRD2S67GADB4VHvj8kyKZh0p0en9mSaZmBdLezdMAlxYEusW6xm6sJsMIRD
         EFCjNjzxolCAeREClp7gnCW+QcbTsQ2Wii7vVTx9zu3O3TFPbfBvoaSeUyxlK6jPiNpq
         HENCLG6TV+Vb5D/CANImn6uwURT8SKKTCba/UC4CAxEntg6UR1LclhTfQ1RKqhG0iAQK
         Mk1w==
X-Forwarded-Encrypted: i=1; AFNElJ9qjtqjV9leLEuXJXwxncJvO4eNpRBKp8xlGnhf5iOelYBQ4G29nL8yxB/MxIQno/FG8COQ/UE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl/4jsuqogittf65bKt8DxfyYdtVtOs6dcfw3ZSqEE1ugfBu60
	AymkaQGkM0Fw82TSzGF1Xt0H2K3sXoNJ2L3GYSvphHqwmCyyzFD1dMjr
X-Gm-Gg: Acq92OFz3Nkh8AMXesKImwmgeXcift6t8LrX5EVLD682CA7q3hY7v+2WL0ZH1iYDcp8
	5fid0lE2eeEiPZn3EWrB6i1N3+2UI3m+WRxQE3Xc/ufnlxlxC/SOoeoYDBAjthZolnVpn82tdQ8
	3hB/xXdVS+RsPfN8EYGNZtojNN5k1sRCN3rHyt4+E3aBMQ0v7gxev9kWvM22BS4/jeyA7FypPT3
	kf4GEiTlY/qN4WbCAzrR3bg/e8SidDMrgPYdS5xxbw8c4frBRR01i01nv4RY2502i5b8fOh1mS7
	6N8IPEV+xsWvUhzhvkR0L+O+qnUQ5zIUQtZ+wH5nn9UMVKW4nxHcy/Qze4XjVWmOkHU85SE0uzt
	ythT1aZ+/XddiaKyMJz+dfrMIombMTYcF7VarfOWG8JRc0X1TzRO+CeHi55ECee2vQtguu7AmZO
	1S+1Mhgc+1bucIScHHsGjhIUBZshlV8qr8S4gR2zJ0gUZ8ip8GcBl+D4TLaBqTRg==
X-Received: by 2002:a17:903:fa7:b0:2c0:dd75:e824 with SMTP id d9443c01a7336-2c1e80f98cfmr118746105ad.4.1780822319417;
        Sun, 07 Jun 2026 01:51:59 -0700 (PDT)
Received: from kfuzz ([202.120.234.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d395sm197220335ad.17.2026.06.07.01.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 01:51:58 -0700 (PDT)
From: Yiming Qian <yimingqian591@gmail.com>
To: Jason Gunthorpe <jgg@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>
Cc: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	keenanat2000@gmail.com,
	yimingqian591@gmail.com,
	stable@vger.kernel.org
Subject: 
Date: Sun,  7 Jun 2026 08:51:21 +0000
Message-ID: <20260607085145.71402-1-yimingqian591@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit









From 0000000000000000000000000000000000000000 Mon Sep 17 00:00:00 2001
From: Yiming Qian <yimingqian591@gmail.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
 stable@vger.kernel.org
Date: Sun, 7 Jun 2026 07:40:00 +0000
Subject: [PATCH] iommu/iommufd: Require write access for writable MAP_FILE
 mappings

IOMMU_IOAS_MAP_FILE pins folios from a shmem/tmpfs or hugetlb file and
uses them as the backing storage for an IOAS mapping.  When userspace sets
IOMMU_IOAS_MAP_WRITEABLE, the resulting IOMMU PTEs allow DMA writes to the
file-backed folios.

The file path currently records the IOMMU mapping as writable, but it does
not require the source file descriptor to have write permission.  It also
bypasses the address_space writable-mapping accounting used by memfd
sealing.  As a result, an O_RDONLY fd for a root-owned mode 0444 shmem file
can be mapped as DMA-writeable and a device, or the IOMMUFD selftest access
path, can write into the file page cache.  The same missing accounting also
means writable IOMMU mappings are not excluded by F_SEAL_WRITE or
F_SEAL_FUTURE_WRITE.

Treat writable MAP_FILE mappings like shared writable mappings: require an
FMODE_WRITE fd, call mapping_map_writable() when creating the backing
file-pages object, and hold that accounting until the iopt_pages object is
released.  This rejects already sealed files and prevents new write seals
from being installed while the IOMMU write mapping exists.

Cc: stable@vger.kernel.org
Reported-by: Yiming Qian <yimingqian591@gmail.com>
Reported-by: Keenan Dong <keenanat2000@gmail.com>
Signed-off-by: Yiming Qian <yimingqian591@gmail.com>
Signed-off-by: Keenan Dong <keenanat2000@gmail.com>
---
 drivers/iommu/iommufd/io_pagetable.h |  1 +
 drivers/iommu/iommufd/pages.c        | 18 +++++++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/io_pagetable.h b/drivers/iommu/iommufd/io_pagetable.h
index 27e3e311d395b..63e3fd738faf2 100644
--- a/drivers/iommu/iommufd/io_pagetable.h
+++ b/drivers/iommu/iommufd/io_pagetable.h
@@ -234,6 +234,7 @@ struct iopt_pages {
 		struct {			/* IOPT_ADDRESS_FILE */
 			struct file *file;
 			unsigned long start;
+			bool mapping_writable;
 		};
 		/* IOPT_ADDRESS_DMABUF */
 		struct iopt_pages_dmabuf dmabuf;
diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index 9bdb2945afe1e..f97d94d9eddd1 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -1421,13 +1421,27 @@ struct iopt_pages *iopt_alloc_file_pages(struct file *file,
 
 {
 	struct iopt_pages *pages;
+	int rc;
+
+	if (writable) {
+		if (!(file->f_mode & FMODE_WRITE))
+			return ERR_PTR(-EPERM);
+
+		rc = mapping_map_writable(file->f_mapping);
+		if (rc)
+			return ERR_PTR(rc);
+	}
 
 	pages = iopt_alloc_pages(start_byte, length, writable);
-	if (IS_ERR(pages))
+	if (IS_ERR(pages)) {
+		if (writable)
+			mapping_unmap_writable(file->f_mapping);
 		return pages;
+	}
 	pages->file = get_file(file);
 	pages->start = start - start_byte;
 	pages->type = IOPT_ADDRESS_FILE;
+	pages->mapping_writable = writable;
 	return pages;
 }
 
@@ -1668,6 +1682,8 @@ void iopt_release_pages(struct kref *kref)
 		dma_buf_put(dmabuf);
 		WARN_ON(!list_empty(&pages->dmabuf.tracker));
 	} else if (pages->type == IOPT_ADDRESS_FILE) {
+		if (pages->mapping_writable)
+			mapping_unmap_writable(pages->file->f_mapping);
 		fput(pages->file);
 	}
 	kfree(pages);

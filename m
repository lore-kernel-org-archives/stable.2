Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C144399E3
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 18:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784743666; cv=none; b=UoIBkm+POtVk4VAizwLi0pAqYLj68tB84dTJr/1Rd+s2gUMaEYzJ4unZu2zQrWr+5N0qHxww5PpgUISoPSKn4VgHd0cbXoTWA0nHME24/IXcskau1xrWfuR2W3swE99LrakRpDsgFYoytZt1HYFu4XiBAd7kRJ5vuvyFvDBQAiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784743666; c=relaxed/simple;
	bh=O7BeEDWxxKBsYS7C8jP9GOtotf/HRpW4W6xaT/lsk4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZN59hxYu1BoUNN28qdOdyzJ+wrzB0/g4CPSAFCsH+ht02E5vCQGaWkCe+5jTcMq1hVTIZ+YvVYp9T5d3nY12Hk0ISJwdORJQ5/I4wzv2ITuEUE5cA+s1XqOd0t0Mr+2cZ7nxPHjlphcW4KlePPthXSm7UUGDeqBvWUv2nVPhXvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BTpSMUvb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTpSMUvb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5053E1F00A3D;
	Wed, 22 Jul 2026 18:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784743664;
	bh=PQPX9SupVU8eQgw9ewFVWY09Xj5fdLt68WqRiu1SK1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BTpSMUvbk3CvcX8RULc0HbjCBFfl4h/tWRX7BTlDCkYhx7lfsLzr0SbuGKZqjwmgg
	 WIwFcBd6AmitlDBO/9g+i1HTheZh1OVsrWgNGpMQbVN3g1dj7IM+O9kKRwu3iW4ZfD
	 Oe7bCZCLAitVs2oMscaQM4GVUYLVWVu0xKL4PZMOCkFxxan71Al9TdvCeExd8LxQp2
	 +yQBk/laMKs7KNz+u3zg6eMJdZsq9vaf41sjKdKSgUUaqP4NOeHwDZP3SdgjBfql8u
	 rIojzW/QYZZ9shDng5vA7NKrUhu7qaxIcHdOOcDKpSfipB0UPHooKSMq6h1mQwsfmp
	 nATJvvvEfNKAA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/4] vduse: remove unused vaddr parameter of vduse_domain_free_coherent
Date: Wed, 22 Jul 2026 14:07:39 -0400
Message-ID: <20260722180741.2201839-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722180741.2201839-1-sashal@kernel.org>
References: <2026072042-splendor-serotonin-4456@gregkh>
 <20260722180741.2201839-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Eugenio Pérez <eperezma@redhat.com>

[ Upstream commit 766e1749c0ef6a09651be9b8a8283d508c322b58 ]

We will modify the function in next patches so let's clean it first.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260119143306.1818855-9-eperezma@redhat.com>
Stable-dep-of: 9c1523803445 ("VDUSE: avoid leaking information to userspace")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vdpa/vdpa_user/iova_domain.c | 3 +--
 drivers/vdpa/vdpa_user/iova_domain.h | 3 +--
 drivers/vdpa/vdpa_user/vduse_dev.c   | 2 +-
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
index fc41e15f7d78f5..0b20859777d480 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.c
+++ b/drivers/vdpa/vdpa_user/iova_domain.c
@@ -514,8 +514,7 @@ void *vduse_domain_alloc_coherent(struct vduse_iova_domain *domain,
 }
 
 void vduse_domain_free_coherent(struct vduse_iova_domain *domain, size_t size,
-				void *vaddr, dma_addr_t dma_addr,
-				unsigned long attrs)
+				dma_addr_t dma_addr, unsigned long attrs)
 {
 	struct iova_domain *iovad = &domain->consistent_iovad;
 	struct vhost_iotlb_map *map;
diff --git a/drivers/vdpa/vdpa_user/iova_domain.h b/drivers/vdpa/vdpa_user/iova_domain.h
index c7edd624e72073..c509ae5d1f0177 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.h
+++ b/drivers/vdpa/vdpa_user/iova_domain.h
@@ -64,8 +64,7 @@ void *vduse_domain_alloc_coherent(struct vduse_iova_domain *domain,
 				  gfp_t flag, unsigned long attrs);
 
 void vduse_domain_free_coherent(struct vduse_iova_domain *domain, size_t size,
-				void *vaddr, dma_addr_t dma_addr,
-				unsigned long attrs);
+				dma_addr_t dma_addr, unsigned long attrs);
 
 void vduse_domain_reset_bounce_map(struct vduse_iova_domain *domain);
 
diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 0ccece3f4f7da8..74c8dc2880040b 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -813,7 +813,7 @@ static void vduse_dev_free_coherent(struct device *dev, size_t size,
 	struct vduse_dev *vdev = dev_to_vduse(dev);
 	struct vduse_iova_domain *domain = vdev->domain;
 
-	vduse_domain_free_coherent(domain, size, vaddr, dma_addr, attrs);
+	vduse_domain_free_coherent(domain, size, dma_addr, attrs);
 }
 
 static size_t vduse_dev_max_mapping_size(struct device *dev)
-- 
2.53.0


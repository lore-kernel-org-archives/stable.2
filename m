Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630E33E49CD
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 16:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784739279; cv=none; b=K7N5kTQJsKB74d1H/5rx7qONVQ3Dbp1VbfAwxp8rPDagRdsAMNYL09Qw9ykOqRaMyV39+oFaUvEN1Hey1rIh7ZfOJYuNpfwCKC38VCBU0CFcGEyiYTHCVkvtgGgLEPVJgKROGKD5X84dCQz7AZZfacSpJt3h9bBHMgV3si/F5J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784739279; c=relaxed/simple;
	bh=tL0+8ty20ETzwb5iDUmj0Xk1zOiHgFyelkS+LGUIasg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nvr0P+Gab4OBG/sngW6r8IB5VuKjXUcTw6o+nCZ/MFKaUilaBn3B+8jhSz80Io+9wAAgfE62vwMFVTfettp7FtWdTGvTQ4gg0eSbB7fknGAjhgSB5W+9PWUbX+6lTfFesDnT8E7gzisilHOfL3xOZiSZOMqNX3E7teM0Je+wWRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3iHW8F8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3iHW8F8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87BAA1F00A3E;
	Wed, 22 Jul 2026 16:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784739278;
	bh=pSqNAkc7g1ni4C9JQ4LhRtxCWuHFkR+2Y8NluAfP7VQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z3iHW8F8pj4DvbWV3rkMsTWe3AtnlfNJLI5sBXXDAuNFUXbCy4Ku8YPveETSUnilM
	 uG9cY8J29A/LAWnQeJMIy9KpzaOV1cb8N+tJ+Kt9tO4W6c9RShkDMwLx+GM2mBwIuP
	 Xw/roHWvMPYM74pqNRjfOeu1v/F2OIEB6XWSuYi6wzlIA8OA5yYL0ayhBGldEU15Bh
	 I5LoqQ1swyIqjiS/SI1IfJpkGvIdvUzPLev5p59pM4fmclnZmIZ5pn7gyD6ojHCIa8
	 S5YuMPaj2RnoCu3uucdf+OcFxjFHZ5hAS6AoUyTYpx5uUU1xM2HJVxMpBV5y9rx+hL
	 1KYeGWJoqHhvQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/4] vduse: take out allocations from vduse_dev_alloc_coherent
Date: Wed, 22 Jul 2026 12:54:32 -0400
Message-ID: <20260722165433.1853588-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722165433.1853588-1-sashal@kernel.org>
References: <2026072041-theft-grievous-be50@gregkh>
 <20260722165433.1853588-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Eugenio Pérez <eperezma@redhat.com>

[ Upstream commit 489d76520612abf9a4ede4344349105406c91a73 ]

The function vduse_dev_alloc_coherent will be called under rwlock in
next patches.  Make it out of the lock to avoid increasing its fail
rate.

Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260119143306.1818855-10-eperezma@redhat.com>
Stable-dep-of: 9c1523803445 ("VDUSE: avoid leaking information to userspace")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vdpa/vdpa_user/iova_domain.c | 24 +++++++-----------------
 drivers/vdpa/vdpa_user/iova_domain.h |  5 ++---
 drivers/vdpa/vdpa_user/vduse_dev.c   | 14 ++++++++++----
 3 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
index 6ef11337d504fc..0a9f668467a8df 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.c
+++ b/drivers/vdpa/vdpa_user/iova_domain.c
@@ -493,17 +493,15 @@ void vduse_domain_unmap_page(struct vduse_iova_domain *domain,
 	vduse_domain_free_iova(iovad, dma_addr, size);
 }
 
-void *vduse_domain_alloc_coherent(struct vduse_iova_domain *domain,
-				  size_t size, dma_addr_t *dma_addr,
-				  gfp_t flag, unsigned long attrs)
+dma_addr_t vduse_domain_alloc_coherent(struct vduse_iova_domain *domain,
+				       size_t size, void *orig)
 {
 	struct iova_domain *iovad = &domain->consistent_iovad;
 	unsigned long limit = domain->iova_limit;
 	dma_addr_t iova = vduse_domain_alloc_iova(iovad, size, limit);
-	void *orig = alloc_pages_exact(size, flag);
 
-	if (!iova || !orig)
-		goto err;
+	if (!iova)
+		return DMA_MAPPING_ERROR;
 
 	spin_lock(&domain->iotlb_lock);
 	if (vduse_iotlb_add_range(domain, (u64)iova, (u64)iova + size - 1,
@@ -514,17 +512,12 @@ void *vduse_domain_alloc_coherent(struct vduse_iova_domain *domain,
 	}
 	spin_unlock(&domain->iotlb_lock);
 
-	*dma_addr = iova;
+	return iova;
 
-	return orig;
 err:
-	*dma_addr = DMA_MAPPING_ERROR;
-	if (orig)
-		free_pages_exact(orig, size);
-	if (iova)
-		vduse_domain_free_iova(iovad, iova, size);
+	vduse_domain_free_iova(iovad, iova, size);
 
-	return NULL;
+	return DMA_MAPPING_ERROR;
 }
 
 void vduse_domain_free_coherent(struct vduse_iova_domain *domain, size_t size,
@@ -533,7 +526,6 @@ void vduse_domain_free_coherent(struct vduse_iova_domain *domain, size_t size,
 	struct iova_domain *iovad = &domain->consistent_iovad;
 	struct vhost_iotlb_map *map;
 	struct vdpa_map_file *map_file;
-	phys_addr_t pa;
 
 	spin_lock(&domain->iotlb_lock);
 	map = vhost_iotlb_itree_first(domain->iotlb, (u64)dma_addr,
@@ -545,12 +537,10 @@ void vduse_domain_free_coherent(struct vduse_iova_domain *domain, size_t size,
 	map_file = (struct vdpa_map_file *)map->opaque;
 	fput(map_file->file);
 	kfree(map_file);
-	pa = map->addr;
 	vhost_iotlb_map_free(domain->iotlb, map);
 	spin_unlock(&domain->iotlb_lock);
 
 	vduse_domain_free_iova(iovad, dma_addr, size);
-	free_pages_exact(phys_to_virt(pa), size);
 }
 
 static vm_fault_t vduse_domain_mmap_fault(struct vm_fault *vmf)
diff --git a/drivers/vdpa/vdpa_user/iova_domain.h b/drivers/vdpa/vdpa_user/iova_domain.h
index 3c2830cb9d4e90..ead5ab477079b6 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.h
+++ b/drivers/vdpa/vdpa_user/iova_domain.h
@@ -67,9 +67,8 @@ void vduse_domain_unmap_page(struct vduse_iova_domain *domain,
 			     dma_addr_t dma_addr, size_t size,
 			     enum dma_data_direction dir, unsigned long attrs);
 
-void *vduse_domain_alloc_coherent(struct vduse_iova_domain *domain,
-				  size_t size, dma_addr_t *dma_addr,
-				  gfp_t flag, unsigned long attrs);
+dma_addr_t vduse_domain_alloc_coherent(struct vduse_iova_domain *domain,
+				       size_t size, void *orig);
 
 void vduse_domain_free_coherent(struct vduse_iova_domain *domain, size_t size,
 				dma_addr_t dma_addr, unsigned long attrs);
diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index a5c4a61605685e..505171a17de873 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -860,18 +860,23 @@ static void *vduse_dev_alloc_coherent(struct device *dev, size_t size,
 {
 	struct vduse_dev *vdev = dev_to_vduse(dev);
 	struct vduse_iova_domain *domain = vdev->domain;
-	unsigned long iova;
 	void *addr;
 
 	*dma_addr = DMA_MAPPING_ERROR;
-	addr = vduse_domain_alloc_coherent(domain, size,
-				(dma_addr_t *)&iova, flag, attrs);
+
+	addr = alloc_pages_exact(size, flag);
 	if (!addr)
 		return NULL;
 
-	*dma_addr = (dma_addr_t)iova;
+	*dma_addr = vduse_domain_alloc_coherent(domain, size, addr);
+	if (*dma_addr == DMA_MAPPING_ERROR)
+		goto err;
 
 	return addr;
+
+err:
+	free_pages_exact(addr, size);
+	return NULL;
 }
 
 static void vduse_dev_free_coherent(struct device *dev, size_t size,
@@ -882,6 +887,7 @@ static void vduse_dev_free_coherent(struct device *dev, size_t size,
 	struct vduse_iova_domain *domain = vdev->domain;
 
 	vduse_domain_free_coherent(domain, size, dma_addr, attrs);
+	free_pages_exact(vaddr, size);
 }
 
 static size_t vduse_dev_max_mapping_size(struct device *dev)
-- 
2.53.0


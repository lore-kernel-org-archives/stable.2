Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5ECF4399C9
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 18:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784743667; cv=none; b=n0kIo6kzDQKBEdS626IUDRUMXKHu16i9nXE7Is0fVyN3u8UERadHbkm817d5LDC067Zg5dt5vnxHbWJ+W1XaYyiOExzGni1EFvoVin6YVD5hiBGfXFCegOiohXKjZdsi+/HE4BPhOPSURvAN7rL9m4FRHMSMuDV21gvaxiVpKRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784743667; c=relaxed/simple;
	bh=/moQ36cLFhZdHBpsjMxa/25L7cNqFtwYetHfcF0H3qU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iOLlhfEhZiAnt0MSNPMVOE0fEdUZeBhBxgWBsJEyiNImXtsMOjXsKBTKa1nFnTs5UZYD1xSBDMhlT8gChLBYI63qJGtR4W1E68VS84AuyZBwha+++ZaKZzxQVhZ6C08N8dJJSDE+wOxplrFWuPgqTF7eCoQUzU7R9dwp6TP7Cuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wo+huSiZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wo+huSiZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16EDE1F00A3A;
	Wed, 22 Jul 2026 18:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784743665;
	bh=CslbrvGZ94eSbRHx5OAge3sm1t9pFDN20WTKu4RPh0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Wo+huSiZ3vJhQHr6DISu8pWgWl1wFK+Dk8pR0485UpXXa5v9kSho07Xjfa8de09PF
	 ShnmEKhLPkx3tTpJL0T+6rnL6JU2WZBhcAPywg3ORpGB2rfXia8foXueBU/PJND1K2
	 tmhKzTLvCZbdSL9T9kz4SdCtuTbY0QekZ6ZKBN9VQhqsHUzU+fQEopHZzAuNeuPLH9
	 d6kEOpdJZbhDa1JXIWWhyhBTmV3wpDjm+kb4wcqVQMZSSiYo5FEgc/52+uDeyDTzGp
	 nV+9geGWoe+rubg58F7oomKTJarsDZOM1yveDXLHJfpN7F/jGMPKE2kLhZ9EQ+07Q/
	 qbfWJUaq/640g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/4] vduse: take out allocations from vduse_dev_alloc_coherent
Date: Wed, 22 Jul 2026 14:07:40 -0400
Message-ID: <20260722180741.2201839-3-sashal@kernel.org>
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
index 0b20859777d480..db449c4a9f78dc 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.c
+++ b/drivers/vdpa/vdpa_user/iova_domain.c
@@ -479,17 +479,15 @@ void vduse_domain_unmap_page(struct vduse_iova_domain *domain,
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
@@ -500,17 +498,12 @@ void *vduse_domain_alloc_coherent(struct vduse_iova_domain *domain,
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
@@ -519,7 +512,6 @@ void vduse_domain_free_coherent(struct vduse_iova_domain *domain, size_t size,
 	struct iova_domain *iovad = &domain->consistent_iovad;
 	struct vhost_iotlb_map *map;
 	struct vdpa_map_file *map_file;
-	phys_addr_t pa;
 
 	spin_lock(&domain->iotlb_lock);
 	map = vhost_iotlb_itree_first(domain->iotlb, (u64)dma_addr,
@@ -531,12 +523,10 @@ void vduse_domain_free_coherent(struct vduse_iova_domain *domain, size_t size,
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
index c509ae5d1f0177..38feeb6ea4ded3 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.h
+++ b/drivers/vdpa/vdpa_user/iova_domain.h
@@ -59,9 +59,8 @@ void vduse_domain_unmap_page(struct vduse_iova_domain *domain,
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
index 74c8dc2880040b..59b42e5990e97a 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -792,18 +792,23 @@ static void *vduse_dev_alloc_coherent(struct device *dev, size_t size,
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
@@ -814,6 +819,7 @@ static void vduse_dev_free_coherent(struct device *dev, size_t size,
 	struct vduse_iova_domain *domain = vdev->domain;
 
 	vduse_domain_free_coherent(domain, size, dma_addr, attrs);
+	free_pages_exact(vaddr, size);
 }
 
 static size_t vduse_dev_max_mapping_size(struct device *dev)
-- 
2.53.0


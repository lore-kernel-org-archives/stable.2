Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB150353A8B
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 16:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784736456; cv=none; b=aSZPMCVQW2pRebPW4x0++1nom40T1EhvbXEvSqEm6+NbETtMIRGE4qTqfVBGYMP/CeDjnvUAvuMlFXCCiuJoYvdnTQVrwmbLasM+YNXw31AOEumu42jV7BJqeGUP5h5nAce4+47Lt+zT2g23ZbrZijhy8C1Uei3UDHVVs6NpeHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784736456; c=relaxed/simple;
	bh=NcsY4yVNt0CC+qWoj4s/47k2/mHQsw5EzclTFdk0/uY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pbum6gnRtojMtCGZ1FlJTFwVAdK+Hy3U6cMb/NNHkMwQV7XZwxvHXLER5sMAZG//wXdPG1t/bi+AuEVmK9l3aPtzftGL3Hb6ir6hq8cSAJhM9aXsXpep6tZyrcvWbCgUXfMz6EkAN2VqNGlUlxv5oxgPKUYOno6EsTV3VLBsOKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FRjGuUlB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FRjGuUlB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 063341F00A3E;
	Wed, 22 Jul 2026 16:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784736455;
	bh=6n9QQGcxoIFB8DidE2LVNX7MSbiTw4VmbNYVyOo8mk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FRjGuUlBX+Ns+FAkngP9cdpXexIpvlWAMMbRZyFQh9sub+QOgLXbnjBIGLVk6ioDp
	 7/ltkraU1ZUV1eE9+IKBYItTpwOi6DzB/asVdfZmOooJgnR8MmyXHCLeNALUstzj9r
	 MtHQ/WR+Pty4EdKvXlVRPS3L1Urz9p9fvhzi/PEfYO5OOjZCufPXR+7XUyd8cH4UiO
	 i0cj+zI3rVuxQ0okYQuPgrgC9MahB31rNGp1ckDHXAEqDq+rREuJC1VBaO+tDDEBt3
	 XUuta9vZjp2DWNCxy7ikgMxobZaP+MeLhHnBAZSYjbVcjBMFninUvsqDYuVVMK56fT
	 4lS7gaINdMb1Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/4] vduse: take out allocations from vduse_dev_alloc_coherent
Date: Wed, 22 Jul 2026 12:07:30 -0400
Message-ID: <20260722160731.1739521-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722160731.1739521-1-sashal@kernel.org>
References: <2026072041-connected-dole-9dc1@gregkh>
 <20260722160731.1739521-1-sashal@kernel.org>
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
 drivers/vdpa/vdpa_user/iova_domain.c | 3 ---
 drivers/vdpa/vdpa_user/vduse_dev.c   | 1 +
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
index aab730e8a31671..0a9f668467a8df 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.c
+++ b/drivers/vdpa/vdpa_user/iova_domain.c
@@ -526,7 +526,6 @@ void vduse_domain_free_coherent(struct vduse_iova_domain *domain, size_t size,
 	struct iova_domain *iovad = &domain->consistent_iovad;
 	struct vhost_iotlb_map *map;
 	struct vdpa_map_file *map_file;
-	phys_addr_t pa;
 
 	spin_lock(&domain->iotlb_lock);
 	map = vhost_iotlb_itree_first(domain->iotlb, (u64)dma_addr,
@@ -538,12 +537,10 @@ void vduse_domain_free_coherent(struct vduse_iova_domain *domain, size_t size,
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
diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index a549396fffb9de..717e132ba5c64b 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -938,6 +938,7 @@ static void vduse_dev_free_coherent(union virtio_map token, size_t size,
 	domain = vdev->domain;
 
 	vduse_domain_free_coherent(domain, size, dma_addr, attrs);
+	free_pages_exact(vaddr, size);
 }
 
 static bool vduse_dev_need_sync(union virtio_map token, dma_addr_t dma_addr)
-- 
2.53.0


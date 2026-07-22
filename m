Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A507C3806CE
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 16:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784739278; cv=none; b=nxFZylr689zf9zxFCITqzNNsuzCaPUJVCpQ9D5Ts0cxXhEFrHp+0jWGvTLZWH/VIq+l3uFb/av6uUVxx7wnmexgyX14ThMlngwe38h3bM4XFRpDfZi6bIPvV2Z9Hp4/5t7Fu1rdgFhOxVCnM3eI+9Vs6VNn1iUG2x4XXBL/5ulw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784739278; c=relaxed/simple;
	bh=TFaID8YU8qcdQ4zD6iUxDIs9m8H/kln/rOkEP1FXXTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LiEEkn/AyZo2Jq+352EZbEw57LqyG+zi8+VnRXOHhY4m1q5a6KSHminQFogP5q2+kykyOnJLGb8+AAGuuy6Td73HKI5r/zkVvMnLjee7/NkE+xAHORn9g+68a5Lnn00RJQOTMnvr2CUNDz4Nd9hUkxBYaBCfCFdT82znAqZyyWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JKW1S4FI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JKW1S4FI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 354461F00A3A;
	Wed, 22 Jul 2026 16:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784739277;
	bh=QLcP+6qGDUVz1aQmhL7djUz+A5DkuL6krY4FOmwkf3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JKW1S4FI7lHwLJwlxDpOLUfZednbRZiyFDNsFDCntEzEHdZLVVLgSgsZKYDyMpGWp
	 vuVMq1ZVokHLO9VHz3yr619XsXS4ebZJFN96+hv6pOBG4iqnAswmhUyGlnzljY3BUv
	 ByKCp9qg6333GxumUT73boP8z7zCGXo2uZmwuBsUNu9RZYJ+STEiVcDAGJNdub9enO
	 8PbFViWt4G/aZ/Ok+twzJ8eUTMJUbkqLrnT7mYmRGjNx7ab531gLkb41EvCdrkTsrf
	 aaWXy9SSK5QqV6dRTMkqHY+HbDhWlt5NteDaWqJTunTF6PWiwntec7DpIgqwOI8aDo
	 z5cIecqhTAl3Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/4] vduse: remove unused vaddr parameter of vduse_domain_free_coherent
Date: Wed, 22 Jul 2026 12:54:31 -0400
Message-ID: <20260722165433.1853588-2-sashal@kernel.org>
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
index 402e66a0ae3951..6ef11337d504fc 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.c
+++ b/drivers/vdpa/vdpa_user/iova_domain.c
@@ -528,8 +528,7 @@ void *vduse_domain_alloc_coherent(struct vduse_iova_domain *domain,
 }
 
 void vduse_domain_free_coherent(struct vduse_iova_domain *domain, size_t size,
-				void *vaddr, dma_addr_t dma_addr,
-				unsigned long attrs)
+				dma_addr_t dma_addr, unsigned long attrs)
 {
 	struct iova_domain *iovad = &domain->consistent_iovad;
 	struct vhost_iotlb_map *map;
diff --git a/drivers/vdpa/vdpa_user/iova_domain.h b/drivers/vdpa/vdpa_user/iova_domain.h
index e36d4b7ef5d045..3c2830cb9d4e90 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.h
+++ b/drivers/vdpa/vdpa_user/iova_domain.h
@@ -72,8 +72,7 @@ void *vduse_domain_alloc_coherent(struct vduse_iova_domain *domain,
 				  gfp_t flag, unsigned long attrs);
 
 void vduse_domain_free_coherent(struct vduse_iova_domain *domain, size_t size,
-				void *vaddr, dma_addr_t dma_addr,
-				unsigned long attrs);
+				dma_addr_t dma_addr, unsigned long attrs);
 
 void vduse_domain_reset_bounce_map(struct vduse_iova_domain *domain);
 
diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 7f569ce8fc7bea..a5c4a61605685e 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -881,7 +881,7 @@ static void vduse_dev_free_coherent(struct device *dev, size_t size,
 	struct vduse_dev *vdev = dev_to_vduse(dev);
 	struct vduse_iova_domain *domain = vdev->domain;
 
-	vduse_domain_free_coherent(domain, size, vaddr, dma_addr, attrs);
+	vduse_domain_free_coherent(domain, size, dma_addr, attrs);
 }
 
 static size_t vduse_dev_max_mapping_size(struct device *dev)
-- 
2.53.0


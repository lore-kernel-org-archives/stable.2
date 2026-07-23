Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8841118CBE1
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 01:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784769412; cv=none; b=AuL3KP13XoUPlbGxDF4/FJMNewtP/MNmu8SuZDq5LAY2mvh+OiODV4eCCyEhK26/oHGQX2TsWm/Q5+m5YlnHm+Cr6EAIVoa6CgIuLF5DXD4oaGCnuh4RMx1m8tONwirWKXbwsMMLsd1mvI0vjNZCpsGelUY22Bxym2hDSUulc+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784769412; c=relaxed/simple;
	bh=KYVGP+mv8t77DHIVnIjvsU5sRgA345f84AneIusjABQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C16YDghhVoWCAS+u2/zH7+9YBeqVMVr6DGD19ZrjF55TFnZxf5y1Dcjf2LJe6bbCpY2+rgZ0relweaqJtv6QRb7nG6rxZXlNlPeCqulyGC7CtQk0wFP7DgSOfqT7Z+wi8086hkG010BDeQ0K2vcCnyp0AztdXkR+0HDkYLAVNTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jwrqnb3H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jwrqnb3H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B50211F00A3D;
	Thu, 23 Jul 2026 01:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784769411;
	bh=wxNUxBByDJ7brLujliUSBeMqfQkE2r7JBIBMzLtW+9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Jwrqnb3HgcJQJoxO37J1xdOeMnj+v/NMqHyk7VOOJITiDbXRIEF3EiGoLKlV6Xu1/
	 JUv4NxmVJ5UID6gKYr8SW2JFtUnRc9bnx1KOXKVMuCYS/F5U3wt87OGVTaN88AxNg5
	 ZG1atQtnyPuS+6xtrdqmc5QsbdQoidLa86134QQ10wsYT5A8jgwXmHaXMBnMgaXpAY
	 NnUN8tJcfQFIKZa7CEEyR8S7+KOFB1ZAXhh0NUZhyYFTzSz0nO3kOcvnULQ9ABBum5
	 Q39xSsxSWOakUX7FGy+HwC0ziWnv2ieC7FqHZowUZslChfa5qT1a10VpnKUXM49QXb
	 NEs/ANfFL5YYw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/4] vduse: remove unused vaddr parameter of vduse_domain_free_coherent
Date: Wed, 22 Jul 2026 21:16:46 -0400
Message-ID: <20260723011648.2779203-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723011648.2779203-1-sashal@kernel.org>
References: <2026072042-challenge-grimacing-a682@gregkh>
 <20260723011648.2779203-1-sashal@kernel.org>
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
index 35363ca0b49bd4..d16ec4fcd797b5 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.c
+++ b/drivers/vdpa/vdpa_user/iova_domain.c
@@ -416,8 +416,7 @@ void *vduse_domain_alloc_coherent(struct vduse_iova_domain *domain,
 }
 
 void vduse_domain_free_coherent(struct vduse_iova_domain *domain, size_t size,
-				void *vaddr, dma_addr_t dma_addr,
-				unsigned long attrs)
+				dma_addr_t dma_addr, unsigned long attrs)
 {
 	struct iova_domain *iovad = &domain->consistent_iovad;
 	struct vhost_iotlb_map *map;
diff --git a/drivers/vdpa/vdpa_user/iova_domain.h b/drivers/vdpa/vdpa_user/iova_domain.h
index b87dac1137d7c7..940778b60318fa 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.h
+++ b/drivers/vdpa/vdpa_user/iova_domain.h
@@ -61,8 +61,7 @@ void *vduse_domain_alloc_coherent(struct vduse_iova_domain *domain,
 				  gfp_t flag, unsigned long attrs);
 
 void vduse_domain_free_coherent(struct vduse_iova_domain *domain, size_t size,
-				void *vaddr, dma_addr_t dma_addr,
-				unsigned long attrs);
+				dma_addr_t dma_addr, unsigned long attrs);
 
 void vduse_domain_reset_bounce_map(struct vduse_iova_domain *domain);
 
diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 4684d4756b427e..1f594e4db71eb1 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -793,7 +793,7 @@ static void vduse_dev_free_coherent(struct device *dev, size_t size,
 	struct vduse_dev *vdev = dev_to_vduse(dev);
 	struct vduse_iova_domain *domain = vdev->domain;
 
-	vduse_domain_free_coherent(domain, size, vaddr, dma_addr, attrs);
+	vduse_domain_free_coherent(domain, size, dma_addr, attrs);
 }
 
 static size_t vduse_dev_max_mapping_size(struct device *dev)
-- 
2.53.0


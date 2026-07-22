Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B2442124C
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 18:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784743256; cv=none; b=QdeM5VOv/mre1z0rb/Ai5PkkEf+EiMQUQN03txPWDl7+uMqMPetZvgMhd8ahexCm61zBLZu663fZ3dv+TvQyKydG0zOxvU9EXkCV86NkHUFrP9COqmNK+BV6k4Bi6Q6fl9BmTDhxZO/0hkuO01T0uqXsaReSWWS2x3nidnf2a58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784743256; c=relaxed/simple;
	bh=yp1B5D0nvEFdPqq29eeR6yay4xpNFdv8W4JsWDZPepQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K+Hez57i5155vOpPfgE0LzLOASBP7ip3x82CdnlQKAo1hfXdcZEjbD/i76/hGJTbrRbbcW/cl18jQS+l3jV77J8IkMuEtjot6sXm8WUPSRCcsDTPIwJV2C6l3FIaK0MJO3TidUl70IJ4SuJHYujk9vX8Jn+kMBhfL9y/0u1qmGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DUKSxnme; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DUKSxnme"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 346301F00A3D;
	Wed, 22 Jul 2026 18:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784743255;
	bh=qE/IK5nFuXg20I8ijUmvd7xO02BgtYXBJBEgB5J0Ow4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DUKSxnmeaFbZHnRLy/7dAhKWNOFz9oODRBB+YAR6BoePXQyonFy37iwKMCzIpYXC+
	 xyMBSu6r9StL/F4kPKhdw4IOlIdAFAwGvKhHCjBb6x83mGRmIdQ33z3WtO2uBoHJGS
	 /dky8XbrtQccX6o9cEtCAK0xLkG4pGjSOLZXbli0NjoK2PZi0QXoX8OBl2Lj1bSniq
	 M67Ba8hmrtkgLlC5sIsAnX5qn+7gnKivySaBTmk78aEoYIcjL8LXHK1VDOe+y+mSmU
	 +dmBk7QxMFALwrKglDFev0WiLhEk/BIkF7AUSojPNSA5wAOWINNXoNtWyKBGUa5tbI
	 28GA+hNMG0BbA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/4] vduse: remove unused vaddr parameter of vduse_domain_free_coherent
Date: Wed, 22 Jul 2026 14:00:50 -0400
Message-ID: <20260722180052.2184339-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722180052.2184339-1-sashal@kernel.org>
References: <2026072041-rectal-mammogram-740b@gregkh>
 <20260722180052.2184339-1-sashal@kernel.org>
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
index 4e8fa3f7af5f94..b686561be40031 100644
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
index b08946be6f4a08..b07dd9eff1056a 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.h
+++ b/drivers/vdpa/vdpa_user/iova_domain.h
@@ -63,8 +63,7 @@ void *vduse_domain_alloc_coherent(struct vduse_iova_domain *domain,
 				  gfp_t flag, unsigned long attrs);
 
 void vduse_domain_free_coherent(struct vduse_iova_domain *domain, size_t size,
-				void *vaddr, dma_addr_t dma_addr,
-				unsigned long attrs);
+				dma_addr_t dma_addr, unsigned long attrs);
 
 void vduse_domain_reset_bounce_map(struct vduse_iova_domain *domain);
 
diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index d7bda179ef79f8..ab6045d6154f3f 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -849,7 +849,7 @@ static void vduse_dev_free_coherent(struct device *dev, size_t size,
 	struct vduse_dev *vdev = dev_to_vduse(dev);
 	struct vduse_iova_domain *domain = vdev->domain;
 
-	vduse_domain_free_coherent(domain, size, vaddr, dma_addr, attrs);
+	vduse_domain_free_coherent(domain, size, dma_addr, attrs);
 }
 
 static size_t vduse_dev_max_mapping_size(struct device *dev)
-- 
2.53.0


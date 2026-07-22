Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD56A4399ED
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 18:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784743667; cv=none; b=moGTmSUJe8SomznJVhNMJ5CFtpNnft0cZIOwzsr5hd9RjgqiFKY0XFFWByy0WCR63UqNLoJBVX6G4yTnAcpy8XLe2QG8zQabCBvPcpJqiJ8cEy9cDzmGokMYiQ5lMpa4ibzRU0FJjd6yPLF3U7tFhAgXjFXdwHiyflbRY73mO/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784743667; c=relaxed/simple;
	bh=Utj83RukygMOcMoy/sF3V87Vq83nxr0EVlx7ijlcy+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qj6xW4wQek8BZJ2hNo5UsZL5W+rUPOIVISGutg83dyI+NRZQ8IP4c9qCgZekQNlvGRAaOGR07gcFZBrAK8tU8neMw8n2x2+syNbew8URSpSAAlroWZ4P7g+wc2k8ekN3KuBdVB2IkffPbpMwGvEAGEE5mk/foUT5Wj1iyBCX8qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e9NUu0nb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e9NUu0nb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E45901F000E9;
	Wed, 22 Jul 2026 18:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784743666;
	bh=ttEmhppM1TyNuZfVIQD5MulKCMIz760rIKSlfzM9ckU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e9NUu0nbuJ0HPSRqvsksaj8IyWB8qop4Hkf1WGZrzF/x1Cqx36nrJxVvYRKSeVEwK
	 QOwAN0SkhrOgqrS43oWXoJIM0MbErvrAml5O8TbTwZWRBTLxVvN8G/sAvVHR3BEy/Z
	 aPmiy3IDOltfQFf4NT6v5FfkQEcAszhYJ7bTWiBvJ+c/PjiqT8bPFHTftAnjW1JzGV
	 07CMmj1o+lkHaKNDvhKLmZSkfg3fe3ArEUIoLYIhACNV+JM6zpSWCh4CnxrqGOZ9Rq
	 mg/9kdBGvAaUUBT8R4p89BnPeUS7Al/RNlKvPjXrcxtZihqOlK4hfbfmwL1W6Vy8TT
	 6/wdPjuC6dM5g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jason Wang <jasowang@redhat.com>,
	Xie Yongji <xieyongji@bytedance.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 4/4] VDUSE: avoid leaking information to userspace
Date: Wed, 22 Jul 2026 14:07:41 -0400
Message-ID: <20260722180741.2201839-4-sashal@kernel.org>
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

From: Jason Wang <jasowang@redhat.com>

[ Upstream commit 9c1523803445ee0348f62b77793266dd981596e0 ]

The bounceing is not necessarily page aligned, so current VDUSE can
leak kernel information through mapping bounce pages to
userspace. Allocate bounce pages with __GFP_ZERO to avoid leaking
information to userspace.

Fixes: 8c773d53fb7b ("vduse: Implement an MMU-based software IOTLB")
Cc: stable@vger.kernel.org
Signed-off-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Xie Yongji <xieyongji@bytedance.com>
Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260130050750.4050-1-jasowang@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vdpa/vdpa_user/iova_domain.c | 2 +-
 drivers/vdpa/vdpa_user/vduse_dev.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
index db449c4a9f78dc..82b796332564bc 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.c
+++ b/drivers/vdpa/vdpa_user/iova_domain.c
@@ -124,7 +124,7 @@ static int vduse_domain_map_bounce_page(struct vduse_iova_domain *domain,
 		if (!map->bounce_page) {
 			head_map = &domain->bounce_maps[(iova & PAGE_MASK) >> BOUNCE_MAP_SHIFT];
 			if (!head_map->bounce_page) {
-				tmp_page = alloc_page(GFP_ATOMIC);
+				tmp_page = alloc_page(GFP_ATOMIC | __GFP_ZERO);
 				if (!tmp_page)
 					return -ENOMEM;
 				if (cmpxchg(&head_map->bounce_page, NULL, tmp_page))
diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 59b42e5990e97a..1a96082c82db61 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -796,7 +796,7 @@ static void *vduse_dev_alloc_coherent(struct device *dev, size_t size,
 
 	*dma_addr = DMA_MAPPING_ERROR;
 
-	addr = alloc_pages_exact(size, flag);
+	addr = alloc_pages_exact(size, flag | __GFP_ZERO);
 	if (!addr)
 		return NULL;
 
-- 
2.53.0


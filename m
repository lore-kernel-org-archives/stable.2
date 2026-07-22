Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A6A42124C
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 18:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784743259; cv=none; b=jZZn5j+DUZDx46qFS6E/S8Cmhi42z4eIfDHUfTpYM5fGnZbnFlv/TrpWyVFNM+iB8urhsGDYbUB7xJnWWlnaXz71Y2GAte8o6+XxL7Abe1XaCHnTEs96HfbxCGdQh4wjCYyr9cQwozd4Ydx0hr/okhnLVcG2lNCSTzpEjGO/7VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784743259; c=relaxed/simple;
	bh=zVOWltkIitAhWLCBL00PfpI+7ufeokEF6zqCoJUdCq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I+mvRWTcsVLdN2VP0Wk9td9hm7Ju71Y5R2LwgP11KBI3bbNWm4cFzZ61umnXoK34h98Qca9LXmQUjfTpcpzO1U7KD2bZpBONKQ97jP7CFzJREF/MG2o9R9losM6kXISaU0/p0pJsPowPbsbbiUU8GLj6MgRnkn/D3pc1hskO+AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CRSDZVUc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CRSDZVUc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C80C51F00A3F;
	Wed, 22 Jul 2026 18:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784743257;
	bh=bGJxQDjW8kMIJzMzY1kBppxzAQot3PL4uIZLUOY/cxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CRSDZVUcfRJBKlGMM3mXGzEouDlwIJk+z1sOd4tAKeA41cGs4FTi5PFrAZr1vJM/c
	 YKTFSS1DFZCKNGn+mzmLJOiPNcYXcmZ8kPi4zO8RWpZlwhSOnEPXcQz17BarKSD/d4
	 998ckP3hRWprWIHVQaFsbEt5L+sfApsI4F6fu0TCgMGKi1pJcYtDG9E3OkVIV2G/UN
	 kKQoDkP5lPCxipg5HoYqzY/rH3QU9kD7ZtbqRUAG/EN3vVjfLW71El9MWekzImSQiH
	 n9JsbDnT/rVxtnmvEWnX771w7uN8qyuZjf4/hcGMzvaooRXHF3Q+FXJ23qYhIsFzyB
	 NEeIH0+c7CjVg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jason Wang <jasowang@redhat.com>,
	Xie Yongji <xieyongji@bytedance.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/4] VDUSE: avoid leaking information to userspace
Date: Wed, 22 Jul 2026 14:00:52 -0400
Message-ID: <20260722180052.2184339-4-sashal@kernel.org>
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
index 2b1ee3f1ba6c92..cc8d26b97187ea 100644
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
index f576e50c7ae8da..903e38bf11d435 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -832,7 +832,7 @@ static void *vduse_dev_alloc_coherent(struct device *dev, size_t size,
 
 	*dma_addr = DMA_MAPPING_ERROR;
 
-	addr = alloc_pages_exact(size, flag);
+	addr = alloc_pages_exact(size, flag | __GFP_ZERO);
 	if (!addr)
 		return NULL;
 
-- 
2.53.0


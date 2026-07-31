Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA814582E8
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 16:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785515132; cv=none; b=k4MjCs8u3rrlihkPZMrRfR1enY+a21EzWmh2UqEmZJQFlhxTMRBQ9skTqd5TfuR6EqNX72RuGuPHaZ3skV/8XOmpft0mTPRCKPLatg9Sd5evFbd6mZWN4fuHdfBhj3TuTFfu8rNBG47V3EJy4P458WJq6GzPPfNFomS7mg4r0/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785515132; c=relaxed/simple;
	bh=wUjnU9Ms42XsVj41ogbcHuxYmqTRvUNCulYZZLkX2BU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WXyl2UA2TyMIofXMWcPkRVrOrruNP1uJiS8qs3E2FW/0wz3lnDUgrolnnULDTy8zu/m3GANz2pd+652cWQfPotlRHxLGWvcW6qY6rWTiKK8d23t1x33hcyCsTkIS7mH5prOwUyDj4oIF1KOOiE+X/7v6BXtrtLDi+T6PM29f1PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2mUc4ab; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2mUc4ab"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E77881F00ACA;
	Fri, 31 Jul 2026 16:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785515129;
	bh=I961fat8osVSjIrggGGpvU3ZaLZAs3FhF6CdQk3/Rh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O2mUc4aboEfu2YDL7347Myvtf3wzw11mQiznfPOQCSQ1yGmOVsyGWc6jMg4w3ZsB/
	 7BqXQJFbzAbaamrxyH2YvJBDRkEfcO8ZTsZ29DIqfacjztQWXZJBESJdhiQZqvlamU
	 KUdInMy0G+nklEuC3w89dj9wlNhq4WiMzrqxWda5HpgY3xwT1ag1H+iHtd/8ReeBF7
	 TY9GEYLu4+NjLF6DYs/Dvo4idVEKnU7cxY+z3zCXmrey0zabn4F1Gi5Z4pbs5jReAi
	 +Lkv3451bhTsIROLxgoXQQSQRg8Uowl+i1bHGch0drglYIl/QNit76FjHtqLN/k3Fl
	 0nWqiiVNOdGtw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] drm/amdgpu: Respect placement requirements in amdgpu_gtt_mgr functions
Date: Fri, 31 Jul 2026 12:25:27 -0400
Message-ID: <20260731162527.789626-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072908-composure-fondly-c978@gregkh>
References: <2026072908-composure-fondly-c978@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Timur Kristóf <timur.kristof@gmail.com>

[ Upstream commit 8882f8897e554053af9e72f4c2da8b1e2cce56c7 ]

When testing intersection and compatibility, respect
the actual placement requirements. This is a pre-requisite
for ensuring that UVD CS BOs do not cross 256M segments.

Fixes: ded910f368a5 ("drm/amdgpu: Implement intersect/compatible functions")
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit bc06579ca29dee9c245a41b12e39c7bb6938af5d)
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c | 30 +++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
index 0760e70402ec..52ed0fa000d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
@@ -217,7 +217,20 @@ static bool amdgpu_gtt_mgr_intersects(struct ttm_resource_manager *man,
 				      const struct ttm_place *place,
 				      size_t size)
 {
-	return !place->lpfn || amdgpu_gtt_mgr_has_gart_addr(res);
+	const struct drm_mm_node *const node = &to_ttm_range_mgr_node(res)->mm_nodes[0];
+	const u32 num_pages = PFN_UP(size);
+
+	if (!place->lpfn)
+		return true;
+
+	if (!amdgpu_gtt_mgr_has_gart_addr(res))
+		return false;
+
+	if (place->fpfn >= (node->start + num_pages) ||
+	    (place->lpfn && place->lpfn <= node->start))
+		return false;
+
+	return true;
 }
 
 /**
@@ -235,7 +248,20 @@ static bool amdgpu_gtt_mgr_compatible(struct ttm_resource_manager *man,
 				      const struct ttm_place *place,
 				      size_t size)
 {
-	return !place->lpfn || amdgpu_gtt_mgr_has_gart_addr(res);
+	const struct drm_mm_node *const node = &to_ttm_range_mgr_node(res)->mm_nodes[0];
+	const u32 num_pages = PFN_UP(size);
+
+	if (!place->lpfn)
+		return true;
+
+	if (!amdgpu_gtt_mgr_has_gart_addr(res))
+		return false;
+
+	if (node->start < place->fpfn ||
+	    (place->lpfn && (node->start + num_pages) > place->lpfn))
+		return false;
+
+	return true;
 }
 
 /**
-- 
2.53.0


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F85F44AB78
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 16:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785515944; cv=none; b=fYMrex5ae8Djp/5mJ9D5/sDBPx04+R+pSyTvXrEbSrBNrm4hK7/zcx7mUxr7aliWzky6j/WB/EC1rW00nf21Bg1l2X5zcXdAOHM9gEtePI7chYl54JXYsZpmqoPSJJvuRFoYUMZeioVStgFkoe22RzPS4P0+HDjvtpQ9GXW4wRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785515944; c=relaxed/simple;
	bh=wUjnU9Ms42XsVj41ogbcHuxYmqTRvUNCulYZZLkX2BU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P0Xgud2fVQC97WzvjF5J82KaQCtu1E/GSlwZdKjM/G5Y9xMxQzMFJz4rFNWgMvtRBL+nINBbJwAdab9weeOwazAS9MAu3ElhCF/KKlpnkpWcdL36INFVa2sbnDMWK5n2fhqXGl9Nvh1qjpw739poGq2XJs9LysxDFc5qvFGNJ8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Si6GxXUc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Si6GxXUc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A0B1F00ACF;
	Fri, 31 Jul 2026 16:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785515943;
	bh=I961fat8osVSjIrggGGpvU3ZaLZAs3FhF6CdQk3/Rh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Si6GxXUcsmx+MGzdBHNn63FBtHZRj69QirGFWN8zjTJHyfVd//OAe50PReydNWwXU
	 /DUScww4/dbahPx13R3KnquigwJlL+8rYO81A3KcCKuqZAiPDhDKWGX2tHo9xVsZrm
	 j3HwQLnw1yg3NIQFFpQsCDgi6uMCkXMUXdKKeG9M1LW6cCIWsh07hh+7TQYRUcd8l1
	 VJQnBVRUmijvkK83OC1jtl1lg7Y3mHgU6QqXI+WmjPtciUjc5wQTrrqZKHypsx4lUW
	 E17D2TaKYne2h8/Lp8gsHfntGfprlu5hCcyliJ1SQzMhOTT+6XN+E48YvJKZuAd2Yt
	 WP8NeoK4WhLUA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] drm/amdgpu: Respect placement requirements in amdgpu_gtt_mgr functions
Date: Fri, 31 Jul 2026 12:39:01 -0400
Message-ID: <20260731163901.838294-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072909-haven-garbage-f0e7@gregkh>
References: <2026072909-haven-garbage-f0e7@gregkh>
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


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F4A43802C
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 16:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785517024; cv=none; b=rzYOYCnA7iOeSZ28c/JCW3uthNFH74KHqWMWIQV+SoF2KZg5G3vRAlMduOYLlyxg/vpeEBdWrkNyelTQWEgDFo+Z/OtyJi0hC/jx8kS5uiZO6Ap0fb7fIUQBN/HNYzxwMmBcUVsznrVE6KTv/fWF8BMzJI55ST+9s3YH0c+IZws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785517024; c=relaxed/simple;
	bh=eo/IaNzl0TGUfmGFV0skog6MBCFN9cLg0hsG6JrYCZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rAmxIcXf3zRm7vkpKEcSS09rvgGpwsYtFpRoHWUEjfB9oAyzKpeaJvSImnh79IOE0rZT/BsqC4RpAj9rqaUUUTOV4QRYw27f850INuG7zAdP3EZGaWHr2tdaioJq5Zu+niN2Eqvvgel0W0XIufvNbod3A6qMOClSn5CrWlJaLuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nDGm9pup; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nDGm9pup"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD36C1F00ADB;
	Fri, 31 Jul 2026 16:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785517023;
	bh=9G+9GbYZr+9oEZBVgu5Ja3kLr7aX1tMC8qgQvzH0E5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nDGm9pup+qTvhHF+CZxV7AEcz7vphCOyHTwwT9Ko9b+Lu7oGkVfcQ1hFwnXDBA6+w
	 IW7YzDhfRhXrvZn0GfuIG2Nxs+uvM49rBbsLxgqP90dybOKOCSk7ul9XKszlo3Zv65
	 QHBb2pYsJ8zIsHCoCK7H9Zg8wzyxYrs5YhlTLtVYAEEj8jWjFa+A64IQG6Vomp4khP
	 8XGzt6j4iy5idWEGJ0zxUbETjMTDToke9z9E/OnKlteDYqZgdp0Ibiv1afWlkmory4
	 UN1WpHDDtVYY7O/XIRZzIvqYZQVO8BIlpjxZvNZBu82/KSSNp4neEY5CisaH4p96tc
	 6dA/cMMlp8EwA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] drm/amdgpu: Respect placement requirements in amdgpu_gtt_mgr functions
Date: Fri, 31 Jul 2026 12:57:01 -0400
Message-ID: <20260731165701.883388-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072909-lunar-eaten-0bc0@gregkh>
References: <2026072909-lunar-eaten-0bc0@gregkh>
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
index 44367f03316f..94de300d5dc5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
@@ -219,7 +219,20 @@ static bool amdgpu_gtt_mgr_intersects(struct ttm_resource_manager *man,
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
@@ -237,7 +250,20 @@ static bool amdgpu_gtt_mgr_compatible(struct ttm_resource_manager *man,
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


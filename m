Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AC738B7DD
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 00:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785545144; cv=none; b=nxy/h2LjSP+THPP9cv7tI89oSKadhXh2ee27+1S+cem/PhwbuRbJWMJJasnRRR4ywahqvG0d1ikRjGkrSgTkWTEl0DTFGnei5YEphXCcnp4EwMXCXm0uRgEIqRr4YXn25kxXitodWHj6RhgATQU3QQ7a/VLl3kQ+XSfhvx0PtPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785545144; c=relaxed/simple;
	bh=YmYwErkPspFEZNFaifH6TOPpQclMgWIRNa9nQcSR21w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EFrWAiH92XOh5VvUYH6wCxaGnxGXrqkxB0OoRBWj0b607hpY7R2bMkHh8+sYa7U0Pc/qP/fJT48hEYLAFu59kEe9eeqlTU/oRgS3tXZzVa7vaN/ygRqcZprux7ih+OlKVIumII8YfYFrO6hMht+lpiNeiUZtQ/1I3aJmTVHEKfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jz3T7RhK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jz3T7RhK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E554F1F00AC4;
	Sat,  1 Aug 2026 00:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785545131;
	bh=oAUq8/dVLn2hORm7OVv59goB6H4F7RlOETsg8S1Fc80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Jz3T7RhKr1kY/fdEn2rALrXU1tDJXAp5vgzqRBh8q5jinHp5DSs0YEBqcQXuwuUsf
	 0lYJsepYS3OANSkKWsZW0Vcjd9XzKONoyWKpiLl4TVKaJ/m53Zhqp2i3ipUYJGZ+/8
	 4IiCT/9RVynvjAQvZg4LDVSaJqUgXXSowUTPbZ87U+XAXwEBsQdeZYM2Xeq1EwYmBw
	 hDHtbHNzjaxHXwc2B961LX7KR40XKC+Vt4mrA0GU0mLh7anhvzQAmRKl/Qyy3YlPK2
	 C4syisE4u0c/9YHUaln0WX60+UXBF6nk5p6oTCcTHPsAPn+vuwMgdAtguqNRP4o474
	 oASLDa+PgpJ+g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] drm/amdgpu: Respect placement requirements in amdgpu_gtt_mgr functions
Date: Fri, 31 Jul 2026 20:45:28 -0400
Message-ID: <20260801004528.3663101-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072909-repurpose-enticing-16f2@gregkh>
References: <2026072909-repurpose-enticing-16f2@gregkh>
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
index 1f3302aebeff..6fa8ec8fcade 100644
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


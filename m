Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE3D44C518
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 10:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785322237; cv=none; b=havAjTpdrKRUCdl1gVtNzxNEuky+ej/xiUf30N7srOE8p+G9TTBX1LGjvdzAHAI5vd51jl6ONBiljehrRLxQduDzMXYex229lJ4YgWcUYX5JaW0B6uKqcwQkbLRrbPH3VGkaj9BJrG9TeSFOlFDWVwZPzXDjBvfed9YEieC03II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785322237; c=relaxed/simple;
	bh=16iHtqB9CZhJZPbGRu9GrEzq/tI7meTWiY+SCiUfd60=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=t2asGMiiioh1Y2snmg/BP0v3I5HjBHQEndJwqpqab5e01sXLoPorKwGTExFa/GISdBd9gQ2zadvF1n5MhVX0W8xhnGoH6fjW7cXHOHIKCsBjsth0z+3codoaLTnd4e5ouvedj1eM9A+Do2IEwo21j/FVZtjSpM/7tzRbzcqmBlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=04TIk181; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="04TIk181"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B341F00A3D;
	Wed, 29 Jul 2026 10:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785322236;
	bh=5Yj9r7MKplanlvO2lCoDOuli7yNZHDoos+g6EJxQFas=;
	h=Subject:To:Cc:From:Date;
	b=04TIk181QGouyuo0HBbqW+tb8ixEd7by8Dzq7oLw1W0TpoCxenTtG8q2uK6c/4Jk7
	 yjMXIUIlSh+5LHwPo028rlgn+yNQwtOQoecKHo4H9gU7kRxGQfzdXkpUhwxKv+xn8a
	 0r0r9pqZjqP34TqFOJPPHWccMW20U3QXyphi6QHA=
Subject: FAILED: patch "[PATCH] drm/amdgpu: Respect placement requirements in amdgpu_gtt_mgr" failed to apply to 6.12-stable tree
To: timur.kristof@gmail.com,alexander.deucher@amd.com,christian.koenig@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 12:50:09 +0200
Message-ID: <2026072909-haven-garbage-f0e7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 8882f8897e554053af9e72f4c2da8b1e2cce56c7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072909-haven-garbage-f0e7@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8882f8897e554053af9e72f4c2da8b1e2cce56c7 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Date: Mon, 25 May 2026 13:33:17 +0200
Subject: [PATCH] drm/amdgpu: Respect placement requirements in amdgpu_gtt_mgr
 functions
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
index d23a91d029aa..0ea32561c4bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
@@ -272,7 +272,20 @@ static bool amdgpu_gtt_mgr_intersects(struct ttm_resource_manager *man,
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
@@ -290,7 +303,20 @@ static bool amdgpu_gtt_mgr_compatible(struct ttm_resource_manager *man,
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


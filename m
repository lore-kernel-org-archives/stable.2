Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F96D356773
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 00:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785545128; cv=none; b=YRXE9KrPVVCiq1irkVa+jPDr2HEQDjI9oixLsC1SEXcrHoyezTYJ7biMExy0k7NQx/0S2Ao2fryKnrhcWReVmEXpLqiJrOfW5t7luVTo5QIKScaRgFIxEr8QfgZO6N0NHs3g8qLdyIxkUMLlpm6MrFbAQ7sCn6fLFZc2Wt4/v0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785545128; c=relaxed/simple;
	bh=Q4gWLJ/ASdmAmtrdR067Oby5LYqI87C7w46qGDn6uxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gqAppeMhXf9UwlQ2rgIPgIEH8/LgyJLmS26PZSLCR6epxhhdFGWKhRvl0LRR85tVJIK98Ku21/MuiXy10qU2F7ALXXyOkewayjOpXfpJ9TdCDK0cd8oJ3izSHlMxD3X395t/iGeHqSVIVHgpmGkjxbBAiwhK/MS4UHBcwSCQf8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tl1ut6af; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tl1ut6af"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E4001F00AC4;
	Sat,  1 Aug 2026 00:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785545120;
	bh=PdQtHyrGKu4c0b5sABsZ9+g90/yo4YcTCI4juGZXAas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Tl1ut6afdTsW2L9DKRgh6Q3K+u5Qx1sscj4sSmPh0kyvyysi08g+TluAaoNiSCltP
	 cBrj2fq4+7RhtnJs12mJ18WX9kCJBvOzrHgbBIyFedxkRvKclOhQ3t1iMxHj56jJXU
	 OjHBTFv+xq9QiDa4gTwhUJ2ZOMfSGktm9nRNiliNn+NAjBT+PyFIkdOhda+TYplFUI
	 p057DcbxlTv/M88wvgm1pPVFhEliSUx7Tc9NIqaFgvhbvi9Rj1q59ziMjUgTCpRpCp
	 iSERpqKKM/r64XbG3pQxwgCghXY4SApIkgrtuKWMFNLnfw6b/uqMgg3G9MGYTPKnC6
	 pLA2Vr+ZI08MQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] drm/amdgpu: Fix amdgpu_bo_move() when old_mem and new_mem are both GTT
Date: Fri, 31 Jul 2026 20:45:17 -0400
Message-ID: <20260801004517.3661920-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072905-unbundle-serving-0266@gregkh>
References: <2026072905-unbundle-serving-0266@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Timur Kristóf <timur.kristof@gmail.com>

[ Upstream commit ee94a65f192c05c543b4d3ad7137cd696b5c18fc ]

The UVD code relies on GTT to GTT moves in order to ensure
that its BOs don't cross 256M segments.

Fixes: bfe5e585b44f ("drm/ttm: move last binding into the drivers.")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 21fd45e5e2628d00b478590bcc3d14d3de5d45b6)
Cc: stable@vger.kernel.org
[ dropped the third `new_mem` argument from `amdgpu_bo_move_notify()` and changed `return 0` to `goto out` to match 5.15's 2-arg prototype and shared epilogue ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 7b3293b37144..ef7b7586779a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -472,6 +472,15 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
 
 	if (new_mem->mem_type == TTM_PL_TT ||
 	    new_mem->mem_type == AMDGPU_PL_PREEMPT) {
+		if (old_mem && (old_mem->mem_type == TTM_PL_TT ||
+				old_mem->mem_type == AMDGPU_PL_PREEMPT)) {
+			r = ttm_bo_wait_ctx(bo, ctx);
+			if (r)
+				return r;
+
+			amdgpu_ttm_backend_unbind(bo->bdev, bo->ttm);
+		}
+
 		r = amdgpu_ttm_backend_bind(bo->bdev, bo->ttm, new_mem);
 		if (r)
 			return r;
@@ -506,6 +515,14 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
 		ttm_bo_assign_mem(bo, new_mem);
 		goto out;
 	}
+	if ((old_mem->mem_type == TTM_PL_TT ||
+	     old_mem->mem_type == AMDGPU_PL_PREEMPT) &&
+	    (new_mem->mem_type == TTM_PL_TT ||
+	     new_mem->mem_type == AMDGPU_PL_PREEMPT)) {
+		ttm_resource_free(bo, &bo->resource);
+		ttm_bo_assign_mem(bo, new_mem);
+		goto out;
+	}
 
 	if (old_mem->mem_type == AMDGPU_PL_GDS ||
 	    old_mem->mem_type == AMDGPU_PL_GWS ||
-- 
2.53.0


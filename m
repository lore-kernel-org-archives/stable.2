Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FBF15A85A
	for <stable@vger.kernel.org>; Sat, 15 Aug 2026 02:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786761030; cv=none; b=U12+58Y5QBiNlLjTtsKBr48MYdxf28vXkamvB83wEJ/rae94DWW5iyh9KZuuSjv56VjAfbJIkPY/rBjxIwEOqBMuNzLgBqj7j/+plrsGi4QuTtoGEBQB7YyHiH93rQIW7qAAQPlmTUSLsgpBYXKkqj9vXFwodcVkHvz3YQbSm6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786761030; c=relaxed/simple;
	bh=vKsDbys0qWZp9p5Zit3CixCFSORa82HalQK8arA7JuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HVEryQiDjxgnmoNPEMg+6DlGKivGhtlvwRFyU7bT9yMmAwappBfnTtGLXm7WRxuUVzo6KN0iMbNo5E3uCA5c8R5h/pk1gvZaKe8lt6TXu4DYEDDslaEN2WT6zyorrRgKnR7YGkyyGqzoWRnHd8LBQqaDobIwfAH9yOlTkohOwdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XWiNEHXf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XWiNEHXf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 751B71F000E9;
	Sat, 15 Aug 2026 02:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786761029;
	bh=dA3yRThNbOw56feDIoAk7tW+SvDY2xwB3z8Ip4bfzzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XWiNEHXfyuZdZOhbHZf/k9p3M4v7sBQYCJSOHPMdJ6zz1fp9pM41bvAJTWqoktlAA
	 VXwSsqP3jC94iWafZPUuQ0tdx9TNZeXv+DLYqV/4/l9CUBb2b7A9OZfa/kueWDBXx5
	 HChQvRmS+DnTyIEYbRGekU5Rzs67prPZCB39P02l65+UjppqKgMdnTx3VCy0hA7Jqb
	 UwEvVCg8lnd7PDjNaxNF9gc+GFNcdrWv2KCMZbSjyjVJZgakhKT+MPS6E6+t7Lb6x/
	 EPEyFpkbrhOqllP66OYIhd3L0usiaJwMfL5BCXYqWDRSjWxNQi+7L4UVaO3gmMZFNV
	 bnqijZwEp3djA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] drm/amdgpu: move debug_vm handling to amdgpu_cs_parser_fini
Date: Fri, 14 Aug 2026 22:30:26 -0400
Message-ID: <20260815023026.1435628-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080543-patient-nemeses-dd0b@gregkh>
References: <2026080543-patient-nemeses-dd0b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

[ Upstream commit d8726ef11512754a68c0ab53c57634a569b8feff ]

The commit referenced below restarts the CS if the validation is
still in progress. When debug_vm is enabled, all BOs from the CS
are invalidated so we will hit an infinite loop.

To avoid that, defer BO invalidation to amdgpu_cs_parser_fini.

Fixes: 59720bfd8c6d ("drm/amdgpu: restart the CS if some parts of the VM are still invalidated")
Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 8c990ee9daa295462df24982ce6878db997a380a)
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 30 ++++++++++++++------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index cf0c4315aca5b..dcf7cd290b889 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1153,19 +1153,6 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 		job->vm_pd_addr = amdgpu_gmc_pd_addr(vm->root.bo);
 	}
 
-	if (amdgpu_vm_debug) {
-		/* Invalidate all BOs to test for userspace bugs */
-		amdgpu_bo_list_for_each_entry(e, p->bo_list) {
-			struct amdgpu_bo *bo = ttm_to_amdgpu_bo(e->tv.bo);
-
-			/* ignore duplicates */
-			if (!bo)
-				continue;
-
-			amdgpu_vm_bo_invalidate(adev, bo, false);
-		}
-	}
-
 	return 0;
 }
 
@@ -1325,6 +1312,8 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 /* Cleanup the parser structure */
 static void amdgpu_cs_parser_fini(struct amdgpu_cs_parser *parser)
 {
+	struct amdgpu_device *adev = parser->adev;
+	struct amdgpu_bo_list_entry *e;
 	unsigned i;
 
 	for (i = 0; i < parser->num_post_deps; i++) {
@@ -1337,8 +1326,21 @@ static void amdgpu_cs_parser_fini(struct amdgpu_cs_parser *parser)
 
 	if (parser->ctx)
 		amdgpu_ctx_put(parser->ctx);
-	if (parser->bo_list)
+	if (parser->bo_list) {
+		if (amdgpu_vm_debug) {
+			/* Invalidate all BOs to test for userspace bugs */
+			amdgpu_bo_list_for_each_entry(e, parser->bo_list) {
+				struct amdgpu_bo *bo = ttm_to_amdgpu_bo(e->tv.bo);
+
+				/* ignore duplicates */
+				if (!bo)
+					continue;
+
+				amdgpu_vm_bo_invalidate(adev, bo, false);
+			}
+		}
 		amdgpu_bo_list_put(parser->bo_list);
+	}
 
 	for (i = 0; i < parser->nchunks; i++)
 		kvfree(parser->chunks[i].kdata);
-- 
2.53.0


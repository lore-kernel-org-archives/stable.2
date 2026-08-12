Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF513367285
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 15:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786549485; cv=none; b=q0Pjo6+RMmxigNGrx2LXcnxhqkCxCCGN8suWfVwx1GU9b1eo3p+OvIyamqm11Wj2gQ7F6Z/wSNymJ+IBzxfHApzFvjIgoZVxLP3cISQK/rTSduPlSSgpo/6MNKD+aJlqUth3FxAE8CIvZteZGOrdHilL0MrvLomJ7ksd0AsL3I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786549485; c=relaxed/simple;
	bh=UYM/2Y3YWkRHkfIDbFJxDAvIKjxn/rnKuxJKMAXhCMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YlDyR039HyMlaQsLPzDP1x+v2Dd5s+xPcCR9z6Jgb6UCcRZrbHcipqeoPl+7x7XFSaWwa4zTYpjW60NB3U/BhlSX4N/dlKa1EFlJYpDD4adSqhB7Q3PSNH2D19UoVmMrugUrVG02Fno/M0YtoZD/N/zht8aFHnTOdcHRld51CWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kygyrioB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kygyrioB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1583C1F00ACA;
	Wed, 12 Aug 2026 15:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786549483;
	bh=p92flJH/Gm38FY8kO1NcaSdNK8MkZITkLCUsOGi1gT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kygyrioBS0YljFWtbphAyNod3CN2HvJGYD51caHyC1zGxPI0x2YQWLICTx/XgJErc
	 JQH0cLMCSIiFBVYVMNNhUzwt8K8qbg00PJK3xQHv9wdvEdJ8uPQxJP7DMmK25Zycix
	 WTS4fqsxYevqWn9r3JAwFlCBjL9Qamt9f+jQysk/tNZj6g1Iv7BcADp+XWbzP44Wtt
	 V7YE6mkXbG++Ztc8tUx/rFzoJF1CaTCMoXCH/7VZhuSJzQ79MEJlj21kju7UEYk8tH
	 Y16tlug9lbQojotNk8hldA75XtH44ifn9OF1qRs8ZHu00Zeic4+DiYKtGWedKQthDE
	 3VXIYqIKmxPtw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] drm/amdgpu: move debug_vm handling to amdgpu_cs_parser_fini
Date: Wed, 12 Aug 2026 11:44:39 -0400
Message-ID: <20260812154439.2235925-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812154439.2235925-1-sashal@kernel.org>
References: <2026080542-reload-plentiful-f343@gregkh>
 <20260812154439.2235925-1-sashal@kernel.org>
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
index 8bb5201d88d87..91daa1c4eb0fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1184,19 +1184,6 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 		job->vm_pd_addr = amdgpu_gmc_pd_addr(vm->root.bo);
 	}
 
-	if (adev->debug_vm) {
-		/* Invalidate all BOs to test for userspace bugs */
-		amdgpu_bo_list_for_each_entry(e, p->bo_list) {
-			struct amdgpu_bo *bo = e->bo;
-
-			/* ignore duplicates */
-			if (!bo)
-				continue;
-
-			amdgpu_vm_bo_invalidate(bo, false);
-		}
-	}
-
 	return 0;
 }
 
@@ -1383,6 +1370,8 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 /* Cleanup the parser structure */
 static void amdgpu_cs_parser_fini(struct amdgpu_cs_parser *parser)
 {
+	struct amdgpu_device *adev = parser->adev;
+	struct amdgpu_bo_list_entry *e;
 	unsigned int i;
 
 	amdgpu_sync_free(&parser->sync);
@@ -1398,8 +1387,21 @@ static void amdgpu_cs_parser_fini(struct amdgpu_cs_parser *parser)
 
 	if (parser->ctx)
 		amdgpu_ctx_put(parser->ctx);
-	if (parser->bo_list)
+	if (parser->bo_list) {
+		if (adev->debug_vm) {
+			/* Invalidate all BOs to test for userspace bugs */
+			amdgpu_bo_list_for_each_entry(e, parser->bo_list) {
+				struct amdgpu_bo *bo = e->bo;
+
+				/* ignore duplicates */
+				if (!bo)
+					continue;
+
+				amdgpu_vm_bo_invalidate(bo, false);
+			}
+		}
 		amdgpu_bo_list_put(parser->bo_list);
+	}
 
 	for (i = 0; i < parser->nchunks; i++)
 		kvfree(parser->chunks[i].kdata);
-- 
2.53.0


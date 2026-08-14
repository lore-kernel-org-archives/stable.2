Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346AB49502D
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 18:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786732929; cv=none; b=mba88R+g+//LzugVB3W6kezgZhSapsmhjkCxVYrSVtr0UhlelOXUoxjMGTJQf7TpnCCszfU15vh2fcPDn6e53wfWcAefV6N9TSP5YuGTsa3raEg69rrsSjBCizOIeue2jPVb0NBbMedCWnpEsXa6HLYNq0ofcerlbK8kDD2h5WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786732929; c=relaxed/simple;
	bh=R7hHgGz/RIm70vX1r+F6rfAYqgEe2y0crZBkmMt3R9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FEY6v8QOmqTrfU4Gmlu7zx8o5BSBJtWNTb7abY0Fh4gOdAAfiEaLO2f+e9JHOQJlGMZG/Y6bGpNZOC9SAT1Yz3gKUDZPUpJr/J4McvUfp7A8OwkUEUc1ictUwmXjDLcXHOLMPx0Sy7maEF9mOqA53+19qDFpakK0QiPM1DTZGHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eaBzr4Dl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eaBzr4Dl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7468D1F000E9;
	Fri, 14 Aug 2026 18:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786732928;
	bh=tRi809S/IJzc0scZpcllOsEzIehR5oZ33/H3aQ8sgEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eaBzr4Dler+udBA/S35GGZjW44SxcT6FK3mvwcI2WvPKwieWmdaJKYoNOmm2b/pzM
	 dwMKKFBmCSkV0g0ZIuHcC1dS4OsQOyVC6UJlmJvoRA/9EDJnx7Gw+AEusrw1eG1g2u
	 AlgvZTPHhmoEDs/l6aoBuUl7Xfisfrrtkl28gIrJjoUjfse/hP5b06l9p83Q4wQQP3
	 bIlOo0VnAp9ywGyaK15K1emos8pHjc9jiK+KyA7FEKm8+kaKGQ1cK0FUoPn2VXpAVR
	 PeaUf6oblCynuDTjV77sBwgktxxS5ASfFEPPUTS1vckBnGt+NfzVG47hIKL+jcxpDr
	 CiG/G1TyYXy7Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] drm/amdgpu: move debug_vm handling to amdgpu_cs_parser_fini
Date: Fri, 14 Aug 2026 14:42:05 -0400
Message-ID: <20260814184205.288790-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080543-driveway-delirium-704c@gregkh>
References: <2026080543-driveway-delirium-704c@gregkh>
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
[ adjusted `adev->debug_vm` back to the global `amdgpu_vm_debug` param and restored the `adev` argument to `amdgpu_vm_bo_invalidate()` calls ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 30 ++++++++++++++------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 2d12bb47c574d..15bb286484b36 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1178,19 +1178,6 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 		job->vm_pd_addr = amdgpu_gmc_pd_addr(vm->root.bo);
 	}
 
-	if (amdgpu_vm_debug) {
-		/* Invalidate all BOs to test for userspace bugs */
-		amdgpu_bo_list_for_each_entry(e, p->bo_list) {
-			struct amdgpu_bo *bo = e->bo;
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
 
@@ -1379,6 +1366,8 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 /* Cleanup the parser structure */
 static void amdgpu_cs_parser_fini(struct amdgpu_cs_parser *parser)
 {
+	struct amdgpu_device *adev = parser->adev;
+	struct amdgpu_bo_list_entry *e;
 	unsigned int i;
 
 	amdgpu_sync_free(&parser->sync);
@@ -1394,8 +1383,21 @@ static void amdgpu_cs_parser_fini(struct amdgpu_cs_parser *parser)
 
 	if (parser->ctx)
 		amdgpu_ctx_put(parser->ctx);
-	if (parser->bo_list)
+	if (parser->bo_list) {
+		if (amdgpu_vm_debug) {
+			/* Invalidate all BOs to test for userspace bugs */
+			amdgpu_bo_list_for_each_entry(e, parser->bo_list) {
+				struct amdgpu_bo *bo = e->bo;
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


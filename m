Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8721304BCB
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 14:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785593347; cv=none; b=hAV4j1iub8HGzze0Ti2qtLg+8NDxmoDhHBifzMNeAtod+udro7QzEtmLK/BOZooN8FSzB7oP0TaZHG+0J89Gct/i98geALKWaif7lNpr3Xlwxk5+UpfuPCK6Of9wg16jTp3mzsbJD8HR/gxiZXZB0NhPzz9XE4G+cY7D/ZnggoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785593347; c=relaxed/simple;
	bh=gii+qpGabFJkJp+VBXeREPBPYRV9gTeqRbT2MVMt1Mc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C7CEAH1aktEQl8XKGFbYuXi1EARYGMyc+VUWlaZtfLEAt9dF783bvcXkLMJ6PHkW1LGjEssXNpmX0bnt6EemzB96gTTnlUGHmw20aM5yYbrzz/xT+qI4LwnKdP3Ofa2BFaTsmRgjsCYsSYzfkKFuf8T6+pMh6TM8c+/HsWsaU5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SEjHyXEw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SEjHyXEw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 231D31F00AC4;
	Sat,  1 Aug 2026 14:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785593346;
	bh=b+ozoIerEycFhgdUbNU/cDMdtfVMqjY3PpJTOBbP1Xw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SEjHyXEw/ZnO0huVjqDboC0PWILfcRF9oHUHwCvXbW0DOmWUUgO9gchcGIaG5Cvb3
	 TuLwwwyjbUZXho7ek8rBuBxlJdP3C2v6NMT59lOM3fr3ZEGR16qb25SLMZc2D7m+6u
	 UibWRt8trBHQc3+x3Ky4nMHtSGesry7nTK3s72Af+R7IZDicnEfuxpae2L3wtzLwbi
	 c5toP42CIluFC/sYxoSHH74SrCuGj0qvpMkJ+CiE1FzYXw5sEnCdej+S2cH4Q+29sH
	 u7STGqramJSwum1iOvAvxDtpYU+YSBQIj+54eYjUFHVKE74CM2dZsCKeemNIE580Bs
	 mI1Tb6q+/Rsnw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
	Martin Hodo <martin.hodo@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Subject: [PATCH 6.18.y 5/5] drm/xe/vm: Fix BO prefetch with CONSULT_MEM_ADVISE_PREF_LOC
Date: Sat,  1 Aug 2026 10:03:59 -0400
Message-ID: <20260801140402.3645391-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260801140402.3645391-1-sashal@kernel.org>
References: <2026072936-hummus-emblem-55be@gregkh>
 <20260801140402.3645391-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>

[ Upstream commit 7bc597ce74bab4153b2009c92eccf889e9d74044 ]

When prefetch region is DRM_XE_CONSULT_MEM_ADVISE_PREF_LOC for a BO VMA,
the code used it as an index into region_to_mem_type[], causing an
out-of-bounds access since the value is -1.

Resolve the preferred location for BO VMAs directly: local VRAM on dGFX
(using the BO's tile placement) or system memory on iGPU.

Discovered using AI-assisted static analysis confirmed by Intel Product
Security.

v2:
-Fix null dereference

Reported-by: Martin Hodo <martin.hodo@intel.com>
Fixes: c1bb69a2e8e2 ("drm/xe/svm: Consult madvise preferred location in prefetch")
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: stable@vger.kernel.org
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20260624174943.2808767-2-himal.prasad.ghimiray@intel.com
Signed-off-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
(cherry picked from commit d9a4906ac03be9f6ed3f3b45c56c866b867fd75b)
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Signed-off-by: Review <review@local>
---
 drivers/gpu/drm/xe/xe_vm.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index b49c1b3fa665..54ed21de7b6d 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -3032,11 +3032,26 @@ static int op_lock_and_prep(struct drm_exec *exec, struct xe_vm *vm,
 						    .request_decompress = false,
 						    .check_purged = true,
 					    });
-		if (!err && !xe_vma_has_no_bo(vma))
-			err = xe_bo_migrate(xe_vma_bo(vma),
-					    region_to_mem_type[region],
-					    NULL,
-					    exec);
+		if (!err && !xe_vma_has_no_bo(vma)) {
+			struct xe_bo *bo = xe_vma_bo(vma);
+			u32 mem_type;
+
+			if (region == DRM_XE_CONSULT_MEM_ADVISE_PREF_LOC) {
+				unsigned int i;
+
+				mem_type = XE_PL_TT;
+				for (i = 0; i < bo->placement.num_placement; i++) {
+					if (mem_type_is_vram(bo->placements[i].mem_type)) {
+						mem_type = bo->placements[i].mem_type;
+						break;
+					}
+				}
+			} else {
+				mem_type = region_to_mem_type[region];
+			}
+
+			err = xe_bo_migrate(bo, mem_type, NULL, exec);
+		}
 		break;
 	}
 	default:
-- 
2.53.0


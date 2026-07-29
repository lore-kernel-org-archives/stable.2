Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802444570EE
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 11:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785323514; cv=none; b=uY3a2umkfNrJKcDxLpen1biWUyepp4fok3ET59ntKjZCSP7GVAHhp4nodz7fX393vw/cmxfZZys0XpaPW27B3Dx9wXXCKoiCzoG2LmNd2MgZx6B/iQrhxZbojFVGXUGao6XpD2J5ApGgrp8lKK/SSYxxwEciJWEE+GJhN0ovW/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785323514; c=relaxed/simple;
	bh=olLfcEg5txlH8ozq/w9ep9mgikdk8Fks9aybI6sCPwc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=IjZwKnXDPDbm4NlynppUwGW3fhusKQDj+E8LrGZLQpN0ifECNnD4+HaEGT1wi1mAConeh6q364Uus9U9kWGy6L00jFhraZ921Gx4VzjPo8lmQ42xP1Csj5RSCxBQo6wT8AjJlA24JUvROuN3WGrnV33z/rc5zYBYEJu3974KnJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kyHQbetp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kyHQbetp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AF911F000E9;
	Wed, 29 Jul 2026 11:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785323513;
	bh=1q/ZTCs8ODftGaZAScQQnTGhciuNODWJfvX5yK+U534=;
	h=Subject:To:Cc:From:Date;
	b=kyHQbetpdYejdh96oMKHoWrhmV+9N6lZF1J8pCqgKPi/5zPoMgRpAQ7E1gux1gDAQ
	 TAQyJIxO+WyW8meC1OXklR1Zvr9jAdFtfiFf2uVD1fM2HkKfeRMl9z32MpHqk5eC1O
	 SqVJTcowG0/OdakUYdrpzCmwrtD8FX4U+fdm9twQ=
Subject: FAILED: patch "[PATCH] drm/xe/vm: Fix BO prefetch with CONSULT_MEM_ADVISE_PREF_LOC" failed to apply to 6.18-stable tree
To: himal.prasad.ghimiray@intel.com,martin.hodo@intel.com,matthew.brost@intel.com,thomas.hellstrom@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 13:11:37 +0200
Message-ID: <2026072936-hummus-emblem-55be@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 7bc597ce74bab4153b2009c92eccf889e9d74044
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072936-hummus-emblem-55be@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7bc597ce74bab4153b2009c92eccf889e9d74044 Mon Sep 17 00:00:00 2001
From: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Date: Wed, 24 Jun 2026 23:19:44 +0530
Subject: [PATCH] drm/xe/vm: Fix BO prefetch with CONSULT_MEM_ADVISE_PREF_LOC
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 080c2fff0e95..32ded13491ca 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -3255,11 +3255,26 @@ static int op_lock_and_prep(struct drm_exec *exec, struct xe_vm *vm,
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


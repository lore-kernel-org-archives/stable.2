Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0A6455197
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 12:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785931274; cv=none; b=L3kcwVzwSXJwe5M3zqXcYHR3qdq+boBqbuYSTGwtw6N8jNFyTGuzxCdhQyTcaAeRZm3gj4jzfidTQwN7dIF/sO+RV+B6yzZ1pF7cVjwnKEPhBuE+vOepEup0i+qXJtXcZhKJ9mtLlQga2wHJlfii9UVr3LhYxzgRYQoJgfKQdlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785931274; c=relaxed/simple;
	bh=fU8elO4dwE6Adx54zk6Ub16BUnvr4dTOCjZeBmIEFT4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=EbRZG86uuZgNskONbBYonriun0PNFhLjfiEI2vSKctjOvGKdo3URAF3ZJKgmrxjWTMtm/rLPtoUXFy9o6QxkbuIxwHcNspWwP9n2cM10nSFiIFrI5KnrpOqx5G6eVggrrfK0tv5qH5mDepSSxpNnKae4r7x8rkm7hX4o13iKhO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pzC2JKdq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pzC2JKdq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B88E51F000E9;
	Wed,  5 Aug 2026 12:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785931273;
	bh=iT9OgFJR9sKqyYlWQVFdrAr9wlT4uqGVSx7U0ri/anQ=;
	h=Subject:To:Cc:From:Date;
	b=pzC2JKdqZacv2JwY8YEY2SktGTsrAr9G4MDUeYRKke5I3d96vTGE72raKOIXM7vVd
	 627Y4GXoKWWO0GHB/t3lRSObHhZ2WoDZL3UWPntorJ+lgymDGA9zdIHck0jgs+MnMO
	 ZU8jr2F/qq07m6HZmsOmGMWmOtmDF+lQmpGAyATY=
Subject: FAILED: patch "[PATCH] drm/amdgpu: move debug_vm handling to amdgpu_cs_parser_fini" failed to apply to 6.1-stable tree
To: pierre-eric.pelloux-prayer@amd.com,alexander.deucher@amd.com,christian.koenig@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 13:58:43 +0200
Message-ID: <2026080543-patient-nemeses-dd0b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x d8726ef11512754a68c0ab53c57634a569b8feff
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080543-patient-nemeses-dd0b@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d8726ef11512754a68c0ab53c57634a569b8feff Mon Sep 17 00:00:00 2001
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Date: Mon, 22 Jun 2026 10:11:22 +0200
Subject: [PATCH] drm/amdgpu: move debug_vm handling to amdgpu_cs_parser_fini
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index e714cee2997a..5445f75741b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1177,19 +1177,6 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
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
 
@@ -1378,6 +1365,8 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 /* Cleanup the parser structure */
 static void amdgpu_cs_parser_fini(struct amdgpu_cs_parser *parser)
 {
+	struct amdgpu_device *adev = parser->adev;
+	struct amdgpu_bo_list_entry *e;
 	unsigned int i;
 
 	amdgpu_sync_free(&parser->sync);
@@ -1393,8 +1382,21 @@ static void amdgpu_cs_parser_fini(struct amdgpu_cs_parser *parser)
 
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


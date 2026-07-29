Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB21B470EAD
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 10:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785322413; cv=none; b=egBnjzhhTq1LJj2nD/nxPTmgloRFRdrDNzDge5+8tF1m97RU5Na4X0JYpEimsumgsCFd1Dz7jSxqURF3IbDvjX7zPh9R0KGisjMh8rTNe1DnGish9WXsAP9Q9wnUZXBADkR2SynIS+bqfAQ/LNKpEPNTc/osrt+sdyqM/oYgWXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785322413; c=relaxed/simple;
	bh=GxPnomLBar9onXQPjcPYrF7KtXw2hScaWPbFNpybc1k=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=myAQcSIDgM8p5jgJ1b2TtuAF/HnCqJOp1DJmkm1/c2JyTbDosoN1MD/KSh9f31Q4aKAKNfUG6jXFBAd8TH6HRXAkwFbfWuhfnQD5GfQTwQKlUXIfd/0+JOAZyY2GHKowi26w0zErmG8MoD6MIzJW00uxalwS1RBoL1n9szGMRaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gMh/woDx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gMh/woDx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C64FE1F000E9;
	Wed, 29 Jul 2026 10:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785322398;
	bh=XCCTMUntYrTy94mKRmbGTfsicFZiyg3orqrWHehkYk8=;
	h=Subject:To:Cc:From:Date;
	b=gMh/woDxa1amL7Qf687m1Krv7Vt3C+8quUpIL2QGTvZNzksII7bOZC38LtFuHiG2Z
	 zaQaMzUqXMEvZcpBxmRumhAGmWI82+SPULiCW05KdAyn7lrbIqeAPXiDpEKO8OOL+k
	 UX3Im/baKmwpezsjQ8781OlsQFo/pUiknRUo6qq0=
Subject: FAILED: patch "[PATCH] drm/amdgpu: Fix amdgpu_bo_move() when old_mem and new_mem are" failed to apply to 5.15-stable tree
To: timur.kristof@gmail.com,alexander.deucher@amd.com,christian.koenig@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 12:53:05 +0200
Message-ID: <2026072905-unbundle-serving-0266@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x ee94a65f192c05c543b4d3ad7137cd696b5c18fc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072905-unbundle-serving-0266@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ee94a65f192c05c543b4d3ad7137cd696b5c18fc Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Date: Mon, 25 May 2026 13:33:18 +0200
Subject: [PATCH] drm/amdgpu: Fix amdgpu_bo_move() when old_mem and new_mem are
 both GTT
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The UVD code relies on GTT to GTT moves in order to ensure
that its BOs don't cross 256M segments.

Fixes: bfe5e585b44f ("drm/ttm: move last binding into the drivers.")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 21fd45e5e2628d00b478590bcc3d14d3de5d45b6)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 2740de94e93c..16c060badaee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -515,6 +515,15 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
 
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
@@ -549,6 +558,15 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
 		ttm_bo_assign_mem(bo, new_mem);
 		return 0;
 	}
+	if ((old_mem->mem_type == TTM_PL_TT ||
+	     old_mem->mem_type == AMDGPU_PL_PREEMPT) &&
+	    (new_mem->mem_type == TTM_PL_TT ||
+	     new_mem->mem_type == AMDGPU_PL_PREEMPT)) {
+		amdgpu_bo_move_notify(bo, evict, new_mem);
+		ttm_resource_free(bo, &bo->resource);
+		ttm_bo_assign_mem(bo, new_mem);
+		return 0;
+	}
 
 	if (old_mem->mem_type == AMDGPU_PL_GDS ||
 	    old_mem->mem_type == AMDGPU_PL_GWS ||


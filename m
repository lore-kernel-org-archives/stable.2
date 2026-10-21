Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792594290;
	b=Lh64QwVk/4EYipq8W9POWkPMmKLXHdRB9dE2jmCcOs4w/bidWCJ/TuIUOze7QrRoe8vo
	 ksNYusISOOkNfjtJSrLKGMLDEpAD04LLOWyYYEZEOJq71LmLi2sIX+VfAfwP7qTBb8Bi7
	 5Mn3CvZ5lhR60B4pHkDqoJbUaUgpk4k830MrV/1WHPY4RJFnTkBPwYNKLlkLENkIJyeJE
	 aWS9IzF2xluAnsdhWubSYP/AkOEVZ7uDbh2+E5XtX9yydkc5GskEuEHMCLCO3HxWnbIaV
	 OtEPYS4zumS0VQib7BZGJq3okkx+Np04v22uLJrdlQWD6QTwEU2HVLrWX8LRWDo8KKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792594290;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=5Rlpp/DiW/fB+FTnDVCSFI114HJnrEwjYbC1/9evv+k=;
	b=hPplYhifXAo0tRD1UXUrmOjYmquz9tiSAzKKZ0mkXLSXa/p6cTON4pcjFg0TBUeqrrpB
	 dHccRm2BeG9fFXrioT7cj/aGYLCGnMjHSey3F0n5GSq/7tEX2BB9NnsuZZVpNfJdJKyqo
	 Yk4loOSG7Dnb8nBRpscteo8YL7zk9TLsvF2Q7QNQBv/SunDz14lf17D/2fewc6lODTi4l
	 HznqBCq5s8j960KpQRmPZ7gcYg7p9LDZImuuzQA6V+icOBcBCCRMxQz7YJDAEHhjyALfl
	 98G15SA+kY8YAg7bGyYd7bm1jpMwGNRj/+nHTuZl2F9kUXfmWLE/7Ks1EmZMbAadagQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=RwvAMJLP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C504606A319
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 14:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=RwvAMJLP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A762F1F000C1;
	Wed, 21 Oct 2026 14:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792594290;
	bh=5Rlpp/DiW/fB+FTnDVCSFI114HJnrEwjYbC1/9evv+k=;
	h=Subject:To:Cc:From:Date;
	b=RwvAMJLPHBlWTzaK7Np4hEKU/taRfEaTBzScGRN82vwFrdzsa198oowXnSKoybiQ+
	 pE0ItidMERG1V+sDrezAlqqspi7CKHoHFynTDfEatZhUNKQH3DCRiZFD/b6jT20SF6
	 fw7NFZbyt0HmPUv7FiWBJLX131tl4wpJyKDLhXa0=
Subject: FAILED: patch "[PATCH] drm/amdgpu/userq: actually validate userq BOs" failed to apply to 7.2-stable tree
To: benjamin.cheng@amd.com,alexander.deucher@amd.com,christian.koenig@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 Oct 2026 16:45:37 +0200
Message-ID: <2026102137-thermos-preaching-3697@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.2-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.2.y
git checkout FETCH_HEAD
git cherry-pick -x 32d0771ef4ca69c30a1db3aefa34dd177cd2a047
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102137-thermos-preaching-3697@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 32d0771ef4ca69c30a1db3aefa34dd177cd2a047 Mon Sep 17 00:00:00 2001
From: Benjamin Cheng <benjamin.cheng@amd.com>
Date: Fri, 9 Oct 2026 09:31:42 -0400
Subject: [PATCH] drm/amdgpu/userq: actually validate userq BOs
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This was supposed to loop over the individual evicted list, as the
kernel and always_valid evicted lists were already handled in
amdgpu_vm_validate.

Without this, BOs that were created and evicted before a userq was made
would never end up in an eviction fence rearm.

Also add the missing ref to the BO before drm_exec locks and refs it.

Fixes: 4cdbba5a16aa ("drm/amdgpu: restructure VM state machine v4")
Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 18decfc9e8cc0fa70b6de9944cc27a37729edfbd)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 9316423f9340..b3dc5dd49a64 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -980,19 +980,21 @@ amdgpu_userq_bo_validate(struct amdgpu_device *adev, struct drm_exec *exec,
 {
 	struct ttm_operation_ctx ctx = { false, false };
 	struct amdgpu_bo_va *bo_va;
-	struct amdgpu_bo *bo;
+	struct amdgpu_bo *bo, *tmp;
 	int ret;
 
 	spin_lock(&vm->individual_lock);
-	while (!list_empty(&vm->always_valid.evicted)) {
-		bo_va = list_first_entry(&vm->always_valid.evicted,
+	while (!list_empty(&vm->individual.evicted)) {
+		bo_va = list_first_entry(&vm->individual.evicted,
 					 struct amdgpu_bo_va,
 					 base.vm_status);
+		bo = bo_va->base.bo;
+		tmp = amdgpu_bo_ref(bo);
 		spin_unlock(&vm->individual_lock);
 
-		bo = bo_va->base.bo;
 		ret = drm_exec_prepare_obj(exec, &bo->tbo.base,
 					   TTM_NUM_MOVE_FENCES + 1);
+		amdgpu_bo_unref(&tmp);
 		if (unlikely(ret))
 			return ret;
 


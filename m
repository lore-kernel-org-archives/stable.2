Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E68435518
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 11:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787225969; cv=none; b=Ad9zHzjm6dUcnw9TyQOEiVkiMt66rIvkOyjLnMqlh6LnmAwsRXZ68eexD7poU3UY9YilE3wNV94pj5BtVHyS1qRF5uEjxJ4zZTYJ88SG0CctVSV0Rfy4tyMXG6Rg9dOVPe4cad2kt+tWctXim9ELtX9Ixd+XxPz1gWVFvMJTP/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787225969; c=relaxed/simple;
	bh=wdj0nG3QwinKKpOKqB8PpF3DN/C5sA1NWa/cPx5X5ZM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rQW5dLOG7XtfZUAH4CkTaHRt6uRft2aSPKOWzq7MB6pMNVJQfA2klw5lCpR6CQs7AnxTDWz8JsClVrRfXw21QJwLqHAOgkTNvPhJxVKKsxlfEdM6LeQ9YEEU1z8TNOrFA5kYAlZpEV3BIYq/quxYw0iK0X4qFty/P/TkPUzZ87Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZtD+gNVt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZtD+gNVt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2055F1F00A3A;
	Thu, 20 Aug 2026 11:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787225968;
	bh=MhsX8nbtfZws7w+vQpjEOKTVRfEbTNbpcEutLbbbjDI=;
	h=Subject:To:Cc:From:Date;
	b=ZtD+gNVtzQdVYmxjMID9UMWPw5xN/9f/0ei2ea1ZIUKNrzSud8Kr+YKgt3Dkene4Z
	 l+LDRdhNmHBr65F5qza8ZvB+zyodoavpR28JrAGJDK/xBzT2A/xLzjKo99WzC5eIfB
	 k+WnOQzWxeuE7N2at+o8ABGh4jncHvt/nOskWN7k=
Subject: FAILED: patch "[PATCH] drm/amdgpu: disallow multiple FENCE chunks in one submit" failed to apply to 6.1-stable tree
To: moonafterrain@outlook.com,alexander.deucher@amd.com,christian.koenig@amd.com,danisjiang@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Aug 2026 13:28:49 +0200
Message-ID: <2026082049-refocus-deviator-76f3@gregkh>
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
git cherry-pick -x 931cd1d1baeae68e8eb2c23bc1f3d8934dca6241
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082049-refocus-deviator-76f3@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 931cd1d1baeae68e8eb2c23bc1f3d8934dca6241 Mon Sep 17 00:00:00 2001
From: Junrui Luo <moonafterrain@outlook.com>
Date: Thu, 6 Aug 2026 12:45:24 +0800
Subject: [PATCH] drm/amdgpu: disallow multiple FENCE chunks in one submit
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

amdgpu_cs_pass1() dispatches on chunk_id once per chunk without
rejecting repeated ids. p->uf_bo is a single-slot field, so a
submission carrying two AMDGPU_CHUNK_ID_FENCE chunks runs
amdgpu_cs_p1_user_fence() twice, and the second run overwrites
p->uf_bo with a freshly referenced BO without dropping the reference
taken by the first.

amdgpu_cs_parser_fini() only unrefs the final p->uf_bo, so every FENCE
chunk but the last leaks a BO reference. The leaked BO outlives handle
close and process exit.

Reject duplicate FENCE chunks the same way commit fec5f8e8c6bc
("drm/amdgpu: disallow multiple BO_HANDLES chunks in one submit") did
for p->bo_list.

Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 665b1fc2a1845206408f9a2c6da67101789edb82)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index f8bf0f6b5097..6798f6decc37 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -248,6 +248,10 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
 			if (size < sizeof(struct drm_amdgpu_cs_chunk_fence))
 				goto free_partial_kdata;
 
+			/* Only a single user fence is allowed to simplify handling. */
+			if (p->uf_bo)
+				goto free_partial_kdata;
+
 			ret = amdgpu_cs_p1_user_fence(p, p->chunks[i].kdata,
 						      &uf_offset);
 			if (ret)


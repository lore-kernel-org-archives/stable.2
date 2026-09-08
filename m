Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E250952E04D
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 18:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788891754; cv=none; b=WfsOpJjrScKnABoWUGgf+BNE5dtSZTUHjO1RrERFP4mOKExW5O16t/hRNfanrjPoW8w0QFdn740L8oDPCiPjggvyhe23BWH+doDp6MTksoIC53jByI/kuOGJYySwgHCBLjB80Ebvclpbsr96rl5TBokQbx8zUvbiF3aJVREuYtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788891754; c=relaxed/simple;
	bh=dmqj1TdZnwlAhVWf47yoySCJaj8U5IS5aVK1lMn8/xI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sr82tCUiQpdLUZ+TylGdqTnGhzLfds4qOVtET7uILEHB8vB8RB04QXJnXBroYSeKxBSi48VMOFib6oDowHAWASybtjqBmWcOOkG8GmgNtTrVSzSlq0zWnPh5PeBucv2mq5P9SEisWQcrgpFvKR23LWVHhM73auoAzbcURd0ZY5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+IuBXYp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+IuBXYp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DCBC1F00A3A;
	Tue,  8 Sep 2026 18:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788891752;
	bh=6jeEarjRPWfuBGxIahT3B7LSuRIt8VdIMBxlRvax/jk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K+IuBXYphUjOKg8eX3oBFe+iXkP1NmzgwUBjWREE8RMV2JNdy8dRP5s0dV0P29Ann
	 6RAFXR2SRDMvORjsQGzgqlIrxa8L7WqDn2EhaxaCUebIv5t2XlSkKrmYr5zUurqOis
	 PVZQVojmEy+1Gn5HnuudwL3qorgHPhRC/b98ofzXfy8sON+4C/e5f8k5TSbAyMPidF
	 3QWWPDgLTkdaoYLk6snzOSICP8OW3kBVCA2STWUSRy2AuAhYLHlCv0B05by6vMPSqx
	 djjCY5FxZiSMDp7DGpuJhCCu33T42UrAviQRzVtuKNaq7BCuw4xDVAlI+tEwDAe04w
	 kZkGSE+OntryQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dave Airlie <airlied@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] nouveau/gem: reserve the bo in the info ioctl around the vma lookup
Date: Tue,  8 Sep 2026 14:22:30 -0400
Message-ID: <20260908182230.203917-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090306-creamlike-diagram-e3f0@gregkh>
References: <2026090306-creamlike-diagram-e3f0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Airlie <airlied@redhat.com>

[ Upstream commit 5e17160d41d92823f3379c1982e1369680c5ce4d ]

In the non-uvmm path, there could be a race between the info lookup
finding the vma, and the gem close path closing the vma leading
to a use-after-free.

Spotted with the help of Opus 4.6.

Signed-off-by: Dave Airlie <airlied@redhat.com>
Fixes: e758a3111914 ("drm/nouveau: fixup gem_info ioctl to return client-specific bo virtual")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260612020658.3176270-1-airlied@gmail.com
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
[ adapted VMM and UVMM handling to the legacy direct VMM selection and condition. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/nouveau_gem.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_gem.c b/drivers/gpu/drm/nouveau/nouveau_gem.c
index 93c1afff5e90e..2b4488adff343 100644
--- a/drivers/gpu/drm/nouveau/nouveau_gem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
@@ -227,11 +227,20 @@ nouveau_gem_info(struct drm_file *file_priv, struct drm_gem_object *gem,
 		rep->domain = NOUVEAU_GEM_DOMAIN_VRAM;
 	rep->offset = nvbo->offset;
 	if (vmm->vmm.object.oclass >= NVIF_CLASS_VMM_NV50) {
+		int ret;
+
+		ret = ttm_bo_reserve(&nvbo->bo, false, false, NULL);
+		if (ret)
+			return ret;
+
 		vma = nouveau_vma_find(nvbo, vmm);
-		if (!vma)
+		if (!vma) {
+			ttm_bo_unreserve(&nvbo->bo);
 			return -EINVAL;
+		}
 
 		rep->offset = vma->addr;
+		ttm_bo_unreserve(&nvbo->bo);
 	}
 
 	rep->size = nvbo->bo.mem.num_pages << PAGE_SHIFT;
-- 
2.53.0


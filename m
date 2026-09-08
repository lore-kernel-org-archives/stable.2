Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F13A59D61E
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 18:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788891345; cv=none; b=nNyvgwAWHvxVlkCbBLX5LnxfIgKXeL73GV8UYui4qn9V+tpQkNReXVdh7cwARBM1b11i5ZSrZCYCwtJ2fMaRrDLaSsBLLnMZ5tL/aiO7w+jkhyCS0/5Aph9hmMkYhJ+S5I5lYL0RmPuO4gbMgWQuPTCsyzfAPAOQgXhEV6gNNx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788891345; c=relaxed/simple;
	bh=s91zouzGDvJ0RpgvkJvz4cuWQWIsedBbn3drvoYQywg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZfqygBMWYByjkAp2+aIY8iyuaBzk+F2c0XmwATLr8Gug8bYazJ2SHttwatQDFI3gyCH0PYEGV88mRqopxTzKqaK96Us3+cksOW/M/jqZtTQEEKmQSQ+c+wYPglHPPwL7CK3Jp0Bxmli4v+Yf9i1h35w3TyGpmO0kVwUHr1Qklz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nurFPXIZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nurFPXIZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 536CA1F00A3E;
	Tue,  8 Sep 2026 18:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788891343;
	bh=tnYzfv83kZSAdYHwMmkdd/OEEd7u9ROplAbey8KzM48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nurFPXIZtfoX0SSZ5aQ3OwcAo9pZXg1MpO8VIUn8unWFLoLwwZA/nqSgdKORDmcRb
	 Wli0VPYPHVo5KcQzpX8tCD599VEN9FkQZu8ur0LosSwSnf48nek2tpXuSjwzsaLp5u
	 iQDqP9Y7cRvVuskQwq6dSLRlRViMLFM3QgarPLbq7J6ukPg+xRgBtyT5YDBUZxGz60
	 FfQS6FU+3jyamtUfYF9eGT9VPjLgFJ2cHEc+SIKKxT6c+4Qi9A9XIk1fq0lwoDmaJn
	 vY18XWUdBp0RySGa38Su+bVreQEzzhbcqFYTcOQsPCWf5ucNr0V6TgTet0ibO5XRet
	 unRnYIkeWXJ+w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dave Airlie <airlied@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] nouveau/gem: reserve the bo in the info ioctl around the vma lookup
Date: Tue,  8 Sep 2026 14:15:41 -0400
Message-ID: <20260908181541.191998-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090305-skeleton-brush-8637@gregkh>
References: <2026090305-skeleton-brush-8637@gregkh>
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
index 7de846a919232..71eb6b42ccff7 100644
--- a/drivers/gpu/drm/nouveau/nouveau_gem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
@@ -277,11 +277,20 @@ nouveau_gem_info(struct drm_file *file_priv, struct drm_gem_object *gem,
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
 
 	rep->size = nvbo->bo.base.size;
-- 
2.53.0


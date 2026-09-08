Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D1E56B877
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 18:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788890685; cv=none; b=nSMlRY7ZjESC7Nu+nGd5oSiItc3WDNYlHBw3m8xrAwmbUDWiKJSDav8J6rm94QD+WYD5SFosl5r2i8bSHXG6Hk/LBJnYaiKcFhqKKIQNZLCPpsoqt+2RyZFsmZdbAKd+GuF2J6whGz1PvF2qxKdPzXqFoVKnTAS22U3PH+SY3Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788890685; c=relaxed/simple;
	bh=/C8ChBl64B2ldTCyc0AWu4BFB6H1eTsk/JmSO8IvqtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zk3JIi/wUhQxji35x3AhFNz7JdraTzSv70gZkVIQUtb7yD3B8nMw3fVsBOjiZh/MqJTkIN++a43KkGuWolSvHHTOxWYgudi/L/ajSNp7tERkbsVERaFcIoBeCjyISsJHB8/LD5w5UQckyQXrbqLZJEeep5VR0mmDs3vr9xk4Zxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PsIikZuS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PsIikZuS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5D101F00A3A;
	Tue,  8 Sep 2026 18:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788890683;
	bh=9KV4J50SQUFGkKto8sMdjHEvCH5cYkXTiKZwJrePZpg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PsIikZuSPcrmVh5hCf54qg4WVrvv8R/5G44YGNpTcNiVnoy9U6KgbuQQeykESUFr+
	 mzSZWlJTaPQna54y3y9sCz9byLlI7zxDF97ixTZBs4Mzlg8S7Ahu/KFz/p/SOe3GJu
	 xdVacF6zYuDyzRAiON3XB6whA/F+9UPVtS4QwOJ/dpGZogyoMGw9iOdRvn/E/oXZRK
	 01cVlPrUCJuInHRHbfodlePVs1UChtSaRs0aIEsceABPfYqf25MzH0ohfqZ/EL36AZ
	 PykmUBtGlZfLNLmXko+mufPmkgb3dN2wTt8kISQOGSUuf+VVn7Ao7fBikwxg8YwMea
	 OiSyXMk+gFkcQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dave Airlie <airlied@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] nouveau/gem: reserve the bo in the info ioctl around the vma lookup
Date: Tue,  8 Sep 2026 14:04:41 -0400
Message-ID: <20260908180441.175024-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090305-award-junior-d158@gregkh>
References: <2026090305-award-junior-d158@gregkh>
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
index 0ec96d9372cd7..571633c07e03e 100644
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


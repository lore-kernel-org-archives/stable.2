Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287113438B0
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 11:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780401439; cv=none; b=WeTPBIIBPyTFB2Y+YST3QtP2ORfOYrkX3yflL1X2JnRGC2QIFb0wwfNuwwBgdwysgnG60/ErHu08133XVojdC7btyrNaabU4P9nfbPFavfd80n77HxsRk5Tzamvn88uM/CNe44sfEiqhQs8qZonBaI2UAop/ai1ZL8a6mQ9pgbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780401439; c=relaxed/simple;
	bh=RRma3Zd6UFVlvFhfVDjOAZoDItATMSqZ9aSBrB0Hd+I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nhv4i0ME4J3hLBNomloowK0/FstBv6edeZdontMubffkW9B+6fGgMVCM8DK0fKcvYh9WhK29R4e2zeQu1NCIkO2sHdEsMeQKJ+w6ze0OcdqTNGD+3TNtEz62mW5uPI2UNF84S1M7aQpBOLCBr4al3AWl6jNn730YCgZIhpvwB8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=HI5eQC8U; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="HI5eQC8U"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+TdZ6wgntN0ET3unbfiP01cv5Eyt2WdGwjMV+mmhb2I=; b=HI5eQC8UhEvPRlfwGix5bZDZUx
	FrDc/DARZhzX+gWg1ggGPAdpf1LvmI0YJF0yjBiWkFClscHxTL8UGyNCRxhgx84adblnCTfWAxGS7
	hrxJ6UjvYT8xN+vOOmmIDGdOfyEQP7/JCocZkvbzdNm+SzKJEyagR1K4uyPWdjzL7AY2CTWPG2peE
	Jce5lFUMmcK3ROYADDZTsRJJmkiaEsmq78toPPlA6BzyQwTyn8lrcRZOFeqXleRTZtcAtCK6x8EC6
	v2kTvwc9miNL01g4bWDx+UNdu2u2Er/C9XcUprFBBfRKDL43ZYkTq78Tc3lgzIYjFNEcuOemt8aRE
	VMK0sMrA==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wUNkB-00BgWO-TG; Tue, 02 Jun 2026 13:57:16 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Tue, 02 Jun 2026 08:57:06 -0300
Subject: [PATCH v3 1/2] drm/v3d: Fix vaddr leak when indirect CSD has
 zeroed workgroups
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260602-v3d-fix-indirect-csd-v3-1-cc79e06e543c@igalia.com>
References: <20260602-v3d-fix-indirect-csd-v3-0-cc79e06e543c@igalia.com>
In-Reply-To: <20260602-v3d-fix-indirect-csd-v3-0-cc79e06e543c@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral Quiroga <itoral@igalia.com>, 
 Jose Maria Casanova Crespo <jmcasanova@igalia.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 stable@vger.kernel.org, =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1568; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=RRma3Zd6UFVlvFhfVDjOAZoDItATMSqZ9aSBrB0Hd+I=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqHsUW8Ntm/Z5+0E90bDqs5eaRckfcVW/38XTSF
 G7xR650tn6JATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCah7FFgAKCRA/8w6Kdoj6
 qhLqCADSS0qJ23/bIpEhoZ0IBjmiO9wMlWM+I3jWXu4aWxRpZXkSHQHWDPfxJB2ZlIUtF1L54Af
 zCCCPG+KzvoijVXslnpR71Oc8XmLx1dFW1w5gm2nF6R/sFhbaNMgdi3eOMOY/v2OVtzr53dIZc1
 Gq4Om8F22WKo+8JCjZng5mRNFDHkFrtENz23R7eW7RDvjaqfK7z8T5gF74X/gOs7XLjqoGqWndY
 AGeySfxacrzQIADg5xwK2FxoympsFvkJOJVQrS9J53ovACOuk4V6wJzbX0Con/UMM/TfILx0Ky3
 ghywFj6yWrAw69hR6hcdOGK4R99U8oa9aQiyif7FwaDxg9bs
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA

v3d_rewrite_csd_job_wg_counts_from_indirect() maps both the indirect
buffer and the workgroup buffer and is expected to release them before
returning. When any of the workgroup counts read from the buffer is zero,
the function bailed out early and skipped the cleanup, leaking the vaddr
mappings of both BOs.

Jump to the cleanup path instead of returning directly, so the mappings
are always dropped.

Cc: stable@vger.kernel.org
Fixes: 18b8413b25b7 ("drm/v3d: Create a CPU job extension for a indirect CSD job")
Suggested-by: Jose Maria Casanova Crespo <jmcasanova@igalia.com>
Signed-off-by: Maíra Canal <mcanal@igalia.com>
Reviewed-by: Iago Toral Quiroga <itoral@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_sched.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
index 94bf628dc91c..47f83936cd73 100644
--- a/drivers/gpu/drm/v3d/v3d_sched.c
+++ b/drivers/gpu/drm/v3d/v3d_sched.c
@@ -403,7 +403,7 @@ v3d_rewrite_csd_job_wg_counts_from_indirect(struct v3d_cpu_job *job)
 	wg_counts = (uint32_t *)(bo->vaddr + indirect_csd->offset);
 
 	if (wg_counts[0] == 0 || wg_counts[1] == 0 || wg_counts[2] == 0)
-		return;
+		goto unmap_bo;
 
 	args->cfg[0] = wg_counts[0] << V3D_CSD_CFG012_WG_COUNT_SHIFT;
 	args->cfg[1] = wg_counts[1] << V3D_CSD_CFG012_WG_COUNT_SHIFT;
@@ -428,6 +428,7 @@ v3d_rewrite_csd_job_wg_counts_from_indirect(struct v3d_cpu_job *job)
 		}
 	}
 
+unmap_bo:
 	v3d_put_bo_vaddr(indirect);
 	v3d_put_bo_vaddr(bo);
 }

-- 
2.54.0


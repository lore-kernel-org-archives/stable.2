Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5853ED3A6
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 12:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781787298; cv=none; b=uA5UkGJF7hxGFcAQgN3aXCGZnPW4P8j7152gXZ+qqzy9sO8CrkMvwlL9J5Brap0iQfwZiEuSzkNb5azF3Mz/cu6PhlyHqQ+RH9oQfNgDZs1gCGC15EbfQLpG0pnEc1YstJg2tavO1Go/1alcWp3dYTuTD6NMx+aWeU4z+DsOSLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781787298; c=relaxed/simple;
	bh=L5VWPd2CEy4kKL9ReM6/uL7vjyCnA0xqd9ypm5wNkHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eqM3HXY//opquBaQuiL6sMK2xhcol4lZZWM2cKUH67KMw1CkGeRxoqvuyPGbXh4U/3VQcItGTvda9atAlFBqXCTcJqG6jchtDxpYqqjnG9/B6qLWSV/PsT6RMRm86KCKKA5vNi2bWoogAV3MGmDIc2a8KSDFcuOJ9JBspaTk4aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AjjFUF8w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AjjFUF8w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4756E1F00A3A;
	Thu, 18 Jun 2026 12:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781787297;
	bh=flBgdtvXvRHpTvheYBcZqbHhVDR5K/r+l512Q9ZCpbY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AjjFUF8wkRt0XqqdQ5ud99NIHv09YBcfDxyQRGYBGKAEyP2laNeRWlLo/wpU1OKdG
	 wTrBf6ZvA/tE7Kfh3/Rxw4d6hM6VZ3TTUeH822sdVnZe9jEt0L6g5kNM7pMTJVKEJK
	 p96VFcsX+jEh6c0F7tO5zjArZ2jYT8A1eS5l78OxWsGLeuiNYQEQ3vbInwpF4amn72
	 KD4iaWz2pIw5wL9OIr2Av60RyzvNhPGUWw7LwL3Q7lGWVb/1T6Rhwrp6KAAPyIAyN7
	 P4/2wVMldsBIyqPfHCaUFaZLPB+NROH63EM+E8YHm8nhc4Hlx84bO5Zs0eg6JOliMF
	 hgASYozlLpIeQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Jose Maria Casanova Crespo <jmcasanova@igalia.com>,
	Iago Toral Quiroga <itoral@igalia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] drm/v3d: Fix vaddr leak when indirect CSD has zeroed workgroups
Date: Thu, 18 Jun 2026 08:54:53 -0400
Message-ID: <20260618125454.649776-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618125454.649776-1-sashal@kernel.org>
References: <2026061521-hardship-pebbly-50b5@gregkh>
 <20260618125454.649776-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Maíra Canal <mcanal@igalia.com>

[ Upstream commit ae7676952790f421c40918e2586a2c9f12a682b6 ]

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
Reviewed-by: Iago Toral Quiroga <itoral@igalia.com>
Link: https://patch.msgid.link/20260602-v3d-fix-indirect-csd-v4-1-654309e32bc0@igalia.com
Signed-off-by: Maíra Canal <mcanal@igalia.com>
Stable-dep-of: 7f93fad5ea0a ("drm/v3d: Skip CSD when it has zeroed workgroups")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/v3d/v3d_sched.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
index 8c08592346d4df..f2a2c17a58c687 100644
--- a/drivers/gpu/drm/v3d/v3d_sched.c
+++ b/drivers/gpu/drm/v3d/v3d_sched.c
@@ -419,7 +419,7 @@ v3d_rewrite_csd_job_wg_counts_from_indirect(struct v3d_cpu_job *job)
 	wg_counts = (uint32_t *)(bo->vaddr + indirect_csd->offset);
 
 	if (wg_counts[0] == 0 || wg_counts[1] == 0 || wg_counts[2] == 0)
-		return;
+		goto unmap_bo;
 
 	args->cfg[0] = wg_counts[0] << V3D_CSD_CFG012_WG_COUNT_SHIFT;
 	args->cfg[1] = wg_counts[1] << V3D_CSD_CFG012_WG_COUNT_SHIFT;
@@ -444,6 +444,7 @@ v3d_rewrite_csd_job_wg_counts_from_indirect(struct v3d_cpu_job *job)
 		}
 	}
 
+unmap_bo:
 	v3d_put_bo_vaddr(indirect);
 	v3d_put_bo_vaddr(bo);
 }
-- 
2.53.0


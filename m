Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38A55A79B
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 16:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781800521; cv=none; b=sBxAd0625GiRpsLtOb6k1owc2B93w3O28RH0egYX0bqy2ADbxLn9IzltNSAe2sbk6TnD9WxYflqmGqSoz4u4lnYxz6m3rjnpgfjr7RJ26x8YVTYeY6NPu/UH0MC4aXuTwekNeIPzdBw9Tct1UM0ep7zJJQj9YfzyxcZYKGU5rXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781800521; c=relaxed/simple;
	bh=2TlJXCaEiRcUk+u1ZzQIxPgdgVY4LQdLwbG/toNMjNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BI1bIo9IAiHHtTWqcWxb4qOOkBboa+nTXS5fa4m/ZYir+1k+KegEU/3uqfQI7CZ5M1d5OKMF+bFvbROHy1ctkZjOM73pYTE0cwNAxSSZTEYqxybNQVNX1TkU5c3urJI/MIk4LLs3Qdohi4OG8SdNV2aP1ASm1aKyNG3BXUMxlKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jajNVMJc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jajNVMJc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 367F91F00A3D;
	Thu, 18 Jun 2026 16:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781800520;
	bh=bC3uPaO6XsVz98SAcM3di/sv7Y1z1oLWHpMShB5KZs8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jajNVMJcKNDBVVTuRXa6YE46dwLfyykikD16orWauIBGGXRJZt7BINZm7pSub10tC
	 Haw+moPbS5LspKc9dsRwzqh48whT3/TIUnTljWML/QBedjAUrsKzkMXbagXvZjoWlj
	 5nFnb+GvDptHILmAXFZld9rUD30pvuFtkm878Lo3qwtl8r+ninHt8uHK5MkfL890D0
	 e8AENydaNkgk9X/L6VEuUnPlrfY/k9Ss6/C19b+yHB5rG2qX4/EEAU3fWkv9L3DfBv
	 jnLdWGlq5azuskpxIZZHCrJuSZbvxn9EGyoKE+LOQ7j2eg/aEAkW8oJYbbAhxdchAz
	 n4i2DjHsF/Wug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Jose Maria Casanova Crespo <jmcasanova@igalia.com>,
	Iago Toral Quiroga <itoral@igalia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] drm/v3d: Skip CSD when it has zeroed workgroups
Date: Thu, 18 Jun 2026 12:35:18 -0400
Message-ID: <20260618163518.797445-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618163518.797445-1-sashal@kernel.org>
References: <2026061528-cytoplast-unretired-0932@gregkh>
 <20260618163518.797445-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Maíra Canal <mcanal@igalia.com>

[ Upstream commit 7f93fad5ea0affc9e1505dd0f7596c0fdb496213 ]

A compute shader dispatch encodes its workgroup counts in the CFG0..CFG2
registers. Kicking off a dispatch with a zero count in any of the three
dimensions is invalid. First, the hardware will process 0 as 65536,
while the user-space driver exposes a maximum of 65535. Over that, a
submission with a zeroed workgroup dimension should be a no-op.

These zeroed counts can reach the dispatch path through an indirect CSD
job, whose workgroup counts are only known once the indirect buffer is
read and may legitimately be zero, but such scenario should only result in
a no-op.

Overwrite the indirect CSD job workgroup counts with the indirect BO
ones, even if they are zeroed, and don't submit the job to the hardware
when any of the workgroup counts is zero, so the job completes immediately
instead of running the shader.

Cc: stable@vger.kernel.org
Fixes: d223f98f0209 ("drm/v3d: Add support for compute shader dispatch.")
Suggested-by: Jose Maria Casanova Crespo <jmcasanova@igalia.com>
Reviewed-by: Iago Toral Quiroga <itoral@igalia.com>
Link: https://patch.msgid.link/20260602-v3d-fix-indirect-csd-v4-2-654309e32bc0@igalia.com
Signed-off-by: Maíra Canal <mcanal@igalia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/v3d/v3d_sched.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
index db98855741ee85..46c52d89cb2498 100644
--- a/drivers/gpu/drm/v3d/v3d_sched.c
+++ b/drivers/gpu/drm/v3d/v3d_sched.c
@@ -257,6 +257,16 @@ v3d_csd_job_run(struct drm_sched_job *sched_job)
 		return NULL;
 	}
 
+	/* The HW interprets a workgroup size of 0 as 65536; however, the
+	 * user-space driver exposes a maximum of 65535. Therefore, a 0 in
+	 * any dimension means that we have no workgroups and the compute
+	 * shader should not be dispatched.
+	 */
+	if (!V3D_GET_FIELD(job->args.cfg[0], V3D_CSD_QUEUED_CFG0_NUM_WGS_X) ||
+	    !V3D_GET_FIELD(job->args.cfg[1], V3D_CSD_QUEUED_CFG1_NUM_WGS_Y) ||
+	    !V3D_GET_FIELD(job->args.cfg[2], V3D_CSD_QUEUED_CFG2_NUM_WGS_Z))
+		return NULL;
+
 	v3d->queue[V3D_CSD].active_job = &job->base;
 
 	v3d_invalidate_caches(v3d);
-- 
2.53.0


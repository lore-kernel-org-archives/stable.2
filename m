Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB683D6693
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 11:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780401442; cv=none; b=tQg6zgV3tCER6J5YURwXewDSrcY/H3nTKv1f/ApKGnMkqHxho4r08EWyPFAQCRSahlNuaFBmDxEJ2Yafbfl2CtsDlXJOR5oR50LAm2+H+cEH5JpJtLAeq1oEMa8ydO+RK+3ymyR1GqL8ihZ03siSmLne5Skwkmh7QcoAkweNBmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780401442; c=relaxed/simple;
	bh=oIRUIiATHaA7OBWTtqU5jr0gWD5mrfZCUmPXhL1hM5g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f3Aphm7a0jIoWiIMpv7GHn3yq1gM/JmHw5VIxHYDgxpypj0kkpDKCpzAwfjWt/v5RI1DidTUTX7P1IHHFywGvn9zHHIXbHinC2o7eL8Mi/Z2Elo/YtxvPKI+Y8qh1RwWoBoio3b0FjYzbwvsDo591aOaQvkq1n8hiGmYllEY+xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=sZxZ9hr7; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="sZxZ9hr7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0ESu+IDe1ri5W5f0FAoHlm8Ie77sofeWqWVPCjcQPYs=; b=sZxZ9hr7OKK0R1FJRwMuVJAtBs
	noYklG004iU1bKGUSf7gNzNHMlLyIzWrfstmO3682Oaze69HwJIiyLkUHtu9OqvWfG1I0qzXUp+b6
	HlYNLr0J0CvXDcnzvfz74ZNpFXys8+7+Pi9KKrhJ6AH9dYioK3ZfTNotk+V4IUp+2Mse4dEsmQKbp
	f/6ZOnxBtowvt2bhKmiL4FCl/GyPMklF5N5EJwYkNieeLlhliON6eiPqe0+P+YAqunDfGgx+5yaBR
	y9PpajgbDI5bMwnRCaOTQ1qtI26Beyjg0T7oOr7uQNl7zIx7bBsJ455y04amUGSDebh+Ubt9fkOS3
	7BoQZGVA==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wUNkE-00BgWO-S8; Tue, 02 Jun 2026 13:57:19 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Tue, 02 Jun 2026 08:57:07 -0300
Subject: [PATCH v3 2/2] drm/v3d: Skip CSD when it has zeroed workgroups
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260602-v3d-fix-indirect-csd-v3-2-cc79e06e543c@igalia.com>
References: <20260602-v3d-fix-indirect-csd-v3-0-cc79e06e543c@igalia.com>
In-Reply-To: <20260602-v3d-fix-indirect-csd-v3-0-cc79e06e543c@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral Quiroga <itoral@igalia.com>, 
 Jose Maria Casanova Crespo <jmcasanova@igalia.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 stable@vger.kernel.org, =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1982; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=oIRUIiATHaA7OBWTtqU5jr0gWD5mrfZCUmPXhL1hM5g=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqHsUWc76e9cGbqNRcOqnE3F32Rhyg0NEhLZmAG
 3GML4EAzmiJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCah7FFgAKCRA/8w6Kdoj6
 qsHdB/9AfH/JoA35ie+UhL+Zi+hpPBi7p7LoEvAB9MuQiJPqkSpyMVN3M3vffcjwoxoGIqSSTU7
 jHSFVHsg1DdGtUseixJ3iV4TqJnjf9cE8jWPJZ9+ubzsKyhvgrj+GUu5uJyUKhRVtRHefSFkAaD
 z9oko2SQxD8fnEhNi480fSAF47YUkDE0bfBrmdLVhdP4wEOIVvbw2Tz3Akd8cMsTO1sXl5OV6Vh
 iMFCp/M1L0v2XPzaBsiZtnI8t9rOK+JjGujOSKDcqpybO33kU1BQ5sBOJxy4YvUIUpFKt6dOz2X
 INWapZs9/n4s762mWVZeeon1CW56aaasVKoibHxJ3RehlhrQ
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA

A compute shader dispatch encodes its workgroup counts in the CFG0..CFG2
registers. Kicking off a dispatch with a zero count in any of the three
dimensions is invalid. First, the hardware will process 0 as 65536,
while the user-space driver exposes a maximum of 65535. Over that, a
submission with a zeroed workgroup dimension should be a no-op.

These zeroed counts can reach the dispatch path through an indirect CSD
job, whose workgroup counts are only known once the indirect buffer is
read and may legitimately be zero, but such scenario should only result in
a no-op.

Don't submit the job to the hardware when any of the workgroup counts is
zero, so the job completes immediately instead of running the shader.

Cc: stable@vger.kernel.org
Fixes: d223f98f0209 ("drm/v3d: Add support for compute shader dispatch.")
Suggested-by: Jose Maria Casanova Crespo <jmcasanova@igalia.com>
Signed-off-by: Maíra Canal <mcanal@igalia.com>
Reviewed-by: Iago Toral Quiroga <itoral@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_sched.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
index 47f83936cd73..6678d62e5bd0 100644
--- a/drivers/gpu/drm/v3d/v3d_sched.c
+++ b/drivers/gpu/drm/v3d/v3d_sched.c
@@ -352,6 +352,16 @@ v3d_csd_job_run(struct drm_sched_job *sched_job)
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
2.54.0


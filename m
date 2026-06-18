Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9882D46CE
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 13:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781791178; cv=none; b=AI2N38KlnU4ytrFYtwz6NhMTqhrE34hA7CHFQ1hrVXEVcSfOk/CmTMbAUpEhxi5dfYRCkT9ujsquSlKB8mKkWeeLTNsiUDJvDGrg41ubgmC/09JD1l1q2p5ygAUCi5xYqlv5JsmPP4KtoDW5WgIS6m24OoaBkDiHBCzy+0zvBVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781791178; c=relaxed/simple;
	bh=YsFwusylVgdZ6mGRJBkWDcQ53q+dHtBrEYL2+YbCKSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rJRudpDT4VYIuYjlnEebrmel+Db3CuUVK0QGdl+684MT3KPmtmr2znljX1vWKmWYHyDtX2weso0bhYgbOIw9RW7DsMiC4AnrmXGpxLGt726b9KxWXxqU+iH60h419TTRCflKkhJeQwX3yOrlV7gdo8mn8IsyL2hnX9NJSPO0fFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JDP2XKSB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JDP2XKSB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AF621F00A3A;
	Thu, 18 Jun 2026 13:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781791177;
	bh=/VFp2OieWk2Vqn3UsT0G/I4Pcdjv1X3DIaJHlOf9d4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JDP2XKSBuEs/15qUfVykRhAuv+RejUSk2aBIbCvzCfyv012EiNesrxl/N5hcr48+/
	 lnodyeGfabOwdUM76EsUUpHRdgqyVUtaz8uWU4/G1hDXiMKoIwtBxe+rrwUNrYI6RZ
	 9iWBTM0lsdP3TfjZ7hu5vx4+amc1ghbJLPBSkaOHrgnvDETcwyODx3UVP6tVYRDOUf
	 Loz09JDXla9mq0HGz4Yglxh8Zv9i67aepygg3U1I3dH9gXlJwdughjbKDR0M7ERXMj
	 S4EpKgw/7AYuheA2aGvhVbXKajk7P2uIMpDu70NW3/Aorb0s7Xm30geZ2wYoXh3BEl
	 g1p1rwHJxQv3A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Jose Maria Casanova Crespo <jmcasanova@igalia.com>,
	Iago Toral Quiroga <itoral@igalia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] drm/v3d: Skip CSD when it has zeroed workgroups
Date: Thu, 18 Jun 2026 09:59:33 -0400
Message-ID: <20260618135933.729574-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618135933.729574-1-sashal@kernel.org>
References: <2026061524-unless-wolverine-f5ef@gregkh>
 <20260618135933.729574-1-sashal@kernel.org>
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
index ff91cdb75bb912..ab872bc818004a 100644
--- a/drivers/gpu/drm/v3d/v3d_sched.c
+++ b/drivers/gpu/drm/v3d/v3d_sched.c
@@ -234,6 +234,16 @@ v3d_csd_job_run(struct drm_sched_job *sched_job)
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


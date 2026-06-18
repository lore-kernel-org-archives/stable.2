Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6BE3F44EA
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 14:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781792029; cv=none; b=U7b8Amly90BZ8ExAORp0gdR0cZW36aurnM4pgJZUL1LT5CYhNYEFo3mKRsFuBLCoxWhQ5PGyny6R4OTMI6W5IR1mpk3+vZ4zIsBlhrethIDpc2UfZ7O6qDvxrYCQRaI8c8T+b03V4MLwdd/HSilUg2NdAAno/4FYpkseNHterGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781792029; c=relaxed/simple;
	bh=YsFwusylVgdZ6mGRJBkWDcQ53q+dHtBrEYL2+YbCKSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S8XrSlUmE+Bxw8yZUzqb/zLzuliiitZQ3r9Gtx2ZU1VeAwS5v9fuRbW//zN78t432uCBLNrogt6sTTprA8j6zHfH0v1+9yEyBWuhBFV7jykmVrEX4dmCPBuaj9dGA8lGS3CW/ojFSUXxycO197Dkf/vWZGWSFRV7Eoia2TRkJnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xa052Kla; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xa052Kla"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 997D31F00A3A;
	Thu, 18 Jun 2026 14:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781792028;
	bh=/VFp2OieWk2Vqn3UsT0G/I4Pcdjv1X3DIaJHlOf9d4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Xa052KlakA68AxCvBnnihaEjwAYffl+x2mYXvKmaA99Ar345de/r+yLhFZZeycIxj
	 5Sr/JFeaDxgbZnjwq5yfMZ+w/H9NZj+6FRhEjC9MopaewiuwJ31v23S9GQu9Bk+Ntl
	 eDPsD0/PZ500ZaTeSGdVHPPIqwZnhddFPeyt4V+20g4fM/M2xLXJUEI35XaBNzmZlB
	 +EzaOGx0sMkcaIP78I7DsVoZwk7t0EOAnOolQzqWfE8GD4+NMT95MEw/xDi6KEHhlB
	 rI5L0IVY8uzLHt9j+q0sHp3J1IQuZE8utIVf8WQG1B5eO+CsmramucUeBg6C1k0Bxd
	 nVRy0ympk2Ejw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Jose Maria Casanova Crespo <jmcasanova@igalia.com>,
	Iago Toral Quiroga <itoral@igalia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] drm/v3d: Skip CSD when it has zeroed workgroups
Date: Thu, 18 Jun 2026 10:13:45 -0400
Message-ID: <20260618141345.734343-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618141345.734343-1-sashal@kernel.org>
References: <2026061526-coil-arbitrary-316e@gregkh>
 <20260618141345.734343-1-sashal@kernel.org>
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


Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE872F7EE8
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 17:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780422632; cv=none; b=hC4KqT+7KzAKm3rDFoL48AVXPvaMd4c/XvyKZ+AanGcrJnicTk4OVCzno1fJhqMqRStHA/s9ucI9lnvVP1lJ6mKuwlvSvXREy0+cEDg0k/u+tCUo0TXrT2rXzKQ9cJvMMmhjl9e0TXiqyt91Y1of6w36PhCRc1Fn1CKxz34fyWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780422632; c=relaxed/simple;
	bh=xQIyPYzk7AhfhDW8LIY6RV9Ivx5TSb0cwjNDzuQZlXk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kgSsQ92QK0cy9SxqCr+nAmWXCCstLF+ROsdyf3ZWX/WBnJGLyQ0nwCTM+SPCdewRgqB3eAT8upumLiO70/m7Vm21aUFTcGDc67uH4TN+ZCpgCkXOT3Fuy8+ddXclrmuy0HsZa96uia3zdshsGyqad7GOKdgOBdL2+S0Dvq2rk0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=gxqjDP+j; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="gxqjDP+j"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=38aNw7/GPIGCen0/DzocqXHLCJmKysDZFWfPsK/cHhg=; b=gxqjDP+jBHUCFep08L3AlLXoYn
	1ntkPFUOavyai5coSx9m/LrS9/KNNrHvxpHJWpuRJMIpY651EmaY3a30PnwGAHqkuEsusPRrNSwEu
	IICriqvBGk/6Ru8OQDkjnTVHqP+u9erfTJ4VH7xcowOzHPag8KnGhIaM3HjhV1KSKldniYOSoPLk2
	AbKKAdKbHQy1TgVKQYZd/2STHgXa0krceU0OnM3whHbbSC+d7hUmT5HLyIfFmC7IKOY2L+eCFObXN
	mn4u+p+/pMGqc6TuUanq7Be3Jai/dT1yI1IGzriTdyhwpnJyk9sCxDzyfwsMrmm0T6Jz4zMQSHnfF
	NuvACnrA==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wUTG0-00BpDx-P4; Tue, 02 Jun 2026 19:50:29 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Tue, 02 Jun 2026 14:50:15 -0300
Subject: [PATCH v4 2/2] drm/v3d: Skip CSD when it has zeroed workgroups
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260602-v3d-fix-indirect-csd-v4-2-654309e32bc0@igalia.com>
References: <20260602-v3d-fix-indirect-csd-v4-0-654309e32bc0@igalia.com>
In-Reply-To: <20260602-v3d-fix-indirect-csd-v4-0-654309e32bc0@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral Quiroga <itoral@igalia.com>, 
 Jose Maria Casanova Crespo <jmcasanova@igalia.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 stable@vger.kernel.org, =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2714; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=xQIyPYzk7AhfhDW8LIY6RV9Ivx5TSb0cwjNDzuQZlXk=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqHxfbBdhVglTRW+HnmadM3G5QkEJJN8ek6EStO
 UjSAL8+uPaJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCah8X2wAKCRA/8w6Kdoj6
 quvACADMmptxvmgTHcCiu3UwJY5YgAbfxaZlYU4u/Hl/FTdbderDL0tmLOmflk9HQXnUzlVMUNE
 ZD/vD3H17ZIRkBR5gE4XL23vnO379ZvCtgEKjoIyzhY2vUhfSye2nuQ4m6mwjriPAdhduXp+0YE
 ryBk9rjBgArBQ1KTg0BAF1VDuH0KiuwVVoXPNTZYBi2rRtHAogDKBZBo7XUeP45LI5iU6AxAHzY
 aFcHd2eRMhh09csngfMMleZEx8pgZtFmCqLj1irq//sD7e5xqo7Q4YdA6se+PxCqg4gacd9uUIl
 ULLzjiJUb9E5/aUU4TLQzY2BUPWWgE049xMbbulM4MZL/mV4
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

Overwrite the indirect CSD job workgroup counts with the indirect BO
ones, even if they are zeroed, and don't submit the job to the hardware
when any of the workgroup counts is zero, so the job completes immediately
instead of running the shader.

Cc: stable@vger.kernel.org
Fixes: d223f98f0209 ("drm/v3d: Add support for compute shader dispatch.")
Suggested-by: Jose Maria Casanova Crespo <jmcasanova@igalia.com>
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_sched.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
index 47f83936cd73..8a635a9ec046 100644
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
@@ -402,13 +412,13 @@ v3d_rewrite_csd_job_wg_counts_from_indirect(struct v3d_cpu_job *job)
 
 	wg_counts = (uint32_t *)(bo->vaddr + indirect_csd->offset);
 
-	if (wg_counts[0] == 0 || wg_counts[1] == 0 || wg_counts[2] == 0)
-		goto unmap_bo;
-
 	args->cfg[0] = wg_counts[0] << V3D_CSD_CFG012_WG_COUNT_SHIFT;
 	args->cfg[1] = wg_counts[1] << V3D_CSD_CFG012_WG_COUNT_SHIFT;
 	args->cfg[2] = wg_counts[2] << V3D_CSD_CFG012_WG_COUNT_SHIFT;
 
+	if (wg_counts[0] == 0 || wg_counts[1] == 0 || wg_counts[2] == 0)
+		goto unmap_bo;
+
 	num_batches = DIV_ROUND_UP(indirect_csd->wg_size, 16) *
 		      (wg_counts[0] * wg_counts[1] * wg_counts[2]);
 

-- 
2.54.0


Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94077367F48
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 19:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780341246; cv=none; b=rGe4sHa9jTjvPUZD/rUl8GYowY0TzzQ/KpAui5KK1Y6OFUL1ov/d6Jg1ejgjyhGAcujUwN0pd+qtiV/87sAyVZX68YcHcXxjL6YEviXeXLIJ2xHf+LTgskuuVLiAto+47PXekJJd/g/4ZZwkC9sIvIokqG5eHDNWa+TCgm8TJlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780341246; c=relaxed/simple;
	bh=I0neitdtlwH4Ke6ALJ6tRKA0tHZdqrGuHBZ7keeGMMc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZjqpBM/k+Nh32LOtcDaSA4uwVLhJVV/RRJJ64qVqY77brhT2wCPU6FMwkXWRdFLbbkk4YjFMhrqYhd4NYk0kwB/XrKPwjCByKnzPOXTx25I8vrJa7EV2enI2OsATjEvfNZGVaoJOzhdpElHI1swZ7D86HEX5uaSoU+auUGeh3Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=X0XYFDmG; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="X0XYFDmG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JnVlHc4j7DkjOb6gJA+UgaK2xhenxZu7GfzPkQWaWuU=; b=X0XYFDmGLUu4HoQcHqI9XVwHOZ
	RvK47V4JX8DojHn7JKfx4PhX4xGv+4KnX7Gq48jtkZCMFqG1md/bFlCGRhCxsRam+8snvMDZ6dvV0
	vmuNUF05mvxXCh5PdzWDZl39k4vzYq26/cxh7FXxRrFnVvgfEtyvCFwBhwF2MOrjqWvYPZi2riskX
	yM0Sjeh0An2Wid+hPx8MkV1wdWgm0EI+6OBYp2IxsKPF8/HvgAg7L8AMD0uL/YbN2aurXfG8u6gJM
	crSdx6iOJWT+ZN5KPiPLLmcUvaGVUEzUqnlD9EWqhGDdeOOunI+ooVk6AGDpQecVq+gHt4kJTfZ1E
	ImEiBDJQ==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wU85I-00BGx8-9V; Mon, 01 Jun 2026 21:14:00 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Mon, 01 Jun 2026 16:13:48 -0300
Subject: [PATCH v2 2/2] drm/v3d: Skip CSD when it has zeroed workgroups
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260601-v3d-fix-indirect-csd-v2-2-aaebf035b936@igalia.com>
References: <20260601-v3d-fix-indirect-csd-v2-0-aaebf035b936@igalia.com>
In-Reply-To: <20260601-v3d-fix-indirect-csd-v2-0-aaebf035b936@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral Quiroga <itoral@igalia.com>, 
 Jose Maria Casanova Crespo <jmcasanova@igalia.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 stable@vger.kernel.org, =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1866; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=I0neitdtlwH4Ke6ALJ6tRKA0tHZdqrGuHBZ7keeGMMc=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqHdnv9mECBq819beRlxj8JeH1mtXVA0v5g3Yxy
 cLoQRX5th6JATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCah3Z7wAKCRA/8w6Kdoj6
 quaHCACcgolyKengCnaF2ANdhov8RxhSK4a2W3OeWJ/tm6IT216ly9vD1kD/EjSeO2I/1ahdse7
 9WkOxi9CunrqrXiBPm96BntgvuLe3Kdu/DSKPP2ygp+DmfmBfvZUWYeloXcZ3trTodXxXUlLpDr
 XCrfS607XjpXup/BBXiTkit7DRqXhU9/LaC3Xh8jAiP1Qok8YY6iWOsDD2hKDZ2hMWfEojXZczy
 AI6wHuRv4d9kG6OhuFtUJbhuCWl9eoU+esWbCVMj+pjplZNPsv2yFIXB9t/uwco7FRpKTgJxsKt
 ogSDZshMoRpQqcvZS4ai5t9UrcdmyFZriZMFW09TjBQOP6nT
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA

A compute shader dispatch encodes its workgroup counts in the CFG0..CFG2
registers. Kicking off a dispatch with a zero count in any of the three
dimensions is invalid. First, the hardware will process 0 as 65536,
causing an illegitimate submission. But over that, a submission with a
zeroed workgroup dimension should be a no-op.

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
---
 drivers/gpu/drm/v3d/v3d_sched.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
index 47f83936cd73..681d10af4c8e 100644
--- a/drivers/gpu/drm/v3d/v3d_sched.c
+++ b/drivers/gpu/drm/v3d/v3d_sched.c
@@ -352,6 +352,15 @@ v3d_csd_job_run(struct drm_sched_job *sched_job)
 		return NULL;
 	}
 
+	/* For dispatch dimensions, HW interprets 0 as 65536, causing
+	 * illegitimate submissions that must be rejected. Note that
+	 * 65535 (2^16 - 1) is the maximum number of workgroups per dimension.
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


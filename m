Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625AE25B0A5
	for <stable@vger.kernel.org>; Sat, 30 May 2026 19:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780170694; cv=none; b=mvPbPCtpk960tnqcxRFExA5SyaqySV8g+is16V2rWpy58XjeJhKW0eyUX2W61BfrwMceHmANa2142woKwEaBZOIHFdP7UKgT19EBmN9tkqui6nL4EMXqFuR1jBm8tG6X3LIh7EwHvOO5Xy1RkwIGODzz35mQq9nput5X5F7fRQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780170694; c=relaxed/simple;
	bh=TmUeISSPkoxu6GHUhx+L0cQBj3qSN0V+RYbBp7OmGnY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cXslXS5Wer55APYvZ2/W/1etvHrwmHHlUUVGIhRu8lxIIg+mqSa1obsIY5lX3gLrZVEJDXg28noem9Xq58VOoG9mHSNaUZvplgIExpj55xPEeFRwP/mTW4IZw+1sD00Wyllb2oaQL9qGW1nWPzpn0hqir7z8cPIsJwdC0YRcA3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=pjkRkroN; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="pjkRkroN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UoHHquSvhwUEjuOaTqZ+K+Tlgrx/liQg23aXecIpwrM=; b=pjkRkroN75b2mXkpyEDm8mxojJ
	BfWrFyeSIG5g/iYbKrsuk4TerQYZFQWEy+uds4/6M2UuOthJ5rkHZi6z/GUuK/arHjxRyVWwW3fUp
	xdhea67+SZJAWZ9nr/c+Ecx44oq1/NwrS3TAmZIUWz87JwDgYsX3hPn9kEZ3jgls6O2IzLPj5msj2
	ZrjZBmHiiF50Nv7u/DA8v6Yh6q4Q7VOXEPuSVpUK0KxQVGqBkTv8use6+myn3SjX2aUhkf3B1VeI6
	tYB/IRwYF0FUaX2TlMb62q5CA5HbpfNzdmSWnFk/Vt5OXjI1m/AaoeOyIcVyhAWu9CHBaDbLUqbj8
	D+pYVu3g==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wTPiS-00AMOG-U9; Sat, 30 May 2026 21:51:29 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Sat, 30 May 2026 16:51:18 -0300
Subject: [PATCH 1/2] drm/v3d: Fix vaddr leak when indirect CSD has zeroed
 workgroups
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260530-v3d-fix-indirect-csd-v1-1-15533948663f@igalia.com>
References: <20260530-v3d-fix-indirect-csd-v1-0-15533948663f@igalia.com>
In-Reply-To: <20260530-v3d-fix-indirect-csd-v1-0-15533948663f@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral Quiroga <itoral@igalia.com>, 
 Jose Maria Casanova Crespo <jmcasanova@igalia.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 stable@vger.kernel.org, =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1515; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=TmUeISSPkoxu6GHUhx+L0cQBj3qSN0V+RYbBp7OmGnY=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqGz+7u7W9D66VTBFxB7mdqc+hSdORzY/EZo9Pe
 0debWQ6cv+JATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCahs/uwAKCRA/8w6Kdoj6
 qh7fCACy78BbYOWbdx8h7Ndw1w3xomWTyyy6L3xpq3zjtbFEq6I9K1VUYEZ+ObM0mgEBSFJyWjc
 nSXAsYl6NsHK7ySH03Xht9xfKxrwp2OiqLXOmsEPiN8R3LE+2UkexrKdL714jJV7xiuloKl1VCr
 Sog9DJPpEwTC2s7m49ZaIZMIXG5bOUF9jpB3FX4kSqDxuOwgbaXDafpL3hGGpC1LdCnNRk3Zz/v
 e5FxBlJv3pBE7z2d9XOuXpc0UNKavH4qxnAQRr9JlZ07FRqJBzGqiwm74JIN641EHfhuZiy6ahU
 WtSbsKiKKwUPmDMXnZfpIxeVgLP6VLyd+v1zQD7JgRE/GwD3
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


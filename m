Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFDE367F48
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 19:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780341243; cv=none; b=kMfZNCgFQ0pS3UqR6dtwxWueKBgAhrHsxhJ/tpafQNAUDnk1eRge7D7dpVMMUKoN1aN9vwk6NqxLONeaSOBGQHZw3yzIJ40jA8bJbwtUrhnwQgpfYYw+UWU7cb5T+6gzDZnA3IAkLeX+5rk1tqMx/jfiCWWSFPYRSFW3wo55j8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780341243; c=relaxed/simple;
	bh=TmUeISSPkoxu6GHUhx+L0cQBj3qSN0V+RYbBp7OmGnY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wns83V+HlqQZ/380OAglApbQS170hgT7yg4TUoT9zZOU49LvwCUtn0O6L3uOKVjT3YGRopUjOdAGrHocT3XC87D4Ir73mwxJed5SK0yWVEGP5Z9BI0QstVTcK0JtxYDEGA1gsXQ4xCUOEp/grJ+ECv8fgTE47ZGnFuMRZ3QG9e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=JOpcRjk5; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="JOpcRjk5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UoHHquSvhwUEjuOaTqZ+K+Tlgrx/liQg23aXecIpwrM=; b=JOpcRjk5STOh6tIivRDl6lwRQ5
	g4doV1Kmw7w/6k/UoLmAOlWLtsOBiJHCjJ28qB1Tdl8NRYQF85UAc/02q5g2aTIOuLJjPZfms6WJ7
	CII5ioChZkULfzItxcA7/apnYAvEHdFFQZ9X0v3fStR102JwlU691E5b4GYY69W2GJliImH2Rox8M
	Ppbx3eCOagDUzHat7qcBwW+eZJdLq56nSffY7KLUKbu0PNV2mNoKRwUpUHGoBA7yaptSNgE4fXUG6
	k2WVKHMKSdnKePZ/kCAfzl9V198R0TgRZ7XCilgOxCk+erJt+DyAOIRKq3g2EQP4dZiMaI9U4UC4D
	Dxsc3Ekw==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wU85F-00BGx8-Dt; Mon, 01 Jun 2026 21:13:57 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Mon, 01 Jun 2026 16:13:47 -0300
Subject: [PATCH v2 1/2] drm/v3d: Fix vaddr leak when indirect CSD has
 zeroed workgroups
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260601-v3d-fix-indirect-csd-v2-1-aaebf035b936@igalia.com>
References: <20260601-v3d-fix-indirect-csd-v2-0-aaebf035b936@igalia.com>
In-Reply-To: <20260601-v3d-fix-indirect-csd-v2-0-aaebf035b936@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral Quiroga <itoral@igalia.com>, 
 Jose Maria Casanova Crespo <jmcasanova@igalia.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 stable@vger.kernel.org, =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1515; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=TmUeISSPkoxu6GHUhx+L0cQBj3qSN0V+RYbBp7OmGnY=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqHdnvzlCnX8vga1PHskPht5nazSRXdLpcqUr0/
 SyQ7MI/knyJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCah3Z7wAKCRA/8w6Kdoj6
 qng+B/0ZWMWWUcTcDOeJAzK4g/pdGN1IciTvyuKSv1z/Px1AQ/rLn3E7a++aFAnE5nrCEyAIc27
 1qqh6ebq+wtzgIHhYo6AIIHrBs97vwuKGqoayqyd4T+5gfSBVcrAdjP+lxMkqAFk3tReSNvTlrQ
 1EXvT6aQRpEEj9lIEj7nyw9TCbMVq7AVP5c0VfoyOuJxWSTeHPjpCT7lCboNSHuDPWbwYMmD1DQ
 4mV0u2TGxd9MpRDkDtqquhUUadHwG57CsWogpjUJn0GtKxluoUpQMKhEexwAjC2CV1aIkjmiDht
 sQTF8nlFu28YBMAhmNxQ7nJQtV/a9iWfJVSFWEjkGTUd/2uz
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


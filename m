Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C922E7631
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 21:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781560528; cv=none; b=bPw/EUCgPGxN2CtBkCBusr3NTBEwg+1MqKRZ598szWdXbJEcZZwIPZg2CSrQkvbCbk1n96EiMmZgm6+TooJKk215BzeGT36i5HvsuiBeiiY2FsW+3UbyGOPGCmxLtJ7aPiNWBu3cWqAZMyOHb/e81sZAZoEFTq5hDHGlaEjehto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781560528; c=relaxed/simple;
	bh=o44oc61S6NM8RRNktviWDDKhwGWAftGHHdDU3CvPTzs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rvoLDZXFccjcO6m50u7JU5/t4d4c/2+736fwELtdu9faTY4G+58YFcOhuUX1740Lze83ZCkBoZx0Gc4CcASlsT1pUivccLG17kMhZLE9ks4LBSMiC3iWuP1fTOkysd7VM1mjs3TjCJvq+/+A+U98DmH3jYGIywhHV26N9jom+Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aSqk6p1E; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSqk6p1E"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-36ba3ea5c46so2228293a91.1
        for <stable@vger.kernel.org>; Mon, 15 Jun 2026 14:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781560526; x=1782165326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d344Kvp1d6liDL70DZYwlUaQhxdX88VJQR8C4v9D23M=;
        b=aSqk6p1E87HQJbQbU+auX3Bjk9V6MK22Paj8BgcEuDsHFwU4Qn3VtDRa76tnLrs+VO
         /zvXheZVErXtenHKH0gTcdz46au/by5O07EvMX/cyDdv0m+BC4y/OzFbEbt+B4kAQ5Xy
         DstYcvjmRhFOcFqrZwPybT0YChkTCYWHK+3J2K0L4mrmRqXXWQ+DQhl0wkBkh275+Fwv
         zdi9Z1rgzjin2GTBAstB10hliKZ9Cn6YZkIqTBansd6tUzMQTRM4p8MlciDxrihSlIDm
         T+wjOlOR9F0KyCOh73yeoUgzczvErBYFAS84bLpUpWadgDRoPgQIjEas52a5AJfblWME
         6mmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781560526; x=1782165326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d344Kvp1d6liDL70DZYwlUaQhxdX88VJQR8C4v9D23M=;
        b=I75PenMlwAtABZso99oUM+sq/fvq+nDdoy2osdob6VEKRIR0WZuMuWJYhJzaX+5IHk
         SbR/0k1pyQLg5j9/ug4rSASTRbRZLB4tFN32hMoRuenep7HkfC0J+RkK60ezDZ1fuc0n
         Oxd8sUvxw4LtXCuLPnJOzhf/m4E5yzLvkE7r1v3cTVk/frE6ufHh0KHefxJbtFFMoF9p
         cxjqzihgzdPKZp2c3i8SRTwwL9jqmNJ0c5wXbU/tB/J/6qdKwWg0f0FjBKRp9UInqDQG
         qNg/mB6aPcOMV7hWltWyvCVS0wH/V8zXEtL9x2VasgdsWPH11Z2HGDgtrttKcadYCTIw
         w3tA==
X-Gm-Message-State: AOJu0YwtC0sAy9gG6MF4mqTW9OyKTkbWaCgi86/JMrGvfyCnpQQ+IN8y
	7xgMhywBRm4izjkKSCxFgcXN1KzgJKqd9AAXaeVTG5aTJpr+0bXXa1TjI0LHfPro
X-Gm-Gg: Acq92OHT1kkA+0j59O4A6Il/RkU1fULn8pKJa+CYIQarJsQ5YzNo3Qs1huNKGRbJJi0
	xZbSKYVq9x3qn7IQFmp7Yl9fh8dmECGm8OSwkDitx/dZ7dXP+H+ULPIFa6pCmlnOvkdJMyRnVE9
	sqPfbu+ULLNPioY+34atzGKNOPBjjEBr/bkQ22Miz7mnsHneh4sLKKZDGmLX8groIIadwuMSDT1
	YaD2ChFVQbCjGuIRZIPWjZeHSe4DgW0TxAUP7Bt2RoklHcfFJS/PORFVEPdtPpIOR6RoZb4s2DD
	msPr0StLej4d1nZca39YmfIifdWjoP0jxnIfgmwFaKacig0OIxeHzzYRFmC1PaoRaCAa6am4ueZ
	k5l+lOSe/2tTPg2f0YAnsSpkB6tqDOpFj/2YYRbMmYaTWB7dAoQvly8iTg28hw1KGAVKqlF532Z
	IpSd1ztcK4dBYI1LsImXmr9IlVDhWWU5Dhj6uFVnoqaShXMN48AqQLePvFFLx2sfap8uk=
X-Received: by 2002:a17:90b:5408:b0:36b:d2d9:a584 with SMTP id 98e67ed59e1d1-37a0250c893mr15994131a91.9.1781560526135;
        Mon, 15 Jun 2026 14:55:26 -0700 (PDT)
Received: from ljh-System-Product-Name.tail61485f.ts.net ([203.246.85.145])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-379e79396d7sm8492479a91.1.2026.06.15.14.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 14:55:25 -0700 (PDT)
From: yserrr <dlwognsdc610@gmail.com>
X-Google-Original-From: yserrr <dlwognsdc610@naver.com>
To: dlwognsdc610@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH] drm/v3d: reject an invalid indirect CSD buffer handle
Date: Tue, 16 Jun 2026 06:54:16 +0000
Message-ID: <20260616065416.1588258-1-dlwognsdc610@naver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: JaeHoon Lee <dlwognsdc610@gmail.com>

v3d_get_cpu_indirect_csd_params() does not check the result of
drm_gem_object_lookup().  A bogus indirect CSD handle from userspace
makes it store NULL in info->indirect; when the CPU job runs,
v3d_rewrite_csd_job_wg_counts_from_indirect() dereferences it through
v3d_get_bo_vaddr() and oopses the kernel.  Any unprivileged client can
trigger this.

Reject the NULL handle with -ENOENT, as every other GEM lookup in this
driver does.  v3d_cpu_job_free() drops the reference under a NULL check,
so the error path leaks nothing.

Fixes: 18b8413b25b7 ("drm/v3d: Create a CPU job extension for a indirect CSD job")
Cc: stable@vger.kernel.org
Signed-off-by: JaeHoon Lee <dlwognsdc610@gmail.com>
---
 drivers/gpu/drm/v3d/v3d_submit.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index ee2ac2540ed5..05f98379c1a4 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -605,6 +605,8 @@ v3d_get_cpu_indirect_csd_params(struct drm_file *file_priv,
 	       sizeof(indirect_csd.wg_uniform_offsets));
 
 	info->indirect = drm_gem_object_lookup(file_priv, indirect_csd.indirect);
+	if (!info->indirect)
+		return -ENOENT;
 
 	return 0;
 }
-- 
2.43.0


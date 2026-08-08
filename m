Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68EF416866
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 14:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786200570; cv=none; b=MpP59tYqWwnobi3pO8f7w1h31Xt+tq532CO7SHezgTg0uK3LJ+R2N3i+zqhtqz6odI/IFXrcGWUliKcAJOR9SDf0jBWQubBosTiWY2u0kPqZQQStERQfziT+CEweLbvPj8CVtCP4NRN563BRH0hugb6EuI3tzdUXYA2b+r5FpfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786200570; c=relaxed/simple;
	bh=YIY7uTlNX8XXHEGZZSyud4GcVHscIMBOt3JxqsrBtSE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nr/Ue5xOPeK2BvrS+zux0tSefsdPTr1HMsmMz56FjYhZ1TmIMppM06jvjr/uNS6c/II7WrsxzRfvDyOnCotxEXkaKnCUylKOiH2D7W4qyu8XS6yznkl6Rk/oKzmYbYktipFvb3CQv+Tb9ZePqe9kmlGJUmHifTZw9tqyESOmZbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OabEyupw; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OabEyupw"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38f0f132f56so2336750a91.0
        for <stable@vger.kernel.org>; Sat, 08 Aug 2026 07:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786200567; x=1786805367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oj+LpxJwmFVdLd+RvTFySlTh8hVfSNWlJ1ThruNqG6Q=;
        b=OabEyupwNs44EVbwmaR9KDImrjIyb0o5CkP/COSNe+PPWCsMdKZCsV/yA0iyy2pNbH
         dKSHYxjs2z/TidOx5K6vF6aD9Op6qSi8X9tyAghWE5BnpATkscv5h2nRbrq9Ef1BQ8ot
         ax7DcktnF4GnrgTSPLRc1257BhLVHILBQSwOgXys1Hl7POyKodC1EY0AMx/UusSYdpWP
         oBzW/QgZkaBCSTc6GerNyGZ8F+GiHcfR+OCjwVm4duoTA0CIxCCBBna9BdXmjFuKkj/h
         aIoduLVdEPck2V12jaK7XJ1yYg6wSlM9wp9xWhOTmBmlEGnzbeZW36soElLLqZ/xtXQy
         Q/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786200567; x=1786805367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oj+LpxJwmFVdLd+RvTFySlTh8hVfSNWlJ1ThruNqG6Q=;
        b=pcFuNROmXIZJpy19tuBuLWd63eyI+JjoFRPpagHBbRDd+khwER+02eOycLN95BK4KL
         Fn7QOZ1oM5a7mNZfKK7fyXivGmcxYGRNGHqM4Byy8KDnheJd7gY9v7FiPsGLZkhbgphs
         izPVasZdDWC18az1mA+lkx2VkUM9pCkfEnGjmUcy1VJiBNsn7IoiIKyrR1olobrTYJgX
         tGByCz0pLeRNR5Sd8ErdCleboq1gXwIRawZBMmTfuJt7KjSuSMIzKoX6z8L0CEqW/zxf
         y9DPWXLFuVy3SSwPcJ1pvR+zCL6GBdGpBqqVJcV974xL7T8kyDY6nOXl6r0+4VCKl/UI
         Lpag==
X-Forwarded-Encrypted: i=1; AHgh+Rqu4GCGlMorSMvzP3TVcImmo+fa8b2Yr5gBJggNCAAOoEU6Fp/lIf5rh3UbZz5diYAesj6TOUA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6C2b3BRGlVJrBuOmzXunAbnerg372s+jTh/cF9KQR76HKOk1W
	ACsjy/lh3yvBB9ZxG6I8j/W9UY9MlFNJCVK6oFuR8in3DjIn8Z9RT7ud
X-Gm-Gg: AR+sD12fYFUoR1nXQzk4kzGT82nmwQboRDHFAJQ9uA75vASN8HPpmWh03qe3FQFQUuT
	sMydJJc8rhhuy6c4jVTzX0AHFB0AspHzQi2GPuHDWlb0HSHitiTRn9eduKNGGN87V5KCfgppOeE
	TReBRjl5efTAbBASbFxDHbI/ACKr+/0Fd6fPzvhWev6233P1pSRTPUzEcggiTAi21B8emPf8CFT
	I4ur+cwJSU21GPmXdelMVfnHsLisitihIeclUrweBmlx1uQzB5fHerLwy2FELz3mkJrzQSyiKNS
	u9UIC2RLzVCm5yFm19uiiPNW54SOd0lJRxhBfm9qTcz12e5t+oiHI3HP1GrUz0dfdzJ/dndTLi4
	r8bN3g0s4mdfiF8/bCuaJptjtUgzNOTMBUvhxvTLnKTif3/0h5epljmWa9AKXG1rVw/Ermcx9kx
	CcJKCBoBE5KpqMEWdG/EdYB8RqHg0tdZXcElhaHxS6VbKYSN0QpQ==
X-Received: by 2002:a17:90a:ec86:b0:390:b3c5:e2c9 with SMTP id 98e67ed59e1d1-392846fd57fmr2663920a91.17.1786200566741;
        Sat, 08 Aug 2026 07:49:26 -0700 (PDT)
Received: from lgs.. ([36.255.223.70])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3925fd95270sm6365730a91.5.2026.08.08.07.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 07:49:26 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Matthew Brost <matthew.brost@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/xe: fix autosuspend cleanup during teardown
Date: Sat,  8 Aug 2026 22:49:07 +0800
Message-ID: <20260808144907.2918746-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xe_pm_runtime_init() calls pm_runtime_use_autosuspend(), but
xe_pm_runtime_fini() does not call the matching
pm_runtime_dont_use_autosuspend() during teardown.

If the autosuspend delay is set to a negative value while autosuspend
is enabled, the runtime PM core increments usage_count to prevent
runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
during teardown, this reference is not dropped.

The documentation for pm_runtime_use_autosuspend() also notes that it
is important to undo it with pm_runtime_dont_use_autosuspend() at
driver exit time, unless runtime PM was initially enabled with
devm_pm_runtime_enable().

Add the missing pm_runtime_dont_use_autosuspend() call to the runtime
PM teardown path.

This issue was found by manual code inspection.

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpu/drm/xe/xe_pm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
index 99562f691080..301789adaa21 100644
--- a/drivers/gpu/drm/xe/xe_pm.c
+++ b/drivers/gpu/drm/xe/xe_pm.c
@@ -518,6 +518,7 @@ static void xe_pm_runtime_fini(struct xe_device *xe)
 	if (IS_SRIOV_VF(xe))
 		return;
 
+	pm_runtime_dont_use_autosuspend(dev);
 	pm_runtime_get_sync(dev);
 	pm_runtime_forbid(dev);
 }
-- 
2.43.0


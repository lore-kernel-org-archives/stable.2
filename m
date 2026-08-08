Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C563812C2
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 13:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786196520; cv=none; b=ZaIzeVSTpHRjk4hwz/Ww3l+PjmJH3VUnZndxFsQYnprqavP22k05XylhIxpEpsYe3yyYkCtCtMoZjeM5lywolIx18vdG8WeFAXFV78MvX7W62EeAhWiK183rgiwh4TY9G4kixEop4kGHXFijMZdrMF+H4aMgl0b2bDSEr28Y+VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786196520; c=relaxed/simple;
	bh=fQj4a9TA622w7byO+NIhdfryBGnr7yGLH3EHFv+wGL8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ki0VQPFGjvKedCL/2xtSOaBCytzJjD/fWJc3LowD+kbAiKWJLm9imKEBK1HEkBWzLeqze2oG6HU9OeOyDP127bUNPbqlpOfipHIrkv4aEhaCIaatIhdqxD080ivBDE1mHWWUxA6e10or5QxiXTBFAIpGIw7XH7PDI3CBkzzPLMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kKam8xPB; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKam8xPB"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38f620399a0so392571a91.2
        for <stable@vger.kernel.org>; Sat, 08 Aug 2026 06:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786196518; x=1786801318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5x4mrfTwKDCuKeGOKJh1sjTyl1+66+prXU9ablIRt+g=;
        b=kKam8xPBhOr5bO8tDlovmMxtU58V1gjnQE3e+E1egzBiejrXFb1G2d0DQqhPu70cX6
         aV5t7DRc1bteAn4CRty879WGnTrZPWZKO45gL5F41nAut2zzubvWOPrpnTh0p6MVWFIk
         tYgJQUqF+T+lpI363XNAV/0a2sCMaBWrK0zZ36NSKEPzY06XR09hOrtv4Cl7iCenHMaq
         JMibocnzZvytpmVYVCuj63QSLoa2Q8ekt0xnHv6sxfeq2Ujv4LDGr3HZPnZ0mQPlMl85
         VoHJ3Oxy4atL2zTg9muk2XSS/1eWZBYrU0V2Xaff3ohOa0qn5B4wMoeIaip+DP83jO2c
         ojEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786196518; x=1786801318;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5x4mrfTwKDCuKeGOKJh1sjTyl1+66+prXU9ablIRt+g=;
        b=qzxpIHeMNCqnbpINcfVqtLoWYRw3alAkCHBpoJCbaNOL1Hd/F3/aODTmjrANE8yObv
         54LLLzoYcMO5zrx2fVowGLFRD+HmP2R2LFswj5pRd3cMoDiozUWa+JwmTjEbjYq1x7Od
         iaqjQxk5mzEQCzszaGYmp9/bA/4N8yKnahi6SAiTmjYkNm6lwx1i6MmNgbfmyAcVQkkD
         rMb+4X7wUgypKUs2Tx7mC7Fq8Jy1nUcr2i2tHjLDQ/vewG9ylMJUaNuH8KR6b9rRRjAR
         YxRMsxdbMKIGpfP3sJnqrfCBF2X0a8CD4pgvOTHPg5tN9uBCgfC+LlGuEKD6oZuz/SZM
         YR/A==
X-Forwarded-Encrypted: i=1; AHgh+RrBMGvN1xckt1ChXoBTSi19dnYzXGOW3XGcczaUhtGl06CopKaGbSiT/jp64aMEdRzBCHxWi2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqOpmg2R4h4ZhPCTJczXN10Y0TzekoxktkdWzCgRa36neLaIig
	ccdFqEnTLNlbm608UCZ7L0mNgvp4/GIY8oksQPBjOCcQBKqBixmyI1G7
X-Gm-Gg: AR+sD10Rr4OdQkeICPD06imLCheaz0rsrXYkLKKK4QA9YXPSQ9+ibRMd6tRtTPU1Idg
	/eapXn4QjIRaoGycrwEBqCsTe+4JbgrQw4tFGGYX3d/6Rj+MpWCbREMZav0ZEXd7cATWnUNROB0
	h5j0M9dhxRJYpWLf/6DjJ8pyHm438rdgbugo0pIh/W3woSjRNAgNPnHAzJhLnEwx66GZ9UZo59S
	bQQhIjq34b6qSd7FrIwXb2rnjblgZB3SiRpiIyoxkLnsQYo0pAaHI75SC17TD6z4ftbtQVSjWck
	T01Xkn+FR1AavfNhLc36Z7FwWlMyXHCL8l6da5IZwYSYHFVp9bY0yq1nsOkenSy4CCBEP7noBAA
	L9pMWH0W6JXXQ0xJztxi29BcaO4YLe7zaOJuLgQcRHMeYO2adgIzNLDt1djf33hrVxwy54sS5Wy
	rWkybqAG5gFYk2LYMQgApip1EemJIVUxfNLMJ854UIKbSErWOjEg==
X-Received: by 2002:a17:90b:4e8d:b0:38d:ec31:4840 with SMTP id 98e67ed59e1d1-3903c5932femr32396260a91.13.1786196517998;
        Sat, 08 Aug 2026 06:41:57 -0700 (PDT)
Received: from lgs.. ([152.32.188.52])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3925fc6f13dsm6278888a91.1.2026.08.08.06.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 06:41:57 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Dave Airlie <airlied@redhat.com>,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/nouveau: fix autosuspend cleanup during teardown
Date: Sat,  8 Aug 2026 21:41:37 +0800
Message-ID: <20260808134137.2864847-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nouveau_drm_device_init() calls pm_runtime_use_autosuspend(), but
nouveau_drm_device_fini() does not call the matching
pm_runtime_dont_use_autosuspend().

If the autosuspend delay is set to a negative value while autosuspend
is enabled, the runtime PM core increments usage_count to prevent
runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
during teardown, this reference is not dropped and usage_count remains
unbalanced.

The documentation for pm_runtime_use_autosuspend() also notes that it
is important to undo it with pm_runtime_dont_use_autosuspend() at
driver exit time, unless runtime PM was initially enabled with
devm_pm_runtime_enable().

Add the missing pm_runtime_dont_use_autosuspend() call to the common
device teardown path.

This issue was found by manual code inspection.

Fixes: 5addcf0a5f0f ("nouveau: add runtime PM support (v0.9)")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_drm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index e16f59b00f6f..1579a4b0785e 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -585,6 +585,7 @@ nouveau_drm_device_fini(struct nouveau_drm *drm)
 	if (nouveau_pmops_runtime()) {
 		pm_runtime_get_sync(dev->dev);
 		pm_runtime_forbid(dev->dev);
+		pm_runtime_dont_use_autosuspend(dev->dev);
 	}
 
 	nouveau_led_fini(dev);
-- 
2.43.0


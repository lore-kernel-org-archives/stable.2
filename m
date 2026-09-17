Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DB74D1790
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 19:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789672526; cv=none; b=RmKt2pAJV9s577ja78wXkNzSCEpoDoroBCrGkJCni36O8uOudbl7c8SuE87GEEZ/OKTpKzHoOKpkRsiHOtUg/amSqfV1/XoT3EuzGm5wPakI9RvxGxjN4Ue8Z5d0k59VySr51e69YAOyF1+pxxavxfRVqlI1pcbR8VHuk7Koz6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789672526; c=relaxed/simple;
	bh=suehwzQIugL8LAVRtlroYOOn+Zi38wpItFbk8gGbq7s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TDGaTte9nZMIM/RMjObdWZbnF4zEsg2LFB4eaCE+Qbu9XF9ooxV+lpAt4LuV15pFFRpNFw17Uz2Of3HgwMh9wljHTinzxkwqSG2Sd7U/vcA/VrWwqT4XYZknrAgTy/ksXxxyG0iVN0Gz4d093gTG529rmcBd+hlbE1hZcy9VPcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tgg/id1m; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tgg/id1m"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c2940ff2313so85250966b.1
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 12:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789672523; x=1790277323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UVO42avi1AUnneieHW+g4jz1dvgdxwcJ0ctKNKrRziI=;
        b=Tgg/id1meL8mItMN9eOYqFDX3HbeBfUMX9wfGUGE4gXXuHW7Sd7RspawlIqsOoot/h
         Y1zVXiNMmPLJcmDGkdivISkimm3rHbu7Sak9yPclDZq6S/3B21suklFr/jIQm/uZCerB
         vgJCt6QJgtYJ6Sz8dos8ZcijA/vmUKL45t7KxNjvdU9Jeuzp03HNtkrLUT4Xl1z9FBZO
         Si1Mw8Q4FTT6tEWS0zML9tEk7xi7Us6hu7G47X9uEoEwRYlQtvtXLMEn+GLd2mrDfrJz
         yBy31XeQFSHKUjLwusfsgpAr2O/Nq+01TT1ewJDtmdPLam9fCZQUr4y4JAeJ51FORtSA
         Ru4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789672523; x=1790277323;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UVO42avi1AUnneieHW+g4jz1dvgdxwcJ0ctKNKrRziI=;
        b=tQ2Xyjsf/vEGUgXS3K1+aXOwFS80sFoeaZqrzuT+b2JCV695q2pMQ4ojpCDEq/63/v
         WPYpfuMhg7OHOThyyvDtytoQcHri7x+Evzg1dSnUN59fjA8ykfZGWv92PaZM9Vk6s5IR
         +LmaA3IZqRQzxdE2LzFJQSD592iV+RsFAMI33IbfI46p2sI4cyI/g++b3tmXOKsj0IOD
         zRlUvyVDzJiAHxpPwLHlZKepxM2lULDztMUskXY8RWBROv614g1qmH+y06kM6y1t0bYa
         Ix5460XKrYySZaGfk8viUCxNJuY7q0PERcWmr2xZHsLY7q94I+7vkg6WAm3+tssU9+mp
         wXAg==
X-Forwarded-Encrypted: i=1; AKwUvByBGaByNahny/HumD0+2rZeM8lapM90eOpwPsd+A+RdIFCel1ODNt2YSh1Gyo+LVY9iIICAMgM=@vger.kernel.org
X-Gm-Message-State: AFuF++l+uYtIVkJoiJNObDh0NZ8YqgzgAu1J+gFGyj8ET8J4yimvB9PQ
	/ssEjbrobWEHcGmvLxbdVOTej4KqvDz0yhuvXCmiKTqv/CWUlCTUOekM
X-Gm-Gg: AYBFou00hIAzg1u79x7UY1MbGb3L2unaL9F56PPDjukmhQadPVEioVTkzXmLCnNOOcY
	/gFst4h9ENNnrQ0jxO1JGCKKPczdq9fku3xo+fT6jRb/fGDPW8Dxx9aqJnpJugUsCSV8b58PqSS
	kV2vOAljkmsIlDiybOyHuumwGn/b9nv1pUE8Q6oc4RKVZetPI68GGC151JjnKHbnw+gyBMr4htI
	NaLAJZ+dOvZSoAwFnK4mniQz08YiK3tfR0ohamleGWydi3l1SubWY7q9hx2S4jmmApA/SzvUuZc
	E71VEz4psgx1x31399QuTe/Oe0o3P8wydWTuU1IK9XNYBzFDJaH4uTPRiAcZlnmyeb7hEMKJq8C
	50Tp/gHE8bEVTmYcO6wBVHv8pqpLnPaY/N878rJe6eh4P/4pCG+VM+zngg5xhOuy6Z14kawnyqS
	mgkQnl54e6Nhtv8MDIpqS79olapaR5jnbk8bqSJvqXgvH9K7ikrTH47dhKXSW76/q92VQ=
X-Received: by 2002:a17:907:9703:b0:c24:6382:2648 with SMTP id a640c23a62f3a-c2a16403e1fmr9238266b.5.1789672523059;
        Thu, 17 Sep 2026 12:15:23 -0700 (PDT)
Received: from cartold ([77.213.69.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29de454b4csm333264166b.17.2026.09.17.12.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 12:15:22 -0700 (PDT)
From: Theo Andersen Carton <andersen.theo@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: airlied@gmail.com,
	simona@ffwll.ch,
	kai.heng.feng@canonical.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Theo Andersen Carton <andersen.theo@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/amdgpu: skip the noirq suspend reset for a switcheroo-parked GPU
Date: Thu, 17 Sep 2026 21:15:12 +0200
Message-ID: <20260917191512.38838-1-andersen.theo@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

amdgpu_pmops_suspend_noirq() resets the ASIC unconditionally. When the GPU
has been parked by vga_switcheroo it has neither power nor a PCIe link, so
the reset cannot reach it: pci_set_power_state() reports the device as
inaccessible and amdgpu_asic_reset() returns -EINVAL. A failure there
aborts the entire noirq suspend phase, and with it the system suspend, so
the machine cannot sleep at all while the GPU is switched off.

amdgpu_device_prepare(), amdgpu_device_suspend() and amdgpu_device_resume()
all bail out early on DRM_SWITCH_POWER_OFF. This callback was added later,
for an unrelated reason, and did not inherit the check. nouveau guards
every one of its PM callbacks the same way.

Bail out the same way here. On a single-GPU system switch_power_state is
never DRM_SWITCH_POWER_OFF, so this is a no-op there.

Found on a MacBookPro11,5, where the Radeon is powered down through
apple-gmux so that the internal panel can be driven by the iGPU instead.
Every suspend failed in amdgpu_pmops_suspend_noirq() while the card was
off; with this check a full S3 cycle completes.

Fixes: 9e051720f9d3 ("drm/amdgpu: Ensure HDA function is suspended before ASIC reset")
Cc: stable@vger.kernel.org
Signed-off-by: Theo Andersen Carton <andersen.theo@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 5c33c19fd9bc..d9d794a7db96 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2664,6 +2664,14 @@ static int amdgpu_pmops_suspend_noirq(struct device *dev)
 	struct amdgpu_device *adev = drm_to_adev(drm_dev);
 	int r;
 
+	/*
+	 * A GPU parked by vga_switcheroo has no power and no PCIe link, so the
+	 * ASIC reset below would fail and abort the whole noirq suspend phase.
+	 * Bail out like amdgpu_device_prepare/suspend/resume() already do.
+	 */
+	if (drm_dev->switch_power_state == DRM_SWITCH_POWER_OFF)
+		return 0;
+
 	if (amdgpu_acpi_should_gpu_reset(adev)) {
 		amdgpu_device_lock_reset_domain(adev->reset_domain);
 		r = amdgpu_asic_reset(adev);

base-commit: 50d05c7c76c96b90462f24debacca971d2e86713
-- 
2.55.0


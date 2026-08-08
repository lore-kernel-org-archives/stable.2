Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69288883F
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 14:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786197718; cv=none; b=sCPQxEXzydlYMlueofN2WrYlDswC02CSVfJmF8iKQd8v36RiBnPkwF60kYDp4MKpOWGtdSLT94lcS9HhIPTOcokx5YGVnJaYRes9DzGlt9GmZA9TnVucOD2M6keqcVIUrH0J+Qi8jEwN8E/ySZVXphlXsT0PwRua+OLJ/vdmmiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786197718; c=relaxed/simple;
	bh=tZMn7kozQpAUSV0Xgz2mGxbRvNsRGrJn6iQ5fog+P78=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T/7b2vUC42Yx20sJN2pFAQzEdsKdmHKDr+g+S5ceATG0/8pEPQ/ueNLy6ER8KaUNTPoKwmvRPLpmDGGSGocoDzerSfwEw3zaqwiZAt/uJdYyWSaK7lccxMrABQ7bq2lPwuGQYgQCXxzR5Cw16OVVBx/CYDyfP+pIZWiK15unmYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eEjYDMF3; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eEjYDMF3"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38dcbade417so423318a91.1
        for <stable@vger.kernel.org>; Sat, 08 Aug 2026 07:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786197717; x=1786802517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LWQEkJchPYeC0ZoavYUr3xCkFVeRdSuQOuSKSluD+U8=;
        b=eEjYDMF3dYTxTeNk7sy+sAVtVmm/iIFRGbUTIDonYuNN5+VLlJw+VRAC7GQduaj6Y2
         0ufFeAJsYqyB9OptOLoUxbW5GO/YZHUDLr7dBuL0zWjRRiXbNkOcIgVn5QE3MiALJyNs
         u587kvjayq4UhoTrrbvQYXC1C/hegUc7G+9GJMqYKcP+5t3d0RSmXgnKyRTevT9ABT8s
         oxpCtGrM8Pu46L8/2gXjFBS9u9XB370xAXaYdIgWsMJw2LPTw0awE/dO6Z0z2hUMqeih
         rmpcPuF9CXF6IZw+EGpUuNgdQeINQkEb8v4xmfIgjwMmWOh5qj/9VcIpRfvQGaaDppPs
         gKpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786197717; x=1786802517;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LWQEkJchPYeC0ZoavYUr3xCkFVeRdSuQOuSKSluD+U8=;
        b=iHOTuKxSjOe7jncEsTGKPvwYH6o5hllz9kIJJiklLh7MREt5aWZ+2LlVizmHdBfq94
         zvBTfreJiB5cFLn7vKxBWFObgCAPly0h5ZRexEPCcj+puRX2azjWni6P7qTxsn57O9vd
         05UcZhdKc8bqDOriakt2wwxPKs5xaj6MX9Fcu2oCJrVj52VtWFcRz97fSupl3HCBRuuP
         lgyCWl/uLXQlPxWwZd/5p1Ukxbnt1J36Cf6UqGQM81vLqZLyKRd8O98BM5/Fp7pmi0Vw
         zdbM/J2nxa1FjMM5SiqUPNeQMv+X5MJernCZflgRbFioypnhurXuGb1Q+COjrzEIZ1rx
         gsKQ==
X-Forwarded-Encrypted: i=1; AHgh+RqCx/9z49shPRsOhUMWIzsD5Zvt9SZKUFIsDB98p1+PCk5+O9b6DQ0KrZqBfd78XIULyo2cqzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvKGBfVGS1b9evpeTm6lel5L5ZeHWt61c7uNt29LQNzBG91ClM
	WWVtLKborGNm25ay8+iagkDugRNYCnw5c392j90k7u/kCh/FziKPls6j
X-Gm-Gg: AR+sD10+bbtvPJie3UWI4Qy9OQhG1BdS4Po7eU9hd62d3PaHelqBF4Rj2ldolUbA4ZT
	cJZKJ/v2QGpeayulVEA3z3ALNCv1Susf4iGh5JmcVWrBUriZ5bh+keqOHqAUXAPUn1wzmrsm0M9
	t7cS0ATg/lWxHnmG+cCcCNDnOdECDYTYdAc/2fIPNk9hjFprLdweo4qKFt9WvxaBBu75xfZxygH
	YoUrA3YR5MZHH07sJWwU8sXbw4tIko+sw8L1pmjVt1g9akkOH4EzS4VsVMetNsQWAZoxUOIWFSE
	5SK1mUIKN42JVjPP6/gpB9H0N1rJklFMR6Yj6R+o6jaDB/LUx1GRK7fqszDkHMu9/ju6MexgFgd
	r6G38wHUhwPjs7ROlF8LjKHgWxMIX1Em1YmRM/OIqOmUHEGQtcC/T/XOhS1vjMDaN9uFg3hR3eH
	6iSYDFJu5Ev0vmFgGnj8LclYv49NxIITkBUiOgCCGxmHA=
X-Received: by 2002:a17:90b:3f43:b0:37c:6130:7a5b with SMTP id 98e67ed59e1d1-3903c54302bmr31739321a91.8.1786197716470;
        Sat, 08 Aug 2026 07:01:56 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39085dbf82csm8638162a91.1.2026.08.08.07.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 07:01:55 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Dave Airlie <airlied@redhat.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/radeon: fix autosuspend cleanup during teardown
Date: Sat,  8 Aug 2026 21:59:42 +0800
Message-ID: <20260808135942.2880971-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

radeon_driver_load_kms() calls pm_runtime_use_autosuspend() for PX
devices, but radeon_driver_unload_kms() does not call the matching
pm_runtime_dont_use_autosuspend() during teardown.

If the autosuspend delay is set to a negative value while autosuspend
is enabled, the runtime PM core increments usage_count to prevent
runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
during teardown, this reference is not dropped.

The documentation for pm_runtime_use_autosuspend() also notes that it
is important to undo it with pm_runtime_dont_use_autosuspend() at
driver exit time, unless runtime PM was initially enabled with
devm_pm_runtime_enable().

Add the missing pm_runtime_dont_use_autosuspend() call to the driver
unload path.

This issue was found by manual code inspection.

Fixes: 10ebc0bc0934 ("drm/radeon: add runtime PM support (v2)")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpu/drm/radeon/radeon_kms.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/radeon/radeon_kms.c b/drivers/gpu/drm/radeon/radeon_kms.c
index dc43fd790a9c..4a99c09f4164 100644
--- a/drivers/gpu/drm/radeon/radeon_kms.c
+++ b/drivers/gpu/drm/radeon/radeon_kms.c
@@ -71,6 +71,7 @@ void radeon_driver_unload_kms(struct drm_device *dev)
 	if (radeon_is_px(dev)) {
 		pm_runtime_get_sync(dev->dev);
 		pm_runtime_forbid(dev->dev);
+		pm_runtime_dont_use_autosuspend(dev->dev);
 	}
 
 	radeon_acpi_fini(rdev);
-- 
2.43.0


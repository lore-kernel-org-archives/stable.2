Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F387390214
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 07:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789545068; cv=none; b=SaL6jKijkNd2D0pNhIoXc3Kzy1f2PkFK3hBGMTSIIH0h2Nkx5JtCnBgCdqEo49/GtUGtKq2MqDqfQQFjWH81Kq3vd4wgHJ0salwGrnA9fmcrJORbaWLirwLA2V9cBTPskHMW9W4eOFQjLVb3zawGPhrWZ4uiO1sHDcukLnepUAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789545068; c=relaxed/simple;
	bh=4eH5Fym6C4VSyFe++/pCvPvmqmWpuC4bBghErnGUi14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ufkFdMmpg/i0vWfr5rF9gfdQ8/lugsgFNEMgPF4Wy2YH07+Gd/4l4v92APbdUI4jCf+EzWNk4RWz1r5vUKqnEMSN8Htx461+NUYI9aZ8gIF/UsL1DpOf28pfFmfbXuIEaRcawob+hHBdLR8msjpBxntW0nAnCNFBf6EyBvWG04M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W51bNS5p; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W51bNS5p"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c29703cb796so95053266b.2
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 00:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789545056; x=1790149856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=j8D6JnnoF4uT9GFk7g9DjQ1aSimSgKnpfAaaRW4jURk=;
        b=W51bNS5puyz4Nlom+EKiUpR6uVQBcUvj9f3i59bY1ZdC6cBG4POEWSHIVqBT5VQMaE
         Ctd2WrQMF5M0oq7J5TPQqc5wTp2oXaCd+Utnc1z2HlXpBD6qJJd45W6/BEetOuMXmYKm
         AFw+On0iT6S9A3n4MjzV5RORUgh43sksymK3dDKuIkWErDkZs1AfIIJM/M2U//1hZ327
         3XE1z9qgPEtYNSZkcGuKeTqaWV4DzbpT8YAKtUL15rUnMxL9YlA/paHRYynUCTUAJ7Zz
         bQmiimI1OjhkpvSAN2fVIb58NlTzQF5Ac66HtZPL5KZ+KY3cGS5nhR5rgegrnDLkVN8/
         P3gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789545056; x=1790149856;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j8D6JnnoF4uT9GFk7g9DjQ1aSimSgKnpfAaaRW4jURk=;
        b=i1NPNnTlGZtntZd6ScAFl40G56Pfd4eptwMSjdPxHn+pmPF7R2ATbg6cE7IJw3P9/J
         HuOzOPBmHxHLVNXSuCTKCsr7GdE6FxRfQqdi4v1MUCkbA1cnPTlnEtR9ATNPlxTtbY0C
         0S2pCmNBQPQ9Cp1OSfTVGZhLB+x7M25pGIOAf5ZUuLBSU45tXQQ8Q0ZBwJPNTcf4b7r+
         FIbZsA9Ip7vcdXJMbTsyud7p2fOT0oSm17T2v1n1qUkR9wY1jNjJd4zXyRIgo734mqN8
         Xvzv5jBXuFlP/Qs3m8QQjS0qIxB7cWau/nkHd6M6iH5Zztm7yW/fuskPDdUrNWG+X75j
         kguw==
X-Forwarded-Encrypted: i=1; AKwUvBz19+KzWVVa2s/qLI2DU7wjF1pO5PxPv2dzk2E68gT+Lx5DKAV8J9D4lr4UrYivsDJp3wOS0kw=@vger.kernel.org
X-Gm-Message-State: AFuF++me7V40hNb/fIA/e/DpQ3dVKl3C0BAPaTzsS3ik8qDzF0FenFj6
	E7OLiJqVPSz7FOpTlIsnuM8UvaeI3QTPvSKU4cD6c/PVa/6L5fel29oWV8JlobZjOga+tQ==
X-Gm-Gg: AYBFou0n2EOsj74771kpZrvB1J1s4lEe5wa+b3qGUJ2eHwdV5wcpAulECz4VU8hwA1f
	1gTk4AdIQUpJfah9NxF4M48eZsfa/vT/FZxOD/SdJwWEjUUUd/TlaPE7QQUzUGydGt2aQBqL05n
	1dh4BakLl3QQ3gFultUZR156P0P5hFPlhqjgNZG7jNY2V5HLAwG6kbumGkd3UfmDz4iCpdUyRJR
	nwdDWFLL9jgfDGyqbwCG4fxHL5z7llvcLQ4gUImVvTPiyy8pQur6U8kxON9+46PG1EXWfuErKgO
	CNNYtXx9Sj3+epHjVjxQrUEIC1/4UulFeXmt7Fpcd6VgDdzxwzWB6pZl8Wo66wmK4IhgC3nBeOl
	HgZW2l7LxbksCnfoOEcLrdzaYKrQCD5G77TBEz70wopqjOJKeihnTDVlyk9UKMHzOupjrndXvSr
	k7g8CbjAkudf1JD/zbC1oOT2yP0AZ3AC7RFeqym/1ye0cQ2aC1JPE+MjNP55QuU8QC9r1prexIB
	sAiLIlCZysmMnysal3qmjJnnkPYo77LJQrJMDRV07xqZ0r7Uj9KF3ZW2QqUB/dG36twNcYPYUoe
	Vk1FriHgwaNwQViNq3/HuGuJb5HirnNT9x6UrIs1ulYyRfbUgXpadnvRtt+zRS/AUipLHXFN19p
	3QkHylyTaO/xHfmllocVagHM6kKmkHhj8HXzBle1xh4xytC4Vo33Tesgz+6tE2ImoQr7wKBzj9j
	41778HKhsY8bEfvDT70uiMlY4/9/6DcQu6czjdxHGXKbEByjSI72ljqatSpuVPWR2exJHdmgNrx
	u+YM32ImHGEj7BB
X-Received: by 2002:a17:907:940a:b0:c29:4415:2ebb with SMTP id a640c23a62f3a-c29e51e2170mr112244966b.8.1789545055876;
        Wed, 16 Sep 2026 00:50:55 -0700 (PDT)
Received: from cs-280612103108-default.europe-west4-a.c.oa7bb030819b2a894-tp.internal (219.145.32.34.bc.googleusercontent.com. [34.32.145.219])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29de652313sm76139466b.55.2026.09.16.00.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 00:50:55 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Boris Breyillon <boris.brezillon@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Steven Price <steven.price@arm.com>,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Dave Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] drm/panfrost: add missing pm_runtime_dont_use_autosuspend() calls
Date: Wed, 16 Sep 2026 07:50:51 +0000
Message-ID: <20260916075051.1353-1-joshua.crofts1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

panfrost_remove() and panfrost_probe() disable PM runtime on teardown or
failure but don't call the pm_runtime_dont_use_autosuspend() function,
causing potential resource leaks.

Add the missing function calls.

Found using Coccinelle.

Fixes: 5c0c825ae4c6 ("drm/panfrost: Replace DRM driver allocation method with newer one")
Cc: <stable@vger.kernel.org>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 36cc2e67a308..74e8e5783f9b 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -1012,6 +1012,7 @@ static int panfrost_probe(struct platform_device *pdev)
 err_out2:
 	drm_dev_unregister(&pfdev->base);
 err_out1:
+	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
 	pm_runtime_disable(pfdev->base.dev);
 	panfrost_device_fini(pfdev);
 	pm_runtime_set_suspended(pfdev->base.dev);
@@ -1027,6 +1028,7 @@ static void panfrost_remove(struct platform_device *pdev)
 	panfrost_gem_shrinker_cleanup(&pfdev->base);
 
 	pm_runtime_get_sync(pfdev->base.dev);
+	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
 	pm_runtime_disable(pfdev->base.dev);
 	panfrost_device_fini(pfdev);
 	pm_runtime_set_suspended(pfdev->base.dev);
-- 
2.47.3


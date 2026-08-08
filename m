Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9350E368D73
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 13:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786194158; cv=none; b=tQZCcGl1Mjbhy4SkUt8aqw/M4vPidAL9y9Wr33x3TxNH0TGAiUvgyfWV3qArTvyP/Hu0XcsxUMeJtljs30xsyJ3LpERsomVtbQfuM/P5NPaR6Y4n1tm0irmX+4NgRNN4/Xa3Z5OrltP6i3as1x1CDRg0+lCt18Z3tQY7P+aVrM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786194158; c=relaxed/simple;
	bh=Eu2DxpzXT2B2CoowyfVggZHqw8b/0SXNWN1PQiInjI4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SH01PRCOBTOiM9HSds9N6ys1vlLDTpRL5e7xg5UL6+3Ho+MOHvaYmaAYOPsOTwIY6sXUWNMRn4j/gDPIqXKCUTpYkkkygFpVAHDSmzBRsAUiaVHnXQqvDMsPsdyEdODMuL2LMANwbK4qYY+aw92GBusf4faDjqLiY6WwXExgdjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vrp22tvc; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vrp22tvc"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cc97653887so5221255ad.1
        for <stable@vger.kernel.org>; Sat, 08 Aug 2026 06:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786194153; x=1786798953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ujnNvGTSQxsZnZMjDYqn4ikZo1KrqP6vWqNprtUTP2Y=;
        b=Vrp22tvcgAXKg+vbZ4duMjeMbripE82VHekNYB4gq/ODT+3T0ifEboiWb07LGBkLFR
         i5IGGBr8cpYRIhlJUG8sJFSqXo9DuiQbuETP0qh71Y358/UY5+rc2oGxSSAOEetLtCL3
         rLuVgqOKMsmM5mMXlIsTOQx3eE4stzlUE0WjDzVbqd9GgMoAFUiXocj/zC3kXDQyn8TO
         WIXdKtg5hfCLqNpqBNw+KhOUL49IPVR1uagcWyc/lQ6K+4VG9WhKd43yoBUdcXjzryIx
         FHCElBX0pAlmHXNqae9awMN31a+OfT8eTHg8WeE5w3Ou45/Tdo9P2Jbp9BTDzPMNpLpX
         nsyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786194153; x=1786798953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ujnNvGTSQxsZnZMjDYqn4ikZo1KrqP6vWqNprtUTP2Y=;
        b=Tg6fr6BeTegPnLiIz4SUvhTPkeAacHtRLoR3Puaz0igsY3zhljLfzQROR3le9wNsn/
         iVQCegEUKUi+23KFmFSNJ2tdXn5fQAJJUoW7ahy5wNZ3VeTOs+5Sj6Vls9vLrF9eLG0k
         +uq9u6IXcjQy3+MfyMT4az8tZc943h55siMiXET4nrsWHFTgiy2gr6hnfEA7nytPounj
         xKzSwJx2qt+A90vxpAnUr626kgZQ4a3+IaaLHjvnClXz2nZ/bXbRVgg19kVQoN6yQ5sg
         caTpqEtzwPhE3L+z/mtpr0u78S1h5Zl2+yTSfXCD4EuTwhNIc5UvezkyNl+4boeVYi9O
         s0Xw==
X-Forwarded-Encrypted: i=1; AHgh+RrkzrpViGP+RzwjMLY+cEnU4qH3HECU7Kz+19I39h6kyx1XN7jldEHQpkg42nC5nx269pbinfk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpvn+DVTlM8ZJBO/4dJU8h8qOktQGhVDK6islzZJWcktOntRsX
	2Bcy4/+RzfWpqbNcgFRtDwBm/bshgg6PHbcorawRqr76/lcPLHv+pQYi
X-Gm-Gg: AR+sD12eyuvRqrw6zSR5NXneEJcGN6lRRG1bRVe+DN1hpwNsn9BOEFdr1Jc16t0tFse
	RoAZn07Dty3L8vDlUbyV0YcyCZ3d27rocyoih2+Ah9HKUUI7sSwMPANdthsLNqDktgtQYH7pEar
	QXeFwx+T16bvUM4VOiUy4VSQqPswN1CiXRFrp26QOa1pwd0glgoGMaZ0MjYjvqUAjQOEI0+3Hu3
	z8raSt6QMfZS4BSvg35V4W8735VMYdq39ENp0wFZO81sBN5K308h0hd75WQPP0etdEoO/MSybQB
	b3NvPe1rwEqOgrdoryGjirwKrPFP/FPNsN1VKHeiyp4TSJVyBPExd0AWNkRV37i+bN/ORPaht26
	axwIzKs6LPmQR5SSuTon333zkLzdf8HeVv+TbWrQ9DP8SV5F10YxyvHxZz6o47GRtCp8tApzZAo
	uiwNof7SC8M2ZBobhjrKQXStshCwnbfvzxIL+aK767eQYQ
X-Received: by 2002:a17:902:cccf:b0:2d0:cc92:f7b8 with SMTP id d9443c01a7336-2d0cc9302a7mr351828965ad.2.1786194153328;
        Sat, 08 Aug 2026 06:02:33 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d14ccae6f8sm18582125ad.1.2026.08.08.06.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 06:02:32 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Qiang Yu <yuq825@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Vasily Khoruzhick <anarsoul@gmail.com>,
	dri-devel@lists.freedesktop.org,
	lima@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/lima: fix autosuspend cleanup during teardown
Date: Sat,  8 Aug 2026 20:59:53 +0800
Message-ID: <20260808125953.2842241-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lima_pdev_probe() calls pm_runtime_use_autosuspend(), but its failure
path does not call the matching pm_runtime_dont_use_autosuspend()
before disabling runtime PM. The remove path has the same issue.

In particular, lima_pdev_remove() explicitly sets the autosuspend
delay to -1 while autosuspend is still enabled. A negative autosuspend
delay can increase usage_count to prevent runtime suspend. Without
calling pm_runtime_dont_use_autosuspend(), this reference is not
dropped before runtime PM is disabled, leaving usage_count unbalanced.

The documentation for pm_runtime_use_autosuspend() also notes that it
is important to undo it with pm_runtime_dont_use_autosuspend() at
driver exit time, unless runtime PM was initially enabled with
devm_pm_runtime_enable().

Add the missing pm_runtime_dont_use_autosuspend() calls to the probe
failure and remove paths.

This issue was found by manual code inspection.

Fixes: 50de2e9ebbc0 ("drm/lima: enable runtime pm")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpu/drm/lima/lima_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/lima/lima_drv.c b/drivers/gpu/drm/lima/lima_drv.c
index 9a0eb1092ad3..9bd44c191e6c 100644
--- a/drivers/gpu/drm/lima/lima_drv.c
+++ b/drivers/gpu/drm/lima/lima_drv.c
@@ -434,6 +434,7 @@ static int lima_pdev_probe(struct platform_device *pdev)
 	return 0;
 
 err_out3:
+	pm_runtime_dont_use_autosuspend(ldev->dev);
 	pm_runtime_disable(ldev->dev);
 	lima_devfreq_fini(ldev);
 err_out2:
@@ -456,6 +457,7 @@ static void lima_pdev_remove(struct platform_device *pdev)
 
 	/* stop autosuspend to make sure device is in active state */
 	pm_runtime_set_autosuspend_delay(ldev->dev, -1);
+	pm_runtime_dont_use_autosuspend(ldev->dev);
 	pm_runtime_disable(ldev->dev);
 
 	lima_devfreq_fini(ldev);
-- 
2.43.0


Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634953C3F4C
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 14:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786199293; cv=none; b=JCnsuw+PdmkCZHMcmbidAUJpScpmt6HIP9ebfMHRk1oADAQpteL1u0RcZugRFkOiEKPdIWkxqah2BPznJWCWs1k4iA8G7lM23ZAwZfbP0YoHOb0fZQ8+ClFKSCcaNGvuxX9yVmK1tc1i5yvSKQ/G5EcmzDX6nAjAh2Mplik+2Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786199293; c=relaxed/simple;
	bh=7mv9HvswDVh8EyKNHJ2j/W4z9Y4BOOPYH5orw5cVUgc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eDyrd2nNYc7cYwW6iCKq8++YZdUx4xDpQjIHmi6CceEEjFonc5iaqKVecxAayIbCgu8nIiU2THKx+2XhM3OuTRjp7M2zkL0BpWZe1QmEkpz/j1k5qWIWQfEwHw4eBKgsynpcX4LQB2SA6wBmTxdJrAzBEnYqPI02Ni5AWRDB5jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B7Bd+uuV; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7Bd+uuV"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84f3ab8750cso465531b3a.0
        for <stable@vger.kernel.org>; Sat, 08 Aug 2026 07:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786199292; x=1786804092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JR3/zjA3xajDjkF0BbKi6bxrnqpn1dXC1eeAaooz27M=;
        b=B7Bd+uuVnDckTln4FcidR04hydNFQ2eTbLxSYeMYKzkVR1Zz1D8OxVK4Uv9+/1brlX
         1iSyRQsQRo+WlnZxfv/l+D+y7NRaOeyPC7v383JNbnVmACRDbXusBCE6vGfJkss2iWk+
         hAurQ6/GGH6HFsb2xOJuRUcg9T157A3x9FIugJJ1Z9KEYgi2IeTTdRs5ftXj/YDZxunE
         EzF6AO5HuPSAuO/DiNDX6khKlMzSZMgxljel8OOEeOZXx/7WZHKv/1pDAdylm6pRMZw0
         OH/n2em5DaFLdIa7cS/XIG+SdYdGOr8mJXreSy0DTe1JVJ2cSmD0VvLENaQXpWU5HZWI
         zXwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786199292; x=1786804092;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JR3/zjA3xajDjkF0BbKi6bxrnqpn1dXC1eeAaooz27M=;
        b=D9/OXnt48lOehzMhbPxfwRLjxMSVFHha7oUzPGXg8t3kGV92abJlUA9ak3fB3pHgdY
         k1SMBW122Q/jA3ZLwHwJxmkN//sBe2vi099yQHUuVTOsRjMGhmJcsrJyvyxwj33GFOyI
         PH+jreGqV77mXjVWxB+2QR5KqwdCycCxMueerFcUrtuDbgpQX8BNcZV9YlY+sHFadgNr
         nUnxu0XcHYoIhZ60Hc3XeAk3Wzbl4rlmXEQewSvd7FhFE/r++lrM+/591SZbEZ18hAyk
         UfQO8Qm9RSjAXdhBo0w+sE9nvU5pSAZ6uV+1nQpCGFN76SQ4e0FT8UAEyJ3hJRx0Z2Bk
         qqtQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro5AKqiEXzUczKilWfJWiI5CgQ2rx2DOPdDABjIxM7anRQXIb/pOni1UeF38e7U6m2S59kHUU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFLPyvU22Imssku1/goxFa7QV7uiOz07tToB/7hK4k4KNmOXym
	pXvJWHRbHJUs7mqu3C4D2xwDPUy1rJu43UCtFrKZ6zd+kkOWCiUKtN5h
X-Gm-Gg: AR+sD13Ms3HZc86kQyveoQi//Ny/YrLBp5hfBOPruh4RPgB8r0u2K64jQipf/79ya88
	rccWjSWeBpnJKvSUPMih+ScaCJT2XLu3ohWINrDWn6cAqMMvD62bKe1JVEi28IN8qa5W/dTZERH
	AHf0l8XBfYGqytC2hD9KbR6MWAUJp3e2EU6qZ/uQ2qnnxkM+p6Se44kGVTLUB/iL8FG7Z1OPKGX
	17SW8pwBiUlY7hP3ZfQHjFSi6j+Zz0WOSUSkvl/mQbXl0Rclk7LqmRa3hLmsikaQfFWpqFh3Ufl
	7HOAk8Cn3V7lbJArG1z0bCrwmVi99CUGKbAQZQqq9celQM72BA67HuOLPLFLIpTSFU2fX9BgBYs
	06LFjluy9Lp7XBaQw54XaR9f92ogd4ZEQNrXl7l/8CFRAz6JCrP41T6Kf9+534xsFQ/CffdpauB
	NzNPvProIWVrUBfeyr9bvZyHIrkcDegecgtkxetsS40HTpUW1tXvlFXqARjA==
X-Received: by 2002:a05:6a00:240a:b0:84e:538:476e with SMTP id d2e1a72fcca58-84f2e0ed7fdmr30329697b3a.32.1786199291788;
        Sat, 08 Aug 2026 07:28:11 -0700 (PDT)
Received: from lgs.. ([101.76.249.46])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a51e9fcsm2177867b3a.36.2026.08.08.07.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 07:28:10 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Thierry Reding <thierry.reding@kernel.org>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	dri-devel@lists.freedesktop.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/tegra: nvdec: fix autosuspend cleanup during teardown
Date: Sat,  8 Aug 2026 22:27:56 +0800
Message-ID: <20260808142756.2898271-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nvdec_probe() calls pm_runtime_use_autosuspend(), but nvdec_remove()
does not call the matching pm_runtime_dont_use_autosuspend() during
teardown.

If the autosuspend delay is set to a negative value while autosuspend
is enabled, the runtime PM core increments usage_count to prevent
runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
during teardown, this reference is not dropped.

The documentation for pm_runtime_use_autosuspend() also notes that it
is important to undo it with pm_runtime_dont_use_autosuspend() at
driver exit time, unless runtime PM was initially enabled with
devm_pm_runtime_enable().

Add the missing pm_runtime_dont_use_autosuspend() call to the driver
remove path.

This issue was found by manual code inspection.

Fixes: 62fa0a985e2c ("drm/tegra: Enable runtime PM during probe")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpu/drm/tegra/nvdec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/tegra/nvdec.c b/drivers/gpu/drm/tegra/nvdec.c
index 7a38664e890e..cb52459b2d79 100644
--- a/drivers/gpu/drm/tegra/nvdec.c
+++ b/drivers/gpu/drm/tegra/nvdec.c
@@ -546,6 +546,7 @@ static void nvdec_remove(struct platform_device *pdev)
 {
 	struct nvdec *nvdec = platform_get_drvdata(pdev);
 
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	host1x_client_unregister(&nvdec->client.base);
 	falcon_exit(&nvdec->falcon);
-- 
2.43.0


Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAE53C3C0C
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 11:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786187218; cv=none; b=qL2sluBfekYbYY3XwE1FTMqLrgzCgBlDNmPjkQUi1rIgEwjOoxsXHWI9sZPt09SO8TvE93kGCNtQruexwVamk58GMkLU5NxUTgt2YN2UnDSSD37wBxB7ivoqdEpi/YAcOWcga2d4yHmT+ql7tjQFddEiRGkE67PuMZU+EgJiYn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786187218; c=relaxed/simple;
	bh=J/ymqtZ5t4rqiTSWSp7zbVWBqr+7P+uQXvX3Ct5nAoU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n0xwcVYC7xUbaoiUjgej+dMk4Np4gUdWIHolFgogv/+3+LcYQQeSkYxs9io/etRsyUtlZQ6CNmi7Pa/oDyRdTN7d3PatsUZX9RE0SrVz9Vg0Dvg2hhts23+x8SgzyEuIAD7hcfjYrD5UkGlkuKZECNHDtlvYSNS/a+QrSXjdnFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fy/Yj0Ki; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fy/Yj0Ki"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2d02b4c3601so4415975ad.3
        for <stable@vger.kernel.org>; Sat, 08 Aug 2026 04:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786187216; x=1786792016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=M8p77R5oDeTzUjp3uZU2mFPZEkph6YP/aLn1kfdoEnU=;
        b=fy/Yj0KiYipgqOQm5AZt3hYehKtzjZWKSsuMQS7Vi8iviYvCrYXWm8avEU0qQ7HJcW
         s1MwSE7S1VVPPnT5NhuU1EYkUwviPOH4xcveqLDXnj+cWkLUEQEOOMrRuBrLuk+igfhN
         Yt66gBg9mMoTKVnHRfQvy3MhuZV4LNCvgPc3XCSddrjxPKC7nvEY5sx454o3YkcwMpqr
         qXMN6jrQBvVHtj3v8Map/3vrL7jrSvjZJ53ff1jquW5RhjVJ9nxZ+tsAmCGTM11eK5ry
         fVmBsxcMSj28JmPOZHF0P0t8g852+inlgmq5OY6uGBUnbS+/m3mkFaXfJnp6U5l+1E3B
         dAsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786187216; x=1786792016;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M8p77R5oDeTzUjp3uZU2mFPZEkph6YP/aLn1kfdoEnU=;
        b=H8XIoJ1dDytsKWlfa8+SccqIzZpiJ6Nuyh01ySiO555ZuelF+JXiQtNPXfwotnMaQ1
         RoeBsXo2WCbX8Swk310LY7mAq709ZPJHDLKrZ4/JULeLS98FHA8MkTVfRBqD3kOIUCDL
         rr6oq/uNfBEuokM6JV/hHpVjGm3KqXlTg/BL6DQro1K560CUYGkVWkRZ0rk9ctexQR9f
         dwYNirT1+L6ZzXvxaH6NWeZcYKnMBU7ZHBOq9BeiQeTmSqiEE7hzvpfCggnJmV6QZDC8
         IO50Md98K7/KUxGDNbservZM5nv9PdPsA8lMvujhq8EQ48uvIH9sgszLWVdCzne1Dzp5
         Pcsg==
X-Gm-Message-State: AOJu0YwtpdtJYP30O3u8Mf1GGXox03x8uvjw5FuQv1jn56rrDw8Pu2Ny
	T+G0qROBAQqkH0Yq7WfLDs4jVQBWorzRunJ2+L9y3hqEIpx40Op2oI+N
X-Gm-Gg: AR+sD112BFjSbumcrPMN6nk5IWijV7qW0yijbeozcPkD4nDEQyGy/0nQdutXTT+4+Q+
	x8XQb7ZagVRfah2uzsIHhdmFn3IqEQovY0qVYFEsvTl2qqdn2FRWLJ2C5EenMfHH2BaspzlvsNK
	7mALL30O/sPu9VhBWVvVuj4v+bp9z9UYdWkDGiV+Tzr0eiXXxIrIgJComBAHdOVJScGr8g2R1rS
	/hJNvZLtoVh59EykyRjV0i3ouiVDeujY38ZvdDVlaTlqODMUEXZYYOiojGxxE/Zy5Hzz9fNuIzv
	pG7APndNsaOqN+gMMsS8aSFWo/+e8xPD2/tPHa1SQgQ8R+fcoAPAi9yiEqX3wsv1zLq28r0jO9G
	jtgBv3fMRB6rAeej3pb7ohgw0nRRcDP6G7n34nBHyoznlYti8MJRwuWCxNqFaMdRQE+y9omA1Q5
	mNBheStrWx2OoPyRxWdJgviFM+i3+OzueKl1m+iOHA3bziVCpWqB9cR3+oRw==
X-Received: by 2002:a17:902:e851:b0:2c9:de53:f84f with SMTP id d9443c01a7336-2d0ca9904acmr318334315ad.19.1786187215843;
        Sat, 08 Aug 2026 04:06:55 -0700 (PDT)
Received: from lgs.. ([101.76.249.46])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d16c4e1182sm18019325ad.72.2026.08.08.04.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 04:06:55 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
	Pramod Gurav <pramod.gurav@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] dmaengine: qcom-bam-dma: fix autosuspend cleanup during removal
Date: Sat,  8 Aug 2026 19:06:42 +0800
Message-ID: <20260808110642.2770355-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bam_dma_probe() calls pm_runtime_use_autosuspend(), but
bam_dma_remove() does not call the matching
pm_runtime_dont_use_autosuspend() when removing the device.

If the autosuspend delay is set to a negative value while autosuspend
is enabled, the runtime PM core increments usage_count to prevent
runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
during teardown, this reference is not dropped and usage_count remains
unbalanced.

Add the missing pm_runtime_dont_use_autosuspend() call before forcing
the device into runtime suspend during removal.

This issue was found by manual code inspection.

Fixes: 7d2545599f5b ("dmaengine: qcom-bam-dma: Add pm_runtime support")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/dma/qcom/bam_dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index 1bb26af0405f..05a3b1f9e0c2 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -1401,6 +1401,7 @@ static void bam_dma_remove(struct platform_device *pdev)
 	struct bam_device *bdev = platform_get_drvdata(pdev);
 	u32 i;
 
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_force_suspend(&pdev->dev);
 
 	of_dma_controller_free(pdev->dev.of_node);
-- 
2.43.0


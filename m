Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8023B100A
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 11:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786188365; cv=none; b=UUeH8in5o+3on6RRx4F+z5ZxXIwIcMoFQL3bwpVu5HYtc9ei2y0sJcbq9OCRPCxaSPVzLWH6nYgZZK9JFx9Gzp7GtCEGNiTE564kp8FYu7dGhqCHWMWbyJ3iT8U1Zius6EyYcQSMDuyvzdXTbq2IPpozdR22lOSO2pXW9a08H8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786188365; c=relaxed/simple;
	bh=79eIeLy6BGI+fBiKuSwA2DDf6rq8Fp/Sbknof2xZaCs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NzivTbo6I6j8BbYz27IiSGAwwEBhzHESmy8NqCfceDbQgR9r8IdAhuzpwXyQ5G1yObe06LexCh9WT3hAWWRdB6DCJK7ijZ3t6K/uGZpmY0Ww2/IxuLXugfgopjYHcHNLJzIDYzq8CiDj/QVrj5GGi5kDy6F1G5jt2as3ldR/yR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NhRmPf1o; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhRmPf1o"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38fdeaed181so445553a91.1
        for <stable@vger.kernel.org>; Sat, 08 Aug 2026 04:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786188363; x=1786793163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BtuOINh8YkDKYuvWIfvZnBXqzDMcNfimlyPxz7Xqg8g=;
        b=NhRmPf1ooNhtD8AfKCgf5GHogVhYqIiEEBRqK3l9qxvopheTpDhbE34jNuuPgz2TIN
         lRRvX4OOhP8wRUbN71lRCP4fQiYod42+QAXaDOt3EDCJzbBFPpMUdjjKvaz0zD4F5yP+
         Qjlsz+oJxufHt0W8EsWs3J0DtyL6G3M9gpwXgBPBl9F8Y2rru68Yrqq0/vFuUU462nmG
         7TlkDBsRYn69p77o9hDhpDHlCkeFN6mwOruoik2OkgC/EKB+fP/krI+vzNpJJbeyWPlM
         hyftV8N32KNCGYq46E98FlBhPSEu81UUgTsstj4aBDzdeB1w4VS+Ie3xAhw9T3Dmi7Aj
         xC1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786188363; x=1786793163;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BtuOINh8YkDKYuvWIfvZnBXqzDMcNfimlyPxz7Xqg8g=;
        b=P0TB8S6X9O9wY1A6KFA5LHD6zbq7/JyJdium8JpA62Ay1RnktFufz2EuhoMj/cUfPa
         lC5WgUWb6a5HVfNNTw3h1atqSbZ3v+cxvArfdv2eybl6bSo9WNf0aa7q8O39xIxwelb4
         r1W2Ndickc/6rpv/PFh/ATiu27knXE74FAhT6kChjH3lpyeQFfwKeQ1JJ7dqWjdtK4dO
         8/jVvLi7oW3BLHdhMShl2aYnvkIYMBSX2RUm3jnjFmw5MX+gBeZ7QQfJoanoNOgpK5P3
         U0fmbJ4pqgwFOhxUS2X0ud41Ew9EeOzBj9mcz4pO2LbPPGn9nB+b5VQxIQvd35lcD+gl
         22vQ==
X-Forwarded-Encrypted: i=1; AHgh+RqAgaVfOYsRGYVWgF/wpKWhEExleniGF/tpbce/zp93vjEm0DoNOHOvL2dhpOPhZndPY3t+i1I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw10PhrYcmOij6wNyL733zCB2cCgYrUs8UWTo24ARHQJZLlt/ss
	W1SsohxbDcrlHpdm1a50Pi+TckB2jGCTAhn5N8YFbFf/edkA5EGT4v1z
X-Gm-Gg: AR+sD13MDSuDxG6s2t0AeW65XjFPxhgjAGNg+/MHEYu/QM/KZzmSWh0eUt9opMCw0cj
	mCQiX3Ff1KIcXO03wz7+4yby3JgPR1UF4j5ySWTuYL4it/n99ttdTKZIy7yqDqqDNgwrB/IGeoo
	uTNr1IqDlkecJdT0j+HIL0mmqdNayasJPvJ87ClUdp2Wk4/CRgNNML9IGbLGvkCXGFATxgFRZgX
	EwBMWDxAU93KkamrLZw05k5LBACUcGWmdhmveWX1ncLqIxrR4inXpWTi35TBjm73fl+K5AwdwtE
	xRuVJspJuLXt90Fr+N0+k/a7buG2WKuuPa/Tg6yLgVvd858RGLWTlpUjQ+CaSM3IP1aoSxaNXyP
	XWteUGo28gBxhNrlZ/tZPQYrVixaWXVAb6OtR8dV/fGjxl9oi1v6JKvabZtVbIocm2IcrGUXRcn
	xlr3UxysmOp7scgBn/sQCS1S2daayChRMp8sH6AQ3YbtYam01WhNA=
X-Received: by 2002:a17:90b:1e53:b0:381:a766:efcb with SMTP id 98e67ed59e1d1-3903c54cf2bmr27833795a91.4.1786188363482;
        Sat, 08 Aug 2026 04:26:03 -0700 (PDT)
Received: from lgs.. ([101.36.107.181])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39085dbf82csm8235726a91.1.2026.08.08.04.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 04:26:03 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Sinan Kaya <okaya@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] dmaengine: qcom: hidma: fix autosuspend cleanup during teardown
Date: Sat,  8 Aug 2026 19:25:51 +0800
Message-ID: <20260808112551.2786782-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hidma_probe() calls pm_runtime_use_autosuspend(), but neither the probe
failure path nor hidma_remove() calls the matching
pm_runtime_dont_use_autosuspend() before disabling runtime PM.

If the autosuspend delay is set to a negative value while autosuspend
is enabled, the runtime PM core increments usage_count to prevent
runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
during teardown, this reference is not dropped and usage_count remains
unbalanced.

Add the missing pm_runtime_dont_use_autosuspend() calls to both the
probe failure and remove paths before disabling runtime PM.

This issue was found by manual code inspection.

Fixes: 67a2003e0607 ("dmaengine: add Qualcomm Technologies HIDMA channel driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/dma/qcom/hidma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/qcom/hidma.c b/drivers/dma/qcom/hidma.c
index c939635be21d..78fd765c81e4 100644
--- a/drivers/dma/qcom/hidma.c
+++ b/drivers/dma/qcom/hidma.c
@@ -893,6 +893,7 @@ static int hidma_probe(struct platform_device *pdev)
 		hidma_free(dmadev);
 bailout:
 	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	return rc;
 }
@@ -930,6 +931,7 @@ static void hidma_remove(struct platform_device *pdev)
 
 	dev_info(&pdev->dev, "HI-DMA engine removed\n");
 	pm_runtime_put_sync_suspend(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 }
 
-- 
2.43.0


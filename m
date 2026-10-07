Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2374A2A59
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 12:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791376074; cv=none; b=qZ5pOv2SERBhMaDjOjo6xU/yU3mFVWbYE5JwMvhG23COLqfenCrPnqx/jLO5N+BdN1IngXllXHdTk0ccAF2gc2sCiJonAgmqzekZ5J62joCsZJ0cH68ESQgMdgt7gFni6SwSTX5BiA5L1FJCJ7qnOcNRvJ5GZA+cO6fWvdcqRpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791376074; c=relaxed/simple;
	bh=mrYDL8Jc5kHOxo/uk1bef7rw5P9jwUrrYQcpUUCM5R8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WXpVSX0D1LrXG+GERUrcKJAp06cMOwaWg+mV8jLQjhq2OIIxMBbRAkY4FNiUghWPo06WYwbxk/Ypbkk5dwWkc/C1gHITbYIpbyu7g9d0KX2NBdH0raA6lCkVOqKFyHYsH8P9odoOPxHJvHAWT5tVUXWmfHtv/lFv0otxSBFbpKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BP0pbMui; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BP0pbMui"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3a4c80d3d5aso2072676a91.0
        for <stable@vger.kernel.org>; Wed, 07 Oct 2026 05:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791376062; x=1791980862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BhdLoXtc9kkNzHYF4QrrqBcMnO9w0fLSquEWS/rnbxY=;
        b=BP0pbMui3jhElTXQYCUBTYnSKzfUDgvophxTlHJaVR8OoxUZmgv9iRGW65Z5YmaR8V
         CBitjewxxi9zRnXJ6vjMo6wlBleCVDJA4XBb8jiUyImVGj720iHtox3vYGufseei35xe
         S04u/TNrLygaad0S2y93/kMiTmdjr1BEnvf3WMG+gLSJfnd4rKXksmedeONwHDF4Ypsh
         6yCu1KKM8RuRwN09P2e1Rvmy2wDgXGEFkRopDR9QsYAdjjrI0k72w40aItEtNKfKgpnS
         8JQHYGXlcBDtaexYdjRvZACQhgDxbLMFN9rHmNDnIdqFuzQ061AOJRhn0DpURJEjAdzC
         q1Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791376062; x=1791980862;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BhdLoXtc9kkNzHYF4QrrqBcMnO9w0fLSquEWS/rnbxY=;
        b=SL3X9evogHw3sERnTe/huxe9KbFcerqrLFH5BpwjToYByhEAJFBbcMWyM6sE2G1pCL
         CgnfBACjIU6EeFvTZnxPr5jp6bkC5GnLz3MF7JAT5d9/pN5AQO5HaitWfSYumTD51mD4
         gAzCLCrfelSctGOtCvICC+xpGfQe1/+6DtWvnYqNXjhba0uPbCy0bGo/znZnQ0ASo3Im
         WqniJqlrjP7REd7b6i9dN6aMHNTZ4NurTYLSVKTHo8ZfUhb/pP6914Dq5uVjPXsEPEES
         L9/ImnYAj2ZTpbTGjpctMNIDg2B6vUTAHBmO7pMrPhMZFQAhLeHqI3Oi86qxTsakTyjc
         AzZA==
X-Forwarded-Encrypted: i=1; AKwUvBxWjfbja2jnWLCR368Zym+T4gPwJfp4fH+GRsIcafibzCCaQzs6peLgrNRsmaNWjtowrbjjGKk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJW0jfotjEmSDz0rQxbhSS8CFd4FR7Id5FNdW/0/zvABhleBDup
	Gv9/BW8wCJUMmf6436ChAuixCmn15YcgnoelNWCdI2dSpCkOMuwVZjor
X-Gm-Gg: AYBFou2uvrwTaRYrKNysnps3PXpFx8LFQDEEwFi1bVsVQL4v+g0RrZ4VK32OOgHM93f
	g6GVv+AzZmmVSmdU1dShHkhBfkaN+aE86fQ4OhK92iAaqvqao56lfm9/87nV0bzJAJdiNlQw4Mw
	2HhPb/j+t3OkhA/87HSnPShjrlh5hrb0XYwrfhmvzPYFPseGiBY94Kc5ZEvli9IUb74+BMMYsci
	jz1qOcUxeC1yq1tX/Tflh1k7kvLT3RNid6WvM1LI4TLYgZycqeQ9GiNcOljaIHPrbwARqj1CBms
	OPd/uG8Lel3p+vw186zOg+j297vBuj1yXq5hTLS4CV+i4x0a+WKeSJKSlEF+Wva/WelBhcTxA4I
	OkR7itaoFhGLCqfdg9mHu1uaqntzBGX+yoXXiIDqQPmaV4PDO7tFEEIZe/fNFEYu8e7ywV/PMjO
	bS8j2i0x+Skz+FwFOmSZw1cUiE71GXq6TQo4yKbVXYuewpYwWgudtmZGk=
X-Received: by 2002:a17:90b:2884:b0:3a5:364:dfd with SMTP id 98e67ed59e1d1-3a8a0cd1a2dmr1992504a91.31.1791376061688;
        Wed, 07 Oct 2026 05:27:41 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::8534])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a88eff2146sm6384956a91.10.2026.10.07.05.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 05:27:41 -0700 (PDT)
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
Subject: [PATCH v3] dmaengine: qcom: hidma_mgmt: fix autosuspend cleanup on probe failure
Date: Wed,  7 Oct 2026 20:25:34 +0800
Message-ID: <20261007122534.194286-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hidma_mgmt_probe() calls pm_runtime_use_autosuspend() during probe, but
the probe failure path does not call the matching
pm_runtime_dont_use_autosuspend() before disabling runtime PM.

Add the missing pm_runtime_dont_use_autosuspend() call to the probe
failure path before pm_runtime_disable() so that the autosuspend
setting is properly undone during cleanup.

This issue was found by manual code inspection.

Fixes: 7f8f209fd6e0 ("dmaengine: add Qualcomm Technologies HIDMA management driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v3:
  - Add the missing changelog.

v2:
  - Keep pm_runtime_enable() and explicitly add the missing
    pm_runtime_dont_use_autosuspend() call in the probe failure path
    instead of switching to devm_pm_runtime_enable().
  - Update the commit message to match the actual change.

 drivers/dma/qcom/hidma_mgmt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/qcom/hidma_mgmt.c b/drivers/dma/qcom/hidma_mgmt.c
index 4805ce390ffa..d8c56af5882d 100644
--- a/drivers/dma/qcom/hidma_mgmt.c
+++ b/drivers/dma/qcom/hidma_mgmt.c
@@ -310,6 +310,7 @@ static int hidma_mgmt_probe(struct platform_device *pdev)
 	return 0;
 out:
 	pm_runtime_put_sync_suspend(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	return rc;
 }
-- 
2.43.0


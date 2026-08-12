Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CED33ACA79
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 09:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786525356; cv=none; b=kIPHOD2X1cLKjjIazCqq7O+eB3J/RkzHKs46ZVyZu5M+tD7ayGdeJk1zlgbbP0rpEcULwkQ5SIrbcT3H6mhcsaNcwe0oCCHWbVj+2JmTjEnfh78B9QpcaZNOLcRPV4pBl/uZfDxIcSC9lmLM7JiVnK4KP+uVjh5ZJs4aIzTBUQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786525356; c=relaxed/simple;
	bh=sz7fS+0nqTxp8zreu7IIQFPHWLcP6Vu/M3gDox9nLAI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PwMmPt5UVuVGwRmBSZGY30zlroUBDmZUwwEBYjEedt/JESJmkSX7p3bw/wUtaNfx2v0lFbEp/C3lE7MggS3F/ILghjszuI60j0PavvNPNEPLYZbNAEifZB6M+OwxdmnXdd4WlpaKMECGQ3F4gn68LB6J/TsdXD3ddG+nv4alFlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gLNpQRjF; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLNpQRjF"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38e07ebd263so580535a91.1
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 02:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786525355; x=1787130155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MMJ/zKXjUuezQHEWC5K8ovWuvaNdAhVwEtkYF+SzJVU=;
        b=gLNpQRjFqpZ9rKnNC1cJHYd5f4BXT6ffIIRuMzhP3GyTJD/7ndFfFKDNZ59DeC5l7r
         9INza+Q/y2wTzpW+k4/n5EpgBOJQ5fdD1oeAAhnmjdYLb55VaVckljezkmyn1fD4Vi00
         bFxvRa5Zz/8BFvPRs58IBaU4FKhRHBvb6u6mc5RQ9/jNp/ap+ZREl2AyuQcJDZInffjD
         4f1EwQHO0UnGk2IwEOBsqk4jAniNhQHTXegtjrMelikAMt4I0/w3A/qf8lJaRTbjB+Wj
         7IGWDXIC0mlzoeOgczo1jWPLxAytEPlKZ0wfS4SCy6Az7oBMCLc6xwTHXSZv/EhhvqQP
         z64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786525355; x=1787130155;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MMJ/zKXjUuezQHEWC5K8ovWuvaNdAhVwEtkYF+SzJVU=;
        b=nnkQ23koGBH7IsIOw0YudFfHHBtQSV4Vc3cy2ZOWb93VcWFKW2Morlm8AXJq5576i9
         bQ5mQc+zx+BU3Kd4d+GUl6B7HkHxFhWkuNrZlv05nYn8gA+PTZyuBh/OM4c1BKVteH77
         t/+ZlJt1OphM6cU2vOjqb6crqb+sey7DkerTOtABV6pCQiV5+38h0UIGSQ3yArsvfvmC
         J9DajgNVnYT+x2ScMcsAXIDkMBNbKrKKDu2tsywKtRx+x9gZFNp38DZVRAHKJTHEs8AN
         ceTnK/0xBj+DMz5LEz7LDuKvwg1IsKGXMNMa0XXEdocRpx+StD0pVe4M5B27ViN8kQuN
         /6IQ==
X-Forwarded-Encrypted: i=1; AHgh+RqIejdoOCrgxX203TWCMTt9r+HKLmViXyc60XRfedSM1KufDvaWdq4CQCHAoZOYCXLIiqsXm1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/9WirCbkPWZRaDs8nnTcqM64zaGQeWSaWnNXlCEDUfA5GevSJ
	uqjYaNwkfJ4Pyjo8ELd3iEjsALXZyo8vQg28iXds4uTJqaKyvmVtgGAmoi/21FvHOmE=
X-Gm-Gg: AR+sD11y0rnls99z4yKhmVeosHvzgolEP2rjwK2cEUXE1/NlTfCmDp0GleM0bFfdx2L
	61HQ+U+8uXCEujMiLUCW0Ds9yYqSzwPRFNdSwy1be9L3zHqpop6p5QlzzXObxmjUsoVOmukVL9K
	rUOOVYOtxdBOLF1s8vaKCZvOLOK1AWvEkaJyrZ0UfdBuq5v6eTcH8omnFioQPvc/C7t1Zzv9kNU
	Uj9CtRAwMIDycB4zUV8BppPfttvz0dLc3o1iVCA4qKUb4VqjB+C3qDLgZJTkJZJPID7T3yC4vZi
	OPJUcROjv/VBm7rTxxMUoyI2k7MJv1X0/Zrsvhd+jrtSX23Ogek2BcJd7m/WJF0GBlKombv68PM
	401vKFhLjvTS8rJkYE4peqsxOpsiw0wfikmwpFOFhEtxRpb08U5LPZ+FIIID0bOJXXqC/9wYUr/
	mgkuuYPTaKMA1kN22a7mO6jzOksKFnrhquxcpjJPoZb9mUHhPvNLFGDw==
X-Received: by 2002:a17:90b:3948:b0:383:f52b:d616 with SMTP id 98e67ed59e1d1-393014fa36emr3633374a91.10.1786525354776;
        Wed, 12 Aug 2026 02:02:34 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392f8893709sm2808609a91.4.2026.08.12.02.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 02:02:34 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Gregory CLEMENT <gregory.clement@bootlin.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Wolfram Sang <wsa@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] i2c: mv64xxx: fix autosuspend cleanup
Date: Wed, 12 Aug 2026 16:58:08 +0800
Message-ID: <20260812085808.3313948-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mv64xxx_i2c_probe() calls pm_runtime_use_autosuspend(), but the probe
failure and remove paths do not call the matching
pm_runtime_dont_use_autosuspend() before disabling runtime PM.

If the autosuspend delay is set to a negative value while autosuspend
is enabled, the runtime PM core increments usage_count to prevent
runtime suspend. Without undoing the autosuspend setting during
teardown, this reference is not dropped and usage_count remains
unbalanced.

Call pm_runtime_dont_use_autosuspend() in both the probe failure and
remove paths before disabling runtime PM to properly undo the
autosuspend setting.

This issue was found by manual code inspection.

Fixes: e5c02cf54154 ("i2c: mv64xxx: Add runtime PM support")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/i2c/busses/i2c-mv64xxx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index 1acba628e16c..995b0e9b7f53 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -1069,6 +1069,7 @@ mv64xxx_i2c_probe(struct platform_device *pd)
 exit_free_irq:
 	free_irq(drv_data->irq, drv_data);
 exit_disable_pm:
+	pm_runtime_dont_use_autosuspend(&pd->dev);
 	pm_runtime_disable(&pd->dev);
 	if (!pm_runtime_status_suspended(&pd->dev))
 		mv64xxx_i2c_runtime_suspend(&pd->dev);
@@ -1083,6 +1084,7 @@ mv64xxx_i2c_remove(struct platform_device *pd)
 
 	i2c_del_adapter(&drv_data->adapter);
 	free_irq(drv_data->irq, drv_data);
+	pm_runtime_dont_use_autosuspend(&pd->dev);
 	pm_runtime_disable(&pd->dev);
 	if (!pm_runtime_status_suspended(&pd->dev))
 		mv64xxx_i2c_runtime_suspend(&pd->dev);
-- 
2.43.0


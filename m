Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD1B369D5D
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 11:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786188178; cv=none; b=th2X6fsR0pWdexIQNdFOJzgiqJbMN32YumGAn7oJMHMx+729Z8SkuNBzfmfNDG/l3in9OGy/sqsVCo3V4z7qIRwRv+u5W56nbt/+q90RZrsE3+bZNtUYliM0BnVNSou2p+PL1AvzCw3uWQ0DBceMfWqiAm5iMxppaWiyrEX2RwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786188178; c=relaxed/simple;
	bh=YmTG5vVK/FTTLwiYHkfLbcJlBmEgt7LnpaAC7mAvf8I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oG5K9y6VuFF8BuWtZgX1Tzl4QabiKKypRpDzD7U8dK4Ty1zCA97k6/6NuCtK+BTb4H1W2EeGKzyEdSRluzBC61be1upsyLsOreJrg6/Hv4YaGFZfzt4CGOe1mnspCu2+/06PRkCQ7ijeQ/dvObALqJO924Jcq7PkQes0xWMYEpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ByaBF6Iv; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ByaBF6Iv"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ceaf8a1265so6673645ad.2
        for <stable@vger.kernel.org>; Sat, 08 Aug 2026 04:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786188177; x=1786792977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MEwID2P1yRmU8Feq+ODsi1JwIGprGXNdUwcJktuS+tc=;
        b=ByaBF6Iv7LYHgN28kQY44npWWC3vHDwDY+kSHIWm12IKGjmvgfFjw14t7xqflCi6FP
         cjWbUjwBMuySXxYhNhql9lS5TQ7ql3sM5CZuR9wjm8gn0jnOXTDrkeWFopmt+HJcmcKt
         b8CPYMnKP43GBVhK7aXXqc4sWk3dx0qlP86MXq2AfqG+7XN0ffP869YJwDA3oTrC9X6o
         839TPXdf7bJ0PLT004h3F5O6slPPye8Bj0VH8xS8rWideciyN8y5DVW7uve+TsopUO72
         lirD5HttjqYCj2o3mc+tCBOoWAXr3S/gxquo+c/dtLR5I0GOitaGnmrUU5IQVikjF9WA
         0TFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786188177; x=1786792977;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MEwID2P1yRmU8Feq+ODsi1JwIGprGXNdUwcJktuS+tc=;
        b=TU5hTSPKsMvPhHEwM9fmt8zq8eMymgTgvF0PW7p55SUEWv5tjnhQt8j5yXvU9e5zK1
         mJnpalEW1YUWjdoemmRIsWjueHjq/gSazvLdrWXxx5smeslz5oJjLUsPd80rpAl6FAE6
         zzT1b/R4x+r/b0Nu7WfMVDXqS416AW8khNH8wUZkwHDGOzj+RQWgDLARmAk8PJIMxvyA
         /oPmsDwxtZHs/pDTe51YjwC1NICK9IgV5HgZFMe84zhlw1k7vVfYsUcUuV0Z1WG4Qypo
         8sa6nNYixtg/bhhiL9aOMQxYPC/+CpoTnd+xYzSIqzpTMlMlyz8P7cpyZLDT5ahYZ2K5
         gyJQ==
X-Forwarded-Encrypted: i=1; AHgh+RpJgDkb4L9FwKr0gyA8FLWVp+SohBrgR2SSIe2Tx2iFglfL2jtOWe1J1zxg/s9HV8FG9MB6yfo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNG6bxWpd+KhuY9torblCCswOGugtcxvQPqTRTM3ywtu/txya0
	n+S+/+DJiera4jOEWjbJCN3rZSvjcghhBn+aGo7F1Ep6lA1FoDwyf/61
X-Gm-Gg: AR+sD115Ps6ZEiyYGibKSwwqTxPWaXfY9Lhavfd0vEJD8+vEiCfP1Ii4ZYxsNeZ+2xQ
	pwHGG74of46nMnQANzED/LZJPc3dEHBXau7n73VVCeoa4ui0xh+jgf4buzCmUPmU1lzP2/jXmNw
	YAjuZ2qh+FS8OX2ZpbpRx7ljUQSGp/cyh3TzuvVEvTP+g/sAAyvYpNGHXwhO6C32j5KFMnFRiuX
	PiNdluL0BhBAyxiJ5rcirrDDnPiZrksKbs9Kvp0j7CMHk8SkwerGKSEfKrwNi5WrEkNCprG3Qyf
	A36Xd79yviogD0cthCyK74JT7PhnWMJ8VIdZcBvZ9ZlmN83h4ib8eGqS1lxyYflCVqdEhT3PCKH
	1Bu3lttaP0qO0+o6Qx7gvnVeDyg42hQKwLrzeiqhuNcVQ8seQ1DC2DFeM2KWhAm2Fn4pcKig8Dp
	gvpoH+QScpQDhhuSqbwZHB3dF6aNC0T8yBZ/vK7UrQKxM=
X-Received: by 2002:a17:902:ef4e:b0:2cf:b68a:2050 with SMTP id d9443c01a7336-2d0ca775824mr364281175ad.15.1786188176638;
        Sat, 08 Aug 2026 04:22:56 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d14dbeeda6sm18048745ad.42.2026.08.08.04.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 04:22:56 -0700 (PDT)
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
Subject: [PATCH] dmaengine: qcom: hidma_mgmt: fix autosuspend cleanup on probe failure
Date: Sat,  8 Aug 2026 19:20:43 +0800
Message-ID: <20260808112043.2781244-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hidma_mgmt_probe() calls pm_runtime_use_autosuspend(), but its failure
path does not call the matching pm_runtime_dont_use_autosuspend()
before disabling runtime PM.

If the autosuspend delay is set to a negative value while autosuspend
is enabled, the runtime PM core increments usage_count to prevent
runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
during cleanup, this reference is not dropped and usage_count remains
unbalanced.

Add the missing pm_runtime_dont_use_autosuspend() call to the probe
failure path before disabling runtime PM.

This issue was found by manual code inspection.

Fixes: 7f8f209fd6e0 ("dmaengine: add Qualcomm Technologies HIDMA management driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/dma/qcom/hidma_mgmt.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/qcom/hidma_mgmt.c b/drivers/dma/qcom/hidma_mgmt.c
index 4805ce390ffa..470c88f36d25 100644
--- a/drivers/dma/qcom/hidma_mgmt.c
+++ b/drivers/dma/qcom/hidma_mgmt.c
@@ -168,7 +168,11 @@ static int hidma_mgmt_probe(struct platform_device *pdev)
 	pm_runtime_set_autosuspend_delay(&pdev->dev, HIDMA_AUTOSUSPEND_TIMEOUT);
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_active(&pdev->dev);
-	pm_runtime_enable(&pdev->dev);
+
+	rc = devm_pm_runtime_enable(&pdev->dev);
+	if (rc)
+		return rc;
+
 	pm_runtime_get_sync(&pdev->dev);
 
 	virtaddr = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
@@ -310,7 +314,6 @@ static int hidma_mgmt_probe(struct platform_device *pdev)
 	return 0;
 out:
 	pm_runtime_put_sync_suspend(&pdev->dev);
-	pm_runtime_disable(&pdev->dev);
 	return rc;
 }
 
-- 
2.43.0


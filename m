Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE4B346AC5
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 09:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786182430; cv=none; b=EJB+KZHdIgTcsWFijTMu7FJbGuhi4BnuNrqz1BCEDjM7eXFOIQS3iXxphNYTH35n+axFLRsV8S40jhZB1RbK+fAeno5ypLRdtklh2P0MicBPmMUlAJOTA/cMfUc6P7b4g5V9ifhLJ+uGm9tAhgUixdVxb3NahuX8c57WYSALPno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786182430; c=relaxed/simple;
	bh=n+VHIM10UQAdsOrOgWwVd3HizjL61jNMNdfdNzv9CBg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l4LTvTNVGGhwoHKoWE6QlL9WXQJNLCux1wuZ2/EohCRUsEYe5SZPR5JSyP9gTJCJUhRVygQMnHAT3s3+DnzZdTS5Xm9lNuSM4s/vETzbFrny6DRNq4kZ/9vHFw9c5IJoK0rTQg7D71oZsUJkqP4+6sA9kevDE3cjlF9CQx+CHJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mNPNuTdg; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNPNuTdg"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cbb7926836eso167693a12.3
        for <stable@vger.kernel.org>; Sat, 08 Aug 2026 02:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786182429; x=1786787229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Tyg/k3QHvoAlSDHqgJ9zjC2EsZ+xAbQy3JHE+24858g=;
        b=mNPNuTdg+jbnrMnh5lFO3AtQXsacgAv7WBq0wgfGs0uoej3WdA6v9hWhoIJ0xK13dk
         PI9cdzfmCItvjaEcmguNPOgq+BktK9RZF0mK8W/bAJdzv30w+DDas1dLHtQSyjlfXAE+
         Haapmp3brnJv1Bv4a7hqiRJniSlwyEM3NV9PHesm/w5TBHxECO2XVwfeWTsK4GuXdkV/
         48C0VH4I+pVZ7EWp1EiZy2Y6epvdXBoZ9Sz6nULX3pWK5hjnk9Ih0J2StYVUEEhRSpfq
         UNzJ//3GdhBakHSzFWcjMzZseOM1784W6qCxN/CBzWIydJc+C8TlaKS73zmYyGI5Da+r
         b/TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786182429; x=1786787229;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tyg/k3QHvoAlSDHqgJ9zjC2EsZ+xAbQy3JHE+24858g=;
        b=V5duhkmYR0QT0zIafvAvVdn0tJB2ywh3rCKwJIQmLexitV/1OtBebjZEgFb8khaOH8
         zLwbJmrE9O/LuxS8aL++vDCJxO4Gk0gFVvEH5iCGBzoWWRDl7+u3G5mEwH7Sms8QgqzN
         Oh62h7KOmzFTebFAA/5eUsVLPNaQUw782PU1Opqzoog8C/PoprrsKtuNnnaRrLrMxaHH
         alSzAAjWOSV1V6jrg5zzrCvUN2iidxv2lC7brNQb3y/ICeDJuFXfN8xrzQywyJPUnRjF
         b+bfssNVcxM6GMZU3z9XWnEMAA6op+NBLGMfXIkYhcgkgWCHZ2qY0GFfg/gYQmPt2IQR
         UPWA==
X-Forwarded-Encrypted: i=1; AHgh+RqdV9Bo3L4/VayzYq+jjspSBfQb8C56PoCY0SSVB0hlGgjSDJCj6T2mC6B8aAgXO3haAnEq5S4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypu2FACFsts/9L5xeK/NXyQEXf89OaY5hJTU0oIfW87V3SsA4c
	H0hwbpxx8uqmtEMqm2Ah6SVe26p5IhZkk0iZLNBqiXzpqp17BjTKpba8
X-Gm-Gg: AR+sD13YceriS3p7upQQi7xb3MAXDmCxax1/2sp47XPGLXcsG6piatYXu+ZaZruoeD2
	MebPIQCt4JJ+upsOAN5JbphYVZsVKvygky7KZpq9+xiQJDIR1cT+fde6htSL/8LXdFZlE6MIuNg
	40T6/2n/ER8EaeUiyA76AVveeLbJ9APu0+fXOK80oSjIW5ztuJfO/n2TydzeZ7YknE6cVa/U3MB
	ZXiyEpID8zWa+Z/I5AxQvEqLk6vC3qPbINZlbDqIuVK/Y+qQWZCgFJBlr9qLeapMlBjmlSb7EBt
	sMBT0/1XAf1xxL3w/bpGTVMj4gu3UgmNPZNlkp+z6MLp1nECxl37M9KMiV8W7v9/VKPdV4lVn+B
	BK72m8US7V/xD6lpmHq9h+q7gv+5IglCgGwtvw2MuT5klhLcTqIAxfHg5A+28+t3XebdrvHoh6p
	YcmzsVLBiulr4L5BtAk/amqZPW/gMFFMugVZ+T8OJ4vB0=
X-Received: by 2002:a05:6a00:4b02:b0:847:8acd:747c with SMTP id d2e1a72fcca58-84f2e022980mr30903415b3a.13.1786182429006;
        Sat, 08 Aug 2026 02:47:09 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a51e9fcsm1983113b3a.36.2026.08.08.02.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 02:47:08 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	Ulf Hansson <ulfh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] dmaengine: pl330: fix autosuspend cleanup during removal
Date: Sat,  8 Aug 2026 17:44:52 +0800
Message-ID: <20260808094452.2752443-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pl330_probe() calls pm_runtime_use_autosuspend(), but pl330_remove()
does not call the matching pm_runtime_dont_use_autosuspend() when
removing the device.

If the autosuspend delay is set to a negative value while autosuspend
is enabled, the runtime PM core increments usage_count to prevent
runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
during teardown, this reference is not dropped and usage_count remains
unbalanced.

Add the missing pm_runtime_dont_use_autosuspend() call before restoring
the runtime PM usage reference in the remove path.

This issue was found by manual code inspection.

Fixes: ae43b3289186 ("ARM: 8202/1: dmaengine: pl330: Add runtime Power Management support v12")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/dma/pl330.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 25ba84b18704..8baadd104719 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -3204,6 +3204,7 @@ static void pl330_remove(struct amba_device *adev)
 	struct dma_pl330_chan *pch, *_p;
 	int i, irq;
 
+	pm_runtime_dont_use_autosuspend(&adev->dev);
 	pm_runtime_get_noresume(pl330->ddma.dev);
 
 	if (adev->dev.of_node)
-- 
2.43.0


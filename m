Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA0F38E8CE
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 18:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790878030; cv=none; b=Z5HXM7uQ1whGPhSlJ9pwIUy+lC6BpBxGmeWm4hrU31/aewUf90+JWpyPBWkbM+x0JlffOm5wuzV5yhcRopPmtmYIEvUAz66hAWrm/RsQqSBbze+B2MVN9mYDXu8fDcluWope85uO0Pz4VBHIjiMLxng6EQRh/m3TXiIdEHby5Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790878030; c=relaxed/simple;
	bh=QsCmprxjt2AIVs23Cx9JQTbYtmyYsaQxrbmPDfjmTRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZtLt9Ut5EXvd6q4rX5jxOMpN0uImTAmakN17KRg3IaTzDvnGh1Cw7YX8FnZ0OpsVS3bFAEjeXXziaFG6tDikuii5ujHKg2sXLR6pqChCQUfqbxlVvApkPh5M2lvTVnsP6WOpyI2D7CKkg9KU+b/LrflZ9ba02iCSVJcu0P5PNz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTvBFO5e; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTvBFO5e"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-533324e9b13so7149921cf.1
        for <stable@vger.kernel.org>; Thu, 01 Oct 2026 11:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790878025; x=1791482825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7GPDCUkXzbddkBBz1dYgs3l5YKgPxDZJWy/V/n2BPFU=;
        b=LTvBFO5e4vJnXr0+4FKdBv0Oat3qg3EB/WoQUwBvQCQAebiX0pJvoMZdfxe6HXDPd9
         k52+cEHhSyoE7aht4e6VhyFKo6JyFfrY7fU7a87r0Zd6/2hExFgl/BnHbF5qK7S4kR+O
         ngMiq14OUpvvPHHbXSwf4yUAO7Ys3vrysP3b2hQ88eeL84qLMttCVAicSiMpXPlDc1xQ
         toKjTcDGDtwOGcQKoyJVir4fF5AjjIRL/baKeMzxKvC9izOMAdmNGxsdHEk17fp6zONJ
         w738wU6JdhpJkQo94ne/uKlYX+NxiF8Y2aAawPHu9JhC7m3Xh5ZjHQj6BDRvsQ5YJUfR
         OWWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790878025; x=1791482825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7GPDCUkXzbddkBBz1dYgs3l5YKgPxDZJWy/V/n2BPFU=;
        b=iJ4rQaE5cdXVwh3MJu3WTdcdL1UolMvwDgWmk7fKBg9Knp53DEJoM/mYE2uWAYQq+f
         n4MfpfjCsO+BzuxGGHtVMIjvYeZuKxszPlwPNy1ueeMDfs7l/F7ycGBujWOiRvF1g4Iw
         CZEelbd3VXPZEZ2XXhYo5RNCU0WkagZVg2tP7X0HAVwghzD/Rzqaf06ymuUL/djCkoxc
         ZC+wyAne7xS48ReD3FR/tqILbTPRW7JYBLNV/9pQc4EiqKNk0fCgLVMAl8Otg8RmB6mk
         jSjYLZORPVTD7t0tQPBlORpVevTZ98On616Y3vrZwEv+kScgBk2EKkFM8Z27oFIh6dgr
         oK6A==
X-Forwarded-Encrypted: i=1; AKwUvBzGxaKvq7HbLAfz1tAG90a1gjyttozlcTPIlFbH7tegIO1RdhednJaS3fXRKdAUlww/2nCK0AY=@vger.kernel.org
X-Gm-Message-State: AFuF++mg4iesbO+RvVhxcAJSNneHLjQcp6RFS4oZHCAk130q3X9CqYip
	osZIaUciJDPOuPGpAYSTKTyWboNHm5p2bq8Kgz5Ehi2JGn7Ij0DhDne9Rx1cGMk=
X-Gm-Gg: AYBFou2fmJkTidykk4+EOWUnXfnsGJ1/sJmBOTbHqFqXdZ9Ug952As81jtgjwJYGFJD
	lR6b9ekFLRtGWxTEUQUDp9KI4RjxRe6v4JQM/cdlnjZAaW4F8mn1G7U6zwEPvwdcFcdLi9efZb3
	AuCeBiFK+UKWiScNSbAQOTl35z7WhWj3L0JSBUAv5lAC3SsUEbDJmEDEWSzEwBIpCz6fQRRs9Dz
	Mf0K6hg+6BIcSLUOdtwlrp9giYXc8Mr2QbY09qtVaJCYcXcPwdn4rXBTg5LUPKkwa0mYtuOv+8Q
	jQSey3nrR4avAG74iMgvyVkYAIVr0K0ukONCUlwOlefHTZDgsu6l/3NEZC+KSikfpuMqoo+0yHE
	s3z+n0QQs03o4Vd5DqXgIJhkZvXxDuiEN+4GBuuGhV4DNfbE3l+yFo3SMkLnYVx8ritc6C6TmpH
	zT38TOUDSESCKaQcbfL97ZEwcia5YyHU73IkXFg6fa+maJT9Znse3QLdyxWpFpQpwckLWQ3KXRF
	iDhz1Tp48YEmCBIuO83gljJgyPxAvLQyMAUC04KVIj71BbEvdwz9ol2CqIZCyJCkqmXUA/RTEu5
	MLuLTRQWUGyKLaK2U6021x4BEuc1
X-Received: by 2002:a05:622a:181b:b0:531:85a:25db with SMTP id d75a77b69052e-533832a853cmr71428341cf.11.1790878025154;
        Thu, 01 Oct 2026 11:07:05 -0700 (PDT)
Received: from i4-gl-tmk5904-1.ad.psu.edu ([130.203.156.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53398a5c3fbsm4310221cf.8.2026.10.01.11.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 11:07:03 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>,
	Benoit Parrot <bparrot@ti.com>,
	Hans Verkuil <hverkuil@kernel.org>
Subject: [PATCH v4] media: ti: cal: drain WDMA IRQ before freeing contexts
Date: Thu,  1 Oct 2026 14:07:02 -0400
Message-ID: <ea39fac2402d401d452fe191ac6f9cc1e9e9dfce.1790877910.git.mhun512@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260925191949.3147558-1-mhun512@gmail.com>
References: <20260925191949.3147558-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cal_remove() unregisters the video devices but does not release their vb2
queues. An active stream can therefore keep WDMA IRQs enabled while the
contexts are freed. The managed IRQ is released only after .remove()
returns, so a handler already in flight can access a freed context through
cal->ctx[i].

Use vb2_video_unregister_device() to release each queue and stop any active
stream while the IRQ is still available for DMA stop completion. Then
release the managed IRQ explicitly before destroying the contexts, which
synchronizes any in-flight handler before the context memory is freed.
Drain the IRQ on the probe error path before destroying partially created
contexts too.

Fixes: 343e89a792a5 ("[media] media: ti-vpe: Add CAL v4l2 camera capture driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
Changes in v4:
- Rebase onto the latest media-committers next branch.
- Rewrap devm_request_irq() to stay within 80 columns; no functional changes.
- Compile-test the CAL driver with x86_64 COMPILE_TEST and W=1.

Changes in v3:
- Resend the unchanged patch with intact diff headers.

Changes in v2:
- Rebuilt the mail-ready message; no code changes.

 drivers/media/platform/ti/cal/cal-video.c |  2 +-
 drivers/media/platform/ti/cal/cal.c       | 13 ++++++++-----
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/ti/cal/cal-video.c b/drivers/media/platform/ti/cal/cal-video.c
index 1990cab77344..fdf0b2f2a310 100644
--- a/drivers/media/platform/ti/cal/cal-video.c
+++ b/drivers/media/platform/ti/cal/cal-video.c
@@ -1051,7 +1051,7 @@ void cal_ctx_v4l2_unregister(struct cal_ctx *ctx)
 	ctx_dbg(1, ctx, "unregistering %s\n",
 		video_device_node_name(&ctx->vdev));
 
-	video_unregister_device(&ctx->vdev);
+	vb2_video_unregister_device(&ctx->vdev);
 }
 
 int cal_ctx_v4l2_init(struct cal_ctx *ctx)
diff --git a/drivers/media/platform/ti/cal/cal.c b/drivers/media/platform/ti/cal/cal.c
index 5c82378d1eee..0340e19fe8cb 100644
--- a/drivers/media/platform/ti/cal/cal.c
+++ b/drivers/media/platform/ti/cal/cal.c
@@ -1145,7 +1145,6 @@ static int cal_probe(struct platform_device *pdev)
 	bool connected = false;
 	unsigned int i;
 	int ret;
-	int irq;
 
 	cal = devm_kzalloc(&pdev->dev, sizeof(*cal), GFP_KERNEL);
 	if (!cal)
@@ -1180,10 +1179,10 @@ static int cal_probe(struct platform_device *pdev)
 	cal_dbg(1, cal, "ioresource %s at %pa - %pa\n",
 		cal->res->name, &cal->res->start, &cal->res->end);
 
-	irq = platform_get_irq(pdev, 0);
-	cal_dbg(1, cal, "got irq# %d\n", irq);
-	ret = devm_request_irq(&pdev->dev, irq, cal_irq, 0, CAL_MODULE_NAME,
-			       cal);
+	cal->irq = platform_get_irq(pdev, 0);
+	cal_dbg(1, cal, "got irq# %d\n", cal->irq);
+	ret = devm_request_irq(&pdev->dev, cal->irq, cal_irq, 0,
+			       CAL_MODULE_NAME, cal);
 	if (ret)
 		return ret;
 
@@ -1264,6 +1263,8 @@ static int cal_probe(struct platform_device *pdev)
 	return 0;
 
 error_context:
+	devm_free_irq(&pdev->dev, cal->irq, cal);
+
 	for (i = 0; i < cal->num_contexts; i++)
 		cal_ctx_destroy(cal->ctx[i]);
 
@@ -1294,6 +1295,8 @@ static void cal_remove(struct platform_device *pdev)
 	for (i = 0; i < cal->data->num_csi2_phy; i++)
 		cal_camerarx_disable(cal->phy[i]);
 
+	devm_free_irq(&pdev->dev, cal->irq, cal);
+
 	for (i = 0; i < cal->num_contexts; i++)
 		cal_ctx_destroy(cal->ctx[i]);
 

base-commit: 4a069a763e8a86821edac4159f7c59a20015631b
-- 
2.53.0


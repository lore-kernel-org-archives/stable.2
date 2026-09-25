Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C1C3B14B7
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 18:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790361638; cv=pass; b=t2Ok7kk+XqECUTPNEb6pLwUoc+1z6NL45xveXaFM3/M4Y8rJjCJ/UhfxMCP6R9dh4AuvoH/kiBK62iM2+91/refA8LeTQ+dVGrhnBuRlm3Z8yJUoooC8qoF+/pTLsFFbrETjdYthvn1t20MzZY0PcELdE78GvxU4P9gC2CmJAH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790361638; c=relaxed/simple;
	bh=FiNejKGRyiUCwe8R1xxJKX2+wQwmNmn+OzfcvY/4MWg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=jiCfaQeztSXdxtDF5JVcyd/SpIh4jR3sDKtUv9sxN4+x4HUXx1j39+g2p4kM+yKCsqqZFCAJDtUYOtpDgbz5tcCwn5vyoaScKfVC2DNcZL6lRcOtnL3kJp9DX+eqhyzLKzJoVSpQdxmVh4IGbpBKl8BanVkHkiw3B3eYjj2evoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CufmY5sY; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CufmY5sY"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f55efe7so179007566b.3
        for <stable@vger.kernel.org>; Fri, 25 Sep 2026 11:40:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790361635; cv=none;
        d=google.com; s=arc-20260327;
        b=NQSHBHag1T/ovGFX0dLTk7jX76jV5akwASA1slCEZp1UM6Adu52aPjyrfCeUpSXR0o
         UQQeccys8ApDI3Bh3bynp7E8Z/O/e45vdxvfZzjps2E6XKdN0btt/JagoyPy6lBPv4S2
         zADg5RTSNkQacME2iqMIOf/sY1lITWTOyA6x132s+flTtePvRQ57Wr1zivYAL/o1UzAM
         TKeivn06me9ukptaWOkrSoP8Wv/wSMLQSHZUXCiwZUI3C64vOyViMYZSLxAdsVcgg1jr
         hhaqu2ZZNyTmaT+kq3htY1NvjLF72f6/dfM/kRJ5CDlHKnn7Wn2PdGLk6cVZNqVfK7N+
         oepg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=NhrI3eqIB0Kaock84/1UscB/KDuXvfgtiOh5Tg0ePhk=;
        fh=6TrzuRHG+EBoZRp9Gswb3G5ICGGvXkBxhExHQyNaASo=;
        b=NY2sJUTNm8lZgrzWtOLpxKZyRhi/uesllZW/LSyl7UPPCcPmASlnwVl+2Zr2LW0ezD
         4sdsZTzR0vuJ7qz0VnuLSDxqCSdtBuJp04UTGVJ5ni8y3O4nZHgB4hGUkn200ixwrP62
         M+0HuBbQB8pRzRHK4R5LzkUh6X6qJ6OaW1Mc2wAJqqcyp3eRfYgrnizKSaKCmlYY+tEl
         Sk/us3fa4jUNp9NJGMmyeqb9iaQPZzldg2C6IHfQUMe0xbzTVjC4+Igyy9ylclq4cuji
         8hmou4vUKiAYPP8e13wMKo15Z7mtEDGfk78OfaP5Y7kS989drfSr/Pvtzm657GaQwBm8
         aFAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790361635; x=1790966435; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NhrI3eqIB0Kaock84/1UscB/KDuXvfgtiOh5Tg0ePhk=;
        b=CufmY5sYnj+7bUq02ubUVBiyAQQNpytHXusGXiCFXpbMngNdieVfRvs7hVU7UlAgPR
         dj1XMq7g3UCkXrkw0LHb3SnhRTrC/IiqYobSeSdNVZa/UHRPgfjNN2ToElGdTEqRky+r
         xxatY2Y1ZIMi7xEHsQcgjCJdRoKdfAyp4NOoD5F3ypgRNzroI5Lqwo2w8sfXU8hoGUOU
         y3NuDyEYZUIyNOZR1YizYfQjhGqIvRx1BLPiH7ddHaxxY5HT2GLR6MC2F8aFqaYBSaQd
         2ZKYQb2FUV7I/VeUucetQzxA3sJOlfZAx0lLcg/7Ux02YS7g4LLhFwjkEA/OSZDtV9EA
         3HNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790361635; x=1790966435;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NhrI3eqIB0Kaock84/1UscB/KDuXvfgtiOh5Tg0ePhk=;
        b=1R4CCvWNzq8VYtQEVMldWvvzkEm26NF3o31CVNCXNvukJ1hbyOA4ZlO70BvyqNvs0f
         c4dNt/nS1ylGphc2fDL3wc203CeRAEFStt4erk95iAEeuGmM+IeD269ibkKXtmp9gOXU
         WTxoNdIybUtSft2K/JOSoHtleNKKi3aojaCsJbLI0IEOUBnMz81eocbASKsf78rgKRtz
         zDy667jbda7fQ6Zewk4+IE6PKMn7CXWNxZ6jf8DA35JcRtRATpu4+Jx+4GdhMeFPlsqZ
         DxjUWlAJO0LesM7N0WoJb4X2WPjJp6buAObf6NBzfpYXWqYtKtvKKOJRYUr3D+GyYcTE
         IwCw==
X-Forwarded-Encrypted: i=1; AKwUvBxEAWRBR4QoNnUWlCGH/ncL5qvXHogXu82dKCbGOnr94ffyRaDXZ9GtGpqDRUXd2wOWb8hx1As=@vger.kernel.org
X-Gm-Message-State: AFuF++nr0JC1mgk6ocNFwAPFONCy6qxN0Y5PtrP+PmF+pcA4xxAipY/J
	LejaK4Iox7W5ggsSOlpBvu6wx4/fGRl2u/o8C/Hc6HqeZPzsWrZVdC5n+eZ5hdHHLbaFBWd5Uem
	Xcw9oVAN/TsEQy9wStREODaojI6sy8g==
X-Gm-Gg: AYBFou2F3vH/BwcP0lSyLDonxPaXpXfQDQvD9TCh3jUZ+D/Uk9Js2QKpUNURl9Gjvnn
	nrErTdYBif2SNRDrSNkBLRBFHvRxDXkGCmEflaBRM1cdTPNwG3hV+rYEIKHhTu86R6s/SyLO3TO
	UbkGn06htZyjLDEgtAemDpH4Y4w/jYyi8ehoX0P1TcbujHVyJZxE+4SHpsKsxMTO8mcdziRoUoF
	74Kk7YNdMSnUbvL5tl2yiuwewKwuoGvZU76YuB3ZkWIKDq9b+50TxtcgpcQJrlw8yT8sSKLd9bE
	IuaBeTaCjUZMVbmNx3oSa9qnGGjk525Tzn63KugamauVjIKjrlRzBLBH1pQa8ZzuF4mDLRURWYf
	Tp47t2x9Uu4jFFQ1sDPpr1QI4onFpTmX6yJL6Bl1ffjAWvnn8bE7yNZ8niAWP0SP1
X-Received: by 2002:a17:907:c49a:b0:c25:68c2:7b94 with SMTP id
 a640c23a62f3a-c2ac2374dfamr590694466b.8.1790361635379; Fri, 25 Sep 2026
 11:40:35 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 25 Sep 2026 11:40:33 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 25 Sep 2026 13:40:08 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: mhun512@gmail.com
Date: Fri, 25 Sep 2026 11:40:33 -0700
X-Gm-Features: AclHuK-JxneS-0asoCU3ZT5yM4k7_2whDc5-gQBYj97HQ2HfJZC4wvnWIgixeeE
Message-ID: <CAGEsz8E4t-Gk9AEN6UTSZT4ncCSKCLsXtEEBYTLpVw-d=BdDOg@mail.gmail.com>
Subject: [PATCH v2] media: ti: cal: drain WDMA IRQ before freeing contexts
To: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>, Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
Content-Type: text/plain; charset="UTF-8"

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

Fixes: 343e89a792a5 ("[media] media: ti-vpe: Add CAL v4l2 camera
capture driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
Changes in v2:
- Resend the unchanged diff without mail client line wrapping.

 drivers/media/platform/ti/cal/cal-video.c |  2 +-
 drivers/media/platform/ti/cal/cal.c       | 11 +++++++----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/ti/cal/cal-video.c
b/drivers/media/platform/ti/cal/cal-video.c
index d40e24ab1127..0310dba0c810 100644
--- a/drivers/media/platform/ti/cal/cal-video.c
+++ b/drivers/media/platform/ti/cal/cal-video.c
@@ -1036,7 +1036,7 @@ void cal_ctx_v4l2_unregister(struct cal_ctx *ctx)
 	ctx_dbg(1, ctx, "unregistering %s\n",
 		video_device_node_name(&ctx->vdev));

-	video_unregister_device(&ctx->vdev);
+	vb2_video_unregister_device(&ctx->vdev);
 }

 int cal_ctx_v4l2_init(struct cal_ctx *ctx)
diff --git a/drivers/media/platform/ti/cal/cal.c
b/drivers/media/platform/ti/cal/cal.c
index b7e77b6b8950..d332a05facce 100644
--- a/drivers/media/platform/ti/cal/cal.c
+++ b/drivers/media/platform/ti/cal/cal.c
@@ -1151,7 +1151,6 @@ static int cal_probe(struct platform_device *pdev)
 	bool connected = false;
 	unsigned int i;
 	int ret;
-	int irq;

 	cal = devm_kzalloc(&pdev->dev, sizeof(*cal), GFP_KERNEL);
 	if (!cal)
@@ -1186,9 +1185,9 @@ static int cal_probe(struct platform_device *pdev)
 	cal_dbg(1, cal, "ioresource %s at %pa - %pa\n",
 		cal->res->name, &cal->res->start, &cal->res->end);

-	irq = platform_get_irq(pdev, 0);
-	cal_dbg(1, cal, "got irq# %d\n", irq);
-	ret = devm_request_irq(&pdev->dev, irq, cal_irq, 0, CAL_MODULE_NAME,
+	cal->irq = platform_get_irq(pdev, 0);
+	cal_dbg(1, cal, "got irq# %d\n", cal->irq);
+	ret = devm_request_irq(&pdev->dev, cal->irq, cal_irq, 0, CAL_MODULE_NAME,
 			       cal);
 	if (ret)
 		return ret;
@@ -1268,6 +1267,8 @@ static int cal_probe(struct platform_device *pdev)
 	return 0;

 error_context:
+	devm_free_irq(&pdev->dev, cal->irq, cal);
+
 	for (i = 0; i < cal->num_contexts; i++)
 		cal_ctx_destroy(cal->ctx[i]);

@@ -1298,6 +1299,8 @@ static void cal_remove(struct platform_device *pdev)
 	for (i = 0; i < cal->data->num_csi2_phy; i++)
 		cal_camerarx_disable(cal->phy[i]);

+	devm_free_irq(&pdev->dev, cal->irq, cal);
+
 	for (i = 0; i < cal->num_contexts; i++)
 		cal_ctx_destroy(cal->ctx[i]);

-- 
2.53.0

Received: from mail-ed2-f34.google.com (mail-ed2-f34.google.com [74.125.228.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705BE2D8385
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 01:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790300297; cv=pass; b=cNrLTmM1zQ+mSOqH/5nP+NXAtIrtyQl9YlEVFSDxdi49pY1LCTqrD4d4SABsjI7qpaUoSn5x9kjwEVFw7VnqOUpomEbQv8F9fI2AZSvH7xwjxxEhigQPcpCEAR/bkDIv0TbY4LplNpdnSZh/rsCsLXL6obfW4H5YTpRMXqwoaW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790300297; c=relaxed/simple;
	bh=IgE3L85VZNyjExRPWT1bFYaiSYz8t9f2npqm/uP/Qv0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=dnPmbxKEhUHv0b3IJ0hZex3Sp9vGzKZ2yqoXyV86yOJq5qwtEEWDEdMtGmRTHR/l/zAJOqTp/3tLP9dhOZ6b0w/dQYJjrz+ENj5kfTGHm2VJaTUBHTfQHwh3Jc6qSue+jOUW5eeDw3wiZTEBHQe3itZzbjn3wXrdpsvqhgSiYbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ovviIemP; arc=pass smtp.client-ip=74.125.228.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ovviIemP"
Received: by mail-ed2-f34.google.com with SMTP id 4fb4d7f45d1cf-6aab5dae09fso692018a12.0
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 18:38:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790300293; cv=none;
        d=google.com; s=arc-20260327;
        b=g6MZY+Xaql3znyMd8eYt7jlmgQn3os6dAO7caIZcjkMmlfgNSeRiQJJY3oStYVdCdi
         4G90fNyENfgt9wSHDCQZia0yrMEogDjVv7nfaJ5AYki9uMzxcu44T5EodwUQaVT6/wtJ
         jXi0ENByw4glWjk18zgXKDQKZ0VpDBFB7lrqp5oxkGVPRVFZ5mdb44zZk5rjqu0qXjnS
         cPlR6uy2yqGpAUpy+qHjubqwTTUnvjLvMO5eFQOJ0lX5IPUQ01Y5p89ys0u15ofZevbK
         w93EO3xwuTndiNFtsW6jVkCdGZYiwPkenDo9XbH2ARz/qUX+uPI6X8PricqPejqtDnp+
         k3Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=dhVh9tOhQNfCYcfYyb8o4zaKlezGG/3H4K/sAYxFk2k=;
        fh=CJCVZjxrlujjogyCk1VVCPA7ZBfFrhUk7mQaPw5Qp74=;
        b=UUKD9XK3fYt1mFs3OgmDLKEKxClkfyVxy+TuiPCgaZtBE2USwbDye7ykCjk+bOyogX
         1A4ZQBPUTGWuVVvBhf2MmchLfbFJZf28EYXZkiIkjlO7IS34CGy+CH9THVolw3auTEyH
         8FOCU/T9t2dretcfLx3QJ1An1SnzO6Xbfl2o5euE0wqmDyKnHriowsaIyvLj2rTlqPGK
         vqw42VHHt9QrEa6dvTjzHk2XwEGr6xK/hBIR9sESzUT75z8TkeIYZhpdkIs449y+O2rM
         18qnBo2SoYPzw3qB4ufcgNDRndhqLc14x05nDlt7hqlVVslfn3RprogxDHPCAlK48aYV
         x0nw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790300293; x=1790905093; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dhVh9tOhQNfCYcfYyb8o4zaKlezGG/3H4K/sAYxFk2k=;
        b=ovviIemPqNq2OEojxFDrde1fxj0FSgGwHV2XZyEzcDWdiaXLLPLowEwg5N6hAZMI/T
         EkMCzvD+U3JmA491Y1Dskj5G7W5ee/euuf5AdT8JYmOA2ix3z8HnoSe4zLmsvX90ABwB
         iIGuIo5yNuk3LXTUVyzguhvssmD88EbZsdjzvJyhA4TkG2+SDtxZKbe2tXxsesPUHvOW
         wnczr5U2UULGxVcFsAlENOTn4c0CsR82TxaAFawx62PhvoU+E2JPisYqYMNDKDbU5oAj
         XjrW7t7AXEsGj76iaQqOWMKvHVn94P/jjUH4WIrvB7WQFAf3efNLC9peuLsn1iiytlca
         K9EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790300293; x=1790905093;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dhVh9tOhQNfCYcfYyb8o4zaKlezGG/3H4K/sAYxFk2k=;
        b=SWS+Pjnmh/3A+hNcm2AGb7OeO388NJXh92a6gVn/6nLkX1xLrZ9DEuBa7nc9P/Izau
         IepXS1RmyjEIAROY9MG6sELaNKKBsqEmP9KQ2qk/vdDtNPLcYHyTEqDlF4q0iR4GChvy
         02q0UGLP0Mj2J7rho7TYXnW3w8NKUozHBlw1WGeXlm/TRAnYQMTQBh7ZnGVf8InpYM2x
         RPVIS6e52CjcV3mSC9PT3hc8FTe3XKEPbJx9WkOJ0yNH7jLK9UoEY6M4L810OPTgXBNZ
         Tbi3P7tiWURgSab4P25PJoykiQ5u2PNnsAYJIDogUsnjyyxMFoAaGdzcVOUz3kto9ZIT
         Ag8Q==
X-Forwarded-Encrypted: i=1; AKwUvByugcGycEDnxRxrdXnuYdqxS2sM8HKntMArGIbZ13Ve/igAtt3ukUUZBzrsIFuy/oLBl1RgJFM=@vger.kernel.org
X-Gm-Message-State: AFuF++mJfOZr39G80u73RmtKe+Vi8m+dYiRvXkLPnlCcrihW7RifU9Fy
	2b/0SMYMBMP330Nm8vW4GlQWdtH4NsjXuUe0gGjrls0sSo8N0FiG8xR0FtT0Ni+/IU/ukBUb1cT
	mkjRvHE9D+FpUquEWMSqER74x4kknuw==
X-Gm-Gg: AYBFou1MLcFSEcalRdTq5DWMpWEtBggN/qaFE/p37EH92oIkevthmiHFllsjsb/APRF
	ge09joXaUEvMF1jPg5bGAeB4Bfow3su5dYJ1KYcKg5bUjErLXhYqC/Wu1/lZaHiuGFw+eWkUQvs
	47XKDMeZC3j15hYmnSybINKY3Vgdm8JSrqELwXisCG6ewvuVOFEfPEgmvUHEpja1wVdBCeHHrI6
	/XOgORS/6y9xRAUMDgb5R30byuUYCi7HDZbmpATGjFHylbJ8XEyFGhT2IgPbLhSNz1WMzt3gi4A
	MeTdMwONrH/vNdJVZXBmvLE1nR0a4e7VDtJPczAHaDp6a9krkLMFY/fBlR1m6RtIC6oJEb9EM3m
	xOD3KfvPlYdo6K4a2ZP35F0WYqhrajP3W2Hz5G4A8ShebzhTtGe7qnTmnkmQ6KIO3
X-Received: by 2002:a17:907:9303:b0:c25:6c9a:88bc with SMTP id
 a640c23a62f3a-c2ac2125234mr368494166b.19.1790300292506; Thu, 24 Sep 2026
 18:38:12 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 24 Sep 2026 20:38:11 -0500
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 24 Sep 2026 20:38:11 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: mhun512@gmail.com
Date: Thu, 24 Sep 2026 20:38:11 -0500
X-Gm-Features: AclHuK-Sp2E_5xMXFea2XkNaZh2_few1Y0jiFDEaO81xEPBstSz936VELv6-EK8
Message-ID: <CAGEsz8F9T3MTA5Tj8NuZ0KywR2ZGkNhum4wGmmBQiArfbx8B2w@mail.gmail.com>
Subject: [PATCH] media: ti: cal: drain WDMA IRQ before freeing contexts
To: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>, Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Myeonghun Pak <mhun512@gmail.com>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Ijae Kim <ae878000@gmail.com>
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

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CF1378D88
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 20:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781728447; cv=none; b=npjcJj+i42fjTrdr/xnehCCYHo1Hw+BZlfmELfN+6GXzYxafQfrQtXrB+Iiw7PnwUzo4R5+5u0XG6PyEfzqciEIU6dMgv6gZpo1jmfYRRMXNGN10fuOiN2kjE3ifMW0M6E3d/3wOv3byCOrPpyI6yWFUEhpdFVlfWH97FFys4I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781728447; c=relaxed/simple;
	bh=awkjC44TsMVG3Medmf+mHRA5l5AQMerVQ9Cn7GHY8iI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B11ImEqgRC52iDynj6ercsam8RPz47mEvBxvJgWod/Kv3jWRuLIHJW3PB+XVHiAaRxpyM6PB0h4h8kdJPt0iOYscmGhV6FAmmqyALoMb919CKMtDfTQ0AmkHyfGhbpx7+0t18o/1D+wJBZJITQWH6W5sD6xhi6DrNd614Tnp3TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VmQspUcq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VmQspUcq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A0201F000E9;
	Wed, 17 Jun 2026 20:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781728446;
	bh=TtCsiom9QZoUorwxoF3zDuBjCcrlaPQ5fC0Z/X/BaUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VmQspUcqpe0ZKwB/mOYi0R1c9lCcEtzW2B50tyYfmzH0q6LgCEqtMe3EsM4v5IpJF
	 xZPllZmVgE5PA9wWGjcYpVvdruTDRB0VPAdvCai/HKbKXYwlBBbjK0EgdknNzYHM3G
	 BQ5hjwgwRLi/25FpFfV3KYHmKUYADxgXQAswqGBgpNBXMKfqohbEQ4x10bu6N+kcSy
	 F7IsdN5zKFrIs6/74wsov+cevEZUYOxaS36J/h4WVJmRjPuZGLxCXnz+b2KjB+9uah
	 UEn1DJUn/f+t+eqp77C59Mfv7XrrDpeXxOZNsPV0lqxHJ/vXcaDMshR3v7oy5i26cJ
	 uBWbkFxz6Nc0A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 4/4] slimbus: qcom-ngd-ctrl: Register callbacks after creating the ngd
Date: Wed, 17 Jun 2026 16:34:00 -0400
Message-ID: <20260617203400.334600-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617203400.334600-1-sashal@kernel.org>
References: <2026061507-squishy-ankle-c2e7@gregkh>
 <20260617203400.334600-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>

[ Upstream commit 2a9d50e9ea406e0c8735938484adc20515ef1b47 ]

When the remoteproc starts in parallel with the NGD driver being probed,
or the remoteproc is already up when the PDR lookup is being registered,
or in the theoretical event that we get an interrupt from the hardware,
these callbacks will operate on uninitialized data. This result in
issues to boot the affected boards.

One such example can be seen in the following fault, where
qcom_slim_ngd_ssr_pdr_notify() schedules work on the NULL ngd_up_work.

[   21.858578] ------------[ cut here ]------------
[   21.858745] WARNING: kernel/workqueue.c:2338 at __queue_work+0x5e0/0x790, CPU#2: kworker/2:2/116
...
[   21.859251] Call trace:
[   21.859255]  __queue_work+0x5e0/0x790 (P)
[   21.859265]  queue_work_on+0x6c/0xf0
[   21.859273]  qcom_slim_ngd_ssr_pdr_notify+0x110/0x150 [slim_qcom_ngd_ctrl]
[   21.859304]  qcom_slim_ngd_ssr_notify+0x24/0x40 [slim_qcom_ngd_ctrl]
[   21.859318]  notifier_call_chain+0xa4/0x230
[   21.859329]  srcu_notifier_call_chain+0x64/0xb8
[   21.859338]  ssr_notify_start+0x40/0x78 [qcom_common]
[   21.859355]  rproc_start+0x130/0x230
[   21.859367]  rproc_boot+0x3d4/0x518
...

Move the enablement of interrupts, and the registration of SSR and PDR
until after the NGD device has been registered.

This could be further refined by moving initialization to the control
driver probe and by removing the platform driver model from the picture.

Fixes: 917809e2280b ("slimbus: ngd: Add qcom SLIMBus NGD driver")
Cc: stable@vger.kernel.org
Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
Link: https://patch.msgid.link/20260530204421.116824-6-srini@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 45 +++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 2f92622c29262b..31e17531f3f37a 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1541,6 +1541,7 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct qcom_slim_ngd_ctrl *ctrl;
 	struct resource *res;
+	int irq;
 	int ret;
 	struct pdr_service *pds;
 
@@ -1555,20 +1556,16 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
 	if (IS_ERR(ctrl->base))
 		return PTR_ERR(ctrl->base);
 
-	ret = platform_get_irq(pdev, 0);
-	if (ret < 0)
-		return ret;
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
 
-	ret = devm_request_irq(dev, ret, qcom_slim_ngd_interrupt,
-			       IRQF_TRIGGER_HIGH, "slim-ngd", ctrl);
+	ret = devm_request_irq(dev, irq, qcom_slim_ngd_interrupt,
+			       IRQF_TRIGGER_HIGH | IRQF_NO_AUTOEN,
+			       "slim-ngd", ctrl);
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret, "request IRQ failed\n");
 
-	ctrl->nb.notifier_call = qcom_slim_ngd_ssr_notify;
-	ctrl->notifier = qcom_register_ssr_notifier("lpass", &ctrl->nb);
-	if (IS_ERR(ctrl->notifier))
-		return PTR_ERR(ctrl->notifier);
-
 	ctrl->dev = dev;
 	ctrl->framer.rootfreq = SLIM_ROOT_FREQ >> 3;
 	ctrl->framer.superfreq =
@@ -1590,24 +1587,34 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
 	init_completion(&ctrl->qmi_up);
 
 	ctrl->pdr = pdr_handle_alloc(slim_pd_status, ctrl);
-	if (IS_ERR(ctrl->pdr)) {
-		ret = dev_err_probe(dev, PTR_ERR(ctrl->pdr),
-				    "Failed to init PDR handle\n");
-		goto err_unregister_ssr;
-	}
+	if (IS_ERR(ctrl->pdr))
+		return dev_err_probe(dev, PTR_ERR(ctrl->pdr), "Failed to init PDR handle\n");
+
+	ret = of_qcom_slim_ngd_register(dev, ctrl);
+	if (ret)
+		goto err_pdr_release;
 
 	pds = pdr_add_lookup(ctrl->pdr, "avs/audio", "msm/adsp/audio_pd");
 	if (IS_ERR(pds) && PTR_ERR(pds) != -EALREADY) {
 		ret = dev_err_probe(dev, PTR_ERR(pds), "pdr add lookup failed\n");
-		goto err_pdr_release;
+		goto err_unregister_ngd;
+	}
+
+	ctrl->nb.notifier_call = qcom_slim_ngd_ssr_notify;
+	ctrl->notifier = qcom_register_ssr_notifier("lpass", &ctrl->nb);
+	if (IS_ERR(ctrl->notifier)) {
+		ret = PTR_ERR(ctrl->notifier);
+		goto err_unregister_ngd;
 	}
 
-	return of_qcom_slim_ngd_register(dev, ctrl);
+	enable_irq(irq);
 
+	return 0;
+
+err_unregister_ngd:
+	qcom_slim_ngd_unregister(ctrl);
 err_pdr_release:
 	pdr_handle_release(ctrl->pdr);
-err_unregister_ssr:
-	qcom_unregister_ssr_notifier(ctrl->notifier, &ctrl->nb);
 
 	return ret;
 }
-- 
2.53.0


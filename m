Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D5D1D9663
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 02:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781749153; cv=none; b=rFILIkxmsu/3y72uaZAC0So6YY/yv8QNuqe8nH1AozWT7PFd0E5D7OpBkKqMVb//HlnOleJsWHv7DijU81uM9UArEVekf2wFx7YeFSdXLU7HW1NHqO421mKFdp0R4onNmMTesTBu/Z064KeidDyfZOMr1hpnNC0cSQDF6rw5juw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781749153; c=relaxed/simple;
	bh=PlaAI4+5HDASMXhUHD3tTJ2RfU7BqXX4vWaf5EgEmHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N44o49Y2KYv+Bil09xSZK8umsHXAFyAvyPGuSZ7GIfEYnDcpcGi+t9gOJa8QFYSRQfwKWFwWDDvXASgkdx5oGja+18mYAw2s3JzvOKx6R8IFiThXoz2URlVrgklY+0L+hVEHnUy6gpOJjfohgKE5M2a6OB/w+ZtMB+0HXWayEkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i4LqEGP1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i4LqEGP1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F7FA1F000E9;
	Thu, 18 Jun 2026 02:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781749151;
	bh=lhH9HsgjzX228rCvzoeWO5cdAZVYGYSxR6kLsu09axo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i4LqEGP1ZsrnmqsahT6vgkf8NKlQnLxovehLejliRANV2GsMD2Gw3t/3Occ2qAafe
	 Sritlm7AcZA6am7OcGIrPTJf/tyTbLTyD7UIMZbYeYafaiKPEZHMrmk+gp8VXNNlEG
	 nw9fwwG1TFRyP9dofbNILD+Zew7mYFqLt8uHft7TwqEtqdwSLPKIgSZEHJ29TOyBG+
	 EtZs//G8vRwCP84G9ZJTUqbAar+DRrZHiTBPqi9BpyAVmUG92gtWy0GRfMZGIts6S+
	 KkEiFELmGFKE4iz31WxqXfDyTbX7KY/i9GFMXlGnNGIXTUPRfkFnMr2J6Q5yGMc8X/
	 ldhwUk0tCJyJg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] slimbus: qcom-ngd-ctrl: Register callbacks after creating the ngd
Date: Wed, 17 Jun 2026 22:19:09 -0400
Message-ID: <20260618021909.526569-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061512-swimwear-clinking-3fb7@gregkh>
References: <2026061512-swimwear-clinking-3fb7@gregkh>
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
[ dropped absent PDR/SSR registration block and kept 5.10's `res->start`/`dev_err` IRQ idiom, adding only `IRQF_NO_AUTOEN` plus a deferred `enable_irq(res->start)` after `of_qcom_slim_ngd_register()` ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 8384f55ccd43e3..0c864bb2d4bdb1 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1444,7 +1444,8 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
 	}
 
 	ret = devm_request_irq(dev, res->start, qcom_slim_ngd_interrupt,
-			       IRQF_TRIGGER_HIGH, "slim-ngd", ctrl);
+			       IRQF_TRIGGER_HIGH | IRQF_NO_AUTOEN,
+			       "slim-ngd", ctrl);
 	if (ret) {
 		dev_err(&pdev->dev, "request IRQ failed\n");
 		return ret;
@@ -1468,7 +1469,13 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
 	init_completion(&ctrl->qmi.qmi_comp);
 
 	platform_driver_register(&qcom_slim_ngd_driver);
-	return of_qcom_slim_ngd_register(dev, ctrl);
+	ret = of_qcom_slim_ngd_register(dev, ctrl);
+	if (ret)
+		return ret;
+
+	enable_irq(res->start);
+
+	return 0;
 }
 
 static int qcom_slim_ngd_ctrl_remove(struct platform_device *pdev)
-- 
2.53.0


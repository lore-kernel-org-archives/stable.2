Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66603559E1
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 19:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781724919; cv=none; b=rnfckS9Ew10IdFKfGDGmUPtpiutwKLUPmcN0FpaPgRigm4KrVtWbJfmpuC13FvOvvhHfe0WnPKu5rnhZschM5mdINU20Qr3oMY/yYQrY7W0DzqnSbfiVXImoUV2xvKHNYG1NNCgUzHYDjonwiI/AS0t7r3rO1rTfz9NBWpUGbJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781724919; c=relaxed/simple;
	bh=bVWMwplVbOd5SaWj3xuy6yaBfUYN07YvFXYnHUD/BXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rv6gqD+Hi4mF4aWZTE1HNdC1cJbFPHCiJxoH26P5KFjLO44r/8cJp3eTvekWJN8Ove9IypEqhnphyv5J/vM0WPQt/Q7DGltFkE/S2uvvfsRF5JTjzFxQhH9kKM5pIu4jJ++WpJtuxLB1avpis3IN5tWeYm/YpsZkK0UmShPKNR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QtAA5QY9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QtAA5QY9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 827F51F00A3F;
	Wed, 17 Jun 2026 19:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781724918;
	bh=gdrEc4OWN4xv/tIebu+2Hvs3hs0VlAMq3PrwULwCzX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QtAA5QY9absfNxvA/JRGmKksjiQVuBhlPfjPs4/bJHEEgqo3I8b3riYjMURIBl04Z
	 ppBTOQylNHB+G4ZuyrW4mjbrukml9DRn8yEYQ67PpC+DbiYU+kudAB6ffO25v3DALQ
	 /WvAPCSETjtoIqoJt04Q69wm22XU3U7E0n6v4O2lPXl7ADF+Hvt0a4BaMWD3rClOKW
	 g5s8ZaV5ci1zQPLEwfs8ovthj13gjbCsQLUAGPR6xnQOIxzn0uYHaN8rrfn3LFu4gS
	 3/FpNkByy/yrF6cLvl5MA0BcE/BFjBq127J9w0sZ5tLDPRib04B+r/LELUcQ/JJM8k
	 z9FpBj25bSWDA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] slimbus: qcom-ngd-ctrl: Fix up platform_driver registration
Date: Wed, 17 Jun 2026 15:35:16 -0400
Message-ID: <20260617193516.299894-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061522-crib-retract-1312@gregkh>
References: <2026061522-crib-retract-1312@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>

[ Upstream commit 8663e8334d7b6007f5d8a4e5dd270246f35107a6 ]

Device drivers should not invoke platform_driver_register()/unregister()
in their probe and remove paths. They should further not rely on
platform_driver_unregister() as their only means of "deleting" their
child devices.

Introduce a helper to unregister the child device and move the
platform_driver_register()/unregister() to module_init()/exit().

Fixes: 917809e2280b ("slimbus: ngd: Add qcom SLIMBus NGD driver")
Cc: stable@vger.kernel.org
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
Link: https://patch.msgid.link/20260530204421.116824-3-srini@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 36 ++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index ed1eb491430bac..0fa668f8578d9c 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1474,6 +1474,13 @@ static int of_qcom_slim_ngd_register(struct device *parent,
 	return -ENODEV;
 }
 
+static void qcom_slim_ngd_unregister(struct qcom_slim_ngd_ctrl *ctrl)
+{
+	struct qcom_slim_ngd *ngd = ctrl->ngd;
+
+	platform_device_del(ngd->pdev);
+}
+
 static int qcom_slim_ngd_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1583,7 +1590,6 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
 		goto err_pdr_lookup;
 	}
 
-	platform_driver_register(&qcom_slim_ngd_driver);
 	return of_qcom_slim_ngd_register(dev, ctrl);
 
 err_pdr_alloc:
@@ -1597,7 +1603,9 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
 
 static int qcom_slim_ngd_ctrl_remove(struct platform_device *pdev)
 {
-	platform_driver_unregister(&qcom_slim_ngd_driver);
+	struct qcom_slim_ngd_ctrl *ctrl = platform_get_drvdata(pdev);
+
+	qcom_slim_ngd_unregister(ctrl);
 
 	return 0;
 }
@@ -1676,6 +1684,28 @@ static struct platform_driver qcom_slim_ngd_driver = {
 	},
 };
 
-module_platform_driver(qcom_slim_ngd_ctrl_driver);
+static int qcom_slim_ngd_init(void)
+{
+	int ret;
+
+	ret = platform_driver_register(&qcom_slim_ngd_driver);
+	if (ret)
+		return ret;
+
+	ret = platform_driver_register(&qcom_slim_ngd_ctrl_driver);
+	if (ret)
+		platform_driver_unregister(&qcom_slim_ngd_driver);
+
+	return ret;
+}
+
+static void qcom_slim_ngd_exit(void)
+{
+	platform_driver_unregister(&qcom_slim_ngd_ctrl_driver);
+	platform_driver_unregister(&qcom_slim_ngd_driver);
+}
+
+module_init(qcom_slim_ngd_init);
+module_exit(qcom_slim_ngd_exit);
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("Qualcomm SLIMBus NGD controller");
-- 
2.53.0


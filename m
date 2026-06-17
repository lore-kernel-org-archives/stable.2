Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AD6397339
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 19:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781725856; cv=none; b=hE8HbEwA3Ze+i65/utHM5NKEBZsZFJm1LngfdzHhuh3oDgPMkGAA6JkF3xjJhE/pyBTTrtC4KJfn9brthBZvwYlsC/DSm5ceZLdNz3m36kBHVSfJaEGtOWLnaUycz1wrMqYRGbVuJgWnJ1/qh+JoYCL/3vEhB1a1AnRr7uRbgYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781725856; c=relaxed/simple;
	bh=Yg2yfIIrwTt0VfqXetXh44fveUa4/4bOb2jm1sYMiR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LJRTPUMTfHV4N3QsKWNBZUXjtvyJE7oMbyfGCFkhmup7bVuKS+uhwtuu+bqCcggrvRUYMRYq0n2pBFKPVOZDCXKkkgXPVHBdluyQB3CqJ0TocZO0srhAMi0dOpxAtV8KAwrpDvBy2BDBQsHRZt9ycbRr/bccvM06ZMTyG1iFPKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lMXBDS6g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMXBDS6g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C29D11F000E9;
	Wed, 17 Jun 2026 19:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781725847;
	bh=tsyobPhw7ssHWT43Au8Mn1rCshfkWWW22fu1W/J8GQk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lMXBDS6gTVOObmj0f4Ci1ylGqHmhZsxfmSeajQGs29Ng2VDcrAmy71HC9USGD0EpD
	 8F7ZPTYdiDGrpjykXtOKOi36AbySrx+/6GU3IHkvipp9gbT2SD+bwSz5G7wNRm+KmU
	 7uJfWx2GV/CVCemXk0U6tbBGM5FrsFQN1YOpSQSHWOz8r8lj09dSePI0+RNmvRfV1M
	 FslFYOYrCuo+Ngp2IYKKNRgoDmBTrzsVyGK3B0DDdouAGLpAsijMrJ6ns06hklAswz
	 RxR/Fv6JaDxENxMoU74gpU5kqbwl0tb5ym6HXerESVFBKsz1UgLC4mFbEWOf+NRr9d
	 u8fFtWjyHds6w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] slimbus: qcom-ngd-ctrl: Fix up platform_driver registration
Date: Wed, 17 Jun 2026 15:50:45 -0400
Message-ID: <20260617195045.303749-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061524-synapse-enticing-658a@gregkh>
References: <2026061524-synapse-enticing-658a@gregkh>
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
index 8384f55ccd43e3..4e6c48b023e519 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1382,6 +1382,13 @@ static int of_qcom_slim_ngd_register(struct device *parent,
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
@@ -1467,13 +1474,14 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
 	init_completion(&ctrl->reconf);
 	init_completion(&ctrl->qmi.qmi_comp);
 
-	platform_driver_register(&qcom_slim_ngd_driver);
 	return of_qcom_slim_ngd_register(dev, ctrl);
 }
 
 static int qcom_slim_ngd_ctrl_remove(struct platform_device *pdev)
 {
-	platform_driver_unregister(&qcom_slim_ngd_driver);
+	struct qcom_slim_ngd_ctrl *ctrl = platform_get_drvdata(pdev);
+
+	qcom_slim_ngd_unregister(ctrl);
 
 	return 0;
 }
@@ -1550,6 +1558,28 @@ static struct platform_driver qcom_slim_ngd_driver = {
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


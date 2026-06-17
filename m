Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B3928CF5D
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 20:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781728440; cv=none; b=r/ML0ERpXvR5BCRuecx+/W5HGprp1c1B9Ysm8H7uAJ8O8L0SvrDg+5Pn4vC1QbcMpIs8DDrU1g/ZuVtgAbftfn175OS/aCBinF3CCAKEN7lFJuugm5TkwDwqJcnUaDbhbbQdu4OGfNv+b/+cncpUQxjZ6Y15jvLf2pNNivLgz94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781728440; c=relaxed/simple;
	bh=yv/OAO1hm17vRsQtyncwVgokk9OgH8vnf7MacQ3bM2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H+Gv/3mTo8vHu4SqFP0sT8TTC4n1VVe8WbVCfwZerc6qQdXfkxayA3av/+9kIDDAAovq5NGmld2HOtWGbumHAT0GqhSff73Nel11iUj34VrRpO7cI8lF/N/3PmLirztZBYR9j6R0dtR9grXt70dVe0PD5oluoVlsiFNLNdys+lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mMZ5mX/4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMZ5mX/4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E70C11F000E9;
	Wed, 17 Jun 2026 20:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781728438;
	bh=bNdlfoqtsBMfEuTEBZXui1lzUFRRYvXWdUgkF6AxEBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mMZ5mX/40Z3FKpyiZ5u5bByaQ4UGnA2/b8FuvpzpqbjmTxxvmYHxNaWOuNw1iF9hC
	 UFASpt1qlj+uypryTzBpPk+V3t0sl74Esb9Cwg93Ji+xskm9gG6A82gVqRX4YXURQa
	 Z6JRbTeCpAgaK7xjcQLoCnfTfeD/qPqp8MGXibCcJiEuCXgTfhNWkwfNOUSp8xsm94
	 b8LsO5bAnQkZJxWXEOy3pOTqiSIgdNqVABYbOyHwfypwoAWx4l02iGYLLi8FNVVfh6
	 jwFX5L6O93hHzaKyTD2ALcxbhxSxi49hrMTF3wDx2HBXSn1KPtZnqhxB4xDjO60f8+
	 vo+SdPyG+XfnQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] slimbus: qcom-ngd-ctrl: Initialize controller resources in controller
Date: Wed, 17 Jun 2026 16:33:56 -0400
Message-ID: <20260617203356.334410-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061531-astute-serotonin-a9f5@gregkh>
References: <2026061531-astute-serotonin-a9f5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>

[ Upstream commit 07c564ea5fb859b7381429de935d5df4781947c6 ]

The work structs and work queue are controller resources, create and
destroy them in the controller context. Creating them as part of the
child device's probe path seems to be okay now that the controller's
probe has been updated, but if for some reason the child does not probe
successfully a SSR or PDR notification will schedule_work() on an
uninitialized "ngd_up_work".

Move the initialization of these controller resources to the controller
probe function to avoid any issues, and to clarify the ownership.

Fixes: 917809e2280b ("slimbus: ngd: Add qcom SLIMBus NGD driver")
Cc: stable@vger.kernel.org
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
Link: https://patch.msgid.link/20260530204421.116824-7-srini@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index d0d289c49c8d11..a49aba31bb8de5 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1579,25 +1579,8 @@ static int qcom_slim_ngd_probe(struct platform_device *pdev)
 	pm_runtime_enable(dev);
 	pm_runtime_get_noresume(dev);
 	ret = qcom_slim_ngd_qmi_svc_event_init(ctrl);
-	if (ret) {
+	if (ret)
 		dev_err(&pdev->dev, "QMI service registration failed:%d", ret);
-		return ret;
-	}
-
-	INIT_WORK(&ctrl->m_work, qcom_slim_ngd_master_worker);
-	INIT_WORK(&ctrl->ngd_up_work, qcom_slim_ngd_up_worker);
-	ctrl->mwq = create_singlethread_workqueue("ngd_master");
-	if (!ctrl->mwq) {
-		dev_err(&pdev->dev, "Failed to start master worker\n");
-		ret = -ENOMEM;
-		goto wq_err;
-	}
-
-	return 0;
-wq_err:
-	qcom_slim_ngd_qmi_svc_event_deinit(&ctrl->qmi);
-	if (ctrl->mwq)
-		destroy_workqueue(ctrl->mwq);
 
 	return ret;
 }
@@ -1653,6 +1636,13 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
 	init_completion(&ctrl->qmi.qmi_comp);
 	init_completion(&ctrl->qmi_up);
 
+	INIT_WORK(&ctrl->m_work, qcom_slim_ngd_master_worker);
+	INIT_WORK(&ctrl->ngd_up_work, qcom_slim_ngd_up_worker);
+
+	ctrl->mwq = create_singlethread_workqueue("ngd_master");
+	if (!ctrl->mwq)
+		return dev_err_probe(dev, -ENOMEM, "Failed to start master worker\n");
+
 	ctrl->pdr = pdr_handle_alloc(slim_pd_status, ctrl);
 	if (IS_ERR(ctrl->pdr)) {
 		ret = dev_err_probe(dev, PTR_ERR(ctrl->pdr),
@@ -1674,14 +1664,19 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
 
 err_pdr_lookup:
 	pdr_handle_release(ctrl->pdr);
+	destroy_workqueue(ctrl->mwq);
 
 	return ret;
 }
 
 static int qcom_slim_ngd_ctrl_remove(struct platform_device *pdev)
 {
+	struct qcom_slim_ngd_ctrl *ctrl = platform_get_drvdata(pdev);
+
 	platform_driver_unregister(&qcom_slim_ngd_driver);
 
+	destroy_workqueue(ctrl->mwq);
+
 	return 0;
 }
 
@@ -1695,8 +1690,6 @@ static int qcom_slim_ngd_remove(struct platform_device *pdev)
 	qcom_slim_ngd_enable(ctrl, false);
 	qcom_slim_ngd_exit_dma(ctrl);
 	qcom_slim_ngd_qmi_svc_event_deinit(&ctrl->qmi);
-	if (ctrl->mwq)
-		destroy_workqueue(ctrl->mwq);
 
 	kfree(ctrl->ngd);
 	ctrl->ngd = NULL;
-- 
2.53.0


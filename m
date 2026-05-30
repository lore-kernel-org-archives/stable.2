Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7145435674A;
	Sat, 30 May 2026 20:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780173888; cv=none; b=e2XQfa6P0eM2/ns+U790vktSYSMq47UnrN60EuHXOLoL26Deiw4IPwrhJ7/OH/zzFhmfOp684gOfUa2hYFogz72u47RTAwDdI4cx0qza9r7ROj0Hgu6sjVft/jonhWAVUmT2nQP8NkoW25WwpKA+WFmWbOU75tECTusHi+cK96c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780173888; c=relaxed/simple;
	bh=CUeXb+EQRqJn3qz0QdlxAhotRGuFTT/UWhN1tYXp5/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VGb9u4KjettdgZR0WPYc/kKk/z34wlXxr2zlIc7obD8mvJ3um2O4+aEnnMYeaaxydDVqFFvC3Ps7bR0nBX0B84b4lX3796M8YGgrCwZdSs8guxp8yz4SgLWzD1qQSBlmKl0Ro0wUb3Ywbb9u4j2JV5GYzXnt2Jfxw9YTvKap8tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QlzGyG6Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QlzGyG6Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6435C1F00893;
	Sat, 30 May 2026 20:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780173887;
	bh=xWqtb6BXrhQFlyO2H679UTBEH1X6Z0Um9/yXr+AHT9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QlzGyG6YjWKajhfotP2XcsSftfa8/5uOfn51vOSeTPa3JMS7a/QrB7yUPK9eF3lv6
	 mrlQbZRaBzrln8gnEf5IgQC8ppY6p3/x9fb0RYdRJTcm8/helrBeSLr5eVYyZvsk5S
	 zmB9ewE10LyAJvbEaKlEMJR75vZWyyfShYNB9DXfCIvn30UV5hyhEGG6hP8ULe6bN7
	 CUFBLLxFPWgagjVMQvgCq8pzxk9pgcLhcbYyI7X5nLO8lNv8JkeqG+bFO4RNduc0pN
	 hLwb2hiGKnLv4nAq3EO4+XxIoo0t9Wnzmuvgs2j0ayhQOWZAvWqleeP5c6upodvt/t
	 xJA743tvVm0Dw==
From: srini@kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	stable@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
	Srinivas Kandagatla <srini@kernel.org>
Subject: [PATCH 6/8] slimbus: qcom-ngd-ctrl: Initialize controller resources in controller
Date: Sat, 30 May 2026 21:44:19 +0100
Message-ID: <20260530204421.116824-7-srini@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530204421.116824-1-srini@kernel.org>
References: <20260530204421.116824-1-srini@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>

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
---
 drivers/slimbus/qcom-ngd-ctrl.c | 38 ++++++++++++++-------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index c1f26b7de519..540a62999655 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1582,25 +1582,8 @@ static int qcom_slim_ngd_probe(struct platform_device *pdev)
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
@@ -1653,9 +1636,18 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
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
-	if (IS_ERR(ctrl->pdr))
-		return dev_err_probe(dev, PTR_ERR(ctrl->pdr), "Failed to init PDR handle\n");
+	if (IS_ERR(ctrl->pdr)) {
+		ret = dev_err_probe(dev, PTR_ERR(ctrl->pdr), "Failed to init PDR handle\n");
+		goto err_destroy_mwq;
+	}
 
 	ret = of_qcom_slim_ngd_register(dev, ctrl);
 	if (ret)
@@ -1682,6 +1674,8 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
 	qcom_slim_ngd_unregister(ctrl);
 err_pdr_release:
 	pdr_handle_release(ctrl->pdr);
+err_destroy_mwq:
+	destroy_workqueue(ctrl->mwq);
 
 	return ret;
 }
@@ -1694,6 +1688,8 @@ static void qcom_slim_ngd_ctrl_remove(struct platform_device *pdev)
 	qcom_unregister_ssr_notifier(ctrl->notifier, &ctrl->nb);
 
 	qcom_slim_ngd_unregister(ctrl);
+
+	destroy_workqueue(ctrl->mwq);
 }
 
 static void qcom_slim_ngd_remove(struct platform_device *pdev)
@@ -1704,8 +1700,6 @@ static void qcom_slim_ngd_remove(struct platform_device *pdev)
 	qcom_slim_ngd_enable(ctrl, false);
 	qcom_slim_ngd_exit_dma(ctrl);
 	qcom_slim_ngd_qmi_svc_event_deinit(&ctrl->qmi);
-	if (ctrl->mwq)
-		destroy_workqueue(ctrl->mwq);
 
 	kfree(ctrl->ngd);
 	ctrl->ngd = NULL;
-- 
2.53.0


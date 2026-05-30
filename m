Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1FE309F1D;
	Sat, 30 May 2026 20:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780173884; cv=none; b=WEqCp0J2eBTb5TL/AtfHXw7po5MqO2/KjMfWoWfRD0APZFTlfVjexb3zsRsxkKN7tt5WvDaIHBCpW8RIkNm52Re47nMf/HFFGDjuWOrQ6xZdbIakPeSFyQAv8yJ7EfIojHgbXEHsuZWQghT1wOhNhwLkYofd8Rrbp5n3Fo2wyUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780173884; c=relaxed/simple;
	bh=u6XM7hKaHPXwckuqGRh8vL+dTgQKfFm9qV2kvcLRfao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tHtJTUQy89fvtrUNHI/doKGyLSkwxms1cgLvTjMtD3Q493RsnXps1wzygyjVavAoyoMfAiHUvbi4WYEDcTp0ScuBO7xTw1xDyVjPS8nUkKhLlM2CUqERXLqLkNvxlHIrlc47EfQB2GQcsZhu5RiWHhukc16yS0fQKS0ViK73WEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UVmeCjO7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UVmeCjO7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D53D1F00893;
	Sat, 30 May 2026 20:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780173882;
	bh=/T8dhXk621vfkbt+g3mSKbModVEuj5a9J0/GKx5WfUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UVmeCjO7HAbspYfjpWeayl1emoEooOT4VIGKm/QIXCaubxJdXjR+i66QLmryqiY0U
	 U6LrQs/ytfOKbICgl8dRgQDDIdwhK4H7M1GI99Sz83OQ1nPTHrgky16pznKhSbxMTS
	 EO+j23mTCvqSs8M5Ti1Wsdk/XJfsLsYVs2GBhUuq3/9+be60vp0qA+nnu8Amy1EIw6
	 XHQjic3kSJJKshhzDRrs6QH7HyMPAMMVDyiYmtHh34Kn3AaXSE+YXloAND9Rkkoskw
	 jHWWw/BO2uUpiaKF8A2RbYPk+/H96sczLQJF/mHcfhGZ87v+DGyq0YGuIVCiDP8tYI
	 raGK250qWmExQ==
From: srini@kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	stable@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
	Srinivas Kandagatla <srini@kernel.org>
Subject: [PATCH 4/8] slimbus: qcom-ngd-ctrl: Correct PDR and SSR cleanup ownership
Date: Sat, 30 May 2026 21:44:17 +0100
Message-ID: <20260530204421.116824-5-srini@kernel.org>
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

PDR and SSR callbacks are registred from the controller probe function,
but currently released from the child device's remove function.

The remove() function should only be unwinding what was done in the
same device's probe() function.

Fixes: 917809e2280b ("slimbus: ngd: Add qcom SLIMBus NGD driver")
Cc: stable@vger.kernel.org
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 6b91a6f11cb6..e9238927cd2a 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1683,6 +1683,9 @@ static void qcom_slim_ngd_ctrl_remove(struct platform_device *pdev)
 {
 	struct qcom_slim_ngd_ctrl *ctrl = platform_get_drvdata(pdev);
 
+	pdr_handle_release(ctrl->pdr);
+	qcom_unregister_ssr_notifier(ctrl->notifier, &ctrl->nb);
+
 	qcom_slim_ngd_unregister(ctrl);
 }
 
@@ -1691,8 +1694,6 @@ static void qcom_slim_ngd_remove(struct platform_device *pdev)
 	struct qcom_slim_ngd_ctrl *ctrl = platform_get_drvdata(pdev);
 
 	pm_runtime_disable(&pdev->dev);
-	pdr_handle_release(ctrl->pdr);
-	qcom_unregister_ssr_notifier(ctrl->notifier, &ctrl->nb);
 	qcom_slim_ngd_enable(ctrl, false);
 	qcom_slim_ngd_exit_dma(ctrl);
 	qcom_slim_ngd_qmi_svc_event_deinit(&ctrl->qmi);
-- 
2.53.0


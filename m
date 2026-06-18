Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F2B1D9663
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 02:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781749109; cv=none; b=G0pPNWzEOqKutPk8lokZqKkxRLCaebLXw7GSqGrI8L6cQxBavxMyNRKUVpPaxtN+Dho3k3Nq8hAYd1d+XS+Gz8/2IOAU825KyB7WGdxsvgZ+5z9sDjqx7VFaQViX1A+PmpHLTefCbDwuCltE3c8nnOMl2lXZzCUfjnOUYOq+iSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781749109; c=relaxed/simple;
	bh=Q2iKGAylfR4B3gcPEcRHAzK4ZZCLprv3woYiKr7cXJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BJW/eGjRZq4sVmLXZ9tG/mIEmV1zOCWUQ7EQFND3EhmuOMCueJPtawVpvQzgo/znx0hyXjUvgjCon2io6X1hoG5teuakHKdTilf2/mTK2ynGWI6K7btufODRFT2pZZKwSwWnFHILZpXOCv+YOnCqVH8d4aoBh9RMUbs7dZZpB3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SXbAAGRi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SXbAAGRi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C970F1F000E9;
	Thu, 18 Jun 2026 02:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781749108;
	bh=fyNpDURjICfBv7EO4AxygXbjlqaXsEYNg02AHe8G3EY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SXbAAGRiYsBA5EMhXNXyRc6v/3ASO2S7lf7xE8KjN5nrrJfb2AxTBCBZwC6ea+YNm
	 aOHx0IDFPP3GW5qc0ANd6Ou/bDz57YJJ0ukkgouai2NAEN9hhgvEEYuRCgcxm6rWnr
	 1QIY6srWD+CAjtgBT6tvucHBVTsR8MOWQNGPxOf48Mlzj4srNv6N7FfEd2BJyQutne
	 neJSJNe4bcyeq3CFtaHjnFElIDJaZ1xvU7hcPfsoAyBOfe4UyivEgmq+zkrA+SkUb/
	 cbRDqDbpTrkdTPoMUemrS2/y/eReGea19fDYOh9zsi9dbajiL2tTpMrdu21SI7CBMk
	 czAetT2KueZjQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] slimbus: qcom-ngd-ctrl: Balance pm_runtime enablement for NGD
Date: Wed, 17 Jun 2026 22:18:26 -0400
Message-ID: <20260618021826.525414-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061525-skillet-catfight-64c5@gregkh>
References: <2026061525-skillet-catfight-64c5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>

[ Upstream commit 6a003446b725c44b9e3ffa111b0effbaa2d43085 ]

The pm_runtime_enable() and pm_runtime_use_autosuspend() calls are
supposed to be balanced on exit, add these calls.

Fixes: 917809e2280b ("slimbus: ngd: Add qcom SLIMBus NGD driver")
Cc: stable@vger.kernel.org
Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
Link: https://patch.msgid.link/20260530204421.116824-8-srini@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index d0d289c49c8d11..28484a6735e725 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1581,6 +1581,8 @@ static int qcom_slim_ngd_probe(struct platform_device *pdev)
 	ret = qcom_slim_ngd_qmi_svc_event_init(ctrl);
 	if (ret) {
 		dev_err(&pdev->dev, "QMI service registration failed:%d", ret);
+		pm_runtime_dont_use_autosuspend(dev);
+		pm_runtime_disable(dev);
 		return ret;
 	}
 
@@ -1689,6 +1691,7 @@ static int qcom_slim_ngd_remove(struct platform_device *pdev)
 {
 	struct qcom_slim_ngd_ctrl *ctrl = platform_get_drvdata(pdev);
 
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	pdr_handle_release(ctrl->pdr);
 	qcom_unregister_ssr_notifier(ctrl->notifier, &ctrl->nb);
-- 
2.53.0


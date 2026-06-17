Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286F4376497
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 20:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781729869; cv=none; b=jOek0TD/itYNI8SoSIF9pptk2qgZGONqIVVN4YK2/Z5zYF7BISxIXBxzw7auatZttvgqD/TEMm28KNZPvKImMLQ1LvxN+UGQ/M3O/EbNec2DI/NJOnuezgO7Kr31EKCkh3lmM81G+mZ9KHSKS3W6891BsUHH4KHI7kOwY4961KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781729869; c=relaxed/simple;
	bh=jiigqx9R/p0yuyKfCleRIvz8u/oKcQcZvqVGwiKQZZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NKJUtSJWQHRYgbz6hTYPWm/OdoCYoJiOUkprjIOdlZsOP0djlG+Gsrsna7TQXqAKMNaSzBjkX0wesattdB02Hgaz/GjbbpjfTFcFcW0vMfv9U5vM9cJAAXXeDjcZRaPvekASxdOXMeC4CjenzT/Vzhj2ycOPnN+XFsDEltmlySw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BuophrKT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BuophrKT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6EC51F000E9;
	Wed, 17 Jun 2026 20:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781729867;
	bh=4cDqZfrr1MrvHetebyhBcwFY53DY4g9NUFRQ8kZ3NvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BuophrKTrN/iileTX5lstheMXy7VR7Lz24fJOwMTBVJRRE3+M8ULi1jW4bD85cz6Y
	 Wo8Zq3cVkYD3HLictR/5HcTQKN0H1/B6PpDDBNj6GM/WIMXO+RLb/bp3qmvN3DaUIu
	 kYsy9QoXJMtAZUj1ewrWbpCFsOizhPN+BrEpwKs7vWmg7qhS1FlodHXf+9/CB2cXkB
	 46C8ABsRP/YxM3cpMbjBrKHZe3YzaRF3DwWTb1omx2Gg0SzK7Eb64BgiaJSWQQK57R
	 V5idDQ8QIDbSWN6VIfz7f4yvlOP3qvHs8Xu8Dy4vrREQkF0Y4FaEFtEQ1Vkg3Q9jHA
	 GOhtU7P1T8aTg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] slimbus: qcom-ngd-ctrl: Correct PDR and SSR cleanup ownership
Date: Wed, 17 Jun 2026 16:57:45 -0400
Message-ID: <20260617205745.371338-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061559-egotistic-safeguard-3f23@gregkh>
References: <2026061559-egotistic-safeguard-3f23@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>

[ Upstream commit 960b53a3f76fa214c2fc493734ae7b3c5e713bbf ]

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
Link: https://patch.msgid.link/20260530204421.116824-5-srini@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index d0d289c49c8d11..f928a672f09ea9 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1680,6 +1680,11 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
 
 static int qcom_slim_ngd_ctrl_remove(struct platform_device *pdev)
 {
+	struct qcom_slim_ngd_ctrl *ctrl = platform_get_drvdata(pdev);
+
+	pdr_handle_release(ctrl->pdr);
+	qcom_unregister_ssr_notifier(ctrl->notifier, &ctrl->nb);
+
 	platform_driver_unregister(&qcom_slim_ngd_driver);
 
 	return 0;
@@ -1690,8 +1695,6 @@ static int qcom_slim_ngd_remove(struct platform_device *pdev)
 	struct qcom_slim_ngd_ctrl *ctrl = platform_get_drvdata(pdev);
 
 	pm_runtime_disable(&pdev->dev);
-	pdr_handle_release(ctrl->pdr);
-	qcom_unregister_ssr_notifier(ctrl->notifier, &ctrl->nb);
 	qcom_slim_ngd_enable(ctrl, false);
 	qcom_slim_ngd_exit_dma(ctrl);
 	qcom_slim_ngd_qmi_svc_event_deinit(&ctrl->qmi);
-- 
2.53.0


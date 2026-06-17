Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0F337B019
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 21:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781733057; cv=none; b=JtwrQU/WYd6GmdiNoBjkDmYnrSaFRoCAQhlsMWfD0Bd6M7fL/jZX17G2d6+CeVOzZmjceSLYx0KonaX192o/FCa6biN2dslvlHmbGzx8TgKRkFJdKq86KiowIBqT+ou0F8R2FjgpcNxM8e058gxI6erpXzakjJonCAV+TKkUqxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781733057; c=relaxed/simple;
	bh=svojJFpSYkxhIWCZFAgSTpAqHOgmomrbP+Qni0n1knI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dRbtIvU2fCak0RMCGML9jx2jtwqS40COb8v6JAK+2WJBAMobWcN0S3SRNNZz+TE09qQziXnwWuDSbWRlH8G4d0/C9PzG+fuwAFBpYw49/vF2RELo93NVdYdEpbGuj0xE4w6EbENA8BrxIEOZB2RqDYaTxpb37nkNXePrdhc7Xqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XykXgVzd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XykXgVzd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BD4F1F000E9;
	Wed, 17 Jun 2026 21:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781733056;
	bh=FWYwawkJqjRnQuxbZrvSLKkT+nqe8Tuy1mbDh6m19/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XykXgVzdkFUE1qH1GG3HDXnuVFsimfBgsVystATAuJpP2M+QBSWV3UU0UxEtXQLJm
	 hBMqsQ6lauk6lFSfu9AU6XQzccbe8t3DDB8nNBWoPekbXUtZQqWFGrVGbhKYfKMgt4
	 XsFQ0pDTuNg54OFtxk44M1zLKnz9+pAPUBxl/bKLy8FJLanhO1qSSjz9sAW+o07gsQ
	 PDNKSefhbB3u0Fj2k/m02EciNiO3WpEQ7PrZt+odlppKv3HDcrDZmdap9YryY2YMLa
	 LMRCsJZJUUxLQWmZIuymGimMyiFipMLWnCUBif70Kor4zLYdoqOlnuePD0JSBLjE2o
	 pljJWILlYzPvw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] slimbus: qcom-ngd-ctrl: Correct PDR and SSR cleanup ownership
Date: Wed, 17 Jun 2026 17:50:53 -0400
Message-ID: <20260617215053.417765-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061501-thwarting-hangup-6391@gregkh>
References: <2026061501-thwarting-hangup-6391@gregkh>
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
index 3fa245a472b2ee..b2c62f8218387d 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1609,6 +1609,11 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
 
 static int qcom_slim_ngd_ctrl_remove(struct platform_device *pdev)
 {
+	struct qcom_slim_ngd_ctrl *ctrl = platform_get_drvdata(pdev);
+
+	pdr_handle_release(ctrl->pdr);
+	qcom_unregister_ssr_notifier(ctrl->notifier, &ctrl->nb);
+
 	platform_driver_unregister(&qcom_slim_ngd_driver);
 
 	return 0;
@@ -1619,8 +1624,6 @@ static int qcom_slim_ngd_remove(struct platform_device *pdev)
 	struct qcom_slim_ngd_ctrl *ctrl = platform_get_drvdata(pdev);
 
 	pm_runtime_disable(&pdev->dev);
-	pdr_handle_release(ctrl->pdr);
-	qcom_unregister_ssr_notifier(ctrl->notifier, &ctrl->nb);
 	qcom_slim_ngd_enable(ctrl, false);
 	qcom_slim_ngd_exit_dma(ctrl);
 	qcom_slim_ngd_qmi_svc_event_deinit(&ctrl->qmi);
-- 
2.53.0


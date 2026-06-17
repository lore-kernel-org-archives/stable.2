Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B8B3CEB84
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 21:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781733438; cv=none; b=idF5zqBAOK0kj/NHfzBqB5l/Ob758uc6xzQ6xiEnksgiix/rSGOuHzDWO0wH9X4lfcoCJ9diMiUGz/eIzNBfluzYgDnY9HXsRvRX3nbRTvyuRSI2UT15g9AwVmYln2Ur/F1a4+e/KfkQddpqLuDTwaRAv1mxXDmPY/0HsH8Iwyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781733438; c=relaxed/simple;
	bh=G8rhi/5KHXBCIZkfbqOnzhVsoviyneRXV8lDQQaMw8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jgI+XVMMfguYyoalgbi6diS3ce9frvu8Fb2LcDwgHHiklDvT5DHYYBuH4m/nQZa0APTtPQYNPsYnTC5K6cbHLHnbrR/J0Ijd7aKtVcFMdtBHzPqKY7qrnUZpU3Fy5TGNDyQIC+a3pk13EYCKVIW1fUeGohWKzxljPmoSINRcQy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fxldf8CG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fxldf8CG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B8551F000E9;
	Wed, 17 Jun 2026 21:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781733436;
	bh=KmPDd5LCOrIpto5+tDF57Sbr9IIzqc1zuCnFeMyB0dA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fxldf8CGzzJb+wMUASwg6pNx/zF/O6RXOP7ZtBm4w442nRpOM5Q4v8xW6J+rittjx
	 Rm1sf6SIo/Qs6AZBfH27hytgdE1U946x4O8eG89ktqYdr8aYLd7i9j5RQlCpw67eaq
	 aZvh321Y1PqGvOS37+eju1y6yqoNuSJiWBrNXgTWsu7t+KgtD1X0E83oNiw2FLe+IE
	 8oNYROUJ48mUHkxLmWGydpLA1ziBcOJE78/aJS+2hDB87e6Hxcxh7pGoIhJ3qqslZW
	 1E9bduI7TlVJupd4eNfOx0HjIcsm0TO+vHLJ0S5MD+b5MSX535V6ouFI3lZBPGmJGd
	 bmC4JzveBa3fw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] slimbus: qcom-ngd-ctrl: Correct PDR and SSR cleanup ownership
Date: Wed, 17 Jun 2026 17:57:13 -0400
Message-ID: <20260617215713.425450-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061503-giving-duke-14ef@gregkh>
References: <2026061503-giving-duke-14ef@gregkh>
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
index ed1eb491430bac..771bf915fb0c41 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1597,6 +1597,11 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
 
 static int qcom_slim_ngd_ctrl_remove(struct platform_device *pdev)
 {
+	struct qcom_slim_ngd_ctrl *ctrl = platform_get_drvdata(pdev);
+
+	pdr_handle_release(ctrl->pdr);
+	qcom_unregister_ssr_notifier(ctrl->notifier, &ctrl->nb);
+
 	platform_driver_unregister(&qcom_slim_ngd_driver);
 
 	return 0;
@@ -1607,8 +1612,6 @@ static int qcom_slim_ngd_remove(struct platform_device *pdev)
 	struct qcom_slim_ngd_ctrl *ctrl = platform_get_drvdata(pdev);
 
 	pm_runtime_disable(&pdev->dev);
-	pdr_handle_release(ctrl->pdr);
-	qcom_unregister_ssr_notifier(ctrl->notifier, &ctrl->nb);
 	qcom_slim_ngd_enable(ctrl, false);
 	qcom_slim_ngd_exit_dma(ctrl);
 	qcom_slim_ngd_qmi_svc_event_deinit(&ctrl->qmi);
-- 
2.53.0


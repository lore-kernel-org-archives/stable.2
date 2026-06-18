Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB521EE01A
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 02:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781749814; cv=none; b=m1pUDdabHrFkHH4L5TefLroD0BleCyaxXWJEXRX+eRMZ0F5oZPNtB9Ley4x0NVlnI+x4ICOOEq75scwGBdYIrZzmx3QaZLf7FtODsDLa1AgkjUjY271E+2xBKpyCNDpkeRaVN8DgtXfQb1a68eeYUE+FN/eqKu0SitEXhMPyXG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781749814; c=relaxed/simple;
	bh=X72V4c8liBOYrYITbhx9Ym/xDAXPy3eMnzPJ/UoDObw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qVXUy9BDkwBYNXmoIiziFv4PTmpwWmzVlmLeAxWSEgPYtxA/k4KXGGLt3JymdoJBJyITOkRhkymDRkVkPlpk0A0iRNtZGUEL4NMhlz4ZjEyjx2RM59w4HKPvL+ElLkSvDqdcr6STesz1TTF5TwFgWninCh/+1DK273DTdt+eKTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/1SGRls; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/1SGRls"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EF641F00A3A;
	Thu, 18 Jun 2026 02:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781749812;
	bh=6ZN3iMNPq7qsjkn181CnaLPEJ/WJ30arxIZJEaV+c3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A/1SGRlsJ9d4y0oE8aYGKHNrOHdKASuXJ2pRojMvGtk452hpsZ+AnNGiahTEj+XiD
	 5vF8SMkQ5R+TeHKg3rzBSNzZzSzzd4A8Tekk3zhswdRm89rClPB+DT5vdal4K9OjB0
	 fGBkcradA/PvwU6pF0aEMTp/LFvIrIMuEuqJownW6VH1cBpV8zHEfco2PdRMZEj9z6
	 OlV7m00cuQFDK6B6wflq/opGhQP3oTvpK2pc81VRrKWOx8WIVsK05JkWqhZNrOFyhw
	 vq1fYvUVlXQDFN0bAUegUZcQ0KDFLJaHukrtWPZQzHGxzSkzyVzBgDOuadpzTePipI
	 xRaV8cd4YXNJw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] slimbus: qcom-ngd-ctrl: Balance pm_runtime enablement for NGD
Date: Wed, 17 Jun 2026 22:30:10 -0400
Message-ID: <20260618023010.530701-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061527-mounting-espresso-4f50@gregkh>
References: <2026061527-mounting-espresso-4f50@gregkh>
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
index 3fa245a472b2ee..1722d9fffd9892 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1508,6 +1508,8 @@ static int qcom_slim_ngd_probe(struct platform_device *pdev)
 	ret = qcom_slim_ngd_qmi_svc_event_init(ctrl);
 	if (ret) {
 		dev_err(&pdev->dev, "QMI service registration failed:%d", ret);
+		pm_runtime_dont_use_autosuspend(dev);
+		pm_runtime_disable(dev);
 		return ret;
 	}
 
@@ -1618,6 +1620,7 @@ static int qcom_slim_ngd_remove(struct platform_device *pdev)
 {
 	struct qcom_slim_ngd_ctrl *ctrl = platform_get_drvdata(pdev);
 
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	pdr_handle_release(ctrl->pdr);
 	qcom_unregister_ssr_notifier(ctrl->notifier, &ctrl->nb);
-- 
2.53.0


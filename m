Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD99338D017
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 12:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781787280; cv=none; b=VuAHj8aHhy2Xxftm3gBRabBh85iSX2HEdmN7YMVtTmDqqPbEbB8W7tPYFhapFrjrNf/yj9cWfeKFWhWPGxOR10rRbekbJTnVDwhhVmbQ4WW1DPa/5rasHdvQ1ByTFsf1n6vy79jOnlS+Oku1lOWntMPQRry7k4bfEEkw9jighUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781787280; c=relaxed/simple;
	bh=ebI3gc1+c6gX567jEjdV1PLtsX1v28LC3qFGuxXDcio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VOQjwKce+xmmHiAsZ30p3tLydtrBJVxmfj/OMAMBVhAWKWFwU8A557+p9eoLCelZp/GWww8yMnq80pY+tm7WglMMb3RX/s00vcUho0niNmtD3s+dfz1DxIA+EGvntcms63hq1y4bJnBX/xdv0vg1rucBRNGzKz8mXUlBQvE8mVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gt3J/d+J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gt3J/d+J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E142A1F000E9;
	Thu, 18 Jun 2026 12:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781787279;
	bh=dXuqQ5f8J9SwTnU1WDlNPUtZCH2w8oC8VMhuTnqy1SI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gt3J/d+Ji5MC+Xd51UCHm0JCC5ANG2nBRWHr8D6qaztF8INEGSTdvI2SbLRRo5ZS7
	 gHD/SIJFB2ZJM9+1nrSSlzm9XAo98hPWR7DWhRZbEMSIEIGe8Eof6hfzqV7d0ZF9YK
	 xr/bdshAtePk/IkF+YTD8Cg/rk3q0/ab3+jlR59i/m9iU9RvaMkQ6zcWoHBzkhHyaw
	 2e1NGU4fdQ67wJCQra7OtQkSBuPzsVVwFg/x+SAqQQXarWgSxqeataQL87vrfcSDss
	 cXeMDl+Tn36p4Cjum+/iDseSn5VmtbtbzicUpYhzy01JT6ilFFj2kBty6Xd9UBS9A4
	 xfKFTs8wrblUg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] slimbus: qcom-ngd-ctrl: Balance pm_runtime enablement for NGD
Date: Thu, 18 Jun 2026 08:54:37 -0400
Message-ID: <20260618125437.649402-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061531-grit-reps-1ea2@gregkh>
References: <2026061531-grit-reps-1ea2@gregkh>
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
index 8384f55ccd43e3..113699806367f3 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1399,6 +1399,8 @@ static int qcom_slim_ngd_probe(struct platform_device *pdev)
 	ret = qcom_slim_ngd_qmi_svc_event_init(ctrl);
 	if (ret) {
 		dev_err(&pdev->dev, "QMI service registration failed:%d", ret);
+		pm_runtime_dont_use_autosuspend(dev);
+		pm_runtime_disable(dev);
 		return ret;
 	}
 
@@ -1482,6 +1484,7 @@ static int qcom_slim_ngd_remove(struct platform_device *pdev)
 {
 	struct qcom_slim_ngd_ctrl *ctrl = platform_get_drvdata(pdev);
 
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	qcom_slim_ngd_enable(ctrl, false);
 	qcom_slim_ngd_exit_dma(ctrl);
-- 
2.53.0


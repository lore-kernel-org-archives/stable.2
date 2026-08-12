Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904223655CD
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 10:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786529632; cv=none; b=M9eC9K/S2xCaE9HgEKcsChC3d2Vf9IlpInaaPzzwRCDKGTBztURo57zwybBke7+G/hHRtEjmoSGk5JrQeTysOnZrnhR6PnPQA677ha+bAXd4c6RgtIlZtGBljBNz/6F2CYLIKBBlL/ZuYF242FgS/K6TRdtyZFkhB62vVm9KA4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786529632; c=relaxed/simple;
	bh=Ly9LKwCGsRSjiW5gdTUAG06oYTldfeGyPt2Y7uJpHuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P0LE/DHolJEw+NM1phcos3mK3WT9ctAuvRg/vqkijp71BPtwXwSIWlArVMtp+Fzf9v/LdRMEraCwNyS8Vmo3ZmqvmvMSJ8nAvzf5Xd3VEHgPC2PKIiQgU7d1TR8fwIZXXbuV4EGySunNHLJj5ufDQsvdsQHyHzsq3PFWy9qrH4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3WB9md7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3WB9md7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3A5E1F00A3F;
	Wed, 12 Aug 2026 10:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786529631;
	bh=2tm4Y2dyLJqLsjP0DP+FgVv+J7/1M+e1upwrOSgjAZs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b3WB9md7MHgzP/NwmNA403dWg8REt4s+bFIFtF/NL8s0ooKQZwyCFzorv7W+k6l53
	 KzPIVxJdTS9e83Ckr5hivfqAVHzqCc1u5dnWUad5WO5FKZWYxL6iJ8co+EHwLKGD2W
	 ry1LXezfdKFdBjZO5X61xHRmpRZRMxzHqEjOqyipQdOU1w18tKirQYDEuCdN/xPPko
	 WjEg+lDiURgE0Ji9WoeDRlGpUdE5alQUwWMElZLPVbCuG4cJKYC2aMrkDGOPuqtzhG
	 AXKvPk1tbbUMC3FMHmmxgURSbRdI8tH2RYHEQeePozPuWbsPXhzuYhmCLDO2UD2BlK
	 lbbnGkCT5lxyw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>,
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] i2c: qcom-cci: drop custom suspend/resume and rely on runtime PM helpers
Date: Wed, 12 Aug 2026 06:13:47 -0400
Message-ID: <20260812101347.1638816-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812101347.1638816-1-sashal@kernel.org>
References: <2026080542-curse-dispersed-597e@gregkh>
 <20260812101347.1638816-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>

[ Upstream commit b08c9857aa1f5f3a81d375d6d4bb1d8b92f22ebc ]

cci_resume() unconditionally calls cci_resume_runtime() regardless of
the runtime PM state.

If the device is already runtime-suspended before system suspend,
the clock is re-enabled while runtime_status remains RPM_SUSPENDED.
As a result, pm_request_autosuspend() does not arm the timer,
leaving the clock permanently enabled.

Fixes: e517526195de ("i2c: Add Qualcomm CCI I2C driver")
Signed-off-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
Cc: <stable@vger.kernel.org> # v5.8+
Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Link: https://lore.kernel.org/r/20260625-cci-v1-1-a100cda673ce@oss.qualcomm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-qcom-cci.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index 1afba8b02ad2a..c84c111d1e43f 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -498,24 +498,8 @@ static int __maybe_unused cci_resume_runtime(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused cci_suspend(struct device *dev)
-{
-	if (!pm_runtime_suspended(dev))
-		return cci_suspend_runtime(dev);
-
-	return 0;
-}
-
-static int __maybe_unused cci_resume(struct device *dev)
-{
-	cci_resume_runtime(dev);
-	pm_request_autosuspend(dev);
-
-	return 0;
-}
-
 static const struct dev_pm_ops qcom_cci_pm = {
-	SET_SYSTEM_SLEEP_PM_OPS(cci_suspend, cci_resume)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
 	SET_RUNTIME_PM_OPS(cci_suspend_runtime, cci_resume_runtime, NULL)
 };
 
-- 
2.53.0


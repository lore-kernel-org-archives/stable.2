Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFB51A6813
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 00:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789085738; cv=none; b=epHnLyID6+HEF0kW0TRUJHGeIwt18IQElRFefrEH9FRvB52kIn7uX81lmfN01oUa8R6feYHzc/xzQwAW0U3U50lNTGLsPbGJ7bdFXzfPjRJRGjZgEyyweaNreqS+i0YCrt9JEmW25IO/eIKi/Ii1xq1jPUyM8/PxMjsl/H0qIyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789085738; c=relaxed/simple;
	bh=kpcz0A9l4GmTdPsCKsn49L7xXUy2oafM/a2+8PY4RFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JSJ5+f/7BTe4vNt0KUA4WQPKBsFHBdH191P+X0nDwJmnAtAxddB6D1k2ecJb40n5MQePLdDi19oJzKXoMN661PKljMRjpO8Z63Yl6N8ANFNh023dd4rTIoeyeXHIsC9HilmDmfG8QHEUhYOzPQAuYJTpNa0tCJKkt+nx7fi/j1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eiYKF74S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eiYKF74S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E9D1F00898;
	Fri, 11 Sep 2026 00:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789085736;
	bh=lsQeL7WeYHgjzOp7sfVjZGjvmf9MejCRaSY0QcZ4MzA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eiYKF74SWM7Thj6Zk2oz9C4jMA+rtXnLHfmiqA6tjLjGhMSu2+w2kODzKk8RAwqtH
	 fiZ+Ie8s4uWTATUaia7Q6PLmXDxbizaVjQ6hNsAulEPZP1IgGO2iZ0CTt2r/y3vp38
	 hcGzDUj8k/FFy2HKf/yKq6/Fx98mGs5t5tqjIbVDp4F1r9n04EpgUN76+rlXMIQLBH
	 9568h8yF6oqCoPciX/sB5JhReaFxQ+fQBLP/tvgQarquIRb5bciW9Mo43LTsorMp3t
	 TH1iHOaft+zAk9occBQjI08GzEW8uBQ3x7OUTNaVK8+g9HJaWCBao1VOFhuEAEnni4
	 YaTUGvOCVvapA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 4/4] i2c: qcom-cci: fix autosuspend cleanup
Date: Thu, 10 Sep 2026 20:15:29 -0400
Message-ID: <20260911001529.3302151-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911001529.3302151-1-sashal@kernel.org>
References: <2026090910-covenant-freestyle-77a9@gregkh>
 <20260911001529.3302151-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guangshuo Li <lgs201920130244@gmail.com>

[ Upstream commit f98d4986482151a835b521a734722fe8dc5ca37d ]

cci_probe() calls pm_runtime_use_autosuspend(), but the remove path
does not call the matching pm_runtime_dont_use_autosuspend() before
disabling runtime PM.

If the autosuspend delay is set to a negative value while autosuspend
is enabled, the runtime PM core increments usage_count to prevent
runtime suspend. Without undoing the autosuspend setting during
teardown, this reference is not dropped and usage_count remains
unbalanced.

Use devm_pm_runtime_set_active_enabled() to manage the runtime PM
state. Its managed cleanup disables autosuspend and runtime PM and
restores the suspended state on probe failure and driver removal.
Remove the now redundant manual runtime PM cleanup.

This issue was found by manual code inspection.

Fixes: e517526195de ("i2c: Add Qualcomm CCI I2C driver")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Cc: <stable@vger.kernel.org> # v5.8+
Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Link: https://patch.msgid.link/20260812094425.3515179-1-lgs201920130244@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-qcom-cci.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index e11aa8e495020..31d37deaa026f 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -635,9 +635,11 @@ static int cci_probe(struct platform_device *pdev)
 	cci_init(cci);
 
 	pm_runtime_set_autosuspend_delay(dev, MSEC_PER_SEC);
+	ret = devm_pm_runtime_set_active_enabled(dev);
+	if (ret)
+		goto disable_clocks;
+
 	pm_runtime_use_autosuspend(dev);
-	pm_runtime_set_active(dev);
-	pm_runtime_enable(dev);
 
 	for (i = 0; i < cci->data->num_masters; i++) {
 		if (!cci->master[i].cci)
@@ -653,8 +655,6 @@ static int cci_probe(struct platform_device *pdev)
 	return 0;
 
 error_i2c:
-	pm_runtime_disable(dev);
-	pm_runtime_dont_use_autosuspend(dev);
 
 	for (--i ; i >= 0; i--) {
 		if (cci->master[i].cci) {
@@ -680,9 +680,6 @@ static void cci_remove(struct platform_device *pdev)
 			cci_halt(cci, i);
 		}
 	}
-
-	pm_runtime_disable(&pdev->dev);
-	pm_runtime_set_suspended(&pdev->dev);
 }
 
 static const struct cci_data cci_v1_data = {
-- 
2.53.0


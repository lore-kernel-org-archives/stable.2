Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B035540A7
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 16:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788972487; cv=none; b=g3TepYDvozkVRrtfq3IF109YJCqBOJ4lu+OHS4J94fEEm2vDwfF2B8Vd/JvnYluNXle3Kld3P8x40lyUhC+VCe0z5kbESi4vIgP0Mh0zf72e3iTxLasC8NVSYl+vFWQzkGsU3jumBLFwPejVps/Zoxj5q6QLfxvO8u7N+bNFA5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788972487; c=relaxed/simple;
	bh=n9zpV6s9lrDworis9pqxEwGZCo6RgD2zRqJ5mQLYG0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EPBm3dHz3n17gWuDPSq71PfZRfg88vsOkvZNiNaxWuG0LcY5Yu/38UHr0HLfIKJ+Hud5Ol62QXxzBq70yJnGqvaw5ZzmXYsEDI1ab19S8UuYbvTKswqZpaF097/fe1WaljDjK3ve4e/iBCSe8mUuEetwDz/YlaphuXlwwXJTsLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hsj2l70W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hsj2l70W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07ED11F000FF;
	Wed,  9 Sep 2026 16:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788972484;
	bh=mThecUROLmlAcT79Ieplbbq0duG6aEQFgPm2GBUqhQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hsj2l70WUZ0H1kMRHlicebUNvXKiblrzkNZrMlwHCG8WAoHq43rRgUiCO31Gj3zmB
	 gwfWIHKDmg/TRmDRsPcwOzh2JxF0IdE7jGLzsL+RL0U90y0x1FNv3DM2qmK0Ws5sa1
	 Y0KJYOfpgbHSQ6RdHHhOOQRDpXRMRyp/m5Z+FURAudrZnhUz0IHRqbhOHSkIdXG2iB
	 IsSjFdPvm7CUV9tUZruG70LahVwT+E/1+7yfISXnBEEo2rlq9L7opbZQC+LIBMnlbs
	 bQdlNQivo1GKkfgfEEHY0Yh6ykd03Kt0VaA6oXKZfc4sFCM1UI1pFlxMwh6nxEkwUg
	 I/UYR8qWQsm0g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] power: supply: qcom_battmgr: fix use-after-free
Date: Wed,  9 Sep 2026 12:48:00 -0400
Message-ID: <20260909164800.3092393-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090354-confirm-surface-c832@gregkh>
References: <2026090354-confirm-surface-c832@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Wu <fanwu01@zju.edu.cn>

[ Upstream commit 4e40befedfc8ed86f44e1f81df92d13c149c9f8d ]

qcom_battmgr_pdr_notify() queues enable_work when the PMIC GLINK service
comes up, and the worker recovers battmgr through container_of() to issue
firmware requests. The PMIC GLINK client stays on the client list until
its devres release action runs, so a PDR notification can keep queueing
the work, and a pending or running worker can access battmgr after devres
frees it.

Make enable_work device-managed with devm_work_autocancel(), registered
before the PMIC GLINK client is allocated. The devres cleanup then
releases the client first, so no further notification can queue the work,
and cancels the work before battmgr is freed.

This issue was found by an in-house static analysis tool.

Fixes: 29e8142b5623 ("power: supply: Introduce Qualcomm PMIC GLINK power supply")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Link: https://patch.msgid.link/20260731022006.317192-1-fanwu01@zju.edu.cn
Link: https://patch.msgid.link/20260801051923.354496-1-fanwu01@zju.edu.cn
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
[ added the missing int ret declaration in qcom_battmgr_probe() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/qcom_battmgr.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index 59a19c6d11ec4..d559825538631 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2022, Linaro Ltd
  */
 #include <linux/auxiliary_bus.h>
+#include <linux/devm-helpers.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of_device.h>
@@ -1335,6 +1336,7 @@ static int qcom_battmgr_probe(struct auxiliary_device *adev,
 	const struct of_device_id *match;
 	struct qcom_battmgr *battmgr;
 	struct device *dev = &adev->dev;
+	int ret;
 
 	battmgr = devm_kzalloc(dev, sizeof(*battmgr), GFP_KERNEL);
 	if (!battmgr)
@@ -1350,7 +1352,6 @@ static int qcom_battmgr_probe(struct auxiliary_device *adev,
 	psy_cfg_supply.supplied_to = qcom_battmgr_battery;
 	psy_cfg_supply.num_supplicants = 1;
 
-	INIT_WORK(&battmgr->enable_work, qcom_battmgr_enable_worker);
 	mutex_init(&battmgr->lock);
 	init_completion(&battmgr->ack);
 
@@ -1397,6 +1398,11 @@ static int qcom_battmgr_probe(struct auxiliary_device *adev,
 					     "failed to register wireless charing power supply\n");
 	}
 
+	ret = devm_work_autocancel(dev, &battmgr->enable_work,
+				   qcom_battmgr_enable_worker);
+	if (ret)
+		return ret;
+
 	battmgr->client = devm_pmic_glink_client_alloc(dev, PMIC_GLINK_OWNER_BATTMGR,
 						       qcom_battmgr_callback,
 						       qcom_battmgr_pdr_notify,
-- 
2.53.0


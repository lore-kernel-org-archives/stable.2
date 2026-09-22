Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E695563FCA
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 16:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790095028; cv=none; b=FAM7bDYXqd5temN6C4iHhwLentIuJM1u/ge7jq3XUUJmHpCjovuicLYjIdaknzDIh70C/iREV04PCPdownSRkt0gt6qnJ5B7VbRv+2h6SJGODfWgU+/47warhABNcvChM0UaE4xPfVLUTHoB3tz+87CJK3kB3ydQ34wDcnvUPkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790095028; c=relaxed/simple;
	bh=SIoWBTjZeP+48zqUjEEm3VLLwg8I8h6f5ol13J+qkiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ph8VAsHkHmsVBcS3ivnd1WRgo13rA4xrM4dCCXbDAxbq4hSFncvBL9N6RSE+rUXMawpgmj9mE0YZsba0+GaIqYNWj4EjihlUfZZrS92KS1Lp4XesqYHMkpIS/b6Vl/EDfP46SGzIp+LcUIrQ2xMLnc5bAARKOqHBhVbTz17GMbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kV2IuxHV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kV2IuxHV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 485791F00898;
	Tue, 22 Sep 2026 16:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790095016;
	bh=SyV2wueMb0pT7jSlibdnGZLneAZ0EYXI/WhKLc3QyBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kV2IuxHVVTTu2Q+IyqDO2VOpu1YuILYn7V6dKYx/b3Zl8wQtJVn57L96jTw2j3bW1
	 N5RrvyzUvZ+B38gAZnFvcTw4NCQO1S6IMRH7B1GA3raxHBdHDKSnXL24DZ0mGLjW2c
	 y/mKNjkWETVKRlMPGNRw3+e6QX1jHy1t7ICgwskDZqPHyR5r8+K4AiUZMG6451hhCy
	 CELuqiGOxg2AHiYXkawc/9VrbbhIxmVkIIoviuiPGwN0hzEZ3B1RMgJ14la8ehzzeU
	 mmgfKvZmy4h8AXlwjFEzUM38HiTgrs8ap+M4e7vADp2ObHU6e+tEnjoHBWpMJYOng0
	 ocfKC1aE3kMEg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Liu Zhenlong <dragonliu2018@gmail.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] i2c: qcom-cci: fix device_node refcount leak in cci_probe()/cci_remove()
Date: Tue, 22 Sep 2026 12:36:52 -0400
Message-ID: <20260922163652.3066989-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922163652.3066989-1-sashal@kernel.org>
References: <2026092210-vacation-hangnail-e82f@gregkh>
 <20260922163652.3066989-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Liu Zhenlong <dragonliu2018@gmail.com>

[ Upstream commit 7362a1553eb09a8cdf8be7e509bd5309a8342486 ]

The of_node_put() matching of_node_get() runs after i2c_del_adapter(),
whose trailing memset() zeroes adap->dev and thus adap->dev.of_node,
making the put a no-op and leaking the node on every adapter removal
and error cleanup.

Use a devm action: the pointer is captured at registration, out of
reach of that memset(), and devres runs the put once on probe failure
and detach, replacing the three manual of_node_put() calls.  The
setup loop uses the scoped iterator form so the child node is released
automatically if devm_add_action_or_reset() fails mid-loop.

Suggested-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Fixes: 02a4a69667a2 ("i2c: qcom-cci: don't put a device tree node before i2c_add_adapter()")
Assisted-by: Claude:claude-opus-5
Signed-off-by: Liu Zhenlong <dragonliu2018@gmail.com>
Cc: <stable@vger.kernel.org> # v5.17+
Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Link: https://patch.msgid.link/20260818175750.4205-1-dragonliu2018@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-qcom-cci.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index 87a4c2d0ee9cd..c0309bf61595b 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -520,10 +520,14 @@ static const struct dev_pm_ops qcom_cci_pm = {
 	SET_RUNTIME_PM_OPS(cci_suspend_runtime, cci_resume_runtime, NULL)
 };
 
+static void cci_put_of_node(void *data)
+{
+	of_node_put(data);
+}
+
 static int cci_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *child;
 	struct resource *r;
 	struct cci *cci;
 	int ret, i;
@@ -539,7 +543,7 @@ static int cci_probe(struct platform_device *pdev)
 	if (!cci->data)
 		return -ENOENT;
 
-	for_each_available_child_of_node(dev->of_node, child) {
+	for_each_available_child_of_node_scoped(dev->of_node, child) {
 		struct cci_master *master;
 		u32 idx;
 
@@ -560,6 +564,9 @@ static int cci_probe(struct platform_device *pdev)
 		master->adap.algo = &cci_algo;
 		master->adap.dev.parent = dev;
 		master->adap.dev.of_node = of_node_get(child);
+		ret = devm_add_action_or_reset(dev, cci_put_of_node, child);
+		if (ret)
+			return ret;
 		master->master = idx;
 		master->cci = cci;
 
@@ -631,10 +638,8 @@ static int cci_probe(struct platform_device *pdev)
 			continue;
 
 		ret = i2c_add_adapter(&cci->master[i].adap);
-		if (ret < 0) {
-			of_node_put(cci->master[i].adap.dev.of_node);
+		if (ret < 0)
 			goto error_i2c;
-		}
 	}
 
 	return 0;
@@ -644,10 +649,8 @@ static int cci_probe(struct platform_device *pdev)
 	pm_runtime_dont_use_autosuspend(dev);
 
 	for (--i ; i >= 0; i--) {
-		if (cci->master[i].cci) {
+		if (cci->master[i].cci)
 			i2c_del_adapter(&cci->master[i].adap);
-			of_node_put(cci->master[i].adap.dev.of_node);
-		}
 	}
 error:
 	disable_irq(cci->irq);
@@ -665,7 +668,6 @@ static void cci_remove(struct platform_device *pdev)
 	for (i = 0; i < cci->data->num_masters; i++) {
 		if (cci->master[i].cci) {
 			i2c_del_adapter(&cci->master[i].adap);
-			of_node_put(cci->master[i].adap.dev.of_node);
 			cci_halt(cci, i);
 		}
 	}
-- 
2.53.0


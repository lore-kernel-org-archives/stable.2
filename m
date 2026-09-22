Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40951479882
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 17:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790099767; cv=none; b=MpYKQ1+XsB/f8QnlsL08mjRf+HHgor8DqmDC+4X5WIC+t0z4L1FyyMAbw3LggWxPgjyPgoC/09vG5NhX5jvenqG51J7N76y81YF+guVkhJG9k2ULj0gHR+nAxEmWzv1iwf0nElFb1Ph/7wSJD+NaGvKmREd6LHdgLqhGXE6S7lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790099767; c=relaxed/simple;
	bh=WbyaNiBJFFgMqTWDu0E7UIykZJNSl8nmvkkKE0LPb28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DCeqINgpz93ov3vmxaKmYU2CrTK4fgu8kvilWXm7dZOvCM3IFhGb+U1IW+U6yWhH/kBJh/UzkVWnN9OrQZMXhggbkG/ERo1m7HvpzfMQ0NPHPOJi2q+k5YlPV7Jt8/i4Y5kNbm1yevZu/fAjA8zClOQTEQZ92EbA055qANmgpM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8I7Z+sD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8I7Z+sD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A43B1F0089A;
	Tue, 22 Sep 2026 17:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790099766;
	bh=bJCEH7eT418p+P+p9pRIFDl3KLlKCaQGGxiGfxYwuOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d8I7Z+sDbtH2XjE1qadFRdfvhNq0LsJKOjveKmpA/EAL6jr0kWlYKr8RpdSOZvJ7d
	 zZ0UMBlFNPM+OpVOj86Mv8dohIfpiaoeODZMM7cB0zlDLjpe8jV+7TlJG6ASbzhaWK
	 kEwdrVS0Aa977QEXbsKyJVizquRkotPp6LeIOKtu+d6GrVzkd3W7zK7gWCeLPzf31m
	 Th9qSk9CIOz7tdmok4RVSJH3hO1GAb3hUuiLXxfsfOZpOSIW4A7jA7MoI+hnyLiI5I
	 5uYkKMCk2oJWfeYrwO+3qT0gi0ALcwDm3/CIHy3xpc6jTT3L16Dp6iY/fjKuOVNaN+
	 3VKDZGdM6iT1w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Liu Zhenlong <dragonliu2018@gmail.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 4/4] i2c: qcom-cci: fix device_node refcount leak in cci_probe()/cci_remove()
Date: Tue, 22 Sep 2026 13:56:01 -0400
Message-ID: <20260922175601.3321063-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922175601.3321063-1-sashal@kernel.org>
References: <2026092212-macarena-tidings-7d83@gregkh>
 <20260922175601.3321063-1-sashal@kernel.org>
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
[ Replaced the scoped iterator with the existing iterator and a function-scoped cleanup variable for GNU89 compatibility. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-qcom-cci.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index 8c9ad30d7364c..501fa9161bbb9 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -520,10 +520,15 @@ static const struct dev_pm_ops qcom_cci_pm = {
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
+	struct device_node *child __free(device_node) = NULL;
 	struct resource *r;
 	struct cci *cci;
 	int ret, i;
@@ -558,6 +563,9 @@ static int cci_probe(struct platform_device *pdev)
 		cci->master[idx].adap.algo = &cci_algo;
 		cci->master[idx].adap.dev.parent = dev;
 		cci->master[idx].adap.dev.of_node = of_node_get(child);
+		ret = devm_add_action_or_reset(dev, cci_put_of_node, child);
+		if (ret)
+			return ret;
 		cci->master[idx].master = idx;
 		cci->master[idx].cci = cci;
 
@@ -631,10 +639,8 @@ static int cci_probe(struct platform_device *pdev)
 			continue;
 
 		ret = i2c_add_adapter(&cci->master[i].adap);
-		if (ret < 0) {
-			of_node_put(cci->master[i].adap.dev.of_node);
+		if (ret < 0)
 			goto error_i2c;
-		}
 	}
 
 	return 0;
@@ -644,10 +650,8 @@ static int cci_probe(struct platform_device *pdev)
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
@@ -665,7 +669,6 @@ static int cci_remove(struct platform_device *pdev)
 	for (i = 0; i < cci->data->num_masters; i++) {
 		if (cci->master[i].cci) {
 			i2c_del_adapter(&cci->master[i].adap);
-			of_node_put(cci->master[i].adap.dev.of_node);
 			cci_halt(cci, i);
 		}
 	}
-- 
2.53.0


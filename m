Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7FA429037
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 17:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790099473; cv=none; b=LCLqyrhc+EaKfh9kTIjr31a8KqcSo97Foy5bvVXoKfzzeTb32oeM0oJdhmIdkMqAMDqdLxJUf9zqRR3gZp2/OpjSDll2eULY4qpWh7CqSi1JotDU996pmWucihjZnrZ6qfgl2TI8sARGVCG8v2SuB4d//YpS7HzcvaOn2N9T5Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790099473; c=relaxed/simple;
	bh=BH3jF+WgspXQGe8CoFzz+lPRrKrT28pFPTIiCDUa8RM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NUC8AgoWK03myjvNnXLaSx6K+23/n88G7wGVfUWfQQgyPCXViH/LE069bKaCxED3kJ/L9usMetv9M/pPUC/Svarr7+4MoU4l7wehSnVlIr9NTdsbEes09pZqDcrbAfIxwmfI0R4AxAGRriBUPe3lUrcanlcxqi3dQIcGf033F4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKC7DUtZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKC7DUtZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A591F00893;
	Tue, 22 Sep 2026 17:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790099471;
	bh=uQdGmLPkGYEWCTpKfVlT1HoOkiTfd4cvXDKvhJyGLNs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AKC7DUtZ9P0RV7Zj1fq1b4fqon8LDfEOSP2e4/AQXDIcf9U6+AvhMODRRVYVeOn7N
	 d+bxNijVeVETYQvQc+xdjQKBwoSCIHRdK1/1wuedImNyir2sl8+IGTVt1YKyWi/nLZ
	 x1aFH9EDOHlKwp6fGiXa5f12QT2EWrdt++pMx1D5vpAc+zPvM6lf/y9hubHAYtdo7U
	 oidWa2IwH9oCc+tu0+IvR7OgT+tUocAuZauX61hbuFdCi8jM2ThPrnNNG9xX1wqAme
	 yF+7T9Br/p/7ny/awHOE0djG5czlZDzpWvQhKpWPSdKH0P0874NjotwxkQlIZjvosA
	 u+FPVmf0kRJ2g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Liu Zhenlong <dragonliu2018@gmail.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 4/4] i2c: qcom-cci: fix device_node refcount leak in cci_probe()/cci_remove()
Date: Tue, 22 Sep 2026 13:51:06 -0400
Message-ID: <20260922175106.3308111-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922175106.3308111-1-sashal@kernel.org>
References: <2026092212-fruit-deploy-01d6@gregkh>
 <20260922175106.3308111-1-sashal@kernel.org>
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
index 6a4d8a546fa75..f3af3a14d2b57 100644
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


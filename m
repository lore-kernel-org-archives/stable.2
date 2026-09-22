Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDF45632A5
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 16:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790095024; cv=none; b=QUi49xOgAAZJt50G0RWg5wntArJtSZHTf5KrdPZRbxwEH/xmeyYLIHbXv32G/ln3PSllqqhccQPKBiFcrNKwXXBvCdfdBVoyknUMgz8wskluWpqnPHYf0iuSwGqiTV/J6RnUbammhldjTrsHrQNlgUuOebKpnmfm+0YALs+rZys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790095024; c=relaxed/simple;
	bh=h+ZUiWqjzo1ersmTGVzrWOag+RXzrQGzXRIfjbU3/tI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S3uerDFhDDS8P1l3Lxs71tlTjDuZVwtvCvfFP3V4U1c/ajAjzKIrrpK/ZgUATXDYnJcraY/IoP2K+IAs+q1TgkX2GyNd2q8aEsHpU2IJSMPmIR908Xe2cTiFzrmaac80p6XQdBK8MwJ8GTgOcJuO+6lC/DD6RO7kQRzVX+ID3k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iaOnUutC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iaOnUutC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 475FE1F00899;
	Tue, 22 Sep 2026 16:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790095016;
	bh=oHfGmlvMlNVTIe8wF3x3arMgd86YKS3R5x73xBsXo3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iaOnUutCSTrEi1W9mq96l/jj6uADdS5FcMO5lC2gvD13Ba5lsPReFQPsONbHbC6jN
	 JC8/0CYciBsSDJ6bhyaQrmm1p7TMeuMI7si3ix2lloySzWVVBqUXhnGDQBplRqrIKG
	 xxzOM4llPKw4c0wVXzdpWPMATmqwcS4B6eN+h7xxgl0injdjjJr6XeAJm4lV4Q9KUO
	 PxFKdwhYGqwoiCVej1Jj4Me90nduYOsb2Dl5JMEDLrZ9lGTyl7xrZ/U+VVIn2JN9TP
	 DpWaHdeTR6pv1W4VvcO2PY/UAPZv75nnAFRSKj2ZpZ3VbHATqAlHTPWdSOB1cAg/Jn
	 BIdyhQz6Szm0w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] i2c: qcom-cci: Remove the unused variable cci_clk_rate
Date: Tue, 22 Sep 2026 12:36:51 -0400
Message-ID: <20260922163652.3066989-2-sashal@kernel.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

[ Upstream commit b88c79699d72caa947ecaae85839b3563662ccce ]

Variable cci_clk_rate is not effectively used, so delete it.

drivers/i2c/busses/i2c-qcom-cci.c:526:16: warning: variable ‘cci_clk_rate’ set but not used.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=11532
Fixes: 8284750a1829 ("i2c: qcom-cci: Stop complaining about DT set clock rate")
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Stable-dep-of: 7362a1553eb0 ("i2c: qcom-cci: fix device_node refcount leak in cci_probe()/cci_remove()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-qcom-cci.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index 22fae6a5a9022..87a4c2d0ee9cd 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -523,7 +523,6 @@ static const struct dev_pm_ops qcom_cci_pm = {
 static int cci_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	unsigned long cci_clk_rate = 0;
 	struct device_node *child;
 	struct resource *r;
 	struct cci *cci;
@@ -594,14 +593,6 @@ static int cci_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, -EINVAL, "not enough clocks in DT\n");
 	cci->nclocks = ret;
 
-	/* Retrieve CCI clock rate */
-	for (i = 0; i < cci->nclocks; i++) {
-		if (!strcmp(cci->clocks[i].id, "cci")) {
-			cci_clk_rate = clk_get_rate(cci->clocks[i].clk);
-			break;
-		}
-	}
-
 	ret = cci_enable_clocks(cci);
 	if (ret < 0)
 		return ret;
-- 
2.53.0


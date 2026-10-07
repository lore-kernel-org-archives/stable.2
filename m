Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437D11E32D6
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 06:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791354171; cv=none; b=qmKWy5bj+fvaZTdm4VeymoVFE/PmsiwR+m1u72DtvatYrQJW0TvsVyBD34+AdkNlNfesXx4CbXx2hMlsr4htH41seRqd75t6ffRAjfT/Fo+iqNqntjFRoYM9P3OZCjwPrko8Rw7xdtQLLYL2Flmc9HtSczyrjFgY82ohpmHhzys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791354171; c=relaxed/simple;
	bh=d3z4Da05mAtgSu9MYxk8fGZoHz3WwKVgm1BT4/dlKoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j1OsWrwaxIaGyvf57bZSp0o/Qdfznu6wvAIYNfjZ/RSItTTsOdIDlJ7NBINjGE47p6j5h213M/uuBU7wquvVJPZm2hi6LcBhiN2m/ujGORxU/Mvng4CBpUbkFEAKPLPKoEOMcxCOi5/CrfSLh4oYn+0XVQyYyJcj4UmaFnzMmW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RlKzysRX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RlKzysRX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B131F0089B;
	Wed,  7 Oct 2026 06:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791354169;
	bh=sjXhqL7FyLhXnQVZlBXTZhUm0uX7iqgzu4baONry4Zo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RlKzysRXCml7T/y4GFGrPXOdx66+FUteoReX9V4BV1vmkDJtyp2gbzQinHHlQO4dg
	 bbEQ22QFh6qdBJQX/EMUszdivcDsllFDiaIcEgigRS3tyxONqlQbUHyzkHg1oJcJLr
	 HrdffAyS/yyo5XPQKniy7FrnmRao96DXMXyc5u4ZcIuXP3nyRLUROt1+jKIa5JuNBM
	 hZBvWMI2ThdY31XPlJpCQVQpLnMGEMvk4QSoy4zuyiTNaEQ7LMHrg6+LszfurqSoMM
	 1o/aIhKO5BdhTok4Yj/BG69yPtpo8tYbjQfQvcTSUFjYMO6t6l0tfrQGvzsCNDSFil
	 TslnoSLRNDXqw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] iio: adc: aspeed: Simplify with dev_err_probe
Date: Wed,  7 Oct 2026 02:22:44 -0400
Message-ID: <20261007062238.1618294-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100600-stage-saturday-572e@gregkh>
References: <2026100600-stage-saturday-572e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

[ Upstream commit dcc3ac29f46fff6775c0a945afc68fd9dece6d34 ]

Use dev_err_probe() to make error code handling simpler and handle
deferred probe nicely (avoid spamming logs).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Stable-dep-of: 95e4eb426b4b ("iio: adc: aspeed: propagate reset deassert errors")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/aspeed_adc.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
index 8ab29948214a5..1cf9df6a14a54 100644
--- a/drivers/iio/adc/aspeed_adc.c
+++ b/drivers/iio/adc/aspeed_adc.c
@@ -536,11 +536,10 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 		return PTR_ERR(data->clk_scaler);
 
 	data->rst = devm_reset_control_get_shared(&pdev->dev, NULL);
-	if (IS_ERR(data->rst)) {
-		dev_err(&pdev->dev,
-			"invalid or missing reset controller device tree entry");
-		return PTR_ERR(data->rst);
-	}
+	if (IS_ERR(data->rst))
+		return dev_err_probe(&pdev->dev, PTR_ERR(data->rst),
+				     "invalid or missing reset controller device tree entry");
+
 	reset_control_deassert(data->rst);
 
 	ret = devm_add_action_or_reset(data->dev, aspeed_adc_reset_assert,
-- 
2.53.0


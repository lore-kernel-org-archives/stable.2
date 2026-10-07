Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4E034EEFD
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 07:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791357656; cv=none; b=Mc4VdM+TYxTGGclUe/0vB8rbki62Z9HxRGRn1kEqO1gSkWjvauf7uODjHaNqN4fGnY7vY3uBGKRUFp1h1GpcBGqx+iIwdsN1iJ43tFiKKIcdDka8OKyvW7J3E3NaCRJlEKTg11tHzcKU6DdEP/R16JmG+NBWWPxvpi65/ofpajM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791357656; c=relaxed/simple;
	bh=mAY+pmCyOlBaUkJnYdvT8F2qZYK+/oh442RI6Ksj43I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JXgb3KzaIx6XppKxdxP9ZDb2jXDe7ZJxzufVP2fcY/qWZ8Pyj1rEVtqYiIFem/lGLTo9M+HaVPmYKpGFrYC3bVIEc4CHyqabCm0rcHhvMpOEHq01gGO+qjp+Ws/N+Qd7lZ3PNnGPQ7mqHUGlKhqrPJLJDsfj26NUODbYLYGMD+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FrHBSiM3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FrHBSiM3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07FB01F0089B;
	Wed,  7 Oct 2026 07:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791357655;
	bh=qw6zU5eDad/k25iuANalCU2udxl2pb7NplqibHAd1f4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FrHBSiM3sGVrN2YRLMuNhjuk0zb5950WAUheyuaIQTfJWJqb9OQIzzphBo1tYIVPB
	 iqXT1UT4gOfhOxRiWJLeW6E68JYNCz70mjy1H7cC3Uguuk5cxUjwhBKZ0hABN9kwbw
	 aV8T2pXpM0cDlg8sGLKgBBFytsDNOAz9I9I8SktAOD2Ipy59vRnm7GOlpI96AT+I6K
	 pumFmoQc7B2ZakLgmWEOrxAjFrms15kFWrpNlVdjkGL6Y/0Eu43APeZb5W37SlDjdk
	 8qChHiY/wbIG1PDT+SHl7U1NJ5fCws8nJVbFvIRbK4nQvgiY0Kn9YwRlhaz3u6H3dS
	 OCLgJhKDWl7LQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] iio: adc: aspeed: Simplify with dev_err_probe
Date: Wed,  7 Oct 2026 03:20:51 -0400
Message-ID: <20261007072035.1682082-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100601-upcoming-ravine-b302@gregkh>
References: <2026100601-upcoming-ravine-b302@gregkh>
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
index 998e8bcc06e1d..e6a9d8d77af53 100644
--- a/drivers/iio/adc/aspeed_adc.c
+++ b/drivers/iio/adc/aspeed_adc.c
@@ -549,11 +549,10 @@ static int aspeed_adc_probe(struct platform_device *pdev)
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


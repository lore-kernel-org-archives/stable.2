Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D98E3D9043
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 06:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791353367; cv=none; b=gKPDvciZXfnJ0rj9VM9GE7Kj3ahAUa0n6EexJ+Eyluus+xtuDqN1LdH/ZDk0zLhcma8MEfy/zQa2z0dSPhNqJ7V/74RfZZTYtlVHua+1jh0bqU4BK9dmdi8gXad+hDZrbgFnzbdPjA+2I487ObHRYeTkqnNuNlrMOpKYcO/TAjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791353367; c=relaxed/simple;
	bh=d3z4Da05mAtgSu9MYxk8fGZoHz3WwKVgm1BT4/dlKoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cMHPVA7VXMC2DUfxquHxEIhRXgxOkuV50AYOo8Os1BMDkTj+zX3yM9VuFbXd+ZIG4/xdn7C6o+l7kKTHZxVagAR27zhA8A72N+V2lsXD0IYnx/KAQDdKUfa6XfAyPSnG9Bduzpv6N8mFWkbDEZpiFu0OcEl/7i1QQ6V/6l7RaUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+UWKWDO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+UWKWDO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 441571F0089B;
	Wed,  7 Oct 2026 06:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791353363;
	bh=sjXhqL7FyLhXnQVZlBXTZhUm0uX7iqgzu4baONry4Zo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y+UWKWDOsQn1HamjIuurTEQxu17X3FVlllXVSG9cUXAJH5QS76ea8tDfBlK1MnFfL
	 RXpMfg6lT+fd+yLaC44eVyRVQcPlt71++CmEsq78vzkZfPVcTBrJMR4uWcNdu40NWe
	 OrXAy+1eplOyNiU4PSy3mGthTQkrTftiL89avr5eCmklmqbF/kN6rkocewnFxYQJCN
	 EEId9dNYtGlCgjJ1R9RolQlkSdosph31kT7qHeg1Ye3HsLUXbRkkkGvovamAXUwIC0
	 Tx+9jokRQbyeo63VQ/KMSvoz0UR5CmJksuzBjdyI91+IlzRJ5QBrCJzF4fX508r37X
	 w7ZLA8y5+bNfw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] iio: adc: aspeed: Simplify with dev_err_probe
Date: Wed,  7 Oct 2026 02:09:19 -0400
Message-ID: <20261007060912.1507775-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100600-blimp-motivator-875e@gregkh>
References: <2026100600-blimp-motivator-875e@gregkh>
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


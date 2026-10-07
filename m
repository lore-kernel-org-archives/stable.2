Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331EF279329
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 07:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791356596; cv=none; b=lL49mExUNip+KY9EWJBeV3BMdBe+O4BI+3kBxmz+byCpP06Lse7c8lpXzWfIvOIHQX3i9sKgsl3Tl5n1/zRgscFXEsxd+oDGq3mHyhpp+cwo9He6QEkUEFqJ/llJr4EtZkK4GIOYc6Im+bVVYjEaGHW1pRHg4XkbpOdodNoTN00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791356596; c=relaxed/simple;
	bh=mAY+pmCyOlBaUkJnYdvT8F2qZYK+/oh442RI6Ksj43I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pKAb7Y6k3JylLJxFJCc6egzlDR3jgexH+VvTGaAJWqe/8Q9I6UIVSlQA+h8vbOwsHohyphySP7icxFQRj7AfJX2wqnua3AbgjQDjy/DRndkIaN1MPrpiSMECtxQ+XGQ3L3YwdPuFEMxY+ZM7GqVrROfcyj6eFtVSukfewAr0tWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTnVGyZ+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTnVGyZ+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCF471F0089B;
	Wed,  7 Oct 2026 07:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791356594;
	bh=qw6zU5eDad/k25iuANalCU2udxl2pb7NplqibHAd1f4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CTnVGyZ+vRVkORLVoF8ZK/GubpAIXC6vwNdEez5HtKXiinutLGuTmNZTVjQjnL/7C
	 SMiCIv3AK+4IJYTHGbS9EXlw/AmZ8sE/ja0WjQLhORx/pgGA/jfm0qnXId9Ya3D5Vs
	 dHucstZZupHQA1hPj3V3AKAH7PARC7YaL86owiUHJ7EijXfcxob5kbuOgo5o0pZKJj
	 nq6Jk5/poLwOIlHyvag1m5nYBS8hWvUNASalWGXj3T4VunYvPLd9kR72ZOqxq6E1x3
	 PcsIchjacAnFZmL9zZiigpMyASgONVDpbBkI9Wu+xfsHnEEsd7RxYcYilVetjUrIOp
	 SKvt3i9DygqZw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] iio: adc: aspeed: Simplify with dev_err_probe
Date: Wed,  7 Oct 2026 03:03:09 -0400
Message-ID: <20261007070256.1632699-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100600-partake-series-35e3@gregkh>
References: <2026100600-partake-series-35e3@gregkh>
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


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824DD3603E9
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 06:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791354172; cv=none; b=KZjkE41ILI9XYaZik8Su+qAYiEc2V5cHHyD8mck001n8v9lmTv6xLGp/C76CPRfOUAjHeVKKx+Zl0tYYGl5epzWV7ePnFaLaH4g3WY5ZvWty/oPT+uzMHyVVb92xkKZsgpIBRCUVOxIRfT0OnGGSlwLLF7hIbtShlSC2BVWfHzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791354172; c=relaxed/simple;
	bh=3aE+LR6Ozwliultkr1yIbuHZQO4v+dp3HozcXQf2KC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uT5AxOd/f0fRJn9xLhcvHlO2dGS+EHjnrj5+4P6wwdieDekGlOVDfk2lwwQxdGByTQKsRRvBUlaSUVMYRqdG9YFCELfxO3SZ5Dul10fvwKhKzNqj+cG7xr/PtJR/eFkw7R71zf6IQM8uFN0xH4HX8oYz+zbMVL44DCy7T8SLcPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4R00gn8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4R00gn8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14AFA1F0089C;
	Wed,  7 Oct 2026 06:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791354171;
	bh=DdeAOxvEEALLXyvUZ4O4qyrxPEWgnZTALotXBCNayg0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a4R00gn8V0ZxurFu/PKwULs3p2IlVI9++BTYUIKy0xIdntlw08KnVwofkrQy3CxWJ
	 8iSbqrTg2wucni0FJpH6T5yJTYzHteCd8Xm6HdOsZ1AIcIBONa+9LsIVkt1jXveKTM
	 VkXZXr3AIIueSVuZYK2wm1c532pm0Q6PwRTkNSZz47+mD2Hb3+H4Wz7KDAkBAdcahy
	 CVY3/zRfMYPlXO/izX2/yoIAMjnH0ZjZ9jGdPjMfi/FW4NRTGETVHFytMSCMC+ib8O
	 APWdcAQ2MZlIuy4fx7SaQhB0WCmef7m5yEST200n1zpes8SB/yCXEEfF9TtusxQeTn
	 EDmZLli2NbaVA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] iio: adc: aspeed: propagate reset deassert errors
Date: Wed,  7 Oct 2026 02:22:45 -0400
Message-ID: <20261007062238.1618294-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261007062238.1618294-1-sashal@kernel.org>
References: <2026100600-stage-saturday-572e@gregkh>
 <20261007062238.1618294-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pengpeng Hou <pengpeng@iscas.ac.cn>

[ Upstream commit 95e4eb426b4bd666fa2f37886c0ddf74a0cc6167 ]

aspeed_adc_probe() continues to register ADC resources after deasserting
the shared reset, even if the reset controller reports a failure.

A failed deassertion leaves the hardware unavailable, so stop probing
before installing the cleanup action and enabling the ADC.

Fixes: edf7550a1f93 ("iio: adc: aspeed: Deassert reset in probe")
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: stable@vger.kernel.org
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/aspeed_adc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
index 1cf9df6a14a54..8039370e1cd28 100644
--- a/drivers/iio/adc/aspeed_adc.c
+++ b/drivers/iio/adc/aspeed_adc.c
@@ -540,7 +540,9 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(data->rst),
 				     "invalid or missing reset controller device tree entry");
 
-	reset_control_deassert(data->rst);
+	ret = reset_control_deassert(data->rst);
+	if (ret)
+		return ret;
 
 	ret = devm_add_action_or_reset(data->dev, aspeed_adc_reset_assert,
 				       data->rst);
-- 
2.53.0


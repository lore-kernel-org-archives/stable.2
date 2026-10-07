Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6755A37E5D8
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 07:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791356597; cv=none; b=UYWrjk2viUktcrCInuLtKTH2+0pamAq5pdcG9reyZsj+Jst0EA6VeWT5vDMbxjNkGJW+YL5du5eJ4EIqkZSkTXtsR32A9VE0WegjcMGzfpQ/n3AwmL35dOb/zP9hkC5KAdiKqTlvYiwNfel1UNYR3hFKQxovdl5kXMgs7yiHvfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791356597; c=relaxed/simple;
	bh=AxNHBOAd22TaFJO75EBuPOn4ipDh8KALsws2KodsWH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cVXpsDmeixiifuBoWrfxjiZlrfls2QDc5jaOR5QMg4bE8WUwt5/z4pCvx3Hqk1QDV0NLKhC8n7vY4xWlIn2FMvYbTBQNPY+iUsh7bmgw9b02Zm1o6KYzzBVJJhE9ugFGD3rwECeXvz+JWUVpRXYX7ZJFMpqlqaX3EGem+70T7No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cUCYUYpg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cUCYUYpg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EC4B1F0089D;
	Wed,  7 Oct 2026 07:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791356596;
	bh=2MEqUCBN088Nf6hjVjvFMPPcd8kFKefKfmG5QDAnC8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cUCYUYpgPkINHo/qBR7oMT8kIZxRILXtkDxlKyfgloSeKGnj7gvSFhKjVN+QqYP13
	 df8PbHzxo38MUF0EVJ89Vw+J8pCNUY6Ic5pWLRXXuIT+ivhfr03ljFMUTVf3td3STX
	 Na4oV3TZz8+h97OXz1OJBf/CRmMkst4CK3t6eBjx42Mww3tdYO3/uLwccQxmLbp1Q3
	 ZThPh40LJtuhaNFfiEkzX/JggLn8meXbZ/HQyzGk2VIFjtTaBDoDpSebjO8BQCu2MG
	 hRpojEOZrqusjBztSXhOvDP9uT9QTov5HR8xXl4gsOPqTE975M9Hd6l1RQRzyfxkIm
	 2om02fk7CjULw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] iio: adc: aspeed: propagate reset deassert errors
Date: Wed,  7 Oct 2026 03:03:10 -0400
Message-ID: <20261007070256.1632699-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261007070256.1632699-1-sashal@kernel.org>
References: <2026100600-partake-series-35e3@gregkh>
 <20261007070256.1632699-1-sashal@kernel.org>
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
index e6a9d8d77af53..4cb2210cb38d7 100644
--- a/drivers/iio/adc/aspeed_adc.c
+++ b/drivers/iio/adc/aspeed_adc.c
@@ -553,7 +553,9 @@ static int aspeed_adc_probe(struct platform_device *pdev)
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


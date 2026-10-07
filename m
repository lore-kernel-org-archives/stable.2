Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013823E9C17
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 07:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791359108; cv=none; b=PXeOQpR3SzjN3m6bB9Txcw0olRBNOqqwIedjlLGgOcXtwLgYBbCJkHhVCnIHB6O0j/xMqFxEAQNkv07hiuykad+lzIgMIY1UphH1MTAVG9GPwUhv3/+1kuVXaX3P0vDHl6hCA9u1nXT1crJiWoswQ1dHPN3bopfITG+L+KHxn5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791359108; c=relaxed/simple;
	bh=56oWk8rtVs347j/GnOzbXVYtmQ1JzflALHrKYh+CDg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BNYkoQwoeulCYDnWcJD7PZGyvJ4Q+sPtuh7xTJZnA/zqIp6/6Zn3cC2Zvgd1RWV+Z/oDvvVFQGGDFjZkfdqhQaCGl2WGj7zLNJac6sCw2mDLK8xKtTeIUX2C4tYquBjCIxdQoFfMM+rdym07KNOCkjvmMKXVsSl46qrdJefNndY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e1abRqYe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1abRqYe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 347E81F0089B;
	Wed,  7 Oct 2026 07:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791359106;
	bh=/y5TRxVh8gW2xfIBb9kCaNuvBLrP5qG9D7M+a8ic77o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e1abRqYeq5jaYS2fKX5FpmAdZT3RWEdVczvggdK/+fOWJOHxMpQYvLyvl/lMPLUr0
	 LkjvitW7qE2VLF90G2Dx6pBm+qcluCSENRCyQpDCylMk37yy+VV4iZFu50lC6dm9rU
	 keo5fDCc76oHvM17kRmNFFNxfqRiwiXSFgIm0r3a+Ci/TTewmHrue0edRBJ20ax5SL
	 qphpafsRWGWRa2U0azOCBP6zgQY+iy740z+1RCveeUdx9VVrKtFutnz4SAhp/bF53b
	 hnkBjRzE9kTEwCXqccyDa1kA9OioUoCiPJeDGcVVUvqwoQ/bXRpvQGgqCxUV56KTjb
	 wnHV9dwJlTUNQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] iio: adc: aspeed: propagate reset deassert errors
Date: Wed,  7 Oct 2026 03:45:03 -0400
Message-ID: <20261007074417.1754784-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100601-fanning-thursday-e3d4@gregkh>
References: <2026100601-fanning-thursday-e3d4@gregkh>
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
[ sashal: Replaced `return ret` with `goto reset_error` to accommodate manual clock cleanup. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/aspeed_adc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
index 34ec0c28b2dff..012cc9291bef3 100644
--- a/drivers/iio/adc/aspeed_adc.c
+++ b/drivers/iio/adc/aspeed_adc.c
@@ -221,7 +221,9 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 		ret = PTR_ERR(data->rst);
 		goto reset_error;
 	}
-	reset_control_deassert(data->rst);
+	ret = reset_control_deassert(data->rst);
+	if (ret)
+		goto reset_error;
 
 	model_data = of_device_get_match_data(&pdev->dev);
 
-- 
2.53.0


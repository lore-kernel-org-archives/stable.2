Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B410D3DA5C5
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 07:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791357657; cv=none; b=u0n2d8pG8NXYLziWIt688x+aSNQr98oWJRhQz1CstMZK81e++kdsnofHFdZ2fgtdC9xaR8twkoHoA/9CfsoSpzM1fKJ/SEze2yK+xnvrkOgNLFZE4wFGw/JX//ZTaRpJCNyc+lw3cGkjTk0agOpZJYmzKvLKp7Fkx6SIXvrN2pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791357657; c=relaxed/simple;
	bh=AxNHBOAd22TaFJO75EBuPOn4ipDh8KALsws2KodsWH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mug86P4L1MXYUp9YeFw8A3BfYytDvVNG+cWH0OBY0LtI7StE9Tlz3IGGjS4dOFfyaPjoTRnjrm8JmNDWpvNsdANojoKXjkTinffsuhM7cwn2H1AhGQmu6kYGwuuB8Zd1T0bs7JeAEv5vCgsemMPx6VTLDmyPM4Rznc//67jDZVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O0sLTCgx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O0sLTCgx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70F781F0089C;
	Wed,  7 Oct 2026 07:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791357656;
	bh=2MEqUCBN088Nf6hjVjvFMPPcd8kFKefKfmG5QDAnC8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O0sLTCgxESlFbyUkZHBumdm8MlfIqd05HiErTzq7pM7Uwa9+AK+45cJ51ljOpguNY
	 TcYMgDbD1AFLQRS5hSrZ/i6PO4uHbl7cztTeUaNhNxHTHYXlZ8yvH7GysjQ1+XQNVx
	 T+um8jZ+w0O2bh0YazLoCtCNxDGZLBdRZY+na7cSFKcz80ojDSDFiQX0q427H0+jMQ
	 XbzUJDAAVPLyIKnjSsDbuUonoH+RD5vaMPv0wIDZ3L/8aEsm7TBlqk4fo2AOR7aePP
	 R3laCopd7XRbOoBlzmAMOO/whvKO3lgvrX0QFWQzfLBinUxc3IfZOoCKYbLEkEBACZ
	 0gXn6A2cbA3KQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] iio: adc: aspeed: propagate reset deassert errors
Date: Wed,  7 Oct 2026 03:20:52 -0400
Message-ID: <20261007072035.1682082-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261007072035.1682082-1-sashal@kernel.org>
References: <2026100601-upcoming-ravine-b302@gregkh>
 <20261007072035.1682082-1-sashal@kernel.org>
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


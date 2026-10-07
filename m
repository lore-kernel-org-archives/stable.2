Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17A6347500
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 06:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791353368; cv=none; b=ejRbYdrMYl03+Yml8twPkquVwa2qHiB8BiKbzuIipyFCktllxoiL3EJdEm9g2TzTrhKph2lUvPkxzlql3R1W3K4w4hd4rBDJo+ug9rywrx2+W222TI4hbxLjrRRrXQPXxpkRWV3rxEFZ83QeV4Yi6xLlei0EIc6EeW3xJtFSql0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791353368; c=relaxed/simple;
	bh=3aE+LR6Ozwliultkr1yIbuHZQO4v+dp3HozcXQf2KC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ojurgQTd90RsMIIKIXmA1rYKK7Jy01VDAUpuwTPE22DA4xxmtf87MH3w1pDbpHqKrgD7HoZAk/b5bz33gu8602cCpnIB6W+1pvpLisEw7+6h7FrCDS+x97tevS9Dbd1JlpTMYT756wneWGThWtRmJ/FYgkfk0rVU6UrSEDD7e8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PyfsqXA4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PyfsqXA4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF3201F0089C;
	Wed,  7 Oct 2026 06:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791353365;
	bh=DdeAOxvEEALLXyvUZ4O4qyrxPEWgnZTALotXBCNayg0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PyfsqXA4CYhJXKtFFJJHMUxxbJ8mHhNDuFZxgMxLPUMvEiUaFpGtFhjVeRehkbCKZ
	 w/K6rGvHWT6Plz2OXdi338uUhU2qB4gi1Fc5u/NXcF3dzqZKhqB4p8Q6f1WNJUEV7T
	 ERmk8aRhAQnTopmQ9Y68j+GJAbmo5mEalMbYWvmUSSVC2l2HmL0WODTlK1DD05TSDx
	 KZ+u8Y/JzwJlfe1hMza99pmUGioYt6o5jrx6HDsxsPGLE+omkuSTf8yTxy1R31w+F0
	 aj6+iq1HqmtPst3O9PbJUPN+iNa4VKzEn9MPVWpa7kog7Qj/wQrrFhORH1cTuAdNDW
	 Nu1kK3a/NCuZg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] iio: adc: aspeed: propagate reset deassert errors
Date: Wed,  7 Oct 2026 02:09:20 -0400
Message-ID: <20261007060912.1507775-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261007060912.1507775-1-sashal@kernel.org>
References: <2026100600-blimp-motivator-875e@gregkh>
 <20261007060912.1507775-1-sashal@kernel.org>
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


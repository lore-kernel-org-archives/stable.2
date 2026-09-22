Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B22B493D5A
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 18:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790101866; cv=none; b=l2s7tdMIqoInDWBQxplgPrxEmaSPrBoq2N17AKv5gmj6xOd4SXDiwXQe1qyZLfSWRAeO0vU7DGz5nwgJC4VkNg7vG+nO9KXEG/zF94L7TbJNTtu6hFc8iZy7K+4sjshDe0RoTrQaxQUDhw8P6STFlCur/jMcGsGPUOb4wZP0Ssg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790101866; c=relaxed/simple;
	bh=eyLcNzaw4//dQyWkWIqguwPPadmDrqec5ubbhFUO0ek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k1S3td5zJ5JNwslV6FYue89MY46RLmirZay9JuHs3hiBQ77CG/pT1527Un67WI32ww5ShPdVWr//exQRbF2oUSYI/KEPaeSKW8fMcTVLxp/c6v2WzIxQ2sLPgOcUS7doraW8jjm0ZxPw28FL6kgkgQY/MMygkBgkKZn/aYmCkqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTSsu9gf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTSsu9gf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1CF41F00899;
	Tue, 22 Sep 2026 18:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790101865;
	bh=qDheX2XfvdDa4+fyFQ1df1evidZ8WtkETw9p4eY9kMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UTSsu9gfO6rhPvpy2dsu+8e+iZkDNWHolda58V4y/Oqu7ef28HMIVzXAvAFEEql+r
	 kHIg2c4Lg6HdRgnIzIXNJeAGva9WyWZ6hzn5VYTthi75DALYM0HPYrDWHfqW3U09pa
	 5b9Duu8Oo3sxg0XKZlEUNlibPJPfiR9N41iKA6TfE2gq8rWLq3RHWHal2tu5i2LWpH
	 x6ATjJxcoU0J7URh9aTVEcwOMqC7GvQkftHdQTp4mS4yvKdKzcGnB6MzdQr5n82cM5
	 WiwNyenNALS2RKh0gHEZqFg+9DkE0SThfNtKCgmzQ9VjQH9AFwtkUSxHRX2K80e7Ev
	 3IbfHdmTPGANg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] watchdog: rtd119x: Avoid division by zero
Date: Tue, 22 Sep 2026 14:31:02 -0400
Message-ID: <20260922183102.3660424-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922183102.3660424-1-sashal@kernel.org>
References: <2026092230-dipper-mute-1a50@gregkh>
 <20260922183102.3660424-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tzung-Bi Shih <tzungbi@kernel.org>

[ Upstream commit 5af7d2cbd20f893def03c8310a460ade66a5d822 ]

clk_get_rate() could return 0.  Avoid a division by zero panic.

Fixes: 2bdf6acbfead ("watchdog: Add Realtek RTD1295")
Cc: stable@vger.kernel.org
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
Link: https://patch.msgid.link/20260913064851.8239-3-tzungbi@kernel.org
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/watchdog/rtd119x_wdt.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/rtd119x_wdt.c b/drivers/watchdog/rtd119x_wdt.c
index 95c8d7abce42e..e963be4df8c4e 100644
--- a/drivers/watchdog/rtd119x_wdt.c
+++ b/drivers/watchdog/rtd119x_wdt.c
@@ -98,6 +98,7 @@ static int rtd119x_wdt_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct rtd119x_watchdog_device *data;
+	unsigned long rate;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
@@ -111,10 +112,14 @@ static int rtd119x_wdt_probe(struct platform_device *pdev)
 	if (IS_ERR(data->clk))
 		return PTR_ERR(data->clk);
 
+	rate = clk_get_rate(data->clk);
+	if (!rate)
+		return -EINVAL;
+
 	data->wdt_dev.info = &rtd119x_wdt_info;
 	data->wdt_dev.ops = &rtd119x_wdt_ops;
 	data->wdt_dev.timeout = 120;
-	data->wdt_dev.max_timeout = 0xffffffff / clk_get_rate(data->clk);
+	data->wdt_dev.max_timeout = 0xffffffff / rate;
 	data->wdt_dev.min_timeout = 1;
 	data->wdt_dev.parent = dev;
 
-- 
2.53.0


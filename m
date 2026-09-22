Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2F0386562
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 18:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790101277; cv=none; b=ERX24/hxY530thIJzADYO64jb7+Y6Qh53n1RDzTzDYHr0sDeTX4OAV35krgb8QjHO7PiNFXvtw4RGibqnvpCJ6ndaiEPejoBaNDS36SGRK91fmsY1+VfZ10zOoa3fvo2ZiXTFJw73/BBgSC5BhIPgC+U7l8rCejtGQzpfC9gF1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790101277; c=relaxed/simple;
	bh=eyLcNzaw4//dQyWkWIqguwPPadmDrqec5ubbhFUO0ek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SGTpA/AQXw5qxAyMT6veND+r1xqsc+56VNrokL4lvJQMKI+MVZgq1YnCJeNpikag7Job+1bqM+OTDAdZl+RvIFrSXzp6X84Dwe1XsOAHrUxTyuMrbIaCwhljppDqruJ3A/DHPmaf6Uu9hnRoG5s0chqv+SInso0Ngnt1KGPIEs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A0u1gQfj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A0u1gQfj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A081F0089A;
	Tue, 22 Sep 2026 18:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790101276;
	bh=qDheX2XfvdDa4+fyFQ1df1evidZ8WtkETw9p4eY9kMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A0u1gQfjJS7c9BZ3pKgO++R+exLm+wE3YCocEl5HdCZjiUSwzB09SMa4CLZdRkysc
	 5u2iOygx8W6hd8iuRNAx4rauwICmImaYipNRbS2Bzt4EXd1kdni39zr9NZ138XdSh2
	 0ZWzZ50Fa5a11va6ZV2mRK0f9KP49HMFYWeC8kdOGkjT7LI95+4cCdvz6f6SWgfTC1
	 HG8BdjynsM2zDlQf5etA9YGb/toTJjcyTDALyU1XVzWcomVl7DUvadWezaStqe+bN/
	 RxpYOb22Zm/cKC3hznI4RNgQF8Nt5fZElwFjdxfXMgev72+7UPre3liV2psZRt9j8U
	 Fw3w/Rp5R+x4g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] watchdog: rtd119x: Avoid division by zero
Date: Tue, 22 Sep 2026 14:21:13 -0400
Message-ID: <20260922182113.3568867-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922182113.3568867-1-sashal@kernel.org>
References: <2026092230-thriving-ungraded-3c65@gregkh>
 <20260922182113.3568867-1-sashal@kernel.org>
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


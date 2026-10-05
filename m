Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E9A442370
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 22:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791240460; cv=none; b=uI+a3xY+WwPJe3RxLEIdQS6PhcasdFM2AF+LH22SM6VLqa4gqu79I/q/05XXvDMbns6cZhbkqsM1Xb2thmBwFUevv0jYl6RiBtIImU6H+7I4pZqjWksrL7Lhz4rpvYVUD8i46Rs6Tje+0aoSJ1ef/bZbOEfwJDNijyEHr4Lg6iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791240460; c=relaxed/simple;
	bh=OshEd/kORRwsO5gtFTLDtfFy+jG89G5oao/Dr66Kwo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lYjEb8zsqLOg9RGQMWY0G1CL4c5oKmFGcI92qJmfH0LV7T9A4a4YerKFDZ9O6iX6jM+X2CtPojvuzNRlgR5wvu0sU5Beem/A3uq6Zzt3zXJJHtirBhyV1M1DR2ZRkn1OxlFWzdoHff2pgGY5gLU5Uu8uGvgsfVYXw9S062OgQ9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ae1AeZ1G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ae1AeZ1G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1B7B1F000FF;
	Mon,  5 Oct 2026 22:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791240456;
	bh=98BzyElnpYNHWRCDy63jZgJaQAfFBtm3t1xKr1LFgTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ae1AeZ1GP37nEcnog+KeNLS34fuiXkYxxgqfRY2jwgVWJuvMOurkDMAcK+H71LSmi
	 Uyyb66d0r1TumCjdvhziA3EzAZQHNZn6eFFE6RLJKHdpwcG8k/um1ngT9FTCHqhT+0
	 I6oZIam4xpnZNjiwCUyiNPs8MCUSYQ1x+pRoo6pnLCCmhT1hSe775TYFPJVilBVvk1
	 3764LAdokWdEx42BM9Tx/WiG+lhuLtMr2FVhYRAPdN6w00z8449NEXOLS8S9fgRkv4
	 K6e5HTcE5HXQL9J7SZGEPf1Bj17tSMnUj1HzU8I0kZiSnEbEuk5zXvL0KKk7GGK/aN
	 rjFfMse0+8DWw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Manikanta Guntupalli <manikanta.guntupalli@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] i2c: xiic: Relocate xiic_i2c_runtime_suspend and xiic_i2c_runtime_resume to facilitate atomic mode
Date: Mon,  5 Oct 2026 18:47:32 -0400
Message-ID: <20261005224634.3501347-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100513-ferris-smugness-b184@gregkh>
References: <2026100513-ferris-smugness-b184@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Manikanta Guntupalli <manikanta.guntupalli@amd.com>

[ Upstream commit 2ee409c6a12d74cd1b16ca3690baa7d5ffffeb7d ]

Relocate xiic_i2c_runtime_suspend and xiic_i2c_runtime_resume functions
to avoid prototype statements in atomic mode changes.

Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Acked-by: Michal Simek <michal.simek@amd.com>
Link: https://lore.kernel.org/r/20241210095242.1982770-2-manikanta.guntupalli@amd.com
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Stable-dep-of: b7e6df2f52ed ("i2c: xiic: preserve PEC byte length in SMBus block read setup")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-xiic.c | 46 +++++++++++++++++------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 44c2afd5ef07b..1cef404a33971 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -238,6 +238,29 @@ static const struct timing_regs timing_reg_values[] = {
 static int xiic_start_xfer(struct xiic_i2c *i2c, struct i2c_msg *msgs, int num);
 static void __xiic_start_xfer(struct xiic_i2c *i2c);
 
+static int __maybe_unused xiic_i2c_runtime_suspend(struct device *dev)
+{
+	struct xiic_i2c *i2c = dev_get_drvdata(dev);
+
+	clk_disable(i2c->clk);
+
+	return 0;
+}
+
+static int __maybe_unused xiic_i2c_runtime_resume(struct device *dev)
+{
+	struct xiic_i2c *i2c = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_enable(i2c->clk);
+	if (ret) {
+		dev_err(dev, "Cannot enable clock.\n");
+		return ret;
+	}
+
+	return 0;
+}
+
 /*
  * For the register read and write functions, a little-endian and big-endian
  * version are necessary. Endianness is detected during the probe function.
@@ -1368,29 +1391,6 @@ static void xiic_i2c_remove(struct platform_device *pdev)
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 }
 
-static int __maybe_unused xiic_i2c_runtime_suspend(struct device *dev)
-{
-	struct xiic_i2c *i2c = dev_get_drvdata(dev);
-
-	clk_disable(i2c->clk);
-
-	return 0;
-}
-
-static int __maybe_unused xiic_i2c_runtime_resume(struct device *dev)
-{
-	struct xiic_i2c *i2c = dev_get_drvdata(dev);
-	int ret;
-
-	ret = clk_enable(i2c->clk);
-	if (ret) {
-		dev_err(dev, "Cannot enable clock.\n");
-		return ret;
-	}
-
-	return 0;
-}
-
 static const struct dev_pm_ops xiic_dev_pm_ops = {
 	SET_RUNTIME_PM_OPS(xiic_i2c_runtime_suspend,
 			   xiic_i2c_runtime_resume, NULL)
-- 
2.53.0


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCED1E505
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 00:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791245430; cv=none; b=q769svuqSOcYMBvTyNASA6a1zAn4TFl77kZDrqKJ2uVimM5dODFzRp8vW+lFe79nLKV5HwAmALRY5M+YwdZyWbmM9mkZTe3MVvxWGzSv4c9R6n0NpIojKpXT/2Dih7Adixyk8sSeA2UnRxaMNi992FMrqi/ogH72lx5USkAfSLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791245430; c=relaxed/simple;
	bh=OshEd/kORRwsO5gtFTLDtfFy+jG89G5oao/Dr66Kwo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YlKiQGR23w04TaMUaYSGZlPuIBHGemuT+Sca8DqTsu54HUr6ZHDfvtsfJIiGVPTw6Js3FzThqOD35O4Q0+B5EwaJXhFH4AMWaNZ89QbYBwE/5UJMeiRThYU2te4I5M4C4vH5txFNpYfKfZnrn6w3DDltsmAnbmet13BpqhUTWeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3mQGmu9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3mQGmu9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38C7B1F000FF;
	Tue,  6 Oct 2026 00:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791245428;
	bh=98BzyElnpYNHWRCDy63jZgJaQAfFBtm3t1xKr1LFgTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A3mQGmu9YoRISvtNTGbSVsvRPcqSGEYqWdyXWiVICMkTxBX/59gEZKGXohroGF69T
	 4cn4B5zvzWVBLYwtzvE2vMCDIb9cgtUrgiNbqsSkgLkbhZaOaQCw7LYzitA/K2m+Op
	 90VUZ4oa0MTYIkVA2LjF9xDhL1wascUSr8X8LcqeI7N546XdYXOXa9nNfsWJzG4r4O
	 TPL6ihphVEQyWaQptKGGfm5Jn8ymERpUJPz+TkwGT7bqzX4YnIDIloYAn1FhO9g7Lt
	 NVZsrDzBmNbkleMUFLo0nYp8Mm3XR9IMadjAV80VqK4gn/2osGiQV7tcPo3x58L8c8
	 vCzfZE1dkeDJQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Manikanta Guntupalli <manikanta.guntupalli@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] i2c: xiic: Relocate xiic_i2c_runtime_suspend and xiic_i2c_runtime_resume to facilitate atomic mode
Date: Mon,  5 Oct 2026 20:10:23 -0400
Message-ID: <20261006000904.3545638-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100514-prewashed-vexingly-363b@gregkh>
References: <2026100514-prewashed-vexingly-363b@gregkh>
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


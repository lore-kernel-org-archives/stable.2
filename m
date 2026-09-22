Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4363463B7C
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 17:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790099479; cv=none; b=PxelEFGhY+amsAsZpBc1tHRtTfY3vAMlY046qTWZrTf2VEI1iKxLyH2D5HtJJ5Hp/ApWgGWZIHJHAteRRIAufrZgYnw7C51ftoawD2Et30QrHhrPKCNXSO3mJZ3IHLUfiKXEanGSNZIO+Mi5oPfi5STKDHaYB+oB+w0ukae+FQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790099479; c=relaxed/simple;
	bh=6srHTuQh2WHJSpSL942mxurkFtiuFuXZMeZq7cR6HiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L6cYchT0lMhRMNGnjoroXgQsjZ5W8V1sQEz1QleVRc5selNOUMPAMYjmkV7P409GftSSVdIy6MYMGWhM/LTgmQKblhAxmr3eFPeKLkw5/YkCzgQSQU9l7DhJwk0uqH1cXz82T9xzXF04iOPoKsvgb6FhBdrMtazsldEeLzEJRak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R1GPZWWe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R1GPZWWe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30AC41F00893;
	Tue, 22 Sep 2026 17:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790099477;
	bh=jW47mMRhEtt6BMmD0G/NYblfmlBIIatTUdSL/2nWAjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R1GPZWWetrra9cnyPN09mG7VOydyb0cUuqKX/z8osGrCsN9c/W/9N68d73oVh3oK9
	 s0zMB+ZwsS23qvpMFEPkcEZsC683h6u7DNsY49kvBB61YEjsqUZeHyxA7kZScJFt8r
	 E9upx1H7CcwY5PJeTIowE2GfR479ollAm06qWp2uDMNtj53E6gXBP5K91GoH1hKxvJ
	 bayZywN9vFjHmeksGH5G8CbzM8AVZCQ8HJ8Ssuv+Hmd2Vnn65I7mAsk9xppK7ixMAW
	 6Py8nuaBUDyq3AENpCS/OUwhfSFR+QwF2ylZMmwwKQ9JrexDfpS4wo91MVpwol/ujN
	 qA1/g2DvFtx9g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Tony Lindgren <tony@atomide.com>,
	Wolfram Sang <wsa@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/3] i2c: omap: Improve error reporting for problems during .remove()
Date: Tue, 22 Sep 2026 13:51:13 -0400
Message-ID: <20260922175115.3308967-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092239-arguable-reunion-62af@gregkh>
References: <2026092239-arguable-reunion-62af@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 9496fffcb28f39e0352779a0199b6e61861c9221 ]

If pm_runtime_get() fails in .remove() the driver used to return the
error to the driver core. The only effect of this (compared to returning
zero) is a generic warning that the error value is ignored.

So emit a better warning and return zero to suppress the generic (and
little helpful) message. Also disable runtime PM in the error case.

This prepares changing platform device remove callbacks to return void.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Reviewed-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Stable-dep-of: e0c3e9d76adb ("i2c: imx: disable autosuspend on remove")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-omap.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 5c045c4da660b..1cd07faecd6c5 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1513,14 +1513,17 @@ static int omap_i2c_remove(struct platform_device *pdev)
 	int ret;
 
 	i2c_del_adapter(&omap->adapter);
-	ret = pm_runtime_resume_and_get(&pdev->dev);
+
+	ret = pm_runtime_get_sync(&pdev->dev);
 	if (ret < 0)
-		return ret;
+		dev_err(omap->dev, "Failed to resume hardware, skip disable\n");
+	else
+		omap_i2c_write_reg(omap, OMAP_I2C_CON_REG, 0);
 
-	omap_i2c_write_reg(omap, OMAP_I2C_CON_REG, 0);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+
 	return 0;
 }
 
-- 
2.53.0


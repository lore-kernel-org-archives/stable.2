Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5DD38D3F1
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 19:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789067465; cv=none; b=UmEi5G11ZMeyftgLU/bDfOXOlziBATmHOpKNFwHTbwNiO+1MXaZ4tMi1t80pyJNOmla3uXazEelNW6mhXvf+1C7j/n14lWJJ3msYDNfpFKtpp/rXC4xHyFsvFKx5/Ys625XBDXy3B0uOlbRLUyQhodtlKm7iIiit/8C9q5KkHL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789067465; c=relaxed/simple;
	bh=KyGzNqlYzaCLqqCEXbSxeHXQyzRNwO6WHpd9UG2GgAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VFR/61dEp2gp5zFn7feviigXFy8yoxVFmA88DUeO990DsFZ4bQSA2zjatMnMpbCa6eogbgx+d9/GedoA/vM1BsdeIBRHYX5AQsM9XbHxjImQmVQamgpjKRkq85lWb0SqhAB8Zhat+n+xqzC7h6J/9+5GwWO+bULY0c5wVynRkVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFq5ROjF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFq5ROjF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D0051F000FF;
	Thu, 10 Sep 2026 19:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789067464;
	bh=eY0OkNmzystQan27SJLsi9Lbj05qeJjdjBKft4Fj62A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JFq5ROjFweD7FUzyW1I70A4iaAljTe7+JQokZoCAi0qigLtqKGCHOOdvMe/vx02/i
	 M40Up2lYjPdR8OR/TGYtI4ZozrPcpy7tyIv+DPOmLbXgR21MrozCm4rIhDnuijKsAO
	 HoC2RVQHfMzGW4PT2XJuSLMepaUBknRMhhyfcMa8yWErcZEpG2saVKq2Tz0suXFHjJ
	 YIbADSB9Sc1pGSrhztIFCrx3//WjvuSgog4nSwOE1Un9mQTZ1TchKsS5TYo7a4HWxe
	 llh98YMhhMXL6aDzCBzFE0pyZsViEG4d4L0jsgxn3lZkAXFSOUqUOUwAdh419X5NHQ
	 Huce5Fl+4NZXg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Tony Lindgren <tony@atomide.com>,
	Wolfram Sang <wsa@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/4] i2c: omap: Improve error reporting for problems during .remove()
Date: Thu, 10 Sep 2026 15:10:59 -0400
Message-ID: <20260910191102.1467479-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090909-palpitate-shortage-3ec4@gregkh>
References: <2026090909-palpitate-shortage-3ec4@gregkh>
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
Stable-dep-of: f98d49864821 ("i2c: qcom-cci: fix autosuspend cleanup")
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


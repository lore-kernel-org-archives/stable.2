Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1087C18DF80
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 00:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789085733; cv=none; b=LE4vMdJGpziBKSwt3GdvZsPGzvq6Ehfozq23paaNBCYIAKRQSIJcbS/aD0gX58inJLJ90nS4/lxQkPpumFFmYThK/9F1Ev7jaJ/jPm10JH1GWUEO9+ITuCFGPYAJ6EoeL/wZMBfEfRAWDVUqnMbBvjvT4OBMuaDktlQcFsWpzCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789085733; c=relaxed/simple;
	bh=KyGzNqlYzaCLqqCEXbSxeHXQyzRNwO6WHpd9UG2GgAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GmwFXgxZUkLBeZjm82waBvIJYU1ExitbkgVnnnJsprF5XFmDRJpw4hJToYKVFP2O0+2slE4lU23qRt3fuP3GSEirSCtR/L2Pp8KGeCpyW0cP58Jh6xoVMwT8PYVEtaibeK1o1/bC8Muppf/LjFBbRo3zuoLLDamcKJlmFhwkSc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fB0l1PYE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fB0l1PYE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 257431F000FF;
	Fri, 11 Sep 2026 00:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789085731;
	bh=eY0OkNmzystQan27SJLsi9Lbj05qeJjdjBKft4Fj62A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fB0l1PYEEsaI0QY0Ssb0RDYZy0BePXXqD2DRNh5+uAin6/9gXK/lA3+CX5Wxk5aKr
	 ZRcS1UiYc5c+SThQFfU2hp0UNDauAU3KH8vkeekYIrP6CVqmnVa8nAzYXj/Lxo11oS
	 NTvlGbpzQhIGUNnzJU4fJMkYBdPF0uACRI5/Sy26p5pQt/YJI0itxYQr5HzELA+6pR
	 3C1qkWWJwoVAQOQrNdQpgQzzakWNawDFakb6Ls9pYyFzzwfuhnIC1k+HgoHm+AiHWN
	 VajFDxqmxjF0cibYmqVqlNFthSRNJO/V0HejCzpcUeHO8q0Z6t/gM3MX8Ms18zpbeF
	 grT5WgDdJgSdw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Tony Lindgren <tony@atomide.com>,
	Wolfram Sang <wsa@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/4] i2c: omap: Improve error reporting for problems during .remove()
Date: Thu, 10 Sep 2026 20:15:26 -0400
Message-ID: <20260911001529.3302151-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090910-covenant-freestyle-77a9@gregkh>
References: <2026090910-covenant-freestyle-77a9@gregkh>
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


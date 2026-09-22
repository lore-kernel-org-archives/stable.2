Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D514568FCF
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 16:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790095837; cv=none; b=oM4WbUOAj69i9WIeP8s4WALQD1O/JwPpBMdtsgejMAbvNUsEm5HeXIDHpxpJJ+ofp3gvS8tHK5sC+JznYWvJ8vzWrpiVXyC46s5oyde5sazjylhRh3LwaPgxhwUwQ+s6jHdxUXysyqVKHbNFSmdZbDA+V3lvGAhHBnPDEr+1lRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790095837; c=relaxed/simple;
	bh=CJbTFFtyQ2VTVKfxlAtjsABhtNf5RLraifLZhBip06s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R4xOgIuE8FvpLuo9xChouLm5k1Rqxh4ZcGcvuJmJSWyfrPDJAt+67M2pCi2ec7KulJKB28ZtVO59fXHxmbtcY72K8/FnvyCi47gcy5e1hziFxV7fpbcO6CRZPNhgDtH762NQJzcpOy0wHoFrq7WTbEFt4OHv6YYg+UaMizpXLOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJoh5wZz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJoh5wZz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33AFF1F000FF;
	Tue, 22 Sep 2026 16:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790095835;
	bh=qcJM+auU4tlyDdgqqPCbJ/K8c0oScDZ/FpdoW8u9C+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZJoh5wZzBifJk6jz+R+L46cwU4wJsSjwnso4PT+o2XuoluliZ198vhyB+2y1rSSXj
	 a4AoQaa7g5GzepOM6hDkI/FntkCZsP9SDSpEX6jokkgq/hbVE1PMnxAzvBnrSD9rtD
	 USuhxaDn12xocG5y83p0tdUqeRXgMxhU31UddkS29GIm4ZABRItt1PrZSlERowhbE2
	 zDOSEKL991j0+Wk6XDZi0TsMrLAQTRYH9ZTYesWvqaK21PY8C5yIFCIi1edgdgNh97
	 e9yV2oaD15QYPhSqwATEqI/YcMhhpj1WmYiJsuQqAcoczXvcMnobgqz6mW+P25XWvZ
	 vrSBYRNgLnCcg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Tony Lindgren <tony@atomide.com>,
	Wolfram Sang <wsa@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] i2c: omap: Improve error reporting for problems during .remove()
Date: Tue, 22 Sep 2026 12:50:31 -0400
Message-ID: <20260922165033.3134020-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092238-babied-brewery-a086@gregkh>
References: <2026092238-babied-brewery-a086@gregkh>
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
index 256fa766b1d3a..7378467c2babe 100644
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


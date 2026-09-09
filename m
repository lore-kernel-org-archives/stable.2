Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF95853ED0E
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788952919; cv=none; b=rpZwEc5dAMdkUGubNgv3EnV6mJJRlVTWu2kpqvAWGl7G5ibFBgdgYLQ7t9/Se9jUgujt2iKyBtCWWCpchoKi/GVt6mK3Wga1r2p5+hVH8C1QfCj5NDVaeQ92CztmsrUPtTARvC7YmkuEr2yMymzmoXBmFXM0/Vsv5tN7prjH3Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788952919; c=relaxed/simple;
	bh=ptbK9ACAPN4Ub3nyse1u/YuLeOtB6UY0p6gzR0RMKVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dTWSVR5XaGPoATsOsR6P8iGsYP+kCR+Jhq2vN3K86seAYbeJlFTy70K98oRqiErVwuLqzlY2okSlZvT9Xlw7mXtxmWq5jChJHF6aFR5NRFeY4BhzyjiE8iXmukhksalRgP1VOgY2TSvYJJLL5aUkKM+b7qORDojFRWSJguzOypY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7eRusz4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7eRusz4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B94F1F00A3F;
	Wed,  9 Sep 2026 11:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788952917;
	bh=GIYuvzhr0612RNK6oyav4ePZ7PMZreIwc+gakjmaf5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h7eRusz4JvVM/YGCB/tfZ1kVPt2EQQF5ro/oGj72HgDUYEQUSV9A6beeJt18ZWRaQ
	 jK+wTuK31jybkARDNAmviKw/LkuA4+7E57jN3y4SB2+u0F5Z6l3WcgfeHswuSU/0xF
	 5irtB4bUAaB5dyYzOLKsHRLViMxjYTBB9A7mwn//KAwnhT0ewnJD7Ign1+qxNDo2wI
	 ye1jC/G6C3QQpzgvM4V0ilTnIvsV/ig1vWYMT6qhwsxJ0VcV6SKew87+QWWxBBJB0M
	 g2F6Ud1Nue3bOb/tMnu/60FpFdoGL//Cc6jAfucyjowK5x+T0y4MaAjmKoLaxaDXdD
	 iwM84/pqzcrNg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 4/8] driver core: platform: Emit a warning if a remove callback returned non-zero
Date: Wed,  9 Sep 2026 07:21:49 -0400
Message-ID: <20260909112153.1816689-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909112153.1816689-1-sashal@kernel.org>
References: <2026090353-unadorned-buffed-09ad@gregkh>
 <20260909112153.1816689-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <uwe@kleine-koenig.org>

[ Upstream commit e5e1c209788138f33ca6558bf9f572f6904f486d ]

The driver core ignores the return value of a bus' remove callback. However
a driver returning an error code is a hint that there is a problem,
probably a driver author who expects that returning e.g. -EBUSY has any
effect.

The right thing to do would be to make struct platform_driver::remove()
return void. With the immense number of platform drivers this is however a
big quest and I hope to prevent at least a few new drivers that return an
error code here.

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
Link: https://lore.kernel.org/r/20210207211537.19992-1-uwe@kleine-koenig.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 831c29a12d56 ("power: supply: lp8788-charger: fix use-after-free on remove")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/platform.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 90166535a5c05..d0b15cbab0ff0 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1305,13 +1305,16 @@ static int platform_remove(struct device *_dev)
 {
 	struct platform_driver *drv = to_platform_driver(_dev->driver);
 	struct platform_device *dev = to_platform_device(_dev);
-	int ret = 0;
 
-	if (drv->remove)
-		ret = drv->remove(dev);
+	if (drv->remove) {
+		int ret = drv->remove(dev);
+
+		if (ret)
+			dev_warn(_dev, "remove callback returned a non-zero value. This will be ignored.\n");
+	}
 	dev_pm_domain_detach(_dev, true);
 
-	return ret;
+	return 0;
 }
 
 static void platform_shutdown(struct device *_dev)
-- 
2.53.0


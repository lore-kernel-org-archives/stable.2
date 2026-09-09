Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FAC4A013D
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788951446; cv=none; b=RldWBOfQYpZ+yuXmGK2ES0EpPfeb6Jic52g214K5Lxh6dKE6Kr9RfEGxhmcppIVYdpKmGsj8onp4uCsAAO7b4Dm/wQbhL2iVYLuFZgsunKkgFelVh+BMrrgZ14g80lgeH9jrv5I7kEfjJNUC1J0on8P4RG3rdjLB/jMXHDBoMgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788951446; c=relaxed/simple;
	bh=gs+1LGc6FtxtHQSgN8gcuegkWsmuxJ57KBLuDZlHj4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LAvd4ykGQF66DtD9XnRS3MkoJzZioNQgXodtde3Elel1jkJleev7Z5XSjoYlt4xeIgW6UDsCaZOop115k3lGVe8dpZqHuoYA23XWGx0BiMgVPkTQdvLjjwkDorMuQOK6f3rK23xjJvVn30xxS9f7IeGJyuvTCTvlTiaNsYOK8yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F81kNyu+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F81kNyu+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F0A11F00ACA;
	Wed,  9 Sep 2026 10:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788951441;
	bh=tO/qOUUvtaD6LruAb3uB1VXCFluslb8AwL4CH444ixc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F81kNyu+iGajDRxBXY9EUigmJb4RFvi+FDv4bgf7LaiTFIl7DsHI4KPxi2Ax0IQnG
	 WZDdkr/7Jd4rsTUoveT7t6uMLYauenNNA2UIVNsMfFcDniHv2mmYyW6ipT9HB8APmj
	 JiNDr6IATVCjmnlFj+cbXML1GD3w3VJAyJNzRulcjx12Sex+pkzwd638NXjTk7pZ37
	 nRIS+m7TqSmZw2Yl7YSBcosLne63h426y+2C4Rsyq6ddjasajvoue5refIpNxpOBqn
	 9tah0PUyKrGnuhJzWakO2pdjevky5FIEIXQWJwW9oDOhEvkbJWGc/n12Yk0EZZpf1H
	 32QeikinUYamA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] power: supply: charger-manager: Convert to platform remove callback returning void
Date: Wed,  9 Sep 2026 06:57:18 -0400
Message-ID: <20260909105719.1641631-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090321-bucked-down-2cfd@gregkh>
References: <2026090321-bucked-down-2cfd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 403eebf95c38302cacc48c127e575461f0e798be ]

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.
To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
.remove_new() which already returns void. Eventually after all drivers
are converted, .remove_new() is renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Link: https://lore.kernel.org/r/20230918133700.1254499-8-u.kleine-koenig@pengutronix.de
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Stable-dep-of: c57cb36f76eb ("power: supply: charger-manager: register regulators before exposing sysfs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/charger-manager.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
index 75df8c15df05a..a20e7aaffbaa8 100644
--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -1630,7 +1630,7 @@ static int charger_manager_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int charger_manager_remove(struct platform_device *pdev)
+static void charger_manager_remove(struct platform_device *pdev)
 {
 	struct charger_manager *cm = platform_get_drvdata(pdev);
 	struct charger_desc *desc = cm->desc;
@@ -1650,8 +1650,6 @@ static int charger_manager_remove(struct platform_device *pdev)
 	power_supply_unregister(cm->charger_psy);
 
 	try_charger_enable(cm, false);
-
-	return 0;
 }
 
 static const struct platform_device_id charger_manager_id[] = {
@@ -1742,7 +1740,7 @@ static struct platform_driver charger_manager_driver = {
 		.of_match_table = charger_manager_match,
 	},
 	.probe = charger_manager_probe,
-	.remove = charger_manager_remove,
+	.remove_new = charger_manager_remove,
 	.id_table = charger_manager_id,
 };
 
-- 
2.53.0


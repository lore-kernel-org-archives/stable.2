Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F47501F2E
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788951848; cv=none; b=ce0BK5axPiFh/rDy48hPm76q83iVXk+MOj2EXyZOHGYhmX5qDmmZTqdIlDYqld4zhNIRfpyCNWiwryf0J/o8nL7nWwT8kJ/vF/shbF4AkptjMvXdnCgsUSaw2oinSjaA+6ST9IgOsHZ9ZnmJaYuf4+Jx2XvSqJ/3v+FFswRpZ5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788951848; c=relaxed/simple;
	bh=6tzr8oblK3FVodKUqdPnTBwZSGrg0yobPW4lVDLha9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XwsQEhG6d7BBt2OU652LJKnMk7aP+HKXJ4Gmveiklj3/KLvSbprAkAHFquOBpvZscAdzL++UB5af5pZZq95geQ0cqT+Osqv/kHzbosvndeWa8geLxRqdBNw3ziFGGe50Dd7skGwIt8K0gHvYVaNgehETNldX1v4c4R7r2ISlV5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TaZv7y72; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TaZv7y72"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E24AD1F00AC4;
	Wed,  9 Sep 2026 11:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788951839;
	bh=R1hTG4AitV5dm1Qi0VzY4Ti4jev/p+hG508caZtjIkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TaZv7y72O78D6lYChyd3Cehs+k7/Kq2afkhqOTQlbOhVQB+sKTrKMfeR9+9GPCmSK
	 Z8AZFxNNtTPSt18xZIu+ajK95JwbwE7QguHc4xnQwOHpfZCUC3hpMZRWuwE4WvyjND
	 kM20iIothnAsaor9qNC4fqbeqEvaxfnqJz5DOXmFEgdazAQRwO9plZ5mnpqVjYc3hr
	 +1y6h0lPTfMce+xzZMtkHKGVk7hp4zsWJKe6w6SaxiOJuuutEN2cEPKe+cogReS83s
	 4FFi9lY9O8nPmcFBMkqPuUQp59QUbo4BSexOnHEStIUkVcmRFcLOjLXf5ktEuDrSoD
	 8ZQ4O9Xx+U4ig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] power: supply: rt9455: Convert to i2c's .probe_new()
Date: Wed,  9 Sep 2026 07:03:56 -0400
Message-ID: <20260909110357.1706595-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090322-duller-precut-e80c@gregkh>
References: <2026090322-duller-precut-e80c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 2adfc4370ebb745380a44c3e5418486a32a9ba67 ]

The probe function doesn't make use of the i2c_device_id * parameter so it
can be trivially converted.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Stable-dep-of: 3e7a1ebc32fa ("power: supply: rt9455: quiesce delayed work before teardown")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/rt9455_charger.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/rt9455_charger.c b/drivers/power/supply/rt9455_charger.c
index 566243a423c8f..dd4ff038814f4 100644
--- a/drivers/power/supply/rt9455_charger.c
+++ b/drivers/power/supply/rt9455_charger.c
@@ -1583,8 +1583,7 @@ static const struct regmap_config rt9455_regmap_config = {
 	.cache_type	= REGCACHE_RBTREE,
 };
 
-static int rt9455_probe(struct i2c_client *client,
-			const struct i2c_device_id *id)
+static int rt9455_probe(struct i2c_client *client)
 {
 	struct i2c_adapter *adapter = client->adapter;
 	struct device *dev = &client->dev;
@@ -1741,7 +1740,7 @@ MODULE_DEVICE_TABLE(acpi, rt9455_i2c_acpi_match);
 #endif
 
 static struct i2c_driver rt9455_driver = {
-	.probe		= rt9455_probe,
+	.probe_new	= rt9455_probe,
 	.remove		= rt9455_remove,
 	.id_table	= rt9455_i2c_id_table,
 	.driver = {
-- 
2.53.0


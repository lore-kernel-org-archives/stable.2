Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EDC5437EE
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788953302; cv=none; b=bOCe0D9vZyEZTJjH1H95aOh5ML35tjWZ9Myxtp5vPFjJz0uZGe0dJmiJp8oeVxgz5/CAekIOth52yhopP6JuUTWgo+0Wac+rs8lF9ypwj9IIgUvPkFY8EOZ3znDLdeuZGA9mFlbz+hYe2DDNO5aWJMHS34D5rkuikqV6MZUJ3bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788953302; c=relaxed/simple;
	bh=lVxJauST2mg0ubVKAIqWXfIIbqyMoZl4moLbOpVmIeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rQ0wUo5e3NG9kkbkGZW2+bVBkHjNiN985aeFescS+flfodeS7Mo0M5YtsOQCjwdWTE5fjzc4eU6RHPHXWtk9ADFaCCnkM0CFfZXkJN4P31o9D8cB4DiQ1hMfCEhfKgId+iEPN/cxGrvLVLa7s2TP6Iap5XYeAoaezybwOZf3uxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bB39Wli2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bB39Wli2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 650071F00A3D;
	Wed,  9 Sep 2026 11:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788953300;
	bh=2SnsFpsiqw6mlR4KT0TwcpRQdEOJyDh+NbQbQHwkMCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bB39Wli2b8/2DnFySUFZbJQDw3L4l4lFbxMjpIqpgy7SqnWKRddem+Wnf/++c3IM5
	 UEYiabEJ3pEJhifxQ5JwH+y8OvZm4l8uJ7paMDPGdZJCs5g/fK2uQpLDOGKIb/gCiC
	 +VaKWrCOb4+ZeYyY4qTnJj5Tcv6Q1NCuJ5BrBzHhHbnZ5vfb+pSAMZwL13QtI9Mdf1
	 4Umdqv0DYPvYYOOmtReOYpdCEaeKooBFsLhONILZRAItn4v444l+sBKI27SbJIJEV5
	 wD9VfftPwz89990E7bTpwg9bjxLgKaZ10xOflJrztNHvWE1fMOIx+n+EcLGn6klsDy
	 rdSIC/2NpX0zg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] power: supply: rt9455: Convert to i2c's .probe_new()
Date: Wed,  9 Sep 2026 07:28:17 -0400
Message-ID: <20260909112818.1847669-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090322-effort-tinderbox-8526@gregkh>
References: <2026090322-effort-tinderbox-8526@gregkh>
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
index 89b414fac6c3a..6f6adc7446a6d 100644
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
@@ -1743,7 +1742,7 @@ MODULE_DEVICE_TABLE(acpi, rt9455_i2c_acpi_match);
 #endif
 
 static struct i2c_driver rt9455_driver = {
-	.probe		= rt9455_probe,
+	.probe_new	= rt9455_probe,
 	.remove		= rt9455_remove,
 	.id_table	= rt9455_i2c_id_table,
 	.driver = {
-- 
2.53.0


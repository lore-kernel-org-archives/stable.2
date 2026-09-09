Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E937D5437EF
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788953484; cv=none; b=sIhNNBzGwjzmroBGa4rAlJKMSEQLvW27qqkAZ/2SbTgcoxcZGh1MYnGIUJ0TOaxInXGDs6wjdxVknjciu4H+nfQd12uUVvefnX/oEVNtBtRXGuhcIyvl87CtGtCjazq2OsLFNo/g8N2+Ods1lQtyxQQC1g/Z9hiMLSHFEPkND1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788953484; c=relaxed/simple;
	bh=lVxJauST2mg0ubVKAIqWXfIIbqyMoZl4moLbOpVmIeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DsCnv3QmRld27ZkqPARRiHscLDs14WrjxGapxFKoD4nw7/YLABamAHN5t8ufc/niq7Xs7arMldf0al4xfKeVmRXPhCVsuBgo2QnjS8Eq5/llmOwXe6Cz7Ox3svFe1yRnKNuB3XRt9JthZYRao08NVVLE3dDIuWxbG0dzZShJSIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NgzppiuA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NgzppiuA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D61C81F00A3A;
	Wed,  9 Sep 2026 11:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788953482;
	bh=2SnsFpsiqw6mlR4KT0TwcpRQdEOJyDh+NbQbQHwkMCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NgzppiuA4RawqlIDgaC2rilaqYNlcLUEh4RXJvkAsWzAw5psWZD24CIOF76a7RoLw
	 Smqo1tfgVl3KPpNq/4W2foj/UZSH2AMilAONNQFUdN1JWpSQw40aOEPGi4RWr14l4L
	 gukufjHHvfG7oEe/tpKSfuIeWZkfLMerIKCCbZbd9mWxez3lWbbO/kx58fd50EhLvO
	 UYdkvorkwETnfRTkIri5QEg9uoIlmS27QIDSZWbmEfSAM9K7mXNampffqE8c1hDcVS
	 ZQsQ2wjET01iwrEZaLR4iViZs/o2EauFvSoVHZ+B47JtV5vBdnwfIuDXpFyjq4XQn7
	 vnPgA8v/KWRXg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] power: supply: rt9455: Convert to i2c's .probe_new()
Date: Wed,  9 Sep 2026 07:31:19 -0400
Message-ID: <20260909113120.1865251-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090323-starlight-drainable-44b5@gregkh>
References: <2026090323-starlight-drainable-44b5@gregkh>
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


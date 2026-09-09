Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC39548545
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788954052; cv=none; b=XJ41kVRFJIjRqxZk4Z5QyJl9yXEXYjiegwJPRXA8vTR8cPipNvQpAjn3L3DM2yjjbBn9l5EnTfR/nCKb5WiS4v7w8/2h/2/SwdkHmISBTWS0SXBqiXehZYO0fvxQjw+oP4bK7+IqlV0fmhJLFBOTGTgTwfWMGc/Y2ssekikWZng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788954052; c=relaxed/simple;
	bh=1Wwlk+tOQIxQMV4ySFPo3C7mmr6k4t4ieJTv3Z3VV9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KUBhP1RmjOpqzce3TeaWxVsxS54O1FFMspXs0nbSqh8WSnGE+4Y089KmJe0kpBAuHLy1lsP5aQUKalGzEaUTctWZRCyeLufnm1yMJNXCoRcrpGiaKhgaAui/ZbiuWjl2cVmhfTlFPkPZNsGbXFL8pMTi4LvwHXv39gix1WDFn4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O71837p8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O71837p8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29EDD1F00A3A;
	Wed,  9 Sep 2026 11:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788954050;
	bh=8cit1UD/vZs5QuCYD/CIvsNpwWnKMOzLsHOR13yK6CM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O71837p8oLMo/Q951E0fffLTANL3YQ8eNGFTH+0955CLvW4wXfo6z+K1KtC6Ba0LV
	 8EiMBXpz9F73yLMIwWklnvvkLo5+Y1SJKgaMNQlEBZyIe5FHAhtrbe82o5Bu+DA7Uu
	 3dgx2MnoCB32DGAXEUpv8cBQyWi4ql2BNcBFwO9DjVv1+zgeHk18qOr3UT3sAsksXr
	 RyxVewJdWEd0c4FGhP8Hx3W6rBCZQJnsW+fw7Q76R3/IgHqIH/0w/D6vrfSNrItFtj
	 gVIY3kOIxQoO6emz7gyCi9BMTAU//a0KqVzS9ODnVhKpPhsOZRImSso2MLSaUmxy9B
	 Q8LMAlxikKMzQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ivan Abramov <i.abramov@mt-integration.ru>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] power: supply: max17040: Check iio_read_channel_processed() return code
Date: Wed,  9 Sep 2026 07:40:47 -0400
Message-ID: <20260909114048.1917822-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090315-stimulate-nanny-a782@gregkh>
References: <2026090315-stimulate-nanny-a782@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ivan Abramov <i.abramov@mt-integration.ru>

[ Upstream commit 2c68ac48c52ad146523f32b01d70009622bf81aa ]

Since iio_read_channel_processed() may fail, return its exit code on error.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 814755c48f8b ("power: max17040: get thermal data from adc if available")
Signed-off-by: Ivan Abramov <i.abramov@mt-integration.ru>
Link: https://patch.msgid.link/20251008133648.559286-1-i.abramov@mt-integration.ru
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

[Stable dependency adaptation]
Linux 6.6 does not contain the optional IIO temperature support introduced
by 814755c48f8b, so omit the temperature-read error-checking hunk and the
unavailable status/temperature context.

Retain the local ret declaration: target 659cc3d8d5ef uses it to propagate
voltage and capacity read errors without adding a declaration of its own.
Use ret for the existing -EINVAL default case so this dependency builds
without an unused-variable warning before the target is applied. Keep the
successful return as zero; the target stores positive readings in ret.

This is a prerequisite-only adaptation with unchanged driver behavior and
no added functions.

Stable-dep-of: 659cc3d8d5ef ("power: supply: max17040: propagate register read errors")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/max17040_battery.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index a9aef1e8b186e..13e82a1ab2aee 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -386,6 +386,7 @@ static int max17040_get_property(struct power_supply *psy,
 			    union power_supply_propval *val)
 {
 	struct max17040_chip *chip = power_supply_get_drvdata(psy);
+	int ret;
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_ONLINE:
@@ -401,7 +402,8 @@ static int max17040_get_property(struct power_supply *psy,
 		val->intval = chip->low_soc_alert;
 		break;
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
+		return ret;
 	}
 	return 0;
 }
-- 
2.53.0


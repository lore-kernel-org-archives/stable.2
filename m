Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC01F54EECF
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788955099; cv=none; b=RWksfaDKHijr8yNU41CPEYyiCA9XWXmVsk3IvZe8At7b55bdf85Jo5ea30ofe2MywuCocy577Xccq3Owv11ir/Wi9agxhD/PYiaHzxcoWCrPu/Ka+7BFDgVcPYX7rBZOJnGH1XcNQpExkDx5Ho5wg8cCHg3UlPwMtyXGlLBEqPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788955099; c=relaxed/simple;
	bh=JKdVzDkQ4L0AW9jMAfNcGmsl1ym4w7KIUfckvzMZ3zY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MyfobI6s9rPgB1BJ3GtoN+4H/RvYwJ/DsdC+c9XLPXulqKTlZ5Cpf5W084fBuAfcTOGgNk/J7MuYpB/hMZgmob0EEXggjsQ5cvHH3KlDstBtoPSFWwPN06q47BsTSFi5qquZruyOvRMQ9yu2H4au/Mpdvj6SGKSP53S4y+tgxy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ffAvxHTk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffAvxHTk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3DD91F00A3F;
	Wed,  9 Sep 2026 11:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788955097;
	bh=Qa5aDAAvMNW7SGkdStteXXlSyl2a0EE12BGOlRMJ12g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ffAvxHTkloTVY407GK1lt0GTvrI83Ve52htGq3JvBxvjoafO92C2iTV7pWp7fPtI8
	 Zq0mnRMoA7JVHjxHsRW5s3FH0lDhFsYO9q7Gv4OERm6Va/zl0Crh8WG+aR3oHLtf2+
	 Afo+e4VRtMFOLA13o3yCJ7+08MzSL74Vt9ebyo40LI/VrVd1D1RzIfxvX8W5/WKInN
	 k9944jZtVYREf4HgCQVqS/CcsSrSfbcF0l7wFpX7hZuk1jCYpPe8102Lwotv8TvmB5
	 CHlYmlaUM/oLHyBMsPSJC2tIN+HJOtopZwNUUKl/+x1pLJVQHwv/KxbCckfj/a5Nf+
	 Q+VUU1QNYC/0w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ivan Abramov <i.abramov@mt-integration.ru>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/4] power: supply: max17040: Check iio_read_channel_processed() return code
Date: Wed,  9 Sep 2026 07:58:12 -0400
Message-ID: <20260909115813.2181976-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909115813.2181976-1-sashal@kernel.org>
References: <2026090352-handyman-delegate-c138@gregkh>
 <20260909115813.2181976-1-sashal@kernel.org>
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
The 5.10 driver has no IIO temperature channel or TEMP property, so omit
the temperature-read hunk and its unavailable supplier-status context.
Retain the local ret variable required by 659cc3d8d5ef ("power: supply:
max17040: propagate register read errors"), which uses it without adding
a declaration in max17040_get_property().

Initialize ret to -EINVAL and use it for the existing unsupported-property
return. This avoids an unused-variable warning before the target is
applied, while keeping successful callbacks returning zero even after
the target stores positive voltage or capacity values in ret. No driver
functions or new properties are added.

Stable-dep-of: 659cc3d8d5ef ("power: supply: max17040: propagate register read errors")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/max17040_battery.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index 8b2f0726ef0c0..fad244a73c8ea 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -392,6 +392,7 @@ static int max17040_get_property(struct power_supply *psy,
 			    union power_supply_propval *val)
 {
 	struct max17040_chip *chip = power_supply_get_drvdata(psy);
+	int ret = -EINVAL;
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_ONLINE:
@@ -407,7 +408,7 @@ static int max17040_get_property(struct power_supply *psy,
 		val->intval = chip->low_soc_alert;
 		break;
 	default:
-		return -EINVAL;
+		return ret;
 	}
 	return 0;
 }
-- 
2.53.0


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A13548549
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788953506; cv=none; b=uodv0JSFxfxst7GHW5ZdOz7DEfgwpSxkORXIdDTdG50RRTVheE9Ueb0FMiOQ07v3jyxo/zWIpAAtOOwSdbSydJzoDIHtkExZj/WbA1EVPBwkFOt7++zpcNAjfGNz1IGPe20ccXKmLHB4Llgd4VA1wQskmzCvTp929ddcYZ1VXPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788953506; c=relaxed/simple;
	bh=1Wwlk+tOQIxQMV4ySFPo3C7mmr6k4t4ieJTv3Z3VV9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sSudvJTLwxg0akyf4PVpkyKKAmNklleiytOZ746U+EgqT/S3zcs7KIhiNK+m/eL52IhTSZQraYnuK3UmM9aC0TzBjpLVi0PCeHalF9qDG0WpaQDlg6GvZr4rqPoQCLtM0e0RDwyPxWtexYpf/iul5Tfzcm9POEl+FopAJbMn6fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DbbwKggM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DbbwKggM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62F7D1F00A3D;
	Wed,  9 Sep 2026 11:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788953504;
	bh=8cit1UD/vZs5QuCYD/CIvsNpwWnKMOzLsHOR13yK6CM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DbbwKggM1eUty1wb8WP+36GnKgwdzbTnU9fF+V3oTbGDqSJmAGO7r9FFJRJXeYA5d
	 EX2wGoY8euW8UnYMss9EKnenAbHfrpNVUaIwzsANwnTzS1udcADbWrY+eLeRRteDcn
	 uKeLZch7131WRuhp32P8F4Dhusx9OaH5U1pB+DOdFBJa9bzmrAmLl5XWc7Qr4bEuCu
	 ZE3CX7BvnQE9QfLtlRMKc09zqYrei5G1DM0faN9Xca6l+lUJu3NjKEGAnakBLKefcE
	 qIUMkU81fNOZ9UQ87Nt+Bsrd/DwrOcF9NlR2V+7ewoiVVcUozJa0yDzR7zBJhmKooM
	 9drf+xIGabLlQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ivan Abramov <i.abramov@mt-integration.ru>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] power: supply: max17040: Check iio_read_channel_processed() return code
Date: Wed,  9 Sep 2026 07:31:41 -0400
Message-ID: <20260909113142.1868881-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090314-unplowed-trance-1ff3@gregkh>
References: <2026090314-unplowed-trance-1ff3@gregkh>
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


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794364000;
	b=RSreYCIYTguSVH4CNCZqLLOs5m2HPu12W6G27WlLKpQI0zqw1ZKHnx82qkV1eJydHLBO
	 M31/SJkcDKfs/ZFus96gKAHEID6f1kykGpVpZ51D19Wr9PBQbMvKXHSbcpcqUCz8abeAQ
	 k/JYzo/rDfqykbfaaDTnKuq29wG8upz6b079uwhS7LblgZg1bCDFgJD0LJO99+oN9nS2I
	 vPguiXVYW9x1zLOVoVzGmOawulrZKK58wM93wBriU93mqkWoeUpVcCCV5/+muCnEe05uv
	 kfqOSsoyhOHYd7xL3FNaP0wGCwpN9p81pauBD/kGhFLSjIQ5f2o3hw6NhtPfsPTQU0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794364000;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=l2UEg6JTEzIdUxl72Yu0p5wPhgKBV2ZNi/zq8LOAvgM=;
	b=5tdI+onKkXxmesXZ6A2abWQ/h4XvcWue3FuObCuI/JpJhto9D9T+URDrasb4gfoh8e25
	 UDidGD9jguQAW5TBKoEnUaftAoBqb0xAipAbPbTMGCxjeqqNqPbWSjUJ1hj0SnzuBSHWZ
	 tNOK1itTR+LsRXVk/q95t2PS8+NP/chx3cIz48LXpWK14/VDFf/FWd86ee838U63xy/Sg
	 VsU+uItqK8GcT5HzcQQrJ8o3EmFtz6EB++bgJ9BkhqPinB/4FsnLGws8RrJ1jJJ/obZcU
	 aee5/jxhgd6/pH3Pd5RVfCkNTeMTsPTJK0gIatrY0ls82WuTtzNvsDTJP5Ch4utadbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J9LQ81ii;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF59C606A33F
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J9LQ81ii
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4495E1F00A03;
	Wed, 11 Nov 2026 02:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794363999;
	bh=l2UEg6JTEzIdUxl72Yu0p5wPhgKBV2ZNi/zq8LOAvgM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J9LQ81iiHqGWp3ozxkOGlXD5fHMqF09pjhnapMHdeiYG+bRGhbxB6jMJfXJtcavUT
	 h7cm0jQl8G3TCUDBXH4yZqzNPTRmWdxwpsfxYPd9/GdIhtSNSGHWcC//S3A9cVEUM/
	 JwBIwZrvYW359WnEG6gq/w1zSgV+QuanrtDhncjZWToyTcmq5zN9pJrbcBMcSfy8Mb
	 y16na/F9pAFmanVFN1ZmU0mHio2PfU7S5sKCVVMUifRtbk1bu8d7DLdpqwZwKYIOPb
	 id3oQZVE/NBdsN4UVWJa22lgODT5ixCE6wvDR5Iu9bXIn1KkmNPPUxiImPaZfCLGtb
	 fok6JBYvJsDpg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/4] power: supply: bq27xxx_battery: register power supply with power_supply_register()
Date: Tue, 10 Nov 2026 21:26:35 -0500
Message-ID: <20261111022629.681261-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111022629.681261-1-sashal@kernel.org>
References: <20261107051652-failed-6.12-db560f4b1c52@kernel.org>
 <20261111022629.681261-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Thomas Weißschuh <linux@weissschuh.net>

[ Upstream commit 1011646d4bd6c2eedb68d131ba7ddaf9ecd2aa9e ]

devm_power_supply_register_no_ws() is going to be removed.
Switch to the general registration API.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
Link: https://lore.kernel.org/r/20241005-power-supply-no-wakeup-source-v1-4-1d62bf9bcb1d@weissschuh.net
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Stable-dep-of: db560f4b1c52 ("power: supply: bq27xxx: Ensure poll work is cancelled on remove")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/bq27xxx_battery.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 19c73aad769a5..fc76fd9e2b96f 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -2163,6 +2163,7 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
 	struct power_supply_config psy_cfg = {
 		.of_node = di->dev->of_node,
 		.drv_data = di,
+		.no_wakeup_source = true,
 	};
 	int ret;
 
@@ -2189,7 +2190,7 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
 	psy_desc->get_property = bq27xxx_battery_get_property;
 	psy_desc->external_power_changed = bq27xxx_external_power_changed;
 
-	di->bat = devm_power_supply_register_no_ws(di->dev, psy_desc, &psy_cfg);
+	di->bat = devm_power_supply_register(di->dev, psy_desc, &psy_cfg);
 	if (IS_ERR(di->bat))
 		return dev_err_probe(di->dev, PTR_ERR(di->bat),
 				     "failed to register battery\n");
-- 
2.53.0


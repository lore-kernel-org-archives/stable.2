Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794363999;
	b=VKRq8YoYCsDN8/fACHpPERvPd3u/xVmqh1r9GTbmIH1QQA4gJOnHDPijq4gS/f+Lo9U5
	 e9zrsYXhrPT7qSEaZY9Y1TW6ULv0mlcfnj0Q3AqTzF8EmVJRMSpROdhXEEzPxErOl2T/e
	 Vy4QL2v7EUVoRPX8YEjIabfwVFmpQSq0iDLROEdYLjyZzlyKWueOsloEyY/hN4sbHka3q
	 NObs5WI+tD4+1XvEaARMlLDOU+yY+zuL5KjpUBLJdfnJ1PufX/tGrpxNmKkPNg02PbnHp
	 xCMmkxaPCQPapQbuz+KF3bxFwQNv7lzOXDKqKUqnoTZh/0iNAU5Y/Sc+qZ/pYO285/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794363999;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Q2qEb96ACmCb8wLRCtUTvXcfMYvAiiW6aWzzpm+65EE=;
	b=muN72bRLum+IEZWYQ+mmKFRLp3Tgb32ZooQ4YNJzpOETjpX77evAcukxzc/DZ+H9Kam7
	 VmT2EvOk1AVmpQlk8IvV0OgXJg/R5zqYjzFWnAh1x+QJpqdQpF785mf0Xq3xAXJ/nfKTS
	 tyx6r7wdXuEdLTUVoUuR7lpXKMp0PfR9YRLKbUFh++HBN0GlEbeOLrPkXNOlOII27VosN
	 X62o0M4mkneC7i7jpdgmFrSjuxnV6MTtudkslS55lPOibcDgoSwbC0zbAdFY6ZH8KyhTl
	 fIiOwWRh1nW9icqimXAiK1jEC/pTH4ENilBT76HEC+TqFtJEF3lUTHUXrYeBgB7Fnxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gT7xfbdY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D32A606A320
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gT7xfbdY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70DDB1F00A06;
	Wed, 11 Nov 2026 02:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794363999;
	bh=Q2qEb96ACmCb8wLRCtUTvXcfMYvAiiW6aWzzpm+65EE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gT7xfbdYxeDtNKoKsHjA8cwauiwf8D/0/X9+0HlBZcKH3CqBpES8rzeOYGcxrS4E+
	 7e362hpEZf777BCsBAdQLHQOLvLJ7qHapbRPJeCDSnhmVJu8ckkBIOutkkOw3EwtFp
	 rpNXIsJk7faP8Qsa5xLkrHefV3AKN0ZQ8bXKfZY317fhi2BbvlJHy+lw1z6Qo5s1BL
	 i/SS53Ua3kaLPSMwcEZNGPqC46zZ1ZxIhY2BaVphBXD5+wUNo9TdVDuy8gNislzIfP
	 fWq/v6HxbnjUcNpGjXwF8Ozqij7iY3u884LWp94mUUE9+wJp8DhYlYgOjN+XmPc+WM
	 KGaLb3T92Dkxg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/4] power: supply: core: add wakeup source inhibit by power_supply_config
Date: Tue, 10 Nov 2026 21:26:34 -0500
Message-ID: <20261111022629.681261-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051652-failed-6.12-db560f4b1c52@kernel.org>
References: <20261107051652-failed-6.12-db560f4b1c52@kernel.org>
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

[ Upstream commit 49000fee9e639f62ba1f965ed2ae4c5ad18d19e2 ]

To inhibit wakeup users currently have to use dedicated functions to
register the power supply: {,devm_}power_supply_register_no_ws().
This is inconsistent to other runtime settings which can be configured
through struct power_supply_config.
It's also not obvious what _no_ws() is meant to mean.

Extend power_supply_config to also be able to inhibit the wakeup source.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
Link: https://lore.kernel.org/r/20241005-power-supply-no-wakeup-source-v1-1-1d62bf9bcb1d@weissschuh.net
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Stable-dep-of: db560f4b1c52 ("power: supply: bq27xxx: Ensure poll work is cancelled on remove")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/power_supply_core.c | 3 +++
 include/linux/power_supply.h             | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index edc7b3bd9b5c8..e51ad6dadc165 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -1403,6 +1403,9 @@ __power_supply_register(struct device *parent,
 	if (rc)
 		goto device_add_failed;
 
+	if (cfg && cfg->no_wakeup_source)
+		ws = false;
+
 	rc = device_init_wakeup(dev, ws);
 	if (rc)
 		goto wakeup_init_failed;
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index b03991a29a65e..36275c37f1f2f 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -236,6 +236,8 @@ struct power_supply_config {
 
 	char **supplied_to;
 	size_t num_supplicants;
+
+	bool no_wakeup_source;
 };
 
 /* Description of power supply */
-- 
2.53.0


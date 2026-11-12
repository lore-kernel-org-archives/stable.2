Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794460439;
	b=QYdlb9+r68fIcRzsTsx3wDWU+8eetQFD34VzVgfma5n4cx3ux+LjvanfWUDNh7Lcx4Ld
	 m3WNaoCnRXnZKgrIpo77i2mJxAibYIrczJ1Q1U7SdNCesPtBJ+kd6YpDXzkSythSphY6N
	 0SgqGwiCNN3hIAA26VZoQVc0Z3J+gjOaHBg0Z56lElygepaHYRy8pT80SxneBUSbPKUS0
	 HuOYEBSO9XRDhDFdUbDxBL2JHCgqqhIofRg50FEC2mP3S72urhyFrQJVO9NOrxkojs8B/
	 mrFH1Uw0Pv8aSoyMk/AGXDzZebjfvO4j0eWxIgWMDBrsF2dENWNMCtNICPtb5/l6gPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794460439;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=tt6qLCDaUsdXbwvOq5OWWWV31cFIM636pb4hA16NcGo=;
	b=xexQ7OhRDamSYfcI7Ss/q/BJya+oWRdrSJWxvck8h3Na/3BgF4iFUscSiVvEJq/3rl0W
	 EoVc+YmopPzkJOFCz1Zqce6iboRKDSuTXg9X104tr/RQQRfTo4kXW3Bwol6ThK+cdnJ/a
	 bqztlX1NeoLnZMNpLmhrDAXCEsrnCdluPdRm6xT+fZukhWQtRtEufuwCvoleC0X8HzsQt
	 lgy+cw9tDJllN2hgKV1pVOonvkyJiGcoa3JDa3F/vF9xT3SNkFE3i9s794l1fwjYas24/
	 qrnPuH5eziP2XZu78KOYEeR/61luAYeG9QeyN7VaJVb3XE6sZxsOCG8MmZKtJeh/ycQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Ees/huBs";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF61D606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 05:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ees/huBs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07A811F00A05;
	Thu, 12 Nov 2026 05:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794460439;
	bh=tt6qLCDaUsdXbwvOq5OWWWV31cFIM636pb4hA16NcGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ees/huBsTzGm0TQqN2EphhNChxl93Oltei8J3JG/er51hQuRsfSBTYpolWK/dXoOo
	 VkJQB06VVGUXCFM8ajGlcVWAqIyZ1cgjm+sb5cgQUxFHUmuTRBstjBObZaiZkclI7D
	 KZDW62L8ShGyIisGqFFSia2KoC2cutWCsBQef0m0p9yKnULXKvDaaXg6P5R7insOEl
	 vq56RkV6uhkD2heVBLm3jURX1gRW89qZXBICGWDKdIQv64pge9BO+/x2glkQWZzGJx
	 KwywdvMUGGWALrTx0f+sGf+bDJQKn456JZN2G/GHtNzvthtXLuX7jLQ4YOd0hlvJQR
	 JmdVe7gezVy0Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/3] hwmon: (chipcap2) Drop unnecessary include files
Date: Thu, 12 Nov 2026 00:13:55 -0500
Message-ID: <20261112051344.2630398-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200334-failed-6.18-8c02722be2ca@kernel.org>
References: <20261109200334-failed-6.18-8c02722be2ca@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guenter Roeck <linux@roeck-us.net>

[ Upstream commit 4c8d758d4ebff3780d09599f2c8db5d6af3ca2af ]

The driver does not perform any locking, does not execute or use any sleep
related functionality, and does not allocate memory. Drop the unnecessary
include files.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Stable-dep-of: 8c02722be2ca ("hwmon: chipcap2: synchronize ready IRQ state")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/chipcap2.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/hwmon/chipcap2.c b/drivers/hwmon/chipcap2.c
index 5f4b0fd535af8..a3d5d99bd57ea 100644
--- a/drivers/hwmon/chipcap2.c
+++ b/drivers/hwmon/chipcap2.c
@@ -82,7 +82,6 @@ struct cc2_data {
 	struct completion complete;
 	struct device *hwmon;
 	struct i2c_client *client;
-	struct mutex dev_access_lock; /* device access lock */
 	struct regulator *regulator;
 	const char *name;
 	int irq_ready;
@@ -570,8 +569,6 @@ static int cc2_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 {
 	struct cc2_data *data = dev_get_drvdata(dev);
 
-	guard(mutex)(&data->dev_access_lock);
-
 	switch (type) {
 	case hwmon_temp:
 		return cc2_measurement(data, type, val);
@@ -612,8 +609,6 @@ static int cc2_write(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 	if (val < 0 || val > CC2_RH_MAX)
 		return -EINVAL;
 
-	guard(mutex)(&data->dev_access_lock);
-
 	switch (attr) {
 	case hwmon_humidity_min:
 		cmd = CC2_W_ALARM_L_ON;
@@ -726,8 +721,6 @@ static int cc2_probe(struct i2c_client *client)
 
 	i2c_set_clientdata(client, data);
 
-	mutex_init(&data->dev_access_lock);
-
 	data->client = client;
 
 	data->regulator = devm_regulator_get_exclusive(dev, "vdd");
-- 
2.53.0


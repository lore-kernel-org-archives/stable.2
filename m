Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC6F37E5D1
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 20:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789332628; cv=none; b=T6xqRhfXWALRBwv4YkPq11vdUFDPKUOrFZG99ciGwA/0omdIQK02G1aeLMN8FszC1Jd1pLaMsFBfMDpPxeo/vBM4cVRmGfmH2OzcPWTKbg8JyoZyZL3/rmG7i8BK5PBmsQ2r4mEkGzTw5QL44RH97GXruX62LFuK28PbEvxwC+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789332628; c=relaxed/simple;
	bh=cjSdxH7baFihtM/V1AMCnUMKfob28Q3GgdzY21w2Wkw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XpJvwi6YYqSUSg8nmK/lCAku3ECcDD8FeaXUUdUIvWpQYQWbMuMC0sRG9mlsWqFKQbUhT0gQ4BDrVYWxx8ekEP2fYqbqToKxVuAcB2ykj6x1IHFP1ZCd7XkB3qM10/kKUcHRohsmJGlp4sM1DQvMr2ZkL2OzXPf6djBTK+oLfH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rgYAjW+p; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rgYAjW+p"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-52fb7692a57so16535901cf.1
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 13:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789332624; x=1789937424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FMTgWivp0e7gelEPDHuWnCELoEKFxvhsWudexAHdLaU=;
        b=rgYAjW+pVNZoKaN9MRpHGtgEaRWlfwxDn5USyH4j+xgkWLa0f+idy+PW83mktI0fWA
         F5Z3t21dSe0Gnj/jl/EGeFLS2MccVIMrBWMLYG7gfqpWb+tmc7VToz+nD4ZQA+80Nmag
         dbgowVCqAaH9m9SDJFluappms85Tc+dkEvL8DoAkFZhl6asn8DicYq2B705p0grGFrvT
         T2XtnmK2/jTNKXfwB88wr293pUkbnc3Esq0ysyRMh7hK9CVTzhSiikXQpMvbSb6C1BF7
         VkMqq1l+2UTQvPjd7KiJ42+6aX7IMI31JcYNadwaWmeWlxg8KTGYc/8H/gOOQZQUSMJ4
         vhAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789332624; x=1789937424;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FMTgWivp0e7gelEPDHuWnCELoEKFxvhsWudexAHdLaU=;
        b=S4IzetQvXkPbQVSX2O/cDyFuVbuKWJSbTuhYO10WPz04dvdLErEZwJ7A0aCdfx0fcS
         0XEMWNqpNOEjaiboDhD664T27W2mP3lZC4jQcWoIotYa+M+h1ys7Il/QJ9TmUMOQgDZJ
         cBdgvdX/R8LUjoLwjXJfJH7lTmaFWxud43nlYmSnDPV8qOOLI0lycA1LsuuV8xbXcMzZ
         weG650fGmGj5ix2sH4lGaZWtSl58Ui806T/6hhjbbUT7PSfq0Nu4HvuhT9hkNFmCrD6J
         Pm1YZAgp7VxvUFoNljtdcr/CEV+QpnQIhqunBE1YfJZIoxU4Ybh80Y6NTuOLYv92jS6X
         +56g==
X-Forwarded-Encrypted: i=1; AKwUvBzKW12WzCRgz+i2VP6GyZoK3WdbgwglrMCcwpjrrQcOjoSSr99FksP6Ok4+YeWDt0jHUonxsOg=@vger.kernel.org
X-Gm-Message-State: AFuF++kK9yKyz9wnOXDRXWotvJ5KL9I8OWrIxAtGsbpS2iQl0oSIQOpY
	/A0MczKCYpC7xFVayURJL+naj6T/xNmcxSnEbK1pSsF2AOFB2YbAbCw=
X-Gm-Gg: AYBFou3WdRc5RHGUQ54I+K1oMpe1kxr6Yf3mk8g1DR2nXFSN0eNtj3MwAKzHZoN8AZ4
	tZO9j1+jiqxtgJpp1DcaG5pwrUJosEdDpbTWEPsC81scF/1we/Owb+AvRgf6eV9YGGHgLpQNaDh
	adVzseeItRShyIVzCKa44lcl6bIblvntjaFc3y51gM4slCEYpcrlJfJUn0emmlkdeinirzaJiib
	k4cyVlborYpDLinj1IcUbcAlanvYFKvEcTQaRjNItFApQTBCdSRjZsfp1UuuP7beTdxq5y+NELo
	CevB3ETlz4suJjwe0nuuyOhLRYwAZYUdYDe3rG4Pp94zGElYUQpV1cjXDVMfnCjhUC0mOifSVsX
	HzuYXJUZ2vB6deHU+Q+klNgB4RAujsAVwCeSsPlZzMt7yLcu25fC+QyK8MyBzJ4/HN2aqAOyn5R
	AbK9NiQ00N8HU2QB281dobLHsuJcq3MlXhjqlNX5qriG86zp28JimqrdbZc7qYwulZyCSXTgZMB
	pdjWUAaOTtob5sthq4A29PBxS516rZjaq5u26ymBIjtN+od4HRVL7/+4jrCsxcuTuesI56DIYYG
	LGFJeU/rEhAPUORcwT0PVL6Gr9qmZn8s1w==
X-Received: by 2002:a05:622a:1355:b0:530:ba79:edd3 with SMTP id d75a77b69052e-530e832fe99mr121931421cf.62.1789332624296;
        Sun, 13 Sep 2026 13:50:24 -0700 (PDT)
Received: from localhost.localdomain ([104.39.73.78])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530ca4ba156sm79460671cf.19.2026.09.13.13.50.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 13 Sep 2026 13:50:22 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Lee Jones <lee@kernel.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	linux-omap@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] mfd: twl-core: unregister the auxiliary platform device on unbind
Date: Sun, 13 Sep 2026 16:50:12 -0400
Message-ID: <20260913205013.54777-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

twl_probe() registers a standalone platform device named "twl", but keeps
its pointer only in a local variable. Probe errors unregister the device,
while successful probe leaves no way for twl_remove() to release it. The
platform device therefore remains registered after the I2C driver unbinds.

Register a managed action on the I2C device immediately after adding the
platform device. This unregisters it on probe failure and driver unbind,
and also handles failure to register the action itself. Remove the manual
error-path unregister to avoid releasing the device twice.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: defa6be1c821 ("mfd: Fix compile for twl-core.c by removing cpu_is_omap usage")
Cc: stable@vger.kernel.org
Assisted-by: OpenAI:GPT-5.6
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/mfd/twl-core.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index c024a28b0..128cd3f6c 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -719,6 +719,11 @@ static const struct mfd_cell twl6032_cells[] = {
 	{ .name = "twl6032-clk" },
 };
 
+static void twl_unregister_device(void *data)
+{
+	platform_device_unregister(data);
+}
+
 /* NOTE: This driver only handles a single twl4030/tps659x0 chip */
 static int
 twl_probe(struct i2c_client *client)
@@ -754,17 +759,22 @@ twl_probe(struct i2c_client *client)
 		return status;
 	}
 
+	status = devm_add_action_or_reset(&client->dev, twl_unregister_device,
+					  pdev);
+	if (status)
+		return status;
+
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
 		dev_dbg(&client->dev, "can't talk I2C?\n");
 		status = -EIO;
-		goto free;
+		goto out;
 	}
 
 	twl_priv = devm_kzalloc(&client->dev, sizeof(struct twl_private),
 				GFP_KERNEL);
 	if (!twl_priv) {
 		status = -ENOMEM;
-		goto free;
+		goto out;
 	}
 
 	if ((id->driver_data) & TWL6030_CLASS) {
@@ -784,7 +794,7 @@ twl_probe(struct i2c_client *client)
 					 GFP_KERNEL);
 	if (!twl_priv->twl_modules) {
 		status = -ENOMEM;
-		goto free;
+		goto out;
 	}
 
 	for (i = 0; i < num_slaves; i++) {
@@ -880,7 +890,7 @@ twl_probe(struct i2c_client *client)
 		status = devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_NONE,
 					      cells, num_cells, NULL, 0, NULL);
 		if (status < 0)
-			goto free;
+			goto out;
 
 		if (of_device_is_system_power_controller(node)) {
 			if (!pm_power_off)
@@ -896,10 +906,7 @@ twl_probe(struct i2c_client *client)
 fail:
 	if (status < 0)
 		twl_remove(client);
-free:
-	if (status < 0)
-		platform_device_unregister(pdev);
-
+out:
 	return status;
 }
 
-- 
2.39.5

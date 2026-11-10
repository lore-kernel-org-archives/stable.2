Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327038;
	b=vyAlitra89caCD5fWGDWax2yWpnkVT/RtfKF/Dyi7l/VMghSsbqWjQsVeMe6v4Hr3svL
	 zfOmyZMIvxSga1s0xPClMEn4Ke3g+CMOxaQF6AVhv5hFfNVRsU9klioj6uRAI3mOP9BWI
	 50saa971OiQdUx4Ohuo3r5U06r9bIgGTpOztggHmaOHSXbybCoK+g99M5p2a8EAOV974k
	 JlTPq5BVKjLcrp9vJMC1XlddymAnKP24xZ93AhkHY9t7FPmT7vNmoFs2WvpplScuGPa8Z
	 6glb5CS9mSubi8kwPVMXG+hI9WtDbcwU73VB1IquGWb+IE1kq8kFPYY0QmRy1Fuq6Fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327038;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=u9igyLKTAh3FUTyB/ncCIP4Parzl3WRDvPkG2cdN3KU=;
	b=TdTqJXhb1lzhfNANgko9n4Nxrm4nwQ2EksghNfZM/E/6VCz++6FjjOHKbSnwlAUIDFgz
	 7xvVOayf5llXd+l93/OdiTOGHDBHcbbXlaPqDYT+bGdQxrLY7tWn08FFGBUl9Sa+uC7oc
	 5TGAtTsOeCM2TSRqwoHnUx1cjSkNcKhVnXTX0Fj6p3yWFm8cKQOYZBuLCJfrSJjodJyMN
	 32t9QZBuShxrqfv83Kcc97nwL5zH9GSZGUP+dE8nAYJE1k6y+9WxnrQ+0aHaZ6RUmZsIh
	 VEEB/rLsS78OsXy68ObyOtfAhfW86gR7LdVRh4eGRgYOPtB8CM1K/eoBAhyM4VqdwjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dtPdkzDJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CEE60A2626
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 16:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dtPdkzDJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CA4E1F008A1;
	Tue, 10 Nov 2026 16:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794327038;
	bh=u9igyLKTAh3FUTyB/ncCIP4Parzl3WRDvPkG2cdN3KU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dtPdkzDJ7z9+cg4cey0D8To2YMbGaudIBknYIQoUqXGEVmvSHDA6j8aC+nPoyIxzb
	 8316vGgbcR0IQeBwp/Gjfr9RNPXP5sNId98h0NS3p7uAK+HLC0z4Cr6wuGfTaLrLzD
	 7JpYMMl2Nl2g9ebL++EzSf3qg+t28HTIYHIX7BPzbC2F8EHTBe3fC/TYhjJ9ksynNm
	 qR4ZIWi9SDLySHgSpVp3iHS+qs379ZcSkodjiutJIYD3yEdX//mZKknIQiK4hjshCc
	 xIefiREF47D0C2rlpumI42sg9m1q2/Dxo7xb0kkPu1jxz4yrNWKhbVo3A2S3uxKe98
	 gcx4V9cjnOwCg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/3] mfd: twl-core: Unregister the auxiliary platform device on unbind
Date: Tue, 10 Nov 2026 11:10:34 -0500
Message-ID: <20261110161015.2399183-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110161015.2399183-1-sashal@kernel.org>
References: <20261107060010-failed-5.15-3c5c55d979dd@kernel.org>
 <20261110161015.2399183-1-sashal@kernel.org>
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

From: Myeonghun Pak <mhun512@gmail.com>

[ Upstream commit 3c5c55d979ddcb0765ce531bc7ba173c87c8712a ]

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
Link: https://patch.msgid.link/20260913205013.54777-1-mhun512@gmail.com
Signed-off-by: Lee Jones <lee@kernel.org>
[ sashal: omitted the goto adjustment for the absent devm_mfd_add_devices() error path ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/twl-core.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index acfc0b96b4a1a..9b1ff86632122 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -757,6 +757,11 @@ static struct of_dev_auxdata twl_auxdata_lookup[] = {
 	{ /* sentinel */ },
 };
 
+static void twl_unregister_device(void *data)
+{
+	platform_device_unregister(data);
+}
+
 /* NOTE: This driver only handles a single twl4030/tps659x0 chip */
 static int
 twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
@@ -791,17 +796,22 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
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
@@ -825,7 +835,7 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
 					 GFP_KERNEL);
 	if (!twl_priv->twl_modules) {
 		status = -ENOMEM;
-		goto free;
+		goto out;
 	}
 
 	for (i = 0; i < num_slaves; i++) {
@@ -912,10 +922,7 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
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
2.53.0


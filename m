Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794326640;
	b=X1BNmVInJh+vC+eRjih2Td/2mvAN8heG3rat1GEgau9lC4TDlpQWx0dcRsOzMEsXbsv6
	 QwPZU9lNwUo7dRDyPvWTq1Rz2EqtOqPTqhrH+zOkvQyYUtpCdihiZjxUzV+Ue9ffypGgA
	 jDy5gCksatLP8htdcMJE06jX4P1T/iSF1sJafPLyOiyDqj9GdwGbVNzro0X/4GgMjOQ70
	 p7Ex60Qtld0f4K8Q/cXzf2EDMVMev5xqzm0C/n7g2MRKcbHNpfzQSJPB50rcF4/M4TiEI
	 GKRQc7A25jkFB3r303SmgGmLdpIaph/5xq/AXMg8npbrLxQWzwq5dd/TYhiaAHWYyLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794326640;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=IRXiuiwcGKTkPULcTDOfpvcUhYTQD0XlBSRvWHdozC8=;
	b=5fK/E/YWCKy9KqQtNCMvGZp6ueJL6WtJR2iD1Vth8JmuX/jdJeaHDRPwUWShKy1Ae8ju
	 I/Q+hhsGQsstV+bLJecpSFdDR8KKSiED5mSFtggVrFcJazLeekyMq6a+vn7U+5ortqyn2
	 j/ymjcYv+2IDAKnBRL5eqeK+XZHtI5coubmwhyHvPjmB7y/pky7dcUs9aW4MArJNVY774
	 Ymr7nL/QUH3p4WcX9zDnXOnmV3uAkPDZL1pKd9/J/7ROYFgXasUTUa1r99NqaL/U7GjfN
	 Ue39EO0vs8Ib+CQ42CeJTAxOhQz1NyZpauu/H69zL0VC0idt0amls211W5jCrw274NQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jod4Z+ID;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CDE60A2604
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 16:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jod4Z+ID
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46E4D1F008A3;
	Tue, 10 Nov 2026 16:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794326639;
	bh=IRXiuiwcGKTkPULcTDOfpvcUhYTQD0XlBSRvWHdozC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Jod4Z+ID+dAg/H2SCt5llYTIDuHMmN9liftBMWwd/ayKpxzww64ABl+Z7+9Xmio3p
	 5KKPsm9XTZnAdrPAWdbWBNI/MvYOXqq+oBwOL/8c4bguIpv56b8EsLSiLsfe9XKn0z
	 7LrAXwRO3QAzrV6dm7A+eEUIAY+GcuFfGM1ZD12FMqApcBPpLs/R4WWB5K2D0KQy2z
	 MxjolBuzvL0osVcnle8bueZCKPpMqYpynPdK+sGUUDA9EgY60pcbcgcWt6DpFu/24P
	 QbTV6M9JJUQMZBAuyUJa/ugzUjJ4Lcdv4ypL06q9YtxDM65whz+8mVVqk5xTcujA6T
	 ZYdUH6P7AByhg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] mfd: twl-core: Unregister the auxiliary platform device on unbind
Date: Tue, 10 Nov 2026 11:03:57 -0500
Message-ID: <20261110160339.2387037-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110160339.2387037-1-sashal@kernel.org>
References: <20261107054250-failed-6.1-3c5c55d979dd@kernel.org>
 <20261110160339.2387037-1-sashal@kernel.org>
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
[ sashal: omitted the error-path update for the absent devm_mfd_add_devices() call ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/twl-core.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index 6c589d71df2a9..703a6ebba7003 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -752,6 +752,11 @@ static struct of_dev_auxdata twl_auxdata_lookup[] = {
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
@@ -786,17 +791,22 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
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
@@ -820,7 +830,7 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
 					 GFP_KERNEL);
 	if (!twl_priv->twl_modules) {
 		status = -ENOMEM;
-		goto free;
+		goto out;
 	}
 
 	for (i = 0; i < num_slaves; i++) {
@@ -907,10 +917,7 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
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


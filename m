Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794324603;
	b=j0FEmKTjPFS8dfSC9Avhle2VBTREozNm6CWcdzjoyID1G75kNWCLi5boEjW267MfEesG
	 KgMVCv9Kls6i6wf8GrGIBmbRHGlxaVfASSh0wGMYDXrZkq340mZTtp4IDFqlD4XXCUSDd
	 khiceuXp3N+fzrS7otMSHUmKqFklq6F9r4hkYs1X7VKUWMbJv7t7anoXbVYLosMIGNOFS
	 N1T+oOTeggs6OxlR7lBTU7OOAaimaoK5E4Avh7ExYx46B1p/IX44QNV2HW5/YQdsLdxgR
	 XwmnLglYVHW8aAi9YpO+/4SIF4XZt8KHfcUGNcEnH05Atc+zEIwEk5+m/kVPqNSbyPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794324603;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=wYjJdSG0GkrwpZiveX9Qzk3gH/p1hX0J17/X73Aoqkw=;
	b=NEYt1eqWcpXBW1G0KQPF6jOdnZgHXsOOfaON9SwbXBL0Tb0Ha++hPli++KgPHr7LQzqI
	 DsPFpDrpsIlbNgk2Vx5VbNvkWmSG9F+sIgDruiw3ULrConx0bpeX1DP+4rzZKmiBz3YdM
	 tUPca8hLZfojURr0sZ4trRrn0tQOhcfqnC18K1AAN4rA+i6iLw7olh32cjNIUvVEt943r
	 1pt6G/62t1HWXaAYf0xzmrvNQQggH008W5jZPEggVbhM9VHPAfJ1y/mWME+PysfOKqPKb
	 r3MWf3/R7092Ht49yI/bxYAuXcbblTvCQspa5E1SryczKdVZlR/guNgDforzEcHDPgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GpjK3Cab;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C454E606A32D
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 15:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GpjK3Cab
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BB191F008A4;
	Tue, 10 Nov 2026 15:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794324602;
	bh=wYjJdSG0GkrwpZiveX9Qzk3gH/p1hX0J17/X73Aoqkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GpjK3CabVS1i1TPitozBqI/ApVEtcmd+yZL1FIFKPl1vQsPis6dAxxiZeYyEVE90L
	 Sz2QNi3yHoM14VjmP21rf2NA864Td45w7+1PAva8+ouyMMo6j0/ysN0RaB+byVI+5P
	 JUW/0DsQijd19v8jqQXwkKmEXYeNk0S4wy7KPHdoUaBleOSw+q9K/PSVhj47JB7/FX
	 GCaheyP7S3UPwpzQAT/2z4MvHArUfklOnCln5FMTj651FJ7pg3Bvt/YuEv+HTnmtFB
	 SF+Bzv5V3n9EKi7rqJTOHndG5cl4JLEe4RcGO+tNnXZ6z2qJ59ii4f2/2msWrGePCT
	 wke6UPxa3OUeA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] mfd: twl-core: Unregister the auxiliary platform device on unbind
Date: Tue, 10 Nov 2026 10:29:59 -0500
Message-ID: <20261110152949.2135243-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110152949.2135243-1-sashal@kernel.org>
References: <20261107050717-failed-6.18-3c5c55d979dd@kernel.org>
 <20261110152949.2135243-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/twl-core.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index c024a28b057e3..128cd3f6c60c4 100644
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
2.53.0


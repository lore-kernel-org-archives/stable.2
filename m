Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794325241;
	b=J37RGC9atOPj4bm33+uy2MGijtZFxEmE43J/NymOCZx5/CcD5DJINVyOJPlwooFAIpiq
	 zLT4QnDorNhzpCNkZu7tEmDbXaRv0peGS7RW7yayMjVZRsSmOGDscTewVUPuWJsuCph19
	 u4Or7BD5a9Pmqdi7LGksIIbp9OhK8spJ9+Cu0lZOUwonHXoy/TSkrtE1E+1tmeGpYj6rr
	 DG+vDS+IPEy38iMyjqTAQL318S/xjvqkF9F06UmYYfcQNiYSSHzyLkSNZiDlvuFXW8L5t
	 prWARuB6E6k1/n31QenhBVvATr6HVemgl+stir/eRTB1tEvIjHl0YgV91wRUoUPdW4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794325241;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=VG0wcoSVXRGWHTPQWAWZrKUmMXN3kp4avbYwwWwaPRc=;
	b=f+PHE+OQL1y70LDpqPZR6Z8UtMKAUeSwsftJVXbryBBTlv1XOTdDfqRB4ik7zGg/c4B3
	 bq1fFCJnCGUWtcY0BWMmopqxx4/iv1aeE9phmAz20nPbZno4Auc05bQAO56lb3OAjNhSy
	 MpvKTWVnvj1B4L4+2F7AYLOgQhlwtQvE9GYBEAEhN5se8wHXF9oe9i7hl2FRX5cpuqtaj
	 SgHNE8afugwbUe6srzBnmtQuOKp8oJtwodeewEy3e1nuwgqqGnPmWz9FB1w/UEAdLsEJg
	 AD9LCsFExA1OTIuod5/TUJeItR3ndXkBj90pb24aLAis5yMW9Rl9udgQDRDQXB3VnxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QNp4AYoz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D4F606A339
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 15:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QNp4AYoz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E861F008A6;
	Tue, 10 Nov 2026 15:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794325240;
	bh=VG0wcoSVXRGWHTPQWAWZrKUmMXN3kp4avbYwwWwaPRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QNp4AYoza5udclRQW/iplIhOg6rEyTU8OkuL/B4r4Fr3Ab7dIyzqR+5kBjjwwKjxE
	 +xqLXgD3ymF8oOIYsil/nxkqdC3EOaxpBOX1x6QnFXVhqqbIcpRRuhv1pUHxV2olmE
	 n2pzkVacPW0EfOJICXerVht9FsW+d1EZCmoQdlN566calwCyx4jKwCD922isr265WP
	 L/6HAGOTaZvnlufJIYC/gGy7lS0TysbxmddduFZCpYdrH5as6NDyEeHZnzuKRNsmQ7
	 urMsvMMydqr6MdGOfXKYVTWcq7zoeRSMX9IrnBlDDTeDVvuMC1qy7Jf7LkQKHzweRR
	 +nzv66kOKXG9g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] mfd: twl-core: Unregister the auxiliary platform device on unbind
Date: Tue, 10 Nov 2026 10:40:38 -0500
Message-ID: <20261110154014.2302728-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110154014.2302728-1-sashal@kernel.org>
References: <20261107051743-failed-6.12-3c5c55d979dd@kernel.org>
 <20261110154014.2302728-1-sashal@kernel.org>
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
[ sashal: Adjusted context to preserve the separate TWL6032-only clock registration block. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/twl-core.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index c53be506311a3..8334066f8e22e 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -715,6 +715,11 @@ static const struct mfd_cell twl6032_cells[] = {
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
@@ -750,17 +755,22 @@ twl_probe(struct i2c_client *client)
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
@@ -780,7 +790,7 @@ twl_probe(struct i2c_client *client)
 					 GFP_KERNEL);
 	if (!twl_priv->twl_modules) {
 		status = -ENOMEM;
-		goto free;
+		goto out;
 	}
 
 	for (i = 0; i < num_slaves; i++) {
@@ -868,7 +878,7 @@ twl_probe(struct i2c_client *client)
 					      ARRAY_SIZE(twl6032_cells),
 					      NULL, 0, NULL);
 		if (status < 0)
-			goto free;
+			goto out;
 	}
 
 	if (twl_class_is_6030()) {
@@ -886,10 +896,7 @@ twl_probe(struct i2c_client *client)
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


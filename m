Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795459346;
	b=cwUnAtMuTwHDNrJAK09PE0ChT5bWpl2QGxQgY5U8imy1JRgm/pHiWn5Ioi4tOykCh8U4
	 QMwOcRwAtXyUcsG4xPGK8sB5jjjx6wLumZZJIHJ8Q0sTbZfQqk3i85USheHg39MPxEf0Q
	 Vq7cLD/H+28g1jswvy0LDZctye7TTtLxG3D72Q3dt/DmSKwP3OkxP8twy6ZRhhhOzoIPh
	 3fz3hrRiRrycI2vMLNZNgQgLXvkvKin+Rjm/0kYUAOsMZY6zMtyn3H7K38Ljqdll4P/Z1
	 pIahkuGdOPfP6vqF7dn/86glBGHAWc9KEBQ+cHULcYCCupxGFGC9Y+TZn58fBAbLwhQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795459346;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=3BRnPWU5gvaarkrl53uTdvwk4xqc+nMjuY3oKO1Cso4=;
	b=P1kkwGQQSHM7KHaDGj6yzdwqRJzZgKVpIa/Fmoj474PmUTVShlklxt6x8Ri8OGg3cTJh
	 A1ZwBGslZmO6XIhKkNC/SpTiOcNPUrwNWyJpTnOrO/8mouR40C0z7uflFJruurldQ7pr6
	 W4/rwWgVb0slzgLvAxJALtWvuI/2CLn9IgVXT0IcNvae3yh9mflQOYhbDExKHI2FR59Ur
	 1QpfzbiJZ1pz7YfVTGVOg8s6zVWiJ7FW1B9GogTmM99lmaPQR48qsptbdtsdCsfIGsT54
	 rW81oUwiKF88+Zrj8wJvaY5TwjOEWq7jpmzk8hU6XLJKxdQzO90u5USUUKTfwfHgAqw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VkNtUBY+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D08606A33E;
	Mon, 23 Nov 2026 18:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VkNtUBY+
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795459346;
	b=LgGdf5g0dyiWFaN7Rylj/JBhwRQaojQ/4mS30JPg7IUekpGYG8fdqDbSg6a5ETR3S1KQ
	 4OrGrQf/OvkXrDMyhqQSJOzxhnuKfnFS1KL4JpCixT4kcozVizKsgXeTrXBgjsxaVWVu2
	 9EEGYpS6CEdWKsCctV8Twdi1M8a7nf8ge9Wj7shFWwL1j5RTMiwfdvCElrj+k8DzwmABS
	 +Ab3Ac5SkrNffoNSRylmLlXX8W06YrbnQxNYiEVCarvgId/RJG2ANxcSYlRjJ+b/nbA+K
	 aCX7XEq4zremKhy0WwJNMRZmfmsBEeXNrHNbkYqt8qb18rOrFC33e/QBK+n02MLe0kQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795459346;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=3BRnPWU5gvaarkrl53uTdvwk4xqc+nMjuY3oKO1Cso4=;
	b=2jRxjOF8LdUUtRufy9rYShCDZvE9Ba4AGA57wsd5+DIALB3ATKNBvtdHNzgp0n0/2aZ2
	 wUSyCAl/+kkKVPsRKgNHL4MOFj6a/uhkBpacMNUfHzD33uehj/5wG/sFVLEcuWjgPFxIu
	 UXLpyMPuhPTMHbyzQOciWdV++omWgFI9R/LAwpKq5/P+rTvLv7ssocA2Hmcaqh4tVD+Ck
	 uQ+fg/RfJaz2yrX1twNq4vaCCK7+B+zo8utSBE77teWEWOLuiaOnEB4hrTE7kdkgNoMhr
	 MH4q+a/51EfIjxe/Gq3c+7KTlbikgo1s03SIV9FqKALzbtRaDlfUI5/R2UyT5ZaWgPQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D33951F02ECF;
	Mon, 23 Nov 2026 18:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795459346;
	bh=3BRnPWU5gvaarkrl53uTdvwk4xqc+nMjuY3oKO1Cso4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=VkNtUBY+sVka20+zbP1/toC15tBhh6+Y96fd2C+6xMBoQV68ejhJjOkAN8MX+4/tA
	 ZvAqkA7DirJuDXuUUbs5PSF6CgK8ayBAhftKktuzDIIgwruEamHEIroMvKsjOjSkyB
	 Lkr1+GHkxetoqT5xG5DUsjtLhJtfOaErF5481k6gH+x1eEaZjGzgmOup+3UA6DQIM9
	 hsDrlKgvETWZ9F7QVv6S5qA5KvCf5QgciTvx7hnQEOykVrbkNY0Gi2Cfxqk4LWXPTd
	 U8VBYw2fNBAWgPSWlAGywVR0Pt3Ht5malhSBj4iOvBNAkEIDjBESvjNZIQ41ArBZKY
	 6GO7fl2v/7ilg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 9FEA04C601;
	Mon, 23 Nov 2026 18:41:45 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Mon, 23 Nov 2026 21:41:45 +0300
Subject: [PATCH 1/2] Input: sx8654 - use the SX8650 soft-reset register
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261123-b4-sx8650-fixes-v1-1-b82a881b971d@gmail.com>
References: <20261123-b4-sx8650-fixes-v1-0-b82a881b971d@gmail.com>
In-Reply-To: <20261123-b4-sx8650-fixes-v1-0-b82a881b971d@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795459304; l=2322;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=2R3B9Vs5B5D+UbWQT9UP0EYwUi/ItokvKyXPewI6m3M=;
 b=mjoXTxK2sHoiteAUKWFxkHss1JZ7mQmG8OvXuZ+YnsBcEiaCRfx4E/zood2zIEPYs9+nE6qpL
 h5h94A2lDyrCw1sq8f/U2GqWw++l75+vMUG5U4vtsISEPYpC7IiymU2
X-Developer-Key: i=filipp.dunsky@gmail.com; a=ed25519;
 pk=JAYP8e2rJ54DHOmhNtXud8rl1igAaAXoOHxtJmVXI1g=
X-Endpoint-Received: by B4 Relay for filipp.dunsky@gmail.com/20260930 with
 auth_id=1085
X-Original-From: Fil Dunsky <filipp.dunsky@gmail.com>
Reply-To: filipp.dunsky@gmail.com
Content-Transfer-Encoding: 7bit

From: Fil Dunsky <filipp.dunsky@gmail.com>

The SX8650 register map uses five address bits and places soft reset at
0x1f. Sending the SX8654 address 0x3f also changes the command bits, so
it does not reset an SX8650.

Select the soft-reset register from the chip data, retaining 0x3f for
the SX8654/SX8655/SX8656 variants. Hardware reset through NRST is
unchanged.

On Almond+, programming CTRL2 to 5 and writing 0xde to 0x3f leaves CTRL2
at 5. Writing 0xde to 0x1f restores its reset value of 0. Both I2C
writes acknowledge, so checking only the write return value misses the
failure.

Fixes: 43df039c6d92 ("Input: sx8654 - add sx8650 support")

Cc: stable@vger.kernel.org

Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>
---
 drivers/input/touchscreen/sx8654.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/sx8654.c b/drivers/input/touchscreen/sx8654.c
index 23fb0c683..13dd80a8e 100644
--- a/drivers/input/touchscreen/sx8654.c
+++ b/drivers/input/touchscreen/sx8654.c
@@ -42,6 +42,7 @@
 #define I2C_REG_IRQMASK			0x22
 #define I2C_REG_IRQSRC			0x23
 #define I2C_REG_SOFTRESET		0x3f
+#define I2C_REG_SX8650_SOFTRESET		0x1f
 
 #define I2C_REG_SX8650_STAT		0x05
 #define SX8650_STAT_CONVIRQ		BIT(7)
@@ -86,6 +87,7 @@
 #define CH_Y				0x01
 
 struct sx865x_data {
+	u8 reg_softreset;
 	u8 cmd_manual;
 	u8 chan_mask;
 	bool has_irq_penrelease;
@@ -244,7 +246,8 @@ static int sx8654_reset(struct sx8654 *ts)
 		gpiod_set_value_cansleep(ts->gpio_reset, 0);
 	} else {
 		dev_dbg(&ts->client->dev, "NRST unavailable, try softreset\n");
-		err = i2c_smbus_write_byte_data(ts->client, I2C_REG_SOFTRESET,
+		err = i2c_smbus_write_byte_data(ts->client,
+						ts->data->reg_softreset,
 						SOFTRESET_VALUE);
 		if (err)
 			return err;
@@ -413,6 +416,7 @@ static int sx8654_probe(struct i2c_client *client)
 }
 
 static const struct sx865x_data sx8650_data = {
+	.reg_softreset		= I2C_REG_SX8650_SOFTRESET,
 	.cmd_manual		= 0xb0,
 	.has_irq_penrelease	= false,
 	.has_reg_irqmask	= false,
@@ -421,6 +425,7 @@ static const struct sx865x_data sx8650_data = {
 };
 
 static const struct sx865x_data sx8654_data = {
+	.reg_softreset		= I2C_REG_SOFTRESET,
 	.cmd_manual		= 0xc0,
 	.has_irq_penrelease	= true,
 	.has_reg_irqmask	= true,

-- 
2.53.0



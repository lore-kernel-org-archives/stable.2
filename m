Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794251065;
	b=HyWpXoUayC0hD5vUGrC5tk6o3GE2X6M1iMUw0zIluJSyFM4MH7GdC6toWPc0FgvktqHY
	 PpTDTusUp5F/AZhpphqITU1vUenvoLR0vCAS47elC3mveM5JyiamN/fNgcfIwFjTQJerV
	 l/P5LZpUfx1zwjwPdjdrBB6AxyilT8f1VLH5BUeWSrFGDH0u6BjTcqdoCi9x80QIV2IK3
	 dfNtGCrQojs/b2DHpNWNf9oGMOg9WIck9Q1oC4jtcBKBU7vy16HgTSQosRXM+DokJ9+sK
	 2ow+I/bqkQi5JR7Vt/RP/OESyA2b8IrV4jkA6OwOsE5b2yiJCr7EAOrWEM/r8q9r7lA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794251065;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=RpUh4/i5yEgJrvnefCqxvh6+JPi28ndM/f1eQAaNtJs=;
	b=xQJifmYBIEr1+4AE555kHSGvVymfRl0hiGSujoGrjX0w3kumiq6c0u1KWNKrR0bXxbv3
	 CBMcVFwejnx/u6PTnw985I6UTtkarbB2Mvw1raIL0PSBT4ck5QFLDdkKiB4hxI/hCmlJr
	 S1xfLSJxD0woa0ncZF6kgcCKM1dIeBRmNEIG6sjcaM6DyPwyN4rcYBQ8E/e8M2rVAbacf
	 yzT6i6JhCFRU6VbQe9q58Fpnx1cIxhV6kWf+VH4TzZj8IaZ/Jc9zE/BFIWey3e6h8kIDi
	 s0huV+bT9Q4clgkLkyK6qDdx3FSKGCJMXQseJzc3mZAY8Df7rrIlWtJi9UA9/733WpQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fAbPfh9S;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BB7606A325;
	Mon,  9 Nov 2026 19:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fAbPfh9S
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794251064;
	b=E6TBaAOyMG11ljYXk+2djcyVuvdQsj0sEwIWSuEBqksp5XryZ6Xxub8Sk8PBYROUiZ8a
	 89E7b5PAv6XHN5kDPEEVMkUyVaUee9wHCUORP2OyXfP+OZSp7Cny26PM/UVrA3GZ6+9Sm
	 6alRi/bXoECSrBwq2edrf9uTjwVLW4gnAc5l/ui+XSgnYe+JyNR5/4u08bIhTgX+ApjBX
	 ntr8YuFuE1KsT7d8KyuWlgHNiM1qdTkZeyI/UfS3L+Fi7x6Z5xx2lR7nt9dR/ntPbgWll
	 mrYdhCoG0WEwxVmL+G/8GYluSh+BWMTscly3grW79/L7vZt/MOF4dHDFkfpvjY/I7qQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794251064;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=RpUh4/i5yEgJrvnefCqxvh6+JPi28ndM/f1eQAaNtJs=;
	b=KAh0PciY3rABwRsSFkzJRTfMQUvPAOwpUASx0JFHAnNamoSdR3cCdTjhL8Ixz6E8kl7Z
	 5mSuQXDfwsPbJYEQaivOHJ1ZvSd5YKdRgNrb5TbquE7bA4lJdN/RfktPPBMNSFF98AFO+
	 iKCvflZI5+VSCtbjfc5u6nyUeQ36KDM6ISkmOQqewgV/z6iKJKytoutzi7+i+jwgY5noX
	 mMHVSD+wZkOudWWSc8yohpuRfP7Sy8dxCvckdn/wMUJDsT1DvSVBx36HlN26eH7p7RDL1
	 GiEnLUrYAkgG7GRZ/u3Bm/Q7OmMbq8ubO7J/cbprB+4idW/PBimk+Kuoh76Zeaeczkg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B078A1F008A2;
	Mon,  9 Nov 2026 19:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794251064;
	bh=RpUh4/i5yEgJrvnefCqxvh6+JPi28ndM/f1eQAaNtJs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=fAbPfh9SHdVJw/5O+++D3MCiokGxPvcE4C9XRaVKhOQASu5F7tOUFtvw17l1krETH
	 hYY5mMOIFjYwkfLX/VPxC0qmwgcXT0LKI7mnZUpg8xi95KFE06Hhl16dPCZ8jx/uBy
	 3g6c6kBi6DV8So4UmwfBWHEDOwsEEwu8wNhcq0EEtaGs+YKCZ8nwVOgXcwmX+ZmuQy
	 04LXAu8Ob9E1h4OHJ1q6Mjcu6oddKx+8urdnrJ1f32wfKbYw/EVE+s48PmlwSfs5mX
	 3PjrTs4wol3pRaA1G6yKRl+JnrJQe+EhA2YXeypfH97WpZR6mfR1wh1bub3BU2cnxm
	 ZgcEEsr0zx//Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 353F7485E6;
	Mon,  9 Nov 2026 19:04:23 +0000 (UTC)
From: Joseph Telaak via B4 Relay <devnull+joseph.telaak.dev@kernel.org>
Date: Mon, 09 Nov 2026 14:03:38 -0500
Subject: [PATCH v2 02/11] leds: rgb: ktd202x: Fix an out-of-bounds read
 with unused channels
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
Message-Id: <20261109-ktd202x-et6326-v2-2-56e97c226658@telaak.dev>
References: <20261109-ktd202x-et6326-v2-0-56e97c226658@telaak.dev>
In-Reply-To: <20261109-ktd202x-et6326-v2-0-56e97c226658@telaak.dev>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Griffin Kroah-Hartman <griffin@kroah.com>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-doc@vger.kernel.org, stable@vger.kernel.org, 
 Joseph Telaak <joseph@telaak.dev>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794251062; l=1977;
 i=joseph@telaak.dev; s=20261104; h=from:subject:message-id;
 bh=WIevyBVu88sXpVFkOrkZHCBIjBM1tLa+KjKrKOEfUlA=;
 b=je58tgYPuvVRDFPZspy1+/3EWSCiKDZxyHGOMap0N0co44VNKM39+rC3aorCj/F8V6k0JyJwV
 fRxUWp+a8CqAjqSftWfq+T9s+XS4tqFl7k18ipY8JYbpCMNoCaFIR+J
X-Developer-Key: i=joseph@telaak.dev; a=ed25519;
 pk=oQI+UfddlZ0wK2ac4WKOGNjUl1ZEN8j9ZVFSqEDoNP0=
X-Endpoint-Received: by B4 Relay for joseph@telaak.dev/20261104 with
 auth_id=1404
X-Original-From: Joseph Telaak <joseph@telaak.dev>
Reply-To: joseph@telaak.dev
Content-Transfer-Encoding: 7bit

From: Joseph Telaak <joseph@telaak.dev>

The LED array is allocated for the number of child nodes, but
ktd202x_chip_in_use() walks it up to num_leds, the number of channels of
the chip. With fewer LEDs in the device tree than channels, for example
two LEDs on a KTD2026, it reads past the end of the allocation and the
__counted_by() annotation hides that from the bounds checkers.

Allocate one entry per channel.

Fixes: 0ebdb7210943 ("leds: Add ktd202x driver")
Cc: stable@vger.kernel.org
Signed-off-by: Joseph Telaak <joseph@telaak.dev>
---
 drivers/leds/rgb/leds-ktd202x.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/leds/rgb/leds-ktd202x.c b/drivers/leds/rgb/leds-ktd202x.c
index 539cf425cdb7..482af28e8370 100644
--- a/drivers/leds/rgb/leds-ktd202x.c
+++ b/drivers/leds/rgb/leds-ktd202x.c
@@ -537,6 +537,7 @@ static int ktd202x_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
 	struct ktd202x *chip;
+	unsigned long num_leds;
 	int count;
 	int ret;
 
@@ -544,10 +545,13 @@ static int ktd202x_probe(struct i2c_client *client)
 	if (!count || count > KTD202X_MAX_LEDS)
 		return dev_err_probe(dev, -EINVAL, "Incorrect number of leds (%d)", count);
 
-	chip = devm_kzalloc(dev, struct_size(chip, leds, count), GFP_KERNEL);
+	/* Loops over the LEDs go up to the number of channels, not of child nodes */
+	num_leds = (unsigned long)i2c_get_match_data(client);
+	chip = devm_kzalloc(dev, struct_size(chip, leds, num_leds), GFP_KERNEL);
 	if (!chip)
 		return -ENOMEM;
 
+	chip->num_leds = num_leds;
 	chip->dev = dev;
 	i2c_set_clientdata(client, chip);
 
@@ -562,8 +566,6 @@ static int ktd202x_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
-	chip->num_leds = (unsigned long)i2c_get_match_data(client);
-
 	chip->regulators[0].supply = "vin";
 	chip->regulators[1].supply = "vio";
 	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(chip->regulators), chip->regulators);

-- 
Git-155)



Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793585583;
	b=TjHOC67FL86iphE+eYFGBaWKrY30J9SoXGYFWRLtz4hqpn1YJ+y9qImZG/zlI2zc6lC4
	 khxyQcXPf2YANeE4GBsoZuR/ZAMbONAkIk1X2Ru/mAe+bRtXfwOEHYrTG7c6ySOVn/4LX
	 tFHeq8iOYUsx2IBJ6j7T9rMPjz99jxQAJb4DPurGgsfFWZBXznbSy8R7WkblJ5XXzRuRB
	 y+3QRgriN5VRVm0KCfCsSp2Z7GVti5Xk9bb9WXQfXlj86nTkBF/ILPLfJ4zPRgyN6hWSg
	 GR6+Uen7ey/nUPdKOPHu/weIiYO9INUtCO7QxQ+Gyo/H6qmmSgWcrYHL0ITfsFMwWSQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793585583;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=UvKGLVMRSCX0AiAkdB4p8byqLJ90SU4RD5Npa1QVQjY=;
	b=bMKwPoTzdXetTwvqpG/+fijb00c+Z07hxKVMvB2pEGNZKAaL7He7gv99MxZtVM9D+JB8
	 h09AlJm7iUwIsW1lap1L/XvgPx4kmhhfPWrwYRQtSoYbg4DBa8s8JfNsc4grulGr5s7ZQ
	 FfeR2BY3rNoaYKV+Bc3LoT29f7nwAGKvQ9bNB4a9k+k7tkzDEXangVHwRj1ffAKN0Ei/O
	 bIkpPPumfKJ7XSvtCvlUw9wkYGidyzT4ylyXjfCRCt3J9SXphQ5gfxYKXBv+tlu+H58bQ
	 dIOmfY0CrWjbqKs0pzCTSpcuUxj9plI2hI2VZ6cCmQcjERntlv6x7APmsNVJaWWBKuQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MHn2kGrJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBF060A262B;
	Mon,  2 Nov 2026 02:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MHn2kGrJ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793585582;
	b=tzX1xjEQZXZlwdTfX1bvQkSoK9pyIm/+q+r537F99lOm4CPPf9YV0HYBynbSwuUNM15X
	 pKzfUwLMC/gZnmuPJPl44GNpRNM/8qXHm5qHV9LBTeIwtrtB7CqLVZWhUxYX7vhf1Gutv
	 a7ChAbaEfnlZ3pU2fPjk+nMcHOkV2t/Wp4b1K7BYWGI8ArlTbJR8O55/zA3+3t49/f32N
	 osct8edkYF7kVxyzZoridjluxj1zeJ+tTweeJNFFYI5vLjLMUsztjVL2B0HDulXF+3yLg
	 35GDbG1HE5AgzTiMzytYaPbmllbr8IXE6fnY0yj14WsdgTrrfBqwYHxxhHt7dbKrWog==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793585582;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=UvKGLVMRSCX0AiAkdB4p8byqLJ90SU4RD5Npa1QVQjY=;
	b=zm7Q/TMWeaGYCrHl53M92YrkaP5+5yK71Td/aHadilbM9JuZvqYud/y/6vcBhBgmSncV
	 uTUWOktqk+/a+2ZJtD66NXfrkyzrW3oDwX6QXOpzzyYCX4Wh4OVTkD+ZVwv5iCZ4a935/
	 DoOpxtojJQs+YQtbtw/3L+PuGxBI/pm0wGFzOpcurhxO6K3VVlvWDhDUBu9fq5AzQARV8
	 vnOZKws+jSZwriGMcD/xf+UsseAawpit1isI3khf9ChhQuLYuPqKqa5ZfwE75ejbvnZEw
	 xsqrXTDYNScKRlWwk/tic8eG0Tz2PFxy2saH/8ilIk5If5jRTt143NxLrnqd5JKmvLA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 6CE6F1F00A23;
	Mon,  2 Nov 2026 02:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793585582;
	bh=UvKGLVMRSCX0AiAkdB4p8byqLJ90SU4RD5Npa1QVQjY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=MHn2kGrJ+JXOWcV6pEGj8KBjDFgenKrotMsphLZq3HHUPlHuVHSWq6qbTStNgk/S0
	 N2+QKmlABMW1Om50vUfwH8DJaezBrOLW0rfpg41CZh8iHtLGqTKnnclsQMWBWW8mlw
	 Z3YZaym+eDbxHjJGMIlPUC+7VsZHhFjxRvPOVjw8k8BNsToR2PYuWX1u1n7OlRwVut
	 Z+SwoVvFCPrRKYBINY+FQBgY06tt6IreaqqLMtoA/qTjtR0u346cwWY+xNKIlTctEo
	 Lt4VO5XNO/8IpeG+1DYO45gJJQf9TTGrqZOy0evfftlk6E95HTv1yx4wMLqItwKsnC
	 DoLs0Jal6OGxg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D725946312;
	Mon,  2 Nov 2026 02:13:00 +0000 (UTC)
From: Joseph Telaak via B4 Relay <devnull+joseph.telaak.dev@kernel.org>
Date: Sun, 01 Nov 2026 21:12:26 -0500
Subject: [PATCH 02/10] leds: rgb: ktd202x: Fix an out-of-bounds read with
 unused channels
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
Message-Id: <20261101-ktd202x-et6326-v1-2-eb51eddad08c@telaak.dev>
References: <20261101-ktd202x-et6326-v1-0-eb51eddad08c@telaak.dev>
In-Reply-To: <20261101-ktd202x-et6326-v1-0-eb51eddad08c@telaak.dev>
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
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793585579; l=2008;
 i=joseph@telaak.dev; s=20261102; h=from:subject:message-id;
 bh=mwFEfqp4SCRu2h+8wzzdp0VhrsnxZe7qyijkGUaRI90=;
 b=l2AjyqU6OQtUEPl6CCNYUZS8H6tz5BGQR9687gz5U9QitYptaESTT9n2ws3fXrg+EbVjWsFRh
 6x/dhyLgQbVA5NpdFz4s+aGnt3AEwsPCX2AfGdIZe3wD/opZB/EpH6N
X-Developer-Key: i=joseph@telaak.dev; a=ed25519;
 pk=OmwSusdK4grZpiuZVfCZAvYyqz9FBkNemsV1EnHyVr4=
X-Endpoint-Received: by B4 Relay for joseph@telaak.dev/20261102 with
 auth_id=1382
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
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Joseph Telaak <joseph@telaak.dev>
---
 drivers/leds/rgb/leds-ktd202x.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/leds/rgb/leds-ktd202x.c b/drivers/leds/rgb/leds-ktd202x.c
index 539cf425c..482af28e8 100644
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



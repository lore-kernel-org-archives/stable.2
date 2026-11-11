Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794416241;
	b=q+nCPSwGuVlIf6d05NSafbldj06Qv3mmtF7gj1bv+8CFqKCiaiN3lSeHrssnalrjvHPu
	 VNJMsFZT8CgIe0YtvhNJ6oSgIZ9GsUcLfSGtYDtQ2muZ5vC9NbqPyMQ2wVG5eqkYA8ybf
	 ABs916k24GjT2/7tdJ5Ty4HIbChxz+4+xlml4G9jzjl6GKFAb2NECRgpIlNMXDEhyFJ4z
	 Lm5IAPOtYA309F+sEhmOQuqkKhWY4qWp4oQXepHipsU/8rq57x5ANgjXnhCc7RJ6dc+pO
	 igMB8qTpHeBnI7Z1i7qucCD316YPfq6HbkCM3B7YVm30c06yWf7CT1pCrVyUyNxOpmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794416241;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=s7FTEwLpA2oriX+q98U9fp1JyHSKRwvRFfmeKxOwO24=;
	b=kyXIbgkbsN2xvtOGYCVGEJCqBH3NT+LFxGry+dXdz1tbuztwWYIOHp6LyQSZ4kOb+aC+
	 Stx9/cQ8lajFibUHje2BZ4A6EcbS4G9mzFjcsAuERCNB11e3Ap681fV3dz6d5+MsgTPL0
	 bSkQ3hpWw9ky5Xsn/5BwR24LJ0caVs3DFq3ieuZtTJMaqcZYpdWa7AOxZC/oSkLcixf6E
	 biQ+FkTuZd8KC0ItopOwfFkZzNUb3wbGwpZ7Gk35Qvz1ND/gkE1Xs+qTIcCXdnKJb1Czm
	 MaHkBcXAoDzW4yYD3Ob5tSkgqcbWGVxhI4kAmonP42lJaMGqOc+72TYVqHyeITxJ/wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QwfffE13;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234DC606A33A
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 16:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QwfffE13
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4518B1F00A06;
	Wed, 11 Nov 2026 16:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794416240;
	bh=s7FTEwLpA2oriX+q98U9fp1JyHSKRwvRFfmeKxOwO24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QwfffE13VC2FCQjUjbbtOebb+zduvhYvvoTozXAbCB7fD41MsM+mE2X5hIoxd22Wd
	 M8GRHXR7JmZ2G+Ry0xKxNEd/p3o2FFtGQ7xq7KtoNd7ISigouy0+sMf+vLgVlhs7EM
	 vWkJw0Ypg+718TB02id+JHWxb1lsA38Ct9hYlwDesLTjUMNBTR2AxfQz3VhvSJVCRZ
	 FFqLR/on0q9rml9o7k1vTK00er9GO3QNTP9vz15vG3hZddhtz7DaZEDAqeMz/BSjQ/
	 l4eJOjUrmL0jxrM5j8X4L1pumkKZy2dP5G7tZTXe//H+5gZeNYrQOJckkaWj4JqPUY
	 6nfx+Me9p47uQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Jos=C3=A9=20Miguel=20Castellanos=20Valladolid?= <josstamy@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] ALSA: hda/realtek: Enable mute LEDs on HP OmniBook X Flip 14-fm0xxx
Date: Wed, 11 Nov 2026 11:57:19 -0500
Message-ID: <20261111165659.3297427-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052343-failed-6.12-c80286aaa4ac@kernel.org>
References: <20261107052343-failed-6.12-c80286aaa4ac@kernel.org>
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

From: José Miguel Castellanos Valladolid <josstamy@gmail.com>

[ Upstream commit c80286aaa4acd52f9bd0b0d4914d2069fe6ba3a8 ]

The HP OmniBook X Flip Laptop 14-fm0xxx (subsystem ID 0x103c8d9f, ALC245
with two CS35L41 amplifiers over I2C) is currently handled by
ALC287_FIXUP_CS35L41_I2C_2. That binds the amplifiers but does not set up
the mute LEDs, so neither the speaker mute key LED nor the microphone mute
key LED lights up under Linux. With that fixup the codec GPIOs stay
disabled (IO[0..2] enable=0).

Switch the entry to ALC287_FIXUP_CS35L41_I2C_2_HP_MUTE_LEDS, which chains
cs35l41_fixup_i2c_two with ALC245_FIXUP_HP_X360_MUTE_LEDS. This keeps the
amplifier setup and adds the speaker mute LED through the ALC245 COEF
register and the mic mute LED through codec GPIO2. It is the same fixup
already used for the 17 Turbine OmniBook 7 DIS (0x103c8d9c).

Tested on the affected laptop with v7.2.11 using the equivalent
ALC245_FIXUP_HP_ENVY_X360_15_FH0XXX fixup, which has the identical
cs35l41_fixup_i2c_two + ALC245_FIXUP_HP_X360_MUTE_LEDS chain: hda::mute
and hda::micmute LED class devices appear and both key LEDs light up
when muting.

Fixes: 29951021367f ("ALSA: hda/realtek: Add support for various HP Laptops using CS35L41 HDA")
Cc: stable@vger.kernel.org
Signed-off-by: José Miguel Castellanos Valladolid <josstamy@gmail.com>
Link: https://patch.msgid.link/20261017050615.14481-1-josstamy@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
[ sashal: added the missing mute LED fixup enum entry and initializer in the existing Realtek codec implementation ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 6f5fa76b78f11..1a68e683801b1 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8212,6 +8212,7 @@ enum {
 	ALC287_FIXUP_LEGION_16ACHG6,
 	ALC287_FIXUP_CS35L41_I2C_2,
 	ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED,
+	ALC287_FIXUP_CS35L41_I2C_2_HP_MUTE_LEDS,
 	ALC287_FIXUP_CS35L41_I2C_4,
 	ALC245_FIXUP_CS35L41_SPI_1,
 	ALC245_FIXUP_CS35L41_SPI_2,
@@ -10414,6 +10415,12 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC285_FIXUP_HP_MUTE_LED,
 	},
+	[ALC287_FIXUP_CS35L41_I2C_2_HP_MUTE_LEDS] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = cs35l41_fixup_i2c_two,
+		.chained = true,
+		.chain_id = ALC245_FIXUP_HP_X360_MUTE_LEDS,
+	},
 	[ALC287_FIXUP_CS35L41_I2C_4] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = cs35l41_fixup_i2c_four,
@@ -11219,7 +11226,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8d9c, "HP 17 Turbine OmniBook 7 DIS", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8d9d, "HP 17 Turbine OmniBook X UMA", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8d9e, "HP 17 Turbine OmniBook X DIS", ALC287_FIXUP_CS35L41_I2C_2),
-	SND_PCI_QUIRK(0x103c, 0x8d9f, "HP 14 Cadet (x360)", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8d9f, "HP 14 Cadet (x360)", ALC287_FIXUP_CS35L41_I2C_2_HP_MUTE_LEDS),
 	SND_PCI_QUIRK(0x103c, 0x8da0, "HP 16 Clipper OmniBook 7(X360)", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8da1, "HP 16 Clipper OmniBook X", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8da7, "HP 14 Enstrom OmniBook X", ALC287_FIXUP_CS35L41_I2C_2),
-- 
2.53.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794414218;
	b=cTVdbl/30/l9V0FIqWDnoB4cjrg80gUfWEEqgjtUpIBd6sPDstgDbnrWrWD9KYkIKwLr
	 3AAqo7HmTLTNDJjQFztuDd7YA06lS54QF6zBy0yJU8PAGHaYtCHCM8BxrSZgBwzfcFTYm
	 nBmFbbndK/G+SeppDmxzFWHTES84tZAfYUxC43gUWJsvxVZqLieCXcSVozZ4VgyfRk45J
	 19nTAJcMUc+O7FvYX7PPzzWGv6l6tYuYmFkykwUWBLNz1hnCmvX0gzry5yXa9IrmyQ+kE
	 burZpvRM3GpFHAMuBIk9qR7XOGIlEnUAPfUYZRFmTAkse8Gpec+KmIT7pS3ffKWm/eQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794414218;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Iuh/Y7e4VREX6Je6eWkX8CT9V5qC1h43VqOavQROvg0=;
	b=Yuff4MuTtW+uE/K/FfsgDkAmG/vqkoWGxsvhu9jvWi4bv6TOGeTp3pmgPz7bdwMRuzCt
	 /6Ag8+kq1fiyZN4PqUXwgcIZkUbGkkdKM+s4s3NPKm1CWeygzrfM4XBtySGO6PPQF+4Lt
	 OepMaNjRf6GKBo5I+ttYDyA1jENV3N7W8gn2anjh/ukjI0Oycsd+9HU1LItw0RMvDUlfN
	 zX0XhTa8kdEqLk3kgfIqsnIeuDF+Amn7BmEUo2niGbMUNMDd/f4D2IGNIVZBEd+Bad/7I
	 eXlZvi+bWMQFwpzCUvXmPki+vymKRPZgUxZXO6y0XgZnRhHGHl31AOQtTyNW4bzelXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=McHIY7i5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECD2606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 16:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=McHIY7i5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD541F00A07;
	Wed, 11 Nov 2026 16:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794414218;
	bh=Iuh/Y7e4VREX6Je6eWkX8CT9V5qC1h43VqOavQROvg0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=McHIY7i5Vp4Ks6Kgbn6Eo1LzZIIXqc+Tkdy7FZ7cRE4j6Q+QXIf3ISCNFctWsuchf
	 wA9LUpzQTdikm9r5rsrymlq8jJXwEOmyfKFN+n/+9q076xUzvsWA87zcrfilqjVF7k
	 We6S3uSu4rCCv/2T4J7Px9WR108unWGjgA788Xvb7wAulFZyOnK7gJdjfhzVNv3yfJ
	 LpDlpERyLDVK7OLhbgpizDRQovDvPCVlfmahakYMixldZeHHkvXmb3tYKFsOgdz0AF
	 yOIhuH7HWteT0nJkUM9gkOqL0hdlMS4N8IKRi7dOCuOQGYyxFBoTgspeCENVpj7GYx
	 DgrIlFeWGqN+Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Jos=C3=A9=20Miguel=20Castellanos=20Valladolid?= <josstamy@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] ALSA: hda/realtek: Enable mute LEDs on HP OmniBook X Flip 14-fm0xxx
Date: Wed, 11 Nov 2026 11:23:36 -0500
Message-ID: <20261111162324.3243277-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111162324.3243277-1-sashal@kernel.org>
References: <20261107051223-failed-6.18-c80286aaa4ac@kernel.org>
 <20261111162324.3243277-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/hda/codecs/realtek/alc269.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 78f5257fd6070..d59dc9904647e 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -7119,7 +7119,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8d9c, "HP 17 Turbine OmniBook 7 DIS", ALC287_FIXUP_CS35L41_I2C_2_HP_MUTE_LEDS),
 	SND_PCI_QUIRK(0x103c, 0x8d9d, "HP 17 Turbine OmniBook X UMA", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8d9e, "HP 17 Turbine OmniBook X DIS", ALC287_FIXUP_CS35L41_I2C_2),
-	SND_PCI_QUIRK(0x103c, 0x8d9f, "HP 14 Cadet (x360)", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8d9f, "HP 14 Cadet (x360)", ALC287_FIXUP_CS35L41_I2C_2_HP_MUTE_LEDS),
 	SND_PCI_QUIRK(0x103c, 0x8da0, "HP 16 Clipper OmniBook 7(X360)", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8da1, "HP 16 Clipper OmniBook X", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8da7, "HP 14 Enstrom OmniBook X", ALC287_FIXUP_CS35L41_I2C_2),
-- 
2.53.0


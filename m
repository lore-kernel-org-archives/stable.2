Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794414218;
	b=FjJhYpCoggS3Hoq6fryGfsrRpDspJUKMPk15GyioGAB0Kck1xsnRTDhlNwd2RMEzB8V6
	 MMLVx/n4XjLP0Bqy1O/yU1TaMxXZK2C4S/TqwjNGQd86swEwVcPrY/L7jP6I3nTNhjNgY
	 fjT4XLkXc0gjn35Nm0XAbeLfb/h2xoUx5UGcriW2nIZe3lmu+EiJIxrPfAupLZjsPRIcs
	 hd22aAXdKQ/8c8oLbAhYnO0WU3gm3ZjHHmLg5y8eJoBmovf0tBWfO65Vxns0UwX/2gDXO
	 nqDNxVZ0NA3ODIYlcuYFi7H47sAg051mH3QWOj5QtOWUg7S83cxadtDBI8fBQBETp5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794414218;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=UqtfVMRKEkFxh1sl/KTh1Udj11b9LEX/NjMZLgNf2zY=;
	b=TV59OLQRdGKfs2qAFXq/rYQ+VPt69rrgGN6E27WHHgoE3Oslxfv+injYiZ5VrnHTBXXq
	 lmKFIZ5uwJEFuPAbxPut00m7L8ek4k5GrrnRGE/mUJAZSVHn+UIQQLHUOJHsLQ0zTse11
	 au/agsnN9AhgFdaZY+hVHBMYgrGbefryRYwnR4OnPf/UIaUAayFaSz7KhoLygB/jKms+j
	 ziWUXzSBMOAfMkimpdVhTzhL4cifspTag/NqoZrHTLIz92LP/JXOx2fTas8Ml5CSPIxMf
	 uXZrypy23JX51BU00AUTHaTYlfEyLkkc3Vnr3+OtETBAWv53hgqvmh3HqC3FYEVT1bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ksgKR2K3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2213A606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 16:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ksgKR2K3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE431F00A05;
	Wed, 11 Nov 2026 16:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794414217;
	bh=UqtfVMRKEkFxh1sl/KTh1Udj11b9LEX/NjMZLgNf2zY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ksgKR2K3OcBH8Fd4HZaIsrfApSD4hKVElPUpirVcIQYmJ6xznW8zBrFOd9xW8VcEn
	 3WdquVa7rKaFfPPumPXXOlM8vJgI73if57euagPHMkU09Ly7ya95bbl47uWbEopYB8
	 Lv0r+GMvYhhgnxeLJwuG0O6tN5u6Erl2moetG/BDQ7hFiMxEGL+NLpjAIdPuuW6tso
	 PKdtFswvR2zUjAdFWfLqbXrjtYtF1ulJkwCheSU9sBL9nfAH8l0SPVl7B1sCwH68cU
	 pywCqDsquUOxmicyArAvYZIS12YE1o0lKV3A3zMIKasxrfU6ARGCj9IXHxM6xczwHG
	 E5Dn/JMEqTCwA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jaeho Cho <jaeho2025@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] ALSA: hda/realtek: Enable mute LEDs on HP OmniBook 7 17-dc0xxx
Date: Wed, 11 Nov 2026 11:23:35 -0500
Message-ID: <20261111162324.3243277-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051223-failed-6.18-c80286aaa4ac@kernel.org>
References: <20261107051223-failed-6.18-c80286aaa4ac@kernel.org>
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

From: Jaeho Cho <jaeho2025@gmail.com>

[ Upstream commit 1c4f6202876a74e752a8cfd3696955f761671c7a ]

The HP OmniBook 7 Laptop 17-dc0xxx (SSID 103c:8d9c) has mute and
mic-mute LEDs on its F6 and F9 keys, but neither lights up. Its quirk
entry only sets up the two CS35L41 amplifiers, so no LED control is
registered for either key.

Writing to the ALC245 by hand with hda-verb, the mute LED responds to
COEF 0x0b bits 2-3 and the mic-mute LED to GPIO 0x04, lit when the pin
is low. That appears to match what ALC245_FIXUP_HP_X360_MUTE_LEDS
already does, so add a fixup that chains the two-amp I2C setup to it
and use it for this model.

Tested on 7.2.4 with the patched module: hda::mute and hda::micmute
are registered, and both LEDs follow the speaker and microphone mute
state, including from the F6 and F9 keys.

Signed-off-by: Jaeho Cho <jaeho2025@gmail.com>
Link: https://patch.msgid.link/20260914142445.3476212-1-jaeho2025@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Stable-dep-of: c80286aaa4ac ("ALSA: hda/realtek: Enable mute LEDs on HP OmniBook X Flip 14-fm0xxx")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/hda/codecs/realtek/alc269.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 99d3fda16f3a2..78f5257fd6070 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -3951,6 +3951,7 @@ enum {
 	ALC287_FIXUP_LEGION_16ACHG6,
 	ALC287_FIXUP_CS35L41_I2C_2,
 	ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED,
+	ALC287_FIXUP_CS35L41_I2C_2_HP_MUTE_LEDS,
 	ALC287_FIXUP_CS35L41_I2C_4,
 	ALC245_FIXUP_CS35L41_SPI_1,
 	ALC245_FIXUP_CS35L41_SPI_2,
@@ -6212,6 +6213,12 @@ static const struct hda_fixup alc269_fixups[] = {
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
@@ -7109,7 +7116,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8d92, "HP ZBook Firefly 16 G12", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8dcd, "HP Victus 15-fa2xxx", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8d9b, "HP 17 Turbine OmniBook 7 UMA", ALC287_FIXUP_CS35L41_I2C_2),
-	SND_PCI_QUIRK(0x103c, 0x8d9c, "HP 17 Turbine OmniBook 7 DIS", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8d9c, "HP 17 Turbine OmniBook 7 DIS", ALC287_FIXUP_CS35L41_I2C_2_HP_MUTE_LEDS),
 	SND_PCI_QUIRK(0x103c, 0x8d9d, "HP 17 Turbine OmniBook X UMA", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8d9e, "HP 17 Turbine OmniBook X DIS", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8d9f, "HP 14 Cadet (x360)", ALC287_FIXUP_CS35L41_I2C_2),
-- 
2.53.0


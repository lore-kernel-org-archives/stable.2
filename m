Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794411410;
	b=eIYrra1VEFGCgD9QX/nReYQY2mW1pY36wOTdecTQXlSRWZrfuPQciVoWKf8PHfrcgAq8
	 xl709AfqeGpjIi5Zn++I0bQcKSnM+GjiADtUeMBalOFvsE7RFBkginJozlvJNnEf1s0HO
	 SD9EIanE+a9vdpr2nRadan/h9zODWFUn/Qnl+/GH5f4hnqW6knhT6QojuvPKoTMcRQW7N
	 n31IFZTfYVhv6nfwdgooXl5gs3mZLYOL6wGC8XY+fDbGETqrHMf23zZ2MHIonTVB6EJMc
	 dDsddk6KTfgxcs97nkvNO2Ujl4Cz/K1OCAb17+5JxC3oD7OnAN7kSpCMsOuM1/+DRXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794411410;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=TTLEEzt1k1Enxaqrnpp4HZmpG97Ys7VdnHjYgq7kT/M=;
	b=G4SFotwq6lkPsdHH7reqzC2bje/O+1iRDS4icLZbERMySOMCh9Kjm4WLTxS8np1GhwcC
	 iId5jcYAlEOroCsA/yEa6Nt2YeSNR/ehE5W2Gm7+f2oFGukTgGUvF6rBdB8RFLXuAcmOT
	 Pe64qwwZZPff+zxHXrhO31gyk/q2nVmWTLSfr1Qjf5magLXWtTHUzFNoh/uKbLXDQLFdx
	 PpSs6O2MIQUYP9gxbbAHHk4stDcBle/ax5DFIZJJZWSMlXxmq3RfXlKOsdKGfY212Eefk
	 X2TM2SRDlb+J7laMfbwaCPPBH6ZPWKI6h+4rLL+pmX90PLta6nxPjCZoY843giYIr0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LJlY27om;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE661606A32A
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 15:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LJlY27om
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FCBB1F00A05;
	Wed, 11 Nov 2026 15:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794411410;
	bh=TTLEEzt1k1Enxaqrnpp4HZmpG97Ys7VdnHjYgq7kT/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LJlY27omueGwMuusLHUpsXUZujzxZfuu1y2skPRsOhuHpsyatxhX/bx6H5Do9+4wk
	 TiWqEL//6r06nKzHVtyhTvdKPLXlpGDPA4r4jvTuqhZRp5xSNyhFd4QAA4pdCAPEWI
	 oupi+BTjQH2V8WPg1pcRMA1pAjsgfsGV6ZMAvoQ6WF2HTDPe5yfHPaQLT90xJQVV7t
	 AiiikRrbMFBA7d1c4m9myPjuTbNWAX+i5AbJ7kEo9DQZv6yG3hIdHwr/LpvFiyJ271
	 U86UJ0gkiWKWVba0PGPIBaSEjUE7EXM1TCMkcQiJVLKe0Uewx9r4hiH6idI+73yrhI
	 Rbz7DyGbHZYBA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Evgeny Akhtimirov <evgeny@devduty.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] ALSA: hda/realtek: Enable all four speaker amps on Lenovo ThinkBook X G2 IAH
Date: Wed, 11 Nov 2026 10:36:48 -0500
Message-ID: <20261111153630.2663279-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050953-failed-6.18-f2293e7b2ddd@kernel.org>
References: <20261107050953-failed-6.18-f2293e7b2ddd@kernel.org>
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

From: Evgeny Akhtimirov <evgeny@devduty.com>

[ Upstream commit f2293e7b2ddd803b1461e0490f9b2f32089c1dd0 ]

The Lenovo ThinkBook X G2 IAH (MTM 21TU) has an ALC287 codec with four
CS35L41 amplifiers on I2C (CSC3551). It reports codec SSID 17aa:3929,
which it shares with the ThinkBook 13x Gen 5, and PCI SSID 17aa:3842.

Since PCI SSID 17aa:3842 has no quirk entry, the codec SSID matches
ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_THINKPAD. That fixup binds only
two amps (cs35l41-hda.0 and .1), while the CS35L41 configuration table
describes four for 17AA3929. Amps .2 and .3 probe and load firmware,
but they are never bound to the codec, so half of the speakers stay
silent.

Add a ThinkPad-style fixup chain that binds four I2C amps, and match the
laptop by its PCI SSID so the ThinkBook 13x Gen 5 is not affected.

Tested with hda_model=1028:0c4d (alias to ALC287_FIXUP_CS35L41_I2C_4):
all four amps bind, apply their calibration and are runtime-active
during playback.

Cc: stable@vger.kernel.org
Signed-off-by: Evgeny Akhtimirov <evgeny@devduty.com>
Link: https://patch.msgid.link/20261009-thinkbook-x-g2-iah-v1-1-56012188aee0@devduty.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
[ sashal: Replaced the unavailable alc287_fixup_tb_vmaster_led() callback with alc287_fixup_bind_dacs(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/hda/codecs/realtek/alc269.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 99d3fda16f3a2..a800de503a1c5 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -3978,6 +3978,8 @@ enum {
 	ALC245_FIXUP_HP_X360_MUTE_LEDS,
 	ALC287_FIXUP_THINKPAD_I2S_SPK,
 	ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_THINKPAD,
+	ALC287_FIXUP_CS35L41_I2C_4_THINKPAD_ACPI,
+	ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_4_THINKPAD,
 	ALC2XX_FIXUP_HEADSET_MIC,
 	ALC289_FIXUP_DELL_CS35L41_SPI_2,
 	ALC294_FIXUP_CS35L41_I2C_2,
@@ -6421,6 +6423,18 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC287_FIXUP_CS35L41_I2C_2_THINKPAD_ACPI,
 	},
+	[ALC287_FIXUP_CS35L41_I2C_4_THINKPAD_ACPI] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = cs35l41_fixup_i2c_four,
+		.chained = true,
+		.chain_id = ALC285_FIXUP_THINKPAD_NO_BASS_SPK_HEADSET_JACK,
+	},
+	[ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_4_THINKPAD] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc287_fixup_bind_dacs,
+		.chained = true,
+		.chain_id = ALC287_FIXUP_CS35L41_I2C_4_THINKPAD_ACPI,
+	},
 	[ALC2XX_FIXUP_HEADSET_MIC] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc2xx_fixup_headset_mic,
@@ -7554,6 +7568,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x3827, "Ideapad S740", ALC285_FIXUP_IDEAPAD_S740_COEF),
 	SND_PCI_QUIRK(0x17aa, 0x3834, "Lenovo IdeaPad Slim 9i 14ITL5", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x383d, "Legion Y9000X 2019", ALC285_FIXUP_LEGION_Y9000X_SPEAKERS),
+	SND_PCI_QUIRK(0x17aa, 0x3842, "ThinkBook X G2 IAH", ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_4_THINKPAD),
 	SND_PCI_QUIRK(0x17aa, 0x3843, "Lenovo Yoga 9i / Yoga Book 9i", ALC287_FIXUP_LENOVO_YOGA_BOOK_9I),
 	/* Yoga Pro 7 14IMH9 shares PCI SSID 17aa:3847 with Legion 7 16ACHG6;
 	 * use codec SSID to distinguish them
-- 
2.53.0


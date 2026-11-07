Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049438;
	b=4iU9Br3aTqcP3t4VhycHX9iov3k5isAaTEyr0jADRRpGPuK5dd4Ja4wTmpVz2+YCMuHI
	 YWRrkvmuxmABegjzQWODvEY6qlW8uPHOQ8FM11W+5u4GNsaYcFi54fJO7enyzyKxtrqBQ
	 GB9oUwg/s9R2wa6RAojSGc28SSylsdU+zt59cRLqHBJeTUHwfi2DUvEvr2VED2pPDII68
	 T5UtkG4X+jDATymkw2ekElMMTaDsfWNLShQNwVG1VeOUbCMb7OXpGD2ImzyTqvo2EhoED
	 8CPghxul7bBaYUmWHLdLR2zVqauMLYvPZ12CZqvxlDO3trtd/atas370rupL4erzp/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049438;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Ha8T9YgSZVAl1R8mVfFL+TruTLssU4Wum2lOCdH5Tyc=;
	b=A0faHdFpN+/Wwi4CfLKv86u7c9Wunli+iIQ75rSxavnAllQrX3Iz991TIWHRYdt7EGs5
	 eGnmVs5hdUA5DiZbx/horue/FTG5rjkeOOQFDKv+eclOqtPR1UMYfcuTiXH3XHiPTXoq2
	 ASJv60kZ2LpG9/TLAKNrkkGcXvlTjZF4h1GhikBc/7HIsXlniJO4Gylm4kL23aJFiWz9T
	 i9U6Nym3QrmoQ9QT6IMlR0MTWkK9CfTpQBiwaVkE5kU1SyXRPUAZFqUZiCgB5+Sh+LMTg
	 f3CMFDZ/gFoVKHsulQJrrI4TKrv7EZ95dyYP41MkERfmKtmJQT8Mfqb1Xvntpa28Oqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NP7RxiGa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD63E606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NP7RxiGa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D74AB1F0089F;
	Sat,  7 Nov 2026 11:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049437;
	bh=Ha8T9YgSZVAl1R8mVfFL+TruTLssU4Wum2lOCdH5Tyc=;
	h=From:To:Cc:Subject:Date;
	b=NP7RxiGaOgRN+JiwMEfWpW43PidrajG+e0cSV8Ho8ceVzOU7MojmO/N6GY5ptfiTD
	 Vp7cRQDdqM9ZHWYh6ODk4poW6fvoMu5MCTbq+uaBpiYx7X58iqT3RXtO1fgXz3eZwl
	 5bxBYxZal5pyTBvIgnXU1GAygZ1A2xZ35eHs+42EUIRZhj6E2e0JtVz0H5sJw2AcG5
	 9WLkmQ3nfW0ElF9wmUW17qeTu7IGwefrvt+DBOU2vBQFFP/stYVezf1T/pOIMmtUeh
	 pApNCr/vJcbXogUdLdNljkdUgVXEDPA0HlyUiy0uKZtD1V0bNY8AHp5Q7S6rKz94Tr
	 f5L4Xmyaos/pg==
From: Sasha Levin <sashal@kernel.org>
To: evgeny@devduty.com,
	tiwai@suse.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ALSA: hda/realtek: Enable all four speaker amps on Lenovo ThinkBook X G2 IAH" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:03:55 -0500
Message-ID: <20261107060355-failed-5.15-f2293e7b2ddd@kernel.org>
X-Mailer: git-send-email 2.53.0
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x f2293e7b2ddd803b1461e0490f9b2f32089c1dd0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060355-failed-5.15-f2293e7b2ddd@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From f2293e7b2ddd803b1461e0490f9b2f32089c1dd0 Mon Sep 17 00:00:00 2001
From: Evgeny Akhtimirov <evgeny@devduty.com>
Date: Fri, 9 Oct 2026 20:02:37 +0400
Subject: [PATCH] ALSA: hda/realtek: Enable all four speaker amps on Lenovo
 ThinkBook X G2 IAH

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
---
 sound/hda/codecs/realtek/alc269.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index a68b6a9b71aa0..217df4301a30e 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -4427,6 +4427,8 @@ enum {
 	ALC245_FIXUP_HP_X360_MUTE_LEDS,
 	ALC287_FIXUP_THINKPAD_I2S_SPK,
 	ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_THINKPAD,
+	ALC287_FIXUP_CS35L41_I2C_4_THINKPAD_ACPI,
+	ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_4_THINKPAD,
 	ALC2XX_FIXUP_HEADSET_MIC,
 	ALC289_FIXUP_DELL_CS35L41_SPI_2,
 	ALC256_FIXUP_ACER_SFG16_MICMUTE_LED,
@@ -7017,6 +7019,18 @@ static const struct hda_fixup alc269_fixups[] = {
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
+		.v.func = alc287_fixup_tb_vmaster_led,
+		.chained = true,
+		.chain_id = ALC287_FIXUP_CS35L41_I2C_4_THINKPAD_ACPI,
+	},
 	[ALC2XX_FIXUP_HEADSET_MIC] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc2xx_fixup_headset_mic,
@@ -8378,6 +8392,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x3827, "Ideapad S740", ALC285_FIXUP_IDEAPAD_S740_COEF),
 	SND_PCI_QUIRK(0x17aa, 0x3834, "Lenovo IdeaPad Slim 9i 14ITL5", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x383d, "Legion Y9000X 2019", ALC285_FIXUP_LEGION_Y9000X_SPEAKERS),
+	SND_PCI_QUIRK(0x17aa, 0x3842, "ThinkBook X G2 IAH", ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_4_THINKPAD),
 	SND_PCI_QUIRK(0x17aa, 0x3843, "Lenovo Yoga 9i / Yoga Book 9i", ALC287_FIXUP_LENOVO_YOGA_BOOK_9I),
 	/* Yoga Pro 7 14IMH9 shares PCI SSID 17aa:3847 with Legion 7 16ACHG6;
 	 * use codec SSID to distinguish them
-- 
2.53.0





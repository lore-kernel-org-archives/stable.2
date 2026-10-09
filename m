Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC65145198F;
	Fri,  9 Oct 2026 16:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791561763; cv=none; b=mhU6qFd+HLO89/VOWUj2jLUVQvJjYbFjBLR01dfnAXXCDQ9+tbZccO179rtMJz/06edcxzRqYJq9P1hx+EYabhXOHWQxooA60TkU7EnGW+Qq2iXvWA+A+XCyi7/PkvauhrCr/kGoqbVw1n4e54DoJSJVPe/JknQHi+uho8x3a5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791561763; c=relaxed/simple;
	bh=igvWJAO2V9my2ZAZZqpzUDGCdqeiTQTYoXNRaEcbuKs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=r1DbdZx5aC8/DVYbLMDU9Ho9hjb6VgRkkrZQh2NA1BgGT2a6jb4CD/X+QbLTH39R7DFnWQo6H9mmpz5F5jhynxxKpNVBZyha4qna/J1xJ2y5M4HBvYFEyaUJ4nc4ksUCg8zW49TwgpQ59IT7SF7aOQKsAEPIqakIc33LFiRkrhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BPQP5oKb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BPQP5oKb"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 534EAC2BCF4;
	Fri,  9 Oct 2026 16:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791561762;
	bh=igvWJAO2V9my2ZAZZqpzUDGCdqeiTQTYoXNRaEcbuKs=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=BPQP5oKbg+kIRjrSl677fGxvJEkjLBNcINp28uaoHu5jYR7QYd1CtROQAZUCQXCKC
	 3DdEgLrbQDO4ghYwbhI7K3fhPyrI7x8ch7V4ZFMNSYuYXc0YVBsCU1dvLo4hxBTa3L
	 CQLsXgdmzlXggcMLu3tqCxA4w2ZFEWzELeUD4S53QAehW1xvXmK0cUYGnJJYG45At0
	 cYkYwwDaDVyMDXKKGr8ti4CsBUQt8zhjyK3HK6JsfjsD5jzh1pQDA5N3vKX+BCtvG4
	 shF+lEcgwKpUTCwxJmyyuFF0E/W6Kz00X6gKBqPzJiDNquv0yfebn69A/DHeUnQE7G
	 esEInDC5YXZqA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FB2CA6015;
	Fri,  9 Oct 2026 16:02:42 +0000 (UTC)
From: Evgeny Akhtimirov via B4 Relay <devnull+evgeny.devduty.com@kernel.org>
Date: Fri, 09 Oct 2026 20:02:37 +0400
Subject: [PATCH] ALSA: hda/realtek: Enable all four speaker amps on Lenovo
 ThinkBook X G2 IAH
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-thinkbook-x-g2-iah-v1-1-56012188aee0@devduty.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MTQqAIBBA4avErBtQo9+rRAvLKQdBQyOC8O5Jy
 2/x3guJIlOCqXoh0s2Jgy+QdQWb1f4gZFMMSqhOCjHiZdm7NQSHDx4KWVsUrRxbQ7o3zQAlPCP
 t/PzTecn5AxysbhZkAAAA
X-Change-ID: 20261009-thinkbook-x-g2-iah-05195dea7d38
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Rhodes <david.rhodes@cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 patches@opensource.cirrus.com, stable@vger.kernel.org, 
 Evgeny Akhtimirov <evgeny@devduty.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791561760; l=3156;
 i=evgeny@devduty.com; s=20261009; h=from:subject:message-id;
 bh=BfsbIsaH+xcSaOBuE7I5ho9CDvOnUQL+4DzaitSAqVw=;
 b=c26iBhGWKwg0niARse87EuFaqvUHE1BwImtaSdsGOlGVPdvcFHiGpeddIxAsZI7aAJX9QmdIi
 tGbJjYlNBx0CHaYQL8ThCED8rRBc+JBgvhf3gCDjwnzyzR14lOcCRye
X-Developer-Key: i=evgeny@devduty.com; a=ed25519;
 pk=3FZbefc8yeIZmuo/7ejP2EM5b4z3JPRLeOgOvhXNloM=
X-Endpoint-Received: by B4 Relay for evgeny@devduty.com/20261009 with
 auth_id=1143
X-Original-From: Evgeny Akhtimirov <evgeny@devduty.com>
Reply-To: evgeny@devduty.com

From: Evgeny Akhtimirov <evgeny@devduty.com>

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
---
 sound/hda/codecs/realtek/alc269.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index a68b6a9b7..217df4301 100644
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

---
base-commit: f5e1a9a3fddab8421416b68bb132ae9626d07156
change-id: 20261009-thinkbook-x-g2-iah-05195dea7d38

Best regards,
-- 
Evgeny Akhtimirov <evgeny@devduty.com>



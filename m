Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046851;
	b=jP98lVQ1DnEE+ZwcflP/fYMVNdikbGFDX3R8XksUQODkyrzXt3l8HEuYiXH2+REjvx94
	 5kFPsEHLYIZ0VfLr2ZyQUTJ2iYgVCJwLmKfUdGMN3otxkwd6kgBQS0bAtPTIxrwwzomN4
	 Q2JDvpPOnsFpo8W+DJO/4mkAKhlzPfGGS1xpCD0ZW++kPwaNHOTPlrTh9/ExWtS3XkGkS
	 hKUyMaBvzfN9rAT9CyQghSE+Wj3XjvFWuJ2Eyncu+lOjHZsMq+cbRwxchADZ2mbweg1Bf
	 asKyjzn7L49AoLio6EGk9zqUKDYVrjb21BOGL/cHdqh7Xpy/0xw2OIZfDrAfkeUwdxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046851;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=2dJf+F72ACoU406FlqjCig0isqDs3xeWvy+uVEKIQ54=;
	b=0YfZr/92O2iBtV4kSih5ls5fhSqnCdsiQZk+6CfuQij4QAtWJ4r/cXqGBebxXVVpAPUL
	 m1u5gi89wf/7u7O/GVBcDouEo/4Bj3AbKJlHoNXUuYi0nvvTxcf3VzmkZtzVJTP1lKJ+y
	 FCmgF/QtimEeul/Rm3IPO9FR6+oI5c6tA8bMCOBmimkkcYbI5BNbM1s/EbxQ9fBcCuyhI
	 Vq/+OvLl4228wbDNpUjrm0f/JFhY4bOhKa+1yGg1iF3bUevJxe1VQcc1q+Qw/PxD8pMRh
	 zW1xKyXoE1WDwJJrzoXqIoUt2sA9VKkEwD//SdWxX/ZxrAjMYpIDePSSfKEA+ht8xpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="lVHZ/2AM";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8836606A334
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lVHZ/2AM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6745B1F0089F;
	Sat,  7 Nov 2026 10:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046850;
	bh=2dJf+F72ACoU406FlqjCig0isqDs3xeWvy+uVEKIQ54=;
	h=From:To:Cc:Subject:Date;
	b=lVHZ/2AMVo23GYPDbWKbawE/wOkGfXaRmIhKMnNX7EPE4v7yrxLsy086Tyjv3CRu6
	 PvHSVNJpBs2yTOoXBe3IM6DmPhoq4NOpUJkvJMspHOZKfYW6Mewdog6ho98aXhtK+8
	 gMzdCq1VLrJiD8xkJ9GgB8blFtnIgI+Y1V1JaL78jgBOWe6COtpQRsFNeQ7ad7/Lqc
	 FtefLVmBEHNHzz8R07+/2qleaUK93LSfojq0JTcUkIM/LDfScXz4+fSgolOxZAFMP9
	 EzVDN1kP6FcFEp6JoYzigyoBcTFUadI7nEkrzkzJC90VJcScsnH4cUfYAFzP6+30om
	 /t0BESXIz0KAw==
From: Sasha Levin <sashal@kernel.org>
To: evgeny@devduty.com,
	tiwai@suse.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ALSA: hda/realtek: Enable all four speaker amps on Lenovo ThinkBook X G2 IAH" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:20:49 -0500
Message-ID: <20261107052049-failed-6.12-f2293e7b2ddd@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x f2293e7b2ddd803b1461e0490f9b2f32089c1dd0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052049-failed-6.12-f2293e7b2ddd@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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





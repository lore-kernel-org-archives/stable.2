Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050434;
	b=yFxL0AALIV81p9m3Ltb26CcgHhAIrAagnq3j3GDFJPjuEyP0v4FyRZJSxQaXOAGqxh1Y
	 G1LLBDPPtDA7/wxC8XbGUB5rhCeIRx2Pp+k95ejPZlvnmr+8xKHLnp+AwmotAH40zBvyP
	 onQL4usig9NswWVrcYX0FmwYfu0r1bcDu7qOcM48+vX9lLD+YGpZfTslpQL5vnnrqcnUi
	 6wI20BdukSEQuRzvPM0bZ7CPIwF+iNb1eLbKZL4FoaQ0fAgzTbgNumAv+PKpwx4b+BwxN
	 U1gqZ61ZOTBIQ8EKePWA0ooSNssZSsKYWJqrFQmifEHWJgzGsnp8gc+OxVlqPdaorWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050434;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=RWFmnISB2TL6+npxYb3yeXfDFJ2A70MFSOTBKuCO6Y0=;
	b=rV9Ul8+LUsZnFMdfSQQHnsDLaDZelqlRI4wWgPcND8BD0nQfVmK1eJkqtzPP5PZMEAyC
	 kJCNM5yBFsMEbYQyN7CmQI6n+lGr39Xxz5Luat0juoOyECLW2iYsu8279eAd8nGxEKvGa
	 PHN0JUrs87iYa1R9o1qkhZvsdxQAbVg6ILgoeorvoLD7DfipTrKZKHdr1xx7ZY8f5P3VA
	 Apm+uF7bBEOWPWh2gusfu2DNxbA/HlMVdjMBdLaJuIGrGAR+RHrvYLGye8hebJgZg02lS
	 eHf3AYtu1XyzxuIwEOiizGroPyhZ0QVaZBQlnoXR7htB/T9hF7Fr7oNhqV4P4FFNgEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lakWPJ6I;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD6E606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lakWPJ6I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E5F21F0089F;
	Sat,  7 Nov 2026 11:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050433;
	bh=RWFmnISB2TL6+npxYb3yeXfDFJ2A70MFSOTBKuCO6Y0=;
	h=From:To:Cc:Subject:Date;
	b=lakWPJ6IjmDhbzfcKAcyeHGDFQ7AOL0lj/drVt5YtlMq/Uwxjh7MJMz0qBDh89VcA
	 zFm7bY9xVLUzBeroumknCxThiSpeV2CdfqLSE7GA+S9QWQ+asPQ5kRQZuNll3efFKg
	 BamefuhoGdWjFsh5i+Slq+R8XJNC13XbFkJpW4vXG30ac81e7+YGVq0VVgK25kL9go
	 8C0k6fGgTlKsWA8BOCLkmpGJ3e5aAQkn9fdTP5kGVSZCMCdrgYa/BAd2t2lPx91o6+
	 NtUE/57igtYKNtK0SsJU4DGvK58X2Hp6P3fAFHwBviHKvnWayae/vytI2pSLe3AGkK
	 RZFCSXvaX85CQ==
From: Sasha Levin <sashal@kernel.org>
To: evgeny@devduty.com,
	tiwai@suse.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ALSA: hda/realtek: Enable all four speaker amps on Lenovo ThinkBook X G2 IAH" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:20:32 -0500
Message-ID: <20261107062032-failed-5.10-f2293e7b2ddd@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x f2293e7b2ddd803b1461e0490f9b2f32089c1dd0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062032-failed-5.10-f2293e7b2ddd@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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





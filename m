Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794312169;
	b=ovKCapU4d+ZR1mz1LR+E51srKkL+O1Bpc73ssgcW1LcBTTwy+00nNS3WOCz2l7eD8km/
	 smhnDtQhCt7dyaGBkdcGs6M3wYLaiszIb2xlouCOmz4Sq9TmwnMvn9M2aE59Z5h65A+IP
	 eN/gfzayrs+LA38xyBZ7tzt4ePRjpsCuuXZvTxBK9XhCigPSDkaPbQ2m2Z38oDkx5npat
	 Y5RboxVnrFwxWbZZRVfk/Jwf3ojr29K12EbWN7H8S5EBH38xFK6zGPVQYEhRxqgJkJy7R
	 6cQ5q7mMa5HwXsCixfxoktpABbvsatw+F2i4SUbbvU0wDUnJMs6xyJieLkjKYNc92AA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312169;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=BiKiJup6gBTtVoYHDe4QIZUEQ6jW/y4ktA+nCN10w2I=;
	b=yoK+MYfPKuXC2cPdrX52N3DHw4UYhVOJIBLQl12zUmuTQjuRY5IalhjrY1dMTdNnk5By
	 CeLDppY6Lw5PVAdJbNZrIVYNnXLhMNfhq62m74n9M7yHAhbutzcui7CKct6yAakEXXtf9
	 ySdGpF4HAP4s4KQRJ16Y3k0+XNy1hn50WnXYlnLZRAH00tQDBErFhmTRdRAsYyM2PVtZz
	 7mH/d0B6v+UxKypTRLNlX1nSn5W6JxVUOMW5/hwj1f/ESqOkzf2TPXiAPvZDcUQBpO5ht
	 lY6GP98oC6R7mR/U+82yeXeZsFLLizI9cVP1D5z9YXjkHtj+SzH9Q4Zn7hpc3+jCxXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TmvB6btd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E831B606A338
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TmvB6btd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43E641F008A1;
	Tue, 10 Nov 2026 12:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794312168;
	bh=BiKiJup6gBTtVoYHDe4QIZUEQ6jW/y4ktA+nCN10w2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TmvB6btdx/7icHdRrhxGaJ4CM37MrItMXPgpCN//sI/uxPKipKmVF2iamsdMuQFHN
	 IrraKhx6eAYXUxOqHCet+hjcsYcAFxM18CZT3+vYloc5Ga6SDXoiGX56IuU/HtrBLE
	 QJXjJrPXSN73ZdL6Td80czEQis1+EtBU1y/FNkaaWFBXxkLg+LxcS5ENzRv+IqTD9n
	 +0zscxl01VzlOtBBYo2hSf9U0wsyhhtaOerStYIRIumjUg6xaOWl0WmRftUX5MfpO8
	 c040HO03VxXWT35GycH9qrjUcr2JkODSKnDTgSXKLawSVz8Ux7R3mf9Y9qN56t93t+
	 qtJXrq1zgUgKw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jared Wuerzburger <jwuerz@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 2/2] ALSA: hda/realtek: Fix internal mic on Minisforum V3 and V3 SE
Date: Tue, 10 Nov 2026 07:02:46 -0500
Message-ID: <20261110120237.930943-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110120237.930943-1-sashal@kernel.org>
References: <20261107050339-failed-7.3-72107104d4f5@kernel.org>
 <20261110120237.930943-1-sashal@kernel.org>
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

From: Jared Wuerzburger <jwuerz@gmail.com>

[ Upstream commit 72107104d4f522405c9dfdfbaeb230e371c295ee ]

On the Minisforum V3 and V3 SE (ALC245, PCI SSID 1f4c:e001) the
internal digital microphone array never produces any audio. The DMIC
pin 0x12 is parsed correctly ("Internal Mic=0x12"), but the headset mic
jack pin 0x19 (BIOS pin config 0x04a19050, jack detect enabled) has no
presence detect wired on these boards: reading GET_PIN_SENSE on 0x19
always returns "present" (as it does on the unused, unconnected pin
0x18), while the headphone jack 0x21 reports correctly.

The generic parser therefore sets up auto-mic switching and, believing
an external mic is always plugged in, permanently routes the ADC to the
empty jack (mixer 0x23 input 0x19 unmuted, input 0x12 muted). The
"Mic Jack" kcontrol reports "on" with nothing plugged in.

Mark pin 0x19 as having no presence detect. The parser then stops
auto-switching and exposes a normal "Capture Source" (Internal Mic /
Mic) control, which desktop audio stacks drive from their Internal
Microphone / Microphone ports. The existing bass speaker DAC routing is
kept by chaining to ALC245_FIXUP_BASS_HP_DAC.

Tested on both models with the same pin config applied through a
snd-hda-intel patch firmware ([pincfg] 0x19 0x04a19150):
 - V3 SE (Ryzen 7 7735U, BIOS 1.03), kernel 7.2.6
 - V3 (Ryzen 7 8840U, BIOS 1.06), kernel 7.2.7
Both boards report the same codec SSID and the same 0x19 default. On
both, the internal mic records at a normal level, headphone jack
detection on 0x21 still switches output, and the bass routing is
retained (DAC1/DAC2 Playback Volume controls present). A headset mic
on the combo jack was not tested (none available); with this change it
has to be selected manually. V3 users already report that the jack mic
gets no input [1], which is the other symptom of the same broken
presence detect.

The patched alc269.c was build-tested with W=1 on tiwai/sound.git
for-linus (7.3-rc3) without new warnings.

The diagnosis, the fixup and this changelog were written with the help
of an AI coding assistant; I reviewed them and tested the change on the
hardware listed above.

Fixes: e34743018249 ("ALSA: hda/realtek: Add quirk for Minisforum V3 SE")
Link: https://github.com/mudkipme/awesome-minisforum-v3/issues/14 [1]
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Jared Wuerzburger <jwuerz@gmail.com>
Link: https://patch.msgid.link/20260928152925.69032-1-jwuerz@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/hda/codecs/realtek/alc269.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 03f03080bbeb5..49c4d01759b06 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -4413,6 +4413,7 @@ enum {
 	ALC287_FIXUP_YOGA9_SPEAKER2_TO_DAC1,
 	ALC256_FIXUP_IPASON_SMARTBOOK_S1,
 	ALC256_FIXUP_ASUS_SPEAKER_COEFS,
+	ALC245_FIXUP_MINISFORUM_V3_MIC_NO_PRESENCE,
 };
 
 /* A special fixup for Lenovo C940 and Yoga Duet 7;
@@ -7236,6 +7237,15 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC256_FIXUP_ASUS_MIC_NO_PRESENCE,
 	},
+	[ALC245_FIXUP_MINISFORUM_V3_MIC_NO_PRESENCE] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x19, 0x04a19150 }, /* headset mic jack, no presence detect */
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC245_FIXUP_BASS_HP_DAC
+	},
 };
 
 static const struct hda_quirk alc269_fixup_tbl[] = {
@@ -8475,7 +8485,8 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1ee7, 0x2081, "HONOR MRB-XXX M1020", ALC256_FIXUP_HONOR_MRB_XXX_M1020_AUDIO),
 	SND_PCI_QUIRK(0x1f4c, 0xb020, "Minisforum AI X1 Pro",
 		      ALC245_FIXUP_MINISFORUM_JACK_DETECT),
-	SND_PCI_QUIRK(0x1f4c, 0xe001, "Minisforum V3 (SE)", ALC245_FIXUP_BASS_HP_DAC),
+	SND_PCI_QUIRK(0x1f4c, 0xe001, "Minisforum V3 (SE)",
+		      ALC245_FIXUP_MINISFORUM_V3_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1f66, 0x0105, "Ayaneo Portable Game Player", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x2014, 0x800a, "Positivo ARN50", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x2039, 0x0001, "Inspur S14-G1", ALC295_FIXUP_CHROME_BOOK),
-- 
2.53.0


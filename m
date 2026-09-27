Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935E8184540
	for <stable@vger.kernel.org>; Sun, 27 Sep 2026 17:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790530391; cv=none; b=NLEmh7H2EBj+fRBJkis/bWPhlmIQ0pF13QxY0hN78TOqYEuLfTygV22yi7vx3ERcwxsqJiDy1wrNrnSPF0VMUH9hXb0Y0izJxDJvF94DWkAkLxh9MEb7qzoJrSyeQjTbSWa+TSe2CIs5g24ekmVYxhE4RrM9qy4LaGLs3jhExSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790530391; c=relaxed/simple;
	bh=PACSGZHoWOhPcJ0+qIAAzlnOA5S/g8zlax0nJRW92Lc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WugjVv7Z56UP1pc5uGewJjyDLcvfHQYSh10/Ka0OH8LqLFgULTC+x602ssXsQpx64bt7tZNuV8KBqf8gRGRk1z4M3EQcPKSFthmd2D56nthx/5XwjCn0yBPYd72nFPoGC4drfnhllmX4fT0KKxB6r4PAgYrPSYB2iy/Q6CxpxLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G2bJTyxf; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2bJTyxf"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-91059280d58so19617286d6.1
        for <stable@vger.kernel.org>; Sun, 27 Sep 2026 10:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790530388; x=1791135188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0Bih5QsU7JkSj/FZUF3rXni5L3KGUCeOtVn2fm+Cr2s=;
        b=G2bJTyxfG6fg5NAy97wDlB7t47lMlaBALBqFLKlp0hMSV7c1zKA20gU0d1bJVet8tk
         hOCmNNagH5F2himkwiLkOK0nluYzFyons8fQqYbEA5gUi2Ub62fH14kRfLhvbJ7wUKvS
         IlquUmKvqmoL5t+EJ6i0B+NwaUW1nKN+pXASpCCSHDGnHhUl6SbjNryFltZvTK4i1aC3
         PsTqeXOzvjUrfLtKzAbXBLRbMydZPyzbWSzRjbXcbXmAf8V4N0eVHX0TxRMbob4Tf9WW
         K40b28kiws8IECNlO0Rd8jpZ9c/HTnxIvxVrriTxD8IMNHsTnhrB6F//wVNHuyfWrugu
         4iYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790530388; x=1791135188;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0Bih5QsU7JkSj/FZUF3rXni5L3KGUCeOtVn2fm+Cr2s=;
        b=PY9T5GbGrcOXi8aQX8/2a0THZpDdyuZ9yzBwBKqi+XLaaA8hN14AdbY3OYVynTvZLs
         bD0M4j1vrzVe8zcTR8IuZvEIr8JA0CPakR6uZ9Yzgeh275wSv6euZ6l6A6Yw5kGWb9xg
         eMfU2j82Wr3dGvr9z1jqFmuataY74KyG/9+AE7Y8eHIq5RNO7pINLKcF8EDLn6nTFIBy
         2QMsbHn0z38lElkk+j7TX4cPM30P5QXRCiYR1qe1erYjocC7+vjYBAr+AQbrSgTwBPHP
         DSiZ59KNkGYJZv/+A7tbZY/cNy+Aol3GmpDoEAUZAfF3zzrDgyEUdOAZjPsngCKi9aMA
         h0CQ==
X-Forwarded-Encrypted: i=1; AKwUvBzgZaG886QAZQAEbE4C4zBOd8cmyE7IZV+rQMs8aP4IuEoGim9xX5nIe7tSyOX3zxWZeoGoD6M=@vger.kernel.org
X-Gm-Message-State: AFuF++krjCGRoNEG069f7/xwj3RWCkc/MQSTJienrjpYjUkw0DCD5085
	K2VL8UM482aikPRgCTdnI+TgjyuU4l+HRqac1WyNNHnc3b1d7rK2m/wX
X-Gm-Gg: AYBFou2uUmAQxNHLd50Tpa5dNyyJgRL3WSVsjXUGRVnb9sTo2AsXdBIakekoCahRcQS
	vJvL3Qva8Q+HmMP6AHBfPFq0qUXiFwawxpR6dxi/gC9WH33OzJmMFSO9MjkRoL2gXLynAdBrbye
	8TxM0ujztLzo8K8sxBbJ9S5d+CBGCcxDBpSNHf3j3AkL7Ydw9ET7kINBqMYn59yjmYXZSRHfgdF
	WuCBBVqDYKVDrbPw72Am1wrGLxL9bJ3p0HtmZoNszUnyjDYXXNmR6V+FB8Hre8Y+AfeizQRLWXp
	M/QeUvSvt83AxLzpo/xrVJ/sQ5I0PfqdHmlSzr/JgQ9jMLNN4AOfTTTDfKoOKZPfmfwnRsHuEk6
	EiwMIhiTqJrikyIwP0p+KWvs06glLllmCbrVANqkn586P6utJ4DoEDdegTFzItbu49q4trviiyK
	Sj5xlXTHczTdCOIyw7aTW6dTDNHweVfWVCE5UyKs0pcRer2SDTPcKymL9aFh1l2l0mSaqXY0NvR
	uehvp2UwzTRLjX+Jn6DdY6A1CzJX+FUDfuTNtGe049lHf48XhI8PCw+SG9YNIgWtOAKiYrEhN8g
	rfg9AEKMJN61dzMQsw==
X-Received: by 2002:a05:6214:21c6:b0:914:4fc3:e865 with SMTP id 6a1803df08f44-9144fc3f5ecmr81736046d6.1.1790530388371;
        Sun, 27 Sep 2026 10:33:08 -0700 (PDT)
Received: from cachyos-SlimIce.lan (1841343-static.dvnpiaaa.metronetinc.net. [195.252.229.229])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91430da86f7sm63390986d6.9.2026.09.27.10.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 10:33:07 -0700 (PDT)
From: Jared Wuerzburger <jwuerz@gmail.com>
To: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Samuel Dionne-Riel <samuel@dionne-riel.com>,
	Jared Wuerzburger <jwuerz@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek: Fix internal mic on Minisforum V3 and V3 SE
Date: Sun, 27 Sep 2026 12:32:37 -0500
Message-ID: <20260927173237.339476-1-jwuerz@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Link: https://github.com/mudkipme/awesome-minisforum-v3/issues/14 [1]
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Jared Wuerzburger <jwuerz@gmail.com>
---
 sound/hda/codecs/realtek/alc269.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 5127a111c..2de91431f 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -4384,6 +4384,7 @@ enum {
 	ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN_HEADSET,
 	ALC285_LENOVO_DAC_RENAME,
 	ALC287_FIXUP_YOGA9_SPEAKER2_TO_DAC1,
+	ALC245_FIXUP_MINISFORUM_V3_MIC_NO_PRESENCE,
 };
 
 /* A special fixup for Lenovo C940 and Yoga Duet 7;
@@ -7136,6 +7137,15 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC287_FIXUP_TXNW2781_I2C,
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
@@ -8349,7 +8359,8 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1ee7, 0x2081, "HONOR MRB-XXX M1020", ALC256_FIXUP_HONOR_MRB_XXX_M1020_AUDIO),
 	SND_PCI_QUIRK(0x1f4c, 0xb020, "Minisforum AI X1 Pro",
 		      ALC245_FIXUP_MINISFORUM_JACK_DETECT),
-	SND_PCI_QUIRK(0x1f4c, 0xe001, "Minisforum V3 (SE)", ALC245_FIXUP_BASS_HP_DAC),
+	SND_PCI_QUIRK(0x1f4c, 0xe001, "Minisforum V3 (SE)",
+		      ALC245_FIXUP_MINISFORUM_V3_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1f66, 0x0105, "Ayaneo Portable Game Player", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x2014, 0x800a, "Positivo ARN50", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x2039, 0x0001, "Inspur S14-G1", ALC295_FIXUP_CHROME_BOOK),
@@ -8579,6 +8590,7 @@ static const struct hda_model_fixup alc269_fixup_models[] = {
 	{.id = ALC236_FIXUP_LENOVO_INV_DMIC, .name = "alc236-fixup-lenovo-inv-mic"},
 	{.id = ALC2XX_FIXUP_HEADSET_MIC, .name = "alc2xx-fixup-headset-mic"},
 	{.id = ALC245_FIXUP_BASS_HP_DAC, .name = "alc245-fixup-bass-hp-dac"},
+	{.id = ALC245_FIXUP_MINISFORUM_V3_MIC_NO_PRESENCE, .name = "alc245-minisforum-v3-mic"},
 	{.id = ALC256_FIXUP_HONOR_MRB_XXX_M1020_AUDIO, .name = "alc256-honor-mrb-xxx-m1020-audio"},
 	{.id = ALC287_FIXUP_LENOVO_LEGION_AW88399, .name = "alc287-lenovo-legion-aw88399"},
 	{}
-- 
2.55.0


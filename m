Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177574E9C0D
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 15:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790609389; cv=none; b=LqzZVSs/8kD4O4VHyznfAbavcqjqK4Yezl4zui5T4+s0KexrOzFhQYbgh3Ey1APB7LU7uOIXyvWnflBGq00LuPDM6OGksaloChOeFhTEUakvrCu3TE6EnXU43rAuofxoSi3YgfxpTILFOLdykkZMIT23fADNFb1xQzkj1tOwPDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790609389; c=relaxed/simple;
	bh=QWsd3wxevy+japnbf8IB+oIJRFrkXbpx/xJHJ2YNGDY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LBH5A7EP7VIy70XcTil7SKLE3sO6e62Lfx21x+GuHZxmK21YtXmVgAIvNdZ6FZqiNkI7u/bfzWK8H4SgQqFtg3Df+eZ6hNId05Wv6EBD+n6X7Q8674eQP6bHyY05PYVwxtbLRpKxRJNA+M0lw51hfJkFdazcTtea9++Fy1UvBMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V6zdbmTk; arc=none smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6zdbmTk"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4c66ba0b762so598444b6e.1
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 08:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790609387; x=1791214187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XoZ89Zwbou41YSb+ju1qDv/4cuEDzLy4HojALjA6SyI=;
        b=V6zdbmTkGBaR5RSR268VCAy/wDdem+kjLY6zqBjYpB42PZBzACOFmMfaDKD2quImKR
         zeqydP90lV+ucXynSfl+4xr582MX3vZWpYnTEd0G6rA9XDVUI2MwSGq3eVsHclJbyNWk
         IeIcIXPHqgN5sJ0bV5gV2bR6Wz7DXhQFTUCeWZl8rxuqgdDc0eh0HA+OrStYuuI2q2bE
         Duqc1usLVGnyf6zOeOw1uPZvTZqKAPhC8YjKLClaKgy3Pw18Mphl91vOnnnxZx+pe9Vr
         e9ka5Jn5rO42g48O6UB/LL28Gb4MMjBbydsKoHj10OS4PQV6W6K4+pMdt9dUj/mLITAg
         Q8LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790609387; x=1791214187;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XoZ89Zwbou41YSb+ju1qDv/4cuEDzLy4HojALjA6SyI=;
        b=T4HQAYdsRBTuIDpNQzC9VqGYh/4JSCNGN+GmkqsFp6jblOTCLwQ2f/bqjn5GjDuOAl
         bV97SEXCPEsHUz7tkZKg/+UlFakv9Xhs65/hs1W0YGGXkaiwuBoYdNtahrRJXDkBIjzA
         Pd429WiThZhf+QkZr42QOFRCAWJ18HmZJQvVtHcCtt6i4abjoqlzM0T23ubvFQZ48BpZ
         kCu59GX7ifR+v/3KTiT6wyY7FDUFdVqn+4bxbnN4a5HhqIeBmHSkpcBN9voQD1PJAknH
         8L3+sx0GkPmO2Mr5wjjfMtvcfTL3M7rkF0KWxGpt6ebwN9kAv9i9FEuut5k+a1yOGSU6
         GQMQ==
X-Forwarded-Encrypted: i=1; AKwUvBySklfvzV/uA7+ONmd+XO2Tow2KxG2NwpmsSOdst/yzcWzxbi64W/crNiz2FuKHYVT1jYh3GpA=@vger.kernel.org
X-Gm-Message-State: AFuF++ml3JuO1R4jLsm3am5fc52XnIDZca5vgTTRYX25gf32icwKjDEq
	HOEOKWMGgxrS1VtB3rfB1/WXiRU90MQyiOCs50kj+1GrLErHg8oxeC9z
X-Gm-Gg: AYBFou3yNdSM0CL51bH94B+QogZgHy33pLc3fMdS5LE3DUh4GbCp7K00YBtIgp+lCYE
	aRDXv/yq7gmP0L6gIwV7VBx2Z2blSUCShv25uhKLx/uWSPo3fLewTyu09WjccqOTiIzfQWzJAsr
	Rr01We0d/VcBUeblXexM2Reypfh1eNN3035bsp0QHr3DSptuAlij2D0PRhuT7F0MRtp0kEOsIRp
	qZiCj7zf+YzSbikClfecpGi25gWy0qHx9YrvkpGtuZkx5pCpwwGkw/UmTToqPzkW8f8SzojwHj/
	FMTPLtgC5dJrwb4tZYEfOGbieSb/1oiV2bMkBNweanOXwEIxW9lu8YLOi+A3VEv48MacN7U9FMO
	A2sCp4W50T6c5WhdAYbrNfkdJYWbeZBIS4CLLo0pNMBesDDPKiP1KAa1o+DG28NKOB9GsN8ryI+
	9sA0ibu8vjADi2+5F61ZqGUgoT5O/yT04tXS8T19MaCzeGlK9yKcaJwVFYeCgK6/PNBBbg7UNyj
	u2sdaQcSvRLsA1CqLoBMg==
X-Received: by 2002:a05:6808:1204:b0:4b8:46e3:e229 with SMTP id 5614622812f47-4d72c837a21mr10326982b6e.21.1790609386543;
        Mon, 28 Sep 2026 08:29:46 -0700 (PDT)
Received: from cachyos-SlimIce.lan ([2607:fb90:9a26:9349::e71])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4ebb6e9e924sm1895924b6e.1.2026.09.28.08.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 08:29:45 -0700 (PDT)
From: Jared Wuerzburger <jwuerz@gmail.com>
To: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Samuel Dionne-Riel <samuel@dionne-riel.com>,
	Jared Wuerzburger <jwuerz@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] ALSA: hda/realtek: Fix internal mic on Minisforum V3 and V3 SE
Date: Mon, 28 Sep 2026 10:29:25 -0500
Message-ID: <20260928152925.69032-1-jwuerz@gmail.com>
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

Fixes: e34743018249 ("ALSA: hda/realtek: Add quirk for Minisforum V3 SE")
Link: https://github.com/mudkipme/awesome-minisforum-v3/issues/14 [1]
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Jared Wuerzburger <jwuerz@gmail.com>
---
Changes in v2:
- Drop the alc269_fixup_models[] entry (Takashi)
- Add Fixes: tag for the commit that added the V3 (SE) quirk (Takashi)
- Assisted-by: LLM (Takashi)
- v1: https://lore.kernel.org/linux-sound/20260927173237.339476-1-jwuerz@gmail.com/

 sound/hda/codecs/realtek/alc269.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 5127a111c5..d9ce10d5d3 100644
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
-- 
2.55.0


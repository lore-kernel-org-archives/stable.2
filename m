Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792FF535FC1
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 20:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791924145; cv=none; b=emiK8TOrmhbpooAuhilXZogGzT3y7NmWy9ObGptlkroi0aGs5jL9JPKDajCZwWDojQoqCeFGNmD6WZyylNkMpl4vQubyK5w0wF0gOBsNLaH8v97y9uCSnyoHT3a46joPQpf133deYMnZXYoPV9hyAJb7m9eKrDZkC8SAI2xQZoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791924145; c=relaxed/simple;
	bh=EU/lXhcyesppo2k4iqqbE1WUHSYLUnCdm/FVETA/lG0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c8hS1+aT0DVf4sJBJhopOBQdf7MzGO0453tAv1SqWLZLrjvtw0svXAGaTIbWSE3G43LKIk1WCvboUkZ1krlyxxlfADJpKX25XMyQS0752pqK8cerZY2SrkARTDI2+g3Jnd2RT1UWkTV/5+aebDs0SRkhJA5HvXsmyQ2LPFBt0fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+X5sNFu; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+X5sNFu"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-15354aa70e8so806284c88.1
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 13:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791924143; x=1792528943; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iLt6GKuvAarV8gdf+zpsyObKDRlnXSW8t5lVL3DEXxI=;
        b=S+X5sNFuYrBsi1WR8vN9OktaV8ts6Tgcf8FVPR+wcIgjkonfrogXtxjCd27jY32lGm
         ieTVmz6+xKgJ6ueiWYG3sOxZW5FxuroAvh0/qQqNYJhvBa8iBqApokceLhjBpeC8Xc0I
         kqk1UHDpVOdRIHOULswFRLi1JP8NIU+93vvkEi44L8Uxc1d+yIdfVvQu4bV3pbFIb67k
         nNqF4cvcOMDYtdTWIQLsOsDBYIQ+PIPJJjwUYZloY/cF2tvD9oW+yUPih4N6Q8XV+Qpl
         XGwNm0h54LFzzauV8/UEPq2LVp9WNtgY8CcwSVbrPmqHkgGogpwCEKBZw0yx1h8U6PWt
         yVZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791924143; x=1792528943;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iLt6GKuvAarV8gdf+zpsyObKDRlnXSW8t5lVL3DEXxI=;
        b=gyp4HDP9DA0SfTiGkKHP/unq2x3NS2aaIAV559X95CjXGhY+Yo+ZwJDZ7+aLbrli62
         TiiO1odvXRZdOBSWBXMl6osnhwtvkX62DtkoLfTIc0E+VFXoaaUbzQlIKHDgEJbkqdb0
         k91opCqPx0T9cBxtk9noiYTya+Ipk0n6/YbKqYiYFREtqmi/5vRFBF9R2R2ImwTumOH1
         uR7eCQwKXv56D1lDZqaQw1EXeebCvqI3uItu/YNtHA2fKuWyqCY1sk88AsXemPw3W/N/
         JGiaUZvkbkYrz76R9uBN/UZHgkstB1eJBNbvYIcq5AaD0LZjKAnw4jMJmBacvMvBc6Xu
         5S4w==
X-Forwarded-Encrypted: i=1; AKwUvBw9CGv3fq5aAtN0AxwstG+5fPPktPJUKyLNOX6VY71gAo5X8x/Z3BHCw8BKgtddg9E98k5Hjvc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLIQg9L1oHIDWJH4nvy2y2S0gMZ0vbiO33BNxvxaxt6roAB7aPX
	Wj/x3lhXETRfgRy3vA+uJj6dBZVYJyw8ZEh4DyDKRFhATcas8nltIGmo
X-Gm-Gg: AYBFou3LJXt7gP5txB3V5Svmn4X3QfS34rLZ7Gv0UnW3VNZYN5fQhM+k4tHc9mfvwuX
	AW4sVjcj5yqicKQvSvbdkbWaSrHOJAr+UtMR9C6nA1hhmBRpLxC1Fz8eKjSHKVhbhIiRCTAYooy
	mcDU+23kEuUpGpXjlzWX/FL9DvOwug3vbLuJkGOZFv3pSSyxx8JvPuZ9AXGfqi8ggiY8V9OLl5Z
	XR8+PlNlWNpyLYsNF34dV89j7zchdU57SE8Y3kcUK8AF5xBMvBsIVSvIiDB5CpkYypsK6DMOcS/
	ix7LfqX36sYq9K/dhA8UsGTl2FGoNUuUloHnY2lm2s1gOt7M8tF7jAbTZCmTAvSzTAWbAAyZFi5
	Z0xt+vOsFda3FB5p59HqE8N0DijiVAwbocoBjt3QMMIdUUl7HqoTp+DjrXhCmyA56VVUfa6QxVo
	pyfBBEQMz3tdL8rC8tBErCJorVZ5uKO3eqYcLFE+T9xJb2dM43vIKe4ENWndu1jlNl
X-Received: by 2002:a05:7022:296:10b0:153:4a27:4ea5 with SMTP id a92af1059eb24-16a600667a0mr17435729c88.28.1791924143269;
        Tue, 13 Oct 2026 13:42:23 -0700 (PDT)
Received: from unix.. ([181.229.23.179])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a6021e49sm41761598c88.20.2026.10.13.13.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 13:42:22 -0700 (PDT)
From: =?UTF-8?q?Iv=C3=A1n=20Ezequiel=20Rodriguez?= <ivanrwcm25@gmail.com>
To: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org
Cc: Kailang Yang <kailang@realtek.com>,
	Naser Al-Asbahi <nasserqahtan0@gmail.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek: keep headset mic on Acer SSID 0x1640
Date: Tue, 13 Oct 2026 17:42:19 -0300
Message-ID: <20261013204219.9649-1-ivanrwcm25@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The micmute-LED quirk for the Aspire A315-44P matches PCI SSID
1025:1640 before the Acer ALC256 pin fallback. The Aspire Go 15
AG15-42P shares that SSID and leaves nid 0x19 as 0x411111f0, so
selecting the LED-only fixup drops the headset-mic pin remap that
the fallback would have applied.

Chain ALC2XX_FIXUP_HEADSET_MIC before the GPIO3 micmute LED on that
SSID. Leave the Swift SFG16 entry (0x169a) unchanged.

Tested on Acer Aspire AG15-42P (Callisto_BCU): PCI pick 1025:1640,
Headset Mic=0x19, GPIO3 enabled with no physical micmute LED, speaker
and capture paths functional.

Fixes: d830631a128b ("ALSA: hda/realtek: Add micmute LED quirk for Acer Aspire A315-44P")
Cc: stable@vger.kernel.org
Signed-off-by: Iván Ezequiel Rodriguez <ivanrwcm25@gmail.com>
---
 sound/hda/codecs/realtek/alc269.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 1623cf926c71..2793d09fbf6f 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -4388,6 +4388,7 @@ enum {
 	ALC285_LENOVO_DAC_RENAME,
 	ALC287_FIXUP_YOGA9_SPEAKER2_TO_DAC1,
 	ALC256_FIXUP_IPASON_SMARTBOOK_S1,
+	ALC256_FIXUP_ACER_HEADSET_MICMUTE_LED,
 };
 
 /* A special fixup for Lenovo C940 and Yoga Duet 7;
@@ -6900,6 +6901,13 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc256_fixup_acer_sfg16_micmute_led,
 	},
+	[ALC256_FIXUP_ACER_HEADSET_MICMUTE_LED] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc256_fixup_acer_sfg16_micmute_led,
+		.chained = true,
+		.chained_before = true,
+		.chain_id = ALC2XX_FIXUP_HEADSET_MIC,
+	},
 	[ALC256_FIXUP_HEADPHONE_AMP_VOL] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc256_decrease_headphone_amp_val,
@@ -7230,7 +7238,13 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1025, 0x160e, "Acer PT316-51S", ALC2XX_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1025, 0x1616, "Acer Aspire A515-57", ALC256_FIXUP_ACER_COLDBOOT),
 	SND_PCI_QUIRK(0x1025, 0x161f, "Acer S40-54", ALC256_FIXUP_ACER_MIC_NO_PRESENCE),
-	SND_PCI_QUIRK(0x1025, 0x1640, "Acer Aspire A315-44P", ALC256_FIXUP_ACER_SFG16_MICMUTE_LED),
+	/*
+	 * Shared SSID: A315-44P needs GPIO3 micmute LED; AG15-42P needs
+	 * the headset pin remap (BIOS leaves 0x19 as 0x411111f0). One
+	 * entry applies both. GPIO3 is unused on AG15.
+	 */
+	SND_PCI_QUIRK(0x1025, 0x1640, "Acer Aspire A315-44P / AG15-42P",
+		      ALC256_FIXUP_ACER_HEADSET_MICMUTE_LED),
 	SND_PCI_QUIRK(0x1025, 0x166c, "Acer Predator PH16-71", ALC2XX_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1025, 0x1679, "Acer Nitro 16 AN16-41", ALC2XX_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1025, 0x169a, "Acer Swift SFG16", ALC256_FIXUP_ACER_SFG16_MICMUTE_LED),
-- 
2.43.0


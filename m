Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F7F3DAACF
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 20:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791405506; cv=none; b=GVZnCwaOVuSMfc3iIJetfFZqZUzq55JO/v1dWeEpMoMHvZRWNesyawLL52PdVu8lIMiLh+ovuemiE6vIoMy14Nlxs9Nzw1yEN3p8pxSM++fOMJ4mp5vjPXBiGp+Q3uKGAhqw7V8XKUwHGMdLk4GnFPahpTcyCjp6YngoEKmP4bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791405506; c=relaxed/simple;
	bh=K4d6gMnFf7ZQsWCeq6Sn4NSLWjg5XihUSjEuj/5HpvU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=aWNccdwUTCdbcig+ntzB83QslelFmZ/VPAPaQoA4UtPtiTOg759hGxOdnsC8dZhlTiPorwYrIR4rrWJq8bezxZYhxK13K3tMEn4sjGPFMB5aHrvm/RON0AUDTtvYn2JhaCuAR31HH5b7z29iFfofIpUd3Bc6XPReE7Ti19Gr+3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sJE4/YfG; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sJE4/YfG"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a16c399641so22637805e9.2
        for <stable@vger.kernel.org>; Wed, 07 Oct 2026 13:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791405503; x=1792010303; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CBotmnq4JEv7wrBKpjasAguJIHdEJNs+KfFfRaMl3IY=;
        b=sJE4/YfGVug7Tja0yoiDu8gpbL4AAt3PSD/eS24snPjYeEHCU/KaH5+J2ncx9QB3O9
         IWNTBpooPDVv+7ygVW7FzjDR75yWTqj3qHIVIJKsu+xW294KZDb4Mz06VED+gV6uxPSh
         0dWAl1IS7EeWfe0B3qBuz2CZhpbJMzUIdA45mSBGDA92sFk8lCOUOhEMU55CV41pNmti
         JBncx27KR8B9BlCQi8DZ/OlaikqTAZ+PRlqus5RuHESBmVNqKxhh/lDPGdsTEfjsUClh
         HUbLrtJSIWEHCTtNluDJEOj/rEDy+YpsYGnyxe2QfaqZ2qrHcaHLNZQfQOXfaqzVd2PJ
         4kaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791405503; x=1792010303;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=CBotmnq4JEv7wrBKpjasAguJIHdEJNs+KfFfRaMl3IY=;
        b=sx9H9Vjtwn8NxGB6JxUUmAxrU6OxtJwlKVuix/jBUvsOaITU7UAstQUyY7GsCXGS5F
         0sDbPfatfR2SxOpGYJxr0LxlyX2eFI3PQDNyyFNA09D9zcKyBHpxoG7HWMyaU58wAJG4
         ML8yfEzz/M5a/AhRpAUjLgmNoWyMYTHKwk8IxE3wXbS2DHa68X2L5etJeZLRJaiOdyL9
         1VERa77Cn4yfAGC93VjXSCoxNhtjVTDsAEInRzmeYygGYufnJP32rQZfN4eteT541qWb
         1Xfs23y8UHEA/+9ycNF5X7gbMt2YbleznefX7ELTKwtO/b/xYfRxkR45qn8leDJCcE0s
         wsbQ==
X-Forwarded-Encrypted: i=1; AKwUvBzspy2YPqmHzeQTJBUk0IzxEDtnhy/II7C7WNcUADmFfnhzufgQRfdUczdHVekGY1efisNC4tw=@vger.kernel.org
X-Gm-Message-State: AFuF++kodLJ9u5DNA7RvwTjDem+HSWUZ4v6p4UGBFoXSzaK4ykwBZ7nn
	etlKBYg0E1QlK0BsY8zXeILzRo3n9O5jXITyoogiUYQfML/zMf9qMZ5h
X-Gm-Gg: AYBFou3FeR1laWKvfdB3bW3zxuZlBJC+4kHfk9JNfVzjdav2tLdLjFqEVKDtX31Db0o
	km6kiAGHw+vcYQxIDEH6xGEcRDnH7m4tX5tFkWZK7OrM/PHfH1yE29VdvAh24T6UNv4sriglwxu
	/1jy/ALr1YgvYQnuSrZuJa08+QwBJaAB6U4FU8EUiPt0hmQ8TSwoI2a3XrlCMnFg8qzRWgs5DMb
	XwV7VjarKFxeOHnakOiZIAsd1nl8Uf9+7b4rD1+UB4WQsQpahNBOCuQWK8zrNgWvM3VtYB99mJc
	NhaNL47AQm39OI046Q5fulXa8lTg9q7gJMBWRmAAR/ZBhpiF/V1gbXd5h6VU9p9BaTgwRTtZ+78
	Wonr2DyrZ2Rcgm9yCnWCgu62f/CEcTebSMqKrDrR6xeLFV0yuCdwRycy6yVNQOV/ofAKNlzhZSL
	55jeKX1b24CKf80r/1SlF9BSu+fSW3LEM3bIrkGEfYVyHVB9Rst5oviybB7EAqSsCQuYF3uyn2X
	fQUJhQg810b9c/I0XpXF9II9T0vbyuJK37qrjGAwzNA9e/nIewCXKX9hwGj1vFhbpQrXW3X6URn
	2eRfdOAtx0I=
X-Received: by 2002:a05:600c:8105:b0:4a0:20c7:6d4c with SMTP id 5b1f17b1804b1-4a180085f90mr62137995e9.0.1791405503347;
        Wed, 07 Oct 2026 13:38:23 -0700 (PDT)
Received: from [192.168.0.165] (85-135-167-198.adsl.slovanet.sk. [85.135.167.198])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1843bd060sm21963115e9.14.2026.10.07.13.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 13:38:22 -0700 (PDT)
From: Matej Sochan <matej.sochan@gmail.com>
Date: Wed, 07 Oct 2026 22:37:46 +0200
Subject: [PATCH] ALSA: hda/realtek: Fix silent speakers on Lenovo Legion S7
 15IMH05
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-legion-s7-v1-1-8ea7fb7ee766@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM0QpAMBSA4VfRubYaaYtXkYvNzuZIaAcpeXfD5
 Vd//wWMkZChyS6IeBDTMicUeQb9YOaAglwylLJUhZRaTBhSIliLulLaKOsqjR5Sv0b0dH6vtvv
 Nux2x394B3PcDZQS+9m0AAAA=
X-Change-ID: 20261007-legion-s7-9467a6bd47ef
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Eric Naim <dnaim@cachyos.org>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Matej Sochan <matej.sochan@gmail.com>
X-Mailer: b4 0.15.2

The speakers on the Legion S7 15IMH05 (PCI SSID 17aa:3811, ALC287) stay
silent after a cold boot with the current quirk, which applies
ALC287_FIXUP_LEGION_15IMHG05_SPEAKERS. They only start working after a
suspend/resume cycle.

The amplifier setup is sent through COEF 0x24/0x26 on NID 0x20. On this
machine the first pass of that sequence appears to only wake the
amplifiers. Sending the identical sequence a second time makes both
speakers work, provided the second write comes a few milliseconds after
the first: back-to-back writes leave the speakers silent, a 7 ms gap
makes only the right speaker work, and 8 ms or more is reliable. A dump
of all COEF registers of NID 0x20 taken before and after the second
write shows no difference.

Add a dedicated fixup that writes the sequence, waits 20 ms to keep a
margin over the measured minimum, and writes it again on every codec
init. It chains to the same AUTOMUTE fixup as before. To share the
sequence, move the verbs of ALC287_FIXUP_LEGION_15IMHG05_SPEAKERS into a
named array; this has no functional change for the other users of that
fixup.

Fixes: 67f4c61a73e9 ("ALSA: hda/realtek: Add quirk for Legion S7 15IMH")
Cc: stable@vger.kernel.org
Link: https://github.com/CachyOS/linux-cachyos/issues/792
Signed-off-by: Matej Sochan <matej.sochan@gmail.com>
---
Tested on a Lenovo Legion S7 15IMH05 (82BC) with v7.2.8 (linux-hardened):
speakers work after repeated cold boots with the 20 ms delay.
The same change applies on top of the sound tree; I have only built and
booted the 7.2.8 module.
---
 sound/hda/codecs/realtek/alc269.c | 92 ++++++++++++++++++++++++---------------
 1 file changed, 56 insertions(+), 36 deletions(-)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 447c0ba358d8..a68b6a9b71aa 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -4377,6 +4377,7 @@ enum {
 	ALC236_FIXUP_HP_LIMIT_INT_MIC_BOOST,
 	ALC287_FIXUP_LEGION_15IMHG05_SPEAKERS,
 	ALC287_FIXUP_LEGION_15IMHG05_AUTOMUTE,
+	ALC287_FIXUP_LEGION_S7_15IMH05_AMP,
 	ALC287_FIXUP_YOGA7_14ITL_SPEAKERS,
 	ALC298_FIXUP_LENOVO_C940_DUET7,
 	ALC287_FIXUP_LENOVO_YOGA_BOOK_9I,
@@ -4529,6 +4530,53 @@ static void alc700_fixup_intel_hades_canyon(struct hda_codec *codec,
 		alc_update_coef_idx(codec, 0x1b, 0x0400, 0x0400);
 }
 
+static const struct hda_verb legion_amp_verbs[] = {
+	/* left speaker */
+	{ 0x20, AC_VERB_SET_COEF_INDEX, 0x24 },
+	{ 0x20, AC_VERB_SET_PROC_COEF, 0x41 },
+	{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
+	{ 0x20, AC_VERB_SET_PROC_COEF, 0xc },
+	{ 0x20, AC_VERB_SET_PROC_COEF, 0x0 },
+	{ 0x20, AC_VERB_SET_PROC_COEF, 0x1a },
+	{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
+	{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
+	{ 0x20, AC_VERB_SET_PROC_COEF, 0x2 },
+	{ 0x20, AC_VERB_SET_PROC_COEF, 0x0 },
+	{ 0x20, AC_VERB_SET_PROC_COEF, 0x0 },
+	{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
+
+	/* right speaker */
+	{ 0x20, AC_VERB_SET_COEF_INDEX, 0x24 },
+	{ 0x20, AC_VERB_SET_PROC_COEF, 0x42 },
+	{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
+	{ 0x20, AC_VERB_SET_PROC_COEF, 0xc },
+	{ 0x20, AC_VERB_SET_PROC_COEF, 0x0 },
+	{ 0x20, AC_VERB_SET_PROC_COEF, 0x2a },
+	{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
+	{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
+	{ 0x20, AC_VERB_SET_PROC_COEF, 0x2 },
+	{ 0x20, AC_VERB_SET_PROC_COEF, 0x0 },
+	{ 0x20, AC_VERB_SET_PROC_COEF, 0x0 },
+	{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
+	{}
+};
+
+static void alc287_fixup_legion_s7_amp(struct hda_codec *codec,
+				       const struct hda_fixup *fix, int action)
+{
+	if (action != HDA_FIXUP_ACT_INIT)
+		return;
+
+	snd_hda_sequence_write(codec, legion_amp_verbs);
+	/*
+	 * The amplifiers accept the setup only a few ms after the first
+	 * write (8 ms is the measured minimum on the test machine), so
+	 * keep a margin.
+	 */
+	msleep(20);
+	snd_hda_sequence_write(codec, legion_amp_verbs);
+}
+
 static const struct hda_fixup alc269_fixups[] = {
 	[ALC298_FIXUP_RAZER_BLADE16_2025_PINS] = {
 		.type = HDA_FIXUP_PINS,
@@ -6593,41 +6641,13 @@ static const struct hda_fixup alc269_fixups[] = {
 	},
 	[ALC287_FIXUP_LEGION_15IMHG05_SPEAKERS] = {
 		.type = HDA_FIXUP_VERBS,
-		//.v.verbs = legion_15imhg05_coefs,
-		.v.verbs = (const struct hda_verb[]) {
-			 // set left speaker Legion 7i.
-			 { 0x20, AC_VERB_SET_COEF_INDEX, 0x24 },
-			 { 0x20, AC_VERB_SET_PROC_COEF, 0x41 },
-
-			 { 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
-			 { 0x20, AC_VERB_SET_PROC_COEF, 0xc },
-			 { 0x20, AC_VERB_SET_PROC_COEF, 0x0 },
-			 { 0x20, AC_VERB_SET_PROC_COEF, 0x1a },
-			 { 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
-
-			 { 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
-			 { 0x20, AC_VERB_SET_PROC_COEF, 0x2 },
-			 { 0x20, AC_VERB_SET_PROC_COEF, 0x0 },
-			 { 0x20, AC_VERB_SET_PROC_COEF, 0x0 },
-			 { 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
-
-			 // set right speaker Legion 7i.
-			 { 0x20, AC_VERB_SET_COEF_INDEX, 0x24 },
-			 { 0x20, AC_VERB_SET_PROC_COEF, 0x42 },
-
-			 { 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
-			 { 0x20, AC_VERB_SET_PROC_COEF, 0xc },
-			 { 0x20, AC_VERB_SET_PROC_COEF, 0x0 },
-			 { 0x20, AC_VERB_SET_PROC_COEF, 0x2a },
-			 { 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
-
-			 { 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
-			 { 0x20, AC_VERB_SET_PROC_COEF, 0x2 },
-			 { 0x20, AC_VERB_SET_PROC_COEF, 0x0 },
-			 { 0x20, AC_VERB_SET_PROC_COEF, 0x0 },
-			 { 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
-			 {}
-		},
+		.v.verbs = legion_amp_verbs,
+		.chained = true,
+		.chain_id = ALC287_FIXUP_LEGION_15IMHG05_AUTOMUTE,
+	},
+	[ALC287_FIXUP_LEGION_S7_15IMH05_AMP] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc287_fixup_legion_s7_amp,
 		.chained = true,
 		.chain_id = ALC287_FIXUP_LEGION_15IMHG05_AUTOMUTE,
 	},
@@ -8348,7 +8368,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	HDA_CODEC_QUIRK(0x17aa, 0x38d5, "Lenovo Yoga Pro 9 16IMH9", ALC287_FIXUP_TAS2781_I2C),
 	HDA_CODEC_QUIRK(0x17aa, 0x38d6, "Lenovo Yoga Pro 9 16IMH9", ALC287_FIXUP_TAS2781_I2C),
 	HDA_CODEC_QUIRK(0x17aa, 0x3855, "Legion 7 16ITHG6", ALC287_FIXUP_LEGION_16ITHG6),
-	SND_PCI_QUIRK(0x17aa, 0x3811, "Legion S7 15IMH05", ALC287_FIXUP_LEGION_15IMHG05_SPEAKERS),
+	SND_PCI_QUIRK(0x17aa, 0x3811, "Legion S7 15IMH05", ALC287_FIXUP_LEGION_S7_15IMH05_AMP),
 	SND_PCI_QUIRK(0x17aa, 0x3813, "Legion 7i 15IMHG05", ALC287_FIXUP_LEGION_15IMHG05_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3818, "Lenovo C940 / Yoga Duet 7", ALC298_FIXUP_LENOVO_C940_DUET7),
 	SND_PCI_QUIRK(0x17aa, 0x3819, "Lenovo 13s Gen2 ITL", ALC287_FIXUP_13S_GEN2_SPEAKERS),

---
base-commit: c3e35f355fadf6be660e1fd356bb22140dda8e46
change-id: 20261007-legion-s7-9467a6bd47ef

Best regards,
--  
Matej Sochan <matej.sochan@gmail.com>


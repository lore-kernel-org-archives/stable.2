Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BD73C1973
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 12:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786366337; cv=none; b=oM5dHBtjgAOc/oUE2idMggJikzR69xldUePBaIs3vN94m/Yxj2ZSF1Cx/M1ZQF4GRmrAidViO+SlfbKZ/TOEygiUsg8HoantnI3Vn6cGT1tXhWeF6JUCUPzhGeBj52adxuwfPdm4316dGQoTV8agVI3G0sOuZl2DZ6e0IDXtk10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786366337; c=relaxed/simple;
	bh=VOyVrKBxAa2NcHrazT98ZERt4p8INB92OTGM2dSWwss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gDm/sbWSjSulrPGj/cZf2kVwMwkv7Zl0tvEaoJ9B5R0dPMpFWpQZHoi2NXfKBaI4V/MmJXwtfRLHDRJ02GrppTbLXMe05Hrr5xLr1khpWaUmBjdIbfM0keFeJWhX+2IMMUJK4BVCS9ubt16dFkletSDB5XJOe9wkC+BzrkByn1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q2jgeGZI; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q2jgeGZI"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c2020421077so285767466b.3
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 05:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786366334; x=1786971134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yrlWuKe6vIOBZ5QESYaBmuJu7So7DiYov3AMNAyIE8I=;
        b=q2jgeGZI5MTh4MA/27xnFOmDuBldv68aHBZLoCywF2hOz+Ilbq1l2kyxA7Ax8foXn5
         piuYQpJ6dNAc4TLr+I0bAUCrKlPT+VsSgkt7mwwkemURTX2POk4hITWKk+uNKRbqCfzq
         79A2TlyPzVh+K/fOo8mV2HsnPL1moPCZgC+VyNSgrEQjfVCtlLnw2I0/YuTk60MEIMR1
         t9alDl7BniklwvoAFFpTIDQCKXk1X6Z8JHXP1JCXOTxxDFjwRWmy7S6S3AhhBKujZUh+
         g3LmoNBnO7x9Ebc6blbvLLnk5OyRiMW2yvIzU1loYwLWMXoyZJAALCEZ3hFVuBaRjSoz
         Sdyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786366334; x=1786971134;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yrlWuKe6vIOBZ5QESYaBmuJu7So7DiYov3AMNAyIE8I=;
        b=oKHWWS1SJJVUz7cu9PZu1gi8lGmUDPDUBmuwthUKQ7zadjC5dKzokPYsICnKKn4CtN
         Mcq0nUQsaSxf6jkZZEPhBYUkObTaEzPmaPiBoL+0Xty8PF1NDV6DwcyVnylbMdmiP/By
         dVjPhgf2joeNeTyr9Cq2IfHCBRe6Zmk0J9BcUq7HUY5g1bt3vVgLF3Ke22Qr5KGweTYL
         R4KbxiLR9tebyD3rbIXxyrOQXS/XYfUcF178Tv9xljUucYxMgo7++fNLlYBIx18jg3NL
         M+2cbz8SY5hXrO0M5VSFWYYPnH/AzHiWgdEd+jswScWIqLsxXR5GOteiGBzFhhtiAx0k
         weKg==
X-Forwarded-Encrypted: i=1; AHgh+RqG8P/gJ8A50fCvfhnNEIdGVuuay4MLGMzi9Wbu/vXSDoVyYTuAyxjyXYQ99/xU2VeM1eEsvvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoSbAiaArZWbIzNenlOQ590gF44TfhWapLUy/dx0DGT6YHDWlf
	6CVHFhNA9JHrI+SSVuf25dhhwZdONkUcjIjH5cBZ0Fan7HwTYdZrqWTB
X-Gm-Gg: AR+sD10BOQZ4XOLzfksrNO1A9zKJsxd1Eif/xeN+cFLhNXbPWHqEcDOLoy0dSalARZM
	KXrXV5p9tRvTcsG6vSHRUyD1YhlnSK5h1Sl6FRTElCLY4GNYlV/3OoXtYoa7ZYI7WTs0fRGIDUT
	PjR+Jcohe7V2hDtkCRRMgtUW4uQJ3StLVOAMdLSbjV7dkOuXA9jLT9cLhiX3J1AqGcd77joi4Wg
	8I0spLUQ0Khr+2tKpDL9XegrB9tRMb0mBKpySMtTPJeRWVtU5yDBIxXTba24nG+/iMPinmc+vv3
	1SaLGCyGQN/eegrpcTMZuvA8Qn6ZklOMw+JNRyX7wklmDdaUMcXPpGri1NiRVbXcOEdotUig/ht
	x2GMFKwjAX1FybXYqnLW+GeBswPkLaFXZr7c4ZWEKIqbtyVtcwMa2dOHcn3Uu9ocHM9VlPYXgkg
	BzyxRvmeDFzVjBqmovFze3RtjePVhbrE9RfsASRcA0duW+F+gGhEg7Q9UsWaF/IfO9QscbArMRc
	pSp/H+olL3IxGZ3tJpWpM7dR/hIuB0/G0I=
X-Received: by 2002:a17:907:ea8c:b0:c1c:257e:4888 with SMTP id a640c23a62f3a-c20c6a00dd5mr70166366b.27.1786366333844;
        Mon, 10 Aug 2026 05:52:13 -0700 (PDT)
Received: from localhost (polaris.rmrf.org. [70.34.242.93])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a1fed756c0sm2535399a12.31.2026.08.10.05.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 05:52:13 -0700 (PDT)
From: Denis Batishchev <ii343hbka@gmail.com>
To: tiwai@suse.com
Cc: perex@perex.cz,
	ii343hbka@gmail.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] ALSA: hda/realtek: Enable micmute LED on HP EliteBook 6 G1a p/n: AD3Q9ET#UUG
Date: Mon, 10 Aug 2026 14:52:09 +0200
Message-ID: <20260810125209.2014042-1-ii343hbka@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The HP EliteBook 6 G1a (SSID 103c:8e0d) uses a Realtek ALC236 codec.
Without a quirk no fixup is selected and the mic-mute LED stays off.
It needs the same ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF quirk as the
already-supported 14" variant (SSID 103c:8dfb), so add it.

Signed-off-by: Denis Batishchev <ii343hbka@gmail.com>
Cc: <stable@vger.kernel.org>
---
v2: fix indentation (per Takashi Iwai <tiwai@suse.de>)
---
 sound/hda/codecs/realtek/alc269.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 6b36c730c..ef8beb928 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -7542,6 +7542,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8df1, "HP EliteBook 630 G12", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8df7, "HP Z66 G6", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8dfb, "HP EliteBook 6 G1a 14", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
+        SND_PCI_QUIRK(0x103c, 0x8e0d, "HP EliteBook 6 G1a 14 (AD3Q9ET#UUG)", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8dfc, "HP EliteBook 645 G12", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8dfd, "HP EliteBook 6 G1a 16", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8dfe, "HP EliteBook 665 G12", ALC236_FIXUP_HP_GPIO_LED),
-- 
2.53.0


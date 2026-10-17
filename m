Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8511AF4E9
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 00:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792198125; cv=none; b=PN4SkDRSriFP7eIKy1uEto8x34l1qLBL6tggEYnBCMcEAZdO8CNsreRLc7Em3ifkjprKR19TTO8cGnymjuMovf5mF8+3LLLvrTpbxK4lKcGiKw74g/oVi41H86sK1Ycpsrvo9AImPl3NVAC/v9cznxGjhhkdzqwlEFPApG8SKNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792198125; c=relaxed/simple;
	bh=5V8rinvEffdQKrE933/i9Jyx4668IhiI+lCFsqIuIZo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L6lxSgGphpZcbv/KNqGQP1nI5XfDCQ2RYKg9hkH9FPm3BC4J7St0cAnZdXEIqBUJ/dWnR/ms2tBwgNnsC8jYEIEj/9GiqWvKSTHvCZb29HqeAe/CKGDoyB78IRom5LEInSihT61kFhzuAdbCIQ2UgP9N1jCobuuUFLZYZeeJQ+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KTciQFId; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTciQFId"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-82380b0f55dso156423a34.1
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 17:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792198123; x=1792802923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=t+hJXj8wwiIb+5no1EG7QW0zHdqHn0SmMCU0JKT/7aQ=;
        b=KTciQFId0emTCbGG1h2y2A32KpZaW1YgzuufShBg7eeh6R25uPNCylYmLVKFvxw40t
         NM53u/SE+zTFnwAI4Zzl7loAX1jrrgFbViCYa9xhu0U4pRsLddh0erwJtdjZXzGZm4qf
         LCH5wCbT2hI7oCurhzULUxG6eAglzkqULm40jVUswc0zfxkd2PFkiN0Lm5s39WDIg666
         dLsCD3PxieHqh8+KUkfxxF32HT7KO1UigoonJHYtkGEHsdaOsxPw67I9DLNlRxYc5MPh
         DbHPSTYMjBsL0VAKbDwrTEO05JKtouUCwXpX8aTBTmsT+RGuEl92Rpy8+Z6TwZA/DiIE
         l2bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792198123; x=1792802923;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t+hJXj8wwiIb+5no1EG7QW0zHdqHn0SmMCU0JKT/7aQ=;
        b=NVBf1IeLPAXM/gNjWf5uJjgJmlV53jlIshL/CCNMyihHu2adRHLhACNJQDxcJqwECD
         0j/zr7weg1UTn+9ZceDO9K+kJ3FQD30Cr+B1QN1Ego/zb19GnOOEZ19am5n1N7Vej6ss
         YZC+cANtJny06PDbKjpfZgDoH8OHiVsx51cC862m1fLDZf3w9gugUQGxBt0HGuoKfRVP
         RyiisCJF1Bl96iek5xPYDLnkGMZTk1LVvIIaoY8921QPpEQgOmhh6c/wjop3enXgjAQU
         zaS/eaRak6S7DpB9dBkH4henHxZs1cMEv3G7f5R52e+J0MweNbUlNXUq5noRqcBNdufR
         CXwQ==
X-Gm-Message-State: AFq9FYLto00V8GK+N+ndjriJj+p1WfyoLy7LEg1HHNxg06TLgx0zOByc
	ZqyJ+VoqDdgopC3LxQZ2nzDbe04AfLG/JNOaH4xYN07K0WguX/SfhyWJ
X-Gm-Gg: AYBFou2MsACxgaX+sOUgJQieMxJG1lDGL210fqhfjHuSJRhyWSYVpRHhAMPByd+hq4T
	BZ9aXV0TmSxRuTeBxK3AHRDLBeVMO2qAMa0tSb5iTsW8isKPhNl4T9GE//+WwCCw/xI+pxASSfb
	mmnyWHqxC9uolKz2n5eYnxLD8DaAPtgmhoAUEIIFFBqLC+SCS/Hs21Ou707lY1909RVSlvXkGWh
	I+v3NtVTagAwRnz4lxTSWmPfJyxgdBKj1SU2Pzopf9FdPpw6TKR2XUQ9q2cyCO48CmHmZlkBKAV
	3EiMnQHL1NgNg1FK2YNu9pl4RvgP+NYPY25TnamIi8j5qYnyf0yI5W5WXmddX97nAyWrP22uM5W
	8XHUh/R+NEtNGrpY1PN6PaBGRpHkCNSG+4s/jlL/0r6NJCF862R3qX+6xBbEMfwan0DKUkxsYEm
	sUc91bI3+0dv4M6UgfpcIO8uXsu6SUmGWUwmpb0q6VfLEZ8PttLrFvWtZH5zyJODQ=
X-Received: by 2002:a05:6830:6a8b:b0:816:b03e:f9dc with SMTP id 46e09a7af769-844fe3a42e0mr1445474a34.5.1792198123190;
        Fri, 16 Oct 2026 17:48:43 -0700 (PDT)
Received: from fedora ([2806:266:482:9274:1367:9be1:68ed:86d5])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-842a53d88c3sm3059400a34.10.2026.10.16.17.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 17:48:42 -0700 (PDT)
From: Luis Gerardo Lopez Hernandez <gamaerry@gmail.com>
To: gamaerry@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek: Fix internal speakers on Acer Aspire AL16-31P
Date: Fri, 16 Oct 2026 18:48:38 -0600
Message-ID: <20261017004838.8774-1-gamaerry@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Acer Aspire AL16-31P (Intel Alder Lake-N, Realtek ALC269VC,
PCI/codec SSID 2782:1718) has its internal speakers wired to pin 0x1b,
but the BIOS marks that pin as not connected (0x411111f0) and only
exposes pin 0x14 as the speaker. As a result the internal speakers are
silent while headphones, HDMI and Bluetooth work.

This is the same layout as the Infinix Y4 Max and MEDION E15433, which
share the 0x2782 subsystem vendor. Reuse their fixup, which configures
pin 0x1b as an internal speaker and limits the internal mic boost.

Tested by booting with snd-hda-intel model=2782:1705: the fixup is
picked, pin 0x1b is used as a speaker output, the internal speakers
work, and they are muted when headphones are plugged in.

Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Luis Gerardo Lopez Hernandez <gamaerry@gmail.com>
---
 sound/hda/codecs/realtek/alc269.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 36d3bc23a..2a0d25493 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -8671,6 +8671,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x2782, 0x1701, "Infinix Y4 Max", ALC269VC_FIXUP_INFINIX_Y4_MAX),
 	SND_PCI_QUIRK(0x2782, 0x1705, "MEDION E15433", ALC269VC_FIXUP_INFINIX_Y4_MAX),
 	SND_PCI_QUIRK(0x2782, 0x1707, "Vaio VJFE-ADL", ALC298_FIXUP_SPK_VOLUME),
+	SND_PCI_QUIRK(0x2782, 0x1718, "Acer Aspire AL16-31P", ALC269VC_FIXUP_INFINIX_Y4_MAX),
 	SND_PCI_QUIRK(0x2782, 0x4900, "MEDION E15443", ALC233_FIXUP_MEDION_MTL_SPK),
 	SND_PCI_QUIRK(0x2782, 0xa128, "Positivo N15RPE-S", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x2782, 0xa212, "Lunnen Ground 14", ALC269VC_FIXUP_LUNNEN_GROUND_14),
-- 
2.56.0


Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E3240860D
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 15:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786374907; cv=none; b=uMZLdiKXy+RJ9EpLYXj0MQ/rKH1YiVFYEZTjQ8Ppmc8uNomDwpUa+pCQL5ITIL+qvv7SH+Ipe508iPUwH+q7qcjwt4i1yFZ2LXVGV8BpFPC6GHAnfk94cQTETTizFlOcRxC8x2pQw9mWiavJTR1VTGlpp6Ae9Fj269XPfFPOgB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786374907; c=relaxed/simple;
	bh=dYwpDRDFH4n8uZjOFwtMCROsjSYUm1YwtTQJtnYVbBY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JVE0xvnv4CN+3kyzJYK9m9a/LMrBVg5cX8w+n5aNtUY2BnIDLEGcAuracdoQZ5Gqsh4KVXZvEKnwf07N0Q9bEHJ8wbqeDPMKcadG88P/tU2bqtJY7f/wU3hwPLoCQ8UC4jOjNRh67B0s67g3IdeQpyZSJYRnLT1wON42kb/99Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lDdcWzhz; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDdcWzhz"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6a157f90752so2668354a12.3
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 08:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786374903; x=1786979703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fPBANNW5+RwZZdfYhz17gZuHdbRy4Yr63PkNIMIILa4=;
        b=lDdcWzhzIuF3hW22hr3pVTUjuq2TvyzU88H92Ydf/PMmChqXHg0QzRlPxJfgo0ipSh
         qQCn3KRb4lMSDveQ4Ls8aFR9TTzeazPs+aCPAnM7JY18mWF7l6kyxFSjEKf9I9uzpOb4
         8HeNbUp1sAFm4/d1syQYAwJPtue9J787IaX/Jq+gCy8hFLszxR07Z1Nxto5lkGkoL4t2
         Ymqj5tFD6ReSm4wruux7U1DsmpqIYC+5MXvVrt7m/GK9TglBUOThJNXIQr3nic7NWN0o
         XRpiD3e3VfsGnrH0KgHwiU+umihpU07VlCa6Gq12HlyuS/QJAHzJQ9IPafMnuZqLDE9G
         ZLEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786374903; x=1786979703;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fPBANNW5+RwZZdfYhz17gZuHdbRy4Yr63PkNIMIILa4=;
        b=ko/mhQ09NT5VOwoQJY7UYBcECkIfcXSHdCtEjRMaTNd+zZR9Iq3HSDflh8XBy85Fsf
         xaDcJnOePKUInW0PxXwtB70zMAlhDDJVXfjb9X+Z4hWE11vKxi/fVVS4BfbuBtvAvIqb
         6UTuRsrg7YZ0lPMvRPfUEr5mvCM8wl55CgSWT2UshVv47S5VBeUxiVtsFpbGiIiuk1/4
         96450lbFIjZNhuLFqsDA+pKn02eJxNbQFmDJfdoalrm3wDs0UGMjOn7UcX6042Pnkf6x
         Y3NInhtpxytBZroknAWUy4OCaCEKe70S7dI6sX/CAYFXgezvC8JpGWVgxRtuzmxqYlkb
         KNVw==
X-Forwarded-Encrypted: i=1; AHgh+RrwbauP/l0vl264A2+MCfyvuj9To8Zd8H2jEqGzyHoeYT6raMNS1q9KirnF/qtkjuApEvEd+x8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz/puCDfnt/askkUrCNe4kZiwwTh5Rlulf5bJJs/wqfCLfKzhT
	J3azzerfYNNxvgJE8JG7zAGVYFKWEnSJqbewNQ/C2HxZVO8Zdp15rQpG
X-Gm-Gg: AR+sD117Hhogk85LGz2GMuCeTVWK9V5xfKvR9ntCsTtMW7KoldCc+TsbaDN9Iqx0BZW
	iVExWY3MBMicwPMEfEFnGXdhjbuE4VCib/DaUhOScffCUbFYy+bS0X2Ke1Ak1jD1XGTdEc6/oAZ
	PWSQR9sMM0QARdfZnr9hmYy7t57ur5ODtDXTfsU2aJ8+O7DfZk/GWu0Nzd1q8URdvslsWehujQr
	tEg5d96+iv9NYoV+11SIJhLi9uE1g5XTUftGQiNMe4P+j7EUsVKLCH2x/FqX0WD14nmn441ZLGm
	+DUGhC4uhrVLzemvDowB0etSNqBK5dv0vDDS8gjaTjeClZr3UmwQmFuOYpGayNTHjSZXNeVPTeE
	+GTHfe9skgIeYv7lchgifk0v/PZFIAo1EgbWoAoaR8RuFPRrRNolzR/xKZKKHm7oCpl8r8fXq6B
	jv0XlnfUOGrzCSrBTQKoi+4+nTJCTPc+lhkyx1ru5Az7SDeoBpUMbF92qtCBzdP7SYS3QYUlxGB
	1/KjU+HyBelUDy+Zu2Ay8ni2HCV6lnNm8M=
X-Received: by 2002:a17:907:7b86:b0:c20:1c9d:8d4b with SMTP id a640c23a62f3a-c20871a8ccfmr1162646566b.2.1786374902694;
        Mon, 10 Aug 2026 08:15:02 -0700 (PDT)
Received: from localhost (polaris.rmrf.org. [70.34.242.93])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2080cf75c2sm398078466b.59.2026.08.10.08.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 08:15:02 -0700 (PDT)
From: Denis Batishchev <ii343hbka@gmail.com>
To: tiwai@suse.com
Cc: perex@perex.cz,
	ii343hbka@gmail.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3] ALSA: hda/realtek: Enable micmute LED on HP EliteBook 6 G1a p/n: AD3Q9ET#UUG
Date: Mon, 10 Aug 2026 17:14:41 +0200
Message-ID: <20260810151440.2306217-2-ii343hbka@gmail.com>
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
v3: fix indentation, 2nd trial (per Takashi Iwai <tiwai@suse.de>)
---
 sound/hda/codecs/realtek/alc269.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 6b36c730c..bcbdafb42 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -7544,6 +7544,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8dfb, "HP EliteBook 6 G1a 14", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8dfc, "HP EliteBook 645 G12", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8dfd, "HP EliteBook 6 G1a 16", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
+	SND_PCI_QUIRK(0x103c, 0x8e0d, "HP EliteBook 6 G1a 14 (AD3Q9ET#UUG)", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8dfe, "HP EliteBook 665 G12", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8e11, "HP Trekker", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8e12, "HP Trekker", ALC287_FIXUP_CS35L41_I2C_2),
-- 
2.53.0


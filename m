Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B0640B6CB
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 13:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780578926; cv=none; b=aAj/xGXW02vpTuKoi6TIAVyrygCP7LLoAKVnPpSTc1Odq+tLavUV2YxJCyiCe3mIr6rRNTN6380ifHMgW8+GbZntzifHCmSGG/c/IdkwkKHK0B0/oRmD/FYgRX7/0opAqqvwCYdghx75gk5L3ocB3iAHvAuz1F+VWyumlYhPUoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780578926; c=relaxed/simple;
	bh=PX1Js/3zvWR4Ese5jDE6K2t9+uZlMH4V7izjEaFNoQM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CQSsxpNO8oZ//Y8OCH/SXqkp3MXRq0+tFAVmXv8EmeduCcxwZr0yL9gYVqtMjQ4JG1i9xjEGS/g5na8yXz6gTg7beNuphLAmWsNDOiWcCosS1PZoPIdkj/KmANG/ETmXFRo2V9cbu2QbrvMx3HjLe0VOYVfrq4tHa5HysA3d6Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nymtjo4O; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nymtjo4O"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-45ee5cdbd28so1232458f8f.1
        for <stable@vger.kernel.org>; Thu, 04 Jun 2026 06:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780578922; x=1781183722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Uby14OwIdVW4k8F2NJV9+wRf4v9W+0pNeX7ztbx9q+8=;
        b=nymtjo4OjUhjED038XrvSVcky8m6W7qowI+mA+zaqVqMROeIHGWIEfZFY7VTeDOmsh
         K6HP0tXuQqmC7lfrR9n67jSCkosj9A8WzW+hWXX0xQBleE0fsi+FN9qVIa3JuE+mvncS
         VyvdsG3r0CpB+QbtYugS43l3c1Scp/BxivL41yI/+eBuMn4AjdNd3RHEGyj6we3nOJp3
         6Kp9hWmfenjP0G4BmZslIpkeUqtQSuKZDeCMBUi3Gp4LijnbtvYHnPsWLmpPpmLc6Ksr
         ogpq4KWp9tsfgYaDKwJiLoOVCGpGjBIgwMP63Soi5SZDJ770jzekVHCVuOZC0MX6s9Ui
         BnBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780578922; x=1781183722;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uby14OwIdVW4k8F2NJV9+wRf4v9W+0pNeX7ztbx9q+8=;
        b=fD3+aHgl1wtOwld8q8Lws7kWSSzm3FmJRNX0eVc8lMDGPPATn2a3MZBLz1uEKHtqke
         6nYBNojw4b5GOuboR9LFA+R3R7rWJ7G8MX0U2WWxS5OLM9gzNt3l7HBcbkIq8A1/ZI1S
         /66ooBg+L05jET1kSy1A5Qr6Ib8+tfx7k0U+4KzE9dq0RIgCaNwSLzE+KJmk+8/5GcQR
         l+zgwGtXiwnKrgBEtmQebcx2k+JYHvN5N8qP6h/vzO3GN5o0OUVV+H4VXfsnwkAH3nER
         aCRv1N5vpzYCoVz99+Xzsl2PU0Q+kXWSyxMJePzxgrsoQY+5nX6J4+XXQVQWNaGb9Yje
         5Rug==
X-Forwarded-Encrypted: i=1; AFNElJ+taOOpQuvZYD8hjWWZ0TruXpn3yXC4gVB0RsmVTA8Nt2Jni/Zyk0aTcsQgweg8csadpCZjbwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjXc6L26WaAI4cCv+TANgqGcG7WmJ/9uoXYGgrp6qwUaPMM9/O
	GEpEXy5FSAjO8vGD4h8QgMYYL8eiT3f7dV3h6EIoh4I6UxT5pMQiX0p2
X-Gm-Gg: Acq92OHWU7CGSP7vQYc0prO8wCi346CWaUO75QdNbd/v8l86aF5syK+TmTPJzUeXQ+B
	5NZ5ukjiSVjyymZDNFV9AIX6zFL6iye3+kYr9OlV4oJnYeUdTTdZwAWxBrAdnptxnc7T0jH3Hdd
	on/PeSdiCqFt/OpwM33zLBy/kD0p3BS13pZW35nk1Fgflw9E47cPbruoI/zcNmDT9dDBSWnKwwi
	7rnkTsHg0KsjrJctborDZ87ig30PBnHovCHHKzxOY8xOgN2KLzMQmyB5OoWbFkZ4OZQddPHESNC
	h7ql/fpNnpJHbnc3e8kyeBSThXU3gPkquHDeeikiim9twOf2IoRiZ7RmCEZO7By2/ERwWYdB9de
	n9nB0AH4b/AwhUM0kmcdaiXohuunBCORAf+MRHPrtvacICfvIJq2aWjeT7qbzk+wJGCE7YucxXA
	vi//hMoe+9LMb6DCSHYDwSPSeMMA6RazHLXZSugbJlPvyYs3G0nI14DmbH13CF/nv3mFzrGprYW
	6PjtzyNb/WrAfcu3E77IjPpQIA7ghWQoQ==
X-Received: by 2002:a05:6000:2082:b0:460:1c93:6eb6 with SMTP id ffacd0b85a97d-4602743465dmr5773003f8f.20.1780578922055;
        Thu, 04 Jun 2026 06:15:22 -0700 (PDT)
Received: from macbook (178-222-30-44.dynamic.isp.telekom.rs. [178.222.30.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dc412sm16849569f8f.4.2026.06.04.06.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 06:15:21 -0700 (PDT)
From: Denis Batishchev <ii343hbka@gmail.com>
To: perex@perex.cz
Cc: tiwai@suse.com,
	ii343hbka@gmail.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek: Enable micmute LED on HP EliteBook 6 G1a
Date: Thu,  4 Jun 2026 15:15:18 +0200
Message-ID: <20260604131518.45993-1-ii343hbka@gmail.com>
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

Note: I don't know how to fix sound-mute LED though.

Signed-off-by: Denis Batishchev <ii343hbka@gmail.com>
Cc: <stable@vger.kernel.org>
---
 sound/hda/codecs/realtek/alc269.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 78a865709..8eebf9159 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -7274,6 +7274,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8df1, "HP EliteBook 630 G12", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8df7, "HP Z66 G6", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8dfb, "HP EliteBook 6 G1a 14", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
+	SND_PCI_QUIRK(0x103c, 0x8e0d, "HP EliteBook 6 G1a 14", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8dfc, "HP EliteBook 645 G12", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8dfd, "HP EliteBook 6 G1a 16", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8dfe, "HP EliteBook 665 G12", ALC236_FIXUP_HP_GPIO_LED),
-- 
2.53.0


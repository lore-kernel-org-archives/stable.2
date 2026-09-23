Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EDF370D54
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 14:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790172940; cv=none; b=NBvlvDWEO5uOBVPC0xxtpZjh4Q44Ee6HvgcielR4YBbp3Q5on8VbHvjRvmSR92q3/84/LKKZTfLJ9WSDMAVdWqCBUZCbGi43ZiWyyjGCc5PZ2ILKig1Duu3GCqtLEDaK8jyU5dyPJfTDP800spZsE32M4Z2j3thPtYaJddC1zBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790172940; c=relaxed/simple;
	bh=Q2MaBMkLXe7IHCBb+bOGm9M3KkOZC8IP6HD0YDMfm1A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cvpxoQp+P9zWfElfUXyTzKw7jNb2oSSowSfxuewcBZRvnrGp8C3BYrhjVzB1jeg45GhGMUtz9bce8RP91lM/tUbLSsECOoHoe7BNLdjOFHLXSOGT6cU1uYqa3msfH8q0wMPz6j0/3Hx/0UeMIPQp3zYSZdsQVNw7X2oH8bKhcEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LbGWViCa; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbGWViCa"
Received: by mail-pj2-f42.google.com with SMTP id d9443c01a7336-2ddaa08c890so5010515ad.0
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 07:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790172938; x=1790777738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iU/15OPk5yvrTv0LgeRqLrS6cUkjBijLp/PMVZ1MHgo=;
        b=LbGWViCal1nhaBhEyk3k/q4YvZ9fMzwFXA8WhGlhN1LQHo3/9RB9tPkn07JwjtxUgK
         WIpHlWSmyMjmQfe/AAFFejCchF7HewuAMc2S5Fu53QnLUkByBK8OIh2/PVXQmveOPmX5
         1yRMQDF5wAbvkmWcC4sOtf7BfX76MnmcVjxYG/QvG4LlE7SOXkicA0KDoJfEtEOTg16y
         m/PHDgssAkutIkmVvLQ4cV5+Pb6l3AZNocaS4w0Kyu/F2jHFOI214+iHojkhg3LUkMdT
         FffF6Dsisv9ZVYjj+sE3oRX0OgbtBBTJBFV4q5O618Q9/52hL4nBMzYkmxGbp+n45sCW
         nKAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790172938; x=1790777738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iU/15OPk5yvrTv0LgeRqLrS6cUkjBijLp/PMVZ1MHgo=;
        b=spLcnzgiO1h/k/QPJjwvac1hmT1jAyV3PE4aMAiuXN6cIzcXkyRa/nJ90v3+VzJbWz
         eLU+wRVVSFkooN/KO7/94p7Vqz8P28yUcLBJQVIeV85CrHJB/DF9xz0Tyzfs9XGsjGYe
         0sTMRTaniYqeWc0UgAOIglElgKIj4b7DEXZBYXj7CHixJqxzKtdltOWBrs/MYu3Sk24t
         OdB7HYxVrMfi0uYMGp/Xh5iR+EaLMw31OzTOVU+7k1y4s2AEH8ED8DCnPQlV2ELkNWGN
         wUA5auy8UxYW8sYV6c7imPLyHSW+wpq9+CHGpW76bcMbw2MPBr4/v9NcuRILbVYs2iw1
         0R5A==
X-Forwarded-Encrypted: i=1; AKwUvBwpo65ns88wuwxxDyeK1xcmqxfUz2POdDLFlyWEDWW7utVDmOeQQeI07fHzdVliaONo+MVlfR4=@vger.kernel.org
X-Gm-Message-State: AFuF++nk04VdRDrctDKw37ldrT8eangKwJgw34D8+rIQl3XZYU1+0mTJ
	hBy87GAPPR9ZkQf5zo5D6oufbFCD4nRt8VgOB1Q//Pu5XTgCUOv+OVEl
X-Gm-Gg: AYBFou0XCotyilw902irtXGJ9L3BsMNCYFLWnW1lUbiGwGPjxV2LQ2K/UytETlxaxg4
	2yQWFMi98OMBCYxSWsVXVj/E7KfcBI+aY93oY0yyimfDCO84/LkM5gBXRqNLhFe5idGLyrciPta
	I82VkxoMMhWY7VLeeZ4D4g7C3Bc6ELsNCObRAcj1K24kwVZ9pgRY+bqEGrz2rR2ioFVApc4Uet1
	1K7xoGdveQVYgCMyV6jrPfvqW9oX+9ZN1kE1z+fejhlBKnSjy2gZilKJo7WIy/J8IZQbod1HTPT
	ZJJ4iigiEM2HiLp/9xmnYdnRlQnnFm0WAxYUy/+foNpC/XtRmDRUm0qhpWWbG7oz/7BnitQoCg4
	c72Lv6otZQ4D3p2VUOG5orpRXQzoA2ym9s7If/Bkio2vgpJlRgcTNe1sdSdo3FwbMwsNsNesA1E
	HnTJ+kKj5SxVJtbvC/p4NFgnMDaw3TnFaXGk7Cf09RuqL6nEC8IhNlwQzz0g4vI8pRXOS7k5opq
	Xv4oEEAibXqmXgTn0dFW0rmguyudFW99p2/AO21GA==
X-Received: by 2002:a17:903:1103:b0:2dd:c100:7cbb with SMTP id d9443c01a7336-2df69de9d56mr24712725ad.55.1790172933687;
        Wed, 23 Sep 2026 07:15:33 -0700 (PDT)
Received: from lenovo.localdomain (211-23-53-87.hinet-ip.hinet.net. [211.23.53.87])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a517069sm11911435ad.3.2026.09.23.07.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 07:15:32 -0700 (PDT)
From: Yu-Hsiang Tseng <asas1asas200@gmail.com>
To: linux-sound@vger.kernel.org
Cc: tiwai@suse.com,
	perex@perex.cz,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek: Fix silent speaker on Higole F9B
Date: Wed, 23 Sep 2026 22:13:44 +0800
Message-ID: <20260923141344.1543158-1-asas1asas200@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Higole F9B is an Alder Lake-N mini PC with a 7" touchscreen and an
ALC269VC codec (subsystem ID 0x10ec111e). Its DMI strings are all
"Default string", so the SSID is the only way to identify it.

The internal speaker is silent out of the box. The generic parser
assigns DAC 0x03 to the speaker pin 0x14 and DAC 0x02 to the headphone
pin 0x15, but the speaker only reproduces what DAC 0x02 plays, whatever
its connection selection says. Checked one path at a time, only the
gain of DAC 0x02 and the mute of pin 0x14 change what comes out of the
speaker. User space only knows the path it was told the speaker uses,
so selecting the speaker turns the path that actually reaches it all
the way down.

Route both 0x14 and 0x15 through mixer 0x0c (DAC 0x02), which is what
ALC290_FIXUP_MONO_SPEAKERS already does. Tested on the device: the
speaker plays.

Cc: <stable@vger.kernel.org>
Assisted-by: LLM
Signed-off-by: Yu-Hsiang Tseng <asas1asas200@gmail.com>
---
The quirk line and this changelog were drafted with an LLM (Claude Code);
the path-by-path analysis and the test were done by hand on the device.

 sound/hda/codecs/realtek/alc269.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 5127a111c..72d681fe7 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -7939,6 +7939,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x10cf, 0x1757, "Lifebook E752", ALC269_FIXUP_LIFEBOOK_HP_PIN),
 	SND_PCI_QUIRK(0x10cf, 0x1845, "Lifebook U904", ALC269_FIXUP_LIFEBOOK_EXTMIC),
 	SND_PCI_QUIRK(0x10ec, 0x10f2, "Intel Reference board", ALC700_FIXUP_INTEL_REFERENCE),
+	SND_PCI_QUIRK(0x10ec, 0x111e, "Higole F9B", ALC290_FIXUP_MONO_SPEAKERS),
 	SND_PCI_QUIRK(0x10ec, 0x118c, "Medion EE4254 MD62100", ALC256_FIXUP_MEDION_HEADSET_NO_PRESENCE),
 	SND_PCI_QUIRK(0x10ec, 0x119e, "Positivo SU C1400", ALC269_FIXUP_ASPIRE_HEADSET_MIC),
 	SND_PCI_QUIRK(0x10ec, 0x11bc, "VAIO VJFE-IL", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
-- 
2.55.0


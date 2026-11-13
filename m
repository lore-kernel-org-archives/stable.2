Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794589102;
	b=WSPgTFgBfDi/MfQ3jUAOxwTz41SrbekbAcznyLE9vUyAX97+Gise2sRbjeLD95ZpGjOW
	 RhR6pUsBioA83s+PakJGDtmldcxo4znTAlFojHUKP8dmhQPZLQZYeuN+h4WzZjzWKkVA0
	 INXCjOs3PBlrfsoQu+FrO0jbY3ur0Xh5iojgYk5l0ZdWZAnRYhWQA1Ok8YjcPcZ3qHFnq
	 C7lWeK0HRFArYuhUESCnqUrniHCundtanHD08Vwqt7KNaA3dOVIDc8UlJQy0Vz1DBxiAb
	 XKyYEZqfBy4R0G5evXOMWxTV/b/W+HtzWrn45sQs4tgq+7qa7kLfJKXUSDjZx+tD15g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794589102;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hRElxMJsDJf5VHSjIG/8pW23E9Fv3Uy5iWG2ez36aFo=;
	b=oZF3GOhQ3h3rPlCS2j6R+tMQwwhRESW95s7XLv12DiSImmLKgT08IKpaZ834x6Xdg9ii
	 pPJ6+v24+013HV90ARlnKFmPyNTKFUCdtTVeRz2DyyYZBxsr2ME1nIz5JnS+NCtmiYYnU
	 KJJDrOYrcTUUtuXarTzRcx2GtUJdSegUsRlNfhkn1AyQuvAqvJOmGDwnYWF19PKD1ZyiU
	 wydmwCpOM7E+0fQ92cnksE4R7wSXxNX78rEW2Rt186ERYp7zGC2U3HUWs7lSrZHri0gOz
	 ctmrU3wu1xfjGtI51EbJE0gZabz9cnNd+iQ3DLClogeqnvA+brd4v5CH6o/SV2bKgDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lY9v8wGD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E0E606A32D
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 16:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lY9v8wGD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEFF81F000C4;
	Fri, 13 Nov 2026 16:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794589102;
	bh=hRElxMJsDJf5VHSjIG/8pW23E9Fv3Uy5iWG2ez36aFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lY9v8wGD0volemdMgh7n/T+g/HOxoI/XiIKaD2RSzl/WyD1/xSG18nNy7Ur57UuyU
	 6OSqytDbe4oI+cULEpr2yfVE9BrfLktJAD7mx37J3RkoyTu54I6hAih/WMegfwtprW
	 IavFKLMpnqXq5pfPS7Qkd0p2IFYY16H+uopYTjs5sVu32Xnam/LXRtuS3sbxRXUJCT
	 1hR7jOG5jwPD7slIOc7MXPkOyhuAKGV7coxgZ4DWP3AxyqwI4eYxBeP08HAMUu5tn0
	 p3dhNpP0Awi2Ed4972L9idiXu3A0dJSLWTvOskm+Rc5rHPAq76yPuS9xx2Cs67MfKN
	 1C53nvvs7b6qQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Luis Gerardo Lopez Hernandez <gamaerry@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ALSA: hda/realtek: Fix internal speakers on Acer Aspire AL16-31P
Date: Fri, 13 Nov 2026 11:58:20 -0500
Message-ID: <20261113165807.2140478-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060747-failed-5.15-d933955c456e@kernel.org>
References: <20261107060747-failed-5.15-d933955c456e@kernel.org>
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

From: Luis Gerardo Lopez Hernandez <gamaerry@gmail.com>

[ Upstream commit d933955c456e0573b40eae4f72a3af37ab1c15c3 ]

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
Link: https://patch.msgid.link/20261017005039.9139-1-gamaerry@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
[ sashal: adjusted insertion context to match the existing snd_pci_quirk table ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index dc2fb0a319c1a..66ca1f6988d71 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9722,6 +9722,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x2782, 0x1701, "Infinix Y4 Max", ALC269VC_FIXUP_INFINIX_Y4_MAX),
 	SND_PCI_QUIRK(0x2782, 0x1705, "MEDION E15433", ALC269VC_FIXUP_INFINIX_Y4_MAX),
 	SND_PCI_QUIRK(0x2782, 0x1707, "Vaio VJFE-ADL", ALC298_FIXUP_SPK_VOLUME),
+	SND_PCI_QUIRK(0x2782, 0x1718, "Acer Aspire AL16-31P", ALC269VC_FIXUP_INFINIX_Y4_MAX),
 	SND_PCI_QUIRK(0x8086, 0x2074, "Intel NUC 8", ALC233_FIXUP_INTEL_NUC8_DMIC),
 	SND_PCI_QUIRK(0x8086, 0x2080, "Intel NUC 8 Rugged", ALC256_FIXUP_INTEL_NUC8_RUGGED),
 	SND_PCI_QUIRK(0x8086, 0x2081, "Intel NUC 10", ALC256_FIXUP_INTEL_NUC10),
-- 
2.53.0


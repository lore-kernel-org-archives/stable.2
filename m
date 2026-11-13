Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794589413;
	b=wTMydmzTm3xvUPhc/HBKNf2aig9s9LCE69Olws7wOXsouNN96xYRyLtcIhNFMvUK8ei0
	 78HpfegMHfcYxomfO0E6lWILrytUnOjRbLQ/6B13eZvE73JF7dpZWllogDapicc+wDn8l
	 DHw1UeiKOuPHJG+/OgGDTcM0g5xoi/HfioLjmdgp2LXVOZz9usejex+7XbgJK51CVNhAE
	 W/HOcXymvZuDQuOiJyqjVv5v37geMyqn3XJKQE/KQhjPh2aBQ4r3Dsss8fYn9BlEAoZpR
	 bGdEbrBYT5VUEhwgKlH9M7akJJf3w+23z8G2qRwBiHcfIFAnlOVab6KAr4Gxl4sQ3Wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794589413;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vAHPmypGlw6UdkIkHbwMQkVBwxlH8DyS2l/CbGrP9A0=;
	b=iMav5LxYenS79bX89S0j3nPqrakqqebqajNfj8yL5M5oGmds2BbyPWqMZVb5DDo8d7xA
	 0LbdrQfPVnHKn4FVzz1BRF2iIsiUPMlAZxux3rc7xtCEWKOFYS0/kEI0IalemGuZqlmZW
	 PaWkPv4LlyM6UQGKw178cjsjWR1DrHlGCGXVmwtyxJWLoMgM1TsqO3s5m8nBaRLTEIjPI
	 vj6SOrCIScBlnbg3ZpCv6NQMQhlhSp4fb5BtCLDd4miFRGeV8meP/3uwA5I5VsWwVlqw5
	 s3PgQt5/y4/E19qrxYn+NS8e5Gsf0S6zyHFaOOKR1PKYWpWz892IE+CS7v0ESi5KSWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E1zz9yat;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88C7606A89E
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 17:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E1zz9yat
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11B921F000C5;
	Fri, 13 Nov 2026 17:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794589413;
	bh=vAHPmypGlw6UdkIkHbwMQkVBwxlH8DyS2l/CbGrP9A0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E1zz9yatg8iTRzNs2H/GTQ8GRE2j40a9aV6Z/tILGLxmY58anTJHG6iGLDW5XpM6/
	 eZBnq3twB+4cBByl79GPi1iJKhqpgxdwbJTVcwmkgm1FkKucIplGG3/wecyaqpF5l5
	 vcaCFeGKrmmDOZ9egqYlMcwOYCziP2GsdHFgf0gb8BOZNlKD4pv+ATUQAQVTk/SdiH
	 O9zS2CN9bkwfLgxRCOweTQkY/MsZ2XxYKX0rUwZ6ouTUcNR9uDk+JIQf/MEW3a25oe
	 TLNm5t9y6iB8sdw+swPCG/UY6g3VjvHt7gxEMPcZg0pmSDiGlZV+iv3bRAEhCFDhti
	 ziiGpKrmRFjvQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Luis Gerardo Lopez Hernandez <gamaerry@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] ALSA: hda/realtek: Fix internal speakers on Acer Aspire AL16-31P
Date: Fri, 13 Nov 2026 12:03:31 -0500
Message-ID: <20261113170312.2145419-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062442-failed-5.10-d933955c456e@kernel.org>
References: <20261107062442-failed-5.10-d933955c456e@kernel.org>
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
[ sashal: adjusted context to the existing snd_pci_quirk table ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 4edd1e022797d..132142770f056 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9635,6 +9635,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x2782, 0x1701, "Infinix Y4 Max", ALC269VC_FIXUP_INFINIX_Y4_MAX),
 	SND_PCI_QUIRK(0x2782, 0x1705, "MEDION E15433", ALC269VC_FIXUP_INFINIX_Y4_MAX),
 	SND_PCI_QUIRK(0x2782, 0x1707, "Vaio VJFE-ADL", ALC298_FIXUP_SPK_VOLUME),
+	SND_PCI_QUIRK(0x2782, 0x1718, "Acer Aspire AL16-31P", ALC269VC_FIXUP_INFINIX_Y4_MAX),
 	SND_PCI_QUIRK(0x8086, 0x2074, "Intel NUC 8", ALC233_FIXUP_INTEL_NUC8_DMIC),
 	SND_PCI_QUIRK(0x8086, 0x2080, "Intel NUC 8 Rugged", ALC256_FIXUP_INTEL_NUC8_RUGGED),
 	SND_PCI_QUIRK(0x8086, 0x2081, "Intel NUC 10", ALC256_FIXUP_INTEL_NUC10),
-- 
2.53.0


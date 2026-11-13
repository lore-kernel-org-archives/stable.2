Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794588955;
	b=YnC+2OhZgX1WCGTY1wTrrUEf4kr8MEbhBDFqIZSW8wRV99Cn//AIK0Ah80JnRjJg2KiG
	 IZ6EFBqFPU8aW6mlw0BJaG1g1qqw27UKmE25c8wZtz29fJSwrhpJTIlg5TR4PTpMKvZft
	 0828y6bb7eVNsISfXBAnT1WINujkanA6vVmlp2f8fcQcnilrRJitpzIzR02WCjxzBRifx
	 RSqxMqbiiVDHVounyDSewm+b7+UqcVTeRqlpRQaxyta5CFXCYhwlMg/ypBqZ1BOHA7V6Z
	 Wk8bkdKWNnsQiuvQg/voyvXz1Hs8zvQbjPfgyoay8wAmnaxxK19YISxZZZlLEnBTFJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794588955;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=YrBTk5dOOIh0Vbm3Skn+RdsWWnY1owm1b0dsboqI77w=;
	b=xWVj1pj5wK8R+bpfBQCVHXKU9fh1WrsoK8+JxUhVWNaD/DYqLB0naJLpw9L8ulJi4p+7
	 8ntLzUHJYrpEd22nyPvjTPOZAk4j8j2oRqgIG4J8r9+KhUnJylXV61s6G0RhM/MV79AZD
	 V3hY8/UCeRknZD9u4YT55TLMmXWGamzpf/j3DIKzgAM2Xd+3T+ARG5xdxeN4y3QYiaraz
	 ZuomxAOAAwZnWQSL7rxD0byw44pk86muJitxlE9CgMHfKXmwsV0hdfM4uzcqS3ctVEbg5
	 NH6Y4+R1Hi7b+Ud7XX0Fsxq/7uFm6g88WkA9W59MpyjGxI+GFYU5o8f7XMqDVjYh89w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AhR5GiC9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCF4606A338
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 16:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AhR5GiC9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 484AC1F000C4;
	Fri, 13 Nov 2026 16:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794588955;
	bh=YrBTk5dOOIh0Vbm3Skn+RdsWWnY1owm1b0dsboqI77w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AhR5GiC9rmQP2OpedIqGFjZRJKMKl5E4XET4qCLgf8RNfPh2rlNjiw3HO9g74WQy7
	 djxut1Nl4dPZfJcnWIXDkDQMbQ8AQMsBHpy+AtDjoIP0vS3i0XsnQJBxPZhI5EeHV5
	 lKTTQe4cwoMxnZkZ3bdnvHdIfsGoIp0gA0Qxfz4Vbu3pzWpvWO3lMO6eEwVKTB74sN
	 yZPoM2x5Ua947WyEiu6lG1i5f4sytJ7LCTFbm+tb5DnkCLGqdu6LiKSlIlyPCK3OFS
	 /XNJTtFL/43Ys24D02OUHZ8pUEP+0ApYJVaXKJMz+/L+M0LLd37bdnQO9awesDPls8
	 9WU6JVyRJoV3A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Luis Gerardo Lopez Hernandez <gamaerry@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ALSA: hda/realtek: Fix internal speakers on Acer Aspire AL16-31P
Date: Fri, 13 Nov 2026 11:55:53 -0500
Message-ID: <20261113165535.2137272-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055037-failed-6.1-d933955c456e@kernel.org>
References: <20261107055037-failed-6.1-d933955c456e@kernel.org>
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
[ sashal: Adjusted context for the snd_pci_quirk table in the consolidated Realtek driver. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index f83afdc59e4e9..d49a2c74d5af3 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10528,6 +10528,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x2782, 0x1701, "Infinix Y4 Max", ALC269VC_FIXUP_INFINIX_Y4_MAX),
 	SND_PCI_QUIRK(0x2782, 0x1705, "MEDION E15433", ALC269VC_FIXUP_INFINIX_Y4_MAX),
 	SND_PCI_QUIRK(0x2782, 0x1707, "Vaio VJFE-ADL", ALC298_FIXUP_SPK_VOLUME),
+	SND_PCI_QUIRK(0x2782, 0x1718, "Acer Aspire AL16-31P", ALC269VC_FIXUP_INFINIX_Y4_MAX),
 	SND_PCI_QUIRK(0x8086, 0x2074, "Intel NUC 8", ALC233_FIXUP_INTEL_NUC8_DMIC),
 	SND_PCI_QUIRK(0x8086, 0x2080, "Intel NUC 8 Rugged", ALC256_FIXUP_INTEL_NUC8_RUGGED),
 	SND_PCI_QUIRK(0x8086, 0x2081, "Intel NUC 10", ALC256_FIXUP_INTEL_NUC10),
-- 
2.53.0


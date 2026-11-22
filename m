Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795384992;
	b=qGdYiksQDMJr2w/NiGAKrXROZT/wS4FYNNf4X31mA7VMGEUf6CBtGS4rX/k/I9FtoaPm
	 uwgfYUt/Er7p1WT2dSFjQi6jbxZnYms/nIuKQ8P3/iAlEomGXP8hKt1r0MKu+i+4r87B0
	 7ECU0Nf99Y9LpaOnygKJC1i354kFx0JimTFLIaEiXLXeLzEV7SwUY+YDRnVkGysN8ESgC
	 Dbm0S3iY5ftEkQDlEAMdUKiPSuQ1HZj3mO6XG1Nm155QUVhJW+PxF/4u9dQxSatAeRFm0
	 UrEtLs4dARhWhoS8GXZ10+Ym7U5vWSWikt25IUifLhuwGhWje7Vx0Rbh/8GXexl3U3Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795384992;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=TYuw29kk9vznSRQWW7d8By5fgiZ7ZqjEohaa5d/tT5E=;
	b=tCEBgJ3HIjpQ8yzPpo99naDYIf/niSVdMIzUJLRt3st1Zn4DaPeZBwAtdmU31aCydU/+
	 fhM6OBqzBT6MtxBTxded2BeToQ6iISI6LKMZc2Hkk+8zCCCIFF0pIBeGcFksbUuy1KzNo
	 ODngyjl6x5HBfzalCXEvUJ9i8nR/TiUldM9yNQA4k1dyIojkS4yAzl8yPCzyI9FzyQcpX
	 YiW6Ik8p27C4F1dSFYfDji5Gsa/gnQCig6R/LCqJSQe74VXiZOfIhWrjdmFR8vaFLCzvI
	 2UGW7jxku2yrfPNfVb5XZgStP0SYQEORzLoEM5bTPVB0ONG3GicnF+/ulZ83g0ScaLw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OWvrWGqU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66390606A69B;
	Sun, 22 Nov 2026 22:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OWvrWGqU
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795384991;
	b=vi7k1wMSLI3k0s547RRW3N7vG6vHdyzNVxZnjCrxzDgecOrRBTOclN+IqJJ8XHFthTui
	 6itxbBJuurM5N3dn5ImAdPDGhoJ3oIAEeHG7WZrNZc83y7wIAqu2yruUFgTHLEPF5N+s/
	 nvhKwOmUOmTN8F05kno5LTKX4xOddDmKxwXJmpFQ7oPPkbfFubX9yxHUpJLjsRpLH4McG
	 VxkPUuVEUvrxKx+9Wd8bgWcTuVjMMtMnMqI84BARryF7H8Cfh7ijIQ/o3uOu6+oYrTGgt
	 5ZJbZaVNOUvrN7w0uNjhxOMrqyLwSCnxw2wsIffmo1i1C/AB7Wu36UqsXEQRKEern4g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795384991;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=TYuw29kk9vznSRQWW7d8By5fgiZ7ZqjEohaa5d/tT5E=;
	b=lwtJjq8bTkNb1/6TRnW5qT6hCGwiprNz9NbdooNmI8glXC3X4ygIJxdwoR4ASECIwp3z
	 ZhxeLSJyDj3AHeX67E0W1rDM/VXtafLIFm/zQ96DhtMXZbPIVSWAUVYseBZr9C85BwZnm
	 WlC73WlcW0+n+0aTk/mD5dMzLZ5OtGM0mUO+tjT9F7Cg6VOfsG3+9XQ++66uMBrbSJAMp
	 kcE7ZdPMP9ip3wpuLAHYLgjIDE4LRNjOUkVdd3vgsa9XR9hiEAO4aTbqsHPJ6ZyX/qLSa
	 tcJwI92KOAvvIc3UORsa0k/vWIWRG3xlRJRtjEREo40xvoSg7yvr2lLXHaKhyE/HvdA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 5978A1F000EB;
	Sun, 22 Nov 2026 22:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795384991;
	bh=TYuw29kk9vznSRQWW7d8By5fgiZ7ZqjEohaa5d/tT5E=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=OWvrWGqUqvuqTlmfxCGkP3fcRdvo9d+wIg6D6TqvcKkQ83lMGBmgUX0MtQQfrFf0F
	 Fa9JyfRVl8ozPL2xc1qKeYf89oWmRvKZDnVMonRmfwoFTp45BJLUXBrcpZcEscAkjI
	 VIXmPJMSBF5vSq+vGEP38ogtCuU3SvpTl5+t82kTFrfG0aR5/+q7C20HYOcxOISwra
	 km0wo3ElHZj8+QA0047m/TlX652jhqZz9Q14fWQ8rC1PeoxEgtRgo4lbH1Yw4viNQr
	 hYVwS+2YF1gI5rvujCZmTU1TEnKQTMrkHfIILIE2Z9S8EX6Lrm91fmvnNxAJuI/g5n
	 ijC2rnpi9ul6Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id AA2264C20C;
	Sun, 22 Nov 2026 22:03:06 +0000 (UTC)
From: Abhiraj Dutta via B4 Relay <devnull+abhirajdutta7.gmail.com@kernel.org>
Date: Sun, 22 Nov 2026 17:02:47 -0500
Subject: [PATCH] ALSA: hda/realtek: Add quirk for HP Spectre x360 2-in-1
 Laptop 16-f2xxx
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261122-hp-spectre-16-f2-quirk-v1-1-2011ef8986fb@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/x3MWwqDQAwF0K2E+21gJoqlsxXxw0fUULDTTFsK4
 t4LngWcA0XdtCDRAdevFXvuSBQrwrQN+6psMxJBgrQxivCWuWSd3q4cW16EXx/zB9cS7vUwhlG
 bGypCdl3sd8Vdf55/a7O4mmgAAAA=
X-Change-ID: 20261122-hp-spectre-16-f2-quirk-32093ab0be47
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Abhiraj Dutta <abhirajdutta7@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795384986; l=2863;
 i=abhirajdutta7@gmail.com; s=20261122; h=from:subject:message-id;
 bh=TXikiVOH5pXwin/sZNAkTdAEDOogwSuDt60eoDtzQoQ=;
 b=Y/iIqrnriFOBEFhC8p5oXoBVoBkZdkL8qjhZMBoFtLIqLBvyv+nXgaUnwf8827IvXQzQ0olnZ
 P+GxCMHAkPjCS2iVLQg4vNwk4/W+0BRyKSI+AwY8aLfuwXpPpMr3/so
X-Developer-Key: i=abhirajdutta7@gmail.com; a=ed25519;
 pk=3ETcWPbWUjdsP3Pv+/VwZOZKPt9O4SvxqiXNMNNY4gc=
X-Endpoint-Received: by B4 Relay for abhirajdutta7@gmail.com/20261122 with
 auth_id=1610
X-Original-From: Abhiraj Dutta <abhirajdutta7@gmail.com>
Reply-To: abhirajdutta7@gmail.com
Content-Transfer-Encoding: 7bit

From: Abhiraj Dutta <abhirajdutta7@gmail.com>

The HP Spectre x360 16-f2xxx (SSID 103c:891e) has the same speaker
problem as the 14-eu0xxx and 16-aa0xxx: the BIOS marks the treble
speaker pin 0x14 as unconnected, so only the bass speakers on 0x17
play. The mute and mic-mute LEDs don't work either.

Use the existing EU0XXX pin fixup and chain ALC245_FIXUP_HP_X360_MUTE_LEDS.
The mute LED is on COEF 0x0b bits 2-3 and the mic-mute LED on GPIO2
(active low), which is what that fixup already handles. Unlike the
16-aa0xxx, the bass speaker amp works without toggling GPIO0, so the
EU0XXX variant is enough.

Under SOF the PCI SSID on this machine reads as 103c:0000, so the entry
is matched against the codec SSID.

Tested on a 16-f2xxx: all four speakers play and both LEDs follow the
mute state.

Cc: stable@vger.kernel.org
Signed-off-by: Abhiraj Dutta <abhirajdutta7@gmail.com>
---
 sound/hda/codecs/realtek/alc269.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index d38be4d50..edfd5ebe8 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -4524,6 +4524,7 @@ enum {
 	ALC256_FIXUP_HEADPHONE_AMP_VOL,
 	ALC245_FIXUP_HP_SPECTRE_X360_EU0XXX,
 	ALC245_FIXUP_HP_SPECTRE_X360_16_AA0XXX,
+	ALC245_FIXUP_HP_SPECTRE_X360_16_F2XXX,
 	ALC245_FIXUP_HP_ZBOOK_FIREFLY_G12A,
 	ALC285_FIXUP_ASUS_GA403U,
 	ALC285_FIXUP_ASUS_GA403U_HEADSET_MIC,
@@ -7226,6 +7227,12 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc245_fixup_hp_spectre_x360_16_aa0xxx,
 	},
+	[ALC245_FIXUP_HP_SPECTRE_X360_16_F2XXX] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc245_fixup_hp_spectre_x360_eu0xxx,
+		.chained = true,
+		.chain_id = ALC245_FIXUP_HP_X360_MUTE_LEDS
+	},
 	[ALC245_FIXUP_HP_ZBOOK_FIREFLY_G12A] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc245_fixup_hp_zbook_firefly_g12a,
@@ -7869,6 +7876,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8902, "HP OMEN 16", ALC285_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x890e, "HP 255 G8 Notebook PC", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x8919, "HP Pavilion Aero Laptop 13-be0xxx", ALC287_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x891e, "HP Spectre x360 2-in-1 Laptop 16-f2xxx", ALC245_FIXUP_HP_SPECTRE_X360_16_F2XXX),
 	SND_PCI_QUIRK(0x103c, 0x896d, "HP ZBook Firefly 16 G9", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x896e, "HP EliteBook x360 830 G9", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8971, "HP EliteBook 830 G9", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),

---
base-commit: d1458f8c2282975f2bd7467cd3c3cf4c0c58c1ca
change-id: 20261122-hp-spectre-16-f2-quirk-32093ab0be47

Best regards,
-- 
Abhiraj Dutta <abhirajdutta7@gmail.com>



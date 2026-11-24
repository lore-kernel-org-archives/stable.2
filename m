Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795486746;
	b=lmGhre6b6dN39tjhtlruWbTYTWw9zkZnCMjvBNxAJw8u2gfJba8bOpO5cQSz1hlpD4u2
	 TsNyCupWCTysunOVsz+Nsb3RKct80DVzsyO9NWY0idyKsiSDnE9J8LDpfCUr470ur+env
	 WTc/6/RKYapUNhhLekRbDkcuQVKEdmoSMtEsnhS7m5cjT7NVwOdOI7nsjZPdbYh8ZpPpM
	 XqGVr+B8JDLjYnDDzPn8sY+74Ty41eDgiWfiCIOE7e452cXuAvQoazET8dJ/ShlhGBlE5
	 YvC9qSmoJ0rdTJY9wB9HIiehIWgPWIRbSoqyDNu9zAGmJfFLM4vg9zWW3v/vGxDV2cg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795486746;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=p373wFfzA+j6Ni2LpTmcRnqyjI5yYrAPkxO3l73XycI=;
	b=gC5QBIkM9Rhlqa4HI0c8SlsCQ23njNSgdTny6QUhT2TeTk8Ri+jgbK0/hf9TGdYKVsqE
	 NPtKsJYAEHB84ispjnMEhFYB5twsKQygcKNu6Z5kMvC2yutGHoug2j3X1dQ9d1GYFtr6u
	 uAlaLNyJJiR25gTjZr9sk8rjIZVpck4cguEy22pf9KrEVBtTiUK38ESfz/haezqcbGYJZ
	 PLWXtoMGOTaPpNfdxknDblGcpFMTyAvyNPBHNi0EoDbTLV6Ty7ZNO+x7exihCw0NJGvEn
	 rrwVvF5Zh1Muyu/ZT4S8c0ywNMCq21ZBbm1ghmjlEvZ5PwwssooE8UWuajjPtDOLZIQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BVJa3vyX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD66606A31E;
	Tue, 24 Nov 2026 02:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BVJa3vyX
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795486745;
	b=bwq642YGBAu7fO7B6vQLveEZ+qCvgZXjnYDe4UHIPg4EgbOngmC1S3zGib3inn8EIgM1
	 zJxjw5dZoEcT9gKj8hCvUERJGusMa4LsYXKV2B9gj1iKL9CyiE531EkXOLH089B3brJYE
	 CxARFQig8Doje7geMaw2TNxcIl8hl8Dz+i+U5ROsm8y+WrkRt0D+kwh4Md0uApxkSHOzL
	 80wkPvtofJmzNOiqsKIbfSsGq1hcp8ASnJWGpevljiN6sIT6/kdsyjKLECXkbm/rnOQmK
	 nHCKdYdlBSBw6WSSduR7ewtZWESqmZGd/csn1/mHq7y6lFO99NyKzcu1sKQsxV46FJQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795486745;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=p373wFfzA+j6Ni2LpTmcRnqyjI5yYrAPkxO3l73XycI=;
	b=qY/HomEa19YVaQoCqZHeTsCKwpTzl8S4OS4XmH0DD6A/0dlJ/NyxlX9lMgQ1aHU3WiaJ
	 1R28kl4wLsqxqskRKsH5uBHvPOcuj6gG/1U44QXH5X+4jHVF5ApkOCUOpVdngJkQ2H6jU
	 2R67X0/YI7rAciAnffrCvycEKRCZ1kO9P+DixyHyicn6c7Hsjl/PIodHPix34cbAO1H/W
	 uC0gae08tswvZsvEEPu6tjoNTgqXEpBm+KL9sezn13ELoDhaiWJB8Wwo9+44MwVYlLPig
	 YikYQTkSAN2LHFKtGptmapyjWzO5RGCatH1N4taERgxI/C/Qw5WfloCOceC+sWZRRHQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id CABF31F000C4;
	Tue, 24 Nov 2026 02:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795486745;
	bh=p373wFfzA+j6Ni2LpTmcRnqyjI5yYrAPkxO3l73XycI=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=BVJa3vyXswhFAxMFuBUgP1F832waWYO713yAUY4Vio0Q0J+co3GyKnIOIGwx0T5rw
	 BCkfX3H08F0DKbSU53g6VrkzSAKOHO/FVSis2dimF3VKfZ9hf9omEXASWbqKV9Fqrv
	 pz2uEyuOi8fiJTqaIOo7afRnaiWCngFDAB9Sd75jbQzU4OSFGxdxqXNr+URtZANjRQ
	 +7zqyGUMVg97Y7JTN04NCXoQ3mnKD3OMk6gusgL5AqIZDAHElr2Cgp8FdCX9TU1Tdj
	 6Cx53S3qPI+/NtzUZqc17MJaETJ8r6fbIGWkD23U8FxJxCLp7Lb3kCyUQe3l65S+Sh
	 ZzRwHQ1o0J+Jg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 23CA34C83D;
	Tue, 24 Nov 2026 02:18:55 +0000 (UTC)
From: Abhiraj Dutta via B4 Relay <devnull+abhirajdutta7.gmail.com@kernel.org>
Date: Mon, 23 Nov 2026 21:17:57 -0500
Subject: [PATCH] ALSA: hda/realtek: Fix duplicate LEDs on HP Spectre x360
 16-f2xxx
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
Message-Id: <20261123-hp-spectre-16-f2-led-fix-v1-1-a2a333dceeb5@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/x3MQQqEMAwF0KuEvzZgqnTRqwyz0DbVgGhph0EQ7
 y74DvAuNK2mDYEuVP1bs2NHIOkIcZ32RdkSAsH1zou4gdfCrWj8VWXxnB1vmjjbydOoMswp+jQ
 LOkKpmu1868/3vh9jGemaagAAAA==
X-Change-ID: 20261123-hp-spectre-16-f2-led-fix-a4e13bdc6db1
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Takashi Iwai <tiwai@suse.de>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Abhiraj Dutta <abhirajdutta7@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795486735; l=2648;
 i=abhirajdutta7@gmail.com; s=20261122; h=from:subject:message-id;
 bh=2fGkl4MnRAFoBN/vsCmVD26p7qRSOwU1KzcdavldMmo=;
 b=1kMFy9uWM5jo+LSPu7W7mproAH6ITaAgaCkQSMjHlRjCut1TZfqS/EwqzfP6rCT9h0mnMH33E
 pC7f44DbUH+CV0kLKjDvBwBp2dihoZSs/kA5niqvab8+rugJT80i1f6
X-Developer-Key: i=abhirajdutta7@gmail.com; a=ed25519;
 pk=3ETcWPbWUjdsP3Pv+/VwZOZKPt9O4SvxqiXNMNNY4gc=
X-Endpoint-Received: by B4 Relay for abhirajdutta7@gmail.com/20261122 with
 auth_id=1610
X-Original-From: Abhiraj Dutta <abhirajdutta7@gmail.com>
Reply-To: abhirajdutta7@gmail.com
Content-Transfer-Encoding: 7bit

From: Abhiraj Dutta <abhirajdutta7@gmail.com>

The EU0XXX fixup already sets up the mute and mic-mute LEDs, so chaining
ALC245_FIXUP_HP_X360_MUTE_LEDS after it registers both LEDs twice
(hda::mute_1 and hda::micmute_1 appear). Use the EU0XXX fixup directly.

The original commit message also got the SSID wrong: under SOF the PCI
SSID is 103c:891e, not 103c:0000.

Fixes: e30ec632e1f0 ("ALSA: hda/realtek: Add quirk for HP Spectre x360 2-in-1 Laptop 16-f2xxx")
Cc: stable@vger.kernel.org
Signed-off-by: Abhiraj Dutta <abhirajdutta7@gmail.com>
---
 sound/hda/codecs/realtek/alc269.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index dfdcf8b98..406524178 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -4524,7 +4524,6 @@ enum {
 	ALC256_FIXUP_HEADPHONE_AMP_VOL,
 	ALC245_FIXUP_HP_SPECTRE_X360_EU0XXX,
 	ALC245_FIXUP_HP_SPECTRE_X360_16_AA0XXX,
-	ALC245_FIXUP_HP_SPECTRE_X360_16_F2XXX,
 	ALC245_FIXUP_HP_ZBOOK_FIREFLY_G12A,
 	ALC285_FIXUP_ASUS_GA403U,
 	ALC285_FIXUP_ASUS_GA403U_HEADSET_MIC,
@@ -7227,12 +7226,6 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc245_fixup_hp_spectre_x360_16_aa0xxx,
 	},
-	[ALC245_FIXUP_HP_SPECTRE_X360_16_F2XXX] = {
-		.type = HDA_FIXUP_FUNC,
-		.v.func = alc245_fixup_hp_spectre_x360_eu0xxx,
-		.chained = true,
-		.chain_id = ALC245_FIXUP_HP_X360_MUTE_LEDS
-	},
 	[ALC245_FIXUP_HP_ZBOOK_FIREFLY_G12A] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc245_fixup_hp_zbook_firefly_g12a,
@@ -7876,7 +7869,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8902, "HP OMEN 16", ALC285_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x890e, "HP 255 G8 Notebook PC", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x8919, "HP Pavilion Aero Laptop 13-be0xxx", ALC287_FIXUP_HP_GPIO_LED),
-	SND_PCI_QUIRK(0x103c, 0x891e, "HP Spectre x360 2-in-1 Laptop 16-f2xxx", ALC245_FIXUP_HP_SPECTRE_X360_16_F2XXX),
+	SND_PCI_QUIRK(0x103c, 0x891e, "HP Spectre x360 2-in-1 Laptop 16-f2xxx", ALC245_FIXUP_HP_SPECTRE_X360_EU0XXX),
 	SND_PCI_QUIRK(0x103c, 0x896d, "HP ZBook Firefly 16 G9", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x896e, "HP EliteBook x360 830 G9", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8971, "HP EliteBook 830 G9", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),

---
base-commit: 896ec6bbe7dd2f29aff1a12eb318a6828be1edd8
change-id: 20261123-hp-spectre-16-f2-led-fix-a4e13bdc6db1

Best regards,
-- 
Abhiraj Dutta <abhirajdutta7@gmail.com>



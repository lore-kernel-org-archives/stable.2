Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4396A4A0EFE;
	Thu, 15 Oct 2026 06:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792047424; cv=none; b=TzImyGfGrRWmlpmO6kDoX2oYnIwnwrDJaDV2tI3XTvAi0hbwXQVAXGK8cm7kZCkuySiRyQM8wIx58E3kQV+6HA5ogd5KEKMn/rT3qT7AcFp6NZjkOoe4O2Hfihi60OkgdcLMlOareat2ian5PWtsw/E2QTocqtCVtTiu13rg/14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792047424; c=relaxed/simple;
	bh=2NRnXUoTYhE6dctcceEuqKNJ1jVNwCq/koP+DN/ZEOQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZLt2zjqXab85CSDzPbv5ozsf0ncMmNIWvm9oiRCt8Sqp11aKwm8uUlKRntqRoFEWhKoMHc3wYP8XS+6g841Yq7rmN0Y6lilbrBLgLqKHiW+5V/iSCDeN154m36mInkyeoUGE/T+C3lacpa1wRfD6nEK0rfiGwsuAVigVgMM0woA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 95b8929ec86511f19a56ed5b684f684d-20261015
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:534f10fa-1ecd-4941-865d-d8977db57739,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:1a55f037f40013148ff75768c968bf37,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50|99,EDM:5,IP
	:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 95b8929ec86511f19a56ed5b684f684d-20261015
X-User: zhangheng@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zhangheng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1125435934; Thu, 15 Oct 2026 14:56:45 +0800
From: Zhang Heng <zhangheng@kylinos.cn>
To: tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhang Heng <zhangheng@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek: Fix quirk for HP Laptop 15-fc0xxx
Date: Thu, 15 Oct 2026 14:56:40 +0800
Message-Id: <20261015065640.377466-1-zhangheng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The HP Laptop 15-fc0xxx is based on an AMD platform where the digital
microphone is provided by the snd-soc-acp6x-mach driver, not by the
HDA codec. The ALC236_FIXUP_HP_DMIC quirk configures pin 0x12 as an
internal DMIC, which is a misconfiguration for this machine: the pin
is not wired to a codec DMIC and the setting has no effect on the
actual microphone path (which works via ACP6x).

Replace ALC236_FIXUP_HP_DMIC with
ALC236_FIXUP_HP_MUTE_LED_MICMUTE_GPIO, the standard quirk used by the
closely related HP Laptop 15-fd0xxx and other ALC236 HP machines. This
removes the misleading DMIC pin config and adds proper mute LED and
micmute LED support that was missing from the original quirk.

Fixes: 720460722310 ("ALSA: hda/realtek: add quirk for HP Laptop 15-fc0xxx")
Cc: stable@vger.kernel.org
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221233
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=222044
Signed-off-by: Zhang Heng <zhangheng@kylinos.cn>
---
 sound/hda/codecs/realtek/alc269.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 92686e71dad1..1c2d88689988 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -4480,7 +4480,6 @@ enum {
 	ALC245_FIXUP_BASS_HP_DAC,
 	ALC245_FIXUP_ACER_MICMUTE_LED,
 	ALC245_FIXUP_CS35L41_I2C_2_MUTE_LED,
-	ALC236_FIXUP_HP_DMIC,
 	ALC256_FIXUP_HONOR_MRB_XXX_M1020_AUDIO,
 	ALC256_FIXUP_HONOR_DRA_XX_SPEAKERS,
 	ALC256_FIXUP_HONOR_DRA_XX_HEADSET_MODE,
@@ -7247,13 +7246,6 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC287_FIXUP_CS35L41_I2C_2,
 	},
-	[ALC236_FIXUP_HP_DMIC] = {
-		.type = HDA_FIXUP_PINS,
-		.v.pins = (const struct hda_pintbl[]) {
-			{ 0x12, 0x90a60160 }, /* use as internal mic */
-			{ }
-		},
-	},
 	[ALC256_FIXUP_HONOR_MRB_XXX_M1020_AUDIO] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
@@ -7919,7 +7911,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8da1, "HP 16 Clipper OmniBook X", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8da7, "HP 14 Enstrom OmniBook X", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8da8, "HP 16 Piston OmniBook X", ALC245_FIXUP_HP_ENVY_X360_15_FH0XXX),
-	SND_PCI_QUIRK(0x103c, 0x8dc9, "HP Laptop 15-fc0xxx", ALC236_FIXUP_HP_DMIC),
+	SND_PCI_QUIRK(0x103c, 0x8dc9, "HP Laptop 15-fc0xxx", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_GPIO),
 	SND_PCI_QUIRK(0x103c, 0x8dd4, "HP EliteStudio 8 AIO", ALC274_FIXUP_HP_AIO_BIND_DACS),
 	SND_PCI_QUIRK(0x103c, 0x8dd7, "HP Laptop 15-fd0xxx", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_GPIO),
 	SND_PCI_QUIRK(0x103c, 0x8de8, "HP Gemtree", ALC245_FIXUP_TAS2781_SPI_2),
-- 
2.25.1


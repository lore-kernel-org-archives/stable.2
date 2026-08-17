Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A2540855;
	Mon, 17 Aug 2026 09:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786960044; cv=none; b=T5SRQlnWV2GX0O854yYhlwZXsTcODU5/Pbg3pm+p6lWLwXNtzzs5RjXu4H60ZCFY2S6q/MGiOkX799mUYi81SA96mZQ7VJCxchpmiG8ixcBmDw0u2l7bZLlyLu+MLKp6wGCpZwcjy/42KyVK3+5VvDQziDXIM0DuwdAEyMAFJE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786960044; c=relaxed/simple;
	bh=AdvbOiSXA7hqEpX426buHhTr9aHX4xm1dvXCym0E+d0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hk695GN68Efh4uaYd0J/QlFNnkAIztIwmmNrgZMwtGFFkOa00LWPALi0+2CFYq5SMm42YjMpX6rgbAwkbm3A7tRGyQnZLtbqSfcq2zGMSDN3rjVklby+7EKdfA8DIcqO2gLwe061VqABMfazOr2qPn2SUzvUU4+aPHhgfjOp9d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 9f7dc0929a2011f19a56ed5b684f684d-20260817
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:acb4430b-7850-45ca-9fa2-dc2b1e899c8b,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:7db8b62,CLOUDID:270fc703ce41d0f0d3e784edce797000,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|136|850|865|898,TC:nil,Content:0|15|50,E
	DM:5|-100,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 9f7dc0929a2011f19a56ed5b684f684d-20260817
X-User: zhangheng@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zhangheng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1567164326; Mon, 17 Aug 2026 17:47:13 +0800
From: Zhang Heng <zhangheng@kylinos.cn>
To: tiwai@suse.de
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	Zhang Heng <zhangheng@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v3] ALSA: hda/realtek: Fix Lenovo Yoga Slim 7 14AKP10 quirk ordering
Date: Mon, 17 Aug 2026 17:47:08 +0800
Message-Id: <20260817094708.222154-1-zhangheng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <871pbxmb4v.wl-tiwai@suse.de>
References: <871pbxmb4v.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Yoga Slim 7 14AKP10 has a PCI SSID of 17aa:38b4 but a codec SSID of
17aa:391a. The current quirk table contains a PCI quirk for 17aa:38b4
(for the Legion Slim 7 16IRH8) which matches first, so the codec-specific
quirk for 17aa:391a is never applied.

This results in the wrong fixup being used (CS35L41_I2C_2 instead of the
correct bass speaker fixup), leaving the internal speakers misconfigured
or silent.

Remove the 17aa:391a entry from its PCI-SSID-sorted position and add it as
an HDA_CODEC_QUIRK directly before the 17aa:38b4 entry, because it must
match on the codec subsystem ID rather than the PCI SSID and it has to win
over the colliding PCI quirk for the Legion Slim 7 16IRH8.  A comment is
added to explain the out-of-order placement, following the same style
already used for the 17aa:38bb and 17aa:38f9 codec-SSID overrides.

With this change, the correct ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN is
applied, restoring speaker output and auto-mute functionality.

The original quirk added in commit e6c888202297 ("ALSA: hda/realtek: Add
quirk for Lenovo Yoga Slim 7 14AKP10") matched on the PCI SSID 17aa:391a,
but this model actually exposes PCI SSID 17aa:38b4 (shared with the Legion
Slim 7 16IRH8), so that quirk never matched and the bass speaker remained
silent.  Fix it by matching on the codec SSID and placing the entry before
the colliding 17aa:38b4 PCI quirk.

Fixes: e6c888202297 ("ALSA: hda/realtek: Add quirk for Lenovo Yoga Slim 7 14AKP10")
Cc: stable@vger.kernel.org
Link: https://bugzilla.kernel.org/show_bug.cgi?id=221298
Signed-off-by: Zhang Heng <zhangheng@kylinos.cn>
---
Changes in v3 (per review feedback from Takashi Iwai):
  - Move the 17aa:391a HDA_CODEC_QUIRK to before the 17aa:38b4 entry so
    that it actually takes precedence over the Legion Slim 7 16IRH8 PCI
    quirk; the v1 placement (after 17aa:38b4) could never be reached.
  - Add a comment explaining the unexpected, out-of-sort positioning.
  - Add Fixes: e6c888202297 (the original non-matching quirk) and
    Cc: stable@vger.kernel.org so the real fix is backported to v7.0.x.

 sound/hda/codecs/realtek/alc269.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 3f0e276fc606..9ee7af1cfe25 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -8069,6 +8069,10 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x38a8, "Y780P AMD VECO dual", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x38a9, "Thinkbook 16P", ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_THINKPAD),
 	SND_PCI_QUIRK(0x17aa, 0x38ab, "Thinkbook 16P", ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_THINKPAD),
+	/* Lenovo Yoga Slim 7 14AKP10 shares PCI SSID 17aa:38b4 with Legion Slim 7
+	 * 16IRH8; use codec SSID to distinguish them
+	 */
+	HDA_CODEC_QUIRK(0x17aa, 0x391a, "Lenovo Yoga Slim 7 14AKP10", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x38b4, "Legion Slim 7 16IRH8", ALC287_FIXUP_CS35L41_I2C_2),
 	HDA_CODEC_QUIRK(0x17aa, 0x391c, "Lenovo Yoga 7 2-in-1 14AKP10", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
 	HDA_CODEC_QUIRK(0x17aa, 0x391d, "Lenovo Yoga 7 2-in-1 16AKP10", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
@@ -8116,7 +8120,6 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x3911, "Lenovo Yoga Pro 7 14IAH10", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x3912, "Lenovo Xiaoxin 14 GT", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x3913, "Lenovo 145", ALC236_FIXUP_LENOVO_INV_DMIC),
-	SND_PCI_QUIRK(0x17aa, 0x391a, "Lenovo Yoga Slim 7 14AKP10", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x391f, "Yoga S990-16 pro Quad YC Quad", ALC287_FIXUP_TXNW2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x3920, "Yoga S990-16 pro Quad VECO Quad", ALC287_FIXUP_TXNW2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x3929, "Thinkbook 13x Gen 5", ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_THINKPAD),
-- 
2.25.1


Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BBB4A9D5B;
	Wed, 23 Sep 2026 12:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790165839; cv=none; b=QQUcx7+ZJqpMih5kaWdhkBdP8nATuL3iF6bS6wQa4AFHDc0abKmg9MG5qkbbAX5E0IUVLZDj4Wsn/la1y6Ooo/30jOcz9XKDjXBd75qVj/Zr6LHbVsyXRorqjCwdM5rzutL9UJLHZgBNOHo9W+492je5wNc5PuelUh5e+lZt6zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790165839; c=relaxed/simple;
	bh=I850guTHv9ywbIJlgUV+AXYkJLzJ9So4+Fs6bkitukM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ElxdUnou0kfsYUdfDg3AnFiQleHqGqwk9NXA+f6D5RONwJxNQEElOLunzZlYAFNjGxldKuJtGFBiWJlRGDOk4yBlpM+aFuY1VSaRmraMNEKcmGj/2X/1ySv3c9wNIgrgMqf8ToolB36Na3mQbzz2267Z9opW4y2oTV36Ce+m0Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ac26e04ab74811f19a56ed5b684f684d-20260923
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:10f5ed81-2320-41cc-9a39-c12452002edd,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:09f6a7cfbc632e97a3e830ca77d6aa1f,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50|99,EDM:5,IP
	:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ac26e04ab74811f19a56ed5b684f684d-20260923
X-User: zhangheng@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zhangheng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 516464414; Wed, 23 Sep 2026 20:16:57 +0800
From: Zhang Heng <zhangheng@kylinos.cn>
To: perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhang Heng <zhangheng@kylinos.cn>,
	stable@vger.kernel.org,
	Baojun Xu <baojun.xu@ti.com>,
	Antheas Kapenekakis <lkml@antheas.dev>,
	Aleksei Arsenev <alesharik4@gmail.com>
Subject: [PATCH] ALSA: hda/realtek: Fix square wave output on ASUS Strix G615LR
Date: Wed, 23 Sep 2026 20:16:40 +0800
Message-Id: <20260923121640.272509-1-zhangheng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ASUS ROG Strix G16 G615LR (PCI SSID 1043:3f20) outputs a loud
full-scale square wave from internal speakers since the TAS2781
amplifier driver started loading. The quirk was using
ALC287_FIXUP_TXNW2781_I2C which chains to the ThinkPad headset
jack fixup, but this is an ASUS device that should use
ALC287_FIXUP_TXNW2781_I2C_ASUS which chains to ALC294_FIXUP_ASUS_SPK
for proper EAPD and pin configuration.

Fixes: f7cede182c96 ("ALSA: hda/realtek: Add Asus quirk for TAS amplifiers")
Cc: stable@vger.kernel.org
Cc: Baojun Xu <baojun.xu@ti.com>
Cc: Antheas Kapenekakis <lkml@antheas.dev>
Reported-by: Aleksei Arsenev <alesharik4@gmail.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=222045
Signed-off-by: Zhang Heng <zhangheng@kylinos.cn>
---
Baojun, Antheas: several other ASUS Strix Gxx5 entries (0x3ee0, 0x3ef0,
0x3f00, 0x3f10, 0x3f30) are still using ALC287_FIXUP_TXNW2781_I2C (the
non-ASUS variant that chains to the ThinkPad fixup). Could you check
whether they also need to be changed to ALC287_FIXUP_TXNW2781_I2C_ASUS?
Ideally with testing on the affected hardware if possible.
---
 sound/hda/codecs/realtek/alc269.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 39dbd876bc1a..d70e03061c91 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -7964,7 +7964,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x3ef0, "ASUS Strix G635LR_LW_LX", ALC287_FIXUP_TXNW2781_I2C),
 	SND_PCI_QUIRK(0x1043, 0x3f00, "ASUS Strix G815LH_LM_LP", ALC287_FIXUP_TXNW2781_I2C),
 	SND_PCI_QUIRK(0x1043, 0x3f10, "ASUS Strix G835LR_LW_LX", ALC287_FIXUP_TXNW2781_I2C),
-	SND_PCI_QUIRK(0x1043, 0x3f20, "ASUS Strix G615LR_LW", ALC287_FIXUP_TXNW2781_I2C),
+	SND_PCI_QUIRK(0x1043, 0x3f20, "ASUS Strix G615LR_LW", ALC287_FIXUP_TXNW2781_I2C_ASUS),
 	SND_PCI_QUIRK(0x1043, 0x3f30, "ASUS Strix G815LR_LW", ALC287_FIXUP_TXNW2781_I2C),
 	SND_PCI_QUIRK(0x1043, 0x3fd0, "ASUS B3605CVA", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x3ff0, "ASUS B5405CVA", ALC245_FIXUP_CS35L41_SPI_2),
-- 
2.25.1


Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE603B47E1;
	Wed, 30 Sep 2026 08:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790758488; cv=none; b=E7/nJPEV50rAWa5yq+VOehrtPxYhCazQVCQTOsK57XpacSYoCfZEKa63PxN+qSUGHeZiCjdEASzzg57AdL84nD47yYtX7QrVPJQftukvby4/1Cvqc1dNzQ3F4Zw45UXASHetgj4upZY8M7gPY1DLGRGUz71JjY/IKkFB9hn2LEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790758488; c=relaxed/simple;
	bh=THgMVxZZh0xaWRRxJaN+bsDgTO/jfGjqX1a7DNDUq0s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e3gvGP8Km6h+PESowtJ/Pp4NIBCV6TwBrh5GKiSB7cD/apjkxIF7YVHLzOzuvoBJ93T1XgNm1rDFfeN9h2jzPJVpXvIBWRg51QM4S73SGOiXyJl8Nswg9IJ5K3p4cMG/ZI4yNQj9pto4F0TxuCRUcwF53iFtsBsH6VoyuLdPAJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 917919d4bcac11f19a56ed5b684f684d-20260930
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:b9dc0e18-bb7e-43dc-bed4-7510b1a8573a,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:7db8b62,CLOUDID:acc1827f390bad74e3718c2a3d337230,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50|99,EDM:-3,I
	P:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
	,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 917919d4bcac11f19a56ed5b684f684d-20260930
X-User: huanglu@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <huanglu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1129873126; Wed, 30 Sep 2026 16:54:38 +0800
From: Lu Huang <huanglu@kylinos.cn>
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	linux-wireless@vger.kernel.org
Cc: shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	chui-hao.chiu@mediatek.com,
	StanleyYP.Wang@mediatek.com,
	jtornosm@redhat.com,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Lu Huang <huanglu@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] wifi: mt76: mt7996: fix uninitialized buf read in mt7996_variant_fem_init()
Date: Wed, 30 Sep 2026 16:54:35 +0800
Message-Id: <20260930085435.1424493-1-huanglu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the eFuse block covering MT7976C_EFUSE_OFFSET is invalid,
mt7996_mcu_get_eeprom() returns -EINVAL without writing buf, but
mt7996_variant_fem_init() tolerates -EINVAL and keeps running, so
buf[idx] == 0xc reads uninitialized stack memory.  A stale 0x0c byte
misclassifies a 0x7976 aDie as 7976C, selects MT7996_FEM_INT and the
wrong default EEPROM, overriding valid calibration data.  Only consult
the eFuse byte when the read succeeded; with an invalid eFuse, fall
back to the three explicit aDie version checks.

Fixes: e8cb33ad546a ("wifi: mt76: mt7996: add support for more variants")
Cc: stable@vger.kernel.org
Signed-off-by: Lu Huang <huanglu@kylinos.cn>
---
 drivers/net/wireless/mediatek/mt76/mt7996/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index fb635a092584..a42a47c0d285 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -1247,7 +1247,7 @@ static int mt7996_variant_fem_init(struct mt7996_dev *dev)
 	adie_ver = u32_get_bits(regval, MT_ADIE_VERSION_MASK);
 	idx = MT7976C_EFUSE_OFFSET % MT7996_EEPROM_BLOCK_SIZE;
 	is_7976c = adie_ver == 0x8a10 || adie_ver == 0x8b00 ||
-		   adie_ver == 0x8c10 || buf[idx] == 0xc;
+		   adie_ver == 0x8c10 || (!ret && buf[idx] == 0xc);
 
 	adie_id = u32_get_bits(regval, MT_ADIE_CHIP_ID_MASK);
 	if (adie_id == 0x7975 || adie_id == 0x7979 ||
-- 
2.25.1


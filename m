Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046A835F60F;
	Tue, 28 Jul 2026 06:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785219619; cv=none; b=c66MnY1qcBR93psronXbyPt+DIzoIPMCY1u2NFxkQKfvSgn0A3Alv7S7zQTTZZndTb5KjQC6XzaQDBkvZDV2a76KYIEy76acrDquB0+nVg/ZUMlo0danZeWxGeZEwz+Azn9vPumfrUQjMwITPjCD5QEIoVuNU57HScNn9PBTEYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785219619; c=relaxed/simple;
	bh=hf0cxE+hS9rvpWZ3HFPQPVp1xNL5jhuqDiv45iDrDwU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b5jk074zhTLrqngwVnacB7rBSW0BwdNztLlCYKKSp0h2P7qgY4iQyvN7hGRh9aokOI36bIbR3k3Ji7spgN9feRgkmLto0v4xqL7VGE95x3RAgI4vUJDW0Gdp/YuMW3NmQ28SvvgBmjvAWnUGHRjeXJGuVBHKZSiEukd34MsjwTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 61398de08a4c11f1aa26b74ffac11d73-20260728
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD
	CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD
	ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:093dc4da-9be6-46f6-998d-7edc9c97175a,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:15
X-CID-INFO: VERSION:1.3.12,REQID:093dc4da-9be6-46f6-998d-7edc9c97175a,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:15
X-CID-META: VersionHash:e7bac3a,CLOUDID:b8cc2c17679be6389ba2838ef7ed2edd,BulkI
	D:2607281420105GWAU4LM,BulkQuantity:0,Recheck:0,SF:10|38|66|78|102|127|850
	|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:ni
	l,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE
	:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 61398de08a4c11f1aa26b74ffac11d73-20260728
X-User: yijiangshan@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <yijiangshan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 96208997; Tue, 28 Jul 2026 14:20:07 +0800
From: Jiangshan Yi <yijiangshan@kylinos.cn>
To: gupt21@gmail.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: hamish.martin@alliedtelesis.co.nz,
	sashal@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	13667453960@163.com,
	Jiangshan Yi <yijiangshan@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] HID: mcp2221: stop device IO before hid_hw_stop
Date: Tue, 28 Jul 2026 14:19:19 +0800
Message-Id: <20260728061919.310367-1-yijiangshan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mcp2221_probe() calls hid_device_io_start() to allow synchronous HID
transactions during setup.  If probe fails afterwards, the devm cleanup
callback mcp2221_hid_unregister() calls hid_hw_close()/hid_hw_stop()
without first calling hid_device_io_stop().

hid_hw_stop() does not stop device IO, so hid_input_report() may still
be delivered and access driver data being freed, causing a
use-after-free.  The same window exists on normal device removal.

Call hid_device_io_stop() at the top of mcp2221_hid_unregister() so
that IO is quiesced before the hardware is stopped in both the error
and remove paths.

Fixes: d4b50ac06ea6 ("HID: mcp2221: Allow IO to start during probe")
Cc: stable@vger.kernel.org
Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
---
 drivers/hid/hid-mcp2221.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-mcp2221.c b/drivers/hid/hid-mcp2221.c
index e4ddd8e9293b..83857ec1d61c 100644
--- a/drivers/hid/hid-mcp2221.c
+++ b/drivers/hid/hid-mcp2221.c
@@ -1049,6 +1049,7 @@ static void mcp2221_hid_unregister(void *ptr)
 {
 	struct hid_device *hdev = ptr;
 
+	hid_device_io_stop(hdev);
 	hid_hw_close(hdev);
 	hid_hw_stop(hdev);
 }
-- 
2.25.1


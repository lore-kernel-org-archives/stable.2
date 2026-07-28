Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5DB372EEC;
	Tue, 28 Jul 2026 06:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785219727; cv=none; b=pcBXFSv+GhMiDS6y4XCEXufUelhHDrYD4cRe+j1O+PAM01oJLxUZed0gJnEWzpJ5ODWCk6fP711pbvornBAd5alhSiCkiPJ9JJ4HQSquOOslqZzWOFH9C3sQyheCgir50pfz/2EvNgMko5Mbxbhrtnlx7daVtusJWiky4N5S3no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785219727; c=relaxed/simple;
	bh=TzpeiGOtf+olQCTX8lvCxsbTpkrRpVynK7QBdLJOquw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L9/hmhSPHWK7O/97jjrbyWfTxNX6YTk6Y+nnzJng/Yjubgvsi+jTvNk/I70yuVkz/Sb7hQTrTtdTOxLhbp8JwSB2PSnAg1CL/WroZTE2DGnljDi8ynf6HEVfd78jPsr8/lIbcosLIRt1U9OoOo00mOmcDAt1I/trk2bcmaOJwNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a16fcee28a4c11f1aa26b74ffac11d73-20260728
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD, CIE_GOOD_SPF
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:40ed0d17-f4e5-4704-b0c3-0278786e1361,IP:15,
	URL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:35
X-CID-INFO: VERSION:1.3.12,REQID:40ed0d17-f4e5-4704-b0c3-0278786e1361,IP:15,UR
	L:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:35
X-CID-META: VersionHash:e7bac3a,CLOUDID:d4f9c0994223fa8eb4582a5b57de8412,BulkI
	D:260728141222NV3X2C1Z,BulkQuantity:1,Recheck:0,SF:10|38|66|78|102|127|136
	|850|865|898,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk
	:41,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,B
	RE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a16fcee28a4c11f1aa26b74ffac11d73-20260728
X-User: yijiangshan@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <yijiangshan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1669212354; Tue, 28 Jul 2026 14:21:55 +0800
From: Jiangshan Yi <yijiangshan@kylinos.cn>
To: djogorchock@gmail.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	13667453960@163.com,
	Jiangshan Yi <yijiangshan@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] HID: nintendo: stop device IO before hid_hw_stop on probe failure
Date: Tue, 28 Jul 2026 14:21:28 +0800
Message-Id: <20260728062128.312859-1-yijiangshan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nintendo_hid_probe() calls hid_device_io_start() before joycon_init()
and joycon_leds_create().  If either fails, the error path jumps to
err_close which calls hid_hw_close()/hid_hw_stop() without first calling
hid_device_io_stop().

hid_hw_stop() does not stop device IO, so hid_input_report() may still
run and access driver data that is being torn down, resulting in a
use-after-free.

Add an err_io_stop label that calls hid_device_io_stop() before
hid_hw_close(), and point the two post-io_start error paths at it.

Fixes: 2af16c1f846b ("HID: nintendo: add nintendo switch controller driver")
Cc: stable@vger.kernel.org
Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
---
 drivers/hid/hid-nintendo.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
index e7302ec01ff1..0db553528826 100644
--- a/drivers/hid/hid-nintendo.c
+++ b/drivers/hid/hid-nintendo.c
@@ -2736,14 +2736,14 @@ static int nintendo_hid_probe(struct hid_device *hdev,
 	ret = joycon_init(hdev);
 	if (ret) {
 		hid_err(hdev, "Failed to initialize controller; ret=%d\n", ret);
-		goto err_close;
+		goto err_io_stop;
 	}
 
 	/* Initialize the leds */
 	ret = joycon_leds_create(ctlr);
 	if (ret) {
 		hid_err(hdev, "Failed to create leds; ret=%d\n", ret);
-		goto err_close;
+		goto err_io_stop;
 	}
 
 	/* Initialize the battery power supply */
@@ -2766,7 +2766,8 @@ static int nintendo_hid_probe(struct hid_device *hdev,
 
 err_ida:
 	ida_free(&nintendo_player_id_allocator, ctlr->player_id);
-err_close:
+err_io_stop:
+	hid_device_io_stop(hdev);
 	hid_hw_close(hdev);
 err_stop:
 	hid_hw_stop(hdev);
-- 
2.25.1


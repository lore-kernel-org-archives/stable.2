Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8519032F76D;
	Mon, 17 Aug 2026 06:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786948918; cv=none; b=a5mp+14SXNFj+SLfN0ortujsrby/Sz51MKo4JSP6p08CbRtpOO4sOyTep3xqmzGmVTo8P7kFNIOkv8rnYSGW4b580vrbI0j8itSj38NWGOHuzfq74DAxogJQq/I2YemM7TSrxcbqJyTZl4NRXPzZNI5AWkZyZNU7Osb3Mfno6o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786948918; c=relaxed/simple;
	bh=kdspecKkKPjXxXoYQ08m1jgrR63Glpb3AMDNmMQpR7w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aHqpYjZPqbP054hPs78kHQrmO5ioxgJ6kM0GQDBWRzeQQ3xTNJj4Zh5VYZax/u6z4FYjkahLbv+7987d/6KLoHl4PWlfHktrDrft51VhLV72Pl5Ia8CRvqss4sObhov/trARKZMjlO6HQHk0FGBYCg2vAK2SxhpVo9DscqVB3KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b701e1049a0611f19a56ed5b684f684d-20260817
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:bb6e6ec9-0d24-451c-a9a1-b40bc25fb757,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:7db8b62,CLOUDID:97eb16837373a411e3af7fcb1216f7f7,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50,EDM:5,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b701e1049a0611f19a56ed5b684f684d-20260817
X-User: gonglinkai@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <gonglinkai@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 850047536; Mon, 17 Aug 2026 14:41:45 +0800
From: Linkai Gong <gonglinkai@kylinos.cn>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Kuan-Chung Chen <damon.chen@realtek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linkai Gong <gonglinkai@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] wifi: rtw89: debug: fix off-by-one in rtw89_ppdu_str()
Date: Mon, 17 Aug 2026 14:41:40 +0800
Message-Id: <20260817064140.511320-1-gonglinkai@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rtw89_ppdu_str() uses type > ARRAY_SIZE(), so type == ARRAY_SIZE() still
indexes one past rtw89_ppdu_infos[]. Compare with >=, like
rtw89_txcmd_str().

Fixes: 419ed7f4a053 ("wifi: rtw89: debug: extend bb_info with TX status and PER")
Cc: stable@vger.kernel.org
Signed-off-by: Linkai Gong <gonglinkai@kylinos.cn>
---
 drivers/net/wireless/realtek/rtw89/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index 8f5af873e09f..5786120602ab 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -4348,7 +4348,7 @@ static const char *rtw89_ppdu_str(struct rtw89_dev *rtwdev, u8 type, u8 subtype)
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	const struct rtw89_ppdu_info *ppdu_info;
 
-	if (type > ARRAY_SIZE(rtw89_ppdu_infos))
+	if (type >= ARRAY_SIZE(rtw89_ppdu_infos))
 		return "RSVD";
 
 	ppdu_info = &rtw89_ppdu_infos[type];
-- 
2.25.1

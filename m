Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865BD337BB8;
	Thu, 30 Jul 2026 10:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785406550; cv=none; b=HqcWG+KyOR+1J9bimU888ndzYkdgsUYj37Gr/YNLOMrw8tUZZdcD42enzWT/JKDjO8W0A+nWJHLk91AWp8kddLkSKO6SHFjxCH8bsVaVUyMHluy66pXy0lX7RbNyo4rYLnitLmsdUqg7AFWUfoKZmmXEMywv+gv9jexn1P7B//E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785406550; c=relaxed/simple;
	bh=LnntfNw/y5kXo6ctlrcTcJ9zVjYBMSadqsdXJu28F+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HiazGm9sTY53g8WBPVKEZvsRTgE7FL59d1AHIW3BeppZy7GDc4pvq0EZZ7t5OvHTZlCCeK4iKSU+tp95VMAOiNdl+xxUyW3UA88FvbR1EmiUPrCAEwUJnIbfUySTGfXCjRjF30uuaEuWTl73oVqYpWDF0JNM083aSKcPjB3V830=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 995ad5e48bff11f1aa26b74ffac11d73-20260730
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, UD_TRUSTED, CIE_BAD
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:f66b0023-c092-4e70-a553-aaff266ebd56,IP:15,
	URL:25,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:35
X-CID-INFO: VERSION:1.3.12,REQID:f66b0023-c092-4e70-a553-aaff266ebd56,IP:15,UR
	L:25,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:35
X-CID-META: VersionHash:e7bac3a,CLOUDID:1c7dfba27a1a6ab8277e1a20b8207cfd,BulkI
	D:260730181537BLSJV2LQ,BulkQuantity:0,Recheck:0,SF:10|38|66|78|102|127|850
	|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:11|94|82|1,File:nil,RT:ni
	l,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,
	BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 995ad5e48bff11f1aa26b74ffac11d73-20260730
X-User: yijiangshan@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <yijiangshan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 427557263; Thu, 30 Jul 2026 18:15:33 +0800
From: Jiangshan Yi <yijiangshan@kylinos.cn>
To: djogorchock@gmail.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	13667453960@163.com,
	Jiangshan Yi <yijiangshan@kylinos.cn>,
	sashiko-bot@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] HID: nintendo: register input device after capabilities are set
Date: Thu, 30 Jul 2026 18:15:06 +0800
Message-Id: <20260730101506.547340-1-yijiangshan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

input_register_device() exposes the device to userspace immediately.
In joycon_input_create() it was called before joycon_config_rumble()
configures the FF_RUMBLE capability and the memless force-feedback
device, so a concurrent EVIOCSFF could dereference a NULL dev->ff.

Registering early also means the initial udev event lacks button and
axis information, which can make input managers ignore the device.

Move input_register_device() to the end of joycon_input_create(), after
all capabilities, the IMU input device and the force-feedback callbacks
have been configured.

Fixes: 2af16c1f846b ("HID: nintendo: add nintendo switch controller driver")
Reported-by: sashiko-bot@kernel.org
Closes: https://sashiko.dev/#/patchset/20260730031927.25444-1-yijiangshan@kylinos.cn?part=1
Cc: stable@vger.kernel.org
Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
---
 drivers/hid/hid-nintendo.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
index e7302ec01ff1..7f014f371800 100644
--- a/drivers/hid/hid-nintendo.c
+++ b/drivers/hid/hid-nintendo.c
@@ -2162,10 +2162,6 @@ static int joycon_input_create(struct joycon_ctlr *ctlr)
 	ctlr->input->phys = hdev->phys;
 	input_set_drvdata(ctlr->input, ctlr);
 
-	ret = input_register_device(ctlr->input);
-	if (ret)
-		return ret;
-
 	if (joycon_type_is_right_joycon(ctlr)) {
 		joycon_config_right_stick(ctlr->input);
 		joycon_config_buttons(ctlr->input, right_joycon_button_mappings);
@@ -2208,6 +2204,10 @@ static int joycon_input_create(struct joycon_ctlr *ctlr)
 	if (joycon_has_rumble(ctlr))
 		joycon_config_rumble(ctlr);
 
+	ret = input_register_device(ctlr->input);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
-- 
2.25.1


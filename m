Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3923A369D59;
	Tue,  1 Sep 2026 06:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788244201; cv=none; b=kIUh9yHZXaJdyGMjP3pu1XP4tmoOVBB1B6m4jo2YVnXSdTMjzhTu6jGawf2oWMqZBPVvvPY9o5gH77joRHNDYmHc38I8PUCB6r2KZpc/TBQD77fSLMnRYo1l5RtCfWC6+1g8CW9LMfHyXCz73wdLSfKR+2LWTU56o337s32FFkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788244201; c=relaxed/simple;
	bh=qNv3G/6Nst4orErUirqmSKISRn7FglIWlvlzS1C/AqE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pGTkNwboI1HdEINwoeVPiNinSVzbzsX7cjsS+e6KXAIFN0BHgaaUahPHu9i1Tdctuve2vabdVYDmj6cHNTxudb1Tbj3x6joQQYYpxDMVBns8BHWVqtjvqnUawUxezdz/gCfAhX/hkH280zSGUql9ODnjEnpq74hjdDkLWzqGAgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 8729842ca5ce11f19a56ed5b684f684d-20260901
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:0fc24f77-7da8-46f8-8266-5c881370f6f7,IP:15,
	URL:0,TC:0,Content:0,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.3.19,REQID:0fc24f77-7da8-46f8-8266-5c881370f6f7,IP:15,UR
	L:0,TC:0,Content:0,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:EDM_GE969F26,ACTIO
	N:release,TS:-5
X-CID-META: VersionHash:7db8b62,CLOUDID:f7159815a406fc5c31978a7e0c50b7ae,BulkI
	D:2609011429519RL32R6X,BulkQuantity:0,SF:10|38|66|78|102|127|850|865|898,T
	C:nil,Content:0|15|50,EDM:1|-100,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:n
	il,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC
	:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_AEC
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 8729842ca5ce11f19a56ed5b684f684d-20260901
X-User: yijiangshan@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <yijiangshan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1963668278; Tue, 01 Sep 2026 14:29:47 +0800
From: Jiangshan Yi <yijiangshan@kylinos.cn>
To: peterhuewe@gmx.de,
	jarkko@kernel.org
Cc: jgg@ziepe.ca,
	ross.philipson@oracle.com,
	stefanb@linux.ibm.com,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	13667453960@163.com,
	Jiangshan Yi <yijiangshan@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] tpm: Fix heap buffer overflow in tpm_transmit_cmd()
Date: Tue,  1 Sep 2026 14:28:50 +0800
Message-Id: <20260901062850.379870-1-yijiangshan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct tpm_buf now uses an embedded flexible array for data, which is
6 bytes shorter than TPM_BUFSIZE due to the struct header. But
tpm_transmit_cmd() still passes PAGE_SIZE to tpm_transmit(), and after
clamping to TPM_BUFSIZE in tpm_try_transmit(), chip->ops->recv() can
write past the end of data[] by 6 bytes.

Pass buf->capacity to tpm_transmit() instead.

Fixes: 3d9e043dab0a ("tpm-buf: Memory-safe allocations")
Cc: stable@vger.kernel.org
Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
---
 drivers/char/tpm/tpm-interface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index f745a098908b..1ccdbde98b69 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -268,7 +268,7 @@ ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_buf *buf,
 	int err;
 	ssize_t len;
 
-	len = tpm_transmit(chip, buf->data, PAGE_SIZE);
+	len = tpm_transmit(chip, buf->data, buf->capacity);
 	if (len <  0)
 		return len;
 
-- 
2.25.1


Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF413998AE;
	Wed,  2 Sep 2026 07:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788335370; cv=none; b=mGo7hXfVvykveNHNYmy5MfaZAY8vJpJnfQ/qI2R30R7aiZIW8eA3F+2+zKj9GO+eP/Uj/ASfkN0h6wyAHigLa1NwugXF68Bf/N/0L3ijXaRHU7Xg7tTtVwdPSV8ODb39Gx+AB+N8J0Ifz+Kp/cJsWEmL9U5cGJzZWHu99xEwp80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788335370; c=relaxed/simple;
	bh=+1/D6f2NxafMslNqlKAGyx9tIFvz2vbLG7i9pjd7mqw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rOD6HsbItHhDf0DDb6OZCFkGhhnp7HD4DLAhtWZq/AqzO8LpPDo3Yr7lO0DOlp1u25PtJoiLPOsH29MEapvlGhoUF8ecAimDRJqbFmEefSBoKeC9brbh4K9SCPzeO5BkbyYArwJms5Wa2DYitWv0HG8QTA3Strv0culMfEY2exE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: cc904adaa6a211f19a56ed5b684f684d-20260902
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:1db8b9f7-2434-446a-bb2b-b06786e8dd33,IP:15,
	URL:0,TC:0,Content:-5,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-10
X-CID-INFO: VERSION:1.3.19,REQID:1db8b9f7-2434-446a-bb2b-b06786e8dd33,IP:15,UR
	L:0,TC:0,Content:-5,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-10
X-CID-META: VersionHash:7db8b62,CLOUDID:48c77bd802e5ea91e7bcb88572b3abc2,BulkI
	D:26090215491983ZS9DE2,BulkQuantity:0,SF:10|38|66|78|102|127|136|850|865|8
	98,TC:nil,Content:0|15|50,EDM:-19|2|-100,IP:-2,URL:0,File:nil,RT:nil,Bulk:
	nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,B
	RE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: cc904adaa6a211f19a56ed5b684f684d-20260902
X-User: yijiangshan@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <yijiangshan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2011002584; Wed, 02 Sep 2026 15:49:17 +0800
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
Subject: [PATCH] tpm: Fix auth session leak in tpm2_get_random() error path
Date: Wed,  2 Sep 2026 15:48:39 +0800
Message-Id: <20260902074839.417419-1-yijiangshan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When tpm_buf_fill_hmac_session() fails in tpm2_get_random(), the error
path returns without calling tpm2_end_auth_session(), leaking the auth
session. All other error paths in the function handle this correctly.

Fixes: 3d9e043dab0a ("tpm-buf: Memory-safe allocations")
Cc: stable@vger.kernel.org
Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
---
 drivers/char/tpm/tpm2-cmd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 48cec39995fe..96e0e06bbbf0 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -281,8 +281,10 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 		}
 		tpm_buf_append_u16(buf, num_bytes);
 		err = tpm_buf_fill_hmac_session(chip, buf);
-		if (err)
+		if (err) {
+			tpm2_end_auth_session(chip);
 			return err;
+		}
 
 		err = tpm_transmit_cmd(chip, buf,
 				       offsetof(struct tpm2_get_random_out,
-- 
2.25.1


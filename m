Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707B43DC4DE
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 14:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786372649; cv=none; b=fojcnm5HSp/ruBaGFIpYd1ZKr82E9Ve70+v6ntpEbNvcoST17YTnnE7rCOR7EGsU9AhsX6jspkwCO4QTT8+r1s9L4HQLYTM3oDlIWFzoRfsRXbY2GhslBpzft0vaaeYANDiJd5rcAaqPGePJvM8y1K4BrR4Bw1+1OmP/TXN8zPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786372649; c=relaxed/simple;
	bh=t3ctwqgS9ou0XiwfcT3bs4QaJCUfvbP/xU6MeLUUu3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AWaafRDuACP6PPn+CMJucpZRR3p04DFHNF1ZmyjQ6WZZNhx4oAn5+yj2bVLV2iTQiAdiOYozf1X47XtNknp/QZ80ZKtXBf+Hhj68L03ldbWJCUMgD1oiQuvbNsnO4hdqF3gxnn0XuEmQ6/Z++13hiqkftllwftAiGG4xU67N+uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=B596JomD; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="B596JomD"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AD1kJf1611897
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 14:37:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=9ww6lOAXfTRg02jq8
	dAowOZzWKBKpyG06hIFNkLZQJM=; b=B596JomDoVnFoAOIVF4EsB0yCegxqdDI6
	MJzeHvO6SNrpfBOUE1KwYaExLZg79yQTnC2exD3exdU9SOpTbtlBa1vHV58ugHHC
	cLUEQP7babeAksZYlNPqWNj6agCuW9qCw3L7O9ODDgeaSPc2ezAJsRlMO/geqVq8
	iplyW2fD3bYfZPF5dOqv3SGHmqmqyiehKEUph/zTT54/XoagFVUJlBDFnY2v51sU
	U11HvMldQ/enI+/wDLMjL6FpYkTDNdCXVf97Vz11mjVhfn83JhLhvRpTIbkUT5Ac
	NK4W5vjQcUPvav2nIbuF0ozhltUxnNw7PCPbC3N8Hbzjt0/SR/2/w==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp2r36s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 14:37:27 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67AEQFGv023746
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 14:37:26 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9gw3y4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 14:37:26 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67AEbMqo38601180
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 14:37:22 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8EFE320043;
	Mon, 10 Aug 2026 14:37:22 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5817B20040;
	Mon, 10 Aug 2026 14:37:22 +0000 (GMT)
Received: from ibm.com (unknown [9.111.40.237])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Aug 2026 14:37:22 +0000 (GMT)
From: Holger Dengler <dengler@linux.ibm.com>
To: stable@vger.kernel.org
Cc: Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH 6.12.y] s390/zcrypt: Fix missing mem scrub at clear key import in cca_clr2cipherkey()
Date: Mon, 10 Aug 2026 16:37:19 +0200
Message-ID: <20260810143719.653754-1-dengler@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026080532-footage-footer-3d54@gregkh>
References: <2026080532-footage-footer-3d54@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a79e227 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=l_XADsiG0JAIV5gd_FcA:9
X-Proofpoint-GUID: WnsguF3nH4LNPrDcV7Oy2r9hOgEViDkU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEyNSBTYWx0ZWRfX2sEPA7kdscEm
 Y/7xz52W7KrQHR6l0X0x1+AE9fslOp0Y0U2ft/I/GAg5pIInPncUgcP6fZpg3i9ULe61pkKyQi5
 4WUUkNf2gRnmpV6IsNdeAb4Pa1OzclQEFeYaapiGghhEFycgEyy7m4TIK2tHGLuA4GFOdotQuic
 rMx9tY0k/qGFfpudKL+wyoyVNcQ3+fERVxOa9LQMR+j8dJpB842Clwh1hM3Vhw/Nx0a2gn4SbDW
 DgeWXpujPXKjrxhVK7ZizlaoJyZ4oOVrR9ICq3ittoUwMCXg0cFaLC2nGAyYvp27wZxPAbC4Qda
 v01kQzYe0QfDnH9cHa2mBMeXt9SQ8FBzlLQo/5BGChNa43ewcxPzLRAgJmWdA8yUsMPDfoKabJk
 /1b9yaCj+omSPQRgrbkjn8nWoeZtIKXhqwp8YvhRsPspfG4H3RkS7ZrfqpK9eTIN8coirvfuifz
 HuZwKUzmhLNBLPzyDuA==
X-Proofpoint-ORIG-GUID: WnsguF3nH4LNPrDcV7Oy2r9hOgEViDkU
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEyNSBTYWx0ZWRfX8256PQ74pOxF
 9CSdUf1mgmuuuzKp/TuXtLMz6yA+EfBcIBVjFOE97FZrktAFUvtHGmesxDS2lN1m7wRfN5XHPUm
 +WtWtTlb0/6yHjxc8KijNuyj5bfA/vU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100125

From: Harald Freudenberger <freude@linux.ibm.com>

The helper function _ip_cprb_helper() uses internal buffer memory for
building and processing CPRBs. After use this buffer was never
scrubbed which could lead to leaving for example clear key material in
memory which could be exposed via tricky reuse of this same memory.

Extend the _ip_cprb_helper() function with another parameter 'scrub'
used to steer scrubbing of this buffer. So now the caller has the
opportunity to decide if scrubbing is needed or not.

Extend the clear key to secure key token import process in function
cca_clr2cipherkey() to tell the helper function from above to scrub
the cprb buffer when the clear key value is part of the request data.

Add explicit scrubbing on return from function cca_clr2cipherkey() for
the random EXOR buffer and the cprb buffer.

Overall this cleans the internal used buffer in case of clear key
import to prevent sensitive data to get exposed.

Fixes: 4bc123b18ce6 ("s390/zcrypt: Add low level functions for CCA AES cipher keys")
Cc: stable@vger.kernel.org
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
(cherry picked from commit 01476391aecef36a3b789ee844357b22fbc90665)
Signed-off-by: Holger Dengler <dengler@linux.ibm.com>
---
 drivers/s390/crypto/zcrypt_ccamisc.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c b/drivers/s390/crypto/zcrypt_ccamisc.c
index 6790afd517ec6..48d36d5a87118 100644
--- a/drivers/s390/crypto/zcrypt_ccamisc.c
+++ b/drivers/s390/crypto/zcrypt_ccamisc.c
@@ -938,7 +938,8 @@ static int _ip_cprb_helper(u16 cardnr, u16 domain,
 			   const u8 *clr_key_value,
 			   int clr_key_bit_size,
 			   u8 *key_token,
-			   int *key_token_size)
+			   int *key_token_size,
+			   bool scrub)
 {
 	int rc, n;
 	u8 *mem, *ptr;
@@ -1077,7 +1078,7 @@ static int _ip_cprb_helper(u16 cardnr, u16 domain,
 	*key_token_size = t->len;
 
 out:
-	free_cprbmem(mem, PARMBSIZE, 0);
+	free_cprbmem(mem, PARMBSIZE, scrub);
 	return rc;
 }
 
@@ -1120,28 +1121,32 @@ int cca_clr2cipherkey(u16 card, u16 dom, u32 keybitsize, u32 keygenflags,
 	 * 4/4 COMPLETE the secure cipher key import
 	 */
 	rc = _ip_cprb_helper(card, dom, "AES     ", "FIRST   ", "MIN3PART",
-			     exorbuf, keybitsize, token, &tokensize);
+			     exorbuf, keybitsize, token, &tokensize,
+			     true);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s clear key import 1/4 with CSNBKPI2 failed, rc=%d\n",
 			       __func__, rc);
 		goto out;
 	}
 	rc = _ip_cprb_helper(card, dom, "AES     ", "ADD-PART", NULL,
-			     clrkey, keybitsize, token, &tokensize);
+			     clrkey, keybitsize, token, &tokensize,
+			     true);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s clear key import 2/4 with CSNBKPI2 failed, rc=%d\n",
 			       __func__, rc);
 		goto out;
 	}
 	rc = _ip_cprb_helper(card, dom, "AES     ", "ADD-PART", NULL,
-			     exorbuf, keybitsize, token, &tokensize);
+			     exorbuf, keybitsize, token, &tokensize,
+			     true);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s clear key import 3/4 with CSNBKPI2 failed, rc=%d\n",
 			       __func__, rc);
 		goto out;
 	}
 	rc = _ip_cprb_helper(card, dom, "AES     ", "COMPLETE", NULL,
-			     NULL, keybitsize, token, &tokensize);
+			     NULL, keybitsize, token, &tokensize,
+			     true);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s clear key import 4/4 with CSNBKPI2 failed, rc=%d\n",
 			       __func__, rc);
@@ -1158,7 +1163,8 @@ int cca_clr2cipherkey(u16 card, u16 dom, u32 keybitsize, u32 keygenflags,
 	*keybufsize = tokensize;
 
 out:
-	kfree(token);
+	memzero_explicit(exorbuf, sizeof(exorbuf));
+	kfree_sensitive(token);
 	return rc;
 }
 EXPORT_SYMBOL(cca_clr2cipherkey);
-- 
2.55.0


Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F28828033B
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 13:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786369226; cv=none; b=gEUjio9R9QqOA+h5kKMAIai+vDDqxyxcIuO7Wxkp80XsqOzZk/JaKh8VC2zPPYOj0ZscKCgAlyiwC+hO/djguk0AsuizmKFwqmIHTpSXP72fo8iJtiCsbBmn2InpBBDWdhSJY8PLhSIrydswhzmkbLfojfBbPnb2QRZWq3OOU9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786369226; c=relaxed/simple;
	bh=akCPl3P6Pjhdiir+56fhDH/0TOqnuVVrUbMNeShGnS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jZyDf6wq0G+pK2cGPBSOMNX/bYxlhFp9Cu5goHW77iN6IR18p9hQR4NFoiAHi2rW82taEJf0G6FSpP1/0tcFtSxniLWYlvbI8lLtXmuOnhhs8BYqJc5VrJDEWQNdC7HFfBJ2q5Nfrh4R/gshisCFXsvMp8qmlIBWdiLpVn3MJs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Dnr268kA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Dnr268kA"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AD1Yxu1611619
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 13:40:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=5LtZO/QEKoC59etVf
	dhHFLhK3jW1lUF62o3rJ+Nu5D0=; b=Dnr268kAmCN2wFDhoHnUMCJt2InTs0TXs
	yi/1BHySkGDXEz7MHvpolhGo09og9sMN770N7lmxL04mN6DNPXynu04bbHtxNQlW
	6bsslqmUB5a0xte+lp77t32Ql+bviDex2dBjTideJ+3V0uCwTFR27gPvt71yEwvH
	5H5eBMWrt2knI41Q3uNULq5NFnifHwy+PJVQUjfyK+FOUFthARRCwh4RKx0drh+0
	gORHuhzrYXBB6vAHqObHWDleUrAxK/FQIIxK3Lsb0iX5efMoqY9tjTqnJIPyvS05
	qb0wWbYcGoNzOSNRhMsse3LNSUXI3l0AQXWeFJGZ16wo280MbpI7A==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp2qtw0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 13:40:23 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67ADQJlU004100
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 13:40:23 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsjmym2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 13:40:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67ADeJWR51708362
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 13:40:19 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1531120040;
	Mon, 10 Aug 2026 13:40:19 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D151A20043;
	Mon, 10 Aug 2026 13:40:18 +0000 (GMT)
Received: from ibm.com (unknown [9.111.40.237])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Aug 2026 13:40:18 +0000 (GMT)
From: Holger Dengler <dengler@linux.ibm.com>
To: stable@vger.kernel.org
Cc: Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH 5.15.y] s390/zcrypt: Fix missing mem scrub at clear key import in cca_clr2cipherkey()
Date: Mon, 10 Aug 2026 15:40:12 +0200
Message-ID: <20260810134012.364362-1-dengler@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026080534-emptiness-clambake-2bac@gregkh>
References: <2026080534-emptiness-clambake-2bac@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a79d4c7 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=l_XADsiG0JAIV5gd_FcA:9
X-Proofpoint-GUID: beBD5LX3L0ABZI78X9g90GThGyQcvw6z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDExNiBTYWx0ZWRfX89m054/QvtbA
 9fzonoNh5IS2KSZhF1fyZP3N/68JhRewdNAarp2OmQt0v09JF0owzyWdRAyqdd9Wzm3G/WhFVRm
 XFsqDpXJLpTJF7dWMZ2rljVPRr6o7FHj+aLYdHZLYQRmDRboQLK5ROU9309HTmpEXZ/Dlk0yqEJ
 QXXfl9YGMgwPiN2xzks3SgHQDgHdQyi4kFgORrln0F4CAqmvCmT6kAO+jHq0nOTksLZ4n/MfiP1
 kJAL1CRewWnr/OtJYtLpGDNby15wJi6RDveuBcHiLzXPJMxj8cOWMWwzSDlB20MWRSMh4br7GLO
 x0MxlUFHHSuoNir7cqoFFodjxB+voGNaQ65KOTp2+TfFShUekwvf44hOdq8tTNYd9Glrk9xLvK7
 UI5mIl0TNf2+a1z5jSnm0VyUabJI+D8vwznAVFLuQbgiM8Z+z+S8/2McnUDSnYEuPPiv//u1088
 BkN0IgXslZRg8cTvl6Q==
X-Proofpoint-ORIG-GUID: beBD5LX3L0ABZI78X9g90GThGyQcvw6z
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDExNiBTYWx0ZWRfX6tBlLTeSpT7F
 WVMWDUxn4rddfeFV0xDjRLhFEZZU0qFR2vb6QvgtJL5RcHLplPncNfH5cx6JDcY334JYquMFMob
 L5olI+2RogWmlqzy49TYVndB+YeL8xw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100116

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
index 6a3c2b4609652..a64cb0268b2ee 100644
--- a/drivers/s390/crypto/zcrypt_ccamisc.c
+++ b/drivers/s390/crypto/zcrypt_ccamisc.c
@@ -946,7 +946,8 @@ static int _ip_cprb_helper(u16 cardnr, u16 domain,
 			   const u8 *clr_key_value,
 			   int clr_key_bit_size,
 			   u8 *key_token,
-			   int *key_token_size)
+			   int *key_token_size,
+			   bool scrub)
 {
 	int rc, n;
 	u8 *mem, *ptr;
@@ -1087,7 +1088,7 @@ static int _ip_cprb_helper(u16 cardnr, u16 domain,
 	*key_token_size = t->len;
 
 out:
-	free_cprbmem(mem, PARMBSIZE, 0);
+	free_cprbmem(mem, PARMBSIZE, scrub);
 	return rc;
 }
 
@@ -1130,7 +1131,8 @@ int cca_clr2cipherkey(u16 card, u16 dom, u32 keybitsize, u32 keygenflags,
 	 * 4/4 COMPLETE the secure cipher key import
 	 */
 	rc = _ip_cprb_helper(card, dom, "AES     ", "FIRST   ", "MIN3PART",
-			     exorbuf, keybitsize, token, &tokensize);
+			     exorbuf, keybitsize, token, &tokensize,
+			     true);
 	if (rc) {
 		DEBUG_ERR(
 			"%s clear key import 1/4 with CSNBKPI2 failed, rc=%d\n",
@@ -1138,7 +1140,8 @@ int cca_clr2cipherkey(u16 card, u16 dom, u32 keybitsize, u32 keygenflags,
 		goto out;
 	}
 	rc = _ip_cprb_helper(card, dom, "AES     ", "ADD-PART", NULL,
-			     clrkey, keybitsize, token, &tokensize);
+			     clrkey, keybitsize, token, &tokensize,
+			     true);
 	if (rc) {
 		DEBUG_ERR(
 			"%s clear key import 2/4 with CSNBKPI2 failed, rc=%d\n",
@@ -1146,7 +1149,8 @@ int cca_clr2cipherkey(u16 card, u16 dom, u32 keybitsize, u32 keygenflags,
 		goto out;
 	}
 	rc = _ip_cprb_helper(card, dom, "AES     ", "ADD-PART", NULL,
-			     exorbuf, keybitsize, token, &tokensize);
+			     exorbuf, keybitsize, token, &tokensize,
+			     true);
 	if (rc) {
 		DEBUG_ERR(
 			"%s clear key import 3/4 with CSNBKPI2 failed, rc=%d\n",
@@ -1154,7 +1158,8 @@ int cca_clr2cipherkey(u16 card, u16 dom, u32 keybitsize, u32 keygenflags,
 		goto out;
 	}
 	rc = _ip_cprb_helper(card, dom, "AES     ", "COMPLETE", NULL,
-			     NULL, keybitsize, token, &tokensize);
+			     NULL, keybitsize, token, &tokensize,
+			     true);
 	if (rc) {
 		DEBUG_ERR(
 			"%s clear key import 4/4 with CSNBKPI2 failed, rc=%d\n",
@@ -1172,7 +1177,8 @@ int cca_clr2cipherkey(u16 card, u16 dom, u32 keybitsize, u32 keygenflags,
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


Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788B33DA5CC
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 13:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786367572; cv=none; b=IeSIySA8LAPi+SvBrpocPPl+Q4hjn+ly0iogFZeD2NsQK5iiSqAkM3NmY1m1E3OogLwoQIacuHi2Nq9c/OhOrNjFsIdU5FoFKmhQDvlAhKA7v8+Jv6taEbZQ8Ov5+/uTYHS+DslPfRSEZU/nCuc0aVMT4plUKlDOQNn3VsUMpDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786367572; c=relaxed/simple;
	bh=kRcA3dKhoYtO7aDySUDsSU/Ds5qE0qYNqQMNYpwc25w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=axrjaPr14UWBV7kM54lZ5uKZhARnrHX6ydgghEgFbVjgDjVm25aQRUuNgENh+mTrruKrOKMbI6vNQkqU8T4tLQmDADv7DdW8/9ddCNA4HD+shL9rkr7FpmeV4eS3uBI7ks190wRMmjENUcJTOv2mzrxEyqR1rWaVhvIZ+Wx2e8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=i0+dUBhc; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="i0+dUBhc"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AD1hbD1611856
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 13:12:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=dp5bkCDZg+81C9Owy
	NWRAymAleQvN7x8QWhGXYjJ7IM=; b=i0+dUBhc16ErV/SbPHQelBEgNUkA5+Bpk
	m5i6tyCcaZ7mEPA7Pi4K1X5m7WfommTQTObTTZ+O2MvRZAUaPxlKdybCCEks2TDs
	FUDfnDKshd+fN/99lFpGR98AFof5Oq+ykemm7q8YP9q2GdseXXZ+tOaN0fi9KPie
	bQfOXPLZBUXBxje5BJZmAoQhcIMv21K5viSeKxGfHpCrKTMlZN+IXJsJbXeyYk5o
	uBBJQXarZ0scNU5o3aAei3Qz11j46UUbLzsdz2+wTxyXsGw6G31Gw8ahzgYsxnkl
	iLBypDyC6yz+e00VACzpwuC2c5/sM68aPYKUBwQ0sHUnkUNbnh/ug==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp2qqa7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 13:12:48 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67ADBNvE031800
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 13:12:47 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9gvthj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 13:12:47 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67ADChnR15597938
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 13:12:44 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE1FC20043;
	Mon, 10 Aug 2026 13:12:43 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 95F9F20040;
	Mon, 10 Aug 2026 13:12:43 +0000 (GMT)
Received: from ibm.com (unknown [9.111.40.237])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Aug 2026 13:12:43 +0000 (GMT)
From: Holger Dengler <dengler@linux.ibm.com>
To: stable@vger.kernel.org
Cc: Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH 5.10.y] s390/zcrypt: Fix missing mem scrub at clear key import in cca_clr2cipherkey()
Date: Mon, 10 Aug 2026 15:12:17 +0200
Message-ID: <20260810131217.238074-1-dengler@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026080534-font-filtrate-0519@gregkh>
References: <2026080534-font-filtrate-0519@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a79ce50 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=l_XADsiG0JAIV5gd_FcA:9
X-Proofpoint-GUID: 3R5zk3dnb3LQHmGqLoS-SeXZgVMCDnDJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDExMiBTYWx0ZWRfX1hYevmiLOXSG
 6O055UryxrXtcdDGOc+2eHDO5VXaGywZyX545yhIYCCkJRT/0X2a/vEeGCUrr2oxVvqQiFN5jtk
 eR6BMTF6o5FaVjeMXSH2po+TQcjuVMgid0m1p4RHuWjMb/gOqtQQPy/1ooJ7cOzQxjdPRBiH3ei
 oQ71q7/KMQnZM8aJqWSNHnSc1C0H/YDo8Edbdjure+ba/PZThdvfTy1o0U9nSTdR79BkhiYKkPW
 0GCRBKrYWVoUjwlrhfF88LyRVifYNt+XvFRpPbCmZjZEMSnr8nsbBUGmW6wSGWvLPjZ2TpT2t0n
 BjiEOEDcQps44TjjoymAWi/MdkY44Op7QAQWHreIkKmZ3gqHd/dshRcVouc74XbmQkxWc9FK3sC
 aYtoT/tu6E5EZ/sWETGYK5CEqRCi6dZnOxIiXjR65lCpPcf44RZcVYzWxxsvSqfnnTyM+oY+GhX
 CQTjGMGTsN4G14v617A==
X-Proofpoint-ORIG-GUID: 3R5zk3dnb3LQHmGqLoS-SeXZgVMCDnDJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDExMiBTYWx0ZWRfX8itCTjs+H5vY
 I1RwIhNAzBuJWU+gjb5JbyngGdlllrCZBRQIQyP9Qg5GzXCdhwUvVQ2xnfZLSpv4ocfDskRCJbC
 1usg9Df1CXpMZa1kQZPdwq61faxMScE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1011
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100112

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
index d8046e589742a..3d18ad5f7b31e 100644
--- a/drivers/s390/crypto/zcrypt_ccamisc.c
+++ b/drivers/s390/crypto/zcrypt_ccamisc.c
@@ -943,7 +943,8 @@ static int _ip_cprb_helper(u16 cardnr, u16 domain,
 			   const u8 *clr_key_value,
 			   int clr_key_bit_size,
 			   u8 *key_token,
-			   int *key_token_size)
+			   int *key_token_size,
+			   bool scrub)
 {
 	int rc, n;
 	u8 *mem, *ptr;
@@ -1084,7 +1085,7 @@ static int _ip_cprb_helper(u16 cardnr, u16 domain,
 	*key_token_size = t->len;
 
 out:
-	free_cprbmem(mem, PARMBSIZE, 0);
+	free_cprbmem(mem, PARMBSIZE, scrub);
 	return rc;
 }
 
@@ -1127,7 +1128,8 @@ int cca_clr2cipherkey(u16 card, u16 dom, u32 keybitsize, u32 keygenflags,
 	 * 4/4 COMPLETE the secure cipher key import
 	 */
 	rc = _ip_cprb_helper(card, dom, "AES     ", "FIRST   ", "MIN3PART",
-			     exorbuf, keybitsize, token, &tokensize);
+			     exorbuf, keybitsize, token, &tokensize,
+			     true);
 	if (rc) {
 		DEBUG_ERR(
 			"%s clear key import 1/4 with CSNBKPI2 failed, rc=%d\n",
@@ -1135,7 +1137,8 @@ int cca_clr2cipherkey(u16 card, u16 dom, u32 keybitsize, u32 keygenflags,
 		goto out;
 	}
 	rc = _ip_cprb_helper(card, dom, "AES     ", "ADD-PART", NULL,
-			     clrkey, keybitsize, token, &tokensize);
+			     clrkey, keybitsize, token, &tokensize,
+			     true);
 	if (rc) {
 		DEBUG_ERR(
 			"%s clear key import 2/4 with CSNBKPI2 failed, rc=%d\n",
@@ -1143,7 +1146,8 @@ int cca_clr2cipherkey(u16 card, u16 dom, u32 keybitsize, u32 keygenflags,
 		goto out;
 	}
 	rc = _ip_cprb_helper(card, dom, "AES     ", "ADD-PART", NULL,
-			     exorbuf, keybitsize, token, &tokensize);
+			     exorbuf, keybitsize, token, &tokensize,
+			     true);
 	if (rc) {
 		DEBUG_ERR(
 			"%s clear key import 3/4 with CSNBKPI2 failed, rc=%d\n",
@@ -1151,7 +1155,8 @@ int cca_clr2cipherkey(u16 card, u16 dom, u32 keybitsize, u32 keygenflags,
 		goto out;
 	}
 	rc = _ip_cprb_helper(card, dom, "AES     ", "COMPLETE", NULL,
-			     NULL, keybitsize, token, &tokensize);
+			     NULL, keybitsize, token, &tokensize,
+			     true);
 	if (rc) {
 		DEBUG_ERR(
 			"%s clear key import 4/4 with CSNBKPI2 failed, rc=%d\n",
@@ -1169,7 +1174,8 @@ int cca_clr2cipherkey(u16 card, u16 dom, u32 keybitsize, u32 keygenflags,
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


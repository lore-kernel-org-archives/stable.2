Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0ED3128D7
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 14:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786370443; cv=none; b=Ntykf8QFPtrs21HcDm+MsoevO78q0n36mOhDrQA/rYp0UmjSoATdHwV28ZJudAPgSKixQpOf1I5/IHuo5X58NBphR8YVRieCXCNVNkEYKr/CLT32bsOJwqLu9Gq5NwAdOjCpSbF54UjFr+iTNNj4EHx9WIHD1qj/WX7pIKxx1JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786370443; c=relaxed/simple;
	bh=qsR4E4rRliRWrtc9y5r9s9jnMgjtwOJlkIjefJevDVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oNbMVggKBMfvOIrVm8ulZ8O8nOaVzfPZz9BkrTz4J6Z8lxEsl0eUUXD1vMFQmqp7Dd/ec0b9vgW1dQgPNNleNRA8MUYXHMSaM9jXBJUk8yA+xDWNj7GHEHhHWIAQA3AbqomJ3UgTaoPq8fASmTw89YZG9dFp0W/05jlvtlGPimQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JW7oWzVd; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JW7oWzVd"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AD1QRH1694153
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 14:00:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=RuotT3PGDF3CPhlfZ
	xLPYzdPpPUcuvorKe1bZZNwWkE=; b=JW7oWzVdQ/iR89NYNnkZK/ijRD8lsDXp8
	3/RtbnA9s3C7Lp5K9wUvJWi4wTZIwpqw4/UNJjzVI+ZsAI+h0/5tmkCZbWjJsG2t
	Nex1/T1mVi84CzXCvCQ7aNoofM1ehRGrnS61MuiIsUvEHZXPCXwCLwdXqNhkupJb
	RAnK0ELRgQlw9QYyf0f5TaZuFquRqhcBW6Mx4zvx3c4xZEL5im6biBetR+jU9uhW
	/VdYng3SYcIAxrp+m1mgE/j3mZZtJK9g9g9udByjGvQVl0+eaTYPKqJAOvFuiXK4
	AipZ34fy9dUvtN696bTeMGDQolYPCSFrNW2fyUz+wnR9H2FgR21yQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvm9g9ye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 14:00:38 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67ADuI0h029539
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 14:00:37 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0g4vf5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 14:00:37 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67AE0X8w30605638
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 14:00:33 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC23320043;
	Mon, 10 Aug 2026 14:00:33 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 92FC320040;
	Mon, 10 Aug 2026 14:00:33 +0000 (GMT)
Received: from ibm.com (unknown [9.111.40.237])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Aug 2026 14:00:33 +0000 (GMT)
From: Holger Dengler <dengler@linux.ibm.com>
To: stable@vger.kernel.org
Cc: Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH 6.1.y] s390/zcrypt: Fix missing mem scrub at clear key import in cca_clr2cipherkey()
Date: Mon, 10 Aug 2026 16:00:30 +0200
Message-ID: <20260810140030.485804-1-dengler@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026080533-underfoot-yelling-55c0@gregkh>
References: <2026080533-underfoot-yelling-55c0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDExNiBTYWx0ZWRfXy5RCHb6j0vcr
 iDJdAzWd5XNL0fqjLxhSy9AZyTqsS3SBhYdlQXgdagyQg2+kBb9aiCxWSh4MSFfO2Iw/V9uXRmB
 0IPTaXGbqR7IDvSB2dIb/YI1AktGuk0qMyXrHTLwOgLKnCtmuckvk4Ak1cwhHO5hdWGI2/mqY4r
 pQcpy5tR3Gje8DAxkWR6CvVPjRdOSbvTToNOrjMIGpxI/8APebtJVbHhWscbmSXXNJDAEAceWtw
 465QmyXfoyT9QozdECiH2LXn+cLo+YACGVbrrW/Z5ADBcLVoiY/NdEytCy4auUZiTs/7ourYuZX
 9btleVxywNXmyjndnTIgwEAEmG2z9BxY9+FTXs6mPM4SAzk/LRgQCxQG3XjnJrFZQ7lOiMRQkDY
 WkDPs5wWT+4dSgv3QpKzXaEH7xYRp0NKmKKxM7CMFVDiKDjsapXBQTTaovFHoYsSzJyiCtLyPdA
 ezL6cxD/thN4HmcydCA==
X-Proofpoint-ORIG-GUID: A6SudIXF0vk6y45xFefvsvfD8Okvyaeo
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDExNiBTYWx0ZWRfX9a81O/1mwy28
 rJz4OyztiodqZ4A4ugslGAd/VZuMPW/dU4GzEpwV7peuTHbBp45AOPt3K/4ZZ+5mbULM5lr5QBU
 fpD78W34hxo798LawphrvT7cbFHSskA=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a79d986 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=l_XADsiG0JAIV5gd_FcA:9
X-Proofpoint-GUID: A6SudIXF0vk6y45xFefvsvfD8Okvyaeo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100116

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
index a2cea4f4a6b85..a4230d73b7b99 100644
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


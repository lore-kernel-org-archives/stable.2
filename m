Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793889880;
	b=gtuEzyidc6Gvr48RMIihpaU+kOle8vVtDcuQgcqto7OCbiW3kAY/ckJS2j6zl7BpAw1J
	 pDKx+GEXIdbt6jFznvo4RCKv+nITN/nIl1MUCUE/YJWuw9tfEXbX3YMCk1Ysd21VKWd6q
	 5T9EVDAHA9yrWt2ID7MiA9WRa0ifFJJO0DzWXeaxslJNS6fu2YaKgCfTHo5VLf8ZWfE6H
	 NP9Mv3AEHyP3g25kX3nkGTDZxYuPGzMe/iVNWoClyIxWWEZR43gn/aUMg+ORE5Le5DgX6
	 PqF2z3Fdcxiyn2W5/DoOKq8GAuARRhqBHri4wIdaWR/FgV4po7/f4jFImVjHrxg+nxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793889880;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Reinject:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=XlISgmGbH4GSY9/zf5L4adWYA03gtg65JNpjQqN6h9s=;
	b=VTbKqUngEayQMFpEWoAu0hv1xFRa69/0E2ES4KWSVAerC2Y6QA37VTcKOtf+G3CnhDwF
	 Ij4gUOeoW1hmMNPrUDdqCsalIcGcCWZSAP3s6eKwH4jp3FjRlQgyjvCJdiYa8pUB30xu+
	 sn7ardyugMUYeNQap+QpojqIuy5oqSCvrSkRMv3P0eO4stopCNnH++XdebMvN7ClilsHP
	 4VhQT24UXMbA3iPGnUSuGP+oWC4+GfXUfW5zCteT68m/U0jpDLMtjM7JTlp0k33hl3e4K
	 f2iduK2q2il58yqRPW+aEDxHqrnzLiEBTWnVj4WPDgiYKAc4rjXJeEb7fLQTyS7bXmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HtSwR+v7;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49905606A326;
	Thu,  5 Nov 2026 14:44:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49905606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HtSwR+v7
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5EiKHM4018508;
	Thu, 5 Nov 2026 14:44:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=XlISgmGbH4GSY9/zf
	5L4adWYA03gtg65JNpjQqN6h9s=; b=HtSwR+v7CAombAOi8vpmg8z5ZLTgvwt2U
	sUXe+knk+crVxzB+fqeKY1B0xtx+ns8NKelOmoa4g+2BjEAqIbTyA3yB3pqmlq3Q
	9ooEiQ/Doox7WeNCB0hK2Dw6fB6dzhLLDfwt/NU5wmd3lZOeLYJTRyY52MbJeGqV
	zz2h1K0H5UTqiSd4h4IHLE0X+1loJ+RcsYYTcntYOqzAvkZ4vnWb6wvE9xPNmvwk
	A+KDyL6h6hJcZID1yvo8KK36TXz0SmMImDj6h401v1iSldguu84tPvEmDKukFL+T
	0ILHrQ/+cIpCGkh3bZaHYFhmOYMweTI8YOHvaOS4p+rkm55bPPEew==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn7u3txm6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 14:44:26 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5EYvop1685696;
	Thu, 5 Nov 2026 14:44:25 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hrmrej3qm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 14:44:25 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A5EiLgR43254164
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Nov 2026 14:44:21 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E9832005A;
	Thu,  5 Nov 2026 14:44:21 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 819E62004B;
	Thu,  5 Nov 2026 14:44:14 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com (unknown [9.67.70.234])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  5 Nov 2026 14:44:14 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        James.Bottomley@HansenPartnership.com, jarkko@kernel.org,
        zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com,
        rnsastry@linux.ibm.com, ssrish@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v6 6/9] pseries/plpks: fix length types for wrapping operations
Date: Thu,  5 Nov 2026 20:13:17 +0530
Message-ID: <20261105144320.357260-7-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105144320.357260-1-ssrish@linux.ibm.com>
References: <20261105144320.357260-1-ssrish@linux.ibm.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Zsp4uN7G c=1 sm=1 tr=0 ts=6aec964a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=9fGkF-8gFJ1lMNA_rXYA:9
X-Proofpoint-ORIG-GUID: BdrmebKB_k7P-eebXYVT9tTOSSxCFsz1
X-Proofpoint-GUID: vnSFPbJxaz64XW2HziOQg8Kyjs5KHHNr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA1OCBTYWx0ZWRfXxn4uuCDvbBlq
 LT9uGjg1OEPveXXUyPsgBUJTcf385Cp21lo3rmurOPYDIKHWkcIqfk4Z/X5/S93mrR5Ho5t6w8o
 8SpCnxZmLZ3CFXVy0bAZ/Fad5kiHYwGnogqmFcNTV439N+O6FlRL8MlBRmjfZwa1Rk7wkfstfnC
 FnJJSxCt7Y7oAcldcylpHxAzSfRnkGvO3QbDAbYu4GiboxM+etjnSEu8oWA1GHicqBeTr5eMwCU
 4QqYE6JszAuWy7FpzFofkGo1LgCLi8xRfPZ2x6/AXdSgqWmgEVsjCLP4fyTxZvoCKGDD6i33Hqg
 TrJeL6k/rtDIlEO3wb9tE1/YLqR3lLXfmVIj6sZwc4s4wiJMXgoEpifcMryduZoXpYm+E+de5Ta
 riixiuKQKsoP9CAkendI/Vk94uLE1viuIjageeRTObXAdD7Qsh0POexjRq3JJgqiA80jRhxcbPU
 hDMz3xq555VWYcGajhg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA1OCBTYWx0ZWRfXxP4fj+ASe5yl
 7quFbUdRrb7hxaTotCI+JHwjw1fQyp3i7eSIJ8lGtXlUwMkwmR4AWUk8KmFeNFZnjGXmtfNwxBU
 l2A2pYIYcyPLTOsc/pNxroYqqc1FxTo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_04,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050058

The object wrapping and unwrapping HCALLs use 64-bit length values, but
plpks_wrap_object() and plpks_unwrap_object() currently use u32 for the
input and output length parameters.

Use u64 for the length parameters to match the underlying HCALL interfaces,
and update the PKWM consumer accordingly. Validate input lengths against
the HCALL-defined limits before calculating output buffer sizes.

Fixes: 133aa79e211d ("pseries/plpks: add HCALLs for PowerVM Key Wrapping Module")
Fixes: c99fcb0d735b ("keys/trusted_keys: establish PKWM as a trusted source")
Cc: stable@vger.kernel.org # 7.0
Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
---
 arch/powerpc/include/asm/plpks.h          |  8 ++++----
 arch/powerpc/platforms/pseries/plpks.c    | 23 +++++++++++++++++------
 security/keys/trusted-keys/trusted_pkwm.c |  4 ++--
 3 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/plpks.h b/arch/powerpc/include/asm/plpks.h
index e87f90e40d4e..8b2ffb27db5a 100644
--- a/arch/powerpc/include/asm/plpks.h
+++ b/arch/powerpc/include/asm/plpks.h
@@ -118,11 +118,11 @@ bool plpks_wrapping_is_supported(void);
 
 int plpks_gen_wrapping_key(void);
 
-int plpks_wrap_object(u8 **input_buf, u32 input_len, u16 wrap_flags,
-		      u8 **output_buf, u32 *output_len);
+int plpks_wrap_object(u8 **input_buf, u64 input_len, u16 wrap_flags,
+		      u8 **output_buf, u64 *output_len);
 
-int plpks_unwrap_object(u8 **input_buf, u32 input_len,
-			u8 **output_buf, u32 *output_len);
+int plpks_unwrap_object(u8 **input_buf, u64 input_len,
+			u8 **output_buf, u64 *output_len);
 #else // CONFIG_PSERIES_PLPKS
 static inline bool plpks_is_available(void) { return false; }
 static inline u16 plpks_get_passwordlen(void) { BUILD_BUG(); }
diff --git a/arch/powerpc/platforms/pseries/plpks.c b/arch/powerpc/platforms/pseries/plpks.c
index 376c50d459fc..d5adc563f71f 100644
--- a/arch/powerpc/platforms/pseries/plpks.c
+++ b/arch/powerpc/platforms/pseries/plpks.c
@@ -22,6 +22,9 @@
  * than the input buffer's length during the WRAP H_CALL
  */
 #define PLPKS_WRAPPING_BUF_DIFF	1024
+#define PLPKS_MAX_WRAPPING_INPUT_SIZE	(32 * 1024)
+#define PLPKS_MAX_WRAPPED_OBJECT_SIZE	\
+	(PLPKS_MAX_WRAPPING_INPUT_SIZE + PLPKS_WRAPPING_BUF_DIFF)
 
 #define PLPKS_WRAP_INTERFACE_BIT	3
 #define PLPKS_WRAPPING_KEY_LENGTH	32
@@ -989,7 +992,7 @@ EXPORT_SYMBOL_GPL(plpks_gen_wrapping_key);
  * plpks_wrap_object() - Wrap an object using the default wrapping key stored in
  * the PLPKS.
  * @input_buf: buffer containing the data to be wrapped
- * @input_len: length of the input buffer
+ * @input_len: length of the input buffer (non-zero, at most 32KB)
  * @wrap_flags: object wrapping flags
  * @output_buf: buffer to store the wrapped data
  * @output_len: length of the output buffer
@@ -1026,8 +1029,8 @@ EXPORT_SYMBOL_GPL(plpks_gen_wrapping_key);
  *
  * Returns: On success 0 is returned, a negative errno if not.
  */
-int plpks_wrap_object(u8 **input_buf, u32 input_len, u16 wrap_flags,
-		      u8 **output_buf, u32 *output_len)
+int plpks_wrap_object(u8 **input_buf, u64 input_len, u16 wrap_flags,
+		      u8 **output_buf, u64 *output_len)
 {
 	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE] = { 0 };
 	struct plpks_auth *auth;
@@ -1044,6 +1047,9 @@ int plpks_wrap_object(u8 **input_buf, u32 input_len, u16 wrap_flags,
 		.component = PLPKS_WRAPKEY_COMPONENT
 	};
 
+	if (!input_len || input_len > PLPKS_MAX_WRAPPING_INPUT_SIZE)
+		return -EINVAL;
+
 	auth = construct_auth(PLPKS_OS_OWNER);
 	if (IS_ERR(auth))
 		return PTR_ERR(auth);
@@ -1114,7 +1120,7 @@ EXPORT_SYMBOL_GPL(plpks_wrap_object);
  * plpks_unwrap_object() - Unwrap an object using the default wrapping key
  * stored in the PLPKS.
  * @input_buf: buffer containing the data to be unwrapped
- * @input_len: length of the input buffer
+ * @input_len: length of the input buffer (more than 1KB, at most 33KB)
  * @output_buf: buffer to store the unwrapped data
  * @output_len: length of the output buffer
  *
@@ -1145,8 +1151,8 @@ EXPORT_SYMBOL_GPL(plpks_wrap_object);
  *
  * Returns: On success 0 is returned, a negative errno if not.
  */
-int plpks_unwrap_object(u8 **input_buf, u32 input_len, u8 **output_buf,
-			u32 *output_len)
+int plpks_unwrap_object(u8 **input_buf, u64 input_len, u8 **output_buf,
+			u64 *output_len)
 {
 	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE] = { 0 };
 	struct plpks_auth *auth;
@@ -1154,6 +1160,11 @@ int plpks_unwrap_object(u8 **input_buf, u32 input_len, u8 **output_buf,
 	u64 objwrapflags = 0;
 	int rc = 0, pseries_status = 0;
 
+	/* outlen = inlen - 1KB must be non-zero */
+	if (input_len <= PLPKS_WRAPPING_BUF_DIFF ||
+	    input_len > PLPKS_MAX_WRAPPED_OBJECT_SIZE)
+		return -EINVAL;
+
 	auth = construct_auth(PLPKS_OS_OWNER);
 	if (IS_ERR(auth))
 		return PTR_ERR(auth);
diff --git a/security/keys/trusted-keys/trusted_pkwm.c b/security/keys/trusted-keys/trusted_pkwm.c
index be69d2b6d46b..b5c3d17be475 100644
--- a/security/keys/trusted-keys/trusted_pkwm.c
+++ b/security/keys/trusted-keys/trusted_pkwm.c
@@ -83,7 +83,7 @@ static int trusted_pkwm_seal(struct trusted_key_payload *p, char *datablob)
 	struct trusted_key_options *options = NULL;
 	struct trusted_pkwm_options *pkwm = NULL;
 	u8 *input_buf, *output_buf = NULL;
-	u32 output_len, input_len;
+	u64 output_len, input_len;
 	int rc;
 
 	options = trusted_options_alloc();
@@ -130,7 +130,7 @@ static int trusted_pkwm_seal(struct trusted_key_payload *p, char *datablob)
 static int trusted_pkwm_unseal(struct trusted_key_payload *p, char *datablob)
 {
 	u8 *input_buf, *output_buf = NULL;
-	u32 input_len, output_len;
+	u64 input_len, output_len;
 	int rc;
 
 	input_len = p->blob_len;
-- 
2.52.0


Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB63D3C3C06;
	Sat, 17 Oct 2026 07:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792223393; cv=none; b=vEvTvtLjeHAzW+pEDffWKhGIO6MQSQ1fwZJpZtTYLLvY75354OkU2ZZOYRd67ySgWqmp5tbVhGeSg2LlSURQzl6nrajnFz7wR2ZqoH5AildzN8qXyCjoltmbO73DhHWRejRDMt/TCbk/fELm0PIjny3E5kZ7tZ3xlpTQEb1M1BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792223393; c=relaxed/simple;
	bh=Hm5b4qV1VtdUbHOT/iyP+8fVMDl95Og9Yf5PMbDqzLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T2fNVCkIxUVdswdhMSNfnT0JcLWgj0a2NlPwQBVnMg3XMc6tNGw45VUCdcniH8DIIskV99isvKpMBTiqzxPy6QWBlojVcn8oWp4bYf+iUX/bqk99QELhi56dG7xzn+D75kpZoDscoiYasOFw1Crxrmof949qv/wNBW1lMD/5UAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SyU4AfGx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SyU4AfGx"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69H7EEE61852182;
	Sat, 17 Oct 2026 07:49:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=3g7u/kzbVYw3Buob8
	L/ltyatcZL9WPFXqQBV1rdUaRI=; b=SyU4AfGxHFfF2AQ09fqKEn2TknS0Y3R6J
	Avg8knuQLxUUEqWsp+n+5ESRpeXJDHvfj5JogMOpkXUVT/LohDVJLNZ+hAeV9aB4
	P3JIen3God0PVhujGZFqTJqZgxpl67dTpLJNimGxN8xeWCeEp9THhfTpghYRPOEG
	s2VFZu9LNy46NGK+dgJZR0uFBOZ9DTAPHFjQveTF1GgwLC3oCL3LED2symWQZvKm
	JIIMeLmvIY8mn2NnW8J7R2yQ6GwaD5Nx6ORkID5mllVExWutfNgx0ePk18G4kyw2
	FOdCbTQtwHbqWHwNRWiAHAF2Ub8AjFG73CW/mr+3pANSNGrwy75YA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hc0nvgq6x-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 17 Oct 2026 07:49:23 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69H74mIK671617;
	Sat, 17 Oct 2026 07:49:23 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hbtqc9r66-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Oct 2026 07:49:23 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69H7nJnP43844006
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Oct 2026 07:49:19 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 072FF20043;
	Sat, 17 Oct 2026 07:49:19 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 504FD20040;
	Sat, 17 Oct 2026 07:49:11 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com (unknown [9.67.66.83])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 17 Oct 2026 07:49:10 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        James.Bottomley@HansenPartnership.com, jarkko@kernel.org,
        zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com,
        rnsastry@linux.ibm.com, ssrish@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v3 1/6] pseries/plpks: fix length types for wrapping operations
Date: Sat, 17 Oct 2026 13:18:45 +0530
Message-ID: <20261017074850.164031-2-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261017074850.164031-1-ssrish@linux.ibm.com>
References: <20261017074850.164031-1-ssrish@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE3MDAzMCBTYWx0ZWRfXzr6ojkU2StaM
 F1HiqawgksVosaq7fqokqZg+Y74g8SB6GZoU9qcjgmdbU1jyXW4inDneIGh8JdSTRZUYBYHN0s5
 nlmk0ZyGAbBqgMQxBMkueDHwjDCJZK8=
X-Proofpoint-ORIG-GUID: DCrk5AcnmkMnfswE9gCMMixC6-EnCkMF
X-Proofpoint-GUID: EtezCY9-VN5Xouvw0FfJVRFaKrqut3MV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE3MDAzMCBTYWx0ZWRfX42U6W3Cw48Yu
 smrEM1nI1tzEi9o3TEyXIwqnNrLKvm6NRs3BHZyuP71N1PMokYJipDcrpVcmXHqn0eGVaQHvrEy
 5lh8Wz54z4KatzTnvSZQISegRWnS9K6/B2+X9ilHA2iSWVmyr/Y8G4uD/hp7RSEga3UoxShc1uS
 Om7rrRJJ+P0WfEIMWJCJ+MCfPj/TGKA4KdZ/3gBmKhg1aTx8uzEqirg/JxEa7kwLt0alxBq81jq
 sZAxbJ16np63DmRTwS6MTdtgsdwdUropV9jBY/iW5UTZUUBIhu4grzbgq/RCl5w/MRReTJS7zCZ
 xSEX5y4hAD9hd+4JnxbW6L2qSuWg+uRcm/2cfnv9yEnAYMxxviGv654/nNA4moZIovYrB4JiJnX
 bFmwXVjk0WbG+sZi+Y1nm7jAcKYcIvpDToxExiyLfX2S9k7jkGrU4sDDL129j8eRcASqTzHhT7L
 id5flc+LMTxDLg5Zm+w==
X-Authority-Analysis: v=2.4 cv=MY35KJ/f c=1 sm=1 tr=0 ts=6ad32884 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=0P1reCDcYORL6uZRMdUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-17_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610170030

The object wrapping and unwrapping hcalls use 64-bit length values, but
plpks_wrap_object() and plpks_unwrap_object() currently use u32 for the
input and output length parameters. As a result, the interfaces cannot
represent the full range of values supported by the hcalls.

Use u64 for the length parameters to align them with the underlying hcall
interfaces. Update the PKWM consumer accordingly.

Fixes: 133aa79e211d ("pseries/plpks: add HCALLs for PowerVM Key Wrapping Module")
Fixes: c99fcb0d735b ("keys/trusted_keys: establish PKWM as a trusted source")
Cc: stable@vger.kernel.org # 7.0
Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>
---
 arch/powerpc/include/asm/plpks.h          | 8 ++++----
 arch/powerpc/platforms/pseries/plpks.c    | 8 ++++----
 security/keys/trusted-keys/trusted_pkwm.c | 4 ++--
 3 files changed, 10 insertions(+), 10 deletions(-)

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
index 240cd5632446..a7953db3f23a 100644
--- a/arch/powerpc/platforms/pseries/plpks.c
+++ b/arch/powerpc/platforms/pseries/plpks.c
@@ -1021,8 +1021,8 @@ EXPORT_SYMBOL_GPL(plpks_gen_wrapping_key);
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
@@ -1140,8 +1140,8 @@ EXPORT_SYMBOL_GPL(plpks_wrap_object);
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
diff --git a/security/keys/trusted-keys/trusted_pkwm.c b/security/keys/trusted-keys/trusted_pkwm.c
index bf42c6679245..b6b5697426a8 100644
--- a/security/keys/trusted-keys/trusted_pkwm.c
+++ b/security/keys/trusted-keys/trusted_pkwm.c
@@ -83,7 +83,7 @@ static int trusted_pkwm_seal(struct trusted_key_payload *p, char *datablob)
 	struct trusted_key_options *options = NULL;
 	struct trusted_pkwm_options *pkwm = NULL;
 	u8 *input_buf, *output_buf;
-	u32 output_len, input_len;
+	u64 output_len, input_len;
 	int rc;
 
 	options = trusted_options_alloc();
@@ -130,7 +130,7 @@ static int trusted_pkwm_seal(struct trusted_key_payload *p, char *datablob)
 static int trusted_pkwm_unseal(struct trusted_key_payload *p, char *datablob)
 {
 	u8 *input_buf, *output_buf;
-	u32 input_len, output_len;
+	u64 input_len, output_len;
 	int rc;
 
 	input_len = p->blob_len;
-- 
2.52.0


Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150B7310784;
	Sun, 18 Oct 2026 17:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792343389; cv=none; b=kpZMkFhCu4ad1fiPBKOAQP1iRxbCYqziUsBTsRaHT6zMpIiRwcN73wWzfWG6YEedvCsziVk1xUIXltguMdkdkxib30wxJEKEcGUGcJeSOnqAjihV8KuOtV+2Gp1wp+FOPAas+Zc0m9x5IVGIdYXVP33y+ERyVn+McM/iTjgKxYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792343389; c=relaxed/simple;
	bh=/IO9vaCvSztevTIuZALl+x3FaHdbuGxC1I8sDId8FWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RMJ0bvyiQHRkbVvHKzHhja/Sob0c46C1zysy/nFmV+/Vn2ibPCJgr7EOO4xjMEGG5HznAZiSVZZXQouRbd7glR6zTdqzEeYkgiuhhthob2hM06zb+t6Sjzwx8igzTeguJ2SH1u3AaJww+hFxW7n732L8I/2+GHgA/vv1faFsBUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Pus/ayNH; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Pus/ayNH"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69IFE8Hs128218;
	Sun, 18 Oct 2026 17:09:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=odmfd7BH8pwt0sHLO
	ZYJYefMYhIJv8ux1W3nzsIhL2Y=; b=Pus/ayNHWDQ0QWYbqZqJSrI0nKOKUvoQ6
	jtOxP7bPH1NSgQhsPusNPWJ/Ex/Hsqndupx1DScpEHzmxOuoa8IHaan1JW2vUDLt
	fTNKC6ax4lxZmb7n2ws29XNZJYE726eFBsNb8FZY3EQZkhhSrEJyZaA+acFqqB1p
	nPygYzJAMccTZZI4iKs2YUqjjmzJOwSRHS1Hd2JFDxGeG7tmL/F9yKJsPG9/uiDU
	kWRdrYrtmGM3/NmPQEDfCGgoxbkU/3InMxzxXrz+MSz/66bD8oa95w03iG7uUHbH
	cT3LqLmSsEhfRNVDu2kzIRVxFNghT0+Gzw7KKtAl9GZYD2lNoyZpA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hbyepp98p-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 18 Oct 2026 17:09:33 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69IFJsLE1540927;
	Sun, 18 Oct 2026 17:09:33 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hcnjgt0kf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 Oct 2026 17:09:32 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69IH9Tka29229332
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 18 Oct 2026 17:09:29 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 48AD42004B;
	Sun, 18 Oct 2026 17:09:29 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4CC9C20040;
	Sun, 18 Oct 2026 17:09:22 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com (unknown [9.67.125.165])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 18 Oct 2026 17:09:21 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        James.Bottomley@HansenPartnership.com, jarkko@kernel.org,
        zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com,
        rnsastry@linux.ibm.com, ssrish@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v5 3/9] pseries/plpks: fix length types for wrapping operations
Date: Sun, 18 Oct 2026 22:38:38 +0530
Message-ID: <20261018170844.491252-4-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018170844.491252-1-ssrish@linux.ibm.com>
References: <20261018170844.491252-1-ssrish@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE4MDA2NiBTYWx0ZWRfXx1oXyUO8Um2K
 AdTo5ZBtaS17dtJEh94ncu+U78JqSmC86bQAvoHqK7NzH0v3hYNXv6Swu+GLaen3KmuCO0t3ZtI
 jGPaCh3vXCv+hKEqaMgccjzFO5h63Jk=
X-Authority-Analysis: v=2.4 cv=Z4R5j3RA c=1 sm=1 tr=0 ts=6ad4fd4e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=IcTAXs86i-CeFwNiEvsA:9
X-Proofpoint-ORIG-GUID: hrveyE5jGh1Fd4uAFIw9ZSQsJRQ4vEAl
X-Proofpoint-GUID: -5B1YpO4Rssi-R3QCwr7KuYkQSg7aOtp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE4MDA2NiBTYWx0ZWRfX5kwZWn06y2b8
 oAqCYLnq7Pq2twlAvP3aKfn9hNAStAxJzKGPVEf2pn5J7LCCm42GnAaOdG67nmIDLAlV0va6hBZ
 q8NFvQn7aovF4PD0sWmh0NVYRtP0OqHoJ0P9dvCizCSEmT/WXn9T30QpQ9jFTDXRt3keuBW6n/i
 EY8QbON8GUZAYjpzmhN02E6RHqraeFtjP2U3dKeLVIK7W4Niowrg76nzZesNn5y2+zEiIRfVZhs
 yue1YZwiGqkSeae/kycMVsRIX08Ef1m/lMFyDdbchXp6wl/Smb4k02uVeWGGnGzgjDaabaw7wuJ
 9p1gTwH4fpFzmSzzMcczKSIIhUxjIOBkIWuQd2PnVI8eVxFnLUTENDFoq3YgOEIY/ESPWfLMTSV
 x5s3WTKgPPufKX2aEoMXZ1x0Hk5/sQiZd0SMsjKVmqCnmNWkzRolUJkaTZ+8eHd6UH6lPM09WHn
 /EvFxu+ugYalNnaMeFA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-18_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610180066

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
 arch/powerpc/platforms/pseries/plpks.c    | 18 ++++++++++++++----
 security/keys/trusted-keys/trusted_pkwm.c |  4 ++--
 3 files changed, 20 insertions(+), 10 deletions(-)

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
index 584091f9aa08..ca750c250374 100644
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
@@ -1023,8 +1026,8 @@ EXPORT_SYMBOL_GPL(plpks_gen_wrapping_key);
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
@@ -1041,6 +1044,9 @@ int plpks_wrap_object(u8 **input_buf, u32 input_len, u16 wrap_flags,
 		.component = PLPKS_WRAPKEY_COMPONENT
 	};
 
+	if (!input_len || input_len > PLPKS_MAX_WRAPPING_INPUT_SIZE)
+		return -EINVAL;
+
 	auth = construct_auth(PLPKS_OS_OWNER);
 	if (IS_ERR(auth))
 		return PTR_ERR(auth);
@@ -1142,8 +1148,8 @@ EXPORT_SYMBOL_GPL(plpks_wrap_object);
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
@@ -1151,6 +1157,10 @@ int plpks_unwrap_object(u8 **input_buf, u32 input_len, u8 **output_buf,
 	u64 objwrapflags = 0;
 	int rc = 0, pseries_status = 0;
 
+	if (input_len <= PLPKS_WRAPPING_BUF_DIFF ||
+	    input_len > PLPKS_MAX_WRAPPED_OBJECT_SIZE)
+		return -EINVAL;
+
 	auth = construct_auth(PLPKS_OS_OWNER);
 	if (IS_ERR(auth))
 		return PTR_ERR(auth);
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


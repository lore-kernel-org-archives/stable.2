Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793889875;
	b=axKjh5nHhh0y2UOLqBnE1XLZ4YWrhOexjLdIysRdF5pePtjMFTYSXhRrSuPamTQDRoIU
	 yrKg0mOJd7NwK9CZNLyKcw53ORBu3gqwpnHhw0TEyt4iJQYgKHLT+8WRiWcwS7wjg+9iR
	 YGgsX3JZujdCdX7yvtbvEn5vq0pfXzTmnBuM3xKP8Yp25aeqVegb74bLum7blrBXpMOnD
	 wRnD/y6bjJCGu9OG+3tgRD2IPtN1j9gKET2U9ul7R21gASlMAvXxSNKzwvH2DpnmDzM56
	 nXA2utpA8qJuG9V/2zDfxzauETQpfTmQyu65GsG0VzAFOhtNbKk3caqhJ5kKkqWD74Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793889875;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Reinject:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=S2mY3fzlFrSjrdoKMp+IDYQG02ytYNJmLbcWwcNkJ6U=;
	b=n7st3eVyzlggIlmir/X+coyT/PTU+zKCfeSB3qmh1kEjjx49QnD+Jy+n8kiqhFgAJiv5
	 XUzPbfqVxvzReRfCkwMP5rFibHmhb7JIrZVkqmUOQLtgbFZEzttkkihC3229Jw7rXuZ88
	 8fOujl1KRd1f6pburF6wzQGzo5Qa3KXEWeVSY5PV75AzE600R6pkBP61U0Rtwz/6JwiYo
	 RNoguRKtGcXZT+W1rQ4d0J1qoIrdkLGIFbFmqXB1QOa17kFXn7LY17XNkB+iwEoCKITbU
	 JWeMObl+PSXP5tbihNitYqiiF+yYA3U4RoJECTTAh/bR3VXUAYs1u+PHMfZE33lv/QA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hAhFZBnZ;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BCB606A32F;
	Thu,  5 Nov 2026 14:44:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84BCB606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hAhFZBnZ
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5EiFr42627275;
	Thu, 5 Nov 2026 14:44:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=S2mY3fzlFrSjrdoKM
	p+IDYQG02ytYNJmLbcWwcNkJ6U=; b=hAhFZBnZHohsZ9TUw9kXqfSr72BW9eryp
	Cy+1D621np4vIaOFhrqptiy/toZWARHgC1LiJaEAswwBbe3CuQQfhRgkNY/LkzVU
	oMnCbdciO7FxnjzwTN9L5A8oeaaS1aNpb3sObimjIM0JfHko51C6y8mIWOwqwbSg
	ESpPuWbRe3SPfG6/PU1ROh4/+C2QC3yNtSvyvcDwNnM0zFVlCuTSvKbDq47xyKtU
	DPM8Fu5kZPwpOsPkNSlMntNjSEfSRluDCXyG4hNZOJudWylJxgPEghu7ecjUIZRP
	oE3zmhWKWEmKD2+HCmkm2qX3x2DaSesELiE+4ce9TL6w/Jg8jGjzw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn6rdjfc5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 14:44:17 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5EZ3bU1796732;
	Thu, 5 Nov 2026 14:44:16 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hrka6teec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 14:44:16 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A5EiCEq31785484
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Nov 2026 14:44:12 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A99822005A;
	Thu,  5 Nov 2026 14:44:12 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B45ED2004B;
	Thu,  5 Nov 2026 14:44:05 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com (unknown [9.67.70.234])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  5 Nov 2026 14:44:05 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        James.Bottomley@HansenPartnership.com, jarkko@kernel.org,
        zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com,
        rnsastry@linux.ibm.com, ssrish@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v6 5/9] pseries/plpks: fix double conversion of wrapping key flush errors
Date: Thu,  5 Nov 2026 20:13:16 +0530
Message-ID: <20261105144320.357260-6-ssrish@linux.ibm.com>
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
X-Proofpoint-GUID: 4iNfgPRtw_HeEea_glZe2ZSrmq7SqFrg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA1OCBTYWx0ZWRfX/VjGjFqt2UtG
 2jW8UoYGUel6R98QZ732DqgkXZrJAF0tT5bd+/9Sdcmbm9wO6L117O06rDTs7C17I2Z++Fbz8Kc
 TFmqNKj+ua4qCvHZ9vkVAAxmwuuqm9plignuJTc0f8ol9g5dVc3GVlMHFXzIwpwH5eDeSW76V5O
 VWmCz2qjSfWkwWjuWF/onSO4lLcQRi4eGB4kBbQjg6mFShRFdriMtVICA2cNF/fibsrJPBqvqZD
 Hq0QkykNT1VDglSXn7fPlBcuz1dbdmhnWOEDiC6dKleNa9dw3h8x8J2h35eEAfrFsnkNTmrgpK8
 6l2y8kOLevvBjp5bVtwaaEye36Q7HsVVSx42W5Whx59qeR/sQYC8hiAYjuFkRJmrnGsHY+ayiLB
 j7Y2A4wtWr74q424cwAm4IMYtmPyLTMMCQ3+AdbIBKpV1fDA2JvNCdkIiQzDbZT1G9NyaQJ90hH
 VO73kDZO1R8Y2NXFFTA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA1OCBTYWx0ZWRfX71hVxA5JAXpB
 WTNW9Qj2A4KOuqkNQ3Ta5aFBIE3MxSSTEF1ysFEc1XgshZCuEBkm3SB58wv0wCxRLlHuqFGro8e
 kOWyVk2FFr8y09FizoTTJbKBu7w72h0=
X-Authority-Analysis: v=2.4 cv=QK391QLL c=1 sm=1 tr=0 ts=6aec9641 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=vpVMPqmk0RDRli2XWrYA:9
X-Proofpoint-ORIG-GUID: cFGEeR14gMPVDJkaJKLJhUibc-yWkPhq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_04,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050058

plpks_confirm_object_flushed() returns zero or a negative Linux errno.
However, plpks_gen_wrapping_key() passes this return value through
pseries_status_to_err(), which treats it as a raw hypervisor status and
converts it again.

Convert only errors returned by H_PKS_GEN_KEY, and propagate errors from
plpks_confirm_object_flushed() unchanged.

Fixes: 133aa79e211d ("pseries/plpks: add HCALLs for PowerVM Key Wrapping Module")
Cc: stable@vger.kernel.org # 7.0: a2df535d9dd9: pseries/plpks: rename the default wrapping key macro
Cc: stable@vger.kernel.org # 7.0
Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/plpks.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/plpks.c b/arch/powerpc/platforms/pseries/plpks.c
index 110251914b51..376c50d459fc 100644
--- a/arch/powerpc/platforms/pseries/plpks.c
+++ b/arch/powerpc/platforms/pseries/plpks.c
@@ -932,6 +932,7 @@ EXPORT_SYMBOL_GPL(plpks_wrapping_is_supported);
  * -ENOMEM	if there is inadequate memory to perform this operation
  * -EBUSY	if unable to handle the request
  * -EEXIST	if the object label already exists
+ * -ETIMEDOUT	if the object was not flushed to storage in time
  *
  * Returns: On success 0 is returned, a negative errno if not.
  */
@@ -940,7 +941,7 @@ int plpks_gen_wrapping_key(void)
 	unsigned long retbuf[PLPAR_HCALL_BUFSIZE] = { 0 };
 	struct plpks_auth *auth;
 	struct label *label;
-	int rc = 0, pseries_status = 0;
+	int rc, pseries_status;
 	struct plpks_var var = {
 		.name = PLPKS_DEFAULT_WRAPKEY_LABEL,
 		.namelen = sizeof(PLPKS_DEFAULT_WRAPKEY_LABEL) - 1,
@@ -964,17 +965,17 @@ int plpks_gen_wrapping_key(void)
 			 label->size, var.policy,
 			 NULL, PLPKS_WRAPPING_KEY_LENGTH);
 
-	if (!rc)
+	if (!rc) {
 		rc = plpks_confirm_object_flushed(label, auth);
-
-	pseries_status = rc;
-	rc = pseries_status_to_err(rc);
-
-	if (rc && rc != -EEXIST) {
-		pr_err("H_PKS_GEN_KEY failed. pseries_status=%d, rc=%d",
-		       pseries_status, rc);
 	} else {
-		rc = 0;
+		pseries_status = rc;
+		rc = pseries_status_to_err(rc);
+
+		if (rc != -EEXIST)
+			pr_err("H_PKS_GEN_KEY failed. pseries_status=%d, rc=%d",
+			       pseries_status, rc);
+		else
+			rc = 0;
 	}
 
 	kfree(label);
-- 
2.52.0


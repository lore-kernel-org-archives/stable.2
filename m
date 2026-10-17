Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835D13D8107;
	Sat, 17 Oct 2026 18:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792262391; cv=none; b=ooecND+VsWiDSXTMtXeg24VU97RGzVrp0rnwHiHKEme28vZHV0XS8kqRFLc6UMK7WGAYZJbASvm4ilMDixVZ5BGJoVw9XGYGHLLZSItbwZciDbLUmO2mAISL6KsbqOO/6faIYKc/0klFqolG3JLP+Gz3sD9MuIOyiulnBI+TNYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792262391; c=relaxed/simple;
	bh=VsO2aNmSAZlLTB2fYI8YlJFL96QnI6fSHmjTjUffMUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RcA+XO6azSUSx7fxeLKnII+rw83g+E20wHDiRISWdx12OMyvElr6arzpcumUE5Kgvv80XL/5h4821+AmUGx+yEJcAP9iE9yIZPKk9G/zAPpU1s0Lvj2mwnRWfQSOJMNPXZwWNVKCCw85r/tI37A5RpITdTabx+EUmyyfc/lJamk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=b41TU9B8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="b41TU9B8"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69HGER8g1132050;
	Sat, 17 Oct 2026 18:39:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=FOmFE1eAy1JYG1JSZ
	WLrqiHrDucGdCxWhppEPzq+Sg4=; b=b41TU9B81gfP8Nji8pvxIrwddcMiw5pB/
	Z3d0hcDvuxmEo4JZnuaHqOIwHmnDfkdMH9Hi1fJzVLNQLUX2iN0QFGGjVOUJKOft
	59jYusMl20qpAV6DFFNsvUnhYFyvMboC++3D6H5lFoeQ4EP8uA+nivvuEg9i6VWw
	HKM7zKEiQ7K04Jc8b9VbHR0WKO69z6xYIJFksnUR4qmOYyWRwmpyxjD5Jg1Em3bK
	/NlEpGlV7a4aK0y9uLnmKlpM7FR+MX3y1r8DVwrAyv4vSVdRnLpc52OqYkUk5pDf
	E1TvpO2rWOORmBXozZXsPjaoB8xKu40/fhNavYd0YDChsTT1UE72Q==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hc0ptarud-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 17 Oct 2026 18:39:30 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69HGK4Tf1319256;
	Sat, 17 Oct 2026 18:39:29 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hawqx1wht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Oct 2026 18:39:29 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69HIdP5i42729774
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Oct 2026 18:39:25 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7144F2004B;
	Sat, 17 Oct 2026 18:39:25 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DBEDE20040;
	Sat, 17 Oct 2026 18:39:18 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com (unknown [9.67.66.83])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 17 Oct 2026 18:39:18 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        James.Bottomley@HansenPartnership.com, jarkko@kernel.org,
        zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com,
        rnsastry@linux.ibm.com, ssrish@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v4 2/9] pseries/plpks: fix double conversion of wrapping key flush errors
Date: Sun, 18 Oct 2026 00:08:46 +0530
Message-ID: <20261017183853.596052-3-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261017183853.596052-1-ssrish@linux.ibm.com>
References: <20261017183853.596052-1-ssrish@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE3MDA3MiBTYWx0ZWRfX3m2fy3L1l+py
 cP5Ua3zajs1sW/aP73c2ESEt2j6ShklByhzQqVoqcde5kY5MdqS8fepuT/AqO6GXGfgJDmyylW0
 xl+EykpPJcCh4h5v71LZGtxzL6Ix6Ry+bbNlh85/kkd0keJMIXgNYQTp/ELBpM0a4JLx8ZEDozi
 8ssyvfIDFNUo2g1ESFx3RGMBPr1h9nm31vz5j0pzXCifDReDbSxk6Ff7Xmr1kjCrV3TW3lo2kXc
 qIvpJbcbwVMyQqs6xdo6im+DEOGCM9TXHc1h4aJznTcuMvj8nJ1UGe0v598MTuZpCVYnBQvx9eu
 Jg12ayBnHb0FrIiGwK48eF3bsMEA3ObDVDI5OGCkNdMT4p74ktmgWAZJKiS4JGutrGMdcNoKnvs
 nkI3ixKVUU1zd4H76L8LT8OYYRbEYzyPiplaJqGUcG2r2zkUuqVTBqMFHPNKhNTo4C10xM39Tvq
 r1RZ7sbtyK7wHfcc38A==
X-Authority-Analysis: v=2.4 cv=WNvqzXsR c=1 sm=1 tr=0 ts=6ad3c0e3 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=7zoujJ_n9ZNfRkIbun4A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE3MDA3MiBTYWx0ZWRfXwZsq/pEZ1pO1
 3WDudv2A1SqtXn1IhuAQMDuzSv+QXtcM8ClI6Jrfv9RrN1mY18dWrZ3PK9G7kvmSx+aVGTDL7VH
 OR1vXK+xnNeOetKrsHeHm5yFyiGwBwE=
X-Proofpoint-GUID: EhDTSU_Ez7HDK_SU2wA58i6nlfkN2MP9
X-Proofpoint-ORIG-GUID: FM5Pu9eF1j38bhGNw0HoOdHlb_0xMcZ1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-17_05,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 impostorscore=0 phishscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610170072

plpks_confirm_object_flushed() returns zero or a negative Linux errno.
However, plpks_gen_wrapping_key() passes this return value through
pseries_status_to_err(), which treats it as a raw hypervisor status and
converts it again.

Convert only errors returned by H_PKS_GEN_KEY, and propagate errors from
plpks_confirm_object_flushed() unchanged.

Fixes: 133aa79e211d ("pseries/plpks: add HCALLs for PowerVM Key Wrapping Module")
Cc: stable@vger.kernel.org # 7.0
Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/plpks.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/plpks.c b/arch/powerpc/platforms/pseries/plpks.c
index c86960f102dc..584091f9aa08 100644
--- a/arch/powerpc/platforms/pseries/plpks.c
+++ b/arch/powerpc/platforms/pseries/plpks.c
@@ -938,7 +938,7 @@ int plpks_gen_wrapping_key(void)
 	unsigned long retbuf[PLPAR_HCALL_BUFSIZE] = { 0 };
 	struct plpks_auth *auth;
 	struct label *label;
-	int rc = 0, pseries_status = 0;
+	int rc, pseries_status;
 	struct plpks_var var = {
 		.name = PLPKS_DEFAULT_WRAPKEY_LABEL,
 		.namelen = sizeof(PLPKS_DEFAULT_WRAPKEY_LABEL) - 1,
@@ -962,17 +962,17 @@ int plpks_gen_wrapping_key(void)
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


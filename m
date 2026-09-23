Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6494A0EED;
	Wed, 23 Sep 2026 18:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188153; cv=none; b=XVGPzu742EKWznTiEtTq039AnAzjkK6/2prNxuXMfC47CBOnlFKpb6b3BD2tyJM5cqelyAZxupiV8wIXWvLIo6fgYBWq5SpvGj9jU4U19RKxLvgQ4r5wKmF2OiBbrZUGO2AmtPr+EhvXfmnsbtNegn9T2fWdEyChoJcVtObat1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188153; c=relaxed/simple;
	bh=egPyPSMytQkU/uhH8h/JTmuFUeEtv2s+PSJRuV7Xdg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UDmbHqAnhbjwD3vmuy+k5M+V3y59KL6iU4skToVd7qWLZ9TOOMH+3KwpITO+sh0U1M/ZpSsuqeUQTlTZLbQpELSy/qlchKCcQ8I3NL9C4wmykng20QyoCZGnMhAk2yYYYlCGSOrNDoyFL1iqq8LTW2dsL/jTCdia7jRsLkf6lYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bz+XIa5S; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bz+XIa5S"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NGZOLP2048265;
	Wed, 23 Sep 2026 18:28:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=gO7WMLMxLCLeKAuVc
	bRabWl9GxDrv3S61aRQovTiWdY=; b=bz+XIa5SVYh9bAfpzQFz9s3p2ufZ+HuVf
	7oItWKcmq+qBfN6L+vn3ED9xlmkfC3uAIVOB5MezBUwdtNtdf/FXvG58PKbf/Z6E
	iM1Hx/ItVKYpEkq+CaesG7a0hUaIkfENTal1jzB9ic0s3euAMB2vcLMLyOUvJXAN
	iHmYLqzSXuZu//qTlme7e+QBDzXLs8IBxW39SpbLDAz7ns1JkHFAfphbThiYVxg3
	CMCQ1i6CGXQI2uBQpGnNMz38kHYZnuxZoY0yDGLc7r9fIeGrgDfSCG/75htscL8V
	ePCJyaF91sw2VEV5D77RTjq8I4GqVvILbBe7jLXMuK7CTZVZat9ng==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1vy2y-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 18:28:58 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68NGWtuP664875;
	Wed, 23 Sep 2026 18:28:57 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbe1t99x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 18:28:57 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68NISrVV33489280
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Sep 2026 18:28:53 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 86F7320043;
	Wed, 23 Sep 2026 18:28:53 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D71320040;
	Wed, 23 Sep 2026 18:28:48 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com (unknown [9.67.83.254])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Sep 2026 18:28:48 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, nayna@linux.ibm.com, gjoyce@linux.ibm.com,
        ritesh.list@gmail.com, sshegde@linux.ibm.com,
        linux-kernel@vger.kernel.org, rnsastry@linux.ibm.com,
        ssrish@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH 01/12] pseries/plpks: fix error handling in plpks_read_var()
Date: Wed, 23 Sep 2026 23:58:05 +0530
Message-ID: <20260923182816.151451-2-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923182816.151451-1-ssrish@linux.ibm.com>
References: <20260923182816.151451-1-ssrish@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: dDqJ8daWDB0lJWgwI9pe4Ip3naXO74It
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab41a6b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=gFDXozieBbrukydjEA0A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA3MiBTYWx0ZWRfX1QAHR6kOrAaP
 xKXN29oAKKj/BNWp1PSp8wcYEMrzBDVZBu1p+/047bmj41n/s2C5PrP64fLKMNUmEOCOEUJ3cKo
 XPtudeqj4qbE29UPHKIaqozE6lHDzNY=
X-Proofpoint-GUID: A7C0g6-MtWkuF4Iy1IulKj_L6ifq3Z3i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA3MiBTYWx0ZWRfXzfwtsxil7Ggt
 xqsFb78EdMGmsW6GbWuiLkm9neEsKQf/kEzhw8V6n3/+qZ/riDEhxVIMkEV0zXF9lCY2qf/4r2I
 z/F9ir02vpiNGwBkHk4whHSS5pAF7C9luto7aU9SGa/c45KRw1tL9iY9+3h+IivQB0ppEDagVwr
 6f8DR1rbj4KydLJSrysc/5Cb4SBY7Yi8Mvo9ABL8RZUs6oAH0mXDu4v/3RjoZo/2tcTCBJGLryA
 4OAHR7e68df9wdXm+kPsaAZE/r6vmfkdTjbKGED6xr7i/yGzwSXDsqOW+S6DvJHAingYa35cI3z
 XPM/sScSJ/AtlqjwXUcCtwIOIoSRHhj+tiUj9cH4oxLjxEqI1qmhgzJjVlwQxSE8HEyAlloB6Vs
 JQJW462SllRO3u0wWNVjHagsKuDN5CCFeaWzcBRbZrsRCzxgBRV871LViLfwLnBFr30wUjr3d9F
 DBRk1HuCGY3X63tvTUg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230072

When a PLPKS variable is initialized without a policy and used to read an
object with the PLPKS_WRAPPINGKEY policy set, the hypervisor returns
H_AUTHORITY along with the object's policy. However, plpks_read_var()
currently treats this the same as any other H_AUTHORITY failure and returns
an error without propagating the policy information to the caller.

Distinguish this case from other H_AUTHORITY failures and propagate the
returned policy to the caller while preserving the authorization error.
Remove the explicit assignment of zero to rc on H_SUCCESS, as it is
redundant.

Also validate the PLPKS variable pointer before dereferencing it.

Fixes: 2454a7af0f2a ("powerpc/pseries: define driver for Platform KeyStore")
Cc: stable@vger.kernel.org # 6.0
Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/plpks.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/plpks.c b/arch/powerpc/platforms/pseries/plpks.c
index 23e4e2a922fc..7e56b3dcacbc 100644
--- a/arch/powerpc/platforms/pseries/plpks.c
+++ b/arch/powerpc/platforms/pseries/plpks.c
@@ -822,6 +822,9 @@ static int plpks_read_var(u8 consumer, struct plpks_var *var)
 	u8 *output;
 	int rc;
 
+	if (!var)
+		return -EINVAL;
+
 	if (var->namelen > PLPKS_MAX_NAME_SIZE)
 		return -EINVAL;
 
@@ -856,22 +859,21 @@ static int plpks_read_var(u8 consumer, struct plpks_var *var)
 				 virt_to_phys(var->name), var->namelen, virt_to_phys(output),
 				 maxobjsize);
 
-
 	if (rc != H_SUCCESS) {
 		rc = pseries_status_to_err(rc);
-		goto out_free_output;
+		if (rc != -EPERM || !retbuf[1])
+			goto out_free_output;
+		goto out_copy_policy;
 	}
 
 	if (!var->data || var->datalen > retbuf[0])
 		var->datalen = retbuf[0];
 
-	var->policy = retbuf[1];
-
 	if (var->data)
 		memcpy(var->data, output, var->datalen);
 
-	rc = 0;
-
+out_copy_policy:
+	var->policy = retbuf[1];
 out_free_output:
 	kfree(output);
 out_free_label:
-- 
2.52.0


Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E905326A0;
	Wed, 23 Sep 2026 18:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188182; cv=none; b=erSKO5gccjHTpcvIizKeloGjLmSG5i8JTs3vuxkAjrm+6FGTdRP689tfUvKwE9rAbJQFlF6QuDUwQByCWYDgI5DF/e2xIz9H9388wy0LRnqRjTtdz5yeBN+z8KKPipIecQOccZvv9FoGrcxc+i2knZ72FxuOXX8vae9PNwz12PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188182; c=relaxed/simple;
	bh=Ia2a9egR1wh2McHjPFZzuxJM/PhWu5apl0PD+4LMRn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RZ84T7g7BY582ScUDvt3qkhzpBfj3AO+IP9WXR9r9LMtTqacZe7KY+69rA2UsMCI5W++NRjAq0ux4db3jOotNiku6ngfBnRN1WdMPh7fpaJx0hXcu5+TQhsenmauBaCeqM1sFI5bDcOm/RIIyTUfhVdZH243x9X8mP0S5HDNSCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=adf4DQpN; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="adf4DQpN"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NGZLr33921943;
	Wed, 23 Sep 2026 18:29:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=P7boCCNyEcigrL7CU
	59oRfKRZkngHfHczb87pzUn4Uk=; b=adf4DQpNAPrIAeeEGrTJl29KPLRbhAOa+
	4QeJVI9rw6lIMphrkzAT7JEgjMwlcKiaqOcgKYRjkIldYRMUZqYb9nbZqwo3I2+n
	jyTt2VmfeP11u9LLKXQD52qCE5AlHe8l/k5Pow1W4oVvSMVeNOVe0Dd+OGXCunAY
	Q25sRpPVO3awPylGGyZoCSk3VF8JQxJLECbtwjijpMXFC1DLlBG2AkqAXsy1mccy
	FuOAs78CmWlvtvxJgen6bYrB18JOsEUI3jO56pd8J6JowBYVgmP4S9S8xkZviJTr
	t4GQfgdS5Uqf8/n/llcJ8/UmEWVlIZafEAy9WdJgJ45N2BBvy6Rzg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgscxm6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 18:29:25 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68NGWnWF664394;
	Wed, 23 Sep 2026 18:29:24 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbe1t9bd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 18:29:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68NITKFU45416830
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Sep 2026 18:29:20 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 91E9320043;
	Wed, 23 Sep 2026 18:29:20 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D456420040;
	Wed, 23 Sep 2026 18:29:14 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com (unknown [9.67.83.254])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Sep 2026 18:29:14 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, nayna@linux.ibm.com, gjoyce@linux.ibm.com,
        ritesh.list@gmail.com, sshegde@linux.ibm.com,
        linux-kernel@vger.kernel.org, rnsastry@linux.ibm.com,
        ssrish@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH 04/12] pseries/plpks: clear sensitive PLPKS buffers
Date: Wed, 23 Sep 2026 23:58:08 +0530
Message-ID: <20260923182816.151451-5-ssrish@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=V/XoQuni c=1 sm=1 tr=0 ts=6ab41a86 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=vus6YNbAzWr4A5RBNAEA:9
X-Proofpoint-ORIG-GUID: YI4qsMKNQlCWu0eUOi7I3VxAthQIOZ7o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA3MiBTYWx0ZWRfX/8tOXSs8ueHT
 DqNvCRZYF4t17rUoSzv5TXtScR/rlvr2HYybUyPvkmI/tbarBtbxZKu3xQUEM1ECSv+CcH8cgbz
 lIliqONiaZclFrHIefhKCR53xu7B+mTCNf/zkISjwwpgm5c1wx/4L0D2EYrwZp6Z9/CPw8gb45K
 Np9RkhCuYgVa3O+uDC0P2dlWWMtEMTDr6r1IC0KowBH4FeT3pzLlKIN/SVnOQb1YUTNpAU1UiLO
 8XQ394olE0UjR0JcSpuIyiEuG8G0uBb++YPm7rIEMKiLbfJJkLVm5j2/+hwJha9cTFgtUNT/7jE
 YvLl40i5UJDlSS30Xmg0iDNtyqm+sJmL6kTaWnaaaq/PcLHeDuZZGXTU3sMjopIS/tT2upxAQ3Z
 ioW1U9S++VOnni2irIia0icD71Rzqc0FBXpsdeuABOkmMOg84bj8QoJWWvVwLdlhGMFTCnb21++
 BqldbmazqyOonO7MhbQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA3MiBTYWx0ZWRfX+SUJkb4vnXFr
 PvABrytmKroSlEiIrNvo1WEnXLaZTf4kLZfo9lt0KVB3Gb+lOt3Qx6qve9HhGHI5QyYhuSQRIb5
 Mt+U3RKozKNV+pc4bo+E43q6yKtMw+0=
X-Proofpoint-GUID: jlwCKsWSBKq14AFC7aJoN1EcZKVb6XB0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230072

PLPKS read, remove, and write operations use authentication buffers that
contain passwords. The read output buffer may also contain sensitive data.
Freeing these buffers with kfree(), without wiping the contents, can leave
sensitive data in memory.

Use kfree_sensitive() to wipe the buffers when freeing them.

Fixes: 2454a7af0f2a ("powerpc/pseries: define driver for Platform KeyStore")
Cc: stable@vger.kernel.org # 6.0
Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
Reviewed-by: Nayna Jain <nayna@linux.ibm.com>
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/plpks.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/plpks.c b/arch/powerpc/platforms/pseries/plpks.c
index e3ae2cd78247..8dbf85e9714c 100644
--- a/arch/powerpc/platforms/pseries/plpks.c
+++ b/arch/powerpc/platforms/pseries/plpks.c
@@ -754,7 +754,7 @@ int plpks_write_var(struct plpks_var var)
 	rc = pseries_status_to_err(rc);
 	kfree(label);
 out:
-	kfree(auth);
+	kfree_sensitive(auth);
 
 	return rc;
 }
@@ -812,7 +812,7 @@ int plpks_remove_var(char *component, u8 varos, struct plpks_var_name vname)
 	rc = pseries_status_to_err(rc);
 	kfree(label);
 out:
-	kfree(auth);
+	kfree_sensitive(auth);
 
 	return rc;
 }
@@ -878,11 +878,11 @@ static int plpks_read_var(u8 consumer, struct plpks_var *var)
 out_copy_policy:
 	var->policy = retbuf[1];
 out_free_output:
-	kfree(output);
+	kfree_sensitive(output);
 out_free_label:
 	kfree(label);
 out_free_auth:
-	kfree(auth);
+	kfree_sensitive(auth);
 
 	return rc;
 }
-- 
2.52.0


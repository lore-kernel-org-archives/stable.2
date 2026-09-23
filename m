Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390765172C2;
	Wed, 23 Sep 2026 18:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188193; cv=none; b=ke5AKcoek3yGNG+MECRFin/9vpMnlwCd5itqbnyPc5R61RFxU0ipz8Q2hAMUWKwH71DzTMNSrNT0Cv9x+cDMqi7M2t175TSYWA44I5GBCmVYjkzUtLyN+1vs0v09kh02Ix5FhNAaSTJQs06M2J0E+LPDW9eAPN7L6ZocpNEfZeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188193; c=relaxed/simple;
	bh=qvp028X4Wu+yDQDg2akIbxSC4mOxIcdq58cDFCTU768=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kVf65BMdTeBrGXFJHRrmMNIuDoyKUU4jWgVoiSbFQEUIpzCHApSHs5ia3YPVRGObDrIdlnRWUTr5+FAzElxi5XsCl6S7lqu0PEZJ6hvkSTqVP2sxYS1xd4kS9eEOdhDvVlXDJDkT1dA+13gU5iYIHPwySWUYa1RZqUkCghtZcFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kVYdJ3Xj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kVYdJ3Xj"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NGZn112049004;
	Wed, 23 Sep 2026 18:29:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=hsVQLhtCzN5/A7h3M
	LQOWfta3UL2hW82uqetma8bkhk=; b=kVYdJ3Xj6hLtG22QiMIrhaOKe3HFHngaj
	2rmpraCcIe18JlgeEO2jM1LBgOj4vju+TSp8sXyl/cDFSf0hoZGqRTxDdxJaVDKw
	KeKjkXVaNiX6h4AFalByuYPdKLtN42qDbvTe+hjagguXWCAiVmveykfgEapQUmC/
	qa5ez4Y62Fr9KUzhqVtCZ4x3DlVKgrseEHZQzE7CbvuLGwxI1XRLFk9/hLWg2/7r
	siJeKx0HM0UXeRnozQQt4au4P6P2mOtgTg2ZON7Ty6irmlcdzxZ/kkTC8Gi3c2fz
	va6DZQu7BTxOXjwyvbnErUA4se4NRJEZMha0JQhGAuoOARNasG2iQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1vy5p-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 18:29:32 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68NGWonU678708;
	Wed, 23 Sep 2026 18:29:31 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvb8jt9gt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 18:29:31 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68NITSus32178468
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Sep 2026 18:29:28 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0AF6920040;
	Wed, 23 Sep 2026 18:29:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F39B12004B;
	Wed, 23 Sep 2026 18:29:22 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com (unknown [9.67.83.254])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Sep 2026 18:29:22 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, nayna@linux.ibm.com, gjoyce@linux.ibm.com,
        ritesh.list@gmail.com, sshegde@linux.ibm.com,
        linux-kernel@vger.kernel.org, rnsastry@linux.ibm.com,
        ssrish@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH 05/12] pseries/plpks: clear sensitive buffers in wrapping operations
Date: Wed, 23 Sep 2026 23:58:09 +0530
Message-ID: <20260923182816.151451-6-ssrish@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: YcFY314aKpeYTwD69oP3pBvR8U0jRKRm
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab41a8d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=2vvbgfWMNvI2M4yFCmYA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA3MiBTYWx0ZWRfX7KlyrjQ3xHNH
 dR/ukwN7LTe7x8CnwId0aF7RnpsQ2JmYxMHz2Un9IJahKqhyihguL1m8zsdI2H/xkp4mTPvkFhc
 20oOeFu8JJwba8hOadrcV0OxMZCRDbA=
X-Proofpoint-GUID: ISnitQ1LhWYJCUmKtWT_W1YQWZz__bbG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA3MiBTYWx0ZWRfX8akLhLF4M6Hv
 zfriAHBOHpgil3+JkfZ0xHecMfj5QoihLJiyQrdeVwOyZjul/IGJK/1q5pnMXh/q07hJB0T53WB
 0bx6tQOp26Q2QlXHOAa8WTOleFfPD9NNfwEG+xSqhboQFH69/2X6UZ7kd7VARriVJlsG/8PvVwI
 RE55EsO2n7dkrNJSZwufy1j5dUGEot4iuv7rigA29ZtfO8t+IhPQHKBV01Vm0kuHguouHZG1ReH
 MhC4qnhQAABpvTuUhR+U8nluICKpC9kWbzsrWhf4CCZIpl6f/aXoLNZRWBmIWq+i2zixu2UUQ/M
 UVgHNUBn9mOXXWY1BTNlNmQt/POhN+TtrlJe04NSQuQHVgah4av9pzAF+75rC6orjMm/bDrjKY0
 pPzElQmd0WJKyA9QlDk/45oZBCY6UWy37rYBIiLvQqSjxGUxQz48JrPKfz8DdLwPLJ+nVJdkjXw
 Nwc1W9+InUXpambcVqA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230072

PLPKS wrapping key generation, object wrapping, and object unwrapping use
authentication buffers that contain passwords. An object unwrapping failure
also frees an output buffer that may contain sensitive data. Freeing these
buffers with kfree(), without wiping the contents, can leave sensitive data
in memory.

Use kfree_sensitive() to wipe the buffers when freeing them.

Fixes: 133aa79e211d ("pseries/plpks: add HCALLs for PowerVM Key Wrapping Module")
Cc: stable@vger.kernel.org # 7.0
Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
Reviewed-by: Nayna Jain <nayna@linux.ibm.com>
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/plpks.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/plpks.c b/arch/powerpc/platforms/pseries/plpks.c
index 8dbf85e9714c..17a73a04d45b 100644
--- a/arch/powerpc/platforms/pseries/plpks.c
+++ b/arch/powerpc/platforms/pseries/plpks.c
@@ -975,7 +975,7 @@ int plpks_gen_wrapping_key(void)
 
 	kfree(label);
 out:
-	kfree(auth);
+	kfree_sensitive(auth);
 	return rc;
 }
 EXPORT_SYMBOL_GPL(plpks_gen_wrapping_key);
@@ -1100,7 +1100,7 @@ int plpks_wrap_object(u8 **input_buf, u32 input_len, u16 wrap_flags,
 out_free_label:
 	kfree(label);
 out:
-	kfree(auth);
+	kfree_sensitive(auth);
 	return rc;
 }
 EXPORT_SYMBOL_GPL(plpks_wrap_object);
@@ -1177,14 +1177,14 @@ int plpks_unwrap_object(u8 **input_buf, u32 input_len, u8 **output_buf,
 	if (rc) {
 		pr_err("H_PKS_UNWRAP_OBJECT failed. pseries_status=%d, rc=%d",
 		       pseries_status, rc);
-		kfree(*output_buf);
+		kfree_sensitive(*output_buf);
 		*output_buf = NULL;
 	} else {
 		*output_len = retbuf[1];
 	}
 
 out:
-	kfree(auth);
+	kfree_sensitive(auth);
 	return rc;
 }
 EXPORT_SYMBOL_GPL(plpks_unwrap_object);
-- 
2.52.0


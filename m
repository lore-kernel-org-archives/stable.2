Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0CA54723
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 04:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783915234; cv=none; b=QiUA3Gmm2t5JF1afsQf5FJo0oJYlvqYT6qu2D9/tjFmBrU8A2PlSuGzJF0z3CC7xm2xsE1c2glDAUWnLXsUeWWY7PeQdWbuJIagu9F38DtnZo/Fq3JTFVKugD7AvakIBTRiXQDjuWwrwNetpc4n4bgYh+aapnjhnfVhyXz/wQFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783915234; c=relaxed/simple;
	bh=ov6kymvgGOEb3ieCdG21Td7c1duhet/rkuPpQGc66f8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q3ztkqTfRd8qd+KrB03bXQhFzKY1Wy9leiYHgkf+7dijDYwDiWiJ7c6gKjylVfBB6ScrSgcX07fGeFJHuYwVxUJEBFwc0H/OZKVgHJ0VFC2mEkyko8zAVKeTM6qGgCMHt2IWpk/ygJTx9F1PvbOSR+aT9C1n+wUhqFU1So0Bms8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hHd07QBC; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hHd07QBC"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D3D1fA1306533;
	Mon, 13 Jul 2026 04:00:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=P4kPvtAAZt0I1oC0B
	Vn1KCFE9SL8fiHGVd41usPeFz8=; b=hHd07QBC2ZuQve6HZRCDwgKr5NEPpG+xy
	6MrIVs2+S4tMteVsfxPz0BYap9LJKzDmvSgwDfswef49oH8aip73B7idhbTG1OlA
	dlzHhiwmgEaBuJE3+bw8pw6BjcJG+g//69cQnCH5p2nhY4krbxue16apn12zGcbO
	0w5bilfn662GVV3GA3w3f7nQKAPcHslF2bI9Qsz/9tm6Svpx0nzNF1nkwvAzLADT
	FV5XL6hCmKYBVPkdmzEh3diRRCZOgH0AagTBfpfDdhVHBM4GaQEvrNYuyZEs1CB5
	5CdraRcY6vUIUNA0Kp6mFp590ksYKW8Grae7MC+h3K9WU1xAxU56A==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegbecby-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 04:00:15 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66D3noxF014996;
	Mon, 13 Jul 2026 04:00:15 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc15jkx9f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 04:00:15 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66D40BOP47120708
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 04:00:11 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F3BF02004B;
	Mon, 13 Jul 2026 04:00:10 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 651BD20040;
	Mon, 13 Jul 2026 04:00:07 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.bl1-in.ibm.com (unknown [9.123.14.142])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jul 2026 04:00:07 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
        ritesh.list@gmail.com
Cc: npiggin@gmail.com, chleroy@kernel.org, shivangu@linux.ibm.com,
        hbathini@linux.ibm.com, mahesh@linux.ibm.com, adityag@linux.ibm.com,
        venkat88@linux.ibm.com, stable@vger.kernel.org,
        Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: [PATCH v2 2/3] powerpc/pseries: Handle and log pseries-wdt registration failures
Date: Mon, 13 Jul 2026 09:29:53 +0530
Message-ID: <20260713035954.1559605-3-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260713035954.1559605-1-sourabhjain@linux.ibm.com>
References: <20260713035954.1559605-1-sourabhjain@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=fOcJG5ae c=1 sm=1 tr=0 ts=6a5462d0 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=jFMkbxqpFWXI0KRqqm4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDAzNCBTYWx0ZWRfX1S2s6hsDUxMQ
 pZUpicpm8I1sA2bnuLpzg4CtW03hxOma8CteWWKqJbwzsrCh2SRQHtOubYEUDgcMcDKfmEUDkeu
 4x9+LaDNELjKCKf1SGzD+5oROdwYfIVeH0rk/DguJJphGxp0wq+qoZm+B9zXu/oo/NRGZ89uup9
 k8X4hMsoRs2butMuWNkSJVfLbExUAJq5+IDbIPe5Ck5Z0GOgcFHODbGsBblE3nFKCv/Q68I9LCG
 xxTX2eczBVpoth/QkGbFcmVdAxQsQdr6Lqz6KiR4ktk/5cl9rhKVILocSaBAVonP3XVIwMh5IuH
 He5l8N2VHZ/DqHjB+NJ0HjxBfASB93Ubcg+vWGx7h/vEdW4dA7rfzvKmI2KRiJ11MPUWkV6iOSf
 IW+ra/nsiG6n3QWBA492js1VaubBNII7T7uY+WJQBPX/p8/YPOPPajgKA4Gq5Z2TFcIT6X0B9Kj
 tEBvgx/QcxmIJkW7gNA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDAzNCBTYWx0ZWRfX9XWALN9ccIXb
 DnotcIhfKJAXTJC9bZTZ2KrKgYvJ35cj4l2jtX+Em3CG7ZzxrdN7EuMOMg9MgafRu0tVFGLL3RH
 eBVb9J/tVXITWizI6Mu9o+kmgda8cSo=
X-Proofpoint-GUID: REYBLvmg1ZOjqvANa6RD1H4Vr68YoCOg
X-Proofpoint-ORIG-GUID: jTRR6nxhG9SVKKgVx7qX6EgYafHYcBz9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_01,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130034

The pseries watchdog initialization registers the pseries-wdt platform
device using platform_device_register_simple(), but currently ignores
its return value.

Check the returned pointer for errors, log a descriptive error message
when registration fails, and propagate the failure code to the caller.
This avoids silently ignoring platform device registration failures.

Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/setup.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 1223dc961242..bbb2813f8ede 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -191,8 +191,18 @@ static void __init fwnmi_init(void)
  */
 static __init int pseries_wdt_init(void)
 {
-	if (firmware_has_feature(FW_FEATURE_WATCHDOG))
-		platform_device_register_simple("pseries-wdt", 0, NULL, 0);
+	struct platform_device *pseries_wdt_dev;
+
+	if (!firmware_has_feature(FW_FEATURE_WATCHDOG))
+		return 0;
+
+	pseries_wdt_dev = platform_device_register_simple("pseries-wdt", 0, NULL, 0);
+
+	if (IS_ERR(pseries_wdt_dev)) {
+		pr_err("Failed to register pseries-wdt platform device\n");
+		return PTR_ERR(pseries_wdt_dev);
+	}
+
 	return 0;
 }
 machine_subsys_initcall(pseries, pseries_wdt_init);
-- 
2.52.0


Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD54305687
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 05:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785130493; cv=none; b=sR7tQb2dtCp4Ywcp3R5hYCqdCT/A7Q9l06SHsOStVhnKoh522X3EEYlbJtmL86kISvxGsheAyReM1/5vvz+M4pj+65c0FfpKVQhNl8rVndg/yA8QbhpdDgYOP/GS92Z6WLE2c/8ymXrMYR9AeYbNkYtdZ+C7spHLc3HnKDke5rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785130493; c=relaxed/simple;
	bh=+0hn6ilBVVJNCCr2xSE6um4sTR8h+hDSNT0OnrPWwDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BodqlOvB1PiXTo9Bp1Tc/w9G0ZrHRbjwMcNhow0dejhEArUuIyT+kf0k5pGUwH9tC5NPrAb9PCOqBpHe1dZY4HBzwdeMUvGtw914xkQfiTM9YaZnQRSk1rf6wPZizFC1Nc+NWdowXkktl0t+NtaAiMX/mFI6ZMqJo0QV1mglFRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hsRQUIEU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hsRQUIEU"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66R1ljOB856156;
	Mon, 27 Jul 2026 05:34:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=MJ76jhVGgrKKKGbEh
	hXMLl+IJSmN+QH65vx4vFqTrMA=; b=hsRQUIEUL1bF99d8aiUmYUmFVxRo4NteH
	YSKvZ5T5APHQq3/G7uH52aM3/5TfqTIcsgEq29kzT5VEc88p4mTXqNseoIvQbrTm
	AZxo935nTwJFOTAul9dJssP3F5b2zsV33/JJ3LW05RSHggR6SCsIKdTbSvmnLEkT
	bGMfJgWpxBNlSQzzI5QIj80WrYVTV/fLb1Nz2PVmiI3GPo/IUba/hYxG45lAf65O
	2oniFZEbg3jyWzrg0hU2UecTRo8NfdJYXhyXyTBumX+AoPJmcUqqj+9TJaiAMKRQ
	T9tS+JNGlgZx2jfBRr+4WkBPnRhF6XQc9no9TzlDvDkG4N+ZsiBVg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw769h2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 05:34:41 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66R5QZNZ016843;
	Mon, 27 Jul 2026 05:34:41 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5xurgp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 05:34:40 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66R5YbGg45547862
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 05:34:37 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4818B2013B;
	Mon, 27 Jul 2026 05:34:37 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 677FE20139;
	Mon, 27 Jul 2026 05:34:34 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.bl1-in.ibm.com (unknown [9.123.14.142])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 05:34:34 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
        ritesh.list@gmail.com
Cc: npiggin@gmail.com, chleroy@kernel.org, shivangu@linux.ibm.com,
        hbathini@linux.ibm.com, mahesh@linux.ibm.com, adityag@linux.ibm.com,
        venkat88@linux.ibm.com, Sourabh Jain <sourabhjain@linux.ibm.com>,
        stable@vger.kernel.org
Subject: [PATCH v3 2/3] powerpc/pseries: Handle and log pseries-wdt registration failures
Date: Mon, 27 Jul 2026 11:04:15 +0530
Message-ID: <20260727053416.276317-3-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260727053416.276317-1-sourabhjain@linux.ibm.com>
References: <20260727053416.276317-1-sourabhjain@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: rpazVoCDs8JgR1WcGIJO9xsZKik8K-b0
X-Proofpoint-ORIG-GUID: GZu6odqskWvi99eh8gwhr9uf6nGw6eIi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDA1MCBTYWx0ZWRfX7n4I3wqxnjSV
 Jd5I7UCbJZHMrPa7JHdbRbJ8qgJIyYUgdyAY3bPs3FtNW/xy4AqpCBAwmCqYtaoAYV4997/6Dum
 PrC1SWMOfSJS905t88vUu3S8qeHV0pOOxHQm8LK1zOJ/QaCFnrOtmbVWjRp0RlzhKg7GoLuB8lc
 neIl7V+HWZJroJTq5iTy2O+PHA63Zu+KxaAGXDqtGrih08DaIR3zhwQmWa5xboq4Q7DojDhjW2S
 7nkiGp04gvZfnPmvccqr4a6P9f+IC/yzvGGi0cTWY9Zg++RxD7S77/FBZ9WCLWpU4ZnfmyZqX2C
 3N6JOZofDMV/uKd9M2cXecgvSsC6m+zUvRgjJmkKcqvf3yUI9hIwkSRO9mKZ2kKV4XXb6NETaVf
 zYRc+PJt8E3SjXTAc6eQxF5/DbdjUEUIxe/r+wpcte4GPwOUKTNJnjwdvlZlHlwRmGcGhjbjtSD
 tJuM/Vxgln2SRGxrsHw==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a66edf2 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=jFMkbxqpFWXI0KRqqm4A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDA1MCBTYWx0ZWRfX9eVkvN1Nx/Bh
 C/YHAa4uc29rlF6qghyQLl3JveaWS+fxqg+dy6q61nmeN07wnqLhJjuMLiGMEGvzFXDvmUyTuN7
 tB7wLf13VewMt6zyj3fG9ksXOl6j07E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_01,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270050

The pseries watchdog initialization registers the pseries-wdt platform
device using platform_device_register_simple(), but currently ignores
its return value.

Check the returned pointer for errors, log a descriptive error message
when registration fails, and propagate the failure code to the caller.
This avoids silently ignoring platform device registration failures.

Cc: stable@vger.kernel.org
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/setup.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 1223dc961242..aed12412c600 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -191,8 +191,18 @@ static void __init fwnmi_init(void)
  */
 static __init int pseries_wdt_init(void)
 {
-	if (firmware_has_feature(FW_FEATURE_WATCHDOG))
-		platform_device_register_simple("pseries-wdt", 0, NULL, 0);
+	struct platform_device *pdev;
+
+	if (!firmware_has_feature(FW_FEATURE_WATCHDOG))
+		return 0;
+
+	pdev = platform_device_register_simple("pseries-wdt", 0, NULL, 0);
+
+	if (IS_ERR(pdev)) {
+		pr_err("Failed to register pseries-wdt platform device\n");
+		return PTR_ERR(pdev);
+	}
+
 	return 0;
 }
 machine_subsys_initcall(pseries, pseries_wdt_init);
-- 
2.52.0


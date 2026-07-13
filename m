Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4245654723
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 04:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783915238; cv=none; b=ljJ/yNJlokWg5NqBqUaS46wHm8TcEuwwPbFwkBRor7Cp4mozODhyKRP1qsk8Nqb+jU7Ki8P0h+jZE7d/gY9jdC2WIwGakdwIFZtJB4HInxGNaFrsEDjCm3wKWwubkEg10+uDcUmaEhFEp4m08XMJI2mv0c1yPBqY4WW3xoFdWAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783915238; c=relaxed/simple;
	bh=dj6O1Jfsv4WyI2TYS4bJ/nhY0Bv1kCeSFHA+90l1XJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AgJW71b+TI84Xx99PeJ9KarlwW9S7Pvado8NS3DfRW8xNqjQDJrPAqMqo+bkzXDqrLLXDyI0ybUIlBCPV3XamCAeU22TDeX2vmKnwF4R29dspXuVIXAnQmI0a6p9hNcDL8pXHGeCXSJX4ZnTXn6FNkGcn4kX3qxShPOrBFqok70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hBMuVbwv; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hBMuVbwv"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D3Bn1j1304479;
	Mon, 13 Jul 2026 04:00:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=naSneYMkzDPlcW0eS
	tLpbm1ZqEBPL00XtReNKxTYT4w=; b=hBMuVbwvc8twfT8SAArd1V2DfIAKjieD4
	rI14kHD3PwHOV/zi4LgKDq6cju9RDQ7Fpp5jfWh2ur/OB+kYm3cWONnVV/9STXRh
	r4GwFtnGXgaTEJLIcYiHMTc6OY2WuNr8a0fFaHcwAHDEszCFYQS4ebRJqzS0EZLZ
	SJfMw4kOlhyeBLXUnkHqjWCc5qZa8S0yUqyEsiAFUE3vSbSHPs8c3vRws1/1tFh3
	ANBxqYoDNbt7C6mCjSs6kmlbTGvXzZzxl4BYKuk08bWouL7sG4Y1CRuJOBd8iTp+
	/35YsYwbsOrGGOh7bovUrfSWiAZWTnAErdjL6A/mhP3h+dSpNFWJg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegbecc8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 04:00:20 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66D3noxI014996;
	Mon, 13 Jul 2026 04:00:19 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc15jkxa8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 04:00:19 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66D40Fnn38928666
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 04:00:15 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6244720040;
	Mon, 13 Jul 2026 04:00:15 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E2C720043;
	Mon, 13 Jul 2026 04:00:12 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.bl1-in.ibm.com (unknown [9.123.14.142])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jul 2026 04:00:11 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
        ritesh.list@gmail.com
Cc: npiggin@gmail.com, chleroy@kernel.org, shivangu@linux.ibm.com,
        hbathini@linux.ibm.com, mahesh@linux.ibm.com, adityag@linux.ibm.com,
        venkat88@linux.ibm.com, stable@vger.kernel.org,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Mahesh Kumar G <mahe657@linux.ibm.com>
Subject: [PATCH v2 3/3] powerpc/crash: stop watchdogs before booting kdump kernel
Date: Mon, 13 Jul 2026 09:29:54 +0530
Message-ID: <20260713035954.1559605-4-sourabhjain@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=fOcJG5ae c=1 sm=1 tr=0 ts=6a5462d4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=1VxKY9m5oVtvVnzyWT4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDAzNCBTYWx0ZWRfX/tukWHsvjlIj
 XQOJfvhsC/KnRc62qwlfs/j4M1g6uN90rrlMcTUZQr98tjz1k4P3nz/sHwfURodqcuRL7Y1yPS+
 JZ2DaIeihYMkGK+soCgNwCUUXs4IDvRdKb9F1iyj1rcUyynE/RXC3dxzU7N8qPrv1PNNYQDIrlM
 tDA2/gC1/UfEGVOJ+3kSOY8uUZo1Z57ddAYVDJMmiFUju/rn/K1vYfjZFax6pFy3OkBCVVSWzPF
 Lbp4nBpRjEIQgL4Yb5Z+FdCPnJfH/iEkI3kGnEOOsK0KviBO2btnAIKx2OKfYMhg4P5yBjdnkpD
 qtnzvBhXuTAozZ39D0rRBTTcvgY4C/ALkDqHfRYsrtERs+tnimbcN6b+/7ErfGnPB5ovI4t8SjM
 LqhKWueyjbN71n9ky9vkWwrZT6S0ksyw0oE6T5bv2ZNanG2mBqYSBtq3i5OdrPOUvqjl1XaxUbT
 0jl3HaSROaSnTq61QLA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDAzNCBTYWx0ZWRfXzn6ThJfuxu7A
 o9zQoYA4vpjzvpxccI2vVUrMW79DXMeRO0oHys1BPIY9sZTa0U791eDGDvGNnN+5IoyNn4pIH/b
 BkGgxjwtxvsheI5bYslz/+fDTt6cMzk=
X-Proofpoint-GUID: Vk7dXiBNrRPsnvlombpGczgGctvSRKAv
X-Proofpoint-ORIG-GUID: 9fNTSFlateuoLOSr4Z-vbdZfzVtVw50h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_01,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1011 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130034

On pseries LPAR systems, watchdog timers configured from userspace can
remain active after a kernel panic. When a panic triggers kdump, the
crashing kernel jumps directly to the kdump kernel without stopping
active watchdogs. As a result, the watchdogs remain active after the
kdump kernel starts.

If dump capture takes longer than the watchdog timeout, PHYP resets the
LPAR before the dump is fully captured, causing dump capture to fail.

Fix this by issuing the `H_WATCHDOG` hcall during the crash shutdown
sequence to stop all active watchdogs before booting the kdump kernel.

Fixes: 69472ffa6575 ("watchdog/pseries-wdt: initial support for H_WATCHDOG-based watchdog timers")
Reported-by: Mahesh Kumar G <mahe657@linux.ibm.com>
Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 arch/powerpc/include/asm/papr-watchdog.h |  2 ++
 arch/powerpc/platforms/pseries/setup.c   | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/powerpc/include/asm/papr-watchdog.h b/arch/powerpc/include/asm/papr-watchdog.h
index fb3a511aa861..84bbe1ddd56f 100644
--- a/arch/powerpc/include/asm/papr-watchdog.h
+++ b/arch/powerpc/include/asm/papr-watchdog.h
@@ -55,4 +55,6 @@
 #define PSERIES_WDTQ_MIN_TIMEOUT(cap)	(((cap) >> 48) & 0xffff)
 #define PSERIES_WDTQ_MAX_NUMBER(cap)	(((cap) >> 32) & 0xffff)
 
+#define PSERIES_WDT_NUM_ALL	((unsigned long)-1)
+
 #endif /* _ASM_POWERPC_CRASHDUMP_PPC64_H */
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index bbb2813f8ede..2e40a9dba637 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -77,6 +77,7 @@
 #include <asm/dtl.h>
 #include <asm/hvconsole.h>
 #include <asm/setup.h>
+#include <asm/papr-watchdog.h>
 
 #include "pseries.h"
 
@@ -185,6 +186,18 @@ static void __init fwnmi_init(void)
 #endif
 }
 
+#ifdef CONFIG_CRASH_DUMP
+static void pseries_crash_stop_watchdogs(void)
+{
+	long rc;
+
+	rc = plpar_hcall_norets_notrace(H_WATCHDOG, PSERIES_WDTF_OP_STOP,
+					PSERIES_WDT_NUM_ALL);
+	if (rc != H_SUCCESS && rc != H_NOOP)
+		pr_warn("Could not stop watchdogs before kdump rc=%ld\n", rc);
+}
+#endif /* CONFIG_CRASH_DUMP */
+
 /*
  * Affix a device for the first timer to the platform bus if
  * we have firmware support for the H_WATCHDOG hypercall.
@@ -203,6 +216,11 @@ static __init int pseries_wdt_init(void)
 		return PTR_ERR(pseries_wdt_dev);
 	}
 
+#ifdef CONFIG_CRASH_DUMP
+	if (crash_shutdown_register(pseries_crash_stop_watchdogs))
+		pr_warn("Could not register watchdog crash shutdown handler\n");
+#endif
+
 	return 0;
 }
 machine_subsys_initcall(pseries, pseries_wdt_init);
-- 
2.52.0


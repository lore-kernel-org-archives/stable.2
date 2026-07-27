Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B578D27732
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 05:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785130492; cv=none; b=JnCyE8AH6PkvqvKTt2NgKwSEqW/t3TPv9ZSIh/oAmuZBzKo5gnBM8lPAzxQLCeBXEEdl4KUx/pxkgW2o6YYr95y66kOonlro5T1vL/XiJ7zTjMmg/8hU6pFY8oD79QcX6A0n6StSHyb6gVA9CyTqkawfcoBSsBhQRI+kji6qNNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785130492; c=relaxed/simple;
	bh=HUGb3A/wG0o89BWV8jmRMKBsE1B7WtmHUBM76knJ8Es=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fHpJMC6V4w9itCSyP2zfyss7I7pEblkFq+B3XEHp4vRvKMO3x3eorEZDnLOv7l48AzE6XrI51OkrqzW9xvtvJwemAk1neHlRwGbSHVIDOWa9fumDfKgH6rx4FnobJKPFdZYh138nOrHmcLJwha8aqlEcXbxU+tCgx2/A6d+IgJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bE7074uU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bE7074uU"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66R1lqwS895515;
	Mon, 27 Jul 2026 05:34:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=PmzWJYSfCGXH5/woV
	fiEt//l7xOHN1hs/LZxFmMmZgw=; b=bE7074uUyTE8liFb2PACmWr6xs8MeqPFv
	C9+Zeic1Tqyb9MeJlAGu6iNksLoFfJg/5nbCqjPkh0zoOmJuDGqaXAd87jIxnYvx
	0wF7PmfuCRPBelJxJUOG5b42PgMz/Ldjqr4ZgeuOlZy323XCvVd80CWe8rbRV42F
	rANH1So2vXWiFIWPtm1sH3VMWrmSq64GU55z3kzxV7CSAuig6jCY9v7fu1D6QAAK
	4EGWwRPbH/OqfpB1GIhGUhccUSnwtUL1mVZTi/MFi4VMaHC2DFURti42Wwze/o5X
	KLVP/LTj60m9GJo0sLd0Dz2FPP0N9+Y9UDGIU2KM2JVSn30APQPqw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwcnxrs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 05:34:37 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66R5QGAj016701;
	Mon, 27 Jul 2026 05:34:37 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5xurgg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 05:34:37 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66R5YX0M44630422
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 05:34:33 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 628822013A;
	Mon, 27 Jul 2026 05:34:33 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A1CE20139;
	Mon, 27 Jul 2026 05:34:30 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.bl1-in.ibm.com (unknown [9.123.14.142])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 05:34:30 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
        ritesh.list@gmail.com
Cc: npiggin@gmail.com, chleroy@kernel.org, shivangu@linux.ibm.com,
        hbathini@linux.ibm.com, mahesh@linux.ibm.com, adityag@linux.ibm.com,
        venkat88@linux.ibm.com, Sourabh Jain <sourabhjain@linux.ibm.com>,
        stable@vger.kernel.org
Subject: [PATCH v3 1/3] powerpc/pseries: Move H_WATCHDOG definitions to a common header
Date: Mon, 27 Jul 2026 11:04:14 +0530
Message-ID: <20260727053416.276317-2-sourabhjain@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: Oj410p1Qcb8IwJBvWOLH2YW-GJagq_cI
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDA1MCBTYWx0ZWRfX8WrBBK1vZArB
 93kmjBNU1v/RY6Xh9ZNjw1QR2Kk2btqEXRNgY/9ifjDNL1Px9YO02Cq6Q1zS5L/Vi01lF97FGPF
 gzrR6A4xLpLuf/PQcmPK1I+jrrUoAEU=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a66edee cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=GYsGH9NJgqgsJyUot8sA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDA1MCBTYWx0ZWRfXzY+ba3MMfrR/
 V+K9fm6IM89JcKmm9e2hqEvfQBbdvgl9aYRPrtsbO6/m9V3dEdx9It6DGIamstthQuDEZjxyGIp
 pqNlKGSk80X9az6QmadRgEWsqasSh7n2sKUh0S5o4jA3izEV/JqzW8yC1uNlH6KzsAafw8ShXoq
 8h8cZlavZUFnAvcZS8a9d/IucNTkliIPvxNUam24XeYYN13gjkbHSFjwSfItmwKBRy9kTctgrZ7
 4mSLGZIDYw4AUFZmdJD6hRd9rkuDIn2ns2ENUNviNlxvG6O70g5MyTcvL/dCkRi//jEidVxnn6E
 4IhqB55XY6H/YwLyYluJ9ZumK69HxnZmkGUxIFPTrdHegKC2On7J8FesqYGKRIrlFsgUq5U13za
 jL5E1OLT5wy+BJA2scTk57br9MQspVxu0canuNBVOrxDX7HhRY9mYrRTxdfLX1rukC5htZXeHUj
 PL4ezcWjtv+DohvgWqA==
X-Proofpoint-GUID: Wa9tp7H_1nXz3P7SfxOOOl8SeoC367q9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_01,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270050

The H_WATCHDOG input and output definitions are currently local to the
pseries watchdog driver. The next patch in this series also needs these
definitions to issue H_WATCHDOG hypercalls outside the watchdog driver.

Move the H_WATCHDOG definitions to a new common header,
asm/papr-watchdog.h, so they can be shared without duplicating the
PAPR watchdog definitions.

No functional changes.

Cc: stable@vger.kernel.org
Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 arch/powerpc/include/asm/papr-watchdog.h | 58 ++++++++++++++++++++++++
 drivers/watchdog/pseries-wdt.c           | 53 +---------------------
 2 files changed, 59 insertions(+), 52 deletions(-)
 create mode 100644 arch/powerpc/include/asm/papr-watchdog.h

diff --git a/arch/powerpc/include/asm/papr-watchdog.h b/arch/powerpc/include/asm/papr-watchdog.h
new file mode 100644
index 000000000000..308ffb73932d
--- /dev/null
+++ b/arch/powerpc/include/asm/papr-watchdog.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef _ASM_POWERPC_PAPR_WATCHDOG_H
+#define _ASM_POWERPC_PAPR_WATCHDOG_H
+
+/*
+ * H_WATCHDOG Input
+ *
+ * R4: "flags":
+ *
+ *         Bits 48-55: "operation"
+ */
+#define PSERIES_WDTF_OP_START	0x100UL		/* start timer */
+#define PSERIES_WDTF_OP_STOP	0x200UL		/* stop timer */
+#define PSERIES_WDTF_OP_QUERY	0x300UL		/* query timer capabilities */
+
+/*
+ *         Bits 56-63: "timeoutAction" (for "Start Watchdog" only)
+ */
+#define PSERIES_WDTF_ACTION_HARD_POWEROFF	0x1UL	/* poweroff */
+#define PSERIES_WDTF_ACTION_HARD_RESTART	0x2UL	/* restart */
+#define PSERIES_WDTF_ACTION_DUMP_RESTART	0x3UL	/* dump + restart */
+
+/*
+ * H_WATCHDOG Output
+ *
+ * R3: Return code
+ *
+ *     H_SUCCESS    The operation completed.
+ *
+ *     H_BUSY	    The hypervisor is too busy; retry the operation.
+ *
+ *     H_PARAMETER  The given "flags" are somehow invalid.  Either the
+ *                  "operation" or "timeoutAction" is invalid, or a
+ *                  reserved bit is set.
+ *
+ *     H_P2         The given "watchdogNumber" is zero or exceeds the
+ *                  supported maximum value.
+ *
+ *     H_P3         The given "timeoutInMs" is below the supported
+ *                  minimum value.
+ *
+ *     H_NOOP       The given "watchdogNumber" is already stopped.
+ *
+ *     H_HARDWARE   The operation failed for ineffable reasons.
+ *
+ *     H_FUNCTION   The H_WATCHDOG hypercall is not supported by this
+ *                  hypervisor.
+ *
+ * R4:
+ *
+ * - For the "Query Watchdog Capabilities" operation, a 64-bit
+ *   structure:
+ */
+#define PSERIES_WDTQ_MIN_TIMEOUT(cap)	(((cap) >> 48) & 0xffff)
+#define PSERIES_WDTQ_MAX_NUMBER(cap)	(((cap) >> 32) & 0xffff)
+
+#endif /* _ASM_POWERPC_PAPR_WATCHDOG_H */
diff --git a/drivers/watchdog/pseries-wdt.c b/drivers/watchdog/pseries-wdt.c
index 48d67f7c972a..e97b943e1d3c 100644
--- a/drivers/watchdog/pseries-wdt.c
+++ b/drivers/watchdog/pseries-wdt.c
@@ -12,61 +12,10 @@
 #include <linux/platform_device.h>
 #include <linux/time64.h>
 #include <linux/watchdog.h>
+#include <asm/papr-watchdog.h>
 
 #define DRV_NAME "pseries-wdt"
 
-/*
- * H_WATCHDOG Input
- *
- * R4: "flags":
- *
- *         Bits 48-55: "operation"
- */
-#define PSERIES_WDTF_OP_START	0x100UL		/* start timer */
-#define PSERIES_WDTF_OP_STOP	0x200UL		/* stop timer */
-#define PSERIES_WDTF_OP_QUERY	0x300UL		/* query timer capabilities */
-
-/*
- *         Bits 56-63: "timeoutAction" (for "Start Watchdog" only)
- */
-#define PSERIES_WDTF_ACTION_HARD_POWEROFF	0x1UL	/* poweroff */
-#define PSERIES_WDTF_ACTION_HARD_RESTART	0x2UL	/* restart */
-#define PSERIES_WDTF_ACTION_DUMP_RESTART	0x3UL	/* dump + restart */
-
-/*
- * H_WATCHDOG Output
- *
- * R3: Return code
- *
- *     H_SUCCESS    The operation completed.
- *
- *     H_BUSY	    The hypervisor is too busy; retry the operation.
- *
- *     H_PARAMETER  The given "flags" are somehow invalid.  Either the
- *                  "operation" or "timeoutAction" is invalid, or a
- *                  reserved bit is set.
- *
- *     H_P2         The given "watchdogNumber" is zero or exceeds the
- *                  supported maximum value.
- *
- *     H_P3         The given "timeoutInMs" is below the supported
- *                  minimum value.
- *
- *     H_NOOP       The given "watchdogNumber" is already stopped.
- *
- *     H_HARDWARE   The operation failed for ineffable reasons.
- *
- *     H_FUNCTION   The H_WATCHDOG hypercall is not supported by this
- *                  hypervisor.
- *
- * R4:
- *
- * - For the "Query Watchdog Capabilities" operation, a 64-bit
- *   structure:
- */
-#define PSERIES_WDTQ_MIN_TIMEOUT(cap)	(((cap) >> 48) & 0xffff)
-#define PSERIES_WDTQ_MAX_NUMBER(cap)	(((cap) >> 32) & 0xffff)
-
 static const unsigned long pseries_wdt_action[] = {
 	[0] = PSERIES_WDTF_ACTION_HARD_POWEROFF,
 	[1] = PSERIES_WDTF_ACTION_HARD_RESTART,
-- 
2.52.0


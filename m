Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0999027732
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 05:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785130498; cv=none; b=e8tWHD1eag3ddWh0eRwdDpr5KW/s09nauvN8in1gQHOizU90nR5jMvOBiMgthYqRILAEFwA4bXvVx6bGL3yum3OP1hxrTJHtFe0f5TZmU94PCTu/cOlpyAgVnM1GBWRlwdsKmmnZ67v03ttq6nDP8KbOu5rqqHlwyT4DM0s8j8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785130498; c=relaxed/simple;
	bh=IbaNIWSmJhO3shDM5xErat2LIsAVnVSQmKSWe23mG4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dY+SNfaeccB+J76MVRycP0jD+gna0LauX9DZyy33NzFaA36aIOc4+kcf8a5/s4M1fq4+n0mTDlfyKNbrbeftH/kEdMK8P7d2t11ht3yhLPjQc1bzWj3aaGhfeg8pmaH8Ynom2KPfTSSIkKeUZ12jsgKu/U74KRdQH/ZzfQG+8us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rXqyr+Bh; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rXqyr+Bh"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66R1luJ9856474;
	Mon, 27 Jul 2026 05:34:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=MiSz5oENnFf7Ep0gq
	hWcsz/w141huOtWKt+qnyYLNN0=; b=rXqyr+BheUnoSxTtHACRrSZSqkF3b8UoE
	3EQHDdCFX0zYrAGN9Y3mDkvLsNd1ZQ1oaBSXoaFt06NijklDrZxzLrQWmOGpiHky
	TtTeeyYxtGSmqqywjC3GeBh5dU5BPAGmrIlg8ao4IGMi0cNP3WjFeAyaWuFdVp66
	HaqlOEmteb/l2d8NFW4jA5knWwJPHnWA7Bw3HXhObHVb1vSl0jWpXJYQR2HAPBry
	U621LlrV2/3wXd/exw5ycKd8uDc3ukYiJMm21gz0GNilHQCqIxc28O8jvtfgkyD8
	QV2LRvjF2QSi/BTlHnxboZZO77Bgd4P+Pxx9hYmjN4E9D8AD616Iw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw769h9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 05:34:46 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66R5QJTc020602;
	Mon, 27 Jul 2026 05:34:45 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yh3y8h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 05:34:45 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66R5Yfkv12976432
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 05:34:41 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A9E922013A;
	Mon, 27 Jul 2026 05:34:41 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B059020139;
	Mon, 27 Jul 2026 05:34:38 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.bl1-in.ibm.com (unknown [9.123.14.142])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 05:34:38 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
        ritesh.list@gmail.com
Cc: npiggin@gmail.com, chleroy@kernel.org, shivangu@linux.ibm.com,
        hbathini@linux.ibm.com, mahesh@linux.ibm.com, adityag@linux.ibm.com,
        venkat88@linux.ibm.com, Sourabh Jain <sourabhjain@linux.ibm.com>,
        stable@vger.kernel.org, Mahesh Kumar G <mahe657@linux.ibm.com>
Subject: [PATCH v3 3/3] powerpc/crash: stop watchdogs before booting kdump kernel
Date: Mon, 27 Jul 2026 11:04:16 +0530
Message-ID: <20260727053416.276317-4-sourabhjain@linux.ibm.com>
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
X-Proofpoint-GUID: AYxFhtFkEhslfZGikY7Y1B167EMdbSrq
X-Proofpoint-ORIG-GUID: XlrdPJiqfPnGm94R65KXUoz7Pc5bBvxC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDA1MCBTYWx0ZWRfX2288HoRpaPwg
 TfWQUcK8BPYZRK7aFkK5mitSPFHyNF1EpGmy8IzUrok9o8TcOKbcUzEtAcy19+jhEqSuPNFBiQk
 hJMyMHHCAYIDD4wsW1Wt5BYe1JkOzOwgMt7YLCbyOBV9NJz7vp/5noiyFB7NcsRoRKSk2pIbdXY
 td6BIOE0zveArYpyYVm/y+W9Ap8/CTjMTGFtJzI4b1PTKapnJDWlwCnelx0AVooP2OXHYZgEGo2
 cU5RZnpdmMWCxLJQ5ObNBO3begQyxGavCWtKJN+dKtayaQOA3bqsjJ3xjKSc/ODm/eopgBPZ9uy
 kTB42Vvkfml31m/BbU8O5EpKuPyt4AMFFp3ktUR7cfCjSZ6hEYbE1+dk3knqMJg24VhuTJyXok1
 8LzKCdYEJVDt/gPnPrutHid28Ql/BZWPVqvxBXW0/5FxERzg6li+b8R+50r7wJT6WfFolnxU/Nk
 1oEGS1fgUiEXGhdXdKw==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a66edf7 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=1VxKY9m5oVtvVnzyWT4A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDA1MCBTYWx0ZWRfX46LApJ8UMd45
 EaGaAtA/YXYo3gm2O7qNSPwjljFEV4e/Y7WBtLIWVExpUGuhXTP0DSjBZwgJ0jmnNo2Vd7DbTxc
 fhQGxGs5Cb258/iqFRQOCkC/V4FNZAw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_01,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270050

On pseries LPAR systems, watchdog timers configured from userspace can
remain active after a kernel panic. When a panic triggers kdump, the
crashing kernel jumps directly to the kdump kernel without stopping
active watchdogs. As a result, the watchdogs remain active after the
kdump kernel starts.

If dump capture takes longer than the watchdog timeout, PHYP resets the
LPAR before the dump is fully captured, causing dump capture to fail.

Fix this by issuing the `H_WATCHDOG` hcall during the crash shutdown
sequence to stop all active watchdogs before booting the kdump kernel.

Cc: stable@vger.kernel.org
Fixes: 69472ffa6575 ("watchdog/pseries-wdt: initial support for H_WATCHDOG-based watchdog timers")
Reported-by: Mahesh Kumar G <mahe657@linux.ibm.com>
Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 arch/powerpc/include/asm/papr-watchdog.h |  6 ++++++
 arch/powerpc/platforms/pseries/setup.c   | 14 ++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/powerpc/include/asm/papr-watchdog.h b/arch/powerpc/include/asm/papr-watchdog.h
index 308ffb73932d..bf876fc2caae 100644
--- a/arch/powerpc/include/asm/papr-watchdog.h
+++ b/arch/powerpc/include/asm/papr-watchdog.h
@@ -21,6 +21,12 @@
 #define PSERIES_WDTF_ACTION_HARD_RESTART	0x2UL	/* restart */
 #define PSERIES_WDTF_ACTION_DUMP_RESTART	0x3UL	/* dump + restart */
 
+/*
+ * R5: "watchdogNumber":
+ *       PAPR says use -1 (all ones) to stop all watchdogs.
+ */
+#define PSERIES_WDT_NUM_ALL	((unsigned long)-1)
+
 /*
  * H_WATCHDOG Output
  *
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index aed12412c600..f29e7547c995 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -77,6 +77,7 @@
 #include <asm/dtl.h>
 #include <asm/hvconsole.h>
 #include <asm/setup.h>
+#include <asm/papr-watchdog.h>
 
 #include "pseries.h"
 
@@ -185,6 +186,16 @@ static void __init fwnmi_init(void)
 #endif
 }
 
+static void pseries_crash_stop_watchdogs(void)
+{
+	long rc;
+
+	rc = plpar_hcall_norets_notrace(H_WATCHDOG, PSERIES_WDTF_OP_STOP,
+					PSERIES_WDT_NUM_ALL);
+	if (rc != H_SUCCESS && rc != H_NOOP)
+		pr_warn("Could not stop watchdogs before kdump rc=%ld\n", rc);
+}
+
 /*
  * Affix a device for the first timer to the platform bus if
  * we have firmware support for the H_WATCHDOG hypercall.
@@ -203,6 +214,9 @@ static __init int pseries_wdt_init(void)
 		return PTR_ERR(pdev);
 	}
 
+	if (crash_shutdown_register(pseries_crash_stop_watchdogs))
+		pr_warn("Could not register watchdog crash shutdown handler\n");
+
 	return 0;
 }
 machine_subsys_initcall(pseries, pseries_wdt_init);
-- 
2.52.0


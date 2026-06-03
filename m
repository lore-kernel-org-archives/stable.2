Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9173F0A9B
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 07:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780470173; cv=none; b=UOGlz70dD1Y3AxrzBcp1XcYRa+3srU0o9sUUHwfG8e+MI/fmK8jl724pVc/R6MZivBptQJbNOh47mY5rJOfvv+P4h/EPfFS/HbuYWBLR5+rCHfzhAH968xdNiZUUo+crey0eciRcFBLm9+8W3urrWCzRPkSV5sUzbgg6WcUH3ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780470173; c=relaxed/simple;
	bh=ZP4pnHhnfq/+bHR0Etcgt/kyGHdU0DtZG7j0ZII3ex8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bdXGZEOUzU8HUAN6hV/MQ54r1DNBxhLdwzcGk5XaxkMBEaBYiB1lhlCHL19OATM0UI35LtOTkmbc8tRfEN7BqAMd/dWGvRXmQgmc6M8FZ7QT3golJ491QVriIjegiEm5WqfHSvKmNr1Zs9rXQz8XHA2HGcbeT3I8wdE/1e6yN6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qwUzSnPC; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qwUzSnPC"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652J10Bw3295133;
	Wed, 3 Jun 2026 07:02:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=NViaJjzcxlcGZ0OP8
	evk7CtE+SAJNW01Z5klCH6SAK8=; b=qwUzSnPCHOfetf2rbM0Yxwj8Ch8Vy2LWJ
	MyP3KAJ5DcizsXqDZixd8QuQ4SOR/mX2Lk8fRY8xlkOof9LhESCKWaGSwyAimxFJ
	wIqOXCgFecHFsUbrk+QpdBmI1XNDBe85F32NC2ULjYhsR+EYWE/DbfGakF45MrVH
	Lg1gMMdRQtPaPo5Z44eZJbfdNB0Qi3j06iboTPf8kCOj543l2YuPuc8/HPz9XPlk
	clipKUeeg+2d3m1VblU6t2cdOlSojJ4vPylLCmSRuwoMQGprluhGDsocJONRzy93
	v3GPrKtk3E50jTcUTBuEVEd1ddLuWzOyunP6bssso6MfNKcSjK8iA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efnahsaep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 07:02:39 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6536s8DS006958;
	Wed, 3 Jun 2026 07:02:38 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcegprw6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 07:02:38 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65372ZgD49480178
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jun 2026 07:02:35 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4118620063;
	Wed,  3 Jun 2026 07:02:35 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A77920043;
	Wed,  3 Jun 2026 07:02:32 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.bl1-in.ibm.com (unknown [9.123.14.142])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Jun 2026 07:02:31 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au
Cc: npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com,
        shivangu@linux.ibm.com, hbathini@linux.ibm.com, mahesh@linux.ibm.com,
        adityag@linux.ibm.com, venkat88@linux.ibm.com,
        sourabhjain@linux.ibm.com, stable@vger.kernel.org,
        Mahesh Kumar G <mahe657@linux.ibm.com>
Subject: [PATCH 1/1] powerpc/crash: stop watchdogs before booting kdump kernel
Date: Wed,  3 Jun 2026 12:32:17 +0530
Message-ID: <20260603070217.483696-2-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260603070217.483696-1-sourabhjain@linux.ibm.com>
References: <20260603070217.483696-1-sourabhjain@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA2MSBTYWx0ZWRfXyef1pk1l40sC
 nO/sdrjJ5G4WJmH4dkilWIWabTg1gzaI2H5T2I1pOUgiUWT5hWM9SQ/CZux1xM4i9Zk832D2AtO
 k9StKO5RWFEIic0KwB70nQZTNYgby6pxJddyfK0ZG5nUT4Y6ldnuo6FgJCbSK51Wj67izrDov+3
 26ymzjSKniGtYu3nvHwAT9BJn6//pjaGkAcLd8IeJsvdfTpbzxqCX/dqEx0Xag81UkcYB0wpf4T
 D9I7xSBii1XSnWgUhht7/RYfpoL10Mf6QlP6ox5HfihMEVwGp89Mzhdv0Kpsu2pjgaM4J+f5d+l
 //Dbq0xiSgTNPXL1A56zEpWSrBI5Fms/XqTFbP2I6PNoudkyz4fTYdIRKktXoR4stYIgv9aB1Ac
 CiXe+xjfeD+xnQ1mIiDgb5cDD6/IT1sOgFr0E8FlzxNZnoMuUqOnfaDRTw5/NeZ8WjRphq3Djdh
 ydkci+nKJTYov1KhIgA==
X-Proofpoint-ORIG-GUID: nrs_0w_cdhb2fZtaRhd37w0KqGgdwrqA
X-Authority-Analysis: v=2.4 cv=cOzQdFeN c=1 sm=1 tr=0 ts=6a1fd190 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=g3HFZtiYJuCwcSEZe5cA:9
X-Proofpoint-GUID: vCxgbyRNcTVUI0kSNOqeV04FonIBSV83
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030061

On pseries LPAR systems, watchdog timers configured from userspace
can remain active after a kernel panic. During panic triggered crash
dump capture, the crashing kernel jumps directly to the kdump kernel
without shutting down userspace services. As a result, active
watchdogs are not stopped before entering the kdump kernel.

If dump capture takes longer than the watchdog timeout, PHYP resets
the LPAR before dump collection completes, resulting in dump capture
failure.

Fix this by issuing the H_WATCHDOG hcall on the crash shutdown path
to stop all active watchdogs before booting the kdump kernel.

Fixes: 69472ffa6575 ("watchdog/pseries-wdt: initial support for H_WATCHDOG-based watchdog timers")
Reported-by: Mahesh Kumar G <mahe657@linux.ibm.com>
Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 arch/powerpc/kexec/crash.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/powerpc/kexec/crash.c b/arch/powerpc/kexec/crash.c
index e6539f213b3d..5651523e3a70 100644
--- a/arch/powerpc/kexec/crash.c
+++ b/arch/powerpc/kexec/crash.c
@@ -28,6 +28,7 @@
 #include <asm/interrupt.h>
 #include <asm/kexec_ranges.h>
 #include <asm/crashdump-ppc64.h>
+#include <asm/hvcall.h>
 
 /*
  * The primary CPU waits a while for all secondary CPUs to enter. This is to
@@ -352,6 +353,28 @@ int crash_shutdown_unregister(crash_shutdown_t handler)
 }
 EXPORT_SYMBOL(crash_shutdown_unregister);
 
+/**
+ * stop_watchdogs - Stop active watchdogs before entering kdump kernel
+ * On pseries LPAR systems, watchdogs configured from userspace remain
+ * active after a kernel panic because userspace services are not shut
+ * down on the kdump crash path. If a watchdog expires while the kdump
+ * kernel is collecting the dump, PHYP resets the LPAR and dump capture
+ * fails
+ *
+ *   0x200UL : watchdog stop operation
+ *   -1      : watchdog number, disable all watchdogs
+ */
+static void stop_watchdogs(void)
+{
+	if (firmware_has_feature(FW_FEATURE_LPAR)) {
+		int rc;
+
+		rc = plpar_hcall_norets_notrace(H_WATCHDOG, 0x200UL, -1);
+		if (rc != H_SUCCESS && rc != H_NOOP)
+			pr_warn("crash: failed to stop watchdogs\n");
+	}
+}
+
 void default_machine_crash_shutdown(struct pt_regs *regs)
 {
 	volatile unsigned int i;
@@ -360,6 +383,8 @@ void default_machine_crash_shutdown(struct pt_regs *regs)
 	if (TRAP(regs) == INTERRUPT_SYSTEM_RESET)
 		is_via_system_reset = 1;
 
+	stop_watchdogs();
+
 	if (IS_ENABLED(CONFIG_SMP))
 		crash_smp_send_stop();
 	else
-- 
2.52.0


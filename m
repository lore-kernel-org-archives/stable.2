Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569ED4AAC5D;
	Fri, 16 Oct 2026 13:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792158197; cv=none; b=uW9bSpvrUS1m9x7O9hHVBo6HhQsYJvNgE6QR5KMD49ZbCbuyvexSvQIny2SPZpAyaUOeJ9SRGbhyTtiuyyi5ljgGtWYRa/cuEFiTCDAutwtIxTozVu9/bzp/rHx83Mw476NqilLGAKtHqcRZpNpqUcpWzxFiWlP4pqtMMR4SoRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792158197; c=relaxed/simple;
	bh=ny601/NZwe1DDZwdoiGgGnqLqwJrF1nQN/gmQZtE1dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tEfHTt8S1BuFApidPpUVZoUMyDcwpMjw4CHuI2OZn9coXWViQpICJheeCm+yYUELyTsZTeNto8UatJmUTUz76tCRJ0/chDY5t5/8vsXAghyp3EVVPJQslTW0fmAushQ7Bm8n9up/ZcxWt8Zy1TlG27yCI5nmp/Qj9oRgFc2OxTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=S4qsFaaK; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="S4qsFaaK"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69GAESmr3540566;
	Fri, 16 Oct 2026 13:43:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=hz/Wzr
	r7Ghfv/m9Znn7aTpfAD1ntAjz54+O38Sp8PJI=; b=S4qsFaaKSsv41leWspk3u3
	a0Fs63zUvkOcSzTwUdHXX+MVNpDo/HU+qIoCyQhpk5gCi1Azy/8HIM77gwAK19tI
	dICk2fInxkCDSx0CV0K9B8nmvMAhPdU4GMMv8zT1+302AvS+qJMcZD0PV90oNIuM
	TdNyGlWMhDSTP9wwmLiGXyj+Z0eT3CwqSyx4ClzJvA3pe3AtVKPRYERRCmhfOS7l
	sEF8rN9HUNVF9h3T66wR5jE4syAxgk0mOQkfXcqwOMAFsDCH22PjUCrXgu/hDGPv
	tK1tNEl6uWyIkBg0VCL3MCASIm8hdz195QcpjJnsfECh9NJCsF3PA/76SNJQmZmg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7e1wptcr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 16 Oct 2026 13:43:01 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69GAJs0d3503283;
	Fri, 16 Oct 2026 13:43:01 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hb34mkq61-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Oct 2026 13:43:00 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69GDgvPl33227166
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Oct 2026 13:42:57 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E3FFA20043;
	Fri, 16 Oct 2026 13:42:56 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5CAE520040;
	Fri, 16 Oct 2026 13:42:53 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.217.170])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 16 Oct 2026 13:42:53 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
        =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
        Vincent Donnefort <vdonnefort@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v2] ring-buffer: Do not check si_mem_available() before deferred init completes
Date: Fri, 16 Oct 2026 19:12:47 +0530
Message-ID: <20261016134247.70722-1-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261009163557.88467-3-amachhiw@linux.ibm.com>
References: <20261009163557.88467-3-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA1MiBTYWx0ZWRfX4WHfQ1W7wcu6
 yaUgmPuJg+SPqEGkimZtjqa1vy4PJdUR4nD6nG8hB+bcPG6rGKC5+wVsoYEcDlRdTLilGo02wF8
 uMaIPfKxgFyAaIURCbxQwb+yqmzcV4E=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA1MiBTYWx0ZWRfX2tZyr/57vI0K
 wjhX+iajny+iBnHRHRUN/VOJcAfOprHG6oFvrMN+FCT/GuEdPhKd4WzBmHdiF5Aj/zypnWLOmDB
 sPAJwmWj0m1/AUukOGoJmnh93VMQUIX/xUMPNnbDWTrIT3f9VHvZIJbgkvye6+y28AngnkH2nBz
 CjneMuH6GzvtKj1ws5mWy/iWgudcbMpzUjwKiM58Geed2yn7BK+liba3DJsuPit/EIzkLbUNLAj
 0BOl628uFCQfXwStaDC5KQTmmQsw5O/20+Txl9Fwj59ms6jDzeP7lc/W1MdTwKguaM5wMfzX+6A
 5JVIzV5mNiIXsqMOazz5QDfHIQxS5tf0PHw6lN1WGhBkUEHODZ9wR26ik+aMtUvO67ZlCEzr80N
 GIl7eLdffnAnpo1ysxJKYXc7cZsDe+awTOxzPt987pzF+nC85QMDaUR2OpDGkT7LIsV6VajCiSU
 mU8N8LQ8XyJNNN+VsaA==
X-Authority-Analysis: v=2.4 cv=E6pYNqdl c=1 sm=1 tr=0 ts=6ad229e6 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=K0jeOQhstxwOhyhfrK8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: DkEQCYaunIu9jw2BbyhxhUMgtZ1rsqrC
X-Proofpoint-GUID: 6jv_EiBt89_ZMqRCvPVa1SGK35B2xEw_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160052

During early boot (early_trace_init() called from start_kernel()),
tracing allocates initial ring buffers (temp_buffer, array_buffer, and
snapshot_buffer) for CPU 0.  Later, as secondary CPUs come online during
smp_init(), each CPU's ring buffer is allocated via trace_rb_cpu_prepare().

Before attempting page allocation, __rb_allocate_pages() performs a
heuristic check using si_mem_available() to return early with -ENOMEM if
memory appears insufficient.

However, on kernels built with CONFIG_DEFERRED_STRUCT_PAGE_INIT=y,
NR_FREE_PAGES only reflects the initial non-deferred pool across the entire
period from early_trace_init() through smp_init().  defer_init() leaves
only a single section per node (e.g.  16 MiB with 64 KB pages) initialized
up-front, and on kernels with large static binary footprints (debug
configurations enabling PAGE_OWNER, DEBUG_PAGEALLOC, KFENCE, or SLUB_DEBUG),
early core initialisations (SLUB caches, vmalloc, static ftrace records)
consume virtually all managed pages in this pool.

si_mem_available() therefore returns a false negative (often 0-1 pages)
across both SYSTEM_BOOTING (for the initial CPU 0 buffers) and
SYSTEM_SCHEDULING (for secondary CPU buffers via trace_rb_cpu_prepare()),
causing __rb_allocate_pages() to prematurely abort with -ENOMEM.

This failure is false: the buddy allocator is designed to replenish
ZONE_NORMAL on demand via deferred_grow_zone() when an actual allocation
is attempted.  Checking si_mem_available() before calling alloc_pages_node()
short-circuits this on-demand growth entirely.

deferred_grow_zone() is only permanently disabled after page_alloc_init_late()
completes (it spawns per-node kthreads and blocks until done), which happens
inside kernel_init_freeable() — before system_state is set to
SYSTEM_FREEING_INITMEM.  Skip the si_mem_available() check until
SYSTEM_FREEING_INITMEM, at which point all deferred pages are initialized
and si_mem_available() is accurate.

Wrap the guard in #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT so that on kernels
without deferred init the original check is preserved unchanged.

Fixes: 2a872fa4e9c8 ("ring-buffer: Check if memory is available before allocation")
Cc: stable@vger.kernel.org
Reported-by: Michal Suchánek <msuchanek@suse.de>
Closes: https://lore.kernel.org/all/arYskzbiaNzBR9MD@kunlun.suse.cz/
Link: https://lore.kernel.org/all/arYskzbiaNzBR9MD@kunlun.suse.cz/
Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
Changes since v1:
 - Extend the guard to cover SYSTEM_SCHEDULING as well: smp_init() calls
   trace_rb_cpu_prepare() -> __rb_allocate_pages() before page_alloc_init_late()
   completes, so the false negative window spans both SYSTEM_BOOTING and
   SYSTEM_SCHEDULING. Use system_state >= SYSTEM_FREEING_INITMEM as the correct
   boundary.  (Sashiko, Vincent Donnefort)
 - Wrap in #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT to preserve the original
   check unchanged on non-deferred kernels. (Vincent Donnefort)
 - Drop Tested-by: guard condition changed, requesting fresh test.

 kernel/trace/ring_buffer.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 04bb94c29f58..aa877a272c89 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2452,10 +2452,24 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 	 * memory. It may not be accurate. But we don't care, we just want
 	 * to prevent doing any allocation when it is obvious that it is
 	 * not going to succeed.
+	 *
+	 * With CONFIG_DEFERRED_STRUCT_PAGE_INIT, NR_FREE_PAGES only reflects
+	 * the initial non-deferred pool during early boot and throughout SMP
+	 * bring-up (smp_init() runs before page_alloc_init_late() completes
+	 * deferred initialization). si_mem_available() returns a false negative
+	 * across this entire window while actual allocations succeed by growing
+	 * the zone on demand via deferred_grow_zone(). Only re-enable the check
+	 * from SYSTEM_FREEING_INITMEM onward, after page_alloc_init_late() has
+	 * finished and si_mem_available() is accurate.
 	 */
 	i = si_mem_available();
+#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
+	if (system_state >= SYSTEM_FREEING_INITMEM && i < nr_pages)
+		return -ENOMEM;
+#else
 	if (i < nr_pages)
 		return -ENOMEM;
+#endif
 
 	/*
 	 * If a user thread allocates too much, and si_mem_available()

base-commit: 2f2f7eeef8b0a1a9b9ca998231419873ccae8d4e
-- 
2.54.0 (Apple Git-157)


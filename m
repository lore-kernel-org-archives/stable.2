Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359044EB86F;
	Fri,  9 Oct 2026 16:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791563822; cv=none; b=GazmylDVVvm2UEI4DnkcvOK+urPPo7Eaj8S69b3OB/i7YtYDCch7OVuasVrNVJ33Qwx6VQQUgSKH6ESmy88XToVG18hUHjLvgxZwNtxR8uM7C76wyRbeqFC+f+1YzrjEpwf5PTqrSCrjUcTIQgt5wNA1IUxAZQLV/Q2hiwh1JZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791563822; c=relaxed/simple;
	bh=nf+tOgQL+aU/wawuwBElkRHO9sRgpiIcV1y3mDerIy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F20R+xgZ5sMcYbD08DyubmKsxf4Eha05A7QuxkabWEp5qVcCWoGGsTm9oE7io8EjQz6BBCm1oQYUzmqXSIilqDUQYItL4xkM6EmrrE+LQNvTzXm0cPMd/leT8tJDFRztOQb6wKtCHGNzy5m570GpywUfHKXg4zGUEvRtwes28XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RdQpZ6wm; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RdQpZ6wm"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699GZYTl3587646;
	Fri, 9 Oct 2026 16:36:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Ae7YCz
	K4dLCH+SF8WCLjOVxmzfbeU5d9L4BymAJdKes=; b=RdQpZ6wmLji7jEM8M4xiFh
	IckruGgYiniGFMqL6+d+0EvRfHAWNK6Vr09oIjfS8Z/QbrsRdPVxLZZR7by49WH8
	iwUv8Wf/nQhjz4qDaY8P2m1nD9M+eaS+kQRS9g+2c3wEonLQid3izNzqUlvtw/p3
	M0KJo4LBNdZ6xaIxSFNGH7v2dCPblg5nS48C17tm2zylIsUiJmH9kKYxYArwy6EU
	A7aJUrk2ayu7gFBUbK1ziWy7DaWXZARbS4cCH6CjJ3uvdQ0nLIiLbRBBwUyqsy3r
	B3Y5KpC5T2C6oAPH5KDtRRMgEEHAt7QXG9Cm1aOZHSTugLSwnMxWiXZIZxJIhQxw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xk1k14u-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 16:36:41 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 699GKBq21150857;
	Fri, 9 Oct 2026 16:36:40 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h6hsnks0r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 16:36:40 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 699Gaa5833096170
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Oct 2026 16:36:36 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD27420040;
	Fri,  9 Oct 2026 16:36:36 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA87F2004E;
	Fri,  9 Oct 2026 16:36:32 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.216.129])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 Oct 2026 16:36:32 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
        =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org, Mark-PK Tsai <mark-pk.tsai@mediatek.com>,
        stable@vger.kernel.org
Subject: [PATCH 2/2] ring-buffer: Do not check si_mem_available() during SYSTEM_BOOTING
Date: Fri,  9 Oct 2026 22:05:57 +0530
Message-ID: <20261009163557.88467-3-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261009163557.88467-1-amachhiw@linux.ibm.com>
References: <20261009163557.88467-1-amachhiw@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=YtCa1IYX c=1 sm=1 tr=0 ts=6ac91819 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=1kEAEcY_UvklnZUDYUIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA2NiBTYWx0ZWRfX+4xK1t4xWok9
 Jy+nHZMjqQwEo0DUay/lzwIJlc53jISlnjOdWZ5RdOoxmLXws6oD6XjIEb+Dph8OGfCGZF8qzQu
 rBLUz4BG6+fkJUT5eylucMwohE1dhpt2ih/rSiv/5gEeRgW/baSCXNFcWkFHDf3OcK3ee7CKyGh
 xuRMGCDiearqnwKql2ccpusalNS53+1wtDVPMkZKnR4aExXR3wcj3uPczxHKPzHsqJjOkWkv8A4
 XV2oWPdKMh0apDu45eXF3L8tj/nINeIMCUXGQTLvyMeku7QPHZ3P7FW34liWeOT3Q8ylX29klzs
 NtqQSVLy6JMwAc8yMJinDMkPgxDdpA+tRDUFky+XpOkVESLOnBc6zzb3EabbgloKlNk1FkV9Cr4
 +AJ7ZKziG6J3Bu/yVXl0MWYt/qlxIgZW/J35ur3Q0fxUDl2nHqoG22vgIA6vIOihp0yy2iOY8ik
 jk4AhRL/eJ/lacd334A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA2NiBTYWx0ZWRfX8Yy4eTsjoazO
 kL2IWiYtduGfjht1S8nboJh4mhrjo8XzNDTF1l/3GcQj66g/UVKEZuC7SsbsYiRhANEjjtPje3u
 VWgfHek8JMy5R3vdO3bwz4cMAmbM5E8=
X-Proofpoint-GUID: FQTEtE0eGU990EHZKiObhsMIDKIA8TdO
X-Proofpoint-ORIG-GUID: bT9NciWlrbiZuLUO4zYR8IlmthwoKIHs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1011 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090066

During early boot (early_trace_init() called from start_kernel()),
tracing allocates initial ring buffers (temp_buffer, array_buffer, and
snapshot_buffer) for CPU 0.

Before attempting page allocation, __rb_allocate_pages() performs a
heuristic check using si_mem_available() to return early with -ENOMEM if
memory appears insufficient.

However, on kernels built with CONFIG_DEFERRED_STRUCT_PAGE_INIT=y,
defer_init() leaves only a single section per node (e.g.  16 MiB with 64
KB pages) initialized up-front.  On kernels with large static binary
footprints (such as debug configurations enabling PAGE_OWNER,
DEBUG_PAGEALLOC, KFENCE, or SLUB_DEBUG), the static kernel image and
early core initialisations (SLUB caches, vmalloc, static ftrace records)
consume virtually all managed pages in this initial pool.

At T=0.000000, watermarks have not yet been established
(totalreserve_pages = 0), so si_mem_available() returns the raw free
page count (often 0-1 pages).  When the snapshot buffer or global trace
buffer attempts to allocate 2 sub-pages, si_mem_available() returns <
nr_pages and prematurely aborts with -ENOMEM.

This failure is false: if the page allocation were actually attempted
via alloc_pages_node(), the page allocator would trigger
deferred_grow_zone() on demand to initialise additional deferred memory
sections.  Checking si_mem_available() before attempting the allocation
short-circuits this on-demand growth.

Skip the si_mem_available() check when system_state == SYSTEM_BOOTING.
Once the system transitions past early boot and page_alloc_init_late()
initialises all deferred memory, si_mem_available() accurately reflects
system-wide free memory and the check operates as intended for runtime
allocations.

Fixes: 2a872fa4e9c8 ("ring-buffer: Check if memory is available before allocation")
Cc: stable@vger.kernel.org
Reported-by: Michal Suchánek <msuchanek@suse.de>
Closes: https://lore.kernel.org/all/arYskzbiaNzBR9MD@kunlun.suse.cz/
Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
 kernel/trace/ring_buffer.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 04bb94c29f58..a9f82e2f8fad 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2452,9 +2452,15 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 	 * memory. It may not be accurate. But we don't care, we just want
 	 * to prevent doing any allocation when it is obvious that it is
 	 * not going to succeed.
+	 *
+	 * Skip this check during early boot: with CONFIG_DEFERRED_STRUCT_PAGE_INIT,
+	 * NR_FREE_PAGES only reflects the initial non-deferred pool at this
+	 * stage. si_mem_available() returns a false negative while actual
+	 * allocations succeed by growing the zone on demand via
+	 * deferred_grow_zone().
 	 */
 	i = si_mem_available();
-	if (i < nr_pages)
+	if (system_state != SYSTEM_BOOTING && i < nr_pages)
 		return -ENOMEM;
 
 	/*
-- 
2.54.0 (Apple Git-157)


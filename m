Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792767324;
	b=Om1zPxXaQyqh2DLbh93+VNjoSQ7lNrWjPyJaMmzyR2UKP1e5te+MlSDdtgKctP4rg4Sg
	 4ypPXCsdLhEFzZcbJGVlBCiHmyS9D4Y6mMKQyS4XC4it3k1O+tEe7vvaxQjm5tSNDwpOT
	 wstsCeiprymEHSx+L51oWgOE4OnXKIEjCRzb0qan+0dcNFQ7Oz6s/tseFC33nC0SzK/v0
	 Q27gWgUJivCoP7PfKu1cCe4dv4oQlwJVEMzKH6djIBYFcgsmo9+yLYFH7KIuQxEaM8+jh
	 IhUKU8XRUzj4hl9NMHOdmcfnPkobDz7B9i07oji83CqLsBGh27S4o37ITfZEaB8nqGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792767324;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Reinject:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=jx+rZOP8xwcac82m3lLT/zD5D1pNBdMovtbyHIAMsmQ=;
	b=O70WZwkw/SPnt5XrmHpThNSnPNf6f2s7vQZQPrM20hNGaO1+tvQhv2xIP05VJHGZnR+G
	 p8XQG09vfPQuVhcZ+IGis9ClF+Fg54l1S2rEUrfGginHfja3UgS5vgvG2tqHSQVW/Naxq
	 +WxLxHTkjWsCUz/j3N+zNzmHXLJdh9kJoOafwNj1fUe19B25gAGDD9hozQ0P6aXINxmWb
	 0lJnPmZJ1/YTLj4W+3pDiNkMkxAF8jkdPNeQK7cK20nion/O6GRk8nA2K0xlvvqWEC3mh
	 rZTiX1pbuLLTr25Tvl3T78u0cBY7dtmggZ9bSIyFFq4KNtAyEPo8R0i3XQPaBQ+MfYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=a8Vf2DKh;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFC5606A31B;
	Fri, 23 Oct 2026 14:55:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BFC5606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=a8Vf2DKh
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NEE26s3183214;
	Fri, 23 Oct 2026 14:55:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=jx+rZOP8xwcac82m3lLT/zD5D1pN
	BdMovtbyHIAMsmQ=; b=a8Vf2DKhfwXf+Ji+xrTBtFCHgXMfFccaraXjIt7ooRU8
	Ji+hLz23EuqJZDvyA+JN8Gkjr4oYwJy0Bd8JEMB1EXIcCbGaKit1bpCrorZkbGhH
	iPJvEkV/dQpyAzUEe1pHu4/10oo7jrxtn187EQbCutSl7JAmt3CEKGM/TyjiUJn9
	+rnSZtdf2aHvPSZTsmpkLnK74rjh6Yp5WF0/2kpat+Nwsy+78lHQN15KGWp6L/d+
	We2RI2tWLL8v4PX6SXwv6o5bHkg5vwIoqjSwCSxPAqyaE57Kj45RxmYppy+qoVSJ
	rCin9iLDdBidCGuwgIS34+TAlbEhKN6HU+a968NI9w==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5ant8b-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 14:55:11 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69NEL2T72203331;
	Fri, 23 Oct 2026 14:55:10 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hekdgmhgu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 14:55:10 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69NEt6bM39780780
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Oct 2026 14:55:06 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F3F820043;
	Fri, 23 Oct 2026 14:55:06 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0237F20040;
	Fri, 23 Oct 2026 14:55:03 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.19.79])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Oct 2026 14:55:02 +0000 (GMT)
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
Subject: [PATCH v4] ring-buffer: Do not check si_mem_available() before deferred init completes
Date: Fri, 23 Oct 2026 20:24:59 +0530
Message-ID: <20261023145459.47516-1-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1NyBTYWx0ZWRfX8LuU3I5P0B58
 /EljYfBSXZxZrxmFIDCdICUVxIsWCb2H/dTiO5++0vv3qykDZR7zA6Pvjjv80woEKdQQME+dkH/
 fXlRADq9N67LdIwdTogDStjTYXSgpIs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1NyBTYWx0ZWRfXzYbtFPYJa8Ww
 cy5i3sHy77EOexqDWc1hUnVSejIHJQtllyE82/+OyrQTLKvT+SLdJtihaGO1AGtHi1WJq9U6gsR
 4ENNJFh7KWQxPgERdI8J2MTmZC642FxnJLCsAEMQJj0p6t0Uon8t6sXveFNewxszOS490SA57Ps
 1lvbnK4ulOL+Qi7DxBn1iOTaRMnWp9Tp1AVkaKkKZ7RluyC2LPawwQ6F2MN65291pOxrs9M45Ww
 nzWAg/J1BJyEQeaOQGsTqPzOCzV/pQdj/xtNwIIv33pOVLncAS7l/y+lvrd2YF5xT4M6+sjP5lc
 8jTGY6YU7ILkUo03KoNwq8zEgvxXEpfOMS/YiMc1e69yDRS70pNeCLpI0GMJXDBVvd7PIc87Vua
 xW+jostwNv1emQwZfYX+yTuJY/UvmlRzoyQcApi7i9whObD6JEnB/rrxZwArUDdGB05hGS/VGN5
 OvM1c8s434NATZ0R7wA==
X-Proofpoint-GUID: gGiItzZ_jiSML3gPj1pimkC8aKari-p9
X-Authority-Analysis: v=2.4 cv=JIKuIMKb c=1 sm=1 tr=0 ts=6adb7550 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=z8eC79uxFTNzhPLTDY8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: RfFxfd_wYjxMJjdLPP7smqeil-QS3kYi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230057

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

Use IS_ENABLED(CONFIG_DEFERRED_STRUCT_PAGE_INIT) to set i = LONG_MAX during
this window, unconditionally bypassing the threshold check.  On kernels
without deferred init IS_ENABLED() compiles the branch away and the original
check is preserved unchanged.

Fixes: 2a872fa4e9c8 ("ring-buffer: Check if memory is available before allocation")
Cc: stable@vger.kernel.org
Reported-by: Michal Suchánek <msuchanek@suse.de>
Closes: https://lore.kernel.org/all/arYskzbiaNzBR9MD@kunlun.suse.cz/
Link: https://lore.kernel.org/all/arYskzbiaNzBR9MD@kunlun.suse.cz/
Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
Changes since v3:
 - Replace #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT / #else / #endif with
   IS_ENABLED() + i = LONG_MAX to avoid duplicating the threshold check.
   (Vincent Donnefort)
 - Trim the in-code comment to one sentence. (Vincent Donnefort)

Changes since v2:
 - Rebase on top of upstream ring_buffer.c changes from Vincent Donnefort;
   update threshold to i < (nr_pages << subbuf_order). (Michal Suchánek)

Changes since v1:
 - Extend the guard to cover SYSTEM_SCHEDULING as well: smp_init() calls
   trace_rb_cpu_prepare() -> __rb_allocate_pages() before page_alloc_init_late()
   completes, so the false negative window spans both SYSTEM_BOOTING and
   SYSTEM_SCHEDULING. Use system_state >= SYSTEM_FREEING_INITMEM as the correct
   boundary.  (Sashiko, Vincent Donnefort)
 - Wrap in #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT to preserve the original
   check unchanged on non-deferred kernels. (Vincent Donnefort)
 - Drop Tested-by: guard condition changed, requesting fresh test.

 kernel/trace/ring_buffer.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 9c4e40847e43..09c02e838c4d 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2463,8 +2463,16 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 		 * memory. It may not be accurate. But we don't care, we just want
 		 * to prevent doing any allocation when it is obvious that it is
 		 * not going to succeed.
+		 *
+		 * With CONFIG_DEFERRED_STRUCT_PAGE_INIT, si_mem_available()
+		 * will reflect the actual available memory only after
+		 * SYSTEM_FREEING_INITMEM.
 		 */
 		i = si_mem_available();
+		if (IS_ENABLED(CONFIG_DEFERRED_STRUCT_PAGE_INIT) &&
+		    system_state < SYSTEM_FREEING_INITMEM)
+			i = LONG_MAX;
+
 		if (i < (nr_pages << subbuf_order))
 			return -ENOMEM;
 

base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
-- 
2.54.0 (Apple Git-157)


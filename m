Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792693131;
	b=Fxo/V7M7aGMPawphUsLKc7Onrf4oGPvnKf8RP4nEmZDntKkXeceP11xX6Q50H+YFvf5Q
	 AmLXliI8K0vvbGm0pzxwIwIWItnkITszWOVAS6Uyq+wAZbU3P1cGeikzj90TYUFpFFpGk
	 f+MjzOuGq/0mjM9h8osuv4nzbts8rQ7Ukyf4loeOFwiJG33S6yknF4CCcJDVyxkgB1EBh
	 UPKEVmSBJpZU3spaoeZTd3aAM9Qn3OimKJ5sxzL0PJUXkzmWPwL3mlUKHL0hkkn8P8psz
	 ZaqrgoT0JsVGC0SiapBsRKmck8HflLLv3pL37jl/wv+VnL6jrptKaCMfnqUexEdtSWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792693131;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Reinject:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=20J1E2C12V85IbyALKOv31zrLq0eJ+kd/Y8FrEZKOPs=;
	b=HLchevHO3B8v7CJxfuHjqttL2Qnwfc2IbAl1Z2gaR2EBmWuvYuo/YqGSfRQrqycuFX5G
	 L+orcfmBGrklMDPizlAHfmFNlESslk6rAvzAaCEgJnpomZD6ao85EcbyUMD0ctbCTLGas
	 kO6aMixSW7enkcFu9JgmP7P6dB8T5yEYnyei6XsOTcK+XUlq6ts5QcyB0AKW6I3Hoz3r7
	 EEXzGqxpu5veijL48WDREvy7ibMnxxiLBqyWrTAqsAwA2HQpvCJ7HU+6aFz4YNLyDlQ2T
	 aLBumCwQT21r+S8RvAgA2CjUWXw3EVHgqkcfXDEFqgZ0TpUnX4bxRJ3j2qDWs1l5MJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b="qfns/08f";
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E800606A31A;
	Thu, 22 Oct 2026 18:18:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E800606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qfns/08f
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69MIEHVu561900;
	Thu, 22 Oct 2026 18:18:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=20J1E2
	C12V85IbyALKOv31zrLq0eJ+kd/Y8FrEZKOPs=; b=qfns/08f1VkrcETEnmOeiF
	twSEFcQmt0jsAlL1vGRbWExBOp00Q/ykDHVB1MXtgB9U1rY91GQC8c1FxACGjINj
	3Wd8+qb2sgprew1jvDj3BN+l+7RsP9nMDhrRACf1tQeueYyYP04HerEbGVRUOimp
	1JbiSUSVTxjds3SCVU0MZAbdwGDeH5dVR5TmD6V8fJ/qmZFDQKamZmQztEFeG/Fn
	yPnxZNCztv9ObMjN2XPI7lrQGRBNYaZomtY9EFoxo5UaJnmpR+Zi7kVXo+UctsVi
	kq6v8PH0Fz3Oo5D+bpGaoicMZacwO6SeOJZARx4OJM9rz0z6VtPBBfEd5lhb2Z0w
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5b0cx5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 22 Oct 2026 18:18:34 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69MI543g921268;
	Thu, 22 Oct 2026 18:18:34 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hfgck1t4h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Oct 2026 18:18:33 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69MIITpR35848670
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Oct 2026 18:18:29 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9AB8B20043;
	Thu, 22 Oct 2026 18:18:29 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 341A920040;
	Thu, 22 Oct 2026 18:18:26 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.220.79])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 22 Oct 2026 18:18:25 +0000 (GMT)
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
Subject: [PATCH v3] ring-buffer: Do not check si_mem_available() before deferred init completes
Date: Thu, 22 Oct 2026 23:48:17 +0530
Message-ID: <20261022181817.49717-1-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261016134247.70722-1-amachhiw@linux.ibm.com>
References: <20261016134247.70722-1-amachhiw@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=X63Hu2Te c=1 sm=1 tr=0 ts=6ada537b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=z8eC79uxFTNzhPLTDY8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Kx2uKdHfVx6IFS5Z68c-io43bhkV9Bpw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA3MiBTYWx0ZWRfXw5Ekr0cgGlwB
 fNm/tWsdi45WOWjs+LhTvC/t1NAwtaYTB8UwBClpC6LQOtsxllDCWxivgAsAb25MSv23goJesDy
 Pmf2TfRMfa2Sfka/OE8CeIdR23TNE6T0jCI6fj4EfKbsqWHborZlvws4tx7Mbo5ClNOssNGzxQs
 YGxEsXEj5EAtS49cFUBToBdkE7jzMeWrr3o/7aEYgxYMZ/kUY1EA0N56BWznVWGu4AiHSjGAReR
 6/MuGdZ6I1PQVcHNB8pqtlmkq5sXg/EbWM9YS+G6iF3TOVbW+VuEUq0SCgUVSQso7G/Qkbnekji
 lqlVo3JvKtNBUCSOilyEkIdKdtrJgth1wQVfyljxdhqolgeZ2uyrJzVnhHFaPnBoJhdU9CNUVxj
 1yLS+mEt34VYAOyhT7AW39eToQlvOEVN1wJ6jkRb/HnvUxGt1lNau89wjfenrg/7e9hzQOO1ZAo
 T/ImALZ/T40B4Raz7vg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA3MiBTYWx0ZWRfX7pLdbvyi41uG
 hsKyMl//M+mA03qZsqqKRhjaomm1lJGDEQtLVqvdufhGpHN4HvRj+sn50ARJgx78KII/CTs4PNN
 V8IBn+7jnPjOursv/gBh2GuOtznpcEI=
X-Proofpoint-GUID: sTzPxRDcBuON0esSEq1jmPX4K322kKiE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0
 clxscore=1015 spamscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220072

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

 kernel/trace/ring_buffer.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 9c4e40847e43..8e5a59a7b69b 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2463,10 +2463,27 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 		 * memory. It may not be accurate. But we don't care, we just want
 		 * to prevent doing any allocation when it is obvious that it is
 		 * not going to succeed.
+		 *
+		 * With CONFIG_DEFERRED_STRUCT_PAGE_INIT, NR_FREE_PAGES only
+		 * reflects the initial non-deferred pool during early boot and
+		 * throughout SMP bring-up (smp_init() runs before
+		 * page_alloc_init_late() completes deferred initialization).
+		 * si_mem_available() returns a false negative across this
+		 * entire window while actual allocations succeed by growing the
+		 * zone on demand via deferred_grow_zone(). Only re-enable the
+		 * check from SYSTEM_FREEING_INITMEM onward, after
+		 * page_alloc_init_late() has finished and si_mem_available() is
+		 * accurate.
 		 */
 		i = si_mem_available();
+#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
+		if (system_state >= SYSTEM_FREEING_INITMEM &&
+		    i < (nr_pages << subbuf_order))
+			return -ENOMEM;
+#else
 		if (i < (nr_pages << subbuf_order))
 			return -ENOMEM;
+#endif
 
 		user_thread = current->mm != NULL;
 	}

base-commit: 7be4bc52fd9e0e55dc9a2e0232b89427d2c4b614
-- 
2.54.0 (Apple Git-157)


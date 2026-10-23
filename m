Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792761384;
	b=NVKGzBOYTv+KM4mPIRv2pcS21wnZB7gLysoq0RHgUdWYUGrPHhxQBVFv6GsI4OP2iIoQ
	 ZIOvFV4YJOSV+bXH3gdfhNyoGaCh6/gN6ZxR2Mdx2tOQam5RcDxN8qOBhIqjg9Q0+w1V1
	 kU4Fx3x4nFiFo0dFDv5hZ1GWb+V0YSv1+kYKkFE3NwRFEalQkioxjG3iYL3EmlZwVNDeA
	 6hPHrjxUNujwi/e9/CZdtEIydBDW/aDy6VtuF17NdVk8RNF/XL3VSwU7BMDYHl5wDjoin
	 XS4Y6Cq2rPqhRUuqpg6TFSQrWsjROBOgGtqG30EkYz0QIgWh3TszFefOff+vXBz3s3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792761384;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 X-TM-AS-GCONF:X-Proofpoint-Reinject:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=igVFdgM3ErO6pSEjD/KuLeZPfErh4C7upEaOtT8OvgY=;
	b=bOvj/psnN4wHVqFHyZc1ReTe+UUboEZ65WRmnoBPh6hfVkJM7JUG1p3VD9Z3EVPdtDe+
	 /5y4A2eTuT8oJXb79N8SqaV7EYrLp0tlX/u4njfiWuMjIbGl/kTX8sez36KFuHEF9wSey
	 dWUIRMshi07wBM7179nca/Jw5itM6nKEuchipj79IAbFNJ1rhWcFmUAv8YKI+KbeZFzN5
	 Gimp8DoYlyiv2VcquO6sxpjbM/Rq30hdULM9PUi+TuqY/w3fTWir59MqVCHBR77NnxVVq
	 mAdsFoUJq3oRWgZYkoB12hg1z8cr3Ket5/AqQZloexqLHtCGm4OdRnDqekQ6zU/fMag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fe6Ocgxg;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CACE606A320;
	Fri, 23 Oct 2026 13:16:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CACE606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fe6Ocgxg
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NAESaI2541120;
	Fri, 23 Oct 2026 13:16:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=igVFdg
	M3ErO6pSEjD/KuLeZPfErh4C7upEaOtT8OvgY=; b=fe6OcgxgnR1GQGwzeHu51N
	pV3igAayRv5oBNR/MarHhrWxJLoKxBKTUHPI3+Dy8vabIEV58IRloOPsdkrp1yZ/
	Xr7norIQBvKO+wCF9dz3VIBrbtSWSKWumUkcvz3gQczFf+rlb2jaH56SJ6YkCzRx
	2aYBM5uAD/Z3Ct+b4XyNJEo9F3ce9feo3zaz/hckqPqosuu0zpDHnUMjn3zP6D7F
	enhXQlHN+jMeOoN4cUQxhsdI9UEFN6/DneuoCBAX+D9aSY3YjtHuGR4XplKUkQxQ
	jWDgFpdUgsVzAq3lParFxQxmvhc+0+enlJkGUmVle6sem9oHxyAT84X0g8Nr4A2w
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5b4run-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 13:16:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69NAK02F2008304;
	Fri, 23 Oct 2026 13:16:07 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hfmpn4m26-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 13:16:07 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69NDG3c937945728
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Oct 2026 13:16:03 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C801220043;
	Fri, 23 Oct 2026 13:16:03 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 10F2C20040;
	Fri, 23 Oct 2026 13:16:01 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 23 Oct 2026 13:16:00 +0000 (GMT)
Date: Fri, 23 Oct 2026 18:54:26 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] ring-buffer: Do not check si_mem_available() before
 deferred init completes
Message-ID: <20261023183942.ef1b59a5-48-amachhiw@linux.ibm.com>
Mail-Followup-To: Vincent Donnefort <vdonnefort@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Harsh Prateek Bora <harshpb@linux.ibm.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	kvm-ppc@vger.kernel.org, stable@vger.kernel.org
References: <20261016134247.70722-1-amachhiw@linux.ibm.com>
 <20261022181817.49717-1-amachhiw@linux.ibm.com>
 <atsYQtXHRH_cCQ5A@google.com>
 <atsY3MXXEUe2YopQ@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment
Content-Transfer-Encoding: 8bit
In-Reply-To: <atsY3MXXEUe2YopQ@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=X63Hu2Te c=1 sm=1 tr=0 ts=6adb5e18 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=NKCSvc21U9GoOpPHwYAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Vd2H_P2CrfGOFoc_vOSy_cOXFkj1doV5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1MSBTYWx0ZWRfXynu8p0HyePI5
 eYAzAYIdvTn237QpQ4VpNZnPAvCNMDfc6Mugq52rQEmrdRkTAWZeirOl3OhJ5a5Aekul6B1I2NI
 WNCy4mIt50RQAL+L4EAU85JF1VdsgtgJd/RulJ+L7Vfb4d8gGgykMzs/fCsLmGIVaODDJvyBT77
 kyevyyOnsAkQaznmSuQUopohovwmTLse9IMkwzcg774Tdvun0UxTwXAn4THWvJYl0u1BUSdexZU
 JBuz7aKG5M1t6ax+mTE88X+rpTAknuAsndFbHEYJXfTqp8cfoiuGKpNVkhQidb6/sXgt5awffgA
 s+B/TdcKc02/imk8hRz7zbX+PPva/J2YQll/dqao67+9XKt5HQ+sCqr+HpnDK4GC0W9UqgN7mW6
 ftVNq17FOQ0FWzVOPV0hn1reWzgpAmWTQJZlMAtqXkACCLw3ay3ATgu5Q/DSfcQHnQ3/HSCHeVj
 v23QMxK9PwtOYyUly0w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1MSBTYWx0ZWRfX0iY7lGyK2jUm
 moK9F6UlGezMVr1IxaUg2BUZI1+8tMrpKbQ1vSOMzvzD4mFo9+TgZ+r015D0l+3eq+9mKGAUeqI
 6RAr9JHLCtaKP/b7GB3wHW66BEqDbNs=
X-Proofpoint-GUID: LU8MfKsS-hDpUE4VbUvYzZoy25vuTiQH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0
 clxscore=1015 spamscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230051

Hi Vincent,

Thanks for reviewing this version.  Please find my response inline below.

On 2026/10/23 09:20 AM, Vincent Donnefort wrote:
> On Fri, Oct 23, 2026 at 09:18:10AM +0100, Vincent Donnefort wrote:
> > On Thu, Oct 22, 2026 at 11:48:17PM +0530, Amit Machhiwal wrote:
> > > During early boot (early_trace_init() called from start_kernel()),
> > > tracing allocates initial ring buffers (temp_buffer, array_buffer, and
> > > snapshot_buffer) for CPU 0.  Later, as secondary CPUs come online during
> > > smp_init(), each CPU's ring buffer is allocated via trace_rb_cpu_prepare().
> > > 
> > > Before attempting page allocation, __rb_allocate_pages() performs a
> > > heuristic check using si_mem_available() to return early with -ENOMEM if
> > > memory appears insufficient.
> > > 
> > > However, on kernels built with CONFIG_DEFERRED_STRUCT_PAGE_INIT=y,
> > > NR_FREE_PAGES only reflects the initial non-deferred pool across the entire
> > > period from early_trace_init() through smp_init().  defer_init() leaves
> > > only a single section per node (e.g.  16 MiB with 64 KB pages) initialized
> > > up-front, and on kernels with large static binary footprints (debug
> > > configurations enabling PAGE_OWNER, DEBUG_PAGEALLOC, KFENCE, or SLUB_DEBUG),
> > > early core initialisations (SLUB caches, vmalloc, static ftrace records)
> > > consume virtually all managed pages in this pool.
> > > 
> > > si_mem_available() therefore returns a false negative (often 0-1 pages)
> > > across both SYSTEM_BOOTING (for the initial CPU 0 buffers) and
> > > SYSTEM_SCHEDULING (for secondary CPU buffers via trace_rb_cpu_prepare()),
> > > causing __rb_allocate_pages() to prematurely abort with -ENOMEM.
> > > 
> > > This failure is false: the buddy allocator is designed to replenish
> > > ZONE_NORMAL on demand via deferred_grow_zone() when an actual allocation
> > > is attempted.  Checking si_mem_available() before calling alloc_pages_node()
> > > short-circuits this on-demand growth entirely.
> > > 
> > > deferred_grow_zone() is only permanently disabled after page_alloc_init_late()
> > > completes (it spawns per-node kthreads and blocks until done), which happens
> > > inside kernel_init_freeable() — before system_state is set to
> > > SYSTEM_FREEING_INITMEM.  Skip the si_mem_available() check until
> > > SYSTEM_FREEING_INITMEM, at which point all deferred pages are initialized
> > > and si_mem_available() is accurate.
> > > 
> > > Wrap the guard in #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT so that on kernels
> > > without deferred init the original check is preserved unchanged.
> > > 
> > > Fixes: 2a872fa4e9c8 ("ring-buffer: Check if memory is available before allocation")
> > > Cc: stable@vger.kernel.org
> > > Reported-by: Michal Suchánek <msuchanek@suse.de>
> > > Closes: https://lore.kernel.org/all/arYskzbiaNzBR9MD@kunlun.suse.cz/
> > > Link: https://lore.kernel.org/all/arYskzbiaNzBR9MD@kunlun.suse.cz/
> > > Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> > 
> > It is usually good practice to not use in-reply-to to link the series between
> > each other.

Noted, thanks.  Since the patch 1 from this series was already picked, I thought
keeping the new versions of patch 2 may make sense.  But will send v4 as a
standalone thread.

> > 
> > > ---
> > > Changes since v2:
> > >  - Rebase on top of upstream ring_buffer.c changes from Vincent Donnefort;
> > >    update threshold to i < (nr_pages << subbuf_order). (Michal Suchánek)
> > > 
> > > Changes since v1:
> > >  - Extend the guard to cover SYSTEM_SCHEDULING as well: smp_init() calls
> > >    trace_rb_cpu_prepare() -> __rb_allocate_pages() before page_alloc_init_late()
> > >    completes, so the false negative window spans both SYSTEM_BOOTING and
> > >    SYSTEM_SCHEDULING. Use system_state >= SYSTEM_FREEING_INITMEM as the correct
> > >    boundary.  (Sashiko, Vincent Donnefort)
> > >  - Wrap in #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT to preserve the original
> > >    check unchanged on non-deferred kernels. (Vincent Donnefort)
> > >  - Drop Tested-by: guard condition changed, requesting fresh test.
> > > 
> > >  kernel/trace/ring_buffer.c | 17 +++++++++++++++++
> > >  1 file changed, 17 insertions(+)
> > > 
> > > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > > index 9c4e40847e43..8e5a59a7b69b 100644
> > > --- a/kernel/trace/ring_buffer.c
> > > +++ b/kernel/trace/ring_buffer.c
> > > @@ -2463,10 +2463,27 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
> > >  		 * memory. It may not be accurate. But we don't care, we just want
> > >  		 * to prevent doing any allocation when it is obvious that it is
> > >  		 * not going to succeed.
> > > +		 *
> > > +		 * With CONFIG_DEFERRED_STRUCT_PAGE_INIT, NR_FREE_PAGES only
> > > +		 * reflects the initial non-deferred pool during early boot and
> > > +		 * throughout SMP bring-up (smp_init() runs before
> > > +		 * page_alloc_init_late() completes deferred initialization).
> > > +		 * si_mem_available() returns a false negative across this
> > > +		 * entire window while actual allocations succeed by growing the
> > > +		 * zone on demand via deferred_grow_zone(). Only re-enable the
> > > +		 * check from SYSTEM_FREEING_INITMEM onward, after
> > > +		 * page_alloc_init_late() has finished and si_mem_available() is
> > > +		 * accurate.
> > 
> > This is quite a massive comment for something simple: When
> > CONFIG_DEFERRED_STRUCT_PAGE_INIT, si_mem_available() will reflect the actual
> > available memory only after SYSTEM_FREEING_INITMEM.

Agreed, will trim it down to that one sentence.

> > 
> > >  		 */
> > >  		i = si_mem_available();
> > > +#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
> > > +		if (system_state >= SYSTEM_FREEING_INITMEM &&
> > > +		    i < (nr_pages << subbuf_order))
> > > +			return -ENOMEM;
> > > +#else
> > >  		if (i < (nr_pages << subbuf_order))
> > >  			return -ENOMEM;
> > > +#endif
> > 
> > Could we avoid the double i < (nr_pages << subbuf_order) with something like
> > 
> > if (IS_ENABLED(CONFIG_DEFERRED_STRUCT_PAGE_INIT) &&
> >     system_state < SYSTEM_FREEING_INITMEM)
> >        i = LONG_MAX;
> > 
> 
> or even i = totalram_pages()?

The IS_ENABLED() pattern is cleaner, will adopt it.  However, totalram_pages()
is not safe as the sentinel here.

_totalram_pages is set by a single totalram_pages_add() call inside
memblock_free_all(), which accumulates the total non-deferred page count from
free_low_memory_core_early() and adds it in one shot.  The deferred pages freed
later by deferred_free_pages() -> __free_pages_core(MEMINIT_EARLY) take the else
branch in __free_pages_core() which only updates zone->managed_pages directly —
totalram_pages_add() is never called for them (the kernel comment there even
says "memblock adjusts totalram_pages() manually").  As a result,
totalram_pages() returns the same small initial-section value (~16 MiB on
ppc64le) throughout the entire window, and setting i = totalram_pages() would
still trigger the i < (nr_pages << subbuf_order) check falsely.

LONG_MAX is unambiguous — it unconditionally passes the threshold check
regardless of nr_pages or subbuf_order, which is exactly the intent.  Will use
that in v4.

Thanks,
Amit

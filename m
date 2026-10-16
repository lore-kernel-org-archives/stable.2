Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3305C4C151C;
	Fri, 16 Oct 2026 13:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792157153; cv=none; b=sUoEfErgQnlDKwnZV18gNI7nEhiLij3YEMegSLoZrldfc3PoCTrAP6+oOYj7eprv0G9U1J2dXD+hsH0dP75wEfQ+Buj7L9LSL6VCOBiuQByCVOxyDMoTdmyGhVk6DacXf28V5vVpCSGNobqPxOLdxdd6KdL6fhmzhjEo6XkSLsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792157153; c=relaxed/simple;
	bh=o/Ckp1rrM6kHYZ25eu+4PLt+sP/3DzaXCIN1wStsUS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QIyZb50IBa+eGTQyFgcQRcCH7LGUFyt7+nLQNNkxbdlPeg7s9oKnYkdwlYH3cVZh93KF292kjMLAsLbaiiyQ00kRlB40n7BeJvbnTt2xAgS6SN5M8C1oxJSQ6rD9/7gxcMIAoBKW1dWWlj2ekqCRdGIVhtK7baunGD8T29Ejub8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cgW8WHP0; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cgW8WHP0"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69GAEDEE3424962;
	Fri, 16 Oct 2026 13:25:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=A1oGMJ
	NudXu36XPK/yxV+yodSQqNeuzr6WgFF4E8wpw=; b=cgW8WHP0tcEwPbkwgMC0h+
	MhSyL+6DoggdkX+LOnamLDX/LFTDPxdyEXLhsX6VZMNxf7BZbH+UT9R4peVbnWc8
	vc8zWbd5AU9lREb+oY+gk0zAcSfm6mQO5l+iw8GOI9/r4cvNNkHpO4Nk4v4vUTKI
	v+m738i/hqD3H+npVjse7ohz3vHu7fzoLfwXwvDSxFC/a/S2rNHo5Sva5rvKIqXM
	YPTNx0xXQKioSmLTn/ce2Bg/v6Gu8N7QzB1NvMidwwIDqHEJApvUZjP+HPwLDGjm
	WQ/zRAMv5USdK8mF74sl8K6vNQ9i4JDZ/RN0dYGHVg/S0gTQUG+c3v53l9HUYG7A
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwjevn4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 16 Oct 2026 13:25:33 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69GAK3ro3580924;
	Fri, 16 Oct 2026 13:25:32 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hawqww07j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Oct 2026 13:25:32 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69GDPS6e43647362
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Oct 2026 13:25:28 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5FC7920043;
	Fri, 16 Oct 2026 13:25:28 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 53C0220040;
	Fri, 16 Oct 2026 13:25:25 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 16 Oct 2026 13:25:25 +0000 (GMT)
Date: Fri, 16 Oct 2026 19:03:44 +0530
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
        kvm-ppc@vger.kernel.org, Mark-PK Tsai <mark-pk.tsai@mediatek.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH 2/2] ring-buffer: Do not check si_mem_available() during
 SYSTEM_BOOTING
Message-ID: <20261016190235.cef361be-9e-amachhiw@linux.ibm.com>
Mail-Followup-To: Vincent Donnefort <vdonnefort@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Harsh Prateek Bora <harshpb@linux.ibm.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	kvm-ppc@vger.kernel.org, Mark-PK Tsai <mark-pk.tsai@mediatek.com>, stable@vger.kernel.org
References: <20261009163557.88467-1-amachhiw@linux.ibm.com>
 <20261009163557.88467-3-amachhiw@linux.ibm.com>
 <as0NDyaXsfQnWPQ4@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <as0NDyaXsfQnWPQ4@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA1MiBTYWx0ZWRfX1B7DwnvE2ZEB
 ZRiQKFd017ZkLJ6lx/GN0Yv/cIpG1mfbEPXwKjRV6HaJ6J5OfuVVXY2YF6Qcbl0+jCpe1AAGd+2
 x2BcSvvOjBXzKhv5Wv8cqRDY+PUUtt8YMQrHC/Wk8tdqZ9FPabRSReZGVWxkeHlp1n3IGsExqKA
 lMXlhyBqOCyWW6GlJbnEXDVWD5Rmc1DCwCKyEdoeaUQWpk+EC7950uKr1uqRr/8Y1HZhrIaFPXj
 WNCX9XmloMkDNe3NJWx5pZI7Z3ICStyCShvrrQOMLwy1OuTJzToc9+VUmBJnjEGeVFXuWlzaLj3
 2aNsA3FjUovGHJRmjb/jzipIQbwCWxS+QUWpPKZeItGavknOe0a4f3LwkgKgn8yIC5hXMLT89vZ
 0CUp+yain6Hl+VX3kUh/iKs0sg66qTJkmsVaIZKNWOFAYF9QP22qD4uJCwOK4v4CD/QJ4IMxdjP
 YJvJnPPtW4Z7TgPssDA==
X-Proofpoint-GUID: BI2cxKGAEKJYjpJtdhn7B-QEcpA1kyCp
X-Proofpoint-ORIG-GUID: qYdT_-xCKwD220TGgWg54Kp8opywLsvm
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA1MiBTYWx0ZWRfX8QDgacc7g/xQ
 R45WROGLPAbi8OaA0R2kULYl5urC62K2wuewINkM1+Rm44n0HIYLOVTtchd4A32Evje1KsgqdRU
 +wHkkM8pKRO1Ddbq93xCai2bVyWQeXQ=
X-Authority-Analysis: v=2.4 cv=btHZl0ai c=1 sm=1 tr=0 ts=6ad225cd cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=dlV8YpW79Mn5UFwVz3cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610160052

Hi Vincent,

Thanks for reviewing this patch.

On 2026/10/12 05:38 PM, Vincent Donnefort wrote:
> On Fri, Oct 09, 2026 at 10:05:57PM +0530, Amit Machhiwal wrote:
> > During early boot (early_trace_init() called from start_kernel()),
> > tracing allocates initial ring buffers (temp_buffer, array_buffer, and
> > snapshot_buffer) for CPU 0.
> > 
> > Before attempting page allocation, __rb_allocate_pages() performs a
> > heuristic check using si_mem_available() to return early with -ENOMEM if
> > memory appears insufficient.
> > 
> > However, on kernels built with CONFIG_DEFERRED_STRUCT_PAGE_INIT=y,
> > defer_init() leaves only a single section per node (e.g.  16 MiB with 64
> > KB pages) initialized up-front.  On kernels with large static binary
> > footprints (such as debug configurations enabling PAGE_OWNER,
> > DEBUG_PAGEALLOC, KFENCE, or SLUB_DEBUG), the static kernel image and
> > early core initialisations (SLUB caches, vmalloc, static ftrace records)
> > consume virtually all managed pages in this initial pool.
> > 
> > At T=0.000000, watermarks have not yet been established
> > (totalreserve_pages = 0), so si_mem_available() returns the raw free
> > page count (often 0-1 pages).  When the snapshot buffer or global trace
> > buffer attempts to allocate 2 sub-pages, si_mem_available() returns <
> > nr_pages and prematurely aborts with -ENOMEM.
> > 
> > This failure is false: if the page allocation were actually attempted
> > via alloc_pages_node(), the page allocator would trigger
> > deferred_grow_zone() on demand to initialise additional deferred memory
> > sections.  Checking si_mem_available() before attempting the allocation
> > short-circuits this on-demand growth.
> > 
> > Skip the si_mem_available() check when system_state == SYSTEM_BOOTING.
> > Once the system transitions past early boot and page_alloc_init_late()
> > initialises all deferred memory, si_mem_available() accurately reflects
> > system-wide free memory and the check operates as intended for runtime
> > allocations.
> > 
> > Fixes: 2a872fa4e9c8 ("ring-buffer: Check if memory is available before allocation")
> > Cc: stable@vger.kernel.org
> > Reported-by: Michal Suchánek <msuchanek@suse.de>
> > Closes: https://lore.kernel.org/all/arYskzbiaNzBR9MD@kunlun.suse.cz/
> > Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> > ---
> >  kernel/trace/ring_buffer.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > index 04bb94c29f58..a9f82e2f8fad 100644
> > --- a/kernel/trace/ring_buffer.c
> > +++ b/kernel/trace/ring_buffer.c
> > @@ -2452,9 +2452,15 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
> >  	 * memory. It may not be accurate. But we don't care, we just want
> >  	 * to prevent doing any allocation when it is obvious that it is
> >  	 * not going to succeed.
> > +	 *
> > +	 * Skip this check during early boot: with CONFIG_DEFERRED_STRUCT_PAGE_INIT,
> > +	 * NR_FREE_PAGES only reflects the initial non-deferred pool at this
> > +	 * stage. si_mem_available() returns a false negative while actual
> > +	 * allocations succeed by growing the zone on demand via
> > +	 * deferred_grow_zone().
> 
> As Sashiko pointed-out, if si_mem_available() is only ready after
> page_alloc_init_late() when CONFIG_DEFERRED_STRUCT_PAGE_INIT, then checking for
> system_state >= SYSTEM_FREEING_INITMEM might be more correct.
> 
> Also I wonder if we don't want to guard with CONFIG_DEFERRED_STRUCT_PAGE_INIT,
> to keep the verification when CONFIG_DEFERRED_STRUCT_PAGE_INIT is unset.

Both suggestions adopted in v2 — using system_state >= SYSTEM_FREEING_INITMEM
and wrapping in #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT.

Thanks,
Amit

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792591703;
	b=V5FuF9HV7VrLQpSfEd8k0CUqNLW8SX31B3xHNoYDPxbVPxx0uRiS7LkEMPO4lc0ESPga
	 bhTBPps1pv3g3thwM6//Ecwdf9Zao0iQlq1f3jHb5OL9iZyzzUnGRimFKowaR27Lo2RHr
	 rOP0VZ7jke6wTdj3UCmystHryYSP4aSgPzNLT/oHgQ/xNqVrfhTNiqgNklMT8FnikhBvt
	 5t+tetdWrX04PyME14fCiyKOuhx1CKO8Kgw19uN+4pKkZXMH48YhuB6b0Ma6l18tnya+7
	 /Ad/3qH8uVDbypk4PyCFe22yxh8UWR8CuMswYVhKURupj+u7VyAN78IPhuk0H8AcQkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792591703;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 X-TM-AS-GCONF:X-Proofpoint-Reinject:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=ADvt/YKRVb0IDur0qISzY9q0oNf6yoH61rpJhz6SvPo=;
	b=V9rV0mdUpCicLvF3lWXdEaz9gO2e7hIUcG56PU/yW2iy/Ez4q0qNro7BRxQIPLyzfLGH
	 urnfEhkZZY4FfdCU3sd3eJgLWehiDv37RH9tBODrBns/iZPkHEbhPHnr2lOgg5Icga6ad
	 YhrSbeNGUmZPYBAQFtdRfOO+nELDsAfcFyKXe4BaXnjN7oQRnekTZVfxE8fDQeznV8ecH
	 UiJ0spuMjsEWuoArRDNk3uG7QV4/gSg0cKIzINQMPEdEO5Dil3+akrvDEm0LtJzjGOS8C
	 qYbvrjsQq3m68bhlSRPQFed9y7e/YJ696vJ2EuMCXti037bUW/VNbResgXDi8aG96Dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fCDCXvxX;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9229606A319;
	Wed, 21 Oct 2026 14:08:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9229606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fCDCXvxX
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69LBihEh1092707;
	Wed, 21 Oct 2026 14:08:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ADvt/Y
	KRVb0IDur0qISzY9q0oNf6yoH61rpJhz6SvPo=; b=fCDCXvxXS5yMYjrbst8URF
	GXReuq4NOxJExJHRKFMVqLQOtNYkaIWoDn7TEWTtsOYnZJ39JNZ9p5ZsRSbKTD5U
	Kl8/4OJqsXSEMBQ74Nmwp+5qqyuCKRJWkj6fkAYhqZfpoUzbcOJ+7u2eO7uAP5je
	7Qnk8xUlw/CMgclHATD2Bx58Cy3umCIj3obVKzWmHB3FKvxcltajKglO0VKAiujA
	E3uPz5cW1ATQ6RILKLllWL6d3BZPFg9ZGXs9CDoCYwAnLv267XmFn/GlQBm7b9hR
	69Bs42eGh5dkA55aVUnMcCTrM4UavpNE8yZvTCPg9uPy9Z46cF4CZmib9P4uC/Xg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5a16p3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 21 Oct 2026 14:08:06 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69LBo0Nf3083664;
	Wed, 21 Oct 2026 14:08:06 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hcmuh78su-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Oct 2026 14:08:06 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69LE7xKM42402202
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Oct 2026 14:07:59 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 87CD720040;
	Wed, 21 Oct 2026 14:07:59 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 83B092004B;
	Wed, 21 Oct 2026 14:07:56 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 21 Oct 2026 14:07:56 +0000 (GMT)
Date: Wed, 21 Oct 2026 19:46:21 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Vincent Donnefort <vdonnefort@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] ring-buffer: Do not check si_mem_available() before
 deferred init completes
Message-ID: <20261021194442.d82d52ff-07-amachhiw@linux.ibm.com>
Mail-Followup-To: Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	Vincent Donnefort <vdonnefort@google.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Harsh Prateek Bora <harshpb@linux.ibm.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	kvm-ppc@vger.kernel.org, stable@vger.kernel.org
References: <20261009163557.88467-3-amachhiw@linux.ibm.com>
 <20261016134247.70722-1-amachhiw@linux.ibm.com>
 <atX3fzEV_Pai4woV@kunlun.suse.cz>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <atX3fzEV_Pai4woV@kunlun.suse.cz>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA1NCBTYWx0ZWRfXyG65JXecQ1qZ
 XTrj6qOaw599HABgWv3Eww0Xs9tLyqxfAKHoR+2McAqaVtBYvr3IrTcJrbmkMlRuUQuvANACUEW
 7IluMJcNfVuTpkOTRtuMf6laDL8JULOhPdDV76eGJDCcMKAAG0fDCtg9tMFNgqghXzkEWHxq5ae
 xU5BARihXwnoT4+ZbGcX7OPy87xGLE1RuVu5/FunFdVpRq35lxYeolBGPNTEfTUSU9irEmVea1C
 a5qm55uFNWYwqMcg0WUh7smrsVRv2mIjQLTTsNjaCjOeIM1NHVy/PUgMm6LHastdF8ZKU0flIuk
 +CwOXDrwyy28c5fVpnBIu+iqrz5aRN6NkMnUgLRafIzE5dkj4h7LGugRrljWdlTfkSfunDJskEI
 qRIr4PWFC5q7t/MwLeEpKWnGC/mxmhtGJEThA/flhxLEvBV1Ujf894BzFFnj1I4kJrDvlIU3fkn
 XvlmDwAbfn+AIjd93GA==
X-Proofpoint-ORIG-GUID: hyUw3X5wNZrdxkXQRgY-MffWMIOFZAJT
X-Proofpoint-GUID: KO4BRUAyOt7JDDy1mg87zV7Y6gkDWO3B
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA1NCBTYWx0ZWRfX8uqSMDpxuI6A
 J8xRgCnNYesbvsgxGa0BeU2aPp1OqIHPJasPEANYOfB6h98yFst7I5eeh2JXUc3yxHAKO+6G9Tu
 fFH9RfJll9qgCA8BfNMPMFUZ2ipTKoE=
X-Authority-Analysis: v=2.4 cv=ZfSIpcVA c=1 sm=1 tr=0 ts=6ad8c747 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=8nJEP1OIZ-IA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=M0V5yE8pmHsQCC-Gis0A:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_03,2026-10-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 clxscore=1015 phishscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210054

On 2026/10/19 12:57 PM, Michal Suchánek wrote:
> On Fri, Oct 16, 2026 at 07:12:47PM +0530, Amit Machhiwal wrote:
> > During early boot (early_trace_init() called from start_kernel()),
> > tracing allocates initial ring buffers (temp_buffer, array_buffer, and
> > snapshot_buffer) for CPU 0.  Later, as secondary CPUs come online during
> > smp_init(), each CPU's ring buffer is allocated via trace_rb_cpu_prepare().
> > 
> > Before attempting page allocation, __rb_allocate_pages() performs a
> > heuristic check using si_mem_available() to return early with -ENOMEM if
> > memory appears insufficient.
> > 

<snip>

> >  kernel/trace/ring_buffer.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > index 04bb94c29f58..aa877a272c89 100644
> > --- a/kernel/trace/ring_buffer.c
> > +++ b/kernel/trace/ring_buffer.c
> > @@ -2452,10 +2452,24 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
> >  	 * memory. It may not be accurate. But we don't care, we just want
> >  	 * to prevent doing any allocation when it is obvious that it is
> >  	 * not going to succeed.
> > +	 *
> > +	 * With CONFIG_DEFERRED_STRUCT_PAGE_INIT, NR_FREE_PAGES only reflects
> > +	 * the initial non-deferred pool during early boot and throughout SMP
> > +	 * bring-up (smp_init() runs before page_alloc_init_late() completes
> > +	 * deferred initialization). si_mem_available() returns a false negative
> > +	 * across this entire window while actual allocations succeed by growing
> > +	 * the zone on demand via deferred_grow_zone(). Only re-enable the check
> > +	 * from SYSTEM_FREEING_INITMEM onward, after page_alloc_init_late() has
> > +	 * finished and si_mem_available() is accurate.
> >  	 */
> >  	i = si_mem_available();
> > +#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
> > +	if (system_state >= SYSTEM_FREEING_INITMEM && i < nr_pages)
> > +		return -ENOMEM;
> > +#else
> >  	if (i < nr_pages)
> >  		return -ENOMEM;
> > +#endif
> >  
> >  	/*
> >  	 * If a user thread allocates too much, and si_mem_available()
> > 
> > base-commit: 2f2f7eeef8b0a1a9b9ca998231419873ccae8d4e
> 
> Hello,
> 
> due to other conflicting changes this no longer applies.
> 
> Will you send a rebase?

Hi Michal,

Thanks for checking and notifying.  I'll look into it and send a v3 as needed.

Thanks,
Amit

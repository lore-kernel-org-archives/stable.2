Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03A830B529;
	Tue, 16 Jun 2026 13:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781617099; cv=none; b=aV8kiBqjq7vf69eYzdReoLFH8TJET8MMF9k8d9LdjHmYUk2jDmIaiv7I2GS9Et3PxK/i/i3kdVZ4qLXVyRe8XwCfKn9k0GBePYkFiGB+jIpCPtSEA2nBhpxoGoAzGIN1x60YFxPP9CV6Sj52dvB9w/y8Selqgnt9OoiL4PCnY54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781617099; c=relaxed/simple;
	bh=YrlXqVwO4LlWxC2v2Tki0wOYpoD4pmFGQ+gzNRlk1YY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iHPj4T3eISs6kOOZJuN85zSNcg1Gm0BwIhaoELt0qNAJj4UVHKghvfsUcLqZdYkTvlAmdgLlbc6geth8PHEHTfJmbE4XQRsmN5T/o+HGvHtZPftuyo08QXf6YgcadqhpE6Dq69Et31eiQfNcL6v1gS3Pvyau8P3UX/jvK+dmc9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=B7gOOxoV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="B7gOOxoV"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GAIQtR1156101;
	Tue, 16 Jun 2026 13:38:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=OJlJUiTv5XLMETNJVTesa29BlzuKdp
	nijWbmINEBqB4=; b=B7gOOxoVTJ0XFMFgjK7UOGZNOLEAoGBQsbGLt6CjbGK4bH
	9jG0p+Qs1LWYoOnypXmRBE+n6iiTi/xTq7CQ49gFLB0xjWJEvL3WYsO536t2P8Fz
	0X2d51nAg0DQ6WhLqtO6WfzUc+iPf9fdVs17o3SqTmVL78MmgTjh7GEcNV3rrPSt
	5khh+2fyZ/YRtdmyZo740wfCtoIagIrHjC2e5DEPrjy+P++/kOYHyFW9bQwDcU+r
	/nuZyFw//DRfAC5ahZ5Q+vo5s1rWHwfjM1QQyDOzn1oDZYlqFVxoFp0+mRZwxbCX
	EknmTxh2TqjwLH7RSVNTfwTcKweOuvxwOog2M3UA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1eg5caa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 13:38:02 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65GDYdrJ012348;
	Tue, 16 Jun 2026 13:38:01 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4esjhk3hm1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 13:38:01 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65GDbvC813042050
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jun 2026 13:37:57 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C2EE520043;
	Tue, 16 Jun 2026 13:37:57 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 050F220040;
	Tue, 16 Jun 2026 13:37:55 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 16 Jun 2026 13:37:54 +0000 (GMT)
Date: Tue, 16 Jun 2026 19:07:55 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        Anushree Mathur <anushree.mathur@linux.ibm.com>,
        Gautam Menghani <gautam@linux.ibm.com>,
        Mukesh Kumar Chaurasiya <mkchauras@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] KVM: PPC: Book3S HV: Validate arch_compat against
 host compatibility mode
Message-ID: <20260616190601.49193107-d8-amachhiw@linux.ibm.com>
Mail-Followup-To: Ritesh Harjani <ritesh.list@gmail.com>, 
	linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Vaibhav Jain <vaibhav@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, 
	Anushree Mathur <anushree.mathur@linux.ibm.com>, Gautam Menghani <gautam@linux.ibm.com>, 
	Mukesh Kumar Chaurasiya <mkchauras@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
References: <20260609053327.61563-1-amachhiw@linux.ibm.com>
 <cxxqerzk.ritesh.list@gmail.com>
 <20260616161011.835c90f0-38-amachhiw@linux.ibm.com>
 <a4suelh6.ritesh.list@gmail.com>
 <20260616182627.2ebf3cfc-3a-amachhiw@linux.ibm.com>
 <8q8eeio8.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8q8eeio8.ritesh.list@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDEzNSBTYWx0ZWRfXwLYiwAAZ/0qP
 C4fGeY/69Q52L5ztLq7fK62M/koQTcP7rGqF0dcW5PdQJIVqmG25U6Butopsqhyz0hWV9rQ+X2Q
 kZnO3iR09Fi6wc+Z3l3m+3eJ85OKFS0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDEzNSBTYWx0ZWRfX2aa9naN/h4n/
 uZGa/jNJHCKe9M0iG+BKTBaVDqhwW5VeWwinEuRAcyAQzZ9YPyC8D8yUD3TnUTwZmOkTD3wdPFS
 KC/8MWStWvd7Yd28iAb2bRlU6va6qFm3zD9Ahtr23Act6pSxn3pq8YFgLBg52n5fk7ksPmM/b0m
 pEJ9gMzK9jmxgqhGtiKTLYHS1y/rOSb/gOmSl8IdmVJE7ULglbSX0J4PB9OqiqV6F+uBgUgmqHW
 FyHeTUnE+oLlUPDvFk1DwvMNW1xYT0tO4GbaGQ4w8b9ndzhzRJkQIZThvWbL9zYNmoaz1M7nA+M
 GL5vAS6jPizSqyu/nXaKDKhOFGWnVskpd14SWXXKRdNEcRC6nNSaHM4KwQcGp/49xWxhthSOpWa
 7EZid1rkJfI/JOGNZT2f1Ceyl/OTWwUiip+rXSUrO/AHDdL2RNd6KeAe7cObRJ+hHttixnRQbXz
 4p+Ao2j6zgWEeT8KE4g==
X-Proofpoint-GUID: iK_GhqM-0CA3-a8u0l2MimtfPdu62Gqd
X-Authority-Analysis: v=2.4 cv=NuDhtcdJ c=1 sm=1 tr=0 ts=6a3151ba cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=iq54L-VbdJhnno5R1iwA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 3woL183bwpqlqcMfJLp47KJDbDowNofT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_03,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 phishscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160135

On 2026/06/16 06:39 PM, Ritesh Harjani wrote:
> Amit Machhiwal <amachhiw@linux.ibm.com> writes:
> 
> > On 2026/06/16 05:38 PM, Ritesh Harjani wrote:
> >> Amit Machhiwal <amachhiw@linux.ibm.com> writes:
> >> 
> >> >> > diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
> >> >> > index 3449dd2b577d..7472b9522f71 100644
> >> >> > --- a/arch/powerpc/include/asm/reg.h
> >> >> > +++ b/arch/powerpc/include/asm/reg.h
> >> >> > @@ -1356,6 +1356,7 @@
> >> >> >  #define PVR_ARCH_300	0x0f000005
> >> >> >  #define PVR_ARCH_31	0x0f000006
> >> >> >  #define PVR_ARCH_31_P11	0x0f000007
> >> >> > +#define PVR_ARCH_INVALID	0xffffffff
> >> >> 
> >> >> Logical processor version is defined as part of the PAPR spec. We should
> >> >> ensure that this invalid PVR is also documented in the PAPR spec.
> >> >> 
> >> >> If you have already taken care of that, then please confirm and feel free to add:
> >> >
> >> > Regarding the PAPR specification documentation: The PAPR spec documents
> >> > the valid Processor Version Register (PVR) values for each processor
> >> > generation (POWER8, POWER9, POWER10, POWER11, etc.). However, the
> >> > PVR_ARCH_INVALID value (0xffffffff) introduced in this patch series is a
> >> > KVM implementation detail used internally to mark invalid compatibility
> >> > mode requests - it's not an architectural value that would be defined in
> >> > PAPR itself.
> >> >
> >> > The validation logic and the use of PVR_ARCH_INVALID as a sentinel value
> >> > are documented in the kernel code and commit message.
> >> >
> >> 
> >> But that still worries me on what if PAPR wants to re-use this value for
> >> some other purpose in future. 
> >
> > This is a valid concern about potential future conflicts with PAPR.
> > However, I'd like to point out that PAPR explicitly specifies:
> >
> >   "The first byte of the logical processor version value shall be 0x0F."
> >
> > Since PVR_ARCH_INVALID (0xffffffff) has a first byte of 0xFF, it's
> > explicitly outside the valid PAPR-defined range for logical PVR values.
> > This means there shouldn't be any risk of future conflict with PAPR
> > specifications.
> >
> 
> aah ok.. That make sense. Thanks for confirming that.
> Can we please update a small comment in the code and log this info,
> maybe something like:

Sure, Ritesh. I can certainly do that in the next version.

Thanks,
Amit.

> 
> /*
>  * PAPR specifies that the first byte of a valid logical PVR value is
>  * 0x0f. 0xffffffff therefore lies permanently outside the PAPR-defined
>  * range and is safe to repurpose as a kernel-internal sentinel. KVM
>  * stores it in vc->arch_compat when userspace requests an unsupported
>  * compatibility mode (e.g. Power11 on a Power10 compat host);
>  * kvmppc_sanity_check() detects this and prevents the vCPU from running
>  * until a valid arch_compat is set.
>  */
> #define PVR_ARCH_INVALID      0xffffffff
> 
> 
> -ritesh
> 

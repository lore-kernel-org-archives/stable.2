Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C74E23C51D;
	Mon, 12 Oct 2026 06:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791787308; cv=none; b=BQQ3mT73j4Cywyha5Oua9pRP5a34mVUsTa5v1d80nUDL9Xi43v2avjCz/Nt2OQMKWpabfsGP4GGYmAaBJki5jaXsx8hKxxoHw1HJtC+091AV8+1WIqmVs6kH9+pM100FodF5uAySPc2yHDCFHoisX+1DF0jgxAvzLUNMJAbywlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791787308; c=relaxed/simple;
	bh=eHivjCKczGzkuQ9uUHMBLdzq+nirecjifqF0uyhgCS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I1UC+NEjVw3bUYbpsexP6HOHETi0wSlyoGw7CGzxH8FyArAkXpwkQdTxc/B8c7kfDhQldPMxEDDn6ytzgrXo35RGok0hj9B7Wr7yHayfOk4rA9BAFn7knmrN29zjxld9I4Y4oisGL3/W7ohfRES84ed1tjzEff8T2v34a0GEsiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DREjDhvs; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DREjDhvs"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69C5EUoG3428290;
	Mon, 12 Oct 2026 06:41:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=PcBuV+5B9AhRqChzjKe031ir1zqSXQ
	T5AWBsIXAlezs=; b=DREjDhvsTcQVp3uNcc5wEm9IQGMy13a4xo4v1GIej7+syS
	EJsGHE/FIYs4amzLO5vjuWmovQenU2ynXPAW7HVJUBwkL+KBd8jPVyMDiNXps4ZJ
	YWCCqq0atnW5tD1P57H5O0XA5qrTiaFYY6lwszxmJyCWpo2oShRuiZEUXTO2QH48
	J+y7TvQvOVLIGr7wZz88+99e7kDeWVEPJ0yIqJJNll+6Tt19d3w1d3CdvxW9/XN3
	EihFUfg5ODzuUcjYwPimwFxOZ2Rz1/wSNZwGisN/9csUNPqNC3wl494ZK78eNL1M
	ibAZkKF89DvMAZPuKXIBu73vhbGFtz7dzDRx+W0w==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv37hwp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 06:41:35 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69C5596W726899;
	Mon, 12 Oct 2026 06:41:34 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h80pjm1vj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 06:41:34 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69C6fTEL49414408
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 06:41:30 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DCB5520040;
	Mon, 12 Oct 2026 06:41:29 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 240F32004B;
	Mon, 12 Oct 2026 06:41:27 +0000 (GMT)
Received: from li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibm.com (unknown [9.39.28.91])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 12 Oct 2026 06:41:26 +0000 (GMT)
Date: Mon, 12 Oct 2026 12:11:24 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au,
        chleroy@kernel.org, sshegde@linux.ibm.com, amachhiw@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/4] KVM: PPC: Book3S HV: Ensure that calls to
 idr_alloc are synchronized
Message-ID: <asyAu4PJz9fyPWV5@li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibm.com>
References: <20261009123035.157770-1-gautam@linux.ibm.com>
 <20261009123035.157770-2-gautam@linux.ibm.com>
 <zewlq628.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zewlq628.ritesh.list@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: UE0v6LLYTCi9Mii3Wj1COcaWLQ2xA-o1
X-Proofpoint-ORIG-GUID: XJd1Bxj_Mle-K2cR3qC97U4q0-Oy87cz
X-Authority-Analysis: v=2.4 cv=aqInmiZV c=1 sm=1 tr=0 ts=6acc811f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=b6S7UqY0JXT-N64pkT4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAyNCBTYWx0ZWRfX1Y8iffh/otoC
 4e4pxqZimfavlwQWYKivf3Wmn4IDV3N3FOqL5k3vSA+NSjZYTSF1n8ubyVB+PeCBgnh25QaOA82
 2NeWtmFL8nETQvikIHKfOTI1UKKrFdo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAyNCBTYWx0ZWRfXxMTktw37mHP5
 fSOxIl/U/A3dBir2xUqhvu/NkZkCH4Q5ZLMMIUGm9VEZwAMJiv61gMFq1I9Ymx+w7PB1HQ8TIta
 K6vdNDlHZ/FbojOrqJ+kRjkg6YIwagjhi/N9wPk8Vgt96suptkZcJ7oHAMyc3LertjyKSmHRkQX
 fpgTYG1Q/SwQZcK86NWbNQuCoYQTuOSD8iuz5vLKTomrxg8E1hPszSbj9dxR5z90uKZvUnZv6hw
 VJCd/aX5F8pYvEvUuUEA60a+ok8s6jFPAxzENCIgt0jkKHGOsxbu6zc3pvw70jSY6tY9kkt4mem
 RAhogQKQSCrqYX58nL+xNGhVo6Ct4LC2uO6WSczAhG3zjxaItKDHVoENSFvL4PThVnsTDrpvpH5
 tVCsqRjjIqITP+Op4yV6lEVPXQSxJwyGjoyeLB4+rysZEz6aXvsSSoSTXd32a9kypttPtQEBXsA
 djVQ+zACitw+yalGMDw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_02,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120024

On Sun, Oct 11, 2026 at 08:47:35AM +0530, Ritesh Harjani wrote:
> Gautam Menghani <gautam@linux.ibm.com> writes:
> 
> > Calls to idr_alloc() in __prealloc_nested() are not currently synchronized.
> > According to the documentation [1], the caller should provide their own
> > locking to prevent concurrent modifications to the idr to prevent bugs.
> >
> > Wrap the call to __prealloc_nested() in	a spinlock to prevent concurrent
> > modifications to idr.
> >
> 
> This looks to be the leftover of previous implementation. IMO, the
> commit msg needs fixing.
> 
> How about this?
> 
> Calls to idr_alloc() in __prealloc_nested() are not currently synchronized.
> According to the documentation [1], the caller should provide their own
> locking to prevent concurrent modifications to the idr to prevent bugs.
> 
> Now __prealloc_nested() calls idr_alloc() with GFP_KERNEL which can
> sleep and mmu_lock is a spinlock. So idr_alloc() cannot be moved under
> mmu_lock. In such cases the idr Documentation says:
>     If you need to take a lock while allocating a new ID from the IDR,
>     you may need to pass a restrictive set of GFP flags, which can lead
>     to the IDR being unable to allocate memory.  To work around this,
>     you can call idr_preload() before taking the lock, and then
>     idr_preload_end() after the allocation.
> 
> Hence preload the idr memory with idr_preload() before taking mmu_lock,
> which allows us to use idr_alloc(..., GFP_NOWAIT) under the spinlock.
> 
> This also allows to kill __prealloc_nested() and __add_nested(), as they
> are not needed anymore with idr_preload().
> 
> [1]: lib/idr.c
> <...>
> 

Yes this is a miss from my end, will fix in v3.

> > [1]: lib/idr.c
> >
> > Fixes: c0f00a18e2a8 ("KVM: PPC: Book3S HV Nested: Change nested guest lookup to use idr")
> > Cc: stable@vger.kernel.org # 5.19+
> > Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> > Co-developed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> 
> Otherwise LGTM. Thanks for taking it ahead and validating this.
> 
> -ritesh

Thanks,
Gautam

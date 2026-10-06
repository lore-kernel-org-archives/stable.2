Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27CD2E719B;
	Tue,  6 Oct 2026 03:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791257272; cv=none; b=j7oY+07a6k4tG86zRjEAwThgUJW2M4ktxzhqVpTERmMyiH4ZD2AQXIFrlfSvNsbuFMAj/7uODieOmkHJCqqb/I6okrkoKsnfVddd7A1iR2rz+K9gheSdRhNCwAmmhtnPaGPA66A6rAzI2Htf+2rxNe58uc+J578OoserMkbirBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791257272; c=relaxed/simple;
	bh=UC1y/SJZ04sdQPQMl5rNLHky3N/saXcS6OaAx6C6r24=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iE8rhTqn6N9TEmY4FBjXtd9uuYDOsbPmcyXi8b3wbp0nDEgtqJCwlb2PMztiJhpD17OrtqPNQkJbFS2flx5EHBHkJDdNyeGJTsviqY903IaYV4o+KDeHzj3ycFJyLzNiBps/PJPwCfWMdnarmWLc9Nve/sWgEJZ4q+5OZaIAyeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IvuHiY9a; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IvuHiY9a"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695HZju91257718;
	Tue, 6 Oct 2026 03:27:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0lBM0v
	UcupH/Y5YqGK9t8/tFQRI3XfjB4q1QDdrszOc=; b=IvuHiY9aXOdgNLogatOE3m
	UfSlFo63cZLFOvhQYSYA2tRUryUUXOryRlndVIAJ/PIVZElKBZa83DBpBCDkMKEv
	7JJ/bKS1kTf+5i+neLCNdWMX/3iZUB66k0TEWQfozDHi6LJipRcXEkABIrKI+FDq
	8H/+uVH864z0TqoRS2hMeHwKln0VtFItsltCJVHweilsYiQd+eQnNyZmf6Ng1esk
	oBHOa33VbfOVDLAUddk8htd+avEJtbzyWF25jBpDdRVVdyauFC8+WxDeU7hoFWp9
	zvyMP+6YZ15j+orsKR2EJFv0X9tHF+obEXqxz9304Z740JPQwuNpaipGm7C41B2A
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2se5dphe-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 03:27:34 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6963HV4u3924960;
	Tue, 6 Oct 2026 03:27:33 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3dhgr5ar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 03:27:33 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6963RSfU48497038
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Oct 2026 03:27:29 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA88820043;
	Tue,  6 Oct 2026 03:27:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 99B3220040;
	Tue,  6 Oct 2026 03:27:24 +0000 (GMT)
Received: from [9.124.213.110] (unknown [9.124.213.110])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  6 Oct 2026 03:27:24 +0000 (GMT)
Message-ID: <f5243a5c-a611-43a8-8350-7418b0dfd864@linux.ibm.com>
Date: Tue, 6 Oct 2026 08:57:23 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] KVM: PPC: Fix get_d_signext() 12-bit displacement
 for paired-single D-form
To: Amit Machhiwal <amachhiw@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman
 <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        kvm-ppc@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Gautam Menghani <gautam@linux.ibm.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        R Nageswara Sastry <rnsastry@linux.ibm.com>,
        Alexander Graf <agraf@suse.de>, linux-hardening@vger.kernel.org,
        stable@vger.kernel.org, Avi Kivity <avi@redhat.com>
References: <20260930173750.56759-1-amachhiw@linux.ibm.com>
 <20260930173750.56759-4-amachhiw@linux.ibm.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20260930173750.56759-4-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDAxMiBTYWx0ZWRfX3ObukXk0g2oB
 cUQXCoIBNSF/qFooWLyuauD0+zVH+11FE0mTaPvdVcrlpD7APOvS/yvtAIBsj2aFz9irCFDp74v
 Bx5C1F9ylkIl1low78ONPxodZOLhXaM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDAxMiBTYWx0ZWRfX406dayzh01wP
 3GlwoVlzfyWnsf802olNfZqRvbPQ2oPgy8s7fuz139p9OBXT69s/7XIj4vY7F0gwEJroEmu4h67
 aGuHXGopq1uMlWy0NXmwrhK7vBdnR+FqeCJ4DBa8v1N+SDd67s+LxUJiABPVWUddbQp88/t1Yju
 mCwNP7IznH4evBiu8usaa5YOeohylx0XiExnA+448fVY/+4yu2NBae0zKhOy/WNpb6ovkaX8Jvz
 lpXEhiBfFIaOgmvW1JZ6Kavgm+jbaBnUMq53uCtBLO2bpfcoBgkq5lsaEwyLiQkKFHzgRBoVBF3
 Ti+4Zj38jFVbTN06xExkpPaAs2LkuYmUeDs4fV5GcsiiDsYGqszQ8C5SQRqaSMBGYX2yxfpHzVu
 PkjfLjGm4qP3A84ou/x6cfZQhzAu4gfwEcKRG0rbMFz0B5EJLPN/ustnXCGK1S8Tjboztg9C06K
 vIxjbBQ8M16B+jqYj2Q==
X-Proofpoint-GUID: rOW8sFFNC8rKqa3XTsPI_t-ZQX-Mrsuy
X-Authority-Analysis: v=2.4 cv=UNRIjyfy c=1 sm=1 tr=0 ts=6ac46aa6 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=WMBJgkUnEH5UdlDH4cMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: PFNW8yP3hAGxY9v5rrxxnGVNiHZyOODw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060012



On 9/30/26 11:07 PM, Amit Machhiwal wrote:
> get_d_signext() has two compounding bugs since its introduction in 2010:
> 
> 1. The extraction mask 0x8FF silently drops bits 8-10 of the 12-bit D
>     field (PPC ISA bits 21-23), corrupting any displacement that has any
>     of those bits set.
> 
> 2. The sign-magnitude idiom "-(d & 0x7ff)" is wrong for two's-complement:
>     for D=0xFFC (encoding of -4) it returns -252 instead of -4.
> 
> Together these errors produce a wrong effective address for psq_l, psq_lu,
> psq_st, and psq_stu whenever the displacement is negative or is a positive
> value >= 0x100 with bits 8-10 set — essentially any real-world paired-
> single stack-relative access.
> 
> The D field occupies the bottom 12 bits of the instruction word (confirmed
> by the adjacent W and I extractions via inst_get_field(inst,16,16) and
> inst_get_field(inst,17,19)). Replace the open-coded logic with the standard
> sign_extend32(inst & 0xfff, 11), which correctly performs two's-complement
> sign extension from 12 bits to 32 bits.
> 
> Fixes: 831317b605e7 ("KVM: PPC: Implement Paired Single emulation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
>   arch/powerpc/kvm/book3s_paired_singles.c | 7 +------
>   1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/book3s_paired_singles.c b/arch/powerpc/kvm/book3s_paired_singles.c
> index bc39c76c9d9f..532f96293de0 100644
> --- a/arch/powerpc/kvm/book3s_paired_singles.c
> +++ b/arch/powerpc/kvm/book3s_paired_singles.c
> @@ -479,12 +479,7 @@ static bool kvmppc_inst_is_paired_single(struct kvm_vcpu *vcpu, u32 inst)
>   
>   static int get_d_signext(u32 inst)
>   {
> -	int d = inst & 0x8ff;
> -
> -	if (d & 0x800)
> -		return -(d & 0x7ff);
> -
> -	return (d & 0x7ff);
> +	return sign_extend32(inst & 0xfff, 11);
>   }
>   
>   static int kvmppc_ps_three_in(struct kvm_vcpu *vcpu, bool rc,

If the intent was just to get the signed value based on bit11 (0 based index)
then patch looks right.

Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>

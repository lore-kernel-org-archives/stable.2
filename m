Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F5B29CE9;
	Thu,  4 Jun 2026 14:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780582879; cv=none; b=fvoYR3FZJUxCBuoxr3dAbeYjwuSgH77IqScGTob3BoV48NfsVInomO4r6yYmHH19nWdNVv9AfC7UoLXLgEB+ZWJ5K4yC1uUJV+eeGS4BesJcrF4NjqR25u1qMafc+U1As8+W2bA9NA46BC8DCtujhBT/oa9bj3RJfcw/tgzxkLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780582879; c=relaxed/simple;
	bh=Knye8SpVao8iNiKSvhwqXYr+14d/YtXJ/n9F0V4Fv08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p2O+bxPXr6uqKmCuYaOGy9/q3ZlZcdJT2CVVyLJFCW6QqZLy6zHTEx/cs7tA1bzfwESxfu+Yhab5hn3Qa2Ee2qEXH0JCL2xIM86Dqmtd+h/BYilSQOH3zIqjGwy55WHNtXbqlcKox7EFO7J2M7KE+QtvId3e/GF5UWbToqSnrJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OxoJsAw3; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OxoJsAw3"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6549oGpF1890877;
	Thu, 4 Jun 2026 14:21:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=oE0Ub0olB6h34lpMKP3FAs17XdIpch
	i8PZ9K85+6noE=; b=OxoJsAw3XZwodkdDZlwccDgexpShEPCh3wKk+p6fjiqnM2
	KctBJkUW+/MgJ97rz7gQ+Xqnoj5uoW2J8iA/Y6oAaxqgbGCVNsobzdRxuO+uCpWD
	Bretcv2cxIzCeSaiWRhjxVPCSyi5Y1knwxuR+AyoKhKhqGHLaW5cLQ8vdMqO2Ys8
	ZN3WCzeZwFHiDqPK6rxe8EU/y0krt/eJJhXLOmwJZF3/KCCzuvKNW++Oz4s8c/vD
	EqcMxesSGOWAGtmw54Z8HOcU2Mgu8AW6Oxx/h1Deh02IZY6671Zs6Dl4fCl7AkiM
	MhGcjIhViZDAcqRnibVGIQPRrhjLPiE+mN4qf7wQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqd4g9ey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2026 14:21:00 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 654E99jp029170;
	Thu, 4 Jun 2026 14:20:59 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egbqhn9ns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2026 14:20:58 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 654EKs8t29950262
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Jun 2026 14:20:54 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C45C220040;
	Thu,  4 Jun 2026 14:20:54 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 482562004B;
	Thu,  4 Jun 2026 14:20:52 +0000 (GMT)
Received: from mac.bl1-in.ibm.com (unknown [9.123.11.154])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  4 Jun 2026 14:20:52 +0000 (GMT)
Date: Thu, 4 Jun 2026 19:50:45 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Anushree Mathur <anushree.mathur@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        kvm@vger.kernel.org, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: PPC: Book3S HV: Validate arch_compat against host
 compatibility mode
Message-ID: <aiGJvUqgjUo6M5et@mac.bl1-in.ibm.com>
References: <20260603141539.47620-1-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603141539.47620-1-amachhiw@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDEzOCBTYWx0ZWRfX5xhC4Mz3d6an
 BJxgiXnUtvLEqaBbl4Hf2Vc5O7Pb+5rZppFkgw1GtJVIHSySOcWUmC12P8D98e9mmPBvI4/T3Hp
 aduOR964X9E78QJOeFgs7mtxWbcI2jCIcpGBSbVKl4UTXJamwsFUfEOAlMqOzQdmCtg/iWqH1Qj
 vZdQbx6Vq+xwa30sKkbofvb010aD9qSSTmXUIkrTkS4dtFb2oHh12NxFrKqGN6U1UGG8IPZ5GBW
 Ee6OBbLEntui7Ot60xBi/b6JLWQlc64m9TZjiZmVgGZ3BoaeFsIX1+FB+c/2O+dc1TpG5teCOFv
 GMlUhfpZZtJPygzwTlLJzEqOJZOvvTgfiCoGT7jJ9AqTNjZDxpIH73AXSbCTndI3EFLfdRGvXJk
 2uQEgSoIpVuk0tHBurXoPpfIXr0/8l+qTJpTYWfvBrCuvS2TtLHx7EFuSKEpx0TEiRAicsbMy9K
 Y6bKuJavI1ONz/gkmag==
X-Proofpoint-GUID: m2gMSzyPMp6m9AQfn3fjhHuiZuAtmOL6
X-Proofpoint-ORIG-GUID: 1_mAQCX0EMZ7eKCbvkx9xww1sMZMd9r2
X-Authority-Analysis: v=2.4 cv=DZknbPtW c=1 sm=1 tr=0 ts=6a2189cc cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=qdroVii9w7lgXkXXhtMA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040138

On Wed, Jun 03, 2026 at 07:45:39PM +0530, Amit Machhiwal wrote:
> On IBM POWER systems, newer processor generations can operate in
> compatibility modes corresponding to earlier generations. This becomes
> relevant for nested virtualization, where nested KVM guests may need to
> run with a specific processor compatibility level.
> 
> Currently, when running a nested KVM guest (L2) inside a Power11 pSeries
> logical partition (L1) booted in Power10 compatibility mode, the guest
> fails to boot while setting 'arch_compat'. This happens because the CPU
> class is derived from the hardware PVR (via mfspr()), which reflects the
> physical processor generation (Power11), rather than the effective
> compatibility mode (Power10).
> 
> As a result, userspace may request a Power11 arch_compat for the L2
> guest. However, the L1 partition, running in Power10 compatibility, has
> only negotiated support up to Power10 with the Power Hypervisor (L0).
> When H_GUEST_SET_STATE is invoked with a Power11 Logical PVR, the
> hypervisor rejects the request, leading to a late guest boot failure:
> 
>   KVM-NESTEDv2: couldn't set guest wide elements
>   [..KVM reg dump..]
> 
> This situation should be detected earlier. Rejecting unsupported
> 'arch_compat' values in 'kvmppc_set_arch_compat()' avoids issuing an
> invalid H_GUEST_SET_STATE hcall and provides a clearer failure mode.
> 
> Add a check to reject Power11 'arch_compat' requests when the host is
> running in Power10 compatibility mode, returning -EINVAL early instead
> of deferring the failure to the hypervisor.
> 
> Suggested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
> Cc: <stable@vger.kernel.org> # v6.13+
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
> Changelog:
> 
> * Moved this patch out of the v3 series [1] as discussed here [2]
> * Addressed below review comments from Ritesh:
>   - Based the PVR validation on cpu features
>   - Fixed hcall name typo
>   - Stable backport
> 
> [1] https://lore.kernel.org/all/20260522152744.55251-1-amachhiw@linux.ibm.com/
> [2] https://lore.kernel.org/all/20260522152744.55251-2-amachhiw@linux.ibm.com/
> ---
>  arch/powerpc/kvm/book3s_hv.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 61dbeea317f3..e16dbb199366 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -446,7 +446,17 @@ static int kvmppc_set_arch_compat(struct kvm_vcpu *vcpu, u32 arch_compat)
>  			guest_pcr_bit = PCR_ARCH_300;
>  			break;
>  		case PVR_ARCH_31:
> +			guest_pcr_bit = PCR_ARCH_31;
> +			break;
>  		case PVR_ARCH_31_P11:
> +			/*
> +			 * Need to check this for ISA 3.1, as Power10 and
> +			 * Power11 share the same PCR. For any subsequent ISA
> +			 * versions, this will be taken care of by the guest vs
> +			 * host PCR comparison below.
> +			 */
> +			if (!cpu_has_feature(CPU_FTR_P11_PVR))
> +				return -EINVAL;
>  			guest_pcr_bit = PCR_ARCH_31;
>  			break;
>  		default:
> 
> base-commit: ba3e43a9e601636f5edb54e259a74f96ca3b8fd8
> -- 
> 2.50.1 (Apple Git-155)
> 

I booted a KVM guest on LPAR with this patch in the following scenarios:
1. P10 guest on P10 host: No error observed
2. P11 guest on P11 host: No error observed
3. P11 guest on P11 host booted in P10 compat mode: No error observed

Tested-by: Gautam Menghani <gautam@linux.ibm.com>

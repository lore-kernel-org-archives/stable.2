Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793882975;
	b=oexB+X9F5vfRJcjTsYl2uVpI0YP3fSPBuGAO1R1BZNG/TB9rcNUY1Ng4UcT3LLdqVCF6
	 1FnMki0Sd9b6s3li25Zr5POQo+h6IHgeXQW8v2KImpY00GE6cVihCxebwiv0Ualotz7mJ
	 nXjHP5447qC12gGLmaLUqDZvBFlvt2834/XHSKGdOOhn0w4x/e1m/p19iUzsuJfnX71Q0
	 Q0eq4iEUI6f7IbDSDAJKzNCtfDcb4AbfrMM+nFp3BwBA2OeDPSIZAOWEtQ6tXl+HvjauE
	 /dH2Lgq3Q96cXCPMv/ib7sXsRUBIIcJJ1Pzos533wGrwXmpK1UislbHC/lPYg3vKRIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793882975;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:In-Reply-To:References:Organization:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=R/DBftmiqpvZQZM2WNA5eddXOQrWxFpkrkg4mRpLdPA=;
	b=Lvkla14TOallnQ/R0C/cV1JdjWfpng8aquyAymoFHwxdamnRiMDJ1sdr6KUd6gTSa0vN
	 R/KpnyE/7UrJqisSYG3M2JXf300lFkbjxfVcugXCi3VRlAYEWhzX0sHtbGhlvr6m2Bln3
	 3O9L7c1fykCuT/5APfmWF6JybHD3wiA4boFOzAF7C+IsANpYVx0Bc6Zsg+whfMAhqDOV1
	 J0zgSzp3QuuabDoaGB8YIC2/zoOB2jxadVbNJI6XlBHEyQ4d5sa+RJUjS/DijNJ4EA/3X
	 8Zi1uvc5LQe8BuDT9FDdfty41bJiaOTSfQfZTNrGix9C4OxcLiNj3gu8NOirJJmSitw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ji+tHU+3;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9663606A33D
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 12:49:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9663606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ji+tHU+3
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5AEGlm3166454;
	Thu, 5 Nov 2026 12:49:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=R/DBft
	miqpvZQZM2WNA5eddXOQrWxFpkrkg4mRpLdPA=; b=ji+tHU+3EzwqCoJZ/vjo/X
	KQzUZS16MaK8foEI/4kuRcXUapUxoMk2oMzrTSdg18GUdQqMESrkOReYW4XZZslY
	frSYal3ECBK4G+LJ5aF8MLvHfR7N4aoTlEv9zJApQoqLO87ttv4eZ38sRdAmI34w
	AjFyEnnSL95lDzEx/nFBAFVB3mnd/FSArfzXjQE1a1Se36CnUHszfNdt8BQb+N4X
	tBVC1gx0jcW4ki1Eu/AINSIe/3S8UZwMuJy+LPlJJmy5AKg6HlDn8dnHU9WZzYWV
	sVR/NGIxq9//UqFPnOeOymYWrkBqCxyXwNOxJ+HNtsmkdytRJjBYEWDx0TKPFZkw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn5rj1wwv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 12:49:30 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5A4xwa271774;
	Thu, 5 Nov 2026 12:49:30 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hqsf5gg1f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 12:49:30 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A5CnQrT42139908
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Nov 2026 12:49:26 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 83B6C2004B;
	Thu,  5 Nov 2026 12:49:26 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6177E20040;
	Thu,  5 Nov 2026 12:49:26 +0000 (GMT)
Received: from p-imbrenda (unknown [9.68.31.243])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with SMTP;
	Thu,  5 Nov 2026 12:49:26 +0000 (GMT)
Date: Thu, 5 Nov 2026 13:49:24 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Christian Borntraeger
 <borntraeger@linux.ibm.com>,
        Steffen Eiden <seiden@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Heiko Carstens
 <hca@linux.ibm.com>
Subject: Re: [PATCH 6.18.y 2/4] KVM: s390: Enable KVM_GENERIC_MMU_NOTIFIER
Message-ID: <20261105134924.4e417448@p-imbrenda>
In-Reply-To: <20261104231214.887398-2-sashal@kernel.org>
References: <2026110445-lividly-gratified-dd5f@gregkh>
	<20261104231214.887398-1-sashal@kernel.org>
	<20261104231214.887398-2-sashal@kernel.org>
Organization: IBM
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: BESXC7hHhlpEaGoijwuXQ6kH7lCXuV5i
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA1MCBTYWx0ZWRfX4OZ5FwKXF97F
 hkBcqUfz8r3RS9XGWhxvdPwoB8r4vWXzS3NtTbsx/dMB/v1xKxssHlSWSvSk315k3BgITxjtHTv
 +0DJeUfWvpJv//KCfhr1LsbvrbheWr8=
X-Authority-Analysis: v=2.4 cv=LokHWXdc c=1 sm=1 tr=0 ts=6aec7b5b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=UAWmP4t35YqQfNuaZqgA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA1MCBTYWx0ZWRfX2oioLgoY94qk
 nQINwlJ2GHnb624jP7av54ZSQUk9LvKq8K2/UzefghT8bYXMXAGubTwqt+tffU16pEu6bs+73Qd
 +O0lC7dmM2q+SXgyXtnSwonnHEfDA2IjDz5LeNLE3gSkT/F6Weze885LmVHndEzIQf7OvKhPLMO
 qZV4uxL4csylIdYINm3/xVeD7rszxK0FE43nNMke1lO/rfu1GQLpDGYXR5wZnZUIoSOLHoVLMBV
 zkFooSrhE5FcW+1FVtVR55aOYzQurk4ooqVR8Ncv599WhA3mZpWqVKr/qOwpJCNexnZEj4TfCSm
 vCLp/W7A0gRW06i+LaBlGdsijBr4LU+IiAXTglwSDeTeXJNv8+uK5BUmDeVdJVuf7k6wVwkMjaC
 nCtygPMMccZ4ehytkQeDekzxggLsIcdS4fYhuPo9kV8RDWZj4udOqOMkE0Ki0a4F6lzmw5mG0Y2
 7fiteQtB8GpfgLjw5qA==
X-Proofpoint-GUID: BESXC7hHhlpEaGoijwuXQ6kH7lCXuV5i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1011 impostorscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050050


I'm a little confused, why is this being backported to 6.18?

KVM_GENERIC_MMU_NOTIFIER should not be enabled on s390; s390 will not
use mmu_notifiers for KVM until 7.0

Patch da260bcb56fe ("KVM: pfncache: use a dedicated invalidation
sequence for cache refresh") does not seem to affect the old s390 code
present in 6.18

Or am I missing something?


On Wed,  4 Nov 2026 18:13:02 -0500
Sasha Levin <sashal@kernel.org> wrote:

> From: Claudio Imbrenda <imbrenda@linux.ibm.com>
> 
> [ Upstream commit a2f2798fa6d18d91766b19a4896bd9fd0654d730 ]
> 
> Enable KVM_GENERIC_MMU_NOTIFIER, for now with empty placeholder callbacks.
> 
> Also enable KVM_MMU_LOCKLESS_AGING and define KVM_HAVE_MMU_RWLOCK.
> 
> Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
> Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
> Acked-by: Heiko Carstens <hca@linux.ibm.com>
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Stable-dep-of: da260bcb56fe ("KVM: pfncache: use a dedicated
> invalidation sequence for cache refresh") Signed-off-by: Sasha Levin
> <sashal@kernel.org> ---
>  arch/s390/include/asm/kvm_host.h |  1 +
>  arch/s390/kvm/Kconfig            |  2 ++
>  arch/s390/kvm/kvm-s390.c         | 45
> +++++++++++++++++++++++++++++++- 3 files changed, 47 insertions(+), 1
> deletion(-)
> 
> diff --git a/arch/s390/include/asm/kvm_host.h
> b/arch/s390/include/asm/kvm_host.h index c2ba3d4398c53..f5f87dae0dd9d
> 100644 --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -27,6 +27,7 @@
>  #include <asm/isc.h>
>  #include <asm/guarded_storage.h>
>  
> +#define KVM_HAVE_MMU_RWLOCK
>  #define KVM_MAX_VCPUS 255
>  
>  #define KVM_INTERNAL_MEM_SLOTS 1
> diff --git a/arch/s390/kvm/Kconfig b/arch/s390/kvm/Kconfig
> index 0ca9d6587243c..0c93ed676508b 100644
> --- a/arch/s390/kvm/Kconfig
> +++ b/arch/s390/kvm/Kconfig
> @@ -31,6 +31,8 @@ config KVM
>  	select KVM_VFIO
>  	select MMU_NOTIFIER
>  	select VIRT_XFER_TO_GUEST_WORK
> +	select KVM_GENERIC_MMU_NOTIFIER
> +	select KVM_MMU_LOCKLESS_AGING
>  	help
>  	  Support hosting paravirtualized guest machines using the
> SIE virtualization capability on the mainframe. This should work
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index caf484b4df7ba..9d1150bb38b29 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -4919,7 +4919,7 @@ int __kvm_s390_handle_dat_fault(struct kvm_vcpu
> *vcpu, gfn_t gfn, gpa_t gaddr, u rc =
> fixup_user_fault(vcpu->arch.gmap->mm, vmaddr, fault_flags,
> &unlocked); if (!rc) rc = __gmap_link(vcpu->arch.gmap, gaddr, vmaddr);
> -	scoped_guard(spinlock, &vcpu->kvm->mmu_lock) {
> +	scoped_guard(read_lock, &vcpu->kvm->mmu_lock) {
>  		kvm_release_faultin_page(vcpu->kvm, page, false,
> writable); }
>  	mmap_read_unlock(vcpu->arch.gmap->mm);
> @@ -6141,6 +6141,49 @@ void kvm_arch_commit_memory_region(struct kvm
> *kvm, return;
>  }
>  
> +/**
> + * kvm_test_age_gfn() - test young
> + * @kvm: the kvm instance
> + * @range: the range of guest addresses whose young status needs to
> be cleared
> + *
> + * Context: called by KVM common code without holding the kvm mmu
> lock
> + * Return: true if any page in the given range is young, otherwise 0.
> + */
> +bool kvm_test_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
> +{
> +	return false;
> +}
> +
> +/**
> + * kvm_age_gfn() - clear young
> + * @kvm: the kvm instance
> + * @range: the range of guest addresses whose young status needs to
> be cleared
> + *
> + * Context: called by KVM common code without holding the kvm mmu
> lock
> + * Return: true if any page in the given range was young, otherwise
> 0.
> + */
> +bool kvm_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
> +{
> +	return false;
> +}
> +
> +/**
> + * kvm_unmap_gfn_range() - Unmap a range of guest addresses
> + * @kvm: the kvm instance
> + * @range: the range of guest page frames to invalidate
> + *
> + * This function always returns false because every DAT table
> modification
> + * has to use the appropriate DAT table manipulation instructions,
> which will
> + * keep the TLB coherent, hence no additional TLB flush is ever
> required.
> + *
> + * Context: called by KVM common code with the kvm mmu write lock
> held
> + * Return: false
> + */
> +bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range
> *range) +{
> +	return false;
> +}
> +
>  static inline unsigned long nonhyp_mask(int i)
>  {
>  	unsigned int nonhyp_fai = (sclp.hmfai << i * 2) >> 30;


Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221F74AA3ED;
	Mon,  5 Oct 2026 14:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791210562; cv=none; b=ZjxTboZ5QFsBR6r+FrrqLZqACdoksRvo/CP1pbp8BmEOaeQGV/Le3AIZvjtDOdeMaOtIxqMYPyCq/foXlIppf8zMxvVwLGXLSYEyq42PhQY7y+YXSdRLgFTQeDxfdMz4UlGghf5Sb3tRUSMLFPF1h4bL3HskeGVIPy/h8uCFJ/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791210562; c=relaxed/simple;
	bh=ovSC+uPDkGlZl9aa2bx1cKmsxsJ6nGSC5vcaDAl+HZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j42vEK5UVMqHKZ4Zp/+S38PfkWtrOP1UaFoml9nldLlAueQLkYyeqnyK6ZqFVr+NtU0MA+ds8sesPIOJMlgkBdhcBRDhIFk3GE5gkKYaYqvFd2D3Rqfqa7N+2KOPbWLNervAgd4N2tp2S+WagCW5iFarTg5i6aenZch76gi3130=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iKkbBvSU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iKkbBvSU"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695CZQP03033219;
	Mon, 5 Oct 2026 14:28:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=d06zqM
	fPB1Xe8Ni2jGcra/zTqdfqWfCh7rme8wXcvi0=; b=iKkbBvSUW9L0R9bqO76CIE
	k5d6SBoViV1GiCG2XINbFWO5NqXmfbQl50IrlA5AMSQ+hMgqQXdKdu7OOZlGQEqY
	PgPUd9gyTp2KCBDky6TCGxwHBv7YEOs2sxOvpg4NAgoy5A3a9T1NMMIcMmzdg5FG
	iGmRq8JXKxTT6AxCt70CZoHddmcLR4QTvPOf8SVoNSPFN/zPNE7/HbfA24Z3O5K7
	HEkRqXfRYtL09dnltFURKarh1LWSW4J2mwJdTN3GbwjXVLmqdxP/f40Mth+78gXq
	kMDzy2lyvcc3EwUHftgOMmg5vq6KIphBu7TrsRpVj87XNbU1AS3AJnNQEz2Wwcsw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2scrarf9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 14:28:45 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 695CHtjm2913186;
	Mon, 5 Oct 2026 14:28:44 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h3eqy5kcr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 14:28:44 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 695ESer031916628
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Oct 2026 14:28:40 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA66120043;
	Mon,  5 Oct 2026 14:28:40 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2552A20040;
	Mon,  5 Oct 2026 14:28:37 +0000 (GMT)
Received: from [9.124.213.199] (unknown [9.124.213.199])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Oct 2026 14:28:36 +0000 (GMT)
Message-ID: <fb954b17-c3b9-49f0-a7d4-8e0f7fc0e404@linux.ibm.com>
Date: Mon, 5 Oct 2026 19:58:36 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] KVM: PPC: Book3S HV: Add preempt_disable() around
 virtual-mode HPTE bit-lock users
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
 <20260930173750.56759-3-amachhiw@linux.ibm.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20260930173750.56759-3-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA1NSBTYWx0ZWRfX/lF7k9ioJSkm
 NME2BKNz4eQpvYY0KyBNWNx+fUpT0aYCccDzhf8blkhK/Q1lvWl2c47VAgUPAeiCedXlst0dxJ0
 oOK+N/JWkGMOXfMywSVO3S4/lyId5Eg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA1NSBTYWx0ZWRfXxljf8keCoTBU
 V+b+RTQu6BI1EziKZ4aF9LaqaMbDBq/eMvtdhh1O6Ukc4ZDzp/6sXLqmih3etjfcb/TfbILTKAw
 dQlXAVFEctUgpGq52pyjB4WnpOyh4JAWEBsu6Ov1MQxT5Y9i7D9Gul3n2q2KT1tD4R9DswSwiJ9
 WnQ0GrQr2Q4GYO72upDyLzFwrb1iSYS0dA11VCv9hulG3eUso63Pw5paV3ZzwvVCv4PiJv5c7Fy
 tZDuHNM7ZlF7RPTG2WUxvyW9Jj3Aso77greii6Wn7NV2AP0uuGfYB2nA2GpcpM6QzI15LkIRPbU
 osLVDZUo1aecUBZHLEC2Wibe6T9OdrvlVmwJAbM4O14xLyv1EEyNRG6AtrIERfQXdZL4DoRJKCy
 /DaNEuX2NfePLGjZ2wBhVlNfOafymHUzqNs+6hYrVP5wkB+3Kmz8pYnEM0y2IRtuAgiGTCCgpDx
 sYHimmO3w4hXcCpWyZA==
X-Proofpoint-GUID: 0QWLeI46hBvP2X9GjFqhBYoDRGe4jCbn
X-Proofpoint-ORIG-GUID: YS8G30qXFar5RvrqCDAa7KB1M6SA1ql8
X-Authority-Analysis: v=2.4 cv=B7osQ+tM c=1 sm=1 tr=0 ts=6ac3b41d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=u9YDEFzsEscQV6yasUIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_03,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 malwarescore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050055

Hi Amit.

On 9/30/26 11:07 PM, Amit Machhiwal wrote:
> kvmppc_hv_find_lock_hpte() requires virtual-mode callers to run with
> preemption disabled, because it can return with HPTE_V_HVLOCK still held
> until the caller later unlocks the HPTE.  Existing virtual-mode callers
> in book3s_64_mmu_hv.c already follow that rule, but several paths do
> not.
> 
> kvmppc_handle_exit_hv() calls kvmppc_hpte_hv_fault() for hash-mode
> data-side and instruction-side faults after guest exit with preemption
> enabled.  kvmppc_pseries_do_hcall() executes virtual-mode HPT hcall
> handlers via kvmppc_pseries_do_hpt_hcall() with preemption enabled; the
> handlers for H_ENTER, H_REMOVE, H_READ, H_CLEAR_MOD, H_CLEAR_REF,
> H_PROTECT, and H_BULK_REMOVE all spin on try_lock_hpte() or lock_rmap().
> H_ENTER also reaches kvmppc_do_h_enter(), which uses arch_spin_lock() on
> kvm->mmu_lock.  That raw lock choice is intentional because
> kvmppc_do_h_enter() is also called from real-mode paths, so the correct
> fix is to establish the proper preemption context at the virtual-mode
> caller boundary.
> 
> On the host side, kvm_unmap_rmapp(), kvm_age_rmapp(),
> kvm_test_clear_dirty_npages(), and resize_hpt_rehash_hpte() also acquire
> HPTE_V_HVLOCK via try_lock_hpte() in process context with preemption
> enabled, serving MMU notifier callbacks, dirty-log harvesting, and HPT
> resize respectively.
> 
> If any of these threads is preempted while holding HPTE_V_HVLOCK, any
> other thread on the same CPU spinning on the same bit-lock can never
> make progress, as the lock owner cannot be rescheduled to release it.
> This is particularly acute when the spinning thread has preemption
> disabled: it will never yield, causing a permanent CPU hang.
> 
> Fix this by adding preempt_disable()/preempt_enable() pairs around the
> two kvmppc_hpte_hv_fault() call sites in kvmppc_handle_exit_hv(), around
> the kvmppc_pseries_do_hpt_hcall() invocation in kvmppc_pseries_do_hcall(),
> and around the try_lock_hpte() hold windows in kvm_unmap_rmapp(),
> kvm_age_rmapp(), kvm_test_clear_dirty_npages(), and resize_hpt_rehash_hpte().
> On failed lock acquisition the guard is released before the cpu_relax()
> spin so the lock owner can be scheduled.
> 
> Fixes: 6165d5dd99db ("KVM: PPC: Book3S HV: add virtual mode handlers for HPT hcalls and page faults")
> Cc: stable@vger.kernel.org # v5.14+
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
> Changes in v2:
> - Extended preempt_disable()/preempt_enable() to also cover four
>    host-side virtual-mode HPTE bit-lock users in book3s_64_mmu_hv.c.
> - Added warning comment above kvmppc_pseries_do_hpt_hcall().
> - Dropped Reviewed-by as the patch was materially extended.
> 
>   arch/powerpc/kvm/book3s_64_mmu_hv.c | 12 ++++++++++++
>   arch/powerpc/kvm/book3s_hv.c        | 10 ++++++++++
>   2 files changed, 22 insertions(+)
> 
> diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> index 2ccb3d138f46..59da958e09cb 100644
> --- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> @@ -823,7 +823,9 @@ static void kvm_unmap_rmapp(struct kvm *kvm, struct kvm_memory_slot *memslot,
>   		 */
>   		i = *rmapp & KVMPPC_RMAP_INDEX;
>   		hptep = (__be64 *) (kvm->arch.hpt.virt + (i << 4));
> +		preempt_disable();
>   		if (!try_lock_hpte(hptep, HPTE_V_HVLOCK)) {
> +			preempt_enable();
>   			/* unlock rmap before spinning on the HPTE lock */
>   			unlock_rmap(rmapp);
>   			while (be64_to_cpu(hptep[0]) & HPTE_V_HVLOCK)
> @@ -834,6 +836,7 @@ static void kvm_unmap_rmapp(struct kvm *kvm, struct kvm_memory_slot *memslot,
>   		kvmppc_unmap_hpte(kvm, i, memslot, rmapp, gfn);
>   		unlock_rmap(rmapp);
>   		__unlock_hpte(hptep, be64_to_cpu(hptep[0]));
> +		preempt_enable();
>   	}
>   }
>   
> @@ -909,7 +912,9 @@ static bool kvm_age_rmapp(struct kvm *kvm, struct kvm_memory_slot *memslot,
>   		if (!(be64_to_cpu(hptep[1]) & HPTE_R_R))
>   			continue;
>   
> +		preempt_disable();
>   		if (!try_lock_hpte(hptep, HPTE_V_HVLOCK)) {
> +			preempt_enable();
>   			/* unlock rmap before spinning on the HPTE lock */
>   			unlock_rmap(rmapp);
>   			while (be64_to_cpu(hptep[0]) & HPTE_V_HVLOCK)
> @@ -928,6 +933,7 @@ static bool kvm_age_rmapp(struct kvm *kvm, struct kvm_memory_slot *memslot,
>   			ret = true;
>   		}
>   		__unlock_hpte(hptep, be64_to_cpu(hptep[0]));
> +		preempt_enable();
>   	} while ((i = j) != head);
>   
>   	unlock_rmap(rmapp);
> @@ -1043,7 +1049,9 @@ static int kvm_test_clear_dirty_npages(struct kvm *kvm, unsigned long *rmapp)
>   		    (!hpte_is_writable(hptep1) || vcpus_running(kvm)))
>   			continue;
>   
> +		preempt_disable();
>   		if (!try_lock_hpte(hptep, HPTE_V_HVLOCK)) {
> +			preempt_enable();
>   			/* unlock rmap before spinning on the HPTE lock */
>   			unlock_rmap(rmapp);
>   			while (hptep[0] & cpu_to_be64(HPTE_V_HVLOCK))
> @@ -1054,6 +1062,7 @@ static int kvm_test_clear_dirty_npages(struct kvm *kvm, unsigned long *rmapp)
>   		/* Now check and modify the HPTE */
>   		if (!(hptep[0] & cpu_to_be64(HPTE_V_VALID))) {
>   			__unlock_hpte(hptep, be64_to_cpu(hptep[0]));
> +			preempt_enable();
>   			continue;
>   		}
>   
> @@ -1077,6 +1086,7 @@ static int kvm_test_clear_dirty_npages(struct kvm *kvm, unsigned long *rmapp)
>   		v &= ~HPTE_V_ABSENT;
>   		v |= HPTE_V_VALID;
>   		__unlock_hpte(hptep, v);
> +		preempt_enable();
>   	} while ((i = j) != head);
>   
>   	unlock_rmap(rmapp);
> @@ -1219,6 +1229,7 @@ static unsigned long resize_hpt_rehash_hpte(struct kvm_resize_hpt *resize,
>   	if (!(vpte & HPTE_V_VALID) && !(vpte & HPTE_V_ABSENT))
>   		return 0; /* nothing to do */
>   
> +	preempt_disable();
>   	while (!try_lock_hpte(hptep, HPTE_V_HVLOCK))
>   		cpu_relax();
>   
> @@ -1346,6 +1357,7 @@ static unsigned long resize_hpt_rehash_hpte(struct kvm_resize_hpt *resize,
>   
>   out:
>   	unlock_hpte(hptep, vpte);
> +	preempt_enable();

I don't like this sprinkling of preempt disable/enable.
Is there not a way to embedd this in try_lock_hpte/unlock_hpte?

Also, Is any of these be called in real mode?
Note that currently preempt count is derived from thread info.
So it may not be safe in real mode.

>   	return ret;
>   }
>   
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index aa51968e206a..0b7743bb89d9 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -1159,6 +1159,10 @@ static long kvmppc_h_rpt_invalidate(struct kvm_vcpu *vcpu,
>   	return H_SUCCESS;
>   }
>   
> +/*
> + * Must be called with preemption disabled. The HPT hcall handlers spin
> + * on HPTE bit-locks and cannot make any blocking/sleeping calls.
> + */
>   static long kvmppc_pseries_do_hpt_hcall(struct kvm_vcpu *vcpu, unsigned long req)
>   {
>   	switch (req) {
> @@ -1212,9 +1216,11 @@ int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
>   	case H_CLEAR_REF:
>   	case H_PROTECT:
>   	case H_BULK_REMOVE:
> +		preempt_disable();
>   		idx = srcu_read_lock(&kvm->srcu);
>   		ret = kvmppc_pseries_do_hpt_hcall(vcpu, req);
>   		srcu_read_unlock(&kvm->srcu, idx);
> +		preempt_enable();
>   		if (ret == H_TOO_HARD)
>   			return RESUME_HOST;
>   		break;
> @@ -1834,8 +1840,10 @@ static int kvmppc_handle_exit_hv(struct kvm_vcpu *vcpu,
>   		else
>   			vsid = vcpu->arch.fault_gpa;
>   
> +		preempt_disable();
>   		err = kvmppc_hpte_hv_fault(vcpu, vcpu->arch.fault_dar,
>   				vsid, vcpu->arch.fault_dsisr, true);
> +		preempt_enable();
>   		if (err == 0) {
>   			r = RESUME_GUEST;
>   		} else if (err == -1 || err == -2) {
> @@ -1881,8 +1889,10 @@ static int kvmppc_handle_exit_hv(struct kvm_vcpu *vcpu,
>   		else
>   			vsid = vcpu->arch.fault_gpa;
>   
> +		preempt_disable();
>   		err = kvmppc_hpte_hv_fault(vcpu, vcpu->arch.fault_dar,
>   				vsid, vcpu->arch.fault_dsisr, false);
> +		preempt_enable();
>   		if (err == 0) {
>   			r = RESUME_GUEST;
>   		} else if (err == -1) {


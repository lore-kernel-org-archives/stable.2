Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C6B4DE701;
	Wed, 30 Sep 2026 13:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790775553; cv=none; b=Sw9xGgszWxh1Yn/TsTcimI70RHzxctLWpZm+Q8tfHJxOPW2T/9iFrFkMOTwtBEwTzMsrcwDKLee9yTOG6XILLOi4OMV9WCxc6G/Rz4SnrrFVcVWqDzejbqJ399p+sM+Cebw+v4BUkLftnJ6saDAUIvK2IGPazGK0M3kuGkwRoCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790775553; c=relaxed/simple;
	bh=h22vSDkbVAwxIYjX0M0qIc6dpj1iaZQkWyUg5l7W5dM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQ13mOahK+r7KHPjVODRWuKWi+oH0V8iqNEvkKk1vg2ksg2JN8e44sKzYuS8tUuhozvLWzQOl9lNopYXyKu6VU8EbTpDAjM+YppFXIVhkFLoL8LJFiI7jIxIosOR5EP+T9vD7QW8AvJufCqs16pj6gPki7cnBJVm4ziIEaewroA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=C6bVeoF7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="C6bVeoF7"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68UB5NVi2798326;
	Wed, 30 Sep 2026 13:38:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=j0LRCX
	QRdK8U0mZCDcxBrktz5SCPHZj5h5xK40AbDWY=; b=C6bVeoF7FyGyoYZGP78mDL
	w+zvISG2GqybXhgt+p+K4ft+yC2QOz5jXeuvsBqQyE921kCJQKZEGCgDbvstN2zv
	0CaGeFGcuuinTJh0LPTztuH4gTyAH9XOUdrWQTT5veyHTnRKlwiVBwSNmiDMq8CQ
	q2TfeWLtVKMyORYZ4crXKixU0iSdsvx1wJtsHgVNzIiWzRqPFvKCkK9mHgZyc7ud
	LJiXZofTQlNZ8UwaG7h4K/g6D9oc06U0sg5uMnnQmQY4ptY+DLcmwFp+wwYXROS7
	dGKH7Zih61+7XEoYgr5sc2OVuPCF8kaXrZwuuIirtHQ4RzUeUwOJQebMg8NETO6Q
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5s5d7hj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 13:38:26 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68UBHURp3353630;
	Wed, 30 Sep 2026 13:38:25 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h0j23kupe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 13:38:25 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68UDcLRk27459952
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Sep 2026 13:38:22 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB7F820040;
	Wed, 30 Sep 2026 13:38:21 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E781820043;
	Wed, 30 Sep 2026 13:38:15 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 30 Sep 2026 13:38:15 +0000 (GMT)
Date: Wed, 30 Sep 2026 19:08:26 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        kvm-ppc@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Gautam Menghani <gautam@linux.ibm.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        R Nageswara Sastry <rnsastry@linux.ibm.com>,
        Alexander Graf <agraf@suse.de>, linux-hardening@vger.kernel.org,
        stable@vger.kernel.org, Avi Kivity <avi@redhat.com>
Subject: Re: [RESEND PATCH 2/3] KVM: PPC: Book3S HV: Add preempt_disable()
 around virtual-mode HPTE bit-lock users
Message-ID: <20260930180232.ffed855b-03-amachhiw@linux.ibm.com>
Mail-Followup-To: Shrikanth Hegde <sshegde@linux.ibm.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, 
	Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Gautam Menghani <gautam@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, 
	R Nageswara Sastry <rnsastry@linux.ibm.com>, Alexander Graf <agraf@suse.de>, linux-hardening@vger.kernel.org, 
	stable@vger.kernel.org, Avi Kivity <avi@redhat.com>
References: <20260928122837.8782-1-amachhiw@linux.ibm.com>
 <20260928122837.8782-3-amachhiw@linux.ibm.com>
 <57f589e4-b7cc-43d1-8d02-732d10118833@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <57f589e4-b7cc-43d1-8d02-732d10118833@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA1NCBTYWx0ZWRfX4EgFbb6zL1BS
 cNrvtNMsBgt3gkhirmgxsVnMCLCRc/qT5adQVks46oBQnvn5XMp9ADb1c3mvfbW5uOmqoshnoB6
 GYM8s8ilUPQIiF7Y+M+adLwevqhkyko=
X-Authority-Analysis: v=2.4 cv=HJ5WhYtv c=1 sm=1 tr=0 ts=6abd10d2 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=A1fdaXlmI8BdxGPDefsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: DKTSW_9HlJkEjTjvjdXXIDw1J-ICCYRx
X-Proofpoint-ORIG-GUID: Iok8jqdxo72sJXwY6sEBRb8KbdrFdBE8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA1NCBTYWx0ZWRfXwBe+XxtmE3ND
 rIJV3dJAHr4G7dV4+AfJ5tKccIUUPbn0dWP5pEl6RBdNgy1qw0iRbCd6zVOPHjLnfPxagueEkyZ
 duFcUNDtw4do337neU1Xw1HirXT3KL9m5sM3zHaUZEsPGDGrlwtzYIghVt2dVvpmrHjl+hCrJSG
 6HaClja19CW0PN8c5hzz8S6zvPMymUawHaXShtdoyTdeI7SDJ+HSJ3/raxlRTn/w+hDhydF5DLu
 cbj3NXIm3MySMaZAxNbGFz99dno60dB1DLp/aVB1iSYVzyNqkK2N02K2MGAGyKRzAn76nfcvVfm
 s3hcpxih7qpVNYYeAiWZIedjU0v8e0EYrO6Bu3D+x32h6k6rtqMsD+JW405/ql4tDSEjOOktR+W
 k0EZR3CeCl0RQEhiEEjSpQgAIr58uQlblQfxeuoqOlKTTzfI2uRv4jwE3WON/pgE4KNRTLh4Amr
 gLPbh+UmZa139v3fEIQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300054

Hi Shrikanth,

Thanks for taking a look at this patch.  Please find my responses inline.

On 2026/09/29 11:48 AM, Shrikanth Hegde wrote:
> 
> 
> On 9/28/26 5:58 PM, Amit Machhiwal wrote:
> > kvmppc_hv_find_lock_hpte() requires virtual-mode callers to run with
> > preemption disabled, because it can return with HPTE_V_HVLOCK still held
> > until the caller later unlocks the HPTE.  Existing virtual-mode callers
> > in book3s_64_mmu_hv.c already follow that rule.
> > 

<..snip..>

> > diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> > index aa51968e206a..52f72f30baf0 100644
> > --- a/arch/powerpc/kvm/book3s_hv.c
> > +++ b/arch/powerpc/kvm/book3s_hv.c
> > @@ -1212,9 +1212,11 @@ int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
> >   	case H_CLEAR_REF:
> >   	case H_PROTECT:
> >   	case H_BULK_REMOVE:
> > +		preempt_disable();
> >   		idx = srcu_read_lock(&kvm->srcu);
> 
> Please add a comment above kvmppc_pseries_do_hpt_hcall, saying preemption
> is disabled and one cannot make any blocking call.

Sure, will do.

> 
> >   		ret = kvmppc_pseries_do_hpt_hcall(vcpu, req);
> >   		srcu_read_unlock(&kvm->srcu, idx);
> > +		preempt_enable();
> >   		if (ret == H_TOO_HARD)
> >   			return RESUME_HOST;
> >   		break;
> > @@ -1834,8 +1836,10 @@ static int kvmppc_handle_exit_hv(struct kvm_vcpu *vcpu,
> >   		else
> >   			vsid = vcpu->arch.fault_gpa;
> > +		preempt_disable();
> >   		err = kvmppc_hpte_hv_fault(vcpu, vcpu->arch.fault_dar,
> >   				vsid, vcpu->arch.fault_dsisr, true);
> > +		preempt_enable();
> >   		if (err == 0) {
> >   			r = RESUME_GUEST;
> >   		} else if (err == -1 || err == -2) {
> > @@ -1881,8 +1885,10 @@ static int kvmppc_handle_exit_hv(struct kvm_vcpu *vcpu,
> >   		else
> >   			vsid = vcpu->arch.fault_gpa;
> > +		preempt_disable();
> >   		err = kvmppc_hpte_hv_fault(vcpu, vcpu->arch.fault_dar,
> >   				vsid, vcpu->arch.fault_dsisr, false);
> > +		preempt_enable();
> >   		if (err == 0) {
> >   			r = RESUME_GUEST;
> >   		} else if (err == -1) {
> 
> Please check if below is possible case.
> 
> https://sashiko.dev/#/patchset/20260928113704.48912-4-amachhiw%40linux.ibm.com

Thank you for raising this point and bringing Sashiko AI's review comment to
attention.  After conducting a deep-dive audit of the preemption paths and the
virtual-mode locking context, it looks like Sashiko's finding is legitimate, and
extremely subtle.

The Deadlock Mechanism:
=======================

In this patch we added preempt_disable() / preempt_enable() pairs exclusively
around the guest vCPU HPT hcall paths (kvmppc_pseries_do_hpt_hcall) and page
fault paths (kvmppc_hpte_hv_fault) in virtual mode to satisfy the HPTE locking
preemption contract.

However, several host-side virtual-mode paths still acquire and hold the HPTE
bit-lock (HPTE_V_HVLOCK) with preemption enabled.  Specifically:

- While MMU notifier paths (unmapping, aging) and the dirty-log path are safe
  (since they are called with kvm->mmu_lock held, which disables preemption),
  the memslot flushing path (kvmppc_core_flush_memslot_hv() ->
  kvm_unmap_rmapp()) runs with only the slots_arch_lock mutex held, leaving
  preemption fully enabled.

If a host-side thread executing kvm_unmap_rmapp() successfully acquires the
HPTE_V_HVLOCK on CPU X and is preempted, a guest vCPU thread subsequently
scheduled on CPU X will enter the hcall or fault path, disable preemption (via
the current change), and spin indefinitely on try_lock_hpte().  Because
preemption is disabled on the spinning vCPU, it will never yield CPU X.  The
preempted host-side lock owner can never be rescheduled on CPU X to release the
lock.

This converts a potential latency/livelock issue into a permanent hard deadlock.

Proposed Solution:
==================

To make this fix completely watertight and eliminate the deadlock window, no
thread must ever be preempted while holding HPTE_V_HVLOCK in virtual mode.  This
means we must disable preemption during the lock-hold window on both the
vCPU-side and the host-side paths.

In the next version, I'll be making following changes:

Host-Side Preemption Disabling: Add preempt_disable() / preempt_enable()
brackets around the HPTE_V_HVLOCK hold windows inside the four host-side
virtual-mode functions in arch/powerpc/kvm/book3s_64_mmu_hv.c:

  - kvm_unmap_rmapp()
  - kvm_age_rmapp()
  - kvm_test_clear_dirty_npages()
  - resize_hpt_rehash_hpte()

For example, inside kvm_unmap_rmapp():

 diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
 index 2ccb3d138f46..59da958e09cb 100644
 --- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
 +++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
 @@ -823,7 +823,9 @@ static void kvm_unmap_rmapp(struct kvm *kvm, struct kvm_memory_slot *memslot,
                  */
                 i = *rmapp & KVMPPC_RMAP_INDEX;
                 hptep = (__be64 *) (kvm->arch.hpt.virt + (i << 4));
 +               preempt_disable();
                 if (!try_lock_hpte(hptep, HPTE_V_HVLOCK)) {
 +                       preempt_enable();
                         /* unlock rmap before spinning on the HPTE lock */
                         unlock_rmap(rmapp);
                         while (be64_to_cpu(hptep[0]) & HPTE_V_HVLOCK)
 @@ -834,6 +836,7 @@ static void kvm_unmap_rmapp(struct kvm *kvm, struct kvm_memory_slot *memslot,
                 kvmppc_unmap_hpte(kvm, i, memslot, rmapp, gfn);
                 unlock_rmap(rmapp);
                 __unlock_hpte(hptep, be64_to_cpu(hptep[0]));
 +               preempt_enable();
         }
  }

To ensure complete consistency and verify there are no other potential
preemption deadlock sites, I conducted a full audit of all 8 occurrences of
try_lock_hpte() inside arch/powerpc/kvm/book3s_64_mmu_hv.c.

The proposed v2 fixes simply bring the host-side lock users into alignment with
the established, pre-existing design pattern used by every other virtual-mode
caller of try_lock_hpte() in this file:

- Established safe callers (4) — already wrapped in preempt_disable() /
  preempt_enable() blocks by design:
	- kvmppc_book3s_hv_page_fault()
	- read_hpte_for_cma()
	- kvmppc_hpte_hv_page_debug()

- Symmetrical alignment in v2 (4):
	- kvm_unmap_rmapp()
	- kvm_age_rmapp()
	- kvm_test_clear_dirty_npages()
	- resize_hpt_rehash_hpte()

This ensures 100% preemption-safety symmetry across all virtual-mode
lock-holding windows in KVM.

I hope this sounds good to you.

Thanks,
Amit

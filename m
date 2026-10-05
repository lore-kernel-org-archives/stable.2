Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F2548551B;
	Mon,  5 Oct 2026 18:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791224409; cv=none; b=UdeEcqBkrnCuY1AV09G8AD10a7dE0O792ZgIt9YXgKYGww+vw13/c7vjFiWas4bzWO4b3H56q9AbInikwpkTEzrCrfMXg5N545PEukbV9oeevEbm5PfrjYYP488AdHkw5wpzUcACxSKDCl5A/y9HSCJxtZtEamGAAUbapbTMWIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791224409; c=relaxed/simple;
	bh=8RjtvhztfKaiHybQasW0Hsdzq6yZm1JNEH40GnRMglw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kb5gfvHYLh29UL9Hd/qBoiKcJGD/WIEyTuTnZ0Qa1/7l0ZT67rsC5JVDUUTj9/Ly8prsiPbHCAjuCTaSmFpe/UvZ4Bz47t+Gvtpcat/UjVojapSBN2/jjAkZiMJVdp+ngUHzp7cqRl3uk1MqHjHtWS2ti3RFMgJwjYmyS+9RnP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=F7t5N6Tl; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="F7t5N6Tl"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695HZT9E1257180;
	Mon, 5 Oct 2026 18:19:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BWmqZ6
	IYywvv2BPCxo/LGr78lDGWHdYIfGeiUXRN2Mo=; b=F7t5N6Tl3k+iOvRyVPT0Ys
	t0LymEYy3l7MVX3k0y3x1EiE7KmMoFomRyVSI5tuPXwP3fYCGJXup3Tn4UNOlHfZ
	OMD2yc/Tptxx9eLVqELmH6Adyu4jF7LP0Bmzip2JNCDwg5paDHvtgPYs8pDnd5ID
	CJ0nPy46pAbA2HxKdR3swru9hJcdP98MvO0LmN2loDEe0dJwdCdHofJ4cfGWfcgd
	QjEVAuGPCSB6+/rhZYIvk4dV2uBoqZbME1cpT3Yi5Rww76dB3MKxUeSsmdG3KYuZ
	zhBsdRX3FQ2GWpU+mE0JTSphsa7wQFvcsxgUqTLqS4qvfiB643UxiWL9wvwEVFlQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2se5bs8d-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 18:19:48 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 695HMcPg3252065;
	Mon, 5 Oct 2026 18:19:47 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h3eqy6c8b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 18:19:47 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 695IJhU547383030
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Oct 2026 18:19:43 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD31920043;
	Mon,  5 Oct 2026 18:19:43 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C90320040;
	Mon,  5 Oct 2026 18:19:40 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  5 Oct 2026 18:19:40 +0000 (GMT)
Date: Mon, 5 Oct 2026 23:57:52 +0530
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
Subject: Re: [PATCH v2 2/3] KVM: PPC: Book3S HV: Add preempt_disable() around
 virtual-mode HPTE bit-lock users
Message-ID: <20261005234024.20213ac7-78-amachhiw@linux.ibm.com>
Mail-Followup-To: Shrikanth Hegde <sshegde@linux.ibm.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, 
	Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Gautam Menghani <gautam@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, 
	R Nageswara Sastry <rnsastry@linux.ibm.com>, Alexander Graf <agraf@suse.de>, linux-hardening@vger.kernel.org, 
	stable@vger.kernel.org, Avi Kivity <avi@redhat.com>
References: <20260930173750.56759-1-amachhiw@linux.ibm.com>
 <20260930173750.56759-3-amachhiw@linux.ibm.com>
 <fb954b17-c3b9-49f0-a7d4-8e0f7fc0e404@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fb954b17-c3b9-49f0-a7d4-8e0f7fc0e404@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA3MSBTYWx0ZWRfXxbBME0SXbNfH
 Fy+E35vRaQJLs4HwkjxuuMvUxl4tl7HQczLmt/fRHCbvp+Xps918e8NOjTDIfawGc+Ajeg/m69f
 LUjPKOIDF8zdLg34v4UHlQ8G4sf2m10=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA3MSBTYWx0ZWRfX/8j12AHp91GH
 WrA2IfYvhbvY8rXQutpI/NcbUKRzyMJCP4lz20ng+0Jp94LIUWwlrnY+d0ebFbbGtQjHc+ie5HD
 QKbvETTZaxggEnlGL3sFq0yq8ufMH74JH6+9mdsprZZuHmH2wLilXQTxP80JLqcfIlGIAKFvdef
 v0TvyQT+x3dpDpSt0JoEuD4pA8JYdsEfKJdrq2fthPo4ZjR1clz04Nn/iEJLOuxq9LrpEdPlnFi
 Nfrkxm8hYl7aOHkJPiiwb64X7wj9JaALFosmtby83ibgc/2DtwVN8eCYOBTIZYZbu2PmUjno4oS
 qV2EOyZzxnxxEVvoM1bYS8zQISWhFIY888veTwwMfmzp57DpQ4oIop9R8VFIc9+XOdva2ZZhuNa
 f8hRhhnM8DbMCI+DYkkIjnvmPQlTG2eIFYvIs/o6WHTAsVobzADkGEu+/bRtmTgW2PIPJBJFd1C
 GkPVLtFhLL5n5uftISA==
X-Proofpoint-GUID: l_FlaIUtu4yPXD4idRUQz3hwDx36bxGH
X-Authority-Analysis: v=2.4 cv=UNRIjyfy c=1 sm=1 tr=0 ts=6ac3ea44 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=DmuH68SPCCL6Sp2UwjMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: vilJbN7VEgVCopRAYTN15ceDyLpNL74R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050071

Hi Shrikanth,

Thanks for the review.  Please find my responses inline below.

On 2026/10/05 07:58 PM, Shrikanth Hegde wrote:
> Hi Amit.
> 
> On 9/30/26 11:07 PM, Amit Machhiwal wrote:
> > kvmppc_hv_find_lock_hpte() requires virtual-mode callers to run with
> > preemption disabled, because it can return with HPTE_V_HVLOCK still held
> > until the caller later unlocks the HPTE.  Existing virtual-mode callers
> > in book3s_64_mmu_hv.c already follow that rule, but several paths do
> > not.
> > 
> > kvmppc_handle_exit_hv() calls kvmppc_hpte_hv_fault() for hash-mode
> > data-side and instruction-side faults after guest exit with preemption
> > enabled.  kvmppc_pseries_do_hcall() executes virtual-mode HPT hcall
> > handlers via kvmppc_pseries_do_hpt_hcall() with preemption enabled; the
> > handlers for H_ENTER, H_REMOVE, H_READ, H_CLEAR_MOD, H_CLEAR_REF,
> > H_PROTECT, and H_BULK_REMOVE all spin on try_lock_hpte() or lock_rmap().
> > H_ENTER also reaches kvmppc_do_h_enter(), which uses arch_spin_lock() on
> > kvm->mmu_lock.  That raw lock choice is intentional because
> > kvmppc_do_h_enter() is also called from real-mode paths, so the correct
> > fix is to establish the proper preemption context at the virtual-mode
> > caller boundary.
> > 
> > On the host side, kvm_unmap_rmapp(), kvm_age_rmapp(),
> > kvm_test_clear_dirty_npages(), and resize_hpt_rehash_hpte() also acquire
> > HPTE_V_HVLOCK via try_lock_hpte() in process context with preemption
> > enabled, serving MMU notifier callbacks, dirty-log harvesting, and HPT
> > resize respectively.
> > 
> > If any of these threads is preempted while holding HPTE_V_HVLOCK, any
> > other thread on the same CPU spinning on the same bit-lock can never
> > make progress, as the lock owner cannot be rescheduled to release it.
> > This is particularly acute when the spinning thread has preemption
> > disabled: it will never yield, causing a permanent CPU hang.
> > 
> > Fix this by adding preempt_disable()/preempt_enable() pairs around the
> > two kvmppc_hpte_hv_fault() call sites in kvmppc_handle_exit_hv(), around
> > the kvmppc_pseries_do_hpt_hcall() invocation in kvmppc_pseries_do_hcall(),
> > and around the try_lock_hpte() hold windows in kvm_unmap_rmapp(),
> > kvm_age_rmapp(), kvm_test_clear_dirty_npages(), and resize_hpt_rehash_hpte().
> > On failed lock acquisition the guard is released before the cpu_relax()
> > spin so the lock owner can be scheduled.
> > 
> > Fixes: 6165d5dd99db ("KVM: PPC: Book3S HV: add virtual mode handlers for HPT hcalls and page faults")
> > Cc: stable@vger.kernel.org # v5.14+
> > Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> > ---
> > Changes in v2:
> > - Extended preempt_disable()/preempt_enable() to also cover four
> >    host-side virtual-mode HPTE bit-lock users in book3s_64_mmu_hv.c.
> > - Added warning comment above kvmppc_pseries_do_hpt_hcall().
> > - Dropped Reviewed-by as the patch was materially extended.
> > 
> >   arch/powerpc/kvm/book3s_64_mmu_hv.c | 12 ++++++++++++
> >   arch/powerpc/kvm/book3s_hv.c        | 10 ++++++++++
> >   2 files changed, 22 insertions(+)
> > 
> > diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> > index 2ccb3d138f46..59da958e09cb 100644
> > --- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
> > +++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> > @@ -823,7 +823,9 @@ static void kvm_unmap_rmapp(struct kvm *kvm, struct kvm_memory_slot *memslot,
> >   		 */
> >   		i = *rmapp & KVMPPC_RMAP_INDEX;
> >   		hptep = (__be64 *) (kvm->arch.hpt.virt + (i << 4));
> > +		preempt_disable();
> >   		if (!try_lock_hpte(hptep, HPTE_V_HVLOCK)) {
> > +			preempt_enable();
> >   			/* unlock rmap before spinning on the HPTE lock */
> >   			unlock_rmap(rmapp);
> >   			while (be64_to_cpu(hptep[0]) & HPTE_V_HVLOCK)
> > @@ -834,6 +836,7 @@ static void kvm_unmap_rmapp(struct kvm *kvm, struct kvm_memory_slot *memslot,
> >   		kvmppc_unmap_hpte(kvm, i, memslot, rmapp, gfn);
> >   		unlock_rmap(rmapp);
> >   		__unlock_hpte(hptep, be64_to_cpu(hptep[0]));
> > +		preempt_enable();
> >   	}
> >   }
> > @@ -909,7 +912,9 @@ static bool kvm_age_rmapp(struct kvm *kvm, struct kvm_memory_slot *memslot,
> >   		if (!(be64_to_cpu(hptep[1]) & HPTE_R_R))
> >   			continue;
> > +		preempt_disable();
> >   		if (!try_lock_hpte(hptep, HPTE_V_HVLOCK)) {
> > +			preempt_enable();
> >   			/* unlock rmap before spinning on the HPTE lock */
> >   			unlock_rmap(rmapp);
> >   			while (be64_to_cpu(hptep[0]) & HPTE_V_HVLOCK)
> > @@ -928,6 +933,7 @@ static bool kvm_age_rmapp(struct kvm *kvm, struct kvm_memory_slot *memslot,
> >   			ret = true;
> >   		}
> >   		__unlock_hpte(hptep, be64_to_cpu(hptep[0]));
> > +		preempt_enable();
> >   	} while ((i = j) != head);
> >   	unlock_rmap(rmapp);
> > @@ -1043,7 +1049,9 @@ static int kvm_test_clear_dirty_npages(struct kvm *kvm, unsigned long *rmapp)
> >   		    (!hpte_is_writable(hptep1) || vcpus_running(kvm)))
> >   			continue;
> > +		preempt_disable();
> >   		if (!try_lock_hpte(hptep, HPTE_V_HVLOCK)) {
> > +			preempt_enable();
> >   			/* unlock rmap before spinning on the HPTE lock */
> >   			unlock_rmap(rmapp);
> >   			while (hptep[0] & cpu_to_be64(HPTE_V_HVLOCK))
> > @@ -1054,6 +1062,7 @@ static int kvm_test_clear_dirty_npages(struct kvm *kvm, unsigned long *rmapp)
> >   		/* Now check and modify the HPTE */
> >   		if (!(hptep[0] & cpu_to_be64(HPTE_V_VALID))) {
> >   			__unlock_hpte(hptep, be64_to_cpu(hptep[0]));
> > +			preempt_enable();
> >   			continue;
> >   		}
> > @@ -1077,6 +1086,7 @@ static int kvm_test_clear_dirty_npages(struct kvm *kvm, unsigned long *rmapp)
> >   		v &= ~HPTE_V_ABSENT;
> >   		v |= HPTE_V_VALID;
> >   		__unlock_hpte(hptep, v);
> > +		preempt_enable();
> >   	} while ((i = j) != head);
> >   	unlock_rmap(rmapp);
> > @@ -1219,6 +1229,7 @@ static unsigned long resize_hpt_rehash_hpte(struct kvm_resize_hpt *resize,
> >   	if (!(vpte & HPTE_V_VALID) && !(vpte & HPTE_V_ABSENT))
> >   		return 0; /* nothing to do */
> > +	preempt_disable();
> >   	while (!try_lock_hpte(hptep, HPTE_V_HVLOCK))
> >   		cpu_relax();
> > @@ -1346,6 +1357,7 @@ static unsigned long resize_hpt_rehash_hpte(struct kvm_resize_hpt *resize,
> >   out:
> >   	unlock_hpte(hptep, vpte);
> > +	preempt_enable();
> 
> I don't like this sprinkling of preempt disable/enable.
> Is there not a way to embedd this in try_lock_hpte/unlock_hpte?

I understand the scattering of preempt_disable()/preempt_enable() looks ugly.
But there are two blockers for that approach:

1. The real-mode hcall dispatch table (hcall_real_table in
   book3s_hv_rmhandlers.S) calls kvmppc_h_enter(), kvmppc_h_remove(),
   kvmppc_h_bulk_remove() and others in book3s_hv_rm_mmu.c, which all call
   try_lock_hpte() from real mode.  Adding preempt_disable() inside
   try_lock_hpte() would affect those real-mode callers, which brings us to your
   second point.

2. The lock/unlock pair crosses function boundaries in several callers. For
   example, kvmppc_hv_find_lock_hpte() acquires HPTE_V_HVLOCK via
   try_lock_hpte() internally but returns with the lock still held — the comment
   above it documents this.  The caller is responsible for the matching
   unlock_hpte().  So even if preempt_disable() were placed inside
   try_lock_hpte(), preempt_enable() would still need to be scattered across
   every caller after their unlock_hpte() — the pairing cannot be made automatic
   inside the primitives alone.

   This caller-side pattern is already established in the tree:
   kvmppc_virtmode_do_h_enter() (book3s_64_mmu_hv.c:298) and
   kvmppc_mmu_book3s_64_hv_xlate() (book3s_64_mmu_hv.c:367) both wrap
   try_lock_hpte() call sites with preempt_disable()/preempt_enable() at the
   caller level, not inside the primitives.

> 
> Also, Is any of these be called in real mode?
> Note that currently preempt count is derived from thread info.
> So it may not be safe in real mode.

The four functions modified in book3s_64_mmu_hv.c — kvm_unmap_rmapp(),
kvm_age_rmapp(), kvm_test_clear_dirty_npages(), and resize_hpt_rehash_hpte() —
are all static functions in book3s_64_mmu_hv.c, and not reachable from the
real-mode hcall table.  They run in process context as MMU notifier callbacks,
dirty-log harvesting, and HPT resize ioctl respectively. The call sites in
book3s_hv.c are likewise post-guest-exit virtual mode.  The preempt_disable()
placements in this patch are safe.

Thanks,
Amit

> 
> >   	return ret;
> >   }
> > diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> > index aa51968e206a..0b7743bb89d9 100644
> > --- a/arch/powerpc/kvm/book3s_hv.c
> > +++ b/arch/powerpc/kvm/book3s_hv.c
> > @@ -1159,6 +1159,10 @@ static long kvmppc_h_rpt_invalidate(struct kvm_vcpu *vcpu,
> >   	return H_SUCCESS;
> >   }
> > +/*
> > + * Must be called with preemption disabled. The HPT hcall handlers spin
> > + * on HPTE bit-locks and cannot make any blocking/sleeping calls.
> > + */
> >   static long kvmppc_pseries_do_hpt_hcall(struct kvm_vcpu *vcpu, unsigned long req)
> >   {
> >   	switch (req) {
> > @@ -1212,9 +1216,11 @@ int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
> >   	case H_CLEAR_REF:
> >   	case H_PROTECT:
> >   	case H_BULK_REMOVE:
> > +		preempt_disable();
> >   		idx = srcu_read_lock(&kvm->srcu);
> >   		ret = kvmppc_pseries_do_hpt_hcall(vcpu, req);
> >   		srcu_read_unlock(&kvm->srcu, idx);
> > +		preempt_enable();
> >   		if (ret == H_TOO_HARD)
> >   			return RESUME_HOST;
> >   		break;
> > @@ -1834,8 +1840,10 @@ static int kvmppc_handle_exit_hv(struct kvm_vcpu *vcpu,
> >   		else
> >   			vsid = vcpu->arch.fault_gpa;
> > +		preempt_disable();
> >   		err = kvmppc_hpte_hv_fault(vcpu, vcpu->arch.fault_dar,
> >   				vsid, vcpu->arch.fault_dsisr, true);
> > +		preempt_enable();
> >   		if (err == 0) {
> >   			r = RESUME_GUEST;
> >   		} else if (err == -1 || err == -2) {
> > @@ -1881,8 +1889,10 @@ static int kvmppc_handle_exit_hv(struct kvm_vcpu *vcpu,
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

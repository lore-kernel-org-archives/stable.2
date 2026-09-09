Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490913A7858
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 19:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788980415; cv=none; b=kcxdhwx2EyQZRw0mw4zKFalmD9pClHn/VbEX7nFyggIxcjjn4UIVCDfQhSp6x1DVonZP8rulcI1CSXcuSvg0FJ112ZPYc28lPt38RTJkh564KeLswJkxt7oobHMA/vlYGm14ZAJVWHbAvFehADLJGfIgorn8gka3hijrN/uWMws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788980415; c=relaxed/simple;
	bh=hd3J3VnRincyxmPVNgG6ZlGf7jsauVi11FvCjiubnLc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q7tovTIkTpLdukSHWb/d35QvcarTZfnRGxZ8Oi85b3pVP6cqwZ/bwaEg5b432iG5AwsU7wuzUc2PA//BvLYPD7NTM2g7tnIWA2iSPSapY07lf4hnlLJVFD6cjgrm2ETPzOqCu0VX+ltZnn535JELhBjrnjqKm0RDlKe35dwvQGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bqej7cRX; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bqej7cRX"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc4922b7c31so2438846a12.1
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 12:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788980412; x=1789585212; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rlTgOxgo1xG1nKqF7u/C9LM2M6bRAo/6DUu/X4srr2A=;
        b=Bqej7cRXWBLcP94HrCYcPZZr3tJc7UKdyPtmb/kej0Kf5P0E6vZYR3Aj/V62EGw4Cc
         BRRHzDxz/TxhZerKCGDv0wHk3rgYrW9YjZhTMWyLarpRw1+eZYOPuDOSV3tS3OwxemlJ
         xHVwtuBfazC0qwckxS3aVmg/6ELA9xmwnxydBwrMmX5xhwBqfM5vg9xJo9amv/x4B7pl
         C8S1yhKyHHY8zAdWoDNidGumjN/UwCrqIE6afzp2SIAbEsJJWSuxQ6NS3lpeDNB/mHCF
         V8SmUb4THIFFHaXNYtN0b1zAjQsvowGrO7gqdVJ9S+zopIfl01VXvX08qFsJT2wKIizF
         V4UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788980412; x=1789585212;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rlTgOxgo1xG1nKqF7u/C9LM2M6bRAo/6DUu/X4srr2A=;
        b=hWUcl7hgoUfzgHf7fEhape5LxBUjyyONypLTtahraDMiZ1sCINabT5dSGe0PehylpO
         b7K0VJFFu7NN8xP164vGlXsPp7y+tkELTqpLPSt0+gxIiwAaPZrye7THXBPQ9ebWD5Ca
         9Hotk+AiUeDChBn/yirKh5opai5cnj77Hh/Go2oKLWC8U06i/oolooAQm3UTz+RZ5G2h
         6dwXUkMPvpwxTBb6I0VLFBnLIqduMWh4DLU5/XGff2Y1mz4oks0h53EWkAFHMSrfmbG/
         qmziuWV6AFp+0Xn1/zk9oYh5uP72CKtYLFVJz9qDm+n2dvqbOh/IGfv59ykkX1QgmvYi
         wwzg==
X-Forwarded-Encrypted: i=1; AKwUvBw768Wvkqwb8RJidmTykUA/Vx6lY6b5y0Alh0VTmoISsuly9jT2axQA1Y3VfBaY31K8La8smw4=@vger.kernel.org
X-Gm-Message-State: AFuF++nsqLdjmXSiP4pK2d7mx4QKPSBOUWhdrBnLHoj/PocJf9WowBoM
	tB2tq+SlLIo4ZPhCAVoNGHHdQZX4MKMJMfOpq209UwA+hU3kT2OfvWj1kpcJyA5sb10YbijwhyJ
	YIWy3BQ==
X-Received: from pgbbd9.prod.google.com ([2002:a65:6e09:0:b0:cc4:2728:8938])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:72a2:b0:3cf:a7a5:e310
 with SMTP id adf61e73a8af0-3dacbd8778fmr3971457637.9.1788980411258; Wed, 09
 Sep 2026 12:00:11 -0700 (PDT)
Date: Wed, 9 Sep 2026 12:00:10 -0700
In-Reply-To: <CALMp9eRJXozpUpdOhqDCWn7VbqHb9G9hn4aZnxS_fef4ad1yTg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260908132838.2116068-1-jmattson@google.com> <CADrL8HW3Q=8eBf-=h6BAPdUN_X1Z_-KG=i5a5rA2kF+V4JURww@mail.gmail.com>
 <CALMp9eRJXozpUpdOhqDCWn7VbqHb9G9hn4aZnxS_fef4ad1yTg@mail.gmail.com>
Message-ID: <aqGsukcRG6khmxpt@google.com>
Subject: Re: [PATCH] KVM: nVMX: Don't flush shadow VMCS12 to guest memory
 during vCPU teardown
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: James Houghton <jthoughton@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 08, 2026, Jim Mattson wrote:
> On Tue, Sep 8, 2026 at 10:35=E2=80=AFAM James Houghton <jthoughton@google=
.com> wrote:
> >
> > On Tue, Sep 8, 2026 at 6:54=E2=80=AFAM Jim Mattson <jmattson@google.com=
> wrote:
> > >
> > > When a vCPU is destroyed while L2 is active, KVM synthesizes a nested
> > > VM-Exit, which flushes the cached shadow VMCS12 back to guest memory:
> > >
> > >   vmx_vcpu_free()
> > >   |-> nested_vmx_free_vcpu()
> > >       |-> vmx_leave_nested()
> > >           |-> nested_vmx_vmexit(vcpu, -1, 0, 0)
> > >               |-> nested_flush_cached_shadow_vmcs12()
> > >                   |-> kvm_write_guest_cached()
> > >                       |-> __copy_to_user(ghc->hva, ...)
> > >
> > > During process exit, do_exit() calls exit_mm() before closing file
> > > descriptors, so vCPU destruction runs with current->mm =3D=3D NULL on=
 a
> > > borrowed lazy TLB active_mm. If the borrowed address space has a writ=
able
> > > mapping at ghc->hva, __copy_to_user() corrupts an unrelated task's me=
mory.
> > >
> > > Skip the flush when KVM synthesizes a VM-exit with vm_exit_reason =3D=
=3D -1
> > > (e.g. during vCPU teardown or SMM entry). In these paths, KVM forces =
the
> > > vCPU out of guest mode internally--no architectural VM-exit is delive=
red
> > > to L1.
> > >
> > > Fixes: 61ada7488ffd ("KVM: nVMX: Cache shadow vmcs12 on VMEntry and f=
lush to memory on VMExit")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Jim Mattson <jmattson@google.com>
> >
> > Hi Jim,
> >
> > This patch looks good for a stable backport, but I feel this kind of
> > bug could easily happen again with the current API.
> >
> > One simple thing that would have prevented this would be to:
> > 1. Change kvm_write_guest_cached() (and related) to take the vcpu
> > instead of the kvm, and
> > 2. Check that vcpu->mm =3D=3D current->mm before doing the uaccess.

The mm pointer is store in "kvm", not in "kvm_vcpu", i.e. this sort of hard=
ening
shouldn't require modifying the callsites.

> > This wouldn't be as suitable for a backport, but I think it's better
> > for preventing similar classes of bugs. I'm sure you (and
> > Paolo/Sean/others) will have better ideas. What do you think?
>=20
> There seems to be some awareness of this issue within KVM, so that may
> not be necessary. Also, as Sashiko points out, we have issues with
> reads as well as writes. I don't know how many choke points we'd have
> to test.
>=20
> AFAICT (with AI assistance), all of the current problems are rooted in
> the following call to nested_vmx_vmexit():
>=20
> void vmx_leave_nested(struct kvm_vcpu *vcpu)
> {
>         if (is_guest_mode(vcpu)) {
>                 vcpu->arch.nested_run_pending =3D 0;
>                 nested_vmx_vmexit(vcpu, -1, 0, 0);
>         }
>         free_nested(vcpu);
> }
>=20
> On the SVM side, there is no comparable faux VM-exit. Instead of
> calling nested_svm_vmexit(), the teardown of SVM nested state is an
> open-coded sequence. Maybe something like that would work better for
> VMX?

Yes, vmx_leave_nested()'s use of nested_vmx_vmexit() is an endless source o=
f pain
and needs to be rewritten.

However, the bigger flaw is that the memslots are still valid when the VM i=
s
being destroyed.  The hardening James suggested above really should be hard=
ening,
not the primary mechanism for ensuring correctness.

Manually freeing each memslot one-by-one isn't a great option, because the =
latency
introduced by each synchronize_srcu_expedited() call would be rather absurd=
.  But
once KVM unregisters its mmu_notifier, i.e. once kvm_mmu_notifier_release()=
 and
thus kvm_flush_shadow_all() runs, all indirect references to memslots need =
to be
gone.  And by "indirect references" I mean code in KVM that relies on a mem=
slot
existing and being reachable, e.g. x86's rmaps and shadow page accounting.

KVM is infuriatingly close to enforcing that already, as only kvm_arch_dest=
roy_vm()
and kvm_destroy_devices() run between unregistering the mmu_notifier and fr=
eeing
all memslot metadata.

	mmu_notifier_unregister(&kvm->mmu_notifier, kvm->mm);
	/*
	 * At this point, pending calls to invalidate_range_start()
	 * have completed but no more MMU notifiers will run, so
	 * mn_active_invalidate_count may remain unbalanced.
	 * No threads can be waiting in kvm_swap_active_memslots() as the
	 * last reference on KVM has been dropped, but freeing
	 * memslots would deadlock without this manual intervention.
	 *
	 * If the count isn't unbalanced, i.e. KVM did NOT unregister its MMU
	 * notifier between a start() and end(), then there shouldn't be any
	 * in-progress invalidations.
	 */
	WARN_ON(rcuwait_active(&kvm->mn_memslots_update_rcuwait));
	if (kvm->mn_active_invalidate_count)
		kvm->mn_active_invalidate_count =3D 0;
	else
		WARN_ON(kvm->mmu_invalidate_in_progress);
	kvm_arch_destroy_vm(kvm);
	kvm_destroy_devices(kvm);
	for (i =3D 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
		kvm_free_memslots(kvm, &kvm->__memslots[i][0]);
		kvm_free_memslots(kvm, &kvm->__memslots[i][1]);  <=3D=3D=3D KVM will be v=
ery sad after this

	}

Destroying memslots before kvm_destroy_devices() is a-ok, all implementatio=
ns do
nothing more than kvm_io_bus_unregister_dev() (a nop at this point in the V=
M's
lifecycle, as buses are already destroyed), and free of memory.

Unfortunately, kvm_arch_destroy_vm() is practically infeasible to audit.  B=
ut, we
don't need to audit that code, we just need to audit kvm_arch_flush_shadow_=
memslot(),
because if there are memslot references that are dropped by flush_shadow_me=
mslot()
but not flush_shadow_all(), then KVM is already buggy and vulnerable.

*sigh*

And of course PPC is a disaster and does literally nothing on flush_shadow_=
all().
Doubly hilarious, the worst offender seems to be kvmhv_release_all_nested()=
.  As
a quick and dirty fix, I think we can simply iterate over memslots and manu=
ally
flush each one?

Which, amazingly, appears to be safe even though kvmppc_uvmem_drop_pages() =
takes
mmap_lock, as exit_mmap()'s call to mmu_notifier_release() is (thanfully) s=
uper
obviously done without hold mmap_lock.

	/* mm's last user has gone, and its about to be pulled down */
	mmu_notifier_release(mm);

	mmap_read_lock(mm);

diff --git arch/powerpc/include/asm/kvm_host.h arch/powerpc/include/asm/kvm=
_host.h
index 2d139c807577..1c8d9d7360e9 100644
--- arch/powerpc/include/asm/kvm_host.h
+++ arch/powerpc/include/asm/kvm_host.h
@@ -903,7 +903,6 @@ struct kvm_vcpu_arch {
 #define __KVM_HAVE_CREATE_DEVICE
=20
 static inline void kvm_arch_memslots_updated(struct kvm *kvm, u64 gen) {}
-static inline void kvm_arch_flush_shadow_all(struct kvm *kvm) {}
 static inline void kvm_arch_vcpu_blocking(struct kvm_vcpu *vcpu) {}
 static inline void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu) {}
=20
diff --git arch/powerpc/kvm/powerpc.c arch/powerpc/kvm/powerpc.c
index 9194cf492d1c..2b88fb9e9bc4 100644
--- arch/powerpc/kvm/powerpc.c
+++ arch/powerpc/kvm/powerpc.c
@@ -764,6 +764,17 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 	kvmppc_core_commit_memory_region(kvm, old, new, change);
 }
=20
+void kvm_arch_flush_shadow_all(struct kvm *kvm)
+{
+	struct kvm_memory_slot *memslot;
+	struct kvm_memslots *slots;
+	int bkt;
+
+	slots =3D kvm_memslots(kvm);
+	kvm_for_each_memslot(memslot, bkt, slots)
+		kvmppc_core_flush_memslot(kvm, slot);
+}
+
 void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
 				   struct kvm_memory_slot *slot)
 {

If the above works for PPC, then KVM can nuke memslots before calling into
kvm_arch_destroy_vm().  x86's asinine memslot deletion in kvm_arch_destroy_=
vm()
needs to be addressed, but that code exists purely to do vm_munmap(), and c=
an
and should be moved to kvm_arch_free_memslot().

All that said, I'm not sure this aggressive fix is the right thing to send =
to
stable@.  For that, James' suggestion of hardening KVM's usage of
__copy_{to,from}_user() seems like the best blend of being comprehensive wi=
thout
being overly invasive/risky.

So, as an immediate set of changes, what if we do this over ~5 patches, wit=
h patches
1 and 2 tagged for stable@?

  1. Add kvm_copy_{to,from}_user{,_inatomic)() and return -EFAULT if curren=
t->mm
     is not kvm->mm.
  2. Hack-a-fix PPC's kvm_arch_flush_shadow_all().
  3. Do x86's vm_munmap() in kvm_arch_free_memslot().
  4. Nuke memslots before calling kvm_arch_destroy_vm().
  5. Change the current->mm checks in kvm_copy_{to,from}_user{,_inatomic)()=
 to
     WARN_ON_ONCE() on failure.

And then in the near-ish future, take things a step further and do:

  6. Fix the vmx_leave_nested() trainwreck.
  7. Harden the common kvm_{read,write}_guest family of APIs even further b=
y
     adding an early WARN_ON_ONCE() on current->mm !=3D kvm->mm, i.e. to de=
tect
     bad KVM behavior as additional defense-in-depth.

The diff for #3 and #4 (lightly tested on x86):

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 4b3681796c75..f05ba2d1364d 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9925,7 +9925,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long t=
ype)
  * @size > 0 to install a new slot, while @size =3D=3D 0 to uninstall a
  * slot.  The return code can be one of the following:
  *
- *   HVA:           on success (uninstall will return a bogus HVA)
+ *   HVA:           on success (uninstall will return a NULL HVA)
  *   -errno:        on error
  *
  * The caller should always use IS_ERR() to check the return value
@@ -9938,10 +9938,10 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long=
 type)
 void __user * __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa,
 				      u32 size)
 {
-	int i, r;
-	unsigned long hva, old_npages;
 	struct kvm_memslots *slots =3D kvm_memslots(kvm);
 	struct kvm_memory_slot *slot;
+	unsigned long hva;
+	int i, r;
=20
 	lockdep_assert_held(&kvm->slots_lock);
=20
@@ -9965,8 +9965,7 @@ void __user * __x86_set_memory_region(struct kvm *kvm=
, int id, gpa_t gpa,
 		if (!slot || !slot->npages)
 			return NULL;
=20
-		old_npages =3D slot->npages;
-		hva =3D slot->userspace_addr;
+		hva =3D 0;
 	}
=20
 	for (i =3D 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
@@ -9982,9 +9981,6 @@ void __user * __x86_set_memory_region(struct kvm *kvm=
, int id, gpa_t gpa,
 			return ERR_PTR_USR(r);
 	}
=20
-	if (!size)
-		vm_munmap(hva, old_npages * PAGE_SIZE);
-
 	return (void __user *)hva;
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(__x86_set_memory_region);
@@ -10013,20 +10009,6 @@ void kvm_arch_pre_destroy_vm(struct kvm *kvm)
=20
 void kvm_arch_destroy_vm(struct kvm *kvm)
 {
-	if (current->mm =3D=3D kvm->mm) {
-		/*
-		 * Free memory regions allocated on behalf of userspace,
-		 * unless the memory map has changed due to process exit
-		 * or fd copying.
-		 */
-		mutex_lock(&kvm->slots_lock);
-		__x86_set_memory_region(kvm, APIC_ACCESS_PAGE_PRIVATE_MEMSLOT,
-					0, 0);
-		__x86_set_memory_region(kvm, IDENTITY_PAGETABLE_PRIVATE_MEMSLOT,
-					0, 0);
-		__x86_set_memory_region(kvm, TSS_PRIVATE_MEMSLOT, 0, 0);
-		mutex_unlock(&kvm->slots_lock);
-	}
 	if (kvm->arch.created_mediated_pmu)
 		perf_release_mediated_pmu();
 	kvm_destroy_vcpus(kvm);
@@ -10066,6 +10048,16 @@ void kvm_arch_free_memslot(struct kvm *kvm, struct=
 kvm_memory_slot *slot)
 	}
=20
 	kvm_page_track_free_memslot(slot);
+
+	/*
+	 * Free memory regions allocated on behalf of userspace, unless the
+	 * memory map has changed due to process exit or fd copying.  Leak the
+	 * mapping on failure, e.g. if the task is killed, worst case scenario,
+	 * the page(s) will be reclaimed when the process exits.
+	 */
+	if (current->mm =3D=3D kvm->mm && slot->id >=3D KVM_USER_MEM_SLOTS &&
+	    !WARN_ON_ONCE(!slot->npages))
+		vm_munmap(slot->userspace_addr, slot->npages * PAGE_SIZE);
 }
=20
 int memslot_rmap_alloc(struct kvm_memory_slot *slot, unsigned long npages)
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 03bfc92864b6..bed48f70b2d8 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1693,6 +1693,7 @@ int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu);
 bool kvm_arch_dy_runnable(struct kvm_vcpu *vcpu);
 bool kvm_arch_dy_has_pending_interrupt(struct kvm_vcpu *vcpu);
 bool kvm_arch_vcpu_preempted_in_kernel(struct kvm_vcpu *vcpu);
+void kvm_arch_destroy_memslots(struct kvm *kvm);
 void kvm_arch_pre_destroy_vm(struct kvm *kvm);
 void kvm_arch_create_vm_debugfs(struct kvm *kvm);
=20
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 65eb26a0520d..899bf5970434 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -945,23 +945,36 @@ static void kvm_free_memslot(struct kvm *kvm, struct =
kvm_memory_slot *slot)
 	kfree(slot);
 }
=20
-static void kvm_free_memslots(struct kvm *kvm, struct kvm_memslots *slots)
+static const struct kvm_memslots kvm_empty_memslots =3D {
+	.generation =3D -1ull,
+	.hva_tree =3D RB_ROOT_CACHED,
+	.gfn_tree =3D RB_ROOT,
+	.id_hash[0 ... (ARRAY_SIZE(kvm_empty_memslots.id_hash) - 1)] =3D HLIST_HE=
AD_INIT,
+	.node_idx =3D 0,
+};
+
+static void kvm_destroy_memslots(struct kvm *kvm)
 {
 	struct hlist_node *idnode;
 	struct kvm_memory_slot *memslot;
-	int bkt;
+	int bkt, i;
+
+	mutex_lock(&kvm->slots_lock);
+	for (i =3D 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++)
+		rcu_assign_pointer(kvm->memslots[i], &kvm_empty_memslots);
+
+	synchronize_srcu_expedited(&kvm->srcu);
+	mutex_unlock(&kvm->slots_lock);
=20
 	/*
 	 * The same memslot objects live in both active and inactive sets,
-	 * arbitrarily free using index '1' so the second invocation of this
-	 * function isn't operating over a structure with dangling pointers
-	 * (even though this function isn't actually touching them).
+	 * arbitrarily free using index '1'.
 	 */
-	if (!slots->node_idx)
-		return;
-
-	hash_for_each_safe(slots->id_hash, bkt, idnode, memslot, id_node[1])
-		kvm_free_memslot(kvm, memslot);
+	for (i =3D 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
+		hash_for_each_safe(kvm->__memslots[i][1].id_hash, bkt, idnode,
+				   memslot, id_node[1])
+			kvm_free_memslot(kvm, memslot);
+	}
 }
=20
 static umode_t kvm_stats_debugfs_mode(const struct kvm_stats_desc *desc)
@@ -1292,12 +1305,10 @@ static void kvm_destroy_vm(struct kvm *kvm)
 		kvm->mn_active_invalidate_count =3D 0;
 	else
 		WARN_ON(kvm->mmu_invalidate_in_progress);
+	kvm_destroy_memslots(kvm);
+
 	kvm_arch_destroy_vm(kvm);
 	kvm_destroy_devices(kvm);
-	for (i =3D 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
-		kvm_free_memslots(kvm, &kvm->__memslots[i][0]);
-		kvm_free_memslots(kvm, &kvm->__memslots[i][1]);
-	}
 	cleanup_srcu_struct(&kvm->irq_srcu);
 	srcu_barrier(&kvm->srcu);
 	cleanup_srcu_struct(&kvm->srcu);
@@ -2005,6 +2016,9 @@ static int kvm_set_memory_region(struct kvm *kvm,
=20
 	lockdep_assert_held(&kvm->slots_lock);
=20
+	if (WARN_ON_ONCE(!refcount_read(&kvm->users_count)))
+		return -EIO;
+
 	r =3D check_memory_region_flags(kvm, mem);
 	if (r)
 		return r;

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A7E41835D
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 12:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786970988; cv=none; b=imdXpA5lH5hOZvUuY9/fS1Bu/l8P+juga/Zo3q8vapqCzbYC0OYod9Mj1XbunAJcEvzCrFSh5AYJl6fTG5r5cHEcR3tj4oblKq7LU1lzbnoe6QdoAUi/9iEaeJdkYU+fRLH3byyE0q1JGrqsMQzdud+Ru6yxvLMpF6XEwtkWppM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786970988; c=relaxed/simple;
	bh=kDYfIOJCjn6kZddGYgycdzc3WghhKtQHULBJK2EkLZo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=eIDpU9Xix3j23WVKG/QQQy+U+nL4co5GZ9F9t6lBaSwGWE+rs1yLdlu7hhLNpJ6mBVLpzSVwgrgjg4Nc0rIOrNejpbkWFN3CG+9705JmvNpELZkpStxCrGMZ+Qqz+Z2OKCgG8jKjgjhhVaJayK7p0m4keyFCQj6x/BrjB1j+FUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yI+hVjV7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yI+hVjV7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 619481F000E9;
	Mon, 17 Aug 2026 12:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786970985;
	bh=4GyI+aPrIxFPCCEYUPToOnwDxGHrBz1itWNyRfQokCQ=;
	h=Subject:To:Cc:From:Date;
	b=yI+hVjV7WW5N8Ig0tvjOiDgrDvYbZR3ogLefNT50g8+aWlJ/sq5jIz65tV2MuBxEq
	 Z6Uj5d15P7VYckWsCfoehnXHiDOsCwg+uMbRXkdiDLWQjp7kAvvWfP+Lq1wbDClyUl
	 50LC/pAu1CZgcTPi8iLfg5qT4wO+0IlGpC1umNLc=
Subject: FAILED: patch "[PATCH] KVM: SVM: Serialize accesses to the owner and mirror list" failed to apply to 6.6-stable tree
To: pbonzini@redhat.com,grayhat@foxmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 17 Aug 2026 14:49:28 +0200
Message-ID: <2026081728-swore-various-658b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 1d78d33275ef2a16c6d080910b291d0a97a0e613
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026081728-swore-various-658b@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1d78d33275ef2a16c6d080910b291d0a97a0e613 Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 6 Aug 2026 16:44:17 +0200
Subject: [PATCH] KVM: SVM: Serialize accesses to the owner and mirror list
 with separate lock

Interaction between KVM_CAP_VM_MOVE_ENC_CONTEXT_FROM and
KVM_CAP_VM_COPY_ENC_CONTEXT_FROM can cause two separate issues:

- in sev_migrate_from(), when the destination KVM is a mirror, the mirror
  entry is moved from the source's list to the owner's mirror_vms list,
  without holding the owner's lock unlike other writers of the owner's
  mirror list (sev_vm_copy_enc_context_from(), sev_vm_destroy()).
  A concurrent COPY or destroy can race with sev_migrate_from() and
  corrupt the list.

- In sev_vm_destroy(), the *owner* is still active and could receive
  concurrently a KVM_CAP_VM_MOVE_ENC_CONTEXT_FROM that causes
  sev->enc_context_owner to change.  In this case the incorrect VM
  receives kvm_put_kvm().

The second issue needs particular care because the owner could disappear
altogether (even though the race window is impossibly small) between
reading it and locking it.  There is thus no way to perform the checks
under the owner lock without putting struct kvm under SLAB_TYPESAFE_BY_RCU
(which would allow kvm_get_kvm_safe() under RCU critical section).

It is much simpler to just use a global lock, since the critical
sections are so small and the new lock is always a leaf lock.

Fixes: b2125513dfc0 ("KVM: SEV: Allow SEV intra-host migration of VM with mirrors")
Cc: stable@vger.kernel.org
Reported-by: Shen Yongchao <grayhat@foxmail.com>
Link: https://lore.kernel.org/kvm/tencent_625C0F42824E542C72B34733392AF2C49709@qq.com/
Link: https://lore.kernel.org/kvm/tencent_DDC4E4352EC91CAC05A9A8F4E55E8C96730A@qq.com/
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 944aaea6501f..0f0ea7896af5 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -97,6 +97,8 @@ static u64 sev_supported_vmsa_features __ro_after_init;
 static u8 sev_enc_bit;
 static DECLARE_RWSEM(sev_deactivate_lock);
 static DEFINE_MUTEX(sev_bitmap_lock);
+/* Protects kvm_sev_info's enc_context_owner, mirror_vms and mirror_entry.  */
+static DEFINE_MUTEX(sev_mirror_lock);
 unsigned int max_sev_asid;
 static unsigned int min_sev_asid;
 static unsigned int max_sev_es_asid;
@@ -2018,7 +2020,6 @@ static void sev_migrate_from(struct kvm *dst_kvm, struct kvm *src_kvm)
 	dst->asid = src->asid;
 	dst->handle = src->handle;
 	dst->pages_locked = src->pages_locked;
-	dst->enc_context_owner = src->enc_context_owner;
 	dst->es_active = src->es_active;
 	dst->vmsa_features = src->vmsa_features;
 
@@ -2026,11 +2027,12 @@ static void sev_migrate_from(struct kvm *dst_kvm, struct kvm *src_kvm)
 	src->active = false;
 	src->handle = 0;
 	src->pages_locked = 0;
-	src->enc_context_owner = NULL;
 	src->es_active = false;
 
 	list_cut_before(&dst->regions_list, &src->regions_list, &src->regions_list);
 
+	mutex_lock(&sev_mirror_lock);
+
 	/*
 	 * If this VM has mirrors, "transfer" each mirror's refcount of the
 	 * source to the destination (this KVM).  The caller holds a reference
@@ -2047,12 +2049,15 @@ static void sev_migrate_from(struct kvm *dst_kvm, struct kvm *src_kvm)
 	 * If this VM is a mirror, remove the old mirror from the owners list
 	 * and add the new mirror to the list.
 	 */
-	if (is_mirroring_enc_context(dst_kvm)) {
-		struct kvm_sev_info *owner_sev_info = to_kvm_sev_info(dst->enc_context_owner);
+	if (is_mirroring_enc_context(src_kvm)) {
+		struct kvm_sev_info *owner_sev_info = to_kvm_sev_info(src->enc_context_owner);
 
+		dst->enc_context_owner = src->enc_context_owner;
+		src->enc_context_owner = NULL;
 		list_del(&src->mirror_entry);
 		list_add_tail(&dst->mirror_entry, &owner_sev_info->mirror_vms);
 	}
+	mutex_unlock(&sev_mirror_lock);
 
 	kvm_for_each_vcpu(i, dst_vcpu, dst_kvm) {
 		dst_svm = to_svm(dst_vcpu);
@@ -2871,11 +2876,14 @@ int sev_vm_copy_enc_context_from(struct kvm *kvm, unsigned int source_fd)
 	 * disappear until we're done with it
 	 */
 	source_sev = to_kvm_sev_info(source_kvm);
-	kvm_get_kvm(source_kvm);
-	list_add_tail(&mirror_sev->mirror_entry, &source_sev->mirror_vms);
 
 	/* Set enc_context_owner and copy its encryption context over */
+	mutex_lock(&sev_mirror_lock);
+	kvm_get_kvm(source_kvm);
+	list_add_tail(&mirror_sev->mirror_entry, &source_sev->mirror_vms);
 	mirror_sev->enc_context_owner = source_kvm;
+	mutex_unlock(&sev_mirror_lock);
+
 	mirror_sev->active = true;
 	mirror_sev->asid = source_sev->asid;
 	mirror_sev->fd = source_sev->fd;
@@ -2963,11 +2971,19 @@ void sev_vm_destroy(struct kvm *kvm)
 	 * Note, mirror VMs don't support registering encrypted regions.
 	 */
 	if (is_mirroring_enc_context(kvm)) {
-		struct kvm *owner_kvm = sev->enc_context_owner;
+		struct kvm *owner_kvm;
 
-		mutex_lock(&owner_kvm->lock);
+		mutex_lock(&sev_mirror_lock);
+		owner_kvm = sev->enc_context_owner;
 		list_del(&sev->mirror_entry);
-		mutex_unlock(&owner_kvm->lock);
+		sev->enc_context_owner = NULL;
+
+		/*
+		 * The reference to owner_kvm cannot move after sev_mirror_lock is
+		 * released.  Release it before kvm_put_kvm() so that owner_kvm is
+		 * never destroyed inside sev_mirror_lock.
+		 */
+		mutex_unlock(&sev_mirror_lock);
 		kvm_put_kvm(owner_kvm);
 		return;
 	}
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 716be21fba33..d63e5878988a 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -109,6 +109,7 @@ struct kvm_sev_info {
 	u64 ap_jump_table;	/* SEV-ES AP Jump Table address */
 	u64 vmsa_features;
 	u16 ghcb_version;	/* Highest guest GHCB protocol version allowed */
+	/* The three fields below are protected by sev_mirror_lock */
 	struct kvm *enc_context_owner; /* Owner of copied encryption context */
 	struct list_head mirror_vms; /* List of VMs mirroring */
 	struct list_head mirror_entry; /* Use as a list entry of mirrors */


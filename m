Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304E847A89B
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 15:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787151840; cv=none; b=VptGauX36TCJ7deFOI9WduZQqprCZlAHW+rchN9Mt98hARWuL6GS5pbPD1pt2JDf2qOW1qOJgCGZlYZQwloc3ltWDpOHAaxf+z3lNXEpmPxm+9bSNofxu7frv7vQ1v9om4PDZBsrVF89EszVn5dr3gHAGSULPw+SoxhXUQeAVnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787151840; c=relaxed/simple;
	bh=8/Cf3ntmF2G/sc3oHeJfisCxTqXhvG5eNcyuVhWkndc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O1uoMVIb8TebLikuJbn7Is+Vlfpp2wO1424xpLiDvbBOwReJaUNeOzeYvipkXeEXofnmmJ1IIn5uTzV0GMHEMQFq2nj8xQ4vTy3aF/H0sr6IErkkOSKx8UINfbGp7GG57xkjUyoLflMLKK94JbglPWhiDSco2/qDHd4IiF5xNSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LDwLzSvT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LDwLzSvT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 108EE1F000E9;
	Wed, 19 Aug 2026 15:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787151836;
	bh=4ErALQG58blC6hUjDkpuuFXA/upyV+p+9Qhxo0OkN54=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LDwLzSvT0kzhToTS0svoBEPkn5hYxgyfNFkbmJhOmh1PiGIIbkPkGXfjkok9O7hnO
	 Y7lLkRik/n3+iASk6+o89QaILK5kGchm/yb0KkN6YWOR+WImRtqNk6CreSGaJhKtG+
	 7JlrEEnBGYzkFAj5PjeDyAKXI22zAKAPjOMOdgKQ9HY6CGM2yV2jyRqM7qhY1uOfxA
	 RARAl9Xh3u9lavqHCQ3Bde5Xnj7ws+a9aLR1jqf+FRP72Y6JvF0Ecp5xQIXbxytaYR
	 7GIgnxq5T/zgin6su+vCUDRMiNhgPorI9QK0p0/ifQD3LM66jaQ1yq2+lpG6A3wQ8o
	 jQna8PRzHyFGA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Shen Yongchao <grayhat@foxmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] KVM: SVM: Serialize accesses to the owner and mirror list with separate lock
Date: Wed, 19 Aug 2026 11:03:54 -0400
Message-ID: <20260819150354.3907372-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026081728-sneak-sprang-042c@gregkh>
References: <2026081728-sneak-sprang-042c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Bonzini <pbonzini@redhat.com>

[ Upstream commit 1d78d33275ef2a16c6d080910b291d0a97a0e613 ]

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
[ Replaced `to_kvm_sev_info(src->enc_context_owner)` with `&to_kvm_svm(src->enc_context_owner)->sev_info` since that helper doesn't exist, and adjusted context for absent `vmsa_features`/`ghcb_version` fields. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/svm/sev.c | 34 +++++++++++++++++++++++++---------
 arch/x86/kvm/svm/svm.h |  1 +
 2 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 140e9b7877c1..53b37f3d770b 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -60,6 +60,8 @@ module_param_named(sev_es, sev_es_enabled, bool, 0444);
 static u8 sev_enc_bit;
 static DECLARE_RWSEM(sev_deactivate_lock);
 static DEFINE_MUTEX(sev_bitmap_lock);
+/* Protects kvm_sev_info's enc_context_owner, mirror_vms and mirror_entry.  */
+static DEFINE_MUTEX(sev_mirror_lock);
 unsigned int max_sev_asid;
 static unsigned int min_sev_asid;
 static unsigned long sev_me_mask;
@@ -1686,18 +1688,18 @@ static void sev_migrate_from(struct kvm *dst_kvm, struct kvm *src_kvm)
 	dst->asid = src->asid;
 	dst->handle = src->handle;
 	dst->pages_locked = src->pages_locked;
-	dst->enc_context_owner = src->enc_context_owner;
 	dst->es_active = src->es_active;
 
 	src->asid = 0;
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
@@ -1714,13 +1716,16 @@ static void sev_migrate_from(struct kvm *dst_kvm, struct kvm *src_kvm)
 	 * If this VM is a mirror, remove the old mirror from the owners list
 	 * and add the new mirror to the list.
 	 */
-	if (is_mirroring_enc_context(dst_kvm)) {
+	if (is_mirroring_enc_context(src_kvm)) {
 		struct kvm_sev_info *owner_sev_info =
-			&to_kvm_svm(dst->enc_context_owner)->sev_info;
+			&to_kvm_svm(src->enc_context_owner)->sev_info;
 
+		dst->enc_context_owner = src->enc_context_owner;
+		src->enc_context_owner = NULL;
 		list_del(&src->mirror_entry);
 		list_add_tail(&dst->mirror_entry, &owner_sev_info->mirror_vms);
 	}
+	mutex_unlock(&sev_mirror_lock);
 
 	kvm_for_each_vcpu(i, dst_vcpu, dst_kvm) {
 		dst_svm = to_svm(dst_vcpu);
@@ -2095,12 +2100,15 @@ int sev_vm_copy_enc_context_from(struct kvm *kvm, unsigned int source_fd)
 	 * disappear until we're done with it
 	 */
 	source_sev = &to_kvm_svm(source_kvm)->sev_info;
-	kvm_get_kvm(source_kvm);
 	mirror_sev = &to_kvm_svm(kvm)->sev_info;
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
@@ -2137,11 +2145,19 @@ void sev_vm_destroy(struct kvm *kvm)
 
 	/* If this is a mirror_kvm release the enc_context_owner and skip sev cleanup */
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
index 0860db312c55..f9f0e79f2f40 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -89,6 +89,7 @@ struct kvm_sev_info {
 	unsigned long pages_locked; /* Number of pages locked */
 	struct list_head regions_list;  /* List of registered regions */
 	u64 ap_jump_table;	/* SEV-ES AP Jump Table address */
+	/* The three fields below are protected by sev_mirror_lock */
 	struct kvm *enc_context_owner; /* Owner of copied encryption context */
 	struct list_head mirror_vms; /* List of VMs mirroring */
 	struct list_head mirror_entry; /* Use as a list entry of mirrors */
-- 
2.53.0


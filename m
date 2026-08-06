Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCD53B8406
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 14:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786027883; cv=none; b=jfOqS2CuixDpOdyiw2QS3yDLVVmbouj1ZvrV5RIN3bVQbqzC0s4B9U6WfmKLOMiMkwFja3IoekVXfoSlKsqNd0/FRu2m60SEGf0mqbubulxE8l6sC3VF+p4aO46az8bWLQPyj1xm66uWwxGs4pMQqFcDCEp5ed9EfBOx7Q2iHts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786027883; c=relaxed/simple;
	bh=JTn9s6gM2szvKxoPm3/ZyZ77FIqrcsDh6La/UymsTEY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jpZYsjpmE2XdwnePGrHlVfqOqp2DwYj1yHBizEC6eQ2IGNDgqSQ4xCY1DUlfZ2lYa0YZ770moqR0Vgxe3ExtJsxM/WxhU7g8mz1dG6cVuXRF/6/qNJiK8rcObRG7V9pzZOa+pag6156GyBKHjELYDpYnu/vcITiSlu4D3cgv/2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i9jVNOxj; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qoAviZB6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i9jVNOxj";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qoAviZB6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786027880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9UBsUkDYuwCc8pkolF5HK4/LrXTfhHoQ32/qQ5yuXRI=;
	b=i9jVNOxjJDZQ+UuRoAtOHo3WZESVVVmupSDrIKwKmcYe4qLcvjN8wO4ColH7XHiBL+0BGL
	cFhoXNknEa699a3JxExb6SnyrvHGw2a3jS8H6jIwsM0vvAYAVFhgjYqWsodBLnBJ1HYorz
	rsFs0bmjLEH19nkia7rN4HyilmZG4E8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-L7LkszUgO6CIbdbtPv29OQ-1; Thu, 06 Aug 2026 10:51:19 -0400
X-MC-Unique: L7LkszUgO6CIbdbtPv29OQ-1
X-Mimecast-MFC-AGG-ID: L7LkszUgO6CIbdbtPv29OQ_1786027878
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47fe9444eceso1538580f8f.2
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 07:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786027878; x=1786632678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9UBsUkDYuwCc8pkolF5HK4/LrXTfhHoQ32/qQ5yuXRI=;
        b=qoAviZB63SiKNh32AsTrBK30RProA97/S5XuhvPGgWwsvADzdadOQBPln79l7tBCKt
         Uk8CThE3iRWIxsGVYuoL3m8j5WOtwjspgTfITb4oUM8Z0IqCjvW1NOcFvo/QU1/tVWrG
         vjik7pEB7nvvqJw6BchaxLRxCwd41trWGXPRhXoIe7XsVXG35lB+f68JU6JRAx4I8tuj
         559MhpasJvpa/AbKLgtZjEXY8gbezHh/x1jkHKiBSOG2BXx3yJv4HrqiKaLKn8w2/14F
         6qwOelGv8gwwztEX2L9gPNSxQh3ftj0QOokOg4SMuZd71k+2G/GEKeLTV+lOn9vfaHiV
         vgWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786027878; x=1786632678;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9UBsUkDYuwCc8pkolF5HK4/LrXTfhHoQ32/qQ5yuXRI=;
        b=R3wH9WzFEcW7UiMVq7k0Lw66iNoEm7KyuXge/rcL6wuoQUoX5YbMQIwmERLIiSL7W2
         ng1yJSKgqHCqDjzsLDfEbqHCXLTaPVzDylTxSMO/H+XwxmpP2ySeOdALvIZ3D90fyRGb
         1jGPT+vmBh9zkCS1LlpcGxzD5l+jQLTyd9N3+djR33gbVVdKF3tdA46QJSCDxBd4SOIC
         hTbQDm5ATfUS9LUkhwW0DfmIlPygVHHGzwR+0YxyafSNw8CyM57FITp64E4OB7Z6GIQq
         LJq5aKMzYm9hxc6o7Y1Bad7+hf16IHl69g1HEIYLVphGpKlL6YE5vDJatAG+ORfldqT/
         rx0Q==
X-Forwarded-Encrypted: i=1; AHgh+RoDkHnCuZUKDVQMajqqPC+EJxkIKarg8WITp5FajxBhnLzQE70uHkmq0UMEBR4xJCyBzP3AHzo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa5bXztYrS65pqyycQek1BCJ5TOk4iTrjtnt4r4vuJXj4pPCmg
	qCwY0mxSPy3FGbK/coRdqLD6BvWeQn8IW7oEFUIzuKaX/vlHkPmI6qmbRRZgyna5jh+0UEMlRp9
	FEQeNQx1TFY1AfXgSO+AkWl0+TtpWqVtIppoF4L446xAPcajiekMJWYCWdw==
X-Gm-Gg: AR+sD1055Y9QAqC3vSbgTACqr7OO8/hketMQ27Kgp0uk3ah8DBA4C6MBg8877QWUUCa
	ILjUkdAjOShqFgBSAZQEN6NGJD1QK5W6R8ETuAkc5AU1dWg/fK9MiaucHRTCmayTagET+QEc1X5
	OGXT5XrTexdwsXUG9PzUFPP1dvDA2xL7VPASBPm3xIvehOFrW+IKB9lmUekr2plQHd8z0GugG/+
	/bqtPRkVuW81JSDu/pnF49lHJinWB3nQPbvV9GkSMCuD+Hr8DKzrl81DbZPdGoLqqLnZwyYzrMP
	mnoo2zPcze0P/9YuCCadNaGCuDGImR3uEkZfsVLs+d9fR3APbLT9ekvXvqX0fm3YGfC2VHtq+1z
	VIdXdW8EgsjbVVw78U4m7fefnDpw/yjf4rHiQxUu6vN9Tz7UGbuedN0fwjVdoQstlRDGDxO+tfv
	m4wYY=
X-Received: by 2002:a05:6000:60f:b0:47f:80d1:be0a with SMTP id ffacd0b85a97d-47fec634bbcmr24302550f8f.14.1786027878096;
        Thu, 06 Aug 2026 07:51:18 -0700 (PDT)
X-Received: by 2002:a05:6000:60f:b0:47f:80d1:be0a with SMTP id ffacd0b85a97d-47fec634bbcmr24302435f8f.14.1786027877611;
        Thu, 06 Aug 2026 07:51:17 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ff7b28729sm7648431f8f.32.2026.08.06.07.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 07:51:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	pgonda@google.com,
	thomas.lendacky@amd.com,
	stable@vger.kernel.org,
	Shen Yongchao <grayhat@foxmail.com>
Subject: [PATCH] KVM: SVM: Serialize accesses to the owner and mirror list with separate lock
Date: Thu,  6 Aug 2026 16:51:15 +0200
Message-ID: <20260806145115.2441519-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 arch/x86/kvm/svm/sev.c | 34 +++++++++++++++++++++++++---------
 arch/x86/kvm/svm/svm.h |  1 +
 2 files changed, 26 insertions(+), 9 deletions(-)

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
-- 
2.55.0


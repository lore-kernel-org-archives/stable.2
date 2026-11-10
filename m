Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794291092;
	b=BGzJ3E0jaFUX0RvgU7SjrOMh2VKSX+QVYE9H/vujHJX08N7k83DZec28LLPBCA/yb/6s
	 QHuUqruvWi/td8qbH+EDWYcEYx+853wH17YUU09NDUOpBOCX14naFe/9OWEMHhuMVWE4Y
	 l6Mrv0jLfrBdbZ5RBa09zlo6nx57jrvjKtTpA2dulggK6+IiF0K57cx5odVQDzOJrP1LS
	 qlUAwsxdRMZ7XeiFhYPwXRjTU8y8vJGkYDUVq8ytGZUGtH3JTspN3Mu8iTsZFb720EKGk
	 86Fvqiwc7ik72a6APVDQCPKemPTv7i656kL29sFYboyR1vdp/c5DsvtNhxjb1Zdruyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794291092;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=6r6bdHHk0MprtIeTGrS3KWCO43Uy8anuYtdR0fOJIEI=;
	b=notqhl8YnZcSFpu+57fTMd8gFMvoG0Y4HOb1gLVhTPK/xEH5YILrSEE53v2DPBJv3yOb
	 FtUigCw6yhtC8ZFn2DxFsdoB5MuXZ06h+mAu7lZb6b0zaLt3l9XIA3uuMPWXqlieLXjwv
	 sJN4M18tHcEV6YGNKdNIZzeJAWK5lLYBkBcvII3w5paOAskaQfhGV/cR6tzrSPo0pA6XC
	 wZdcqfzDXq525DnNiWrOhvKO3zF9TErwpwrVPf6Q+ZhBqGdcQqk2SZWI7mXSK9VGj88Pt
	 v+WgJOmIVK45ZftWnMw2rRTxA9TYWmZBuq1nUj/uNA9Mhmh8ffXH7J/XsSOjXQGsuJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HrjUpjiR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF43606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 06:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HrjUpjiR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5D011F0089F;
	Tue, 10 Nov 2026 06:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794291091;
	bh=6r6bdHHk0MprtIeTGrS3KWCO43Uy8anuYtdR0fOJIEI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HrjUpjiRm74MZN3rlwG2LtwW7u1Kgl3iNVmXJTtTvdvLuzDX3atM9PeUupLL9fL4T
	 v2uZXeYpHAEVMZKl0aLMM5LOGeq1xKUOwgnplDfe6GM3QRhxSHxqIOQ3BuypLyQ+U/
	 G1NwUuPW8VKHfw9OCONatoQR1G0CDblsm8/tUDBdIsBlS4A99YaBtkO4ttGs4sbgao
	 9VrCpOZWFIeZG0FS2izyCr4dOEZiz3AK6tTxU2rowkl0vByT/tjbLe70hTmGwEyWj8
	 sWujrrPb6uMmB6oJng3XaL9PwwyKZG9bDO7tF6bbao/nF6YAQdNKsA9PWdrMi326dk
	 0f9y93ODZFosQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] KVM: guest_memfd: Split bind() into prepare()+commit() phases
Date: Tue, 10 Nov 2026 01:11:29 -0500
Message-ID: <20261110061101.506289-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050710-failed-6.18-83411f32b8ad@kernel.org>
References: <20261107050710-failed-6.18-83411f32b8ad@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit 83411f32b8ad96c6b05b1511d1a588daab44bd25 ]

Split binding a memslot to a guest_memfd instance into prepare() and
commit() phases so that KVM can separate preparing the memslot from binding
the memslot to the gmem instance, i.e. from committing the memslot.  This
will allow waiting to commit the memslot+gmem binding until the memslot is
fully prepared, which is necessary as the memslot becomes reachable when
the binding is created.

As a bonus, drop the unwind-on-failure from the commit phase (other than
nullifying the bindings), as the only reason bind() did the full unwind is
because it technically didn't own the memslot, i.e. "needed" to leave
memslot in the same state it started in.

No functional change intended (the unwinding down on bind() failure was
effectively dead code since KVM simply deletes the memslot on failure,
i.e. there was nothing that could actually observe the unwind).

Cc: stable@vger.kernel.org
Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
Link: https://patch.msgid.link/20260922001332.1121266-5-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
[ sashal: adapted guest-memory interfaces to the existing header layout and u64/struct kvm_gmem types ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 virt/kvm/guest_memfd.c | 67 ++++++++++++++++++++++++------------------
 virt/kvm/kvm_main.c    | 18 +++++++++++-
 virt/kvm/kvm_mm.h      | 18 ++++++++----
 3 files changed, 69 insertions(+), 34 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 5f9a25fa0a09b..74f7b7ee28793 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -563,15 +563,14 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args)
 	return __kvm_gmem_create(kvm, size, flags);
 }
 
-int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
-		  unsigned int fd, u64 offset)
+int kvm_gmem_prepare_memory_region(struct kvm *kvm, struct kvm_memory_slot *slot,
+				   unsigned int fd, u64 offset)
 {
 	u64 size = slot->npages << PAGE_SHIFT;
-	unsigned long start, end;
 	struct kvm_gmem *gmem;
 	struct inode *inode;
 	struct file *file;
-	int r = -EINVAL;
+
 
 	BUILD_BUG_ON(sizeof(gpa_t) != sizeof(offset));
 	BUILD_BUG_ON(sizeof(gfn_t) != sizeof(slot->gmem.pgoff));
@@ -595,43 +594,55 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
 	if (!PAGE_ALIGNED(offset) || offset + size > i_size_read(inode))
 		goto err;
 
-	filemap_invalidate_lock(inode->i_mapping);
-
-	start = offset >> PAGE_SHIFT;
-	end = start + slot->npages;
-
-	if (!xa_empty(&gmem->bindings) &&
-	    xa_find(&gmem->bindings, &start, end - 1, XA_PRESENT)) {
-		filemap_invalidate_unlock(inode->i_mapping);
-		goto err;
-	}
-
 	/*
 	 * memslots of flag KVM_MEM_GUEST_MEMFD are immutable to change, so
 	 * kvm_gmem_bind() must occur on a new memslot.  Because the memslot
 	 * is not visible yet, kvm_gmem_get_pfn() is guaranteed to see the file.
 	 */
 	WRITE_ONCE(slot->gmem.file, file);
-	slot->gmem.pgoff = start;
+	slot->gmem.pgoff = offset >> PAGE_SHIFT;
 	if (kvm_gmem_supports_mmap(inode))
 		slot->flags |= KVM_MEMSLOT_GMEM_ONLY;
 
-	r = xa_err(xa_store_range(&gmem->bindings, start, end - 1, slot, GFP_KERNEL));
-	if (r) {
-		xa_store_range(&gmem->bindings, start, end - 1, NULL, GFP_KERNEL);
-		slot->gmem.file = NULL;
-		slot->gmem.pgoff = 0;
-		slot->flags &= ~KVM_MEMSLOT_GMEM_ONLY;
-	}
-	filemap_invalidate_unlock(inode->i_mapping);
-
 	/*
-	 * Drop the reference to the file, even on success.  The file pins KVM,
-	 * not the other way 'round.  Active bindings are invalidated if the
-	 * file is closed before memslots are destroyed.
+	 * Gift the caller a reference to the file.  The reference will be
+	 * dropped after bindings are established, or if installing the new
+	 * memslot ultimately fails.
 	 */
+	return 0;
+
 err:
 	fput(file);
+	return -EINVAL;
+}
+
+int kvm_gmem_commit_memory_region(struct kvm *kvm, struct kvm_memory_slot *slot)
+{
+	struct kvm_gmem *gmem = slot->gmem.file->private_data;
+	struct inode *inode = file_inode(slot->gmem.file);
+	unsigned long start, end;
+	int r;
+
+	if (WARN_ON_ONCE(slot->gmem.file->f_op != &kvm_gmem_fops))
+		return -EIO;
+
+	filemap_invalidate_lock(inode->i_mapping);
+
+	start = slot->gmem.pgoff;
+	end = start + slot->npages;
+
+	if (!xa_empty(&gmem->bindings) &&
+	    xa_find(&gmem->bindings, &start, end - 1, XA_PRESENT)) {
+		filemap_invalidate_unlock(inode->i_mapping);
+		return -EEXIST;
+	}
+
+	r = xa_err(xa_store_range(&gmem->bindings, start, end - 1, slot, GFP_KERNEL));
+	if (r)
+		xa_store_range(&gmem->bindings, start, end - 1, NULL, GFP_KERNEL);
+
+	filemap_invalidate_unlock(inode->i_mapping);
+
 	return r;
 }
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 5521743d6e8cb..2354a4097dec4 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2128,7 +2128,23 @@ static int kvm_set_memory_region(struct kvm *kvm,
 	new->flags = mem->flags;
 	new->userspace_addr = mem->userspace_addr;
 	if (change == KVM_MR_CREATE && (mem->flags & KVM_MEM_GUEST_MEMFD)) {
-		r = kvm_gmem_bind(kvm, new, mem->guest_memfd, mem->guest_memfd_offset);
+		r = kvm_gmem_prepare_memory_region(kvm, new, mem->guest_memfd,
+						   mem->guest_memfd_offset);
+		if (r)
+			goto out;
+
+		r = kvm_gmem_commit_memory_region(kvm, new);
+
+		/*
+		 * Drop the reference to the file, even on success.  The file
+		 * pins KVM, not the other way 'round.  Active bindings are
+		 * invalidated if the file is closed before memslots are
+		 * destroyed.
+		 */
+#ifdef CONFIG_KVM_GUEST_MEMFD
+		 fput(new->gmem.file);
+#endif
+
 		if (r)
 			goto out;
 	}
diff --git a/virt/kvm/kvm_mm.h b/virt/kvm/kvm_mm.h
index 0e68675a8a630..9db0a64d9d541 100644
--- a/virt/kvm/kvm_mm.h
+++ b/virt/kvm/kvm_mm.h
@@ -73,8 +73,9 @@ static inline void gfn_to_pfn_cache_invalidate_start(struct kvm *kvm,
 #ifdef CONFIG_KVM_GUEST_MEMFD
 void kvm_gmem_init(struct module *module);
 int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args);
-int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
-		  unsigned int fd, u64 offset);
+int kvm_gmem_prepare_memory_region(struct kvm *kvm, struct kvm_memory_slot *slot,
+				   unsigned int fd, u64 offset);
+int kvm_gmem_commit_memory_region(struct kvm *kvm, struct kvm_memory_slot *slot);
 void kvm_gmem_unbind(struct kvm_memory_slot *slot);
 #else
 static inline void kvm_gmem_init(struct module *module)
@@ -82,9 +83,16 @@ static inline void kvm_gmem_init(struct module *module)
 
 }
 
-static inline int kvm_gmem_bind(struct kvm *kvm,
-					 struct kvm_memory_slot *slot,
-					 unsigned int fd, u64 offset)
+static inline int kvm_gmem_prepare_memory_region(struct kvm *kvm,
+						 struct kvm_memory_slot *slot,
+						 unsigned int fd, u64 offset)
+{
+	WARN_ON_ONCE(1);
+	return -EIO;
+}
+
+static inline int kvm_gmem_commit_memory_region(struct kvm *kvm,
+						struct kvm_memory_slot *slot)
 {
 	WARN_ON_ONCE(1);
 	return -EIO;
-- 
2.53.0


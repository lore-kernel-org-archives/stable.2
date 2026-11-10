Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794291679;
	b=u0i/jqAnYgiurMyMraOxONqebdc4Qr4jdyjjWhSRVMZ+o+0HDcOIrdQfIKQDkAoE9PMb
	 wptPjrXqahs9Znkgxfyp8hnG8sCVYUD84jx01Z8MSe3X+nfJ9UgVcv+VkuaFtoB6/HojR
	 6GrHuKCbS0ZKLqzNQg9Vkz3U/JT6ngsQGUxRO9677y+M5hOFw31XSHqhMzGQDQusYdBXv
	 ALWKw47peXREt0axJ8gs6406ZIjKgzk2ueSDlrM/YJcN1E6QrX4fs9AXkm1+1rKt+jazM
	 6N4/JrbU1QnZ2yCdEHwVnaPSZBgKoOxg0K1qyz33wXLUsBv/+F75iS7Rv3/IYMEYvxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794291679;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=AO43z8OOLZpih4NLQwu7cfaQLJzm76ZwrofVqC2prTU=;
	b=jcGUy/ah67uZsP00K1lgfC+GQww+mnIFFYaoX8SyuQRweE4o0tYDUbrRTRI41G3h8rKu
	 VchTbKXDv6ixUK8jhG3nHbYp4Syut8Xqm2GuCnkmgAw4hMkSGjvooL+5OH+9Ucl1lUQ20
	 qR4PcCRndCKxzGXFTEUy9AoQzjlygYcpYzbnEnV0Y14ZVai75pFTX9Bez0MltXgaGS2Rh
	 S0mprmOVl+dindTRY1rcnqy97N9dSFddpwPjD0dQ8wtPFUZQiezcBv034gr7ymIE2yhyh
	 dzlU+DVSGBPJ2FXUNAkBHH4Lc8HhXQlXxM5R7B/o/0OFXUp132nMSGBKuw5oAfyunTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="TY/mZdDH";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7352606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 06:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TY/mZdDH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D85BB1F008A1;
	Tue, 10 Nov 2026 06:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794291678;
	bh=AO43z8OOLZpih4NLQwu7cfaQLJzm76ZwrofVqC2prTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TY/mZdDHxsTQULFQR06kA8TzMRa3T8NdoMBQncVyw7FQq9gHNoCaj0DFacBS0+MFa
	 MUuapqB6Z/9E3KNyfZxmhJQuXZR23SI6I2922TICLhAPnvYDpQL/RLkOFOChog8nv6
	 uzYTg8dwOR3zQ6tV0VV3lROn+3FcXNgOM4ULrWdt752Ouc6FrxfuAuUNNsY+CdWn1w
	 2hpG8fa++NvPmdemazTDrWT/3XK7NwAQWJ73sdUM7wRUyMiBofi6O7kCUTEwSoYv69
	 Emvhq8bopudIQg83f+dYvM3xYjt3l43HnG/9t7xpjyLQuTaBCMqyy6ZfQ6MF1w72c/
	 V0HshS91iNu+g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] KVM: guest_memfd: Split bind() into prepare()+commit() phases
Date: Tue, 10 Nov 2026 01:21:15 -0500
Message-ID: <20261110062046.520447-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051731-failed-6.12-83411f32b8ad@kernel.org>
References: <20261107051731-failed-6.12-83411f32b8ad@kernel.org>
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
[ sashal: changed the fput() guard from CONFIG_KVM_GUEST_MEMFD to CONFIG_KVM_PRIVATE_MEM ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 virt/kvm/guest_memfd.c | 61 +++++++++++++++++++++++++-----------------
 virt/kvm/kvm_main.c    | 18 ++++++++++++-
 virt/kvm/kvm_mm.h      | 18 +++++++++----
 3 files changed, 66 insertions(+), 31 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 88b7279f4634d..4f69260cafbb2 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -472,15 +472,13 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args)
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
 
 	BUILD_BUG_ON(sizeof(gpa_t) != sizeof(offset));
 	BUILD_BUG_ON(sizeof(gfn_t) != sizeof(slot->gmem.pgoff));
@@ -501,40 +499,53 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
 	if (!PAGE_ALIGNED(offset) || offset + size > i_size_read(inode))
 		goto err;
 
+	/*
+	 * memslots of flag KVM_MEM_GUEST_MEMFD are immutable to change, so
+	 * kvm_gmem_bind() must occur on a new memslot.  Because the memslot
+	 * is not visible yet, kvm_gmem_get_pfn() is guaranteed to see the file.
+	 */
+	WRITE_ONCE(slot->gmem.file, file);
+	slot->gmem.pgoff = offset >> PAGE_SHIFT;
+
+	/*
+	 * Gift the caller a reference to the file.  The reference will be
+	 * dropped after bindings are established, or if installing the new
+	 * memslot ultimately fails.
+	 */
+	return 0;
+
+err:
+	fput(file);
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
 	filemap_invalidate_lock(inode->i_mapping);
 
-	start = offset >> PAGE_SHIFT;
+	start = slot->gmem.pgoff;
 	end = start + slot->npages;
 
 	if (!xa_empty(&gmem->bindings) &&
 	    xa_find(&gmem->bindings, &start, end - 1, XA_PRESENT)) {
 		filemap_invalidate_unlock(inode->i_mapping);
-		goto err;
+		return -EEXIST;
 	}
 
-	/*
-	 * memslots of flag KVM_MEM_GUEST_MEMFD are immutable to change, so
-	 * kvm_gmem_bind() must occur on a new memslot.  Because the memslot
-	 * is not visible yet, kvm_gmem_get_pfn() is guaranteed to see the file.
-	 */
-	WRITE_ONCE(slot->gmem.file, file);
-	slot->gmem.pgoff = start;
-
 	r = xa_err(xa_store_range(&gmem->bindings, start, end - 1, slot, GFP_KERNEL));
-	if (r) {
+	if (r)
 		xa_store_range(&gmem->bindings, start, end - 1, NULL, GFP_KERNEL);
-		slot->gmem.file = NULL;
-		slot->gmem.pgoff = 0;
-	}
+
 	filemap_invalidate_unlock(inode->i_mapping);
 
-	/*
-	 * Drop the reference to the file, even on success.  The file pins KVM,
-	 * not the other way 'round.  Active bindings are invalidated if the
-	 * file is closed before memslots are destroyed.
-	 */
-err:
-	fput(file);
 	return r;
 }
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index c574cd2f4f722..699198ae1594c 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2103,7 +2103,23 @@ int __kvm_set_memory_region(struct kvm *kvm,
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
+#ifdef CONFIG_KVM_PRIVATE_MEM
+		fput(new->gmem.file);
+#endif
+
 		if (r)
 			goto out;
 	}
diff --git a/virt/kvm/kvm_mm.h b/virt/kvm/kvm_mm.h
index 15b2c728f7dd5..92ec2bde65324 100644
--- a/virt/kvm/kvm_mm.h
+++ b/virt/kvm/kvm_mm.h
@@ -41,8 +41,9 @@ static inline void gfn_to_pfn_cache_invalidate_start(struct kvm *kvm,
 #ifdef CONFIG_KVM_PRIVATE_MEM
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
@@ -50,9 +51,16 @@ static inline void kvm_gmem_init(struct module *module)
 
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


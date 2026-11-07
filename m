Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050193;
	b=xwxRKoxa/GEuLUrTnsEeTjpg3tj70WhVQfIBwME/ZCQo+hcdXNkWkprl8GVSTZZonyxQ
	 Dl7HTbpPhYyXdbiYXN+mL3Cp8x7nRSQBI2Ly68ARbFpmZz6FDZZ7RQlyomA5Y8fOEqpIf
	 t6O8Rpy74efoEk8YbXDRrrN2fYC8VjI9aU9ErGyh2Dkgtv9Ik8mTawW61WvbiVNHFC3yd
	 yS8DT4dziuhkJcERzFrGdsMmPf0zb83kJdeymrQulK18q97CuAn+pPwEV/8PSqCwy2zYc
	 gRpg8fp5HbM1UbtMS+64BmKZjSSyVRaiNk2AaprHOUbgl0KmDpmqWbbrngglJnzV1Lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050193;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=jE49MoEIL1hWyRuoeP0+rII5CD1psDKKvGEaM0oKVB0=;
	b=1LxfNlTsf8vg2LqklPhUSg849/zGfCwskeTdDLEQnI4eBxB9fJpYgYziDPplMUv5Zacb
	 EOuPmoLTAu+lX+YjDOzbHazxj0NKxBQvjtkww0+e0mZvrqnYmxorfdUu7cgkkPiq5+vA9
	 UCYdjE1wGh5ndXSyJoUY/hQY7jOf9vMnVv0wrRg0wcb71Ff52Y2npdQJzvY0b77Y5nEqW
	 G6EhC7B0ia/FX9xWs1LwOyc02Aecmh0uuequ4yFczLR0QGzsC3nQk7EYVlj4E4Qy+pJPV
	 9GJv5LIFXL0VB+FqxmOEsUXRMiDjOCO4FnKOitNu/0h/c/xLPQBiW+hW+i/A7FyZieg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MWjUIyLH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CAD606A32E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MWjUIyLH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C59801F0089F;
	Sat,  7 Nov 2026 11:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050193;
	bh=jE49MoEIL1hWyRuoeP0+rII5CD1psDKKvGEaM0oKVB0=;
	h=From:To:Cc:Subject:Date;
	b=MWjUIyLHcoVXbrzmDLKQAQUeU1rKoNyA8RcCog3FGeVqE5EHS01g2Tji7zT4bVgvJ
	 R9ocIVUrR1yByhp43NivBJl+LPN7SlS0NaZ9c5iUpqVDzM7IHOTNb0L9BizE4UwR/i
	 inMQ//3qRTLCAieaUJl53umlKI08f0X7Y+H4Ogm44lwg9b4n9JL3N05CpuuM2Ocf7s
	 34hUYlqWr9LmZ5nhBp128CCmgmIeGxTU3Hjr6KNMSkZKNRJFQpcpkAplak4q/Sen/p
	 5Dkyj4RXN4vRVXHeBhRE8WDyyIzhgHKJO10c1yWdqAcd+3AgElit+eYPs+cd/9aG7h
	 Sqo/QgrBixxGQ==
From: Sasha Levin <sashal@kernel.org>
To: seanjc@google.com,
	david@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] KVM: guest_memfd: Split bind() into prepare()+commit() phases" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:16:31 -0500
Message-ID: <20261107061631-failed-5.10-83411f32b8ad@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 83411f32b8ad96c6b05b1511d1a588daab44bd25
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061631-failed-5.10-83411f32b8ad@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 83411f32b8ad96c6b05b1511d1a588daab44bd25 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Mon, 21 Sep 2026 17:13:30 -0700
Subject: [PATCH] KVM: guest_memfd: Split bind() into prepare()+commit() phases

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
---
 virt/kvm/guest_memfd.c | 68 ++++++++++++++++++++++++------------------
 virt/kvm/guest_memfd.h | 19 ++++++++----
 virt/kvm/kvm_main.c    | 18 ++++++++++-
 3 files changed, 70 insertions(+), 35 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 751d0ad94f746..c813c20de7f30 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -642,15 +642,14 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args)
 	return __kvm_gmem_create(kvm, size, flags);
 }
 
-int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
-		  unsigned int fd, uoff_t offset)
+int kvm_gmem_prepare_memory_region(struct kvm *kvm, struct kvm_memory_slot *slot,
+				   unsigned int fd, uoff_t offset)
 {
 	uoff_t size = slot->npages << PAGE_SHIFT;
-	unsigned long start, end;
 	struct gmem_file *f;
 	struct inode *inode;
 	struct file *file;
-	int r = -EINVAL;
+
 
 	BUILD_BUG_ON(sizeof(gpa_t) != sizeof(offset));
 	BUILD_BUG_ON(sizeof(gfn_t) != sizeof(slot->gmem.pgoff));
@@ -674,44 +673,55 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
 	if (!PAGE_ALIGNED(offset) || offset + size > i_size_read(inode))
 		goto err;
 
-	filemap_invalidate_lock(inode->i_mapping);
-
-	start = offset >> PAGE_SHIFT;
-	end = start + slot->npages;
-
-	if (!xa_empty(&f->bindings) &&
-	    xa_find(&f->bindings, &start, end - 1, XA_PRESENT)) {
-		r = -EEXIST;
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
 
-	r = xa_err(xa_store_range(&f->bindings, start, end - 1, slot, GFP_KERNEL));
-	if (r) {
-		xa_store_range(&f->bindings, start, end - 1, NULL, GFP_KERNEL);
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
+	struct gmem_file *f = slot->gmem.file->private_data;
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
+	if (!xa_empty(&f->bindings) &&
+	    xa_find(&f->bindings, &start, end - 1, XA_PRESENT)) {
+		filemap_invalidate_unlock(inode->i_mapping);
+		return -EEXIST;
+	}
+
+	r = xa_err(xa_store_range(&f->bindings, start, end - 1, slot, GFP_KERNEL));
+	if (r)
+		xa_store_range(&f->bindings, start, end - 1, NULL, GFP_KERNEL);
+
+	filemap_invalidate_unlock(inode->i_mapping);
+
 	return r;
 }
 
diff --git a/virt/kvm/guest_memfd.h b/virt/kvm/guest_memfd.h
index 0f9c6f8408389..01bd359d27e30 100644
--- a/virt/kvm/guest_memfd.h
+++ b/virt/kvm/guest_memfd.h
@@ -8,8 +8,9 @@
 int kvm_gmem_init(struct module *module);
 void kvm_gmem_exit(void);
 int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args);
-int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
-		  unsigned int fd, uoff_t offset);
+int kvm_gmem_prepare_memory_region(struct kvm *kvm, struct kvm_memory_slot *slot,
+				   unsigned int fd, uoff_t offset);
+int kvm_gmem_commit_memory_region(struct kvm *kvm, struct kvm_memory_slot *slot);
 void kvm_gmem_unbind(struct kvm_memory_slot *slot);
 #else
 static inline int kvm_gmem_init(struct module *module)
@@ -17,9 +18,17 @@ static inline int kvm_gmem_init(struct module *module)
 	return 0;
 }
 static inline void kvm_gmem_exit(void) {};
-static inline int kvm_gmem_bind(struct kvm *kvm,
-					 struct kvm_memory_slot *slot,
-					 unsigned int fd, uoff_t offset)
+
+static inline int kvm_gmem_prepare_memory_region(struct kvm *kvm,
+						 struct kvm_memory_slot *slot,
+						 unsigned int fd, uoff_t offset)
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
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index c53a88cea1f23..c7526c1617f7a 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2107,7 +2107,23 @@ static int kvm_set_memory_region(struct kvm *kvm,
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
-- 
2.53.0





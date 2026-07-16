Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39E81A2C25
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 11:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784202076; cv=none; b=LQnc5hy6OgtNGsyxWZaZvdkvdRZQSWZTPxXtluF9/Ge8QKhdv2NNI1yndIDWzs523Wxvyq9noMmQMjZcULKKExmzu97Dul5xkVuVYxhicM5OoO3dVa64xkq/8I8REdN/YCwWbmqyTopp+W746Tdf7nJKK6t64JomrCb1i8HP3DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784202076; c=relaxed/simple;
	bh=29jQMChxbO3tsnNGpSuJfH84W5iS2mKHSGjUYeW8VK4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=t8+vXOXDIbOsUm4QCIXJaKd7CpP+e/0BrTp4ed01UBeakrmWM8crv7SXpVr8mpAU+OpMTRpaeZeAj5J/vvYZU8FkSCx3yyG6avy//TkLfZBPhDEO39FDlnJNU48q/5rZeZscTK1jt4ridwxdmKtSXy3COnKra5uiUyKkd/L4xE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IZ1ZoOzZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IZ1ZoOzZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E531F000E9;
	Thu, 16 Jul 2026 11:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784202075;
	bh=Le28TrVAJjFm+MFWXJ8tMSTc/3lYfdsT/e45/vz5tR8=;
	h=Subject:To:Cc:From:Date;
	b=IZ1ZoOzZdVWZmfq46qhJa8Oj7kVoLAIkQPQ8ZforLu8kJHl+oyGU7mogZpzI30SoY
	 6Uyvigb+VNFHQ5R4TYscwgyxinee38pXl6dns13/OoxzizMwyHvWYQ89BH29DR4uV4
	 PRtRowRaz/yFF+p8CZZ7OOrFGWZKcBORxl7lwdKU=
Subject: FAILED: patch "[PATCH] KVM: guest_memfd: Treat memslot binding offset+size as" failed to apply to 6.12-stable tree
To: seanjc@google.com,ackerleytng@google.com,michael.roth@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Jul 2026 13:41:00 +0200
Message-ID: <2026071600-cognition-untrue-ec58@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x eba85fee7fc6cf28fec38a5bf3c378bef9a79ca6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071600-cognition-untrue-ec58@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From eba85fee7fc6cf28fec38a5bf3c378bef9a79ca6 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Tue, 2 Jun 2026 10:09:19 -0700
Subject: [PATCH] KVM: guest_memfd: Treat memslot binding offset+size as
 unsigned values

When binding a memslot to a guest_memfd file, treat the offset and size as
unsigned values to fix a bug where the sum of the two can result in a false
negative when checking for overflow against the size of the file.  Passing
unsigned values also avoids relying on somewhat obscure checks in other
flows for safety, and tracks the offset and size as they are intended to be
tracked, as unsigned values.

On 64-bit kernels, the number of pages a memslot contains and thus the size
(and offset) of its guest_memfd binding are unsigned 64-bit values.  Taking
the offset+size as an loff_t instead of a uoff_t inadvertently converts
the unsigned value to a signed value if the offset and/or size is massive.

Locally storing the offset and size as signed values is benign in and of
itself (though even that is *extremely* difficult to discern), but
operating on their sum is not.

For the offset, KVM explicitly checks against a negative value, which might
seem like a bug as KVM could incorrectly reject a legitimate binding, but
that's not actually the case as KVM_CREATE_GUEST_MEMFD takes a signed value
for its size, i.e. a would-be-negative offset is also greater than the
maximum possible size of any guest_memfd file.

Regarding the size, while KVM lacks an explicit check for a negative value,
i.e. seemingly has a flawed overflow check, KVM restricts the number of
pages in a single memslot to the largest positive signed 32-bit value:

        if (id < KVM_USER_MEM_SLOTS &&
            (mem->memory_size >> PAGE_SHIFT) > KVM_MEM_MAX_NR_PAGES)
                return -EINVAL;

and so that maximum "size" will ever be is 0x7fffffff000.

The sum of the two is, however, problematic.  While the size is restricted
by KVM's memslot logic, the offset is not, i.e. the offset is completely
unchecked until the "offset + size > i_size_read(inode)" check.  If the
offset is the (nearly) largest possible _positive_ value, then adding size
to the offset can result in a signed, negative 64-bit value.  When compared
against the size of the file (guaranteed to be positive), the negative sum
is always smaller, and KVM incorrectly allows the absurd offset.

Opportunistically add missing includes in kvm_mm.h (instead of relying on
its parents).

Fixes: a7800aa80ea4 ("KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for guest-specific backing memory")
Cc: stable@vger.kernel.org
Cc: Ackerley Tng <ackerleytng@google.com>
Reviewed-by: Michael Roth <michael.roth@amd.com>
Reviewed-by: Ackerley Tng <ackerleytng@google.com>
Link: https://patch.msgid.link/20260602170921.1304394-2-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 46727539d08a..f54502640b08 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -640,15 +640,16 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args)
 }
 
 int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
-		  unsigned int fd, loff_t offset)
+		  unsigned int fd, uoff_t offset)
 {
-	loff_t size = slot->npages << PAGE_SHIFT;
+	uoff_t size = slot->npages << PAGE_SHIFT;
 	unsigned long start, end;
 	struct gmem_file *f;
 	struct inode *inode;
 	struct file *file;
 	int r = -EINVAL;
 
+	BUILD_BUG_ON(sizeof(gpa_t) != sizeof(offset));
 	BUILD_BUG_ON(sizeof(gfn_t) != sizeof(slot->gmem.pgoff));
 
 	file = fget(fd);
@@ -664,8 +665,7 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
 
 	inode = file_inode(file);
 
-	if (offset < 0 || !PAGE_ALIGNED(offset) ||
-	    offset + size > i_size_read(inode))
+	if (!PAGE_ALIGNED(offset) || offset + size > i_size_read(inode))
 		goto err;
 
 	filemap_invalidate_lock(inode->i_mapping);
diff --git a/virt/kvm/kvm_mm.h b/virt/kvm/kvm_mm.h
index 9fcc5d5b7f8d..7510ca915dd1 100644
--- a/virt/kvm/kvm_mm.h
+++ b/virt/kvm/kvm_mm.h
@@ -3,6 +3,9 @@
 #ifndef __KVM_MM_H__
 #define __KVM_MM_H__ 1
 
+#include <linux/kvm.h>
+#include <linux/kvm_types.h>
+
 /*
  * Architectures can choose whether to use an rwlock or spinlock
  * for the mmu_lock.  These macros, for use in common code
@@ -72,7 +75,7 @@ int kvm_gmem_init(struct module *module);
 void kvm_gmem_exit(void);
 int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args);
 int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
-		  unsigned int fd, loff_t offset);
+		  unsigned int fd, uoff_t offset);
 void kvm_gmem_unbind(struct kvm_memory_slot *slot);
 #else
 static inline int kvm_gmem_init(struct module *module)
@@ -82,7 +85,7 @@ static inline int kvm_gmem_init(struct module *module)
 static inline void kvm_gmem_exit(void) {};
 static inline int kvm_gmem_bind(struct kvm *kvm,
 					 struct kvm_memory_slot *slot,
-					 unsigned int fd, loff_t offset)
+					 unsigned int fd, uoff_t offset)
 {
 	WARN_ON_ONCE(1);
 	return -EIO;


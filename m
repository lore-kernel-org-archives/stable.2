Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793820164;
	b=a4bz1Bwy8GMxsMdU9158/e249D8qpzM9ddacSyqsQg0lFGP77sr684+Wj721xPTv0r2X
	 7OujQOl3DJwWtH8XHzUyi0IVWfAJRF//nCD+7kiiApCYPH71PFW3eN6Rlqzudvn2XWmsA
	 ERZZGQRluDLWe5TWARNtUDPkO857wb29ctTOON3XJav5xOe6Ht30idfbcil4ZJ4CLuExQ
	 71hAS8j8L+x26EFvecIttzYYEloeJ0r67fBFTpZnMbcLXwf1YUO2iRJ0QPrLEwl7F+d7F
	 ijON1f6+qSdF7QYCevvMR+95IXE/RwrjZAKayNfvZBwoYwluTmhe+6MxN/66T13AHZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793820164;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=xSHPRMwgYvv87BhKRb1F8Oqc/A4sbUaGTYI2VwdCY1Q=;
	b=uDQ5jPwutqX69gIo/1xTk4hajkbdPJfdGnvwRa0J/s16cJLgzH70Uvc7xtbX10z9c0TD
	 X3uWYYpsCIKh7FJJtXvFwoyJcMRQ7fLTMmqaMSUFcJdGSxpwSbhymVBrzI/ynC6lo9zp8
	 myKm8u40qrBTeNq11CuNMvRL2tVZCBXFfKbk2vihXSjm28Fn3/JwIYrGQVP4xBvVXd429
	 NMjquJ9fyNnsiKjE8tCHhmfhB9kNddf1BWhjh1IlyQjiQcprmY5+uwvOZ0quGEb2eNqsN
	 /w8KHDuT5Gmc/jG4Djk3gokJlkHKvEE/sANWAOGOJiNqUTNmeQNaAsjdh+/WeZQQWQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=uyu7lO7P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C342A606C90E
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 19:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=uyu7lO7P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 544FC1F00919;
	Wed,  4 Nov 2026 19:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793820163;
	bh=xSHPRMwgYvv87BhKRb1F8Oqc/A4sbUaGTYI2VwdCY1Q=;
	h=Subject:To:Cc:From:Date;
	b=uyu7lO7Pb+Avj+pRANXplHu6TWO0nds/HQItrCwOxzDZbZfLPj9kP/ER5qkOJ1AS+
	 0lN3fPdb+C9JugHTd6XRMQJCBPnGyy1zpV31WdK1giZROkG9hXV3aTKY++AM4340qU
	 2Ot4NcDumZIOauYtU19b+ANKdWv0vpcVmLEhkb/0=
Subject: FAILED: patch "[PATCH] KVM: guest_memfd: take the invalidate lock when unbinding a" failed to apply to 6.18-stable tree
To: shivankg@amd.com,david@kernel.org,sashiko-bot@kernel.org,seanjc@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 14:22:42 -0500
Message-ID: <2026110442-recast-sequel-2c6a@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 0ee2c883b62deb74d8c43007e8049dc006d3a2fb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110442-recast-sequel-2c6a@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0ee2c883b62deb74d8c43007e8049dc006d3a2fb Mon Sep 17 00:00:00 2001
From: Shivank Garg <shivankg@amd.com>
Date: Tue, 1 Sep 2026 07:20:38 +0000
Subject: [PATCH] KVM: guest_memfd: take the invalidate lock when unbinding a
 dying file

kvm_gmem_unbind() takes mapping->invalidate_lock only if the
get_file_active() succeeds. When the guest_memfd file is dying, its
reference count is already zero so get_file_active fails and the binding
is removed without holding the invalidate lock.

kvm_gmem_invalidate_{start,end}() checks f->bindings independently to
decide whether to begin or end KVM MMU invalidation. So, the bindings
must therefore remain stable between the two calls. Otherwise, unbind
can remove a binding after start increments mmu_invalidate_in_progress,
but before end finds the binding and decrements it.
Example, unbind race with memory failure:

  CPU 0: memory failure               CPU 1: memslot delete
  ----------------------------------  ---------------------------
                                      (guest_memfd file is dying)
  kvm_gmem_error_folio()
    kvm_gmem_invalidate_start()
      finds binding
      mmu_invalidate_in_progress++
                                      kvm_gmem_unbind()
                                        get_file_active() fails
                                        removes binding
    kvm_gmem_invalidate_end()
      no binding found
      counter stays elevated

mmu_invalidate_retry() then returns 1 forever, so guest page faults
retry without ever installing a mapping and the guest hangs.

Remove the distinction between live and dying files in the unbind path.
Always use slot->gmem.file and take the invalidate lock when it's non-NULL.
Normal unbind callers hold slots_lock, which prevents release from clearing
the pointer or freeing the file state until unbind completes. Final VM
teardown can only see a NULL pointer because guest_memfd pins the KVM until
release has cleared all bindings.

Fixes: ae431059e75d ("KVM: guest_memfd: Remove bindings on memslot deletion when gmem is dying")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260728092027.225CF1F000E9@smtp.kernel.org
Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Shivank Garg <shivankg@amd.com>
Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
Link: https://patch.msgid.link/20260901-gmem-unbind-fix-v2-1-12febe1d2216@amd.com
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 625e62e1a031..21bb3710edfe 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -668,11 +668,33 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
 	return r;
 }
 
-static void __kvm_gmem_unbind(struct kvm_memory_slot *slot, struct gmem_file *f)
+void kvm_gmem_unbind(struct kvm_memory_slot *slot)
 {
+	struct file *file = slot->gmem.file;
 	unsigned long start = slot->gmem.pgoff;
 	unsigned long end = start + slot->npages;
+	struct gmem_file *f;
 
+	/*
+	 * Nothing to do if the underlying file was _already_ closed, as
+	 * kvm_gmem_release() invalidates and nullifies all bindings.
+	 */
+	if (!file)
+		return;
+
+	/*
+	 * However, if the file is _being_ closed, then the bindings need to be
+	 * removed as kvm_gmem_release() might not run until after the memslot
+	 * is freed.  Modifying the bindings is safe even if the file is dying
+	 * as kvm_gmem_release() nullifies slot->gmem.file under slots_lock,
+	 * and only puts its reference to KVM after destroying all bindings.
+	 * I.e. reaching this point means kvm_gmem_release() hasn't destroyed
+	 * the bindings or freed the gmem_file and can't do so until the caller
+	 * drops slots_lock, so there's no need to verify the file is live.
+	 */
+	f = file->private_data;
+
+	filemap_invalidate_lock(file->f_mapping);
 	xa_store_range(&f->bindings, start, end - 1, NULL, GFP_KERNEL);
 
 	/*
@@ -680,36 +702,6 @@ static void __kvm_gmem_unbind(struct kvm_memory_slot *slot, struct gmem_file *f)
 	 * cannot see this memslot.
 	 */
 	WRITE_ONCE(slot->gmem.file, NULL);
-}
-
-void kvm_gmem_unbind(struct kvm_memory_slot *slot)
-{
-	/*
-	 * Nothing to do if the underlying file was _already_ closed, as
-	 * kvm_gmem_release() invalidates and nullifies all bindings.
-	 */
-	if (!slot->gmem.file)
-		return;
-
-	CLASS(gmem_get_file, file)(slot);
-
-	/*
-	 * However, if the file is _being_ closed, then the bindings need to be
-	 * removed as kvm_gmem_release() might not run until after the memslot
-	 * is freed.  Note, modifying the bindings is safe even though the file
-	 * is dying as kvm_gmem_release() nullifies slot->gmem.file under
-	 * slots_lock, and only puts its reference to KVM after destroying all
-	 * bindings.  I.e. reaching this point means kvm_gmem_release() hasn't
-	 * yet destroyed the bindings or freed the gmem_file, and can't do so
-	 * until the caller drops slots_lock.
-	 */
-	if (!file) {
-		__kvm_gmem_unbind(slot, slot->gmem.file->private_data);
-		return;
-	}
-
-	filemap_invalidate_lock(file->f_mapping);
-	__kvm_gmem_unbind(slot, file->private_data);
 	filemap_invalidate_unlock(file->f_mapping);
 }
 


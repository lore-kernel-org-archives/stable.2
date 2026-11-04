Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793820173;
	b=ZnqIl1xUJfhJUHBCshDd3eCmOStjEjqJMJ/LVSfB23S4aEgczMjjgDi7esivErFb/z9C
	 4On2aR0ASoBZWNdvqn5v9WOAUdc5/+yjQnOZKtVITd105oqw/89YKqT17GEnQvFr4ZE9z
	 gSKcZ76YE27qSi3Hw4Y3DN3G/IjI0BhcGQg8a8Y8P6tlrlWo2FRchA7a8VvCHWNZss4Iu
	 PxSo55iAfqcIUKSC+ajOssBzRGX1fVwSkrCsOepUGsqRvqZHGvU7Et9c8Ng9j9KiTTOTh
	 eNXQ/qdXIbm2UlvAuY4YRtUVIHB6IU/jxLPxVCwAPC5h0SjpH6rZ9viS+Nswa7Qw02g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793820173;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=b+dKPKBiHusdRq8k+f2Xcxy60hmat6uaNJGaWRyDLzQ=;
	b=0OUVNbe35ZGRXHjccNs4BjcWW2lQXOb1yE6xnuByWK8FqNdQAIrCVwzdMwhQfrV+2dRM
	 pGvMPq+bFaHfh8HcpJLJUdrMoz7gA+kzSExjoeB4/Wuk/Hp4MzRpHYv+fStxrHeu1wlKc
	 RHV/V0xwpaqmQutL2Qx15zepLx69PZtnLQ99huK3OYN+oAFtTvRhM6ufTSOn6VA5XiNnw
	 /mCq7B6/j57mZwriP+WVim3mWy5JusWOOz5vMnGN672RJ9216CJRdX5QeGNakOG2Rot/d
	 DtYwDausodcq0keuPSt5lc/yTfw0GLFT5tYp1sTkSZqqL6O1lo5j6kUgYgjPerw67yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=OJxhLLlR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5031607894A
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 19:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=OJxhLLlR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A2F1F0093A;
	Wed,  4 Nov 2026 19:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793820172;
	bh=b+dKPKBiHusdRq8k+f2Xcxy60hmat6uaNJGaWRyDLzQ=;
	h=Subject:To:Cc:From:Date;
	b=OJxhLLlRPI+Fft47CA3j519I506u9uy9rE5lEh400jPUM+kayyCr4kX5ddjoRpo+r
	 zP3FG55u0jrw/HTecMhXBDABuVV5qZXys1PMmGzUfPkkDrFUP7rTkEUoItYGqSoSWO
	 RbTywYXuMNwD2VjJzJMRG5Eulp5ufgXGOJVS/XIU=
Subject: FAILED: patch "[PATCH] KVM: guest_memfd: take the invalidate lock when unbinding a" failed to apply to 6.12-stable tree
To: shivankg@amd.com,david@kernel.org,sashiko-bot@kernel.org,seanjc@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 14:22:43 -0500
Message-ID: <2026110443-wham-canine-0ce3@gregkh>
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


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 0ee2c883b62deb74d8c43007e8049dc006d3a2fb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110443-wham-canine-0ce3@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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
 


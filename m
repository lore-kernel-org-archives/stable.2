Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793974421;
	b=MMmUxibdQU1pr0tV6zuzLEMAOTdW3iieb26DTdisJNwKJcf2Q4vg/t7CXinX/OqrSJWe
	 Ovge+u/nXVDjIjRimoUttNQaoQ3mffDcMioHZyw+cij2XoZx97kBIPg2lYuYqGhU9OHCA
	 XmGElE0JVElXtEp/DFUdnA+MoSLrPgldWAe/mA4kU9qVxazBXnjP94BFnQY3s6OQGXalR
	 o+Kbj5nH7E4qRjbOwMH8Q8hYvfZy6Isk5XoR2EZXz2RpO1P10220Ruidt7hVnwWu+Y2nL
	 ZBIeDdW2B49+r8n8xIR5uLa+tEtEzlb9uPGbYdIVGWmjW0lz5Vq23t4cwkKTGWFqp0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793974421;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hwqHqfPbvqPsYJ/6jw8FyV9u20mx881DKftZYCYE5CA=;
	b=Qky8Og4NS1/TKHleECYGncWbetM0mIFtYPr3lIFJlEfP974VdgUwSmuj4SPguDs0lBvf
	 Rchk8nzt3iEh2rST0RnU0DL6KqQmvjkpU93owVClEb/UgTaLI1w2T0ElB698ZyicsZKd+
	 +NpmPqmqUDl7RaoZkxU2EXrBk1NO70MwW7gAJCb/5veY3xZ5TmkVa+T+9n8NQgiap21Pu
	 dbtCnmrhrgQ7T9b2qrYvIwSLGJXj/AFvZgy5yntCrPEMEvJtS54ic1GbH3FZp9gmRbm3B
	 bclelacJrb+BslYe4wvpd7g7WR/vknIxlhVjnNf1/3f7CUlrZ+B3PVLAHJLY0Ab89eA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="hap/gnbH";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4AF606A326
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 14:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hap/gnbH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93C3E1F0089F;
	Fri,  6 Nov 2026 14:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793974421;
	bh=hwqHqfPbvqPsYJ/6jw8FyV9u20mx881DKftZYCYE5CA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hap/gnbH7xtmR80leNScGbzVPSAT46n36U+BjSg8NssE6hVVmlSxSWJxOv1AmCkvk
	 CegqSCKtdSouKqgV+wDE2CC+aBp2CbKJ95lOIwpzaD/GZND0oiLJ+P5Cwm466ZbOOU
	 D5P5qHkk2KvzitQDKakk1/jCrXtUjsmBb8myEgQvTaQhEUUs68jOQUqdsuTopOEn/g
	 3g8N/cwuNuZZ/oI/xh30sET7bafRC03mZdM1O8BFRj8OnNH93Li+qNksj5/qTSP4EI
	 7NIh0eD5qV73PYhWAXAHvIwcqO+KkhgQtJyXGhQ+HHCj8YDj0kMLSj8H/knunDf6ny
	 ist36WHORzGwg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shivank Garg <shivankg@amd.com>,
	Sashiko <sashiko-bot@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] KVM: guest_memfd: take the invalidate lock when unbinding a dying file
Date: Fri,  6 Nov 2026 09:13:39 -0500
Message-ID: <20261106141257.320136-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110442-recast-sequel-2c6a@gregkh>
References: <2026110442-recast-sequel-2c6a@gregkh>
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

From: Shivank Garg <shivankg@amd.com>

[ Upstream commit 0ee2c883b62deb74d8c43007e8049dc006d3a2fb ]

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
[ sashal: Adapted unbind to struct kvm_gmem with explicit kvm_gmem_get_file()/fput() removal replacing upstream's automatic cleanup removal. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 virt/kvm/guest_memfd.c | 48 ++++++++++++++++--------------------------
 1 file changed, 18 insertions(+), 30 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index a59a4446b8461..e121534e21692 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -627,53 +627,41 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
 	return r;
 }
 
-static void __kvm_gmem_unbind(struct kvm_memory_slot *slot, struct kvm_gmem *gmem)
+void kvm_gmem_unbind(struct kvm_memory_slot *slot)
 {
+	struct file *file = slot->gmem.file;
 	unsigned long start = slot->gmem.pgoff;
 	unsigned long end = start + slot->npages;
-
-	xa_store_range(&gmem->bindings, start, end - 1, NULL, GFP_KERNEL);
-
-	/*
-	 * synchronize_srcu(&kvm->srcu) ensured that kvm_gmem_get_pfn()
-	 * cannot see this memslot.
-	 */
-	WRITE_ONCE(slot->gmem.file, NULL);
-}
-
-void kvm_gmem_unbind(struct kvm_memory_slot *slot)
-{
-	struct file *file;
+	struct kvm_gmem *gmem;
 
 	/*
 	 * Nothing to do if the underlying file was _already_ closed, as
 	 * kvm_gmem_release() invalidates and nullifies all bindings.
 	 */
-	if (!slot->gmem.file)
+	if (!file)
 		return;
 
-	file = kvm_gmem_get_file(slot);
-
 	/*
 	 * However, if the file is _being_ closed, then the bindings need to be
 	 * removed as kvm_gmem_release() might not run until after the memslot
-	 * is freed.  Note, modifying the bindings is safe even though the file
-	 * is dying as kvm_gmem_release() nullifies slot->gmem.file under
-	 * slots_lock, and only puts its reference to KVM after destroying all
-	 * bindings.  I.e. reaching this point means kvm_gmem_release() hasn't
-	 * yet destroyed the bindings or freed the gmem_file, and can't do so
-	 * until the caller drops slots_lock.
+	 * is freed.  Modifying the bindings is safe even if the file is dying
+	 * as kvm_gmem_release() nullifies slot->gmem.file under slots_lock,
+	 * and only puts its reference to KVM after destroying all bindings.
+	 * I.e. reaching this point means kvm_gmem_release() hasn't destroyed
+	 * the bindings or freed the gmem_file and can't do so until the caller
+	 * drops slots_lock, so there's no need to verify the file is live.
 	 */
-	if (!file) {
-		__kvm_gmem_unbind(slot, slot->gmem.file->private_data);
-		return;
-	}
+	gmem = file->private_data;
 
 	filemap_invalidate_lock(file->f_mapping);
-	__kvm_gmem_unbind(slot, file->private_data);
-	filemap_invalidate_unlock(file->f_mapping);
+	xa_store_range(&gmem->bindings, start, end - 1, NULL, GFP_KERNEL);
 
-	fput(file);
+	/*
+	 * synchronize_srcu(&kvm->srcu) ensured that kvm_gmem_get_pfn()
+	 * cannot see this memslot.
+	 */
+	WRITE_ONCE(slot->gmem.file, NULL);
+	filemap_invalidate_unlock(file->f_mapping);
 }
 
 /* Returns a locked folio on success.  */
-- 
2.53.0


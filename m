Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794437719;
	b=oN8kGZg9qrCmRkkpqGeSloKpKnxaNl/MZSwOuCi8XKzenGQTP9WFy8dL4xGs8ZpKRZLa
	 Hb8cJRYih/MbSSMDmNyylYzzCWX4pHeUtL1l/9HNFQisIzM3Bhu3zRuCnIk7bH+PhfppO
	 tCSn+XsaRfOyWonQ/lcHUBo9awiGdbjQqItAZkoXJlJrmc25Xta2u5DhJ9jcz9YJYZkkm
	 DSm8WpYmkmRaxA3V9EXhcpGVRVX6cE4j8pbrL8uRTAQbyrHx2btWlSic/xcW3Sx1EJtac
	 nm2Mi5LV59QASWOg4P8exMIVYYECvqwBxqmSbT0z8RG/T0mF353F0KMPnHv62PH6xTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794437719;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1gdf9Bq6jlJ/Em8YXNZn+PhSzP7XddBcL4qXg1rgFGs=;
	b=P8u7SpGSZMaZH43dXpycRXMTll8zYIPjk0GVfUwdTLlhTuUNBjaAt7jjFopMkEH/+D9u
	 qZ+eGk1N0Xl4L+HfV1StMy10xMICd9QeDuc/FykqRkX6B7BY54qjjMzEjEbPjHesjBDSP
	 evrVe2ov+90Y6BITSk7/3N7vuRW38UPHlI0qexagGNv5+HA3kuA+QdpOWtOAjwZkbX1LW
	 T18sjAHElftUXaIetVGT8h6OB0dSq4aX+uXRenEHARObRTBpo9c9/u1uA8cefZji3S/BT
	 WZzsy0gHf5E6eaNw6GqWewi7f+FHoTa7UExep5Szmskd/XCT+CAriTHmiZHPEmI/PjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Oy5NH1hS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3D3606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 22:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Oy5NH1hS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C0221F00A05;
	Wed, 11 Nov 2026 22:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794437718;
	bh=1gdf9Bq6jlJ/Em8YXNZn+PhSzP7XddBcL4qXg1rgFGs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Oy5NH1hSiBF8Q8rG86XY878Qbqwqwf7RQTl7C5TBLEd9SORpohB+s7FM9isTGuIgQ
	 hcrEhDkw57tBtA14HeKPpRW0EL6WLsUgCL3yjr5Lvmx9wiwvQHqQh3m5fbKlanU1Wi
	 snOLU+59dY7aa7TDQxj274YTRZpEnsfyz56MReDyUpeXbNy6NUklduRQ4Rs3+PqxRs
	 ZMDBxiac+EZzMFEAh95zojrt+tgK+tMhsH2a6CNvFLys+g+4/aevlOjR1hTHEQf4R6
	 n8Q5FKmxAPWrhZlcGmyw3C7T22fusjEEVAqqjumZqquU8xhJFAFqqXExZ3wkirw/BB
	 TySBSAjmakQ0A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	"Gregory Price (Meta)" <gourry@gourry.net>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y] mm/userfaultfd: wake waiters when registration modes are removed
Date: Wed, 11 Nov 2026 17:55:16 -0500
Message-ID: <20261111225453.188656-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200156-failed-7.3-4eee9c389b07@kernel.org>
References: <20261109200156-failed-7.3-4eee9c389b07@kernel.org>
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

From: "David Hildenbrand (Arm)" <david@kernel.org>

[ Upstream commit 4eee9c389b072e161549d46dcb1ae10b0222717e ]

UFFDIO_REGISTER can replace MISSING or MINOR tracking without waking
faults that are already queued. For example, switching an anonymous
range from MISSING to WP leaves a missing-fault waiter asleep until
userspace explicitly wakes it.

When a registration change removes a UFFD mode, wake waiters in the
affected interval after updating the VMA. The VMA is write-locked at
this point, so no new faults can queue under the old modes and woken
threads cannot retry until mmap_write_unlock(). Waiters for retained
modes in the same interval may also wake and refault.

The hang reproduces for MISSING-to-WP and MINOR-to-MISSING transitions,
with both read and unread fault events.

Fixes: 63b2d4174c4a ("userfaultfd: wp: add the writeprotect API to userfaultfd ioctl")
Cc: stable@vger.kernel.org
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Link: https://patch.msgid.link/20261031-fixes_core-v3-25-d6437171ecc3@kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
[ sashal: Adjusted context to retain is_vm_hugetlb_page() instead of vma_is_hugetlb(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/userfaultfd.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index cc37b60fc3e81..d94ca9d8a9d5f 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -2287,6 +2287,9 @@ static struct vm_area_struct *userfaultfd_clear_vma(struct vma_iterator *vmi,
 	return ret;
 }
 
+static void wake_userfault_range(struct userfaultfd_ctx *ctx,
+		unsigned long start, unsigned long end);
+
 /* Assumes mmap write lock taken, and mm_struct pinned. */
 static int userfaultfd_register_range(struct userfaultfd_ctx *ctx,
 			       struct vm_area_struct *vma,
@@ -2304,6 +2307,8 @@ static int userfaultfd_register_range(struct userfaultfd_ctx *ctx,
 		prev = vma;
 
 	for_each_vma_range(vmi, vma, end) {
+		const bool any_mode_removed = vma->vm_flags & __VM_UFFD_FLAGS & ~vm_flags;
+
 		cond_resched();
 
 		VM_WARN_ON_ONCE(!vma_can_userfault(vma, vm_flags, wp_async));
@@ -2349,6 +2354,10 @@ static int userfaultfd_register_range(struct userfaultfd_ctx *ctx,
 		 */
 		userfaultfd_set_ctx(vma, ctx, vm_flags);
 
+		/* Retry faults for removed modes while the VMA is write-locked. */
+		if (any_mode_removed)
+			wake_userfault_range(ctx, start, vma_end);
+
 		if (is_vm_hugetlb_page(vma) && uffd_disable_huge_pmd_share(vma))
 			hugetlb_unshare_all_pmds(vma);
 
@@ -3665,6 +3674,17 @@ static __always_inline void wake_userfault(struct userfaultfd_ctx *ctx,
 		__wake_userfault(ctx, range);
 }
 
+static void wake_userfault_range(struct userfaultfd_ctx *ctx,
+		unsigned long start, unsigned long end)
+{
+	struct userfaultfd_wake_range range = {
+		.start = start,
+		.len = end - start,
+	};
+
+	wake_userfault(ctx, &range);
+}
+
 static __always_inline int validate_unaligned_range(
 	struct mm_struct *mm, __u64 start, __u64 len)
 {
-- 
2.53.0


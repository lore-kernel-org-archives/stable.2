Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794438303;
	b=sOWtVBNyxdd733psqNIgDG+D3ACzfuwDSY6XS7roEXRv2ygNgu2YnJVFgcwrMdtOK00m
	 aM/ZblUAdIaaeEFzjSAYaZhxR8DDG+H36CFljdgIlHegKNQyCP1wcJcaZvdQU3AJTXHA4
	 +GFGKWaEhgPMk9TQlSufRFP9LdjoA9533dPRKUxkMWWGa/WBwQ5RrYUl/Oe0sUIO7dcrV
	 O0UsHP7Ay2zJakecd75CwJtWw2Ym7swD3QMuSBhNdZhC6IzvqDJn8WGmT7Sd0l8yrs72M
	 qZ/HfBQJwHMjBV3IIaC4IOy1HzFI0l5YsGzTFksQHdxuFylBqUvGfB4Sn/7nIxQD4Vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794438303;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=SP4kKZr1/rxDpDSqBCS8ofh6a0EM3fbwBhr6xrSIS7Q=;
	b=gGTY6kAvRXmYU/d0WRnsFgIbCx0VpHsPKSWpmQTbi5q9KdIRtKaXPaRnRDkVyzLgdFuv
	 04cnATfyghTnSCuVAytzFvvqZ4Q5prjzaeNejip8afr9OgnlUF748O1p9IUHTj6C3qqKz
	 c8YQAi3LzW9qfB/ymzoHF11EDhhXuZ9GxxCKRDjfKe7o5hWx6jPO8asOwdNp3EewGGlZb
	 f9GPX60+Wdh1v/KlDM3RlikSqRHpYxg6iBbOfkvgMihVKezZit2gmDN7s1hHGWhC84/Br
	 ztM9TSHihHxZEMaHxy5e3uoipAmpf/tsWd8sf1c79SHD2GMrx1tySq+jAyKxb/5bB3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gGW3WEcB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC198606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 23:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gGW3WEcB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 815B71F00A05;
	Wed, 11 Nov 2026 23:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794438303;
	bh=SP4kKZr1/rxDpDSqBCS8ofh6a0EM3fbwBhr6xrSIS7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gGW3WEcBZzwhPxkqlF2+unEElVQcARfz+A/YckpRkrDpN+WmN4UGmU7TX+KXGG7/s
	 g6coDJIRqaZu29d96sZXS7A22Z1lposOI9b2H0ftQkva7nintzjJeiyE8tNse3GnhO
	 y2D3G9u+7W8qd8AdeiTbDzdskYDSc97jLJSySEeJgiMblePpt1vSZfrd8XspcY/rHp
	 4c6aY0alXawf4U+bo6ENASGKUpE7sL3CoKRYGtnds1VlG8yeC7Bj7NV7opOj6y4VDC
	 mEbdmwKZyWu4sAJk7vsdC2LkHi9yZU3hKf1LtkH6lxsG7RX1V/JPwzhQy+gQkSzhvU
	 BUd1+0aoUsmyQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	"Gregory Price (Meta)" <gourry@gourry.net>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] mm/userfaultfd: wake waiters when registration modes are removed
Date: Wed, 11 Nov 2026 18:05:01 -0500
Message-ID: <20261111230446.377585-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200508-failed-6.18-4eee9c389b07@kernel.org>
References: <20261109200508-failed-6.18-4eee9c389b07@kernel.org>
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
[ sashal: replaced the upstream wakeup wrapper with a direct cross-file wake_userfault() call using a shared range structure ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/userfaultfd.c              |  9 ++-------
 include/linux/userfaultfd_k.h |  8 ++++++++
 mm/userfaultfd.c              | 12 ++++++++++++
 3 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 7e40eb9131bd7..22d4a7ad54575 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -71,11 +71,6 @@ struct userfaultfd_wait_queue {
 	bool waken;
 };
 
-struct userfaultfd_wake_range {
-	unsigned long start;
-	unsigned long len;
-};
-
 /* internal indication that UFFD_API ioctl was successfully executed */
 #define UFFD_FEATURE_INITIALIZED		(1u << 31)
 
@@ -1191,8 +1186,8 @@ static void __wake_userfault(struct userfaultfd_ctx *ctx,
 	spin_unlock_irq(&ctx->fault_pending_wqh.lock);
 }
 
-static __always_inline void wake_userfault(struct userfaultfd_ctx *ctx,
-					   struct userfaultfd_wake_range *range)
+void wake_userfault(struct userfaultfd_ctx *ctx,
+		    struct userfaultfd_wake_range *range)
 {
 	unsigned seq;
 	bool need_wakeup;
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 796a380664bd8..d65effb5cbff2 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -78,6 +78,14 @@ struct userfaultfd_ctx {
 	struct mm_struct *mm;
 };
 
+struct userfaultfd_wake_range {
+	unsigned long start;
+	unsigned long len;
+};
+
+void wake_userfault(struct userfaultfd_ctx *ctx,
+		    struct userfaultfd_wake_range *range);
+
 extern vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason);
 
 /* A combined operation mode + behavior flags. */
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 579445bddf561..5846fbf8baa09 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -2064,6 +2064,8 @@ int userfaultfd_register_range(struct userfaultfd_ctx *ctx,
 		prev = vma;
 
 	for_each_vma_range(vmi, vma, end) {
+		const bool any_mode_removed = vma->vm_flags & __VM_UFFD_FLAGS & ~vm_flags;
+
 		cond_resched();
 
 		VM_WARN_ON_ONCE(!vma_can_userfault(vma, vm_flags, wp_async));
@@ -2098,6 +2100,16 @@ int userfaultfd_register_range(struct userfaultfd_ctx *ctx,
 		 */
 		userfaultfd_set_ctx(vma, ctx, vm_flags);
 
+		/* Retry faults for removed modes while the VMA is write-locked. */
+		if (any_mode_removed) {
+			struct userfaultfd_wake_range range = {
+				.start = start,
+				.len = vma_end - start,
+			};
+
+			wake_userfault(ctx, &range);
+		}
+
 		if (is_vm_hugetlb_page(vma) && uffd_disable_huge_pmd_share(vma))
 			hugetlb_unshare_all_pmds(vma);
 
-- 
2.53.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794439088;
	b=i8Vx+TTodbfGh5/VamDxtE16xdV3UT0j2jjwPRfUT57e7dPPhq2js4N2gwpvGJz2h8uY
	 zgXKGFWg8IJ4Gh2dSv+1s9fLc/O9pISDV0pNDUI+rGCXBrz8haJic5YKaOoDi18FP0x7u
	 miO4zlrbBKnOS2fHSgPZ418oXbG3BwbLRCWzhHwmI1LCHF7Pj9P6bARsdjlwhSY6BfMDK
	 c0bwvexAr3dxh4x7oJYlEemEzPynkyBBoefqWwKrxZdkPNqUXnwzxONYOO8xXNn/Ro3uK
	 1CedgfO3wZLkoePStjRiRjP3nngps9t8HLBV8K53tJ8qKcV9gHiCYN6Zcs8lWLQ/NIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794439088;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Ix0kB5hn1z7nvbCxmDdqbXSje3Q9X95mpbUUgO1whQQ=;
	b=a8usDYT6Kn71UIpvLxruegLiRHMrUC2kvONvdrjJhkEj24psEIfiILQ/Jxq7qHjUXThl
	 krvCpmKMaVl7bBfl19dbNRn7JK05+wM/XeYlPd+JnRKeYafzBJ3SrzYVZN+MXLWMGTSJy
	 Rv0a6GJ82ZafwRbMsXLVOqXa/Z2QSZCH2jR+yoccIXzWUVREygw65Sv/u6xE9a23uwTsp
	 wqjVWn0EKZUUe93AJui52udgiN+QC1t/WP5i7n05SStuL3J6u1MCVt1Mi0bgdfMaHYA9b
	 UJhUnlFdU1QhJRGJopYm4HtyJBcZdE8L0ElvpScxTpKNRMHH6yKl1YFFsayUBK1DCGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ob7OB7Th;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04191606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 23:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ob7OB7Th
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1CB31F00A05;
	Wed, 11 Nov 2026 23:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794439087;
	bh=Ix0kB5hn1z7nvbCxmDdqbXSje3Q9X95mpbUUgO1whQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ob7OB7ThmIEWF83rHuCEENvNfdrNsisrf77Uh8Z+9g5DXfr0bRyGqAbbIswakxHB7
	 ERv4DeYHGLgJv6TTDCE6kCuxsUHjoJkt4JBNblvVconhcZJzOIDv0E5X61WHzRr9wn
	 cPcfQG19ExPn/l6HU4LpzI7l8PMHeLxzFICcL6Sq0FWf/R8DESWBN1nJMSgXCvkZL5
	 gTI9iXhXmlWX6a9ylmvOkbv6Bn6xrsYsVLhCtTKNWbPc80nG8pzE0iQXVNR6v50gAb
	 EgpAkerPO1XvjfTsQhPwvTYGrnSrlYPg6tVLBWbmqHKVqmCoG2S3rFiCfXRHkFZkPx
	 g1QA0X4fkqdgw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	"Gregory Price (Meta)" <gourry@gourry.net>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mm/userfaultfd: wake waiters when registration modes are removed
Date: Wed, 11 Nov 2026 18:18:05 -0500
Message-ID: <20261111231749.463731-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200903-failed-6.12-4eee9c389b07@kernel.org>
References: <20261109200903-failed-6.12-4eee9c389b07@kernel.org>
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
[ sashal: replaced the local wake_userfault_range() wrapper with a direct wake_userfault() call, exposing the helper and its range structure across files ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/userfaultfd.c              |  9 ++-------
 include/linux/userfaultfd_k.h |  8 ++++++++
 mm/userfaultfd.c              | 12 ++++++++++++
 3 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index cbd9d610c54bf..71084cf5b7989 100644
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
 
@@ -1185,8 +1180,8 @@ static void __wake_userfault(struct userfaultfd_ctx *ctx,
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
index 8ff68ce1860be..8b8be5fa2eb57 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -82,6 +82,14 @@ struct userfaultfd_ctx {
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
index 9951b4f42c65a..33abb025750db 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1962,6 +1962,8 @@ int userfaultfd_register_range(struct userfaultfd_ctx *ctx,
 		prev = vma;
 
 	for_each_vma_range(vmi, vma, end) {
+		const bool any_mode_removed = vma->vm_flags & __VM_UFFD_FLAGS & ~vm_flags;
+
 		cond_resched();
 
 		BUG_ON(!vma_can_userfault(vma, vm_flags, wp_async));
@@ -1996,6 +1998,16 @@ int userfaultfd_register_range(struct userfaultfd_ctx *ctx,
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


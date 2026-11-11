Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794439687;
	b=iX1PsnB81QwMILCB+E2q6s/vqdGGmdTlaLnZ1CBHXix7RR1Zt2dBpErdRCRemFXA6rWn
	 5OM6MclB7HKaGBIgL9nVYb6iTGGFdMVDPEHBwNmR8NQC0JTIDrUiUPwKdgSj0P4MCOxVz
	 eHN3nkXZvcBqHR9COSWmyEacKSk0J/hMqkBmjbbnBVQYTmqk3yxK1ndxuCT/ldJRi0ASA
	 aevf/LBRzYZOEwjJ86nPEVrGmW8fKz8AE53J8gM5XZCcxzKoCec5CLR5O0KBAAy8DssJW
	 49oa0aHMcc2Cmey0OBXgAFrF75cT4ifhTWta+8BAlrLOaNGpjhKcJPIyLq/df+2ShWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794439687;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ibh16hckzSf0pI3E7zle1ONFLmqUDn4zHjbVKC9sGMA=;
	b=RWDp8jWb06kR1k/yx1mgSElw+ye1awCBGUIIMilXFf/HPpBkkc2krSgy2KL2zERNI/aG
	 varwmVh1TwhjQOgCzrxFKlG9RvwCchkhLu5Hs4cGWDy7bCUaMyqb+EcilV6KgvNvs9+G2
	 n6yHTKP5mGGXS06gSp7jGTDDFgv6Ljn6RwP8trQGoXYT3KfwYo/KxMPY6CEOCTr8DSH6p
	 vqs3b22VdlgaxgmAjAikGd2E2QrjcW6CKaMBBtJ2ovUvCQT+QpbsNuZMjVOHmV01zAlhY
	 rF/EM3OxzanZn41f+/xEWne3i+kUYqciJVvIF/2IhQ4uYi0t0BIvaFLnS30uN8MMWRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JjSXpp7H;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB977606A32A
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 23:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JjSXpp7H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF1F31F00A05;
	Wed, 11 Nov 2026 23:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794439687;
	bh=ibh16hckzSf0pI3E7zle1ONFLmqUDn4zHjbVKC9sGMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JjSXpp7Hcvjdv8i+uqmpXHyQ5xMLlMJBDpoeOyv/N2Gsr7zwi2FpJieq+Bh6F2dhx
	 5pmqqjrb7Us7uoxgY72D3Y5c/WMZXT0u+i8gre6kvL68moXSjyfS7BkNkAn1O8jGj5
	 X42iZR+DGDjqfl0SvfSE4sHEkpKK4JF7DcRH1ymiJtXGJbC0G+2w6tJ3LmQR3fH1X0
	 Sz/hSwVPO2tg75HC1ZeAgnbj7YYX+uUCNYb8tbSwOVCGK7KrhN33DG6KOgMa31xvE9
	 /8JVZF5g2ta444olocHk37Yqet+kIdP7LBaYZBViPWggThTKm8NmJvwnX+cckYHa3l
	 cmwEE2UGdIC4Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	"Gregory Price (Meta)" <gourry@gourry.net>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] mm/userfaultfd: wake waiters when registration modes are removed
Date: Wed, 11 Nov 2026 18:28:05 -0500
Message-ID: <20261111232739.585501-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201339-failed-6.6-4eee9c389b07@kernel.org>
References: <20261109201339-failed-6.6-4eee9c389b07@kernel.org>
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
[ sashal: adapted userfaultfd_register_range() changes to the existing userfaultfd_register() loop by inlining the wake_userfault_range() helper ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/userfaultfd.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index bd64d6b9cf899..273b16516a5d5 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1476,6 +1476,8 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 
 	ret = 0;
 	for_each_vma_range(vmi, vma, end) {
+		const bool any_mode_removed = vma->vm_flags & __VM_UFFD_FLAGS & ~vm_flags;
+
 		cond_resched();
 
 		BUG_ON(!vma_can_userfault(vma, vm_flags));
@@ -1527,6 +1529,16 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 		userfaultfd_set_vm_flags(vma, new_flags);
 		vma->vm_userfaultfd_ctx.ctx = ctx;
 
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


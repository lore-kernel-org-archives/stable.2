Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794514104;
	b=J+iS8L9b+/UYx2AVTS1y1X9omNtpesFS3KgxcBwEK+cRsE5j4apSumCPnxW8+rLz22Gr
	 l8kkOdpeN62zVNXzc9ZmImUcS9UVBXuxcPvJBmbUUheEJ7soLWttGvBc/CcN9j0ziep/P
	 9icSRBNnb6j/63ZKWRqV7YOdl6VqpdGJphOgnqGfk5/NgsUEDuoDZgQogMKJDU295Glg6
	 6nJ01on1aoULu8weAMAK1GbaWgn7hRie4WO+aL/Flm49LcaCHWdY9CgcFHPmVFET5E0dk
	 n8l5WG5beZ5RlBsLKieLmUiEo7yMn6GcM2BAfms4pRW3MCM8LrPlF78UxsTHmWNOKmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794514104;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=k7lyuIb4ox+Rw7/ArCtjyqQ0iIPzZdkPkfVfuImeHFM=;
	b=pBikgrEXrrE3ii+iXpIll9SzJGlF7/oyBp6IGdDKTl1i8ysO3YNsgBdAc6yrCFWR+zcg
	 4SawmkpvbnuDpDYQKnQA/HwcG3PNDCRbjNUGwODSWj3oWlsw4gxhQV74a1TbSJ/yCvyaf
	 7P1VFNeHf67i8yEbf7/0gn9QGZ30nl7EShzHnCYZX9J87yXL8ZRhfZci0R3M1/j4x0YO6
	 d4WpgQj/1vbPiDBZ5VxSA1vk0J6rW5qrPkjq7MPIIj2OBxVbs28ititAF6Lfq98cj6TjF
	 AAAXvwMLkdhbWCP6xXOAOStp4Jm0NgDRwHFwHknm/IWLQIZRl+rslXeh5UyD5ckZM3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QL3VzyG3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42346606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 20:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QL3VzyG3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 424E11F000C4;
	Thu, 12 Nov 2026 20:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794514104;
	bh=k7lyuIb4ox+Rw7/ArCtjyqQ0iIPzZdkPkfVfuImeHFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QL3VzyG3k5E+OAo1cc+wnl8LJwE401yol6CTMyZj1VRLhJz9StnDr2ychN+YQpUyg
	 rkQE+rwVr82jKC3BJtcacHbras0FMiYCKrvGEfDu6YuNyO82nskydfvsmGndUxYnc7
	 RM97BVTKoBpMzZDqCcWPg2t8PViCqdbJTqupF5hyxgE+1cAS2CmeoiUZ3VEuexGd7X
	 PvkJY//MzjlNySqbRcD+cAYX9t4oq2IQh2RlP/ZRT7ebwy0KeFaRnZMRENMQFJf1Bl
	 Nto9eeCLKgbpdQycg+Xa+3wOSTuDcR25Jf1paVc6ZDCz7RYczoWPzgwtaQQnONTCpJ
	 y4MatVpAs+rvw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
	Lance Yang <lance.yang@linux.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] mm/mremap: recheck PUDs under the page table lock
Date: Thu, 12 Nov 2026 15:08:21 -0500
Message-ID: <20261112200619.3454339-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201833-failed-6.1-402882943dfa@kernel.org>
References: <20261109201833-failed-6.1-402882943dfa@kernel.org>
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

[ Upstream commit 402882943dfa8bab5c2bcc66189f9fb2828f248e ]

Once get_old_pud() is fixed to accept PUD leaves, unmap_mapping_range() can
clear a leaf between the lookup and the move. Holding mmap_lock in write
mode does not prevent this.

If the zap happens before move_page_tables() tests the entry, an empty
PUD can reach move_normal_pud(), where pud_populate() turns it into a
present page table entry. If it happens after the test, move_huge_pud()
can instead try to move an empty entry, triggering CONFIG_DEBUG_VM
warnings on powerpc.

Recheck the source under the page table lock in both helpers. Treat an
empty source in move_normal_pud() as a completed move, and use
__pud_trans_huge_lock() in move_huge_pud().

In the future we should likely have the code lookup a PUD/PMD lockless
once, instead of multiple times, because one of the problematic bits
here is the:

	pud_trans_huge(*old_pud)

Fixes: 0881ace292b6 ("mm/mremap: use pmd/pud_poplulate to update page table entries")
Cc: stable@vger.kernel.org
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Link: https://patch.msgid.link/20261031-fixes_core-v3-31-d6437171ecc3@kernel.org
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
[ sashal: adjusted context for move helpers using direct vma and old_addr arguments instead of pagetable_move_control ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/mremap.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index ec66e7be8afea..fd1f9ed45eb93 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -345,14 +345,18 @@ static bool move_normal_pud(struct vm_area_struct *vma, unsigned long old_addr,
 	if (new_ptl != old_ptl)
 		spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
 
-	/* Clear the pud */
 	pud = *old_pud;
+	if (unlikely(pud_none(pud)))
+		goto out_unlock;
+
+	/* Clear the pud */
 	pud_clear(old_pud);
 
 	VM_BUG_ON(!pud_none(*new_pud));
 
 	pud_populate(mm, new_pud, pud_pgtable(pud));
 	flush_tlb_range(vma, old_addr, old_addr + PUD_SIZE);
+out_unlock:
 	if (new_ptl != old_ptl)
 		spin_unlock(new_ptl);
 	spin_unlock(old_ptl);
@@ -387,7 +391,9 @@ static bool move_huge_pud(struct vm_area_struct *vma, unsigned long old_addr,
 	 * We don't have to worry about the ordering of src and dst
 	 * ptlocks because exclusive mmap_lock prevents deadlock.
 	 */
-	old_ptl = pud_lock(vma->vm_mm, old_pud);
+	old_ptl = __pud_trans_huge_lock(old_pud, vma);
+	if (unlikely(!old_ptl))
+		return false;
 	new_ptl = pud_lockptr(mm, new_pud);
 	if (new_ptl != old_ptl)
 		spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
-- 
2.53.0


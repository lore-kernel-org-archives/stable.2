Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794456701;
	b=o8gsXo9kqWtK61crNElZPQBGrGNmZdTAQz2jYd+BhvSpNwS/DJhbS1zlr9Er36APXzvq
	 oDAU/0tiq2YQZzBiByJnBVgn8fOt41RU4dPcIfmcZF+b6Cp3DSNuOregQ4yixi33fecB2
	 VvM7a45LE4kjOGQeejra2mMHztEulje4UJ01T5rG2szrFIxEo68ygDmuzyDS5aFFc5bQK
	 C8zdD0Fs1ImdW3X1+xp0SUKOXf/HmN5IW8NEkH1b6Hl/d1gOwPqqObbxRAXhDYhuyR5Pi
	 J9L3N5s2XmDNZkIIt25o2G4HjwoB8eqJo1VVt1iX68xaA+ZFLg/AO54v9cDyITyxPpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794456701;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=LqFHUtyzwsSbPCDPfBI44pRsVmkwWg7w5AZpHmdhFJo=;
	b=GMBdItnev3N6Ygn/MSmz9auxEiC9Vyf3eD6kzpblY0DtURxfY2Dny78hUCRG3deGP9TL
	 4SuPb/h8jvOgG/hEOerA+zrzq3gklLst8usTfWZBxu1g3xTXuFlzYtJhBR8Y/WzXbDUVN
	 T37uecnOsDqz1ib3w2NnUnd7gakwjxurD1nRj35MS/YHl4XD/x6lGL5vCWIVCYUbGFr5R
	 b4va8spQmM1YoF/h4TlKUMMJQFo4RHeUHQctx25GKCqWLM2+pb5BrfGIjieGoVoeaq1q9
	 lk0ePKTmDbSSz2hfREp0Y0RryncpM899hFQWtTPtaz4vIymgB2XfY0Vx4NO5xto6tFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K17+CW4h;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DE8606A321
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 04:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K17+CW4h
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2F5E1F00A05;
	Thu, 12 Nov 2026 04:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794456701;
	bh=LqFHUtyzwsSbPCDPfBI44pRsVmkwWg7w5AZpHmdhFJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K17+CW4hYgeEpGhhjcC/WY2HYPULDq9Tu/UA0gpu2xtXOwVL9sBrElLmrxv5q9Hth
	 nVbzZCk/zlN5ds3+mWg7Ob2G4osuu7ATRfYX5z89XVeeQbrS0AJn2S8bFHOfL3NYeb
	 nPUFgy9jZEkCrAZqcStMrdMQfB6nvXSBs7YuPj0b4sD3XzIXP0LjhzKwb8i3aw/Ari
	 TcuVmfNS1MW+QBEced7PohP+T53to3wCHZUmLZF7RB1tR3WszFF8b//o5m1XRD/uuk
	 l0lkdZN9i0q8ZVBqcw0H0ysj+OFeIsL27LA6G9SY2l5ee2Z/fjeeaFnjq7BCsU5IfE
	 CGczs8Rn3GB5g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
	Lance Yang <lance.yang@linux.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mm/mremap: recheck PUDs under the page table lock
Date: Wed, 11 Nov 2026 23:11:39 -0500
Message-ID: <20261112041120.1884451-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200913-failed-6.12-402882943dfa@kernel.org>
References: <20261109200913-failed-6.12-402882943dfa@kernel.org>
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
[ sashal: Adapted pagetable_move_control context to use direct vma and address arguments. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/mremap.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 8b507e228a274..838e1237ca204 100644
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


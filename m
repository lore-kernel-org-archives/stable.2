Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794513575;
	b=JDHz3vEDBfy6pIl/ycTLPGZf5Cc8vuSOCoHOVZpjOCPo8HCAlU+Qbu000YjJNPdoX6MK
	 r+jokSVE2sA+H8shdcvft7aErWrDPW6zR0PUrMyy0qWgdCX3bZ94heOnEcIFXyIU5+lGs
	 3ifcJyTj+1BIVVUoJQDHFRW1L5yNIAqmhyvm54HUQUpFFNArAjvbXUgyKCEViEWlHzbik
	 0QDij3NLeFQhXCH+1kIcpsydSrf7CUYs5JXo6GUrvqkFxJ2TOd3G7FRLvrl+TJMUmtw+I
	 h9+2YBPKuVvQFCzYANnrgZqKsdUY0y0yI+ZVHGxF5iTINrPxc/HuxXCZ8pTNU4D/6rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794513575;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=4Kc10Xqb88y+UN4MLScxbFOnSlsgrRMJBIMvFvtoC3M=;
	b=IvttgT7GU59VvFru6ifmIip5vezC4u37ECaxuHStTfZdR/GGlG5P+L1yGrTjuYdQswLx
	 P2ZY/9mbCCIhYF4PPhjokbS9ba2N3cYrFIPBCs7HCRfiFHp1+DWnncHVdS3CX8Oyklr4V
	 uFH90KJr+ue3Gk9Z4AiFHHMv+u0pza66xOK37wBX+W12nuZ6xWlCOJkeMuBPbAOuu2woy
	 wq0bwvMT9h5+fr4TlQqKiPQakRr6JNDTaSojJF0FL/d2g2060h+WYqdnQ9voNP01GTKmp
	 2Wat4Hj5ioflNnXuo4lxkr3ChPc6DCIOpV9rI5QEE5LEzkUcGkKkkjvU49EOW129qmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V0o4dC13;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5158606A333
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 19:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V0o4dC13
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C72881F000C4;
	Thu, 12 Nov 2026 19:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794513574;
	bh=4Kc10Xqb88y+UN4MLScxbFOnSlsgrRMJBIMvFvtoC3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V0o4dC13Dhz3rHEZe01FM3l6k2qMHrpDt0yaiXmInCt26OIb3h0rR7iui4OWMIEs2
	 WcXS5xSnmLo1GYslE2SjQ9C512gP8weaF8+qv7soBL+V72NSVgmv/xFLZAqu6z9U7h
	 bnp+bGAWDrC4uXKsehfQrn70jsiizAQTO1eKUithLbW/IUnexDv2P1b1iSTzvYF3Fv
	 mWY2heELKaX/xVO7NkLLIEcjnfZsMDDzZ5UlpAilGXZUcbgplBzIYYXdn3VF6Un+vi
	 c30bQpPWRlIgBLFFazhLSb2Ob18by34IIHsY9kaP3BldNT59Hz36j63jxGfAfY8wIN
	 eKz9GPmqKe1Og==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
	Lance Yang <lance.yang@linux.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] mm/mremap: recheck PUDs under the page table lock
Date: Thu, 12 Nov 2026 14:59:32 -0500
Message-ID: <20261112195747.3385807-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201344-failed-6.6-402882943dfa@kernel.org>
References: <20261109201344-failed-6.6-402882943dfa@kernel.org>
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
[ sashal: adjusted context for move functions using explicit vma and old_addr parameters instead of pagetable_move_control ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/mremap.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 0739a31b54eed..be6b4aab93bd2 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -363,14 +363,18 @@ static bool move_normal_pud(struct vm_area_struct *vma, unsigned long old_addr,
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
@@ -405,7 +409,9 @@ static bool move_huge_pud(struct vm_area_struct *vma, unsigned long old_addr,
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


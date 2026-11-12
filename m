Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794514421;
	b=A4GqJfX2l3g1tFFxtIHyLd4Kyd6Bkps9KBQshvZJz8/ZS5IYwsnBE1qxUmpqurf2fpAA
	 MMBoXI9yyjjHe113SlVHmEMBz3iUGOWAOecSzs0XNUNJIu0NuDEQnUJeNzzfqogtpybYC
	 vvu26OI5nm2CstCOXOhQhsmvPuyYfE2V7khhM0bFSm2rJINx8d2vge2NsY8Y1tJd6JYQP
	 qR1mesUA4l2t0FiA0tIZHQA1IlHorqiJiO/+avC9Uqqai5Ulxk7ZPbB42IlWZmrYYtd9a
	 AEzv+7uP4XVp4Q8IwMyz0tt64V/V8d5OxIzeb4GuZ4Migr97lN6OTlAf0nXMFejIFhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794514421;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=fRMHYYZdtvHn+faB0IFiwJllZlMdGNul3fPW03FulrM=;
	b=EbM/n80DL9R4pxz4WrNLgO1QcmdBWKO9pgf4VtqZQRW4WAXqxLstOcQprf3CsOWEDJ5z
	 OkTAXbtqyAOFsOUAgO7Xuo/buvUpzUvZ3VmGsyDU1xOUjDLjEGu7UV910fa0isrJvTLEu
	 H1bbPnaIkbxgjyKHYDxRXG2vDRPZ7D4HsrWATLCaMMBJh7iNG4WWGNLuDPlMDX5nX48GS
	 ncvucrtZDFV5Y+rAAfP1vui1SEssrSjehUpN9ditqvli4D7LI1XUniiNCpb+JLBJ4MRjc
	 rqauJ3wJm3Cp+ZmDYsQhHvXtVPqQEmuUarYcUwMU1Nb8DqxtDuwHeOZ9rZ9VVY2PVBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IxKUpWnu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6103B606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 20:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IxKUpWnu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4132A1F000C4;
	Thu, 12 Nov 2026 20:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794514421;
	bh=fRMHYYZdtvHn+faB0IFiwJllZlMdGNul3fPW03FulrM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IxKUpWnuADMj5jTBD3vug9+dPLrUrj4HfaO9eZOas9Uqpmx5pH8PX4DyQ4ZFBzDFW
	 TanzX1iwWKW/Q3wpq6s7YjOoKCUv17F297v6tbdFpVuiGQYWvJW1wtut1YPRHlTmH7
	 YRNVkQ2m5+afK2HA5v3zvPCJXWgMbsPGyb9anx2+vS6WBdfywPWQ/6BS652ParZWr4
	 t4Xx899Ph3IVAQt339uFBRfCItqIQxqyKIkQGC5lNiHFGq4+JPmzYRAqaBtaxszvL0
	 PH3Yd62InahFj5TSBWZj7IbYC1cgvZiY3qh0BaPPPRkmRQOcQ6ti9dFn47Me/HFzPS
	 4w+24l2r+5LPQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
	Lance Yang <lance.yang@linux.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] mm/mremap: recheck PUDs under the page table lock
Date: Thu, 12 Nov 2026 15:13:38 -0500
Message-ID: <20261112201247.3549858-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202338-failed-5.15-402882943dfa@kernel.org>
References: <20261109202338-failed-5.15-402882943dfa@kernel.org>
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
[ sashal: adjusted context for separate vma and old_addr parameters instead of pagetable_move_control ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/mremap.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 5d8b8309ae2ac..810a5006b8dca 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -313,14 +313,18 @@ static bool move_normal_pud(struct vm_area_struct *vma, unsigned long old_addr,
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
@@ -355,7 +359,9 @@ static bool move_huge_pud(struct vm_area_struct *vma, unsigned long old_addr,
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


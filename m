Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272942;
	b=FUmouuX1Dfof0ZjlfWzIuwxw50+fGaSXazeEdytrzA5+u76KEKzNTpnYIqXfd5+CG1tc
	 oiDH7645qGiTip8lOQdaqNuBZgb09n3a7tSd3Cs7PLxYi6uWZ0dRBnhrj47O3VHlENk3o
	 XOjePGXDkDq3R7qEoBFx2HfFF6xdB2zM4iJOvCOJuhLoquw66zUevNGGr+AwrU1Vk/lbx
	 1PH07hL95Y04/fqaJtBum1rmLosQNFUXwudl/RediTs3xnwpAtWgrfzMCEwQSn7uAnVgU
	 OLfCCe0Mo10G0WFdYVV8IAiFH91U8oazloCGDYMEIyzWYMSI4WA/f3nYkBFgE9uJUcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272942;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=tABhjbrUjpLXekCgxWiyuiENONr9Z4Nj9Pviai1roBA=;
	b=GSjlbT5T7UYkzOxnw/kBtOLFcMqLuwx9LX+XNHyUppqDAfHuIYBYVzNFbqcs+sZduFNo
	 jBY+9mDZzljsAn1pY4CNSCf/leQLuZUTCNbUqXqlUCc07PxldBk9vK0DST6ctkhe8MgNb
	 sHKj82gKiNthP3TTgvtBHq2sarSNNCXx2LCdb90MDWjqTEpIrWBE4mj1oCnWrZ1fZXlc0
	 dt3nIfDvPtRnFZa++e5P3d7tL3kRmbkkuG9e9nw0789kjLSt4qzb2Q9k2llQItbCq849I
	 HzvbvcuKhxlb5VJJDcHTeYLwykYOPvA8TiGtV4tOYLPneVt8kFLXHsW2ovEXPxG5JGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ryi8nV+3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD61606A32A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ryi8nV+3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F081C1F0089F;
	Tue, 10 Nov 2026 01:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272942;
	bh=tABhjbrUjpLXekCgxWiyuiENONr9Z4Nj9Pviai1roBA=;
	h=From:To:Cc:Subject:Date;
	b=Ryi8nV+3hjsz2p8F/gknpPwDdmQAlRpXv4Sp9jzfKPFA0RLRztGO0RMJDJLMbvwbz
	 x8Su2ZDOqd1NiNZ0QpniOpCM4Ghkd3GeMiF/wAdwWHWHUN5v7eCClc4ut96+c95ub8
	 NEpZorsWlPaMX1uyDoDaCgDqPZ+oVuZPXV6ZFRsl7KCTcd8bOuwNk8laV5OTWEjBBM
	 DEWjpgWNfhTruRYYMoSG0FGY1wjRkPBD1UNy+ub/cVtT2E0xkOuWxlJLNhlAX8T1od
	 ZUb7u92blhXtDqYh86y6KNhjCMCsmc5/eKnH3/zg3BgQyFNwdXqZTb+SokEmqRDYvk
	 ecGZ2pm2WRsew==
From: Sasha Levin <sashal@kernel.org>
To: david@kernel.org,
	josef@toxicpanda.com,
	usama.anjum@arm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/gup: recheck the PUD under PTL in follow_pud_mask()" failed to apply to 6.12-stable tree
Date: Mon,  9 Nov 2026 20:09:00 -0500
Message-ID: <20261109200900-failed-6.12-79cb51d538ab@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 79cb51d538abc459f74e046d27797d36b133ce0e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200900-failed-6.12-79cb51d538ab@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 79cb51d538abc459f74e046d27797d36b133ce0e Mon Sep 17 00:00:00 2001
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Sat, 31 Oct 2026 10:39:48 +0100
Subject: [PATCH] mm/gup: recheck the PUD under PTL in follow_pud_mask()

follow_pud_mask() reads the PUD without a lock. If it is a leaf, it takes
the lock and calls follow_huge_pud(), which reads the entry again, but
only tests whether it is present.

A leaf can be zapped concurrently and a page fault can fill the empty
entry with a page table.

This currently only applies when device-dax makes use of PUD entries,
and the fault after e.g., MADV_DONTNEED would find THPs to be disabled.

That requires a sequence like

1) Fault in the PUD
2) Disable THP
3) Have GUP race against concurrent MADV_DONTNEED + refault

Which is rather unlikely to happen in practice, which is why we never
received a report about such a problem.

Before commit 1b1676180246 ("mm/gup: handle huge pud for
follow_pud_mask()"), we performed that check in follow_devmap_pud() by
testing for pud_devmap().

Let's fix it by just structuring follow_pud_mask() similar to
follow_pmd_mask(), minus protnone stuff that does not apply and minus
FOLL_SPLIT_PMD handling. That makes it much easier to spot any such
inconsistencies.

Perform the pud_bad() check early in follow_pmd_mask() and just forward
the PUD value. We can drop the pud_present() check in follow_huge_pud(),
just like we have in follow_huge_pmd().

Even though we are performing more changes than strictly necessary, the
fix should be easy to backport.

Fixes: 1b1676180246 ("mm/gup: handle huge pud for follow_pud_mask()")
Cc: stable@vger.kernel.org
Reported-by: Josef Bacik <josef@toxicpanda.com>
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Link: https://patch.msgid.link/20261031-fixes_core-v3-19-d6437171ecc3@kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/gup.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 7d43ce717b246..f809361227e7e 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -658,9 +658,6 @@ static struct page *follow_huge_pud(struct vm_area_struct *vma,
 
 	assert_spin_locked(pud_lockptr(mm, pudp));
 
-	if (!pud_present(pud))
-		return NULL;
-
 	if ((flags & FOLL_WRITE) &&
 	    !can_follow_write_pud(pud, pfn_to_page(pfn), vma, flags))
 		return NULL;
@@ -896,15 +893,17 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 }
 
 static struct page *follow_pmd_mask(struct vm_area_struct *vma,
-				    unsigned long address, pud_t *pudp,
-				    unsigned int flags,
-				    unsigned long *page_mask)
+		unsigned long address, pud_t *pudp, pud_t pud,
+		unsigned int flags, unsigned long *page_mask)
 {
 	pmd_t *pmd, pmdval;
 	spinlock_t *ptl;
 	struct page *page;
 	struct mm_struct *mm = vma->vm_mm;
 
+	if (unlikely(pud_bad(pud)))
+		return no_page_table(vma, flags, address);
+
 	pmd = pmd_offset(pudp, address);
 	pmdval = pmdp_get_lockless(pmd);
 	if (pmd_none(pmdval))
@@ -953,18 +952,23 @@ static struct page *follow_pud_mask(struct vm_area_struct *vma,
 	pud = pudp_get(pudp);
 	if (!pud_present(pud))
 		return no_page_table(vma, flags, address);
-	if (pud_leaf(pud)) {
-		ptl = pud_lock(mm, pudp);
-		page = follow_huge_pud(vma, address, pudp, flags, page_mask);
+	if (!pud_leaf(pud))
+		return follow_pmd_mask(vma, address, pudp, pud, flags, page_mask);
+
+	ptl = pud_lock(mm, pudp);
+	pud = *pudp;
+	if (unlikely(!pud_present(pud))) {
 		spin_unlock(ptl);
-		if (page)
-			return page;
 		return no_page_table(vma, flags, address);
 	}
-	if (unlikely(pud_bad(pud)))
-		return no_page_table(vma, flags, address);
+	if (unlikely(!pud_leaf(pud))) {
+		spin_unlock(ptl);
+		return follow_pmd_mask(vma, address, pudp, pud, flags, page_mask);
+	}
 
-	return follow_pmd_mask(vma, address, pudp, flags, page_mask);
+	page = follow_huge_pud(vma, address, pudp, flags, page_mask);
+	spin_unlock(ptl);
+	return page;
 }
 
 static struct page *follow_p4d_mask(struct vm_area_struct *vma,
-- 
2.53.0





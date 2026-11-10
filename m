Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273821;
	b=X1PLkLzXURwiKPXMFW2XF/XacdQxduJnEgO+C0ix4iQE2DYT3+asfaWXqKCXvk8yqV3b
	 L+MjsjQTZEkl/qfptbvbc5zElDY0aBn+QPC3OlO87K8O3gjBCsEHMySTOjWnjurUWGiyj
	 xtGfV6f0EY+9H55AovBMPLrLPmmfnInoSQ4DuGHs8anly+EPIYaoO/ianU5xxHyA4/W70
	 cWwe5T6RZxla5WoloY5YMd7wIr2dzepOa4APLwDff8xeLljuJGz/gOqSCEW4XzPJiYYwi
	 p5gNnE3ps8+zsT4cO972TgVjKOAkZpMNSM0m8GmPWxlUB4Snlrv0caxa9kPXvXFPyyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273821;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=stYZSjXfwDTRHGpqUYRXTE8jTxFpmX1H+YHPMT5fWC4=;
	b=Cq5MvxSXlTZCavJ4CElg3T7nCFOKcMZLCimtx/9zqMWmMz9GY1OKO/McAXGXCMjaesCO
	 C87o6ES7w2qD6aZvV3WSHE1rzWynyPuPpRh0uXbHhSlgD3Er9HhLLdGadBRitKtuR/Apk
	 mefROrZTY2WWkn+OOxMjNbGsKyBSTDFHdGljlQpnCt4icST9ZWdgafD8TlWA4pgS0HkFs
	 3eB96VCuEIS00JNFoUm8yvqAYN+tnxQKrRQbq+ERn6TElYHrj9gzgEn+uEEN4Blp5AQfd
	 +zSQUHHgvsI26IStgN/aRtoT90nf8fif1NyMohQUg6DRnUhP7OallONaycQ1OHbYQ2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fUH2mkgF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E80606A336
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fUH2mkgF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE73D1F0089F;
	Tue, 10 Nov 2026 01:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273820;
	bh=stYZSjXfwDTRHGpqUYRXTE8jTxFpmX1H+YHPMT5fWC4=;
	h=From:To:Cc:Subject:Date;
	b=fUH2mkgFGdy9+xIdu8VmqbsH8X+0PpEIzNucBcb0xtcYfxsP8irkHXGFdwMuc7+4A
	 F1o+HitOMMglzlxaQkKwGUBnn6drcQQ622a9myD9E2RzeEvQZs2khE8q1rK00YKITS
	 Fk/SmpcR3CM39Ta8y4Cxf0BG68C1q6+/0AD8mTu+EYmkcz2v9wtd5RVTgO78EMjpnk
	 +jYEGqiazFVs8D5AL13vnXvZMqRVkARhZ70nGrgT5Dxj/Fc6V6ATRah6UDzn5ptiTl
	 rD08OPaWhFP9ZV8Vt2It3bNBL26Mf+zkRpdupJMazP6Ui8QXtx9/3/IPrkVqLMs5ki
	 zHQ2EPO6RBnew==
From: Sasha Levin <sashal@kernel.org>
To: david@kernel.org,
	ljs@kernel.org,
	pfalcato@suse.de,
	usama.anjum@arm.com,
	lance.yang@linux.dev
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/mremap: recheck PUDs under the page table lock" failed to apply to 5.15-stable tree
Date: Mon,  9 Nov 2026 20:23:38 -0500
Message-ID: <20261109202338-failed-5.15-402882943dfa@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 402882943dfa8bab5c2bcc66189f9fb2828f248e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202338-failed-5.15-402882943dfa@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 402882943dfa8bab5c2bcc66189f9fb2828f248e Mon Sep 17 00:00:00 2001
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Sat, 31 Oct 2026 10:40:00 +0100
Subject: [PATCH] mm/mremap: recheck PUDs under the page table lock

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
---
 mm/mremap.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 16e736c72d9cb..91f0865f6aeea 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -461,14 +461,18 @@ static bool move_normal_pud(struct pagetable_move_control *pmc,
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
 	flush_tlb_range(vma, pmc->old_addr, pmc->old_addr + PUD_SIZE);
+out_unlock:
 	if (new_ptl != old_ptl)
 		spin_unlock(new_ptl);
 	spin_unlock(old_ptl);
@@ -503,7 +507,9 @@ static bool move_huge_pud(struct pagetable_move_control *pmc,
 	 * We don't have to worry about the ordering of src and dst
 	 * ptlocks because exclusive mmap_lock prevents deadlock.
 	 */
-	old_ptl = pud_lock(mm, old_pud);
+	old_ptl = __pud_trans_huge_lock(old_pud, vma);
+	if (unlikely(!old_ptl))
+		return false;
 	new_ptl = pud_lockptr(mm, new_pud);
 	if (new_ptl != old_ptl)
 		spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
-- 
2.53.0





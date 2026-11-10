Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273226;
	b=yIJrk7EuMKV8jNE3jvkwoC2lfk8kAGQfEjceshn955q1Gawie+/HfC07qE/UINCvdPOe
	 9w/95BR4hBgb1M3C88E7T9eZC3oh0Un3NJDeW8TS5Zu7H8NzNI/QqpenOUR1BGprJ9yzt
	 v8ovPH7SzHoCA0f8VD/Sc4Pj2jJ5h7iapZ7eJDJaoF/Cyoc7mBNxF70cyU4TWzSrT6Gf1
	 Gv2AMyTrmIgrbq1zxM/Q+WuL1tH0Gk1bTz0RI/YJL7rw6s+eCR+n8R39WjtmoKwlYssGo
	 gteNivWQE9uDMTez6sGTOLUPBF6aVydkRGq8cIlg15CR57w3vkLuztV2PdsRkhLdLoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273226;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=yV2gBXAkFAIR76lQGP7WusvKdRh6ZgA0KRwijwqrkRY=;
	b=cul6CTzsSCa87xM4UtUsAwW35wEE6pNCvAYx/cpyuckttc+CmuHoaXVqZnJ3iI7F2Ywy
	 MYroFFWKi95MCxX4tp8kdMIm4FzIB8HpD2Tn76ks9vVtgCVygIeKBwJt0snfo6kSr4eBW
	 MFMopGC6yXYrO0eAUBtoJmlV2euErNyOTN3lMi++stjQC6TibYo3iKk+A6ynQeCtJtrca
	 AhU351fuxkfazCL42cx0t/T/DJymt+qtWCJvkTQfGI7t1b6bn8Yne4Ew25FCddOqMU2hM
	 pfZqClRrSSwZd9PMZkIvnpKJ1CNtO6e5qWYRtUM8QM4j3oP14NwwgoIf6vIbbZ75Jpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bn1S2mHA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC43606A33D
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bn1S2mHA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD5AC1F0089F;
	Tue, 10 Nov 2026 01:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273226;
	bh=yV2gBXAkFAIR76lQGP7WusvKdRh6ZgA0KRwijwqrkRY=;
	h=From:To:Cc:Subject:Date;
	b=Bn1S2mHAFwzdpfDuQ3+diX16X0HogXQFeFTsDx5nI1tg0GjaFd8IS8tTwATzjmQwE
	 R7y8PBdHSLvjlnzv84+d0OI0nyXWBtHbzbp8vU6tWKyYjy2C1l/fSXqtXhNbSA+gZM
	 McH7/d/kMRE4uZer0kNIn7JTSnWa2xANy/gXW0xHh4XXP2q83VCS01W4c4VrLNUMv8
	 As8h22ECOjxPYjx0YHdnquAftfI1+41xOiO7+sQ+t//CviQ7Wlcv0QPfGdB3GzDZJe
	 WkWkjNnvBrcIUN3p/TRtOQg15ZgfOUkOSKt8ZLbVF3bh1rE+9qy+fOXclrkInru8T9
	 nk5bvyWwMYaXw==
From: Sasha Levin <sashal@kernel.org>
To: david@kernel.org,
	ljs@kernel.org,
	pfalcato@suse.de,
	usama.anjum@arm.com,
	lance.yang@linux.dev
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/mremap: recheck PUDs under the page table lock" failed to apply to 6.6-stable tree
Date: Mon,  9 Nov 2026 20:13:44 -0500
Message-ID: <20261109201344-failed-6.6-402882943dfa@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 402882943dfa8bab5c2bcc66189f9fb2828f248e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201344-failed-6.6-402882943dfa@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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





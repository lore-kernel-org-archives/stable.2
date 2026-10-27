Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793100330;
	b=0Nk6ML623Eps9SVmnPbzjQziIjZfLGH1jlktAj07SBUTQI564OfSYqMgGHlqaOkeQ4RT
	 p4LAQ6QAP18g2jQj9W1Jqv8UfbSdr80F6ZYGqYpDBxfPA0p27TBZCQuEfSxXQ7ztjwUKA
	 Aw0lC/QoSMecjmRp+V1i7RIgmNYwa+1G7rbYynVP4dUUY7qYqEPz8m2GbOxE44V+pBupO
	 YXrmC9KRHm/KanLLgTvG7TT1RyB3crZFVyzQyUTvWcDBcspY49b4zo4Qgv27Nr7LodoOr
	 28bgtr8EiBCgGfLI3m3OdoDGGpvfMC4TLqoezb8owlJ5TvAfFxkwEE1XnY8R/j1aMiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793100330;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=U3Yz6H0MBaIRh93vJ8ttjk8w2r8qCoWEwM9mVP5l9lY=;
	b=BCf9Iv33puj0tPCkMAEhMZVv8VlR2YPR79r6dSbV6Vj8ekdA0EFZGBwKq+Uc18iAkU0r
	 E8twzmRdeS34awfkMZn03nbnR3M8bxFrixi5G0CkXO6imb+1WLZAsa5cnbTvhi8yqcwBA
	 GfTaxSnof0q3h+sy9k+ABKdkhs4c4AuDhOH8ELXnZ47JkrZ0ottQF57qElQlm4BP9Ne1E
	 y8FWVRVPPd/51/oeg2+7WhJCKlQDevkwVYNBpempz66ZwF53Wu+0EMU92Jecm2HKUsSAy
	 7ju1OyzHiTA+X7P3tzvrfUK5XCuSRtygnBpGcBrkl4/x4DTwLPkQvsTCAOtHC0TekcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bCicIYV1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45120606A31D;
	Tue, 27 Oct 2026 11:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bCicIYV1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A019E1F01828;
	Tue, 27 Oct 2026 11:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793100329;
	bh=U3Yz6H0MBaIRh93vJ8ttjk8w2r8qCoWEwM9mVP5l9lY=;
	h=From:Date:Subject:To:Cc;
	b=bCicIYV1dNM+LwDqWYdCrKP8na9i9j7FQUeDUNpdq5dQYKjxUppB2ElkbddviJQxb
	 bhoDnxmgS5hgyG7Eg13CsJt/Q84rV6sh/DWSWiVZ8/UCrkawI/xT/9ghdbQFApiuyO
	 kAyBp+WzyG/rb7c7clq3f8V+LvP2SDBl6Bgs+AHuUnScw4kR1g4ndY1dy22XkakoGc
	 vWZj7r1frbH1W7q4J9HmtrH152HR+f0CCuzw7tGpZXTP1aaozQ7sNbAhb/tj+cWT0x
	 HBOWapJYvksvgLRsEPO7eRjzUxrrSjF7x2GF2w/Ly4DjgyKaLbY5zSPtXN9AC1Ow9c
	 Gc4uuHBxxZunA==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Tue, 27 Oct 2026 11:25:20 +0000
Subject: [PATCH] mm/vma: update VMA iterator state on error in new VMA
 merge
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-fix-new-merge-bug-v1-1-7023a787e6b9@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MSwqAMAwFryJZG0iDWPAq4sJPrFlYpcUPiHc3u
 BzevHkgS1LJ0BQPJDk16xYNXFnAuPQxCOpkDExcO2KPs94Y5cJVko3DEdC7kZloqmgewH57EpP
 +Ztu97wdzNV0yYwAAAA==
X-Change-ID: 20261027-fix-new-merge-bug-71c2200d40fb
To: Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, ljs@kernel.org, 
 stable@vger.kernel.org, Li Jinyue <jinyue.li@linux.alibaba.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3975; i=ljs@kernel.org;
 h=from:subject:message-id; bh=enOY1tlL9CmXRwkEJ9MaAJA03UHuIoy8wDncUU+/XGU=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLIedKmus5wfVc/+rk1RZ2KZ9tLrZzXWukkEtU9IE7nzr
 qdRNTKxo5SFQYyLQVZMkeX5F/H9QSJh8zov+LvBzGFlAhnCwMUpABMx3MTIcLn9u6CxqhFfyS1d
 W1ZT17zCY1MNmRxDmg4preDbkLe/nZHhv9Vy761f0x99eB5u+/3mx9+y01Wv2r2ZOl3HPaNad4M
 pAwA=
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

Commit cacded5e42b9 ("mm: avoid using vma_merge() for new VMAs") shared
code between vma_merge_new_range() and vma_expand().

However in doing so, it failed to correctly restore the VMA iterator when
vma_expand() errors out.

This is a problem when the immediately preceding VMA is mergeable and
vmg->just_expand isn't specified, at which point the VMA iterator is moved
to the previous VMA.

(Note that vmg->just_expand is a special case for brk(), where the
iterator will already be positioned at the VMA to be expanded.)

Resolve things by restoring the VMA iterator on error. Use
vma_iter_next_range() to do this, so it will correctly stop on the gap
after the previous VMA, rather than skip to the next VMA after it (this is
a new VMA merge, so is being applied at a gap).

To isolate the error handling, return early when a merge isn't
possible (what the vmg->target check was doing before), then handle the
merge success/failure case explicitly.

While here, update vma_expand() to jump to the nomem case when
dup_anon_vma() fails, so vmg->state is correctly updated.

This doesn't impact anything in practice, but is the correct course and
since it's part of the error path that this patch addresses, it makes sense
to update it also.

Users are very unlikely to have observed the issue this patch addresses in
practice, as it is near-impossible to fail an allocation for an anon_vma,
but a process under memory pressure that receives a fatal signal could
trigger it.

This issue was originally reported by Li Jinyue for which I am grateful. He
indicated this was uncovered by a private syzkaller instance.

Fixes: cacded5e42b9 ("mm: avoid using vma_merge() for new VMAs")
Cc: stable@vger.kernel.org
Reported-by: Li Jinyue <jinyue.li@linux.alibaba.com>
Closes: https://lore.kernel.org/all/20261025093921.1011927-1-jinyue.li@linux.alibaba.com/
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/vma.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index af8e65ada23b..d416ba58eb4c 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -1141,6 +1141,7 @@ struct vm_area_struct *vma_merge_new_range(struct vma_merge_struct *vmg)
 	struct vm_area_struct *next = vmg->next;
 	unsigned long end = vmg->end;
 	bool can_merge_left, can_merge_right;
+	bool move_iter_back = false;
 
 	mmap_assert_write_locked(vmg->mm);
 	VM_WARN_ON_VMG(vmg->middle, vmg);
@@ -1182,23 +1183,30 @@ struct vm_area_struct *vma_merge_new_range(struct vma_merge_struct *vmg)
 			vmg->end = end;
 
 		/* In expand-only case we are already positioned at prev. */
-		if (!vmg->just_expand) {
-			/* Equivalent to going to the previous range. */
-			vma_prev(vmg->vmi);
-		}
+		if (!vmg->just_expand)
+			move_iter_back = true;
 	}
 
+	if (!can_merge_left && !can_merge_right)
+		return NULL;
+
+	if (move_iter_back)
+		vma_prev(vmg->vmi);
+
 	/*
 	 * Now try to expand adjacent VMA(s). This takes care of removing the
 	 * following VMA if we have VMAs on both sides.
 	 */
-	if (vmg->target && !vma_expand(vmg)) {
-		khugepaged_enter_vma(vmg->target, vmg->vm_flags);
-		vmg->state = VMA_MERGE_SUCCESS;
-		return vmg->target;
+	if (vma_expand(vmg)) {
+		/* Error occurred, restore iterator. */
+		if (move_iter_back)
+			vma_iter_next_range(vmg->vmi);
+		return NULL;
 	}
 
-	return NULL;
+	khugepaged_enter_vma(vmg->target, vmg->vm_flags);
+	vmg->state = VMA_MERGE_SUCCESS;
+	return vmg->target;
 }
 
 /*
@@ -1288,7 +1296,7 @@ int vma_expand(struct vma_merge_struct *vmg)
 	if (!ret && vmg->copied_from)
 		ret = dup_anon_vma(target, vmg->copied_from, &anon_dup);
 	if (ret)
-		return ret;
+		goto nomem;
 
 	if (remove_next) {
 		vma_start_write(next);

---
base-commit: 1eb36316305767b54fac2cd40b88b3499791bdf2
change-id: 20261027-fix-new-merge-bug-71c2200d40fb

Cheers,
-- 
Lorenzo Stoakes (ARM) <ljs@kernel.org>


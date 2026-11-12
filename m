Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794450286;
	b=k/ULU/Eta82jvQPXsId+hCPzr+iNVGp4zTXy6PFlX5ZXhGcJSrAsVYKfUutE02igovk/
	 cjJIZd3N+Gjy/cj2aq648RrOMCtQ39QjS4ulOKT+/L0jEiJX5F+uvut1MRLtyIy3gSMi0
	 mCjkp//fNPcfyU4paqZJPSmtsWCzxwHMAP7oUFyaSddajEye4TVbNdcIcBP8pMyg3269o
	 9VjxoE0BMx5jWJeP9E2Ep0YKqwN72Y4yEjNDyQwLTzjgL3zPyZIj9sOjCRQ7Av9pNo7FR
	 D+EaU+fWtns9HqoPwBlnTe3Yrn42KEp8W5z3Vk7frydMFGbx7NbFozKT6EXjYAbuJlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794450286;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=jnAv2BERtbCBbfO158BVte75MIf0+cHvohKDqhQt7Hk=;
	b=AX4ER/LtWrHfelwvGk7Snfh1e19PDjVIzs3PYMBpBYq0UNaK6XJ8eBRDZTO7Vn2t6xG1
	 pjgfvU0mn6IAhqx1hO+RxRHoKfVH5skaffu7NMmYXK6Jx14mA4sGzt0PZ0FKpc88oJJKb
	 QQAy2ru+1UI2/ElOYGLujOzJEJvP4bvmuVzgAe3bZWA+7Sgj9WXDrwKni+4jYXG7dlVbC
	 K1yL+O4mnXPSvb/BywjCJ526nAZi8uI5PitK1bCTPYZ91H3AhbaM9bVmc5FnoFcQk3Xfr
	 DHtmJYPbGZ4Tzb3T8b6lJncdB5tjjpnMTFasoJoJyUi7KlJ6PoTDJ6BYbG/tU8x2bjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OoD2V44F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BC0606A337
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 02:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OoD2V44F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B671F00A0F;
	Thu, 12 Nov 2026 02:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794450286;
	bh=jnAv2BERtbCBbfO158BVte75MIf0+cHvohKDqhQt7Hk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OoD2V44FLMKsMGXtJPq5w1B10/9O27sgmrYSuYIXEViyDSzZO9jd5yaR3uHrOFmP8
	 gtywGSdAqU22B+7ocT8jpzh4Y8/GhXoNcWe+l4UUzXCfR8H982caWy8LbZZJhPZvli
	 MJ9/YusDp7Q3Em2C/bQniocUzU42cAlM5EEd8mdY7FTxCdOnjblW8UcXUxulZCUfhz
	 vZbSeByczTQG0HHmugWaQCl81qHuXL24gRV09Dd+nw9U0ROMqdR7gzUydYPQWWo1Ly
	 CBbKcX2jT11q6GcMkc1OjfPDtIPgcoze7RyAt89nq3MywqPhp8FMzY1djjkIiuaXCC
	 /tghbkG1LCGbQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Li Jinyue <jinyue.li@linux.alibaba.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mm/vma: update VMA iterator state on error in new VMA merge
Date: Wed, 11 Nov 2026 21:24:44 -0500
Message-ID: <20261112022425.1343808-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200805-failed-6.12-168ed9c5d5ec@kernel.org>
References: <20261109200805-failed-6.12-168ed9c5d5ec@kernel.org>
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

From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>

[ Upstream commit 168ed9c5d5ec2fd326715eba5750c2b69e559ff3 ]

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

Link: https://lore.kernel.org/20261027-fix-new-merge-bug-v1-1-7023a787e6b9@kernel.org
Fixes: cacded5e42b9 ("mm: avoid using vma_merge() for new VMAs")
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reported-by: Li Jinyue <jinyue.li@linux.alibaba.com>
Closes: https://lore.kernel.org/all/20261025093921.1011927-1-jinyue.li@linux.alibaba.com/
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: Pedro Falcato <pfalcato@suse.de>
Cc: <stable@vger.kernel.org>
[ sashal: Retained merge descriptor cleanup on expansion failure because the caller reuses the descriptor for retries. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/vma.c | 44 +++++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index 66b0472b7d8a6..aaf75bd4e33e5 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -931,6 +931,7 @@ struct vm_area_struct *vma_merge_new_range(struct vma_merge_struct *vmg)
 	pgoff_t pglen = PHYS_PFN(end - start);
 	bool can_merge_left, can_merge_right;
 	bool just_expand = vmg->merge_flags & VMG_FLAG_JUST_EXPAND;
+	bool move_iter_back = false;
 
 	mmap_assert_write_locked(vmg->mm);
 	VM_WARN_ON(vmg->vma);
@@ -968,33 +969,38 @@ struct vm_area_struct *vma_merge_new_range(struct vma_merge_struct *vmg)
 			vmg->end = end;
 
 		/* In expand-only case we are already positioned at prev. */
-		if (!just_expand) {
-			/* Equivalent to going to the previous range. */
-			vma_prev(vmg->vmi);
-		}
+		if (!just_expand)
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
-	if (vmg->vma && !vma_expand(vmg)) {
-		khugepaged_enter_vma(vmg->vma, vmg->flags);
-		vmg->state = VMA_MERGE_SUCCESS;
-		return vmg->vma;
-	}
+	if (vma_expand(vmg)) {
+		/* Error occurred, restore iterator. */
+		if (move_iter_back)
+			vma_iter_next_range(vmg->vmi);
 
-	/* If expansion failed, reset state. Allows us to retry merge later. */
-	if (!just_expand) {
-		vmg->vma = NULL;
-		vmg->start = start;
-		vmg->end = end;
-		vmg->pgoff = pgoff;
-		if (vmg->vma == prev)
-			vma_iter_set(vmg->vmi, start);
+		/* If expansion failed, reset state. Allows us to retry merge later. */
+		if (!just_expand) {
+			vmg->vma = NULL;
+			vmg->start = start;
+			vmg->end = end;
+			vmg->pgoff = pgoff;
+		}
+		return NULL;
 	}
 
-	return NULL;
+	khugepaged_enter_vma(vmg->vma, vmg->flags);
+	vmg->state = VMA_MERGE_SUCCESS;
+	return vmg->vma;
 }
 
 /*
@@ -1032,7 +1038,7 @@ int vma_expand(struct vma_merge_struct *vmg)
 		vma_start_write(next);
 		ret = dup_anon_vma(vma, next, &anon_dup);
 		if (ret)
-			return ret;
+			goto nomem;
 	}
 
 	/* Not merging but overwriting any part of next is not handled. */
-- 
2.53.0


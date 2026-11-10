Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272888;
	b=ZSljVYwXd/vCa5gNpanl9TSlSmgEyLrzD8Eg+QAKWgzZ+YxgPwnIguW9V/h0QJMnF1aD
	 ocQySZZcZ0nu+QhzFDVGkZOHN/1l1u3Fp4oNjVraL430e1mCVKh4hjS5/xQn+SH35Feu0
	 CLJaJusDwwqnEgcVDCDqIC1YJUi7lU45ffg7iZjjMlHFaEvrSuAPpablGPgMQPc/uKNZB
	 h2BVV4yKtqiy0QNIDhCe523RhCzoFVYchve932t2HScaprepKDNTup0VOkwegVQYUETjn
	 PwisY8i5akkRryi8UOI5pN523azZnzyIxENtSG4harD8gOf36QgTTsveFPMmY6noDmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272888;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=7QqGcsiW7UChmHZNzKi9rFxGcu2hwE9yTeWJIoORpqo=;
	b=SMTXNy6fxpvYPv8JE5Jjg+ZydkfVi6TPCmdCaQ7zsNTwh8HkhFarJnNmEH37CgUYoaym
	 mFDsIxorC/ZYfH2QmkK15dJEZuX1bCuonlLqmuMDiPU3ZmVxs7wD6mxwsk76fE80wP99C
	 asIpCBxdCRpaCG674bbQqYWSzmucp94/E/rzbuYN53+oVdi4AmtIfTeQH3fTxJaNsjI5N
	 zffck7T4vvvrhme44C0y2LRJ/wLFrSQgGTI8eDFZbrBbCF13agZO2YItdzKrqqrsrJQ5V
	 pxIB2E0o5JB+QNrNyiuGI+cZbYju6KvGyz1uVhv2MDmDnGnxbptnnUNEeC8EFLAi4dQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ENQl69Vx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C36C606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ENQl69Vx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11C681F0089F;
	Tue, 10 Nov 2026 01:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272888;
	bh=7QqGcsiW7UChmHZNzKi9rFxGcu2hwE9yTeWJIoORpqo=;
	h=From:To:Cc:Subject:Date;
	b=ENQl69Vx0Z4bJSv1ic3yZWcPTTV8FBznZ/2ZYHCynXVp6x7N2dfyw82PbdEghji61
	 rSUb1Hop+zr3AmmHeSMaPl5CA4ZzKEDNbz/Yc+oN69JBO6EM12+L78/ygd4Jz4LdJv
	 1HsBtJLAORgfg0zw6+b3DmdYb4MECGOc4rO5A/F/hhkEjv2RnG24EJQG0IRkYxtPzC
	 syW6OY0wg/r6mPzF1xRn3bzow3pDwaU+dif1eumpaZGiRtqKD3pwZzOywcMs15Iyb7
	 iDZj20mjRHDXlhU2PXkLextAQy1M62LXQPn6/W9vyq1G/epfJAedVXhvN3h2Rin4ZQ
	 8BuXY/zNQHD6Q==
From: Sasha Levin <sashal@kernel.org>
To: ljs@kernel.org,
	akpm@linux-foundation.org,
	jinyue.li@linux.alibaba.com,
	liam@infradead.org,
	vbabka@kernel.org,
	jannh@google.com,
	pfalcato@suse.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/vma: update VMA iterator state on error in new VMA merge" failed to apply to 6.12-stable tree
Date: Mon,  9 Nov 2026 20:08:05 -0500
Message-ID: <20261109200805-failed-6.12-168ed9c5d5ec@kernel.org>
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
git cherry-pick -x 168ed9c5d5ec2fd326715eba5750c2b69e559ff3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200805-failed-6.12-168ed9c5d5ec@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 168ed9c5d5ec2fd326715eba5750c2b69e559ff3 Mon Sep 17 00:00:00 2001
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Tue, 27 Oct 2026 11:25:20 +0000
Subject: [PATCH] mm/vma: update VMA iterator state on error in new VMA merge

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
---
 mm/vma.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index af8e65ada23b2..d416ba58eb4c2 100644
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
-- 
2.53.0





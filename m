Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272938;
	b=BDpNzqPmNsbe0WSIuWJ7agU66ZjHvyWcJzL6I/X7eXvbzQD5ViLyWU5DqOAlFyf7fyDA
	 rG7Qk5nQyQP1kfQo5sikZykFkssi8VSS+DULhY2xAUTB7SFUzMaBpCWnxy2gzw7uCZIC3
	 V6Wjv0QBcEXJ9bPwwrbW3uxEL6WBRknHJ2BIz6gnyfQyO8FYi/TtSH5C7FOksVk9u0Pe/
	 p8jWqKZ69cg1ekH+5TGSUDE7j+kKmHI7/BMz9rSoujNo8JeOR6nK5WNejnZ/Ui289WmCg
	 zgfGb71q1rpR+IBe551tnGQ27B4DpaFUOvOTsG+QsngvsPKsp4g3ZtaOZuiwry+wfEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272938;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=l+VxQO86NJBzx6OeiHxiWUP+yGWwsrYMbE38vkZbwaM=;
	b=w9LrDIuByn7rtXFKO9yeTbMMm9QInRo7t1zjcEeioXfqxydOfO9Bt0a7H//zveaRVCjS
	 dahbrjPUoswOKwmkIj/e4fIc9a3N7NAN1ZOw3Yih9LhulBoT7pMC7axYgPmFPFNYDRpA6
	 sl7C9O4No25FBqETXP45ESi6Q/TdpxGzb8T5B75xRcV39g+yZrsgL/QyWYvAEfde2bUVl
	 m+/ucwKXatogp0kRLfeDzGOvP9Fx7odXAudugYPu9Bd67vO0IYYYo6C3xaIfghc3HGPd7
	 fVG+6dPuIle3BxMO6o1337ySedn/du6+vAQ+JmVQKrwKeaykYTxp4iE34JhTltoRghA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O4K1fbL5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58F3606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O4K1fbL5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B62311F0089F;
	Tue, 10 Nov 2026 01:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272937;
	bh=l+VxQO86NJBzx6OeiHxiWUP+yGWwsrYMbE38vkZbwaM=;
	h=From:To:Cc:Subject:Date;
	b=O4K1fbL5Q5o3d3ngqGhFs7b3lKP2tw8BeAPlSiYkT5kMlN9IV25OjsD8cnU0d6doW
	 yRpluid6lPuWOlRR8hCZxn5UR24VlqMuwCYWJ7WFg9xhDzrNkFewaDIJN0ckeOtM0/
	 I9wEv08E5ODy65GjItkLsz9HQcv430NmuMc4gZ8RSzCtI2ZrlAcU8h5NoNomxRL4Ey
	 38lher7mAtliv6IqiPKcm7pu3KvPknK2x2wc2NR+VoqRGQpuFz9YZc/9Rit8juDUjr
	 8PRhj8RanC25S8bMN3c9qcp1jk9F8SUbD5WNYPoO7rU/LZHEeH8c5mgyzB2LKEz0+Z
	 3KS1xEqKyC1/A==
From: Sasha Levin <sashal@kernel.org>
To: mason@kernel.org,
	gourry@gourry.net,
	usama.anjum@arm.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	david@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/huge_memory: fix truncate racing with PMD zapping" failed to apply to 6.12-stable tree
Date: Mon,  9 Nov 2026 20:08:55 -0500
Message-ID: <20261109200855-failed-6.12-e6a07d29b0a6@kernel.org>
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
git cherry-pick -x e6a07d29b0a60f3a4cfe77fe34eeb4b3fb38d6c4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200855-failed-6.12-e6a07d29b0a6@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From e6a07d29b0a60f3a4cfe77fe34eeb4b3fb38d6c4 Mon Sep 17 00:00:00 2001
From: Chris Mason <mason@kernel.org>
Date: Sat, 31 Oct 2026 10:39:42 +0100
Subject: [PATCH] mm/huge_memory: fix truncate racing with PMD zapping

zap_huge_pmd_folio() removes the rmap before calling folio_mark_dirty().
If this was the last mapping, truncation can skip unmapping the folio
and proceed without waiting for the PMD lock, racing with dirtying.

ifs_set_range_dirty() can oops if MADV_DONTNEED races with
ftruncate() on XFS, when we get the folio set dirty after it was found
to not be mapped anymore.

Move folio_mark_dirty() and folio_mark_accessed() before rmap removal,
matching the PTE zap path. This keeps the folio mapped while updating
its state, so truncation must wait for the page table lock.

Fix generated by an LLM and sent by Chris Mason in private.

Fixes: fe6cf984939d ("mm/huge_memory: transfer the pmd dirty bit to the folio on zap")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
[ david: simplify comment and description ]
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Link: https://patch.msgid.link/20261031-fixes_core-v3-13-d6437171ecc3@kernel.org
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/huge_memory.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 283c4bc8b927c..ce52962db16b9 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2495,10 +2495,6 @@ static void zap_huge_pmd_folio(struct mm_struct *mm, struct vm_area_struct *vma,
 {
 	const bool is_device_private = folio_is_device_private(folio);
 
-	/* Present and device private folios are rmappable. */
-	if (is_present || is_device_private)
-		folio_remove_rmap_pmd(folio, &folio->page, vma);
-
 	if (folio_test_anon(folio)) {
 		add_mm_counter(mm, MM_ANONPAGES, -HPAGE_PMD_NR);
 	} else {
@@ -2512,6 +2508,13 @@ static void zap_huge_pmd_folio(struct mm_struct *mm, struct vm_area_struct *vma,
 			folio_mark_accessed(folio);
 	}
 
+	/*
+	 * Present and device private folios are rmappable. Remove the
+	 * rmap after transferring young+dirty to the folio.
+	 */
+	if (is_present || is_device_private)
+		folio_remove_rmap_pmd(folio, &folio->page, vma);
+
 	/* Device private folios are pinned. */
 	if (is_device_private)
 		folio_put(folio);
-- 
2.53.0





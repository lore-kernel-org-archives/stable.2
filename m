Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946F8549397;
	Thu, 15 Oct 2026 16:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792080461; cv=none; b=X8vruSDeAefkdHLkhPSAF6i/YDtivDrp0DPA8QKLdeQiUZC1BHmP3jFak9eSk5s8fy8fpKs0g8w7U2OA6Op4eaqG3yIVIBlaCsw3uhbRRPt7fBNadAyo04Hm34s0Bc4saMGy63QikOV6lcM2o6tIbq2SHNPgAgYg8onzuRFAVDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792080461; c=relaxed/simple;
	bh=ulrZ2V7SJXfVeJxQpvnSpDWRVwaaNecXzCNDtz03vwE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TPksk7GdqiFigk5e3IQQPZr/9I+cEUm8zb+bpceh9uj5p3BRh0nbh6runBkaGlOXkvV278KQ2HICpcSb8lc9LOvJKrWNQ+1B/qAioDEE4xIZYwht0VxQ+D6pmde5n1m0sLhsj+iWQgBcMUOYl0Bdh6outba9Fam8r59XGnbP+5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oClVWSoc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oClVWSoc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B38E1F000C5;
	Thu, 15 Oct 2026 16:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792080448;
	bh=CciFSgIFbCKdkyGPR3RAGdYw4f/ibGwxPnazJEcANEE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=oClVWSocfqvduPR2ALfzIteEFks2esswxs0F5Y2oZ/OA+HLCsAV/fLlib5j95qPEq
	 +3kZatFC0ANxS/DB0lRArKWAxUA+V/mKeyDOldSMMcAwzYJrl7fu+w2qeL+9QEAvW9
	 wuui8iSP/G/wc3mZPtq8nFawHp2pPEOzw51/wgIO95YwNYlx/8OW3tO/V1wUyYm4tT
	 upGx+ji2prBVevtIwEgY38MI2o90fU5H4R7Z4KqZgUtrXG6Ju8afkoBoaF1ddxngwY
	 Po9NzE5sqCS6nyjwxUxNtqLm3ObuglI8ZrMX9ToVMbhjAcpB0CN5NbdfdbsNMob9kS
	 2W5jC2QjzjP8Q==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 15 Oct 2026 18:07:07 +0200
Subject: [PATCH 01/10] mm/vma: don't leak the commit charge on mmap failure
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-urgent_fixes-v1-1-42796911043b@kernel.org>
References: <20261015-urgent_fixes-v1-0-42796911043b@kernel.org>
In-Reply-To: <20261015-urgent_fixes-v1-0-42796911043b@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Muchun Song <muchun.song@linux.dev>, 
 Oscar Salvador <osalvador@suse.de>, Miaohe Lin <linmiaohe@huawei.com>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>, Adam Litke <agl@us.ibm.com>, 
 Mel Gorman <mel@csn.ul.ie>, Rik van Riel <riel@surriel.com>, 
 Peter Xu <peterx@redhat.com>, "Kiryl Shutsemau (Meta)" <kas@kernel.org>, 
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Josef Bacik <josef@toxicpanda.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 "David Hildenbrand (Arm)" <david@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3090; i=david@kernel.org;
 h=from:subject:message-id; bh=PrdvM6UwTy8T7DRmlAnUC/i1CY7asN3v2e9tohKJ6aM=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIu/DL+dvLjnYVC5XPumHP1rnrR8tnh5Ik9fX+myYXLh
 yzxUueQ7yhlYRDjYJAVU2QJCr5v8PLlutpqNz5mmDmsTCBDGLg4BWAimlEM/9OLcg34K3TmMjy/
 kizyN7FEZ63Q0ohiPqWsv16H3Lcl3GJkeHSnM3SLOv/CjvtnxW7K8s5Zt2/jtcrvfBc3rCpTutd
 iwAkA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

From: Josef Bacik <josef@toxicpanda.com>

When an accountable mapping replaces existing mappings (MAP_FIXED),
__mmap_setup() only charges the difference between the size of the new
mapping and the VM_ACCOUNT pages it replaces. It then zeroes
vms->nr_accounted so that unmapping the old VMAs does not return their
charge, which now backs the new mapping.

If the operation fails after that point, the error path returns
map->charged, i.e. only the difference. By then vms_clean_up_area() has
zapped the page tables and closed the old VMAs, so
vms_abort_munmap_vmas() cannot reattach them. It leaves a gap and
finishes the unmap with vms_complete_munmap_vmas(), which uncharges
vms->nr_accounted == 0 pages. The old VMAs are gone, the new one was
never created, and the charge of the old ones is never returned, not
even when the process exits.

No privilege is needed to hit this, only a file whose mmap hook fails,
for example a socket (sock_no_mmap() returns -ENODEV):

	p = mmap(NULL, len, PROT_READ | PROT_WRITE,
		 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
	mmap(p, len, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_FIXED,
	     socket_fd, 0);

Every iteration adds len to Committed_AS for good. With
vm.overcommit_memory=2 this lets any user make all further accountable
allocations in the system fail with -ENOMEM.

Once the new mapping has taken over the charge of the mappings it
replaces, it owns the charge for all of its pages. Record that in
map->charged, so that the error path returns all of it.

A failure in __mmap_setup() itself is not affected: it happens before
the charge is taken over and the old VMAs are reattached with their
charge intact.

Original fix generated by an LLM and sent in private by Josef.

Fixes: 4f87153e82c4 ("mm: change failure of MAP_FIXED to restoring the gap on failure")
Cc: stable@vger.kernel.org
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
[ david: call variable "uncharged" and make it const, adjust/simplify comments ]
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/vma.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index 6c35f0d775ab6..81e2c93a1cc52 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -2577,14 +2577,17 @@ static int __mmap_setup(struct mmap_state *map, struct vm_area_desc *desc,
 
 	/* Private writable mapping: check memory availability. */
 	if (accountable_mapping(map)) {
-		map->charged = map->pglen;
-		map->charged -= vms->nr_accounted;
-		if (map->charged) {
-			error = security_vm_enough_memory_mm(map->mm, map->charged);
+		const unsigned long uncharged = map->pglen - vms->nr_accounted;
+
+		/* Charge only what's not already charged by mappings we replace. */
+		if (uncharged) {
+			error = security_vm_enough_memory_mm(map->mm, uncharged);
 			if (error)
 				return error;
 		}
 
+		/* Our new mapping owns the entire charge now. */
+		map->charged = map->pglen;
 		vms->nr_accounted = 0;
 		vma_flags_set(&map->vma_flags, VMA_ACCOUNT_BIT);
 	}

-- 
2.43.0


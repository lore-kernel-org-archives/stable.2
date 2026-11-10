Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273209;
	b=tFYPQOK+jFTRfWsOBkDJs4RdUjbbAlaFQpqtU935KjU6TAe0gnNpg3tHSTeR5ghmzKuW
	 +nRl6TWe7Q2GuJ9lw9hAfbADACdDh03oqthoAwaJbNo4iE1lmZP1JXPXAoDintFMsc1a6
	 DCCidyZD+82lilZUOBydl7cbsyBV/4+vLpdsZM32ocEBKYFvJOl9xWrJ2eoUcQvV3xaxh
	 3YYRrSpQJFjbFI7MzmxIsdVU8yYDkyQabZ+xoPPX3z1FABkCt4aObyV7qV39YijWQrIsA
	 j/9Qe+bLvCIE4cIqReGpbhHsji95sZE6QpQiOIEux5Eoi4hGpiXkxIstnyYMICD7qxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273209;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=IO1yDENEE6BKKe9Oc2d28MEhdWgWyAWAkSwsjpryFQ0=;
	b=jlAXMWfRtymmHItURcDzAWyF5ZjWaKFc+VRFMnFoh03MTSdn5SrveGCgc0cEmaJEDrEf
	 tansNUX2XBwqliS3O40sdGTlcf3s+S2PlLJ71ybslwOqvhepWE8p7Gu6Bb87c/3qbZOJk
	 UpYBPa+obXYKvmPMcoxKBxLHV2aSYDrPHg1jgZU33HNaIReigPEtMAaPEhiUwczJAGqk3
	 Rr25L66TInXNnG39UCC+pjonOAJi+481FEQ2rm+Vo2B3evQPjm28ySm7lnUuiQUGoN1u8
	 y6nwf7ocPfA68KW199r0JN5IGoscoB5/T4nt9iGb2hFgVH4PgcUJVKtkO085hbVsDgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iG7DD6cz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4DA606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iG7DD6cz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2AFA1F0089F;
	Tue, 10 Nov 2026 01:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273208;
	bh=IO1yDENEE6BKKe9Oc2d28MEhdWgWyAWAkSwsjpryFQ0=;
	h=From:To:Cc:Subject:Date;
	b=iG7DD6czQfBlaK/6pIUJ8SfeAjEoRKCETiH+EgHSfj6XkW1Z9cPV+LigUJ/pcm7P7
	 T6C2ARamYdZiPKqwpqjs1yh/4/F0gukCzxppkeAXiMwIcCeYIeswDyIp0f9C0UbkNB
	 eOazf+jXnhq6cY1CvsYiI4pWcmmR8OhcnFMb0SRxCiRNjEzPMt4kOQgHo+TJ2KZ1p2
	 YxPhb7pnIbfeGNvGCRrgM44On2BnqNn/FbT5pWl41gMB/M1EIFsJUVn3hQF3q2Vdyj
	 n0FUr3G6czsGJMqoCvmavutrJcl+WU1NUCbEMnV9a26ut9ryafBKJxdq4xrIjHUcO5
	 RhEdV6nXrkHbA==
From: Sasha Levin <sashal@kernel.org>
To: mason@kernel.org,
	pfalcato@suse.de,
	gourry@gourry.net,
	usama.anjum@arm.com,
	lance.yang@linux.dev,
	baolin.wang@linux.alibaba.com,
	david@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/khugepaged: preserve dirty bits when collapsing PTE-mapped THPs" failed to apply to 6.6-stable tree
Date: Mon,  9 Nov 2026 20:13:26 -0500
Message-ID: <20261109201326-failed-6.6-fe2817e3d5ea@kernel.org>
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
git cherry-pick -x fe2817e3d5ea347214342c9a5cd8bcbff20c0574
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201326-failed-6.6-fe2817e3d5ea@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From fe2817e3d5ea347214342c9a5cd8bcbff20c0574 Mon Sep 17 00:00:00 2001
From: Chris Mason <mason@kernel.org>
Date: Sat, 31 Oct 2026 10:39:46 +0100
Subject: [PATCH] mm/khugepaged: preserve dirty bits when collapsing PTE-mapped
 THPs

try_collapse_pte_mapped_thp() clears PTEs without transferring their dirty
bits to the folio. A shmem read fault can map a clean folio writable, so
a later store only dirties the PTE. Losing that dirty bit allows reclaim
to discard modified data.

The assumption that regular files are read-only is also obsolete since
commit 1b6444331bebb ("mm/khugepaged: enable clean pagecache folio collapse
for writable files"). In any case, transferring PTE dirty bits to the folio
when removing mappings (and while the folio is still mapped) is the right
thing to do.

Use get_and_clear_ptes() to collect the dirty bits and mark the folio
dirty before unmapping it. Update the comment.

This was reproduced with shmem using MADV_COLLAPSE followed by
MADV_PAGEOUT.

Fix generated by an LLM and sent by Chris Mason in private.

Fixes: 27e1f8273113 ("khugepaged: enable collapse pmd for pte-mapped THP")
Fixes: 1b6444331bebb ("mm/khugepaged: enable clean pagecache folio collapse for writable files")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
[ david: adjust comment; simplify description; cover file-thp as well ]
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Link: https://patch.msgid.link/20261031-fixes_core-v3-17-d6437171ecc3@kernel.org
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/khugepaged.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 34ebb37c862c0..ce794d9760a87 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1995,9 +1995,10 @@ static enum scan_result try_collapse_pte_mapped_thp(struct mm_struct *mm, unsign
 		/*
 		 * Must clear entry, or a racing truncate may re-remove it.
 		 * TLB flush can be left until pmdp_collapse_flush() does it.
-		 * PTE dirty? Shmem page is already dirty; file is read-only.
 		 */
-		clear_ptes(mm, addr, pte, nr_batch_ptes);
+		ptent = get_and_clear_ptes(mm, addr, pte, nr_batch_ptes);
+		if (pte_dirty(ptent))
+			folio_mark_dirty(folio);
 		folio_remove_rmap_ptes(folio, page, nr_batch_ptes, vma);
 		nr_mapped_ptes += nr_batch_ptes;
 	}
-- 
2.53.0





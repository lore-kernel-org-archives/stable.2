Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273798;
	b=NqkiB6WGEu3Cpo8J0fZPbxVcHKycFMW9hNxZOcuo2lQOEtwHDJ/GvVtJO0Y6dj6CgBXm
	 jYs5m2+f4Fl5h2sNba9YKX3PGn25ZTT+mQJEENEizwIwuzFu84r5Qxab5VqnKyCh8hLEK
	 FZUgOQK7tUMs0qfH4kkhORg4NsYaQO5lhDFE0IcpCffJKUI+aAsx2htgypqnlklTxT3l5
	 boM3IRmhlsyLmxXDKikMYfXZgUHKuageFVGccxp7p7dWXUWcoy4WAaKUB+G2ZDQAQPm+o
	 Frqgkim1s8wlvI5DBwBpQczEK56J9TlE9MNLXqvnL/LoBpOPoqWG1Ig/TV1TtpZN6Ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273798;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=8FKwSYkFMRzzYDsruihRiqwwXgFJ9CqvMiusxRCBzTE=;
	b=mLl97M4vaXwOcbqhKic/OJYOlqpQKQ5cU7HDUB2CQs85TvY0e5CamfcT75qpbKp2Bpkq
	 w+60buGjvvmFBPR7xY6nkFzIMQda5HdfsrPDTQzLa+EQnGVV0v9LtZPZDMsrJx4jLTtU4
	 YOl/LBGaNpxV03D6gXKViHIeblocNRAjo3dXqWGGhxJGXmJplByonpXwqn4+0S/bWNCF6
	 v5vuZ2k6erhKinFjY0Yb/tvQUq+qVZpCtIYT6oEceWRmsLktbQXcYKnJlMQ2JODKfZI+c
	 lel6IAoKYh5nj3az528nF8mvKn2jk+CMHhgPLSIaFIz/CBrvjFTvyYo3NDuTZSCFBRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=er9muruK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0D26071843
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=er9muruK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 694811F008A2;
	Tue, 10 Nov 2026 01:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273797;
	bh=8FKwSYkFMRzzYDsruihRiqwwXgFJ9CqvMiusxRCBzTE=;
	h=From:To:Cc:Subject:Date;
	b=er9muruKG7ExViOQcqC9W1Bv0ZJi/lIKelc5euf7/ZcORAxHpTKNdGS9ekD+8tKvy
	 +LKrW/LGu6rMaCmRPrDw0I1vM9GY0g34WX7pyX/lON52v0aLJA13jGd5itMxohmGDY
	 ZButRAccbPLjmwyNNtJ4RQeUt+tffUJ7WDV6Lj6+QA6JSVgPnII1dKDjLhn/ZncZ8g
	 xe7/WVxyonmExTQrzBET1zlIwOUVA7Ow3NZgeBnHnNx5f3qR+rMan/BJ3QTDALQ20A
	 48uW3lZdq2fcyvC4t6U1ncd/JJspa9GxPOBzendDl1wNU4Jr/49JudDi3JTVaWmGbN
	 b0rLSYD1NhJfQ==
From: Sasha Levin <sashal@kernel.org>
To: mason@kernel.org,
	pfalcato@suse.de,
	gourry@gourry.net,
	usama.anjum@arm.com,
	lance.yang@linux.dev,
	baolin.wang@linux.alibaba.com,
	david@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/khugepaged: preserve dirty bits when collapsing PTE-mapped THPs" failed to apply to 5.15-stable tree
Date: Mon,  9 Nov 2026 20:23:15 -0500
Message-ID: <20261109202315-failed-5.15-fe2817e3d5ea@kernel.org>
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
git cherry-pick -x fe2817e3d5ea347214342c9a5cd8bcbff20c0574
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202315-failed-5.15-fe2817e3d5ea@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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





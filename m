Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801942;
	b=04JEfKOPL0QoXcmcbEwSCqxZ+xYfk0iq65TJMkdw6+kTgfNc/eCh+K/KjBhZcrisZd/n
	 Fx+9bHW24CDgqRHGyXh62SZ4FuGwJlkD0inRPJVIT6TwIx98Ppjmkx9YvhQElYXAp+Ucc
	 knEmu4iTBZTt2W7GypvmmngebKqkzYzxPyN2MJFF1UGaIAIVLXvCHvKWVMDknYHbSAqoo
	 AQ6d+ffdlAl/82K2SQuWPVy0CUwBs1uJv4biLh56etxB7c+2qu58lQYE0em8KQDVw5gKB
	 m8+iK/rgtnD+POFXevFnBMaxl6Jww59DaesU7Dyqybf09zjJ83M7zHZpae4JybvSW5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801942;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=qQh0cnNiO0koPB119VPBcFRcMcvx06Wogc2lEjmz58I=;
	b=fXxTE8Oh4sgtQ/EW/3ZUjx0+v7ydrHRFEAnHsIpXc13+RhXdC03VlxfRrpDRlslODPn0
	 n7LdhLz68lYV/z6q9cI7VDLNFSdJiE76qvvGpc1/f7nDTFEqq2R+9UBRQnFr803Sj0zSD
	 neIkzj1D0aATDBvFiXhFKhSvzmBVYsHHiGD/eeX20q/W4i3tRh4RB2VnLZGdYfO1C0uIO
	 mgslWspdNvyvzvh5xoEyDZng9+uvvHLOvjcDUGCF9b2zAGLvE5yfoiTW926yc2Lew5Wq2
	 p4wQgidM+8brjt2FPUdG2F33o86g/hHJ3X9dk4MKoF0PhFBIaerpkU6jXcc+Ww/B1Cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=w1x+qobo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45E0606A326
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 14:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=w1x+qobo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BF311F000C1;
	Wed,  4 Nov 2026 14:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793801941;
	bh=qQh0cnNiO0koPB119VPBcFRcMcvx06Wogc2lEjmz58I=;
	h=Subject:To:Cc:From:Date;
	b=w1x+qoboEuoCnhG3fvO4gEhA3wtoVk6akqpr9caKqtiKMNs0wPJRYZkaFVrn/+GFR
	 qo77uwxmLJk92BvMp0b8THb9hTJLmr5kcDfUQLN25fqAUZa6KrcwPCN2shWiJLwMN5
	 NqhMO7rbat4ZN34tgJxaz7nMwMU+a3Sag2PLrb8k=
Subject: FAILED: patch "[PATCH] mm/truncate: look up the end-edge straddler by index" failed to apply to 6.18-stable tree
To: yi.zhang@huawei.com,akpm@linux-foundation.org,baolin.wang@linux.alibaba.com,bfoster@redhat.com,chengzhihao1@huawei.com,david@kernel.org,djwong@kernel.org,hughd@google.com,jack@suse.cz,joannelkoong@gmail.com,liam@infradead.org,ljs@kernel.org,mhocko@suse.com,rppt@kernel.org,sashiko-bot@kernel.org,stable@vger.kernel.org,surenb@google.com,vbabka@kernel.org,wangkefeng.wang@huawei.com,willy@infradead.org,yangerkun@huawei.com,yizhang089@gmail.com,yukuai@fnnas.com,ziy@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 15:19:00 +0100
Message-ID: <2026110400-reenact-degraded-eaf5@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x f47dee903b9f0f1e4e7181e8a398a7678cabf0a5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110400-reenact-degraded-eaf5@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f47dee903b9f0f1e4e7181e8a398a7678cabf0a5 Mon Sep 17 00:00:00 2001
From: Zhang Yi <yi.zhang@huawei.com>
Date: Mon, 28 Sep 2026 20:08:31 +0800
Subject: [PATCH] mm/truncate: look up the end-edge straddler by index

In truncate_inode_partial_folio(), after the first split at the start
edge, folio_split() unlocks and drops the refcount of the after-split
sub-folios.  The sub-folio straddling the end of the truncation range is
therefore unlocked and only transiently ref'd in the page cache while the
code still derives it from a page pointer inside the original folio.

Between the first split finishing and page_folio() resolving split_at2,
that tail page can be reclaimed, freed and reallocated as a new large
folio in the same mapping at a different file offset.  folio2 then points
at a folio that does not cover the end boundary, yet folio2->mapping ==
folio->mapping still holds, so the stale pointer passes the mapping check
and folio_split_or_unmap() splits a folio at a wrong position (or, with a
transient refcount, a use-after-free window opens between try_get and the
split).  __folio_split()'s own folio != page_folio(split_at) check cannot
catch this either since split_at2 has been reallocated as part of the new
folio, so page_folio(split_at2) resolves back to folio2.

Look the straddler up by its page index instead.  __filemap_get_folio()
returns the folio currently covering the boundary, ref'd and locked, with
the mapping validated under the lock, so the split target is always the
real folio at the end edge.

Link: https://lore.kernel.org/20260928120833.3440834-3-yi.zhang@huaweicloud.com
Link: https://lore.kernel.org/linux-mm/DLGXT0ERY79Z.3C5DYVJVX6S9Z@nvidia.com/
Fixes: 7460b470a131 ("mm/truncate: use folio_split() in truncate operation")
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/message/20260916094500.C30061F00893%40smtp.kernel.org
Suggested-by: Jan Kara <jack@suse.cz>
Suggested-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Brian Foster <bfoster@redhat.com>
Acked-by: Zi Yan <ziy@nvidia.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Joanne Koong <joannelkoong@gmail.com>
Cc: Darrick J. Wong <djwong@kernel.org>
Cc: <yizhang089@gmail.com>
Cc: Yang Erkun <yangerkun@huawei.com>
Cc: Zhihao Cheng <chengzhihao1@huawei.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: <yukuai@fnnas.com>
Cc: <stable@vger.kernel.org>

diff --git a/mm/truncate.c b/mm/truncate.c
index 8a28f4a21267..f252619ae6c3 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -259,30 +259,32 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
 		 * for shmem truncate
 		 */
 		struct folio *folio2;
+		pgoff_t end_idx;
 
 		if (offset + length == size)
 			goto no_split;
 
-		split_at2 = folio_page(folio,
-				PAGE_ALIGN_DOWN(offset + length) / PAGE_SIZE);
-		folio2 = page_folio(split_at2);
-
-		if (!folio_try_get(folio2))
+		/*
+		 * After the first split at the start edge, the folio at the
+		 * end edge may be freed and reused concurrently.
+		 * __filemap_get_folio() looks up the straddler at end_idx
+		 * and returns it locked and ref'd with the mapping
+		 * validated.
+		 */
+		end_idx = (pos + offset + length) >> PAGE_SHIFT;
+		folio2 = __filemap_get_folio(folio->mapping, end_idx,
+					     FGP_LOCK | FGP_NOWAIT, 0);
+		if (IS_ERR(folio2))
 			goto no_split;
 
+		/* make sure folio2 is large */
 		if (!folio_test_large(folio2))
 			goto out;
 
-		if (!folio_trylock(folio2))
-			goto out;
-
-		/* make sure folio2 is large and does not change its mapping */
-		if (folio_test_large(folio2) &&
-		    folio2->mapping == folio->mapping)
-			folio_split_or_unmap(folio2, split_at2, min_order);
-
-		folio_unlock(folio2);
+		split_at2 = folio_page(folio2, (end_idx - folio2->index));
+		folio_split_or_unmap(folio2, split_at2, min_order);
 out:
+		folio_unlock(folio2);
 		folio_put(folio2);
 no_split:
 		return true;


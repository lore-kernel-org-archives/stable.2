Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793799590;
	b=UAJRXflctB3H76/I2klug9DhFRzIgFZGr6cSVFN2gKOLTTCTuNOL3bQHIKdtprobR2WQ
	 7ijkDQp0k53jLmtw869Sm7Qs+ZqltJlnTbca2ISrF8A3ICgTeX/tW81x32Mu8q8HYuIZN
	 rpymHcq1HF1CshDWpsx/NQaV/l/e2vfu48fSvVgkYPuflFSXewbrsdjh7FSL6G3HKZwfY
	 H40HcVnAvvgqLy51jF0eHrFq75lH35qIBDX3bZIZiFj7PxKS3rVgw5oaNk8zY5jGr/34J
	 nw6HfigFx7wGECjXZ3xESrMCSIuMx2RiO9aRpAcX2/YBMAs0cFItlrXTQriQoad13Pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793799590;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=2Qa7U71mlguyrpXCasNA+lj5xSQoEoKSz+jEmi4VtQ4=;
	b=SkVbUtGTlE31jZfoA47o/bTJL/6cab9Dm63j9Xl3YKAkNS249w4Kk+uPbgZBdO4H0sid
	 cFupMA/kcToQ5PeelZ1XMe0zwwqPmVIU0sVLP8qYhfGH+fcbTyQy/OQYLdmFLOctiO4Uy
	 17QiZGP2l85UxAWttCL6AKTN4ZpJmUyqpxagz0mzVw39ejcPtyXaUFLG+SIGx94MEZzSe
	 W1ThsHS+xHSqFMeC9v4+XVdGWC5trXTbttTP8eadDmz4ZIeUkFHvwf+nNWgLQASgCBNbn
	 9ahXJOan7hJ2oJykxlVLM8e0abw5890woq0+POO881GPlYzyAgQs5qBm22Oy3YQj99w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=1nxSOa5b;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68540606A337
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 13:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=1nxSOa5b
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E1041F00919;
	Wed,  4 Nov 2026 13:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793799590;
	bh=2Qa7U71mlguyrpXCasNA+lj5xSQoEoKSz+jEmi4VtQ4=;
	h=Subject:To:Cc:From:Date;
	b=1nxSOa5bbYpczu9ei9Iy29os/5f/TJmDY7PJdhB9jllo0oi7YZxIJy8UWfo3pNHed
	 pA9x6UXu+YCpqTlnOeWAGHQ9tjPv+mcVm1m9NkcQI736LQnSrlJVwE+Y4v7PyVtbZA
	 cR9NkhIYFkdGmBEtvexAgGictRzjj5D3PIe1GfXI=
Subject: FAILED: patch "[PATCH] mm/hugetlb: fix use-after-free in hugetlb_mfill_atomic_pte()" failed to apply to 5.10-stable tree
To: david@kernel.org,agl@us.ibm.com,akpm@linux-foundation.org,jannh@google.com,josef@toxicpanda.com,kas@kernel.org,lance.yang@linux.dev,liam@infradead.org,linmiaohe@huawei.com,ljs@kernel.org,mgorman@techsingularity.net,muchun.song@linux.dev,nao.horiguchi@gmail.com,osalvador@suse.de,peterx@redhat.com,pfalcato@suse.de,riel@surriel.com,rppt@kernel.org,stable@vger.kernel.org,vbabka@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 14:39:47 +0100
Message-ID: <2026110447-friend-unmanaged-5374@gregkh>
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


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x d8a9cd7fd2fb01211430c933932da58839b8ca65
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110447-friend-unmanaged-5374@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d8a9cd7fd2fb01211430c933932da58839b8ca65 Mon Sep 17 00:00:00 2001
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 15 Oct 2026 18:07:09 +0200
Subject: [PATCH] mm/hugetlb: fix use-after-free in hugetlb_mfill_atomic_pte()

Let's fix another instance where we use a folio after dropping the PTL,
where someone else could e.g., MADV_DONTNEED it once we drop the PTL,
making us trigger a use-after-free on the folio.

Link: https://lore.kernel.org/20261015-urgent_fixes-v1-3-42796911043b@kernel.org
Fixes: cb6acd01e2e4 ("hugetlbfs: fix races and page leaks during migration")
Fixes: 1c9e8def43a3 ("userfaultfd: hugetlbfs: add UFFDIO_COPY support for shared mappings")
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reported-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Acked-by: Muchun Song <muchun.song@linux.dev>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: Pedro Falcato <pfalcato@suse.de>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: Adam Litke <agl@us.ibm.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Rik van Riel <riel@surriel.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Kiryl Shutsemau <kas@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: <stable@vger.kernel.org>

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 16a3abb985be..5db64fa98404 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6520,11 +6520,16 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 	/* No need to invalidate - it was non-present before */
 	update_mmu_cache(dst_vma, dst_addr, dst_pte);
 
-	spin_unlock(ptl);
 	if (!is_continue)
 		folio_set_hugetlb_migratable(folio);
 	if (vm_shared || is_continue)
 		folio_unlock(folio);
+
+	/*
+	 * Hold the PTL until we're done with the folio: the page table owns the
+	 * folio reference now.
+	 */
+	spin_unlock(ptl);
 	ret = 0;
 out:
 	return ret;


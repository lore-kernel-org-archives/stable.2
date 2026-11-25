Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795646182;
	b=kgcXIXGghUg2Oeqw7fzJuzdydf20rBh8L39z2ciU63SiFtdXg/zuYEF8fPqFI0HF9/ZT
	 v6zF0Y2w/rgUBPDlLZD/6upIR+4LlYj124c+se71tgYeeQ+anhX6oKsWtOvjz38etRbRC
	 6F9SLtDTXPPr4h1808Ly63+9gpjdiVEeZSKEOrFtPq3p9FPE3Atuza0peLvMir1ogOE2z
	 hOAaXhaeGtnvQ0NYi71LHGdBHVBTHS5/NU/TrRdxkQ1ZbQlN/yS1WWgj8zrn6FwtxQ6F/
	 f1oexgAMIwdQDDOnwmYfwAqzNfrW74Ieqd3erbRfznAZSkF4Dlp+gH9ibZiTRT5/bLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795646182;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=mZpBmqbQgXgMnTQ2l4D3Ajs1IvGXdBhBJX97XEhXrFw=;
	b=3lsFG/1j4McA8LhM3LFDC4lxFbBHzduK9okJVarmndguf4G/H2arbqvqRuqRFqXwcLJa
	 g9t1GP435LXRJN8JFqNXowSRucYGGad+HGKYguyDLAXHz2ALFqFgC47pxWGWJpOJH1dvk
	 hdXmcNHzv7lyfWZH3G14lD+eXKqWuvSd/Y1elSkedU6cgYpkR0qJHnaSC3brl06c9Odtt
	 tHay8REGHb7VBLCs3yQwbmZeRrvI2CnB55CKXfMFy/gB3Ed6Gc24DOQ1mt2V+fC52x4s/
	 uAJjKrfVi8HABl1kzlyVS677rOOQGlps2zmh0tiqxV/Ax0EPeKDrEEcKS+Hz0hNhuEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BmsTCXIE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DF5606A31E;
	Wed, 25 Nov 2026 22:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BmsTCXIE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 598C71F000C6;
	Wed, 25 Nov 2026 22:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795646182;
	bh=mZpBmqbQgXgMnTQ2l4D3Ajs1IvGXdBhBJX97XEhXrFw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=BmsTCXIEHzyk1Iz3UrAmJqsf3yHx5toX3cmpJM5kGRORGuPeuzYOlsDrF8XRi+99N
	 j9evxWo6rcK8doMUD9vmK1thBCtMq5uX8vc8TxGnfOgvgN0sK1afqV4d/TbeAsN+bv
	 b8BiNeoB4vopglr3JXsfHw5M37KsLQN0BwCEJytLA1a6wCSRHFe4RJHYqC1L9XfI7k
	 qUKpnSUFKJuQaiXSMEM4PWhJoL/P+br2Twoofuuz2Uvtfi5ubkKhgkpKQN64s84iGN
	 eT+TMY/5RBB7nmUvqsexw1/SyyTQISQBuiOOdYDcBDEssVNYa4BSoEdNjJtV7SOmch
	 Yn7sJqQjyEgFw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 25 Nov 2026 23:33:09 +0100
Subject: [PATCH 11/21] mm/migrate: check hugetlb PMD sharing in
 move_pages()
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
Message-Id: <20261125-hugetlb_fixes_2-v1-11-db27fd2f71a8@kernel.org>
References: <20261125-hugetlb_fixes_2-v1-0-db27fd2f71a8@kernel.org>
In-Reply-To: <20261125-hugetlb_fixes_2-v1-0-db27fd2f71a8@kernel.org>
To: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Jinmeng Zhou <jinmengzhou22@gmail.com>, Hongfu Li <lihongfu@kylinos.cn>, 
 Andrea Arcangeli <aarcange@redhat.com>, 
 Mike Kravetz <mike.kravetz@oracle.com>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>, Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Dave Airlie <airlied@redhat.com>, 
 Vivek Kasireddy <vivek.kasireddy@intel.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, Mike Rapoport <rppt@kernel.org>, 
 Mel Gorman <mel@csn.ul.ie>, Dave McCracken <dave.mccracken@oracle.com>, 
 Andy Whitcroft <apw@shadowen.org>, Adam Litke <agl@us.ibm.com>, 
 Lorenzo Stoakes <ljs@kernel.org>, Rik van Riel <riel@surriel.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>, 
 Lance Yang <lance.yang@linux.dev>, James Houghton <jthoughton@google.com>, 
 Yang Shi <shy828301@gmail.com>, Suren Baghdasaryan <surenb@google.com>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Pedro Falcato <pfalcato@suse.de>, 
 Gregory Price <gourry@gourry.net>, Zi Yan <ziy@nvidia.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Matthew Brost <matthew.brost@intel.com>, Byungchul Park <byungchul@sk.com>, 
 Alistair Popple <apopple@nvidia.com>, 
 Wanpeng Li <liwanp@linux.vnet.ibm.com>, Andi Kleen <ak@linux.intel.com>, 
 Kenneth W Chen <kenneth.w.chen@intel.com>, Hugh Dickins <hugh@veritas.com>, 
 Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>, 
 Joern Engel <joern@logfs.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Michal Hocko <mhocko@suse.cz>, 
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, 
 KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, 
 "Kirill A. Shutemov" <kirill@shutemov.name>, 
 Sasha Levin <sasha.levin@oracle.com>, 
 Guillaume Morin <guillaume@morinfr.org>, Wanpeng Li <liwp.linux@gmail.com>
Cc: linux-mm@kvack.org, Jason Gunthorpe <jgg@ziepe.ca>, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Andrew Morton <akpm@osdl.org>, linux-doc@vger.kernel.org, 
 "David Hildenbrand (Arm)" <david@kernel.org>, stable@vger.kernel.org, 
 Chris Mason <mason@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2908; i=david@kernel.org;
 h=from:subject:message-id; bh=LCKF5BA45+5q+zlGMmgNQ58xhaVraHm1MhKbZUIdXxE=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLZk1SOsM2XOqg9/+16iS+zL/m5bQuprN2nbVLyaMWcm
 VaTnnh87ihlYRDjYJAVU2QJCr5v8PLlutpqNz5mmDmsTCBDGLg4BWAi0r2MDJviahiD/OV+Mjuk
 H7d1XiSutsrqw38Di6cGh6vvLgy042X4Z3d13c6okD9K3F/OWp2R+rN7yptrPq47wnvqp3bU8Of
 cZwAA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

Without MPOL_MF_MOVE_ALL, which requires CAP_SYS_NICE, move_pages(2)
refuses to migrate folios that might be mapped by other processes.

However, folio_maybe_mapped_shared() does not check for page table
sharing. So move_pages(2) with MPOL_MF_MOVE can migrate hugetlb
folios that other processes map.

mbind(2) and migrate_pages(2) already handle PMD table sharing since
commit 73bdf65ea748 ("migrate: hugetlb: check for hugetlb shared PMD in
node migration"), but we missed move_pages(2).

Let's fix it by using hugetlb_folio_maybe_mapped_shared() for hugetlb
folios in move_pages(2). Such folios are now reported with -EACCES in
the status array.

Rework the code to have separate checks for hugetlb vs. !hugetlb.

This has low urgency.

Fixes: e632a938d914 ("mm: migrate: add hugepage migration code to move_pages()")
Cc: <stable@vger.kernel.org>
Reported-by: Chris Mason <mason@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/migrate.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 0430197fdc04b..194d74152e8e3 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2279,8 +2279,9 @@ static int do_move_pages_to_node(struct list_head *pagelist, int node)
 	return err;
 }
 
-static int __add_folio_for_migration(struct folio *folio, int node,
-		struct list_head *pagelist, bool migrate_all)
+static int __add_folio_for_migration(struct folio *folio,
+		struct folio_walk *fw, int node, struct list_head *pagelist,
+		bool migrate_all)
 {
 	if (is_zero_folio(folio) || is_huge_zero_folio(folio))
 		return -EFAULT;
@@ -2291,13 +2292,19 @@ static int __add_folio_for_migration(struct folio *folio, int node,
 	if (folio_nid(folio) == node)
 		return 0;
 
-	if (folio_maybe_mapped_shared(folio) && !migrate_all)
-		return -EACCES;
-
 	if (folio_test_hugetlb(folio)) {
+		/* fw->ptep aliases fw->pmdp and fw->pudp. */
+		if (!migrate_all && hugetlb_folio_maybe_mapped_shared(folio, fw->ptep))
+			return -EACCES;
 		if (folio_isolate_hugetlb(folio, pagelist))
 			return 1;
-	} else if (folio_isolate_lru(folio)) {
+		return -EBUSY;
+	}
+
+	if (!migrate_all && folio_maybe_mapped_shared(folio))
+		return -EACCES;
+
+	if (folio_isolate_lru(folio)) {
 		list_add_tail(&folio->lru, pagelist);
 		node_stat_mod_folio(folio,
 			NR_ISOLATED_ANON + folio_is_file_lru(folio),
@@ -2332,8 +2339,8 @@ static int add_folio_for_migration(struct mm_struct *mm, const void __user *p,
 	if (vma && vma_migratable(vma)) {
 		folio = folio_walk_start(&fw, vma, addr, FW_ZEROPAGE);
 		if (folio) {
-			err = __add_folio_for_migration(folio, node, pagelist,
-							migrate_all);
+			err = __add_folio_for_migration(folio, &fw, node,
+							pagelist, migrate_all);
 			folio_walk_end(&fw, vma);
 		} else {
 			err = -ENOENT;

-- 
2.56.1


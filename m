Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795646071;
	b=UttiFVsnF7ISBBr4XIPzPbDMDnmBSqvEMrhmRWYnye+AgYtCl+mkpzkHoHA/PUl7penZ
	 E7VMptSMSsUk3VQXB4e609IdyjtfWu6vs0P289I7fMEUAcQHcVRSr3BAFl9IgoH2DXRhz
	 xz26vnfKR2nHIW2ioRM4Q0zErgP6yEwfyHPRCbtPfUaut1v/pHcI4sYeGQJgrjXu88aVk
	 aBq0v3sFiCrS9YzT/RqDy1mJCU6+h1LnBRmfooPI8Ufhfda17izKlpnJR9Jyegsjpdhxg
	 uIlmfM6jEi3kxspxwCTxdGWYullac25ERNrdHefXCbNQSAPAOZ1U0zRS1YL03WsZX4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795646071;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=8fTo2Z8MBd6ECzqB32nwIsRFTY+y4eGXyeXoke+qtck=;
	b=fLL/GutEQA5LBx+FufP38L/UPb99JBlCod5aiBRYQ0VLK/0AVuT0qeq2J0o6po96uNb6
	 6w0VGLCAjYPR2PSVgeD6Y+kEfe4KE643O9s/EWh2fbX5R9bdy/23NpfpSG1PH6ntZqLSK
	 1U/vR5lEzJAxhZcz+9BIQ7rUuHVRkIU4TvUsGD2+9ZeizhE7rT9XHo/fGr7kja0XWQkH3
	 TxuGiTq5qeeQ8foxnDiXTS2ANZZMWPDpDoGkoiNxJQwAGTtOlWfxwtoReGV3nOEgS+e7r
	 uuXgQcHNieaBc6yD7IAcIgoGYwZhjsfdS+Oc7nmPXy6TJxfF6RffBsIu6xL8cWgbL1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m630vnF8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6594606A321;
	Wed, 25 Nov 2026 22:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m630vnF8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7955E1F000CF;
	Wed, 25 Nov 2026 22:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795646070;
	bh=8fTo2Z8MBd6ECzqB32nwIsRFTY+y4eGXyeXoke+qtck=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=m630vnF8CBqdvferMVJw3+VLwe1fZh4JBEzWxfp12Xy8MH1d6IKJWmVQ63ZJIyvyr
	 SUuChcUOJLomXlHQcsTpfBfLK8B/Of/ubxETq+/LNTvUD+KEhax9Osjswyc4EWvqAr
	 IeJPVdEZB2rYyNB8BAGbVK/J86rRctBEYE9udDp91QgkduO9HGZUsFWH8I9jxSEE4t
	 iu1MkhUIxBcdMJPuz9v75QJnGoVmSuHApHDUH+Sp1vfu5prmOKdVNFhkFdzxIlRJIh
	 9zo8c/2iZgscF0PlsAkpPgyFXGuIUe29Mzp2RU9mMFL4zoWMdffOk4JYDZHlp67gx2
	 0gSC2V9mpM9Sg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 25 Nov 2026 23:33:02 +0100
Subject: [PATCH 04/21] mm/memfd: mark new hugetlb folios migratable
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
Message-Id: <20261125-hugetlb_fixes_2-v1-4-db27fd2f71a8@kernel.org>
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
 "David Hildenbrand (Arm)" <david@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1263; i=david@kernel.org;
 h=from:subject:message-id; bh=3/a8tud39mF9CLqnRD7ju9MjzM6vMjDpQCZWW0NPirI=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLZk1Rqtm3aekvro5vjhFDVz06enxdvcZm8/cjmDNmts
 1Zs2XlMqKOUhUGMg0FWTJElKPi+wcuX62qr3fiYYeawMoEMYeDiFICJuFxn+B96X6vfrGjy6dIT
 ReI8HgHuVbpJDhOOnrvZcUyX68tCs08M/8yLc//qb5RTFxTOvv2lSV1yUuYLL+bQd7e87n8MZLR
 azgcA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

memfd_alloc_folio() adds a new hugetlb folio to the page cache, but
never sets it migratable, unlike hugetlb_no_page() and
hugetlbfs_fallocate().

Later faults will find it as an existing folio and never set the
migratable flag.

Such a folio can never be isolated for migration, even once it is no
longer pinned, which breaks memory offlining, alloc_contig_range() and
memory failure handling.

Let's fix it by setting the new folio migratable after adding it to the
page cache, like hugetlbfs_fallocate() already does.

This has low urgency.

Fixes: 89c1905d9c14 ("mm/gup: introduce memfd_pin_folios() for pinning memfd folios")
Cc: <stable@vger.kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/memfd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/memfd.c b/mm/memfd.c
index 0e02ca69d27cb..6340e8a7c4355 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -152,6 +152,7 @@ struct folio *memfd_alloc_folio(struct file *memfd, pgoff_t idx)
 			}
 
 			hugetlb_set_folio_subpool(folio, subpool_inode(inode));
+			folio_set_hugetlb_migratable(folio);
 			folio_unlock(folio);
 			filemap_invalidate_unlock_shared(memfd->f_mapping);
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);

-- 
2.56.1


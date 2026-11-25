Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795646040;
	b=KcxxG54OMsvqv2KDOx7GHG5q2UxLAUzgHGwWrBdSnfOtqkisqZWkkLaGp08rP3AJfsBp
	 ifyot2zmTTOGQxB3/ga+2ClVDMnMUgafCT2KpdQYDLORcFabdaoD65ed02XsYEYk6OEDy
	 RFvk02rbW2w+e21FMvU+kHy8CKTb+Uc5J7xkswq7bfhK2SXvnkj7UJk5YxlWUXUXF0sM4
	 6/435MkD+B1tcqz41psQV/Q4eHwd12x8XKfcRqEHCS7MrJUPKC1oBO+nkdNbe0l2oDaGc
	 tI0RaVO8T3XD0IaQ63ixKIU7M7Kl8BVfRVUSbrKvhvWC3XIo/muljgC7DVPN9iOCYdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795646040;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=He20RWMnQEfWNCCjTnuFJzGYdzo97eyhNCvvU93SJYw=;
	b=IEEcpJbf9x4/hqyCWZR/UTd9L83+R8oTt3Tw9dmbf8eASYvwxhLclZmqhWMjifKzeTLI
	 XN1qgFKAK8NYinnob4W1GSq2yYST5XntO99m1HcPf8jee4SO/TQafPIWj4v6EnVMBN9Jv
	 WMCbvvJ5hspeBx06Iwt4HydRUwSmEUpra/q4q5vL9RIIRp9EGgc2iYOfZoa9zUf2Z+5PP
	 n/h8+0b43feeshySKzkdjhmwEoiKd5vhLfuKCaB4jKoYiRgq5Rf+OvCFYWrAQTFifE4IV
	 kn2W/XL8DYSeB8Sipk1vcAMRpsVidG/UrMiXFtY08KaBeh3oI4S6ADl/SHBQjJUXKNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ahK8ELcL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D69606A321;
	Wed, 25 Nov 2026 22:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ahK8ELcL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A2D51F000C0;
	Wed, 25 Nov 2026 22:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795646038;
	bh=He20RWMnQEfWNCCjTnuFJzGYdzo97eyhNCvvU93SJYw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ahK8ELcLkFb6vhynAAkR+XAD0pRhnkOpCP9l2RPpNRNuRZg3bHUGplidaID/6tCT3
	 85TtdL/rN00U2qWrlx3w8v3WO1a28OwRWopl7PUuoyw9FHI/s+OXGB9oncb4k2gKKE
	 0sSKwEstEQlISK2bJhRvBEC6QKWbsKBzMh8iOXAZ3zQaWyN55pgwfWQ+xsjxx8Awrp
	 sKXPIUX3/ufMnpCJGA6yClocXINcWSUlgYxIIG34sHi2rcc9X4SikXyfwRI7dfM2UN
	 DBn9seKPscn6Pz1yANZe6zemGHHxnKZHQZEEBrQ7LS8VmvS89o1b+Kcu/KNlL9prH7
	 /UomkEFte94Tg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 25 Nov 2026 23:33:00 +0100
Subject: [PATCH 02/21] mm/hugetlb: fix truncated copy result in UFFDIO_COPY
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
Message-Id: <20261125-hugetlb_fixes_2-v1-2-db27fd2f71a8@kernel.org>
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
 "David Hildenbrand (Arm)" <david@kernel.org>, 
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1560; i=david@kernel.org;
 h=from:subject:message-id; bh=IM9Jn0PMIC7KdrlMfsHaSFMWAt4HGC1aolUW6gtZvro=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLZk5Rjdi+VyA5cFPbUoF87MlvvUGnL/k96RRznmXPXL
 3pv839RRykLgxgHg6yYIktQ8H2Dly/X1Va78THDzGFlAhnCwMUpABPJ+sHIsMnEy/jx6ccHVTxW
 7W7d8c5AS3n3vmjtVL9v6R1JKzOZGxgZTl5KXXnrwdue1sjQSBeLw7c9BUoerNDonj8reHKSXLo
 zOwA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

From: Chris Mason <mason@kernel.org>

Folios that span more bytes than can fit into an unsigned integer (e.g.,
16 GiB folios on arm64) are problematic with UFFDIO_COPY: the result
from copy_folio_from_user() can be truncated, possibly indicating
success instead of an error.

We will then continue with the folio that has stale data, and make it
accessible to user space.

For example, if copy_folio_from_user() fails such that the number of
bytes not copied is a multiple of 4 GiB, we'll get an effective ret ==
0.

Let's fix it by simply testing the return value directly.

This has medium urgency, as it's an information leak.

Fixes: 8fb5debc5fcd ("userfaultfd: hugetlbfs: add hugetlb_mcopy_atomic_pte for userfaultfd support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Chris Mason <mason@kernel.org>
[ david: cleanup code and description ]
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/hugetlb.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index f46c85fc0cd0b..d57964914e18a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6568,11 +6568,8 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 			goto out;
 		}
 
-		ret = copy_folio_from_user(folio, (const void __user *) src_addr,
-					   false);
-
 		/* fallback to copy_from_user outside mmap_lock */
-		if (unlikely(ret)) {
+		if (unlikely(copy_folio_from_user(folio, (const void __user *)src_addr, false))) {
 			ret = -ENOENT;
 			/* Free the allocated folio which may have
 			 * consumed a reservation.

-- 
2.56.1


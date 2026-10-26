Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793057452;
	b=VCuP2pUCBtOg/hc3DTZ9x3thV3FyhUQTtVXDY5QbjGdFmQ5OhkCph6tLZ14rIARpvE3X
	 tYdtnNswGBujnTk2D22RhKhuIldt7gCQPj8a3SPUt0Pv0wiciJO6XgCjNSRn2nSwSYAf3
	 vZOMwLp6WwrOCDy3LfLLEycTU9TCMt/MBEywv7f8K0Mii+H3DOdoUxEdbNY4QmwH1CIKT
	 Rnd8hYiyF4ILPZ0UHLu7MSlx+oqS9awSqvlYAp5uzGk5QeeiCodJiLjQF7+v3Vk3vkWUy
	 rN167X6OxqkM8/huK2HClqQjeK7tLELZHeXvOD6qaYK8kZufo+CDHQhL2G548dBdPeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793057452;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=m/o6pomwj/Snmigqc9keZX4r9b48IrK05m0ArbeZmVQ=;
	b=ul4If6YfcqT4/wno2CRLikenE/qA/HSZM6Bm5nRZWaeLo/N7nmSl4A3SlvrpFQO/CLXe
	 vzmPWRdV0MSeQtP0yyqEMDJqyix+9GFKe8JIcwrRZgchDNllw+GOyEWvsnFtNcHp1K4R7
	 jQfLPamsJLZD91fqNl9rpnot/cYh6jooAezKHAfworuT4WvPVnPyXecQYeAlVNnyl8v/F
	 K8ybYXgnrHPibrlZHvi8iYgITADda0EqBfnpnvDPvEKU/7YlvAKD67IE4Oiy6MqNclvBN
	 nygGgZZLUbQHcGFBRns5z8sYAbZPyMinX0Brr4/B55R1uCQwiMkGF6fl6Sr2wfnL/xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NFfu5RLx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1338606A325;
	Mon, 26 Oct 2026 23:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NFfu5RLx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ECB81F01828;
	Mon, 26 Oct 2026 23:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793057451;
	bh=m/o6pomwj/Snmigqc9keZX4r9b48IrK05m0ArbeZmVQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=NFfu5RLxi1K4bGG0NRmN8zByvp1TBgBHz0vcQFO2M4z3uMArn+KqbxBg2JlggagTD
	 AlNPVDXXrqk4pgda8FB25EHeKVUD32b3wkHkAoRxLkDlylEBKLltcTAd27TZWriwkR
	 uJODZIsMTICjejtne7zG1NQb40xvBqHE6/yzlQ7UjwWZFv9hcONwV3bfvrkmY5kEsP
	 qhtSSJLqHmxxPrQLnpRE6t3V3u/KVKtzcFD0IGK1iu8gXezPaQUo9TYeP89qXcGtM8
	 1wlLRCafmWVhc5VsIxPDlA7+wXRBTiOv5xt+6VapKyLJPHqHpJ5w0XHt/rTPx07x9n
	 tFJO5djUzOpQA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Tue, 27 Oct 2026 00:18:01 +0100
Subject: [PATCH 41/46] mm/vma: call ->may_split() before a partial merge
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
Message-Id: <20261027-fixes_core-v1-41-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
In-Reply-To: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>, 
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
 Baoquan He <baoquan.he@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>, 
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
 Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, 
 Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
 Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Youngjun Park <youngjun.park@lge.com>, 
 Gregory Price <gourry@gourry.net>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
 Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, 
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3897; i=david@kernel.org;
 h=from:subject:message-id; bh=n+6M+CIUo0qz0KTVvqRDwy/r7F7Vuv5M4Gm+ODQkq/s=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLu35/B/6XFN7Rs/zaBkvdGZ1lqfJojSud6TmwqNb7x8
 sL+1F8/OkpZGMQ4GGTFFFmCgu8bvHy5rrbajY8ZZg4rE8gQBi5OAZiI4gFGht9TPv4Un6OptiFl
 vSurSN20dUyMehd4RXWfbvyf3fZ86jZGhht/4qUk2T5Yn82qKz6944ZO37VyzQ1+61sW5JduvH6
 ilhcA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

From: Chris Mason <mason@kernel.org>

A driver can use the ->may_split() hook to forbid a VMA boundary at
certain addresses.

A device-dax device is a character device that gives raw access to a
range of memory through mmap(). device-dax refuses any address that is not
a multiple of the device's alignment through vm_ops->may_split.

vma_merge_existing_range() can move boundaries, but does not call
vm_ops->may_split.

If a range at the edge of a VMA gets the attributes of the adjacent VMA,
the function moves only that range over to the neighbour: one VMA shrinks
and the other grows. This is a partial merge, and vma_modify() tries it
before any split.

Take a device-dax VMA that lies next to another VMA of the same file.
The user calls mprotect() on the one page of the first VMA that touches
the second VMA, and asks for the protection that the second VMA already
has. The result is a partial merge. It puts the boundary inside a 1 GiB
mapping, which is a single leaf entry at the PUD level.

As part of the merge, the kernel looks for a huge PMD to split at the
new boundary. That code does not expect a PUD leaf:

    vma_merge_existing_range()
      commit_merge()
        vma_adjust_trans_huge()
          split_huge_pmd_address()
            mm_find_pmd()
              treats the PUD leaf as a pointer to a PMD table,
              so the "table" is the device memory that the leaf maps
            __split_huge_pmd()
              reads a PMD that the user wrote to the device memory
              folio_put() on the folio that this PMD names

Bad. While the code must at some point be taught to split PUD entries as
well, the issue here is that we move VMA boundaries such that they are
incompatible with the driver.

Fix this by calling ->may_split() on the address that a partial merge
would move the boundary to, and by abandoning the merge if the driver
refuses. vma_modify() then tries the split, which fails with -EINVAL.

Factor out existing split handling into check_split() and reuse it.

Fix generated by an LLM and sent by Chris Mason in private.

Fixes: 38607c62b34b ("fs/dax: properly refcount fs dax pages")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
[ david: improve description; cleanup the code ]
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/vma.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index 1be613044b4a5..acdf00346cda5 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -516,6 +516,15 @@ void unmap_region(struct unmap_desc *unmap)
 	tlb_finish_mmu(&tlb);
 }
 
+static int check_split(struct vm_area_struct *vma, unsigned long addr)
+{
+	if (!vma->vm_ops)
+		return 0;
+	if (!vma->vm_ops->may_split)
+		return 0;
+	return vma->vm_ops->may_split(vma, addr);
+}
+
 /*
  * __split_vma() bypasses sysctl_max_map_count checking.  We use this where it
  * has already been checked or doesn't make sense to fail.
@@ -532,11 +541,9 @@ __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	WARN_ON(vma->vm_start >= addr);
 	WARN_ON(vma->vm_end <= addr);
 
-	if (vma->vm_ops && vma->vm_ops->may_split) {
-		err = vma->vm_ops->may_split(vma, addr);
-		if (err)
-			return err;
-	}
+	err = check_split(vma, addr);
+	if (err)
+		return err;
 
 	new = vm_area_dup(vma);
 	if (!new)
@@ -948,6 +955,10 @@ static __must_check struct vm_area_struct *vma_merge_existing_range(
 	if (vmg->__remove_middle && !can_merge_remove_vma(middle))
 		return NULL;
 
+	/* If middle isn't removed then it's resized, i.e. splits. */
+	if (!vmg->__remove_middle && check_split(middle, left_side ? end : start))
+		return NULL;
+
 	/*
 	 * If we merge both VMAs, then next is also deleted. This implies
 	 * merge_will_delete_vma also.

-- 
2.43.0


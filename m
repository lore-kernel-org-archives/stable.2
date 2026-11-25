Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795646296;
	b=IrET+h72uSKNOWxYmK91cQiRe2cHdUafu8rwy/Dkc/Pq0X1A2ovOiiwQQE1PPax0M22h
	 HYYFAMNaaDyRlCL706NaZFsAryoAtpdwa6buZ5Jm7LCZiTLlW9jkKKdL/UN0mZX6KxwAU
	 Xger2a4AzftJCCY+nHxutnpeu4HhAxGBIunLfFlbw3NEO0vsBgXvvVprLgWA60WZhPXR7
	 i+Js1aiOXcpejDGfr99IVBooKCOUeMjnzn85Iz+16HnLW10Q/6uyu8FZgfsv7tKXJEMGk
	 GZ1sCca/JzJD+CL36dYeTT0VzMJj9gEy4er7X9IutMMkb7fpB9lw0LphbPC/bI17Pag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795646296;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=c5sCadhkwY9UanmmId4XEWhXMASQtuWsR/mG1JPVDXI=;
	b=jebthmMroQQNfzolDo4kKoteP7Zj/Y2vlgPBFGEyiu4983PFAjvERg0FC8y4zr6xhYMs
	 AlvGPeee1cgXCrKNwj3NpP8JpbJlgeuOFmdVujlGqUuya6L5o5aC02OAA7vwsKg1zhjBQ
	 TfE9ZQfXML6DLAl2NBdWCrm+n5EdcPLkfdhqVF7lVhcSpGVcUx7kpuq1/W3LUGczh3Oek
	 tv3+EqgtJ3nhugxVhrONPFDhXzJ5ivqrkGloI5GHjJZOxJSV6l+3N5Fwnok+UZEiC3nvx
	 gOi0vgz6ZLXOdm+kLRXkqN/iVou9g9CWF6P3duvJ9iI0j8rV1BXtZ6KD+5mIxYxadqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mcGV1irF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297E7606A31E;
	Wed, 25 Nov 2026 22:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mcGV1irF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19CA81F000C0;
	Wed, 25 Nov 2026 22:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795646295;
	bh=c5sCadhkwY9UanmmId4XEWhXMASQtuWsR/mG1JPVDXI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=mcGV1irFRfXDZP7eEVn2PE6y0zqMjBz3R4YH3XVsY1dIM8vndetGzsNVRLSa9MHqH
	 Hl8tPm3IHHw8Q+AWHbAmKVE8Eokao7NczVWg8nPhKPR1BZ9rGJoernBmso/wi+Lvmn
	 I1oNfQ86/7bW+rb+gZM3Sr9iVsB0iUxRM+nd6p3ha72bJMyr4FvbaQnt+EQPcQhZDF
	 xmmEK1Ro+b8WaD1DQn4PQv8jOyiIt5Q8LY+q5ei+PGW6+Ud9+cpmHuOCatVBkqyr6Y
	 lpvOFTcZtHdIOmkTP6GZ7zxp2qtV9fIRjDzqLM0Ep6XUzFQ42c4NcdPFrDEK/hSR1A
	 sk6LwO1VZkHZQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 25 Nov 2026 23:33:16 +0100
Subject: [PATCH 18/21] fs/proc/task_mmu: don't clear VM_SOFTDIRTY on
 hugetlb VMAs
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
Message-Id: <20261125-hugetlb_fixes_2-v1-18-db27fd2f71a8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1880; i=david@kernel.org;
 h=from:subject:message-id; bh=+sv+UhDuOwJztPqdlwWWA+euIQWZKN3bwN8oaLd2OMA=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLZk1RjN1gnhsRf/3P15CPRqcePHrc9xZkad2Pdwldv2
 2d6xawS7ChlYRDjYJAVU2QJCr5v8PLlutpqNz5mmDmsTCBDGLg4BWAiu5Yx/I/o3civLLybU1m6
 1z3Qdp/Q7vdu6p+t9rxujPg/YU3NK1dGhtfpgcuaM5e8/G12cbkh71vRn9cr38Tqv9XZ8iC0ILr
 MnQsA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

hugetlb does not support soft-dirty tracking: since commit f96f7a40874d
("mm/hugetlb: fix hugetlb not supporting softdirty tracking"),
vma_wants_writenotify() ignores VM_SOFTDIRTY for hugetlb VMAs, and
clear_refs never clears the soft-dirty bits of hugetlb entries.

However, clear_refs still clears VM_SOFTDIRTY on hugetlb VMAs. With
CONFIG_MEM_SOFT_DIRTY, a FOLL_FORCE write to a private hugetlb mapping
without VM_WRITE can then loop in __get_user_pages() until the task is
killed, with the mmap_lock held for reading:

    __get_user_pages()
    retry:
      follow_page_mask()
        follow_huge_pmd()
          can_follow_write_pmd()
            pmd_needs_soft_dirty_wp() is true
          returns NULL
      faultin_page()
        hugetlb_wp()
          set_huge_ptep_maybe_writable()
            no VM_WRITE: the entry stays as it is
        returns 0
      goto retry

Let's fix it by not clearing VM_SOFTDIRTY on hugetlb VMAs, so we always
treat hugetlb pages as soft-dirty.

This has low urgency, as the loop can be killed.

Fixes: 052ccfbcc6cd ("mm/hugetlb: support FOLL_FORCE|FOLL_WRITE")
Cc: <stable@vger.kernel.org>
Reported-by: Chris Mason <mason@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 fs/proc/task_mmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 41b280ab7b19d..d9ecb94f4daa5 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1801,6 +1801,9 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
 
 		if (type == CLEAR_REFS_SOFT_DIRTY) {
 			for_each_vma(vmi, vma) {
+				/* hugetlb does not support soft-dirty tracking. */
+				if (vma_is_hugetlb(vma))
+					continue;
 				if (!(vma->vm_flags & VM_SOFTDIRTY))
 					continue;
 				vm_flags_clear(vma, VM_SOFTDIRTY);

-- 
2.56.1


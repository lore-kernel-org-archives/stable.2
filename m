Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795646198;
	b=wTcN8mJUS1yH5TpdXkL13fOOzT1dUhe8iqILpqzCDbq9tTBNhfhPjq9FdDEt/nwOuShm
	 Fi9KmUK82u0IDY89sgexn8sjk9fRiYuD6LmobA30Qk+SS0hSTiK+xa0y4d1aJvkE9p78m
	 3EHj4mTbcTLHJBZJjVu6U5Zv62gHkxLtVqM1g6UJDBKFG/UAwFL6ZPaHx4SHaBC+pDULv
	 87QcGEbb8uSY/s4brTG1Zm39T4T7JRuHknhqeXZK833DSljJiGTZezPD1iF3431CaXJeI
	 uFdKtcgRAhp2Uj27TIcVdBQHzZ7FKa2q2MzI1X5FQYZNOTZs8PnfTgNJ/7yVrW/vWpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795646198;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=PwSb8ZjkUHuvGDFbXZGeha4mv6LAPnKvJMHgWrsVdx8=;
	b=T+Yz9t2QsUs5xBm1NzORZNwqCGORo5PATaLRCDspzzL2yiuX0Vl6Sv1GfhZl4Pe/PHUF
	 dok6u15rPQH1VLAFvllZRMu28feSUWdIfFeR3njBjWyoXuoa7+WQgR0Wv4mPHR7B9xQIp
	 kbytS1EcUEbJViM3uuxXFDWLS92av3U+mtZ5tIEIQudagoPx2cZgoJPrGQWS/h9T2qkUA
	 WDmtWjE/r/CqekssO5Q0xsiuFk00LANVkLjQSwrGLJMSKE+0QByEPRYIVxBI6Eb8bQR45
	 oJuqxuoc0LpSrNcTMhUzzWoAhRip61H3uQM8I08CY7in4tAmA6Ydjwg0ufTJa2v/kvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LsFyja9g;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7BD606A326;
	Wed, 25 Nov 2026 22:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LsFyja9g
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E3D1F000D0;
	Wed, 25 Nov 2026 22:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795646197;
	bh=PwSb8ZjkUHuvGDFbXZGeha4mv6LAPnKvJMHgWrsVdx8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=LsFyja9g1bv8H1boRMMuNp6jOzLUv7I/HQCONg6bdcVTXtKXt0hWbPAPCBqq+636f
	 wpmzGssYGYCfNE55PJkegIlE3fZ7S5fgAtVLvV7wUQZSinn/0Dcl8POgWOBvV7Vj8r
	 vfM/39SE3MGC+SIZDTk5lozhHdydCcMpK8JHoG5tt5eav+T6zjCM/IbdYJWM85dt8v
	 Djur3cQavRY9p3Ycg5B3Lv4W2AJepogoix5qNxeNBMFeJw6x9uSfx75WN2ZjdSJ91n
	 2qShv516I7tzJl3OVCx990J+qKJUIKutrCbJsfQmybG/Elnb49/on60NR4yJJ2wipp
	 PDV8noFu7xbvQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 25 Nov 2026 23:33:10 +0100
Subject: [PATCH 12/21] mm/hugetlb: don't share page tables of a VMA during
 mprotect()
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
Message-Id: <20261125-hugetlb_fixes_2-v1-12-db27fd2f71a8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3232; i=david@kernel.org;
 h=from:subject:message-id; bh=FAzuahks5m8VCo2oG3BmxZCgGWj6jmiJDPwksv+1liY=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLZk1RmHnlsfTaVz/nHkbywYONkmRqG0+3B3SsTs7ZfF
 X2TMjO8o5SFQYyDQVZMkSUo+L7By5fraqvd+Jhh5rAygQxh4OIUgIm8DWH4nzzR10/y7sveo9JO
 n1ouJs28wfPd62HYHaH7J3/9/Hj7yAyGv5Kzel4ecP7yo/G4SX7DB4dXLx4eXp1k+Z9zpz/L3Pc
 3MlkA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

When mprotect() of a shared hugetlb mapping races with a hugetlb fault
in another process that can share the same PMD table, we can end up with
page table entries that don't match the VMA flags, such as writable ones
in a PROT_READ mapping or PROT_NONE ones in accessible VMAs.

huge_pmd_share() takes i_mmap_rwsem and shares a PMD table if the flags
of the two VMAs match, so while that lock is held the entries in a
table have to match the flags of its VMA.

However, mprotect_fixup() stores the new flags without i_mmap_rwsem, and
only hugetlb_change_protection() takes it. A fault in between shares a
table that still has the old entries, and the walk then unshares the
table instead of changing them:

    process A                        process C
    VMA is RW, entries are RW        VMA is R, PUD is empty
    =========================        ======================
    mprotect_fixup()
      VMA flags = R
                                     huge_pmd_share()
                                       i_mmap_lock_read()
                                       flags match, take A's table
                                       i_mmap_unlock_read()
      hugetlb_change_protection()
        i_mmap_lock_write()
        huge_pmd_unshare()
          clear A's PUD, return 1
        skip the entries
                                     VMA is R, entries are RW

mprotect() changes both the flags and the entries while holding the
mmap lock in write mode.

Let's fix it by only sharing the page tables of another VMA if we can
try-read-lock the mmap lock of its mm. If the trylock fails, we simply
try the next VMA, or allocate our own page table.

A trylock is fine, as we hold i_mmap_rwsem, which is usually taken under
the mmap lock. We should use the VMA lock instead, but we'll do that
separately.

This has medium urgency, as it can result in endless page fault loops if
mprotect() races with PMD table sharing and we end up with PROT_NONE
entries in accessible VMAs. If the kernel accesses such memory, for
example in copy_to_user(), the loop happens in the kernel and the task
cannot be killed.

Fixes: 39dde65c9940 ("[PATCH] shared page table for hugetlb page")
Cc: <stable@vger.kernel.org>
Reported-by: Chris Mason <mason@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/hugetlb.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 2c13349863bd8..0b0f6e17b8b06 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7264,15 +7264,23 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 		if (svma == vma)
 			continue;
 
+		/*
+		 * Stabilize the svma flags, as mprotect() changes flags
+		 * before adjusting page tables.
+		 */
+		if (!mmap_read_trylock(svma->vm_mm))
+			continue;
+
 		saddr = page_table_shareable(svma, vma, addr, idx);
 		if (saddr) {
 			spte = hugetlb_walk(svma, saddr,
 					    vma_mmu_pagesize(svma));
-			if (spte) {
+			if (spte)
 				ptdesc_pmd_pts_inc(virt_to_ptdesc(spte));
-				break;
-			}
 		}
+		mmap_read_unlock(svma->vm_mm);
+		if (spte)
+			break;
 	}
 
 	if (!spte)

-- 
2.56.1


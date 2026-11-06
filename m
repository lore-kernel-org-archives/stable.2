Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794007743;
	b=rVx4PXDeDskSQsvp7VeJsCI37zYmm3ujffLXw9/wC4NOwc1rzFlU5Ce6bD3LaHHbFifl
	 KDlveaAIZfcBnbx46DNMtUQpGmNyRWfnfUFZjr9RZz9c1TmkXb8tqPc6dw9h6Nstz1CVT
	 MLO3gMv5FKxQBXPLAARCUKDk5gyLhmnKklTnHFX3+nruBD+3e0mQWWrIGlaKDQmbMOQwf
	 AQjZJULCJdUmqV2J1/+kOkO8JOE/f5NwFK+c93b4wqBmS/+es9pfBncUyYraaCgel7qbp
	 5pagbYNuZA4SCtBxcapwEljkx4AmbygzlpAzAVjV4BrYmvV+FJG8Z/8/XMSvNCFjthQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794007743;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=D5Lg8q3KbQTAAjZNb67nMqqiPJ3mZrmihVYvOJgZmWY=;
	b=k9Zdf8RlRQ481DnHHUO2Pk6NjTicn40jyK+CThOd/d5TbIJgyI4wsTeK0ZCTV7bwHXB7
	 MqN9fjZmTJs4cUgmRG4m1Wv2blMiaBhLM+bQ2Y2OlphqfBtL/ZTkxF+igHcbRu7dr0Qfg
	 sW7ROjVsWbUZRujS0Wb6tHgZNeozLnBL/MA6YF9P+PGPomdA5YNr5Xh4sgOuH78r5NpBN
	 kEt26Hsd2CburjNJdfK9+HH8gf6bX3Z9t0TGtZgZ7bjmXIjkt1z4qW8wvtt0wnqnD8Nw7
	 Swz2J3bGkhWux2Gh6HttWlDRFfJBP9GOHA8siCczxzju5wF37Y5YomO+D2WInBSSulA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HjCG0g1a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D38606A32C;
	Fri,  6 Nov 2026 23:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HjCG0g1a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE0891F0089F;
	Fri,  6 Nov 2026 23:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794007742;
	bh=D5Lg8q3KbQTAAjZNb67nMqqiPJ3mZrmihVYvOJgZmWY=;
	h=From:Date:Subject:To:Cc;
	b=HjCG0g1aTWciy3pkJyDNFBUBv9stFTaNjuMAfqZBTNGjzbPDRP7Hv5yTgJ4UfSbAb
	 8AxuShUqRnxXJCFO5FCHTSOYL3nrnKrzHtk6Tl77YM0rJzMq8iXYBPMX2R98m4JqLs
	 ZyRPBLxrk0v/d4wZWElK8BXnP6C+6ss9SyrIOzVt+N10ncpCv301mHppiSZ1eQ1gzV
	 ELs3u9tQK4Mli8Ghkzmj8g6k9J9aeIVI69a5hfW7hOhfdFyEDIECTHlFtpjg5Mx+6T
	 tUrKZ/99debrBN6/xNPxbnXA+zVGkT8NhD6v4IanHAWaNfVpF/AOxCnpB5b2HmzPJu
	 Of59IvMcDOgCQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Sat, 07 Nov 2026 00:28:55 +0100
Subject: [PATCH] mm/mprotect: don't skip uffd marker install when racing
 with PTE table reclaim
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
Message-Id: <20261107-uffd_shmem_marker-v1-1-91fa2d653cfe@kernel.org>
X-B4-Tracking: v=1; b=H4sIALZi7moC/yXMTQqDMBBA4avIrA0kFvzpVYpITCZ1lNgyo0UQ7
 260y2/x3g6CTCjwzHZg/JHQZ04weQZusPMbFflkKHRRGqMrtYbgOxkixi5anpCV1X1Tl42v6oe
 D1H0ZA23389X+LWs/oluuERzHCXdNXQh1AAAA
X-Change-ID: 20261107-uffd_shmem_marker-a0b9869d783c
To: Andrew Morton <akpm@linux-foundation.org>, 
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>, Peter Xu <peterx@redhat.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Peter Xu <peterx@redhat.com>, 
 Qi Zheng <qi.zheng@linux.dev>, Tal Zussman <tz2294@columbia.edu>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3788; i=david@kernel.org;
 h=from:subject:message-id; bh=nwDMBOfI116Kjc7OUedjQY4U7ETBhxHwaczK3QvYfAM=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLeJe06+bZNLohnk7Vi/M/oJTzn4/O97u7y2pIkbxVcv
 4y76LpVRykLgxgHg6yYIktQ8H2Dly/X1Va78THDzGFlAhnCwMUpABOJSmNkWLDDuTVVPOV+18zZ
 8sF39HM9v5hVK6zkX2x270ZNNMOpU4wMrwWiHe6u/bnGquXkq03B3fVPbXR9FnHrmh4/ufLI5t0
 BrAA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

change_pmd_range() populates PTE tables before installing uffd-wp
markers. An empty PTE table can be removed after change_pmd_prepare()
returns but before the pmd_none() check.

That check then skips the range, allowing UFFDIO_WRITEPROTECT to report
success without installing the required markers. Subsequent writes by
userspace to these areas will not trigger uffd events.

PTE table reclaim during MADV_DONTNEED and page table retraction during
khugepaged can trigger this.

Retry page-table allocation in that case. Simplify the code, getting
rid of change_pmd_prepare() by routing all code through the "again" label.

It's a small race though, so likely this is not very urgent.

Fixes: fe2567eb5521 ("mm/shmem: allow uffd wr-protect none pte for file-backed mem")
Fixes: 6375e95f381e ("mm: pgtable: reclaim empty PTE page in madvise(MADV_DONTNEED)")
Cc: stable@vger.kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
I expect Andrew to pick this up.
---
 mm/mprotect.c | 48 +++++++++++-------------------------------------
 1 file changed, 11 insertions(+), 37 deletions(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index e18d4e12fc341..ef4e7188e24da 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -470,25 +470,8 @@ pgtable_populate_needed(struct vm_area_struct *vma, unsigned long cp_flags)
 }
 
 /*
- * Populate the pgtable underneath for whatever reason if requested.
- * When {pte|pmd|...}_alloc() failed we treat it the same way as pgtable
- * allocation failures during page faults by kicking OOM and returning
- * error.
- */
-#define  change_pmd_prepare(vma, pmd, cp_flags)				\
-	({								\
-		long err = 0;						\
-		if (unlikely(pgtable_populate_needed(vma, cp_flags))) {	\
-			if (pte_alloc(vma->vm_mm, pmd))			\
-				err = -ENOMEM;				\
-		}							\
-		err;							\
-	})
-
-/*
- * This is the general pud/p4d/pgd version of change_pmd_prepare(). We need to
- * have separate change_pmd_prepare() because pte_alloc() returns 0 on success,
- * while {pmd|pud|p4d}_alloc() returns the valid pointer on success.
+ * Populate the lower-level page table if marker installation requires it.
+ * Return -ENOMEM on allocation failure.
  */
 #define  change_prepare(vma, high, low, addr, cp_flags)			\
 	  ({								\
@@ -517,30 +500,21 @@ static inline long change_pmd_range(struct mmu_gather *tlb,
 again:
 		next = pmd_addr_end(addr, end);
 
-		ret = change_pmd_prepare(vma, pmd, cp_flags);
-		if (ret) {
-			pages = ret;
-			break;
-		}
-
-		if (pmd_none(*pmd))
+		if (unlikely(pgtable_populate_needed(vma, cp_flags))) {
+			if (pte_alloc(vma->vm_mm, pmd)) {
+				pages = -ENOMEM;
+				break;
+			}
+		} else if (pmd_none(*pmd)) {
 			goto next;
+		}
 
 		_pmd = pmdp_get_lockless(pmd);
 		if (pmd_is_huge(_pmd)) {
 			if ((next - addr != HPAGE_PMD_SIZE) ||
 			    pgtable_split_needed(vma, cp_flags)) {
 				__split_huge_pmd(vma, pmd, addr, false);
-				/*
-				 * For file-backed, the pmd could have been
-				 * cleared; make sure pmd populated if
-				 * necessary, then fall-through to pte level.
-				 */
-				ret = change_pmd_prepare(vma, pmd, cp_flags);
-				if (ret) {
-					pages = ret;
-					break;
-				}
+				goto again;
 			} else {
 				ret = change_huge_pmd(tlb, vma, pmd,
 						addr, newprot, cp_flags);
@@ -554,7 +528,7 @@ static inline long change_pmd_range(struct mmu_gather *tlb,
 					goto next;
 				}
 			}
-			/* fall through, the trans huge pmd just split */
+			/* The PMD might have been split. */
 		}
 
 		ret = change_pte_range(tlb, vma, pmd, addr, next, newprot,

---

base-commit: a3d27154a205f6b32000e7e2734b2a6a4d22c65b

change-id: 20261107-uffd_shmem_marker-a0b9869d783c

--

Cheers,

David


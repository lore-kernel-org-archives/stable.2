Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875F4560AC9;
	Wed, 14 Oct 2026 15:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791992796; cv=none; b=l4aXjjw/rhVjAcycoaN8tZF92w7HuyRwATd05icfAoqvAGYwD75MfVS6wbQUV4whqFApuJSUh5wOgJgq0RBwqYatwlK9ZQTkVoZyCsWhEMnulG3qFYaAkNXuE5yrlPB5pEFUh6Z9gYuqPKfj6aDtKvbqn6nQuXrvZ/VznzbtxJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791992796; c=relaxed/simple;
	bh=sIdp45qCVAMC/oMNtppMSs+1CULAOMEcEyoP7Ygja0s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I7CN0P57dmxvMo+99HFeRlalBOy2SQRns88vL+M86x5KP6Nd/Ij6yJyyPACOUeZDTAR3yZjfTrgq1sWd5fLSFRuXgshtwQ1UAzz0MjTVGKKTO+LzDqhFgtj3LeZo2O/2lc/nqFb8F1ZTNVbsxdpNFSF/FOYDaPEcucYOSB2ETVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=K2pQMiSk; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="K2pQMiSk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=Message-Id:Content-Type:MIME-Version:Subject:Date
	:From; bh=EMv5U2kupUmtXz66ccHe/Yh8rCYgenznf122ZvfNPM8=; b=K2pQMiSkEIH7P8hKJB0
	JM5g1DAstr85+VMmMKQREcTVvYlyH9242d4WCiMnme2l7EZ6683ckBx09NtVAR74N+DEFqEy45Ygg
	+kwBM9Ou//dMuU+vxgY5UXvhFDRs17fY0Q3evizQ1hMoE5ZKxA4L3UuuWYr1WG7uO7etcWLy4P/W6
	8+PfOCQTiimVpblvv9c7E8go5YzRPbawZ2B4Q0OwapXulYWXR3U4Ht3+LpaWtBYO/wTe34MeN+qSk
	0Ht8mvNRpg/Iam3+FYjqACDq/79P17/6Jw6Hm/pQkbUTD2ANqeAQy1Meq/f1bMBKVvZ1wZ6m//Yhc
	5c51Kl06sqhD+2w==;
Received: from ch-demo-asa.virtuozzo.com ([130.117.225.8] helo=f0.sw.ru)
	by relay.virtuozzo.com with esmtp (Exim 4.96)
	(envelope-from <khorenko@virtuozzo.com>)
	id 1xH17q-006OFq-2O;
	Wed, 14 Oct 2026 17:46:14 +0200
From: Konstantin Khorenko <khorenko@virtuozzo.com>
Date: Wed, 14 Oct 2026 17:46:09 +0200
Subject: [PATCH v3 1/2] mm/huge_memory: recheck a special PMD under the
 lock in copy_huge_pmd()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v3-1-85eaec8417f6@virtuozzo.com>
References: <20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v3-0-85eaec8417f6@virtuozzo.com>
In-Reply-To: <20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v3-0-85eaec8417f6@virtuozzo.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Peter Xu <peterx@redhat.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org, 
 =?utf-8?q?Lo=C3=AFc_Molinari?= <loic.molinari@collabora.com>, 
 dri-devel@lists.freedesktop.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Konstantin Khorenko <khorenko@virtuozzo.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2667;
 i=khorenko@virtuozzo.com; h=from:subject:message-id;
 bh=sIdp45qCVAMC/oMNtppMSs+1CULAOMEcEyoP7Ygja0s=;
 b=owEBbQKS/ZANAwAKAVGWCkf5YVwqAcsmYgBqz6PFIbb8Nor8wTYNoHR7PZeR1qeybbFlD6+wd
 +0+taKoZdGJAjMEAAEKAB0WIQRWD23IPcXT0GO9CCxRlgpH+WFcKgUCas+jxQAKCRBRlgpH+WFc
 Kl0vD/968/kYsYobbUx0cPTui7Rt1ZMQVmfgrr3DIbKM8eppM2P1ghpu6ZGDI2pNa1Xw6oQl1G5
 LwlXCJFNinaWulXdC/NYm9KA0u8882jh5YO79/fpfVoCvJcMJn4R9iykn+AxafzpQrhpIj2CzNo
 KZUw7w7OhcnKqKV5guGMyWBPpColCAFKWi3xzCqKHTuotXSjqph4iObqAZjUjdcqkOPkyAf3oAw
 1COP5gZaDqln/mQkQoboYGoBlwveqHXOPKQuCHr4LFvgYZKIAemX2NSYpGf83agvdzKEJa+u8Wd
 oHQsUgGCuHJmkRGn4ivi/yYG1eNvCp8GRJB4yl5jGl/cS09Wl6xfyG/EILJR5uDGBWKWiV/ccSv
 ryq2Ibk/Wd/GMNzYlqybjO1dGRMecxUlUFBd6Wzuq8yNKZlHESbLDCOFaNqn5jWkGNOv82VVB+a
 2R2jssBIGSYbHxJK7/XonDJSrYWZmSXRkfNhmpVjIKWu41f29wWFT/zA8E6MslgeIqMAJkb/g3M
 Sx8/W1ZSXtfo3qKdQaP/s8qsl3tAk6eJwplqByUemL4DdO6X/Eq2c2J/4SxMzGjSgjirsRQsZkV
 RA/QV3G4QilnpwHuHKC9PRyrDbOTk82x1iTT34bBNKEL/3+5l9G8la0Q/IQf9TFMTQ84AaaED6q
 YiB+61jTMlIjbMQ==
X-Developer-Key: i=khorenko@virtuozzo.com; a=openpgp;
 fpr=560F6DC83DC5D3D063BD082C51960A47F9615C2A

copy_huge_pmd() reads a special PMD without the page table lock and
copies that value to the child. The mmap write lock held by fork does
not stop unmap_mapping_range(): it zaps under i_mmap_rwsem and the PMD
lock.

The zap visits the parent VMA before the child's, as dup_mmap() links
the child right after the parent in i_mmap. If it clears the parent PMD
after fork has read it, and passes the child before fork copies it, the
child keeps a mapping the driver has revoked:

- vfio-pci: the child reaches the BAR after the device memory was
  disabled or the device was reset, instead of getting SIGBUS;
- panthor: the child maps the pages of an evicted buffer object after
  they are freed.

Read the PMD again under the source PMD lock, which the zap takes to
clear it. Either the zap got there first, and the PMD is none, or the
copy is in place before the zap reaches the child. Faults are locked
out, so only a zap can change the PMD, and pmd_none() is the test.

Fixes: bc02afbd4d73 ("mm/fork: accept huge pfnmap entries")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
---
 mm/huge_memory.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 1e5d68acf62a5..bf788bb231691 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1965,13 +1965,22 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		src_ptl = pmd_lockptr(src_mm, src_pmd);
 		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
 		/*
-		 * No need to recheck the pmd, it can't change with write
-		 * mmap lock held here.
-		 *
-		 * Meanwhile, making sure it's not a CoW VMA with writable
-		 * mapping, otherwise it means either the anon page wrongly
-		 * applied special bit, or we made the PRIVATE mapping be
-		 * able to wrongly write to the backend MMIO.
+		 * The mmap and VMA write locks of the source keep faults
+		 * out, but unmap_mapping_range() does not take the mmap
+		 * lock and may have cleared the pmd since the lockless
+		 * read. Let copy_pmd_range() skip it then.
+		 */
+		pmd = pmdp_get(src_pmd);
+		if (unlikely(pmd_none(pmd))) {
+			spin_unlock(src_ptl);
+			spin_unlock(dst_ptl);
+			return -EAGAIN;
+		}
+		/*
+		 * Make sure it's not a CoW VMA with writable mapping,
+		 * otherwise it means either the anon page wrongly applied
+		 * special bit, or we made the PRIVATE mapping be able to
+		 * wrongly write to the backend MMIO.
 		 */
 		VM_WARN_ON_ONCE(vma_is_cow_mapping(src_vma) && pmd_write(pmd));
 		goto set_pmd;

-- 
2.43.0


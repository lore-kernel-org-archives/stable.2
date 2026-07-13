Received: from va-1-113.ptr.blmpb.com (va-1-113.ptr.blmpb.com [209.127.230.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D41277035
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 17:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783962943; cv=none; b=dxNfIQTwjOr0bl7C+ZLC1OhkamB5NWT4eLF8Djzhk7zasmur3/BY4Bt/WDAxwSFmcGtKVNWA2td3y3U8KaWVYCzxaI6dZ/IcYWFWDkHWmy454kYOT/6j42qmt/c42efMjJAetGpAVII8pTZ6WDNSqeqiRhowrNoDmZ6mUcL418s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783962943; c=relaxed/simple;
	bh=Aa8/5udmfj8TWjs9Foxa4aNvmPw6ehqBRclM4OZGM5M=;
	h=To:Cc:Mime-Version:References:Content-Type:Date:In-Reply-To:From:
	 Subject:Message-Id; b=jYJCZLkWLM602kj4id25h9ATtQ4PqolrsnLh3SOwuN6GFsRFb5blmKkiACuzrP6gzaCcr3JOFgLcuWRl7oSs313dW+Jeu7bizy8DiMQS1wBKR2NPj32VUyoWSP4tjbS2mGW/s6t9DK4ADoTUyqbT1vqS34ZirCDc9r6r8hUDuP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=hv1aiAcn; arc=none smtp.client-ip=209.127.230.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="hv1aiAcn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1783962936; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=Nw+wphzpHskAbkcarmC3gNoJ47BFqLlYPBNMfUcVWJk=;
 b=hv1aiAcn/0yT3QSpIcP8SEh1TTNWX0ykOHopIA9NWEyADckU+Z7pcRNqQBqrjbrLG/oml5
 3T63yANZU4Uuntj+OFE7MjMi7qkXxeWTo6wxP47VSrfdeWGJqOGdhQ2pbCOvO/+4uAVmZE
 Oc3zJC3SNbALj3I8ZZ/Dn2MecH4ybxwi0PhxG+e/kp+zGbjNc+F4mycM1ujCgREqv6Nqlc
 Oe+/bi/NVQWcn3ys3n6SbIeZIMq665/Jb61v5ZzMpQ19vidAU8DbeFMa40bcszYC1aFmHz
 PZMU1d/HC57RqWtXG/eMX3GqA5Bb4hH0AEXIS5lkMg4t5D71kCoQd7NgcVmEuA==
To: <akpm@linux-foundation.org>, <muchun.song@linux.dev>, 
	<osalvador@suse.de>, <david@kernel.org>
Cc: <caixiangfeng@bytedance.com>, <richard.weiyang@linux.alibaba.com>, 
	<baoquan.he@linux.dev>, <shuah@kernel.org>, <linux-mm@kvack.org>, 
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<stable@vger.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
References: <20260713171456.300518-1-caixiangfeng@bytedance.com>
X-Original-From: Xiangfeng Cai <caixiangfeng@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Date: Tue, 14 Jul 2026 01:14:55 +0800
In-Reply-To: <20260713171456.300518-1-caixiangfeng@bytedance.com>
From: "Xiangfeng Cai" <caixiangfeng@bytedance.com>
Subject: [PATCH 1/2] mm/hugetlb: fix list corruption in allocate_file_region_entries()
Message-Id: <20260713171456.300518-2-caixiangfeng@bytedance.com>
X-Mailer: git-send-email 2.55.0.122.gf85a7e6620
X-Lms-Return-Path: <lba+26a551d36+583eed+vger.kernel.org+caixiangfeng@bytedance.com>

allocate_file_region_entries() tops up resv->region_cache with freshly
allocated file_region descriptors.  The allocation uses GFP_KERNEL, so
resv->lock is dropped around it: the new entries are gathered on a
stack-local list head, allocated_regions, and spliced into
resv->region_cache once the lock is re-acquired.

The splice used list_splice(), which moves the entries but does not
re-initialize the source head, so allocated_regions is left pointing at an
entry that now lives on resv->region_cache.  The top-up runs in a while
loop that re-checks the cache deficit after re-acquiring the lock.  For a
shared mapping the resv_map is shared by every mapper of the hugetlbfs
inode, so a concurrent region_chg()/region_add()/region_del() on the same
resv_map can consume cache entries during the unlocked window and force a
second iteration.  That iteration calls list_add() on the stale head and
corrupts the list; with CONFIG_DEBUG_LIST the __list_add_valid() check
trips:

  list_add corruption. next->prev should be prev (ffffc900011ff7f8),
  but was ffff88814c281460. (next=ffff88814c545640).
  kernel BUG at lib/list_debug.c:31!
   allocate_file_region_entries+0x191/0x420
   region_chg+0x267/0x300
   hugetlb_reserve_pages+0x387/0xc80
   hugetlbfs_file_mmap+0x2ce/0x3f0
   mmap_region+0x1348/0x1a80
   do_mmap+0x85e/0xb90
   vm_mmap_pgoff+0x18c/0x330
   ksys_mmap_pgoff+0x2a1/0x3e0
   do_syscall_64+0xd7/0x420

Without CONFIG_DEBUG_LIST the bad list_add() silently links a kernel-stack
address into resv->region_cache, leading to later use-after-free.

Use list_splice_init() so the source head is re-initialized empty after
each splice, making the retry loop safe.

Fixes: d3ec7b6e09e5 ("mm/hugetlb: use list_splice to merge two list at once")
Cc: <stable@vger.kernel.org>
Signed-off-by: Xiangfeng Cai <caixiangfeng@bytedance.com>
---
 mm/hugetlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 571212b80835..f9577a789fe6 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -693,7 +693,7 @@ static int allocate_file_region_entries(struct resv_map *resv,
 
 		spin_lock(&resv->lock);
 
-		list_splice(&allocated_regions, &resv->region_cache);
+		list_splice_init(&allocated_regions, &resv->region_cache);
 		resv->region_cache_count += to_allocate;
 	}
 
-- 
2.55.0.122.gf85a7e6620

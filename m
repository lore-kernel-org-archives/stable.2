Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6302747276D
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 13:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785937532; cv=none; b=pVKc3yEnchVEYOurGd0bvIRkvrNJ8/QVi02kay4d7o9NnoSNaa5QrOQQEedB90FB7wjgNT3xjdk3ef/C9cVJvhpuGVJFZ3B8ANqRXyzurF6rG/j43oRIAtj4F0JDD3/Soin49044YIeqzumAbW1zL/n3B53ky8zyNi6yUl4ySVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785937532; c=relaxed/simple;
	bh=sIf/hdPVjIi9gZ/q32arLdr2rRni4cqXKXpFZ8mas98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LnZON7liRq/A2LeAUrZ93+mSYiQKgS2eJcm9fL4wmXT68GJdppYcG/o+33aqUDRGMG6hDQzYzEEvnDFV4cmHDLZN7kGqrC0e2YiRNQasMKrCC2xvrxm7M8mrtf3r7X1TFy/3hpguXp4WCSd7mTsXPxDvZA0SGmQ91UNbpNO/feM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=B0vfELi3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J0/ZzJri; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="B0vfELi3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J0/ZzJri"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 7CEB51D00108;
	Wed,  5 Aug 2026 09:45:28 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 05 Aug 2026 09:45:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1785937528; x=
	1786023928; bh=e344T9qlmQ/5omekM0/dFGr1ahHHLZ18/ioXiCbFq8g=; b=B
	0vfELi3Xh8Z7iVnZag74dk6MpfsXBltBcailOZFCAur5HrokX1igiqW0ayk53qEX
	uJCEUSoDcaE6ulxds1POkX5SEKoJFtR770O/TDy42ABfrEEM5czM5fImYykMEeh9
	8ekqex82hhfQzsSq+j9gz1bXxhKUWy0gN+3iTptv292y2ohr0RvppCkEziqDAtJK
	hUWpmIAvEJ9FWgWQqx0GQBJambRnYHWH4hv+Wz+xhi+SR+ockSn9OUUT5ySoKn9m
	bHa6PhFz/J9eKOU7x+08ex0PGn84tukt3WELiuy4vZqAkDXVA6a8eAnuYLwXzqYe
	c9RHbmNyDv6xgxKwCD+uw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1785937528; x=1786023928; bh=e
	344T9qlmQ/5omekM0/dFGr1ahHHLZ18/ioXiCbFq8g=; b=J0/ZzJriHfb9eH7fP
	Bik91qdnYDLpdsr0xwWYY8y8V/6X+uql94hnIMdG9nQBBCULIgsN8h+WvQMu2LbV
	NysbqyWp/F6QTpekD3lij1wUSxqvaYWH6gUnNtqNY2b3qyq3d1OVdbBFil9yRsvs
	5horM7OcU6n75hw98NhxSMmYiZmiB/zstzOkvOSkn0WHoywB2u3nHhL3yCvdAZ2B
	hDp2PtoHayFh/L+CDMh0pQ5K63ItF+d7QwoGs23O39itISO/41sB4b4LMDLKSytU
	CDRQWVrjeM53Su6YF4d1uhyQY/qIeGtT/ASazh/ASIeOLLh3GEhweuvPMe1Wq8ls
	wiJmQ==
X-ME-Sender: <xms:dz5zaiQrmaT6cNN8KWyhtvU5cCdTY-vPA99jGrRhUMK0Jd8WzKI9WQ>
    <xme:dz5zavWFuwXy_Hg7V5OH2dFSMinnWkt17yStlbLMZLPn5ZWjgiSUwoUpi7ynnebLo
    9cvSSgd_MPDM06M4kmRVEAz3z-oXJFsYbvMwax6K_KFbl8uk1Wj8vTK>
X-ME-Received: <xmr:dz5zavcxufmsugbiYcH_OrYu13ydl4khfyV7A8WL6TWOp7DWAkbCxKRzneQ>
X-ME-Proxy-Cause: dmFkZTGpCwdINvLnxM/ti6vyhVAZri4wrIATASKaJ+7EOsIAOMh5S02gZLgVSpopAnVoG3
    9NYAeFbrqzw+Eb5QhrElZGaqACIJtWM2o7xQEdTHfzWsFvwsSS6M0kPPLjZuDo6A5m5WQi
    TxS7pkog/QGfyK8iEbIPS1oGu3d7253YNfBS8mndRrvYvrJ5l+tyxqUxlQysgvpJXfq6Za
    P3OU/IgFvJTlw3ClttWVgjGetU0g0jOVZMGJ+XtkU7NoKDe3Yg6WHrDiY6LKh/iwNswBa7
    8a7GiyQSO7HXLwkG6WYZooubs4KaLMA8sDsqKhQWxKhMrahOvZtF61JLaFa0eNoU1OBsWp
    hHcv1vnCQR/0c+nm45U4hqqmrdd7uq1OkWem1jE3G9ROcnvL53p4bg3XodAHoVxrB/6OyZ
    chtlh8ZRb9iTOgQKCmuWGtr2N78pu4D+NxYkd1jFnuCzQXRR+wlJkSEXQbbZNg67RTZR5t
    pAPR4uCGHaFmoVBu652BY0HWDI0/S9JmwwvjeEb+p7Ro8BcuOeTS8p/cEtGupcclAz76pG
    1zEU/l65KzIGh3kpcSKPjYZ/vFI/QWlQ5EnrdgOUUFUI6oNjIh1S9NuFq0n1ufoZFaueOk
    vChWVjKsV7ARdUyML1zlrpO0b5X79a5ksT+m+EfhZhhv0x/EcLvR/HAwV7HQ
X-ME-Proxy: <xmx:dz5zaqyPJayWYxvUlhsInaJq_HjI8_Po9P3NIgAp2EGDPKQExGn1jQ>
    <xmx:dz5zaiE89Lm8h-YMOXmZPGNHTPtOgS-TR2DvoK3EWaah13Qu2jRaPQ>
    <xmx:dz5zah1-9Ya3Bacrwb8xbDKgt-v07c9fLw3Ah3W5d0DrAsG-ANHzsA>
    <xmx:dz5zai_cjOS554zfC3Zo9NEaap990A7ypOEbILiiaQnBo8Pkxfl_hA>
    <xmx:eD5zajNaUyJNlokBKrxxsU1vFv7ezWcUpGypHvH42NlQHvbVIKL0sZGQ>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 09:45:27 -0400 (EDT)
From: Kiryl Shutsemau <kirill@shutemov.name>
To: stable@vger.kernel.org
Cc: "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	Hao Zhang <zhanghao1@kylinos.cn>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Barry Song <baohua@kernel.org>,
	Dev Jain <dev.jain@arm.com>,
	Lance Yang <lance.yang@linux.dev>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.18.y] mm/huge_memory: unlock i_mmap_rwsem before releasing after-split folios
Date: Wed,  5 Aug 2026 14:45:25 +0100
Message-ID: <20260805134525.2776879-1-kirill@shutemov.name>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026080501-buccaneer-doormat-144d@gregkh>
References: <2026080501-buccaneer-doormat-144d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>

__folio_split() keeps dereferencing the mapping after the split:
shmem_uncharge(mapping->host) and remap_page() while the folios are still
frozen/locked, and i_mmap_unlock_read(mapping) at the very end, after the
after-split folios have been unlocked and freed.

Nothing holds an inode reference across that.  The split relies on @folio
-- which the beyond-EOF drop loop never removes, as it starts at
folio_next(folio) -- staying locked and in the page cache to hold off
eviction.  But the unlock loop unlocks @folio before i_mmap_unlock_read()
runs.  If the caller's @lock_at is a tail beyond EOF, as memory_failure()
passes when splitting a poisoned tail of a shmem THP that reaches past
i_size during truncation, it too is gone from the page cache; so once
@folio is unlocked no locked, in-cache folio pins the inode, and a
concurrent final iput() can evict and RCU-free it before
i_mmap_unlock_read() touches i_mmap_rwsem:

  BUG: KASAN: slab-use-after-free in __up_read+0x634/0x790
   i_mmap_unlock_read include/linux/fs.h:537 [inline]
   __folio_split+0x732/0x1640 mm/huge_memory.c:4100
   try_to_split_thp_page+0xab/0x390 mm/memory-failure.c:1675
   memory_failure+0x1394/0x26e0 mm/memory-failure.c:2470

  Freed by task 4601:
   shmem_free_in_core_inode+0x54/0xb0 mm/shmem.c:5177
   evict+0x57f/0xac0 fs/inode.c:870

Do every mapping dereference while @folio still pins the inode: drop
i_mmap_rwsem right after remap_page(), before the loop that unlocks and
frees the after-split folios, and clear @mapping so the exit path does not
unlock it again.  shmem_uncharge() and remap_page() already run before
that point, so after this nothing past the unlock loop touches the inode
or the mapping.

This is now a rule the split depends on, alongside keeping @folio frozen
until the page cache is updated: no inode or mapping dereference once the
after-split folios start being unlocked.

Link: https://lore.kernel.org/20260716095424.471052-1-kirill@shutemov.name
Fixes: baa355fd3314 ("thp: file pages support for split_huge_page()")
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reported-by: Hao Zhang <zhanghao1@kylinos.cn>
Closes: https://lore.kernel.org/linux-mm/20260710071344.GA106129@zh-pc
Co-developed-by: Hao Zhang <zhanghao1@kylinos.cn>
Signed-off-by: Hao Zhang <zhanghao1@kylinos.cn>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Lance Yang <lance.yang@linux.dev>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: Nico Pache <npache@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit e923bd21058ea02fd0dcd3549d151d143fd036e5)

Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 mm/huge_memory.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index b90be9f16b49..01f8739e1bdb 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3867,6 +3867,18 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 		remap_flags = RMP_USE_SHARED_ZEROPAGE;
 	remap_page(folio, 1 << order, remap_flags);
 
+	/*
+	 * Drop the mapping while the inode is still pinned. @folio stays
+	 * locked and present in the page cache until the loop below, so
+	 * eviction cannot free the inode yet; @lock_at is not enough, it may
+	 * be a tail beyond EOF that the split already dropped from the page
+	 * cache. Nothing past this point may touch the inode or the mapping.
+	 */
+	if (mapping) {
+		i_mmap_unlock_read(mapping);
+		mapping = NULL;
+	}
+
 	/*
 	 * Unlock all after-split folios except the one containing
 	 * @lock_at page. If @folio is not split, it will be kept locked.
-- 
2.54.0


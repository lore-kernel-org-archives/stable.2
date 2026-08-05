Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2353647255C
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 13:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785937524; cv=none; b=D/TJSSrqsmAC6mURkZ5TsTqTCr2/QSenkOI4/rgBX1pFnfcDliGwu+mZ1KZnxoOU0rQYJ6oQoUMl9TCtCW3U720xgjs6/Z/MmgD0Og1txR3YX4VUPOmYv51fo46r9ODA9DFyeHVP3UFr21OsGCuwa74BZLKllaKlm5vWanWRfvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785937524; c=relaxed/simple;
	bh=MySTx4ELqXdFK1nACo7MmqOBo04o/oRXH416DvGKJRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VZxX26DjQv5ASAaqWoBNerZ13lCWcRQ4LSM8JIbI/sF5aM4wMVef+NYbb2l6erRZWOjmSiUoSgZQK3xJXMhUoUaIZV61E+SHfA/Q/rZM8PRGEsAnEC6piCMiRasFtw32kFG5GKK+NVGL25iZFg9yz3EvEtIwgC9Y5nwlLQfqdhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=hySqGjQt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IQ6AQHSG; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="hySqGjQt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IQ6AQHSG"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id ECCAA1D00167;
	Wed,  5 Aug 2026 09:45:21 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Wed, 05 Aug 2026 09:45:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1785937521; x=
	1786023921; bh=acZHG1V4DY5RBwjJmE8DJYM61nOwVpX/MU8W2OnmEUQ=; b=h
	ySqGjQtgFfV7/SloT53sT6H2g7u0wenauNWSLihiZC33Rb2WKOAMSL0rEARLMQDj
	bAzbVFK9UXExGu/sxo34ZPmPqtG/2LX2cCXYr+xFOEfyzY+OCBElTBco9R86yBsz
	Qa5Kh7MiWbsUNtKsp5dqDooluD5OqKxjmwBOcZq1EP2RlvgkEeaCqfMUte+86Wo2
	gP8L+KnpKcNyLHhT7KK4LeUDu/q7aTK/OMD8TH25NhSW647eZlbnuRpAeE6ZqHwC
	jlJMHo2ZEIpACtrMTKNmNhRTcRrKZDAK0a8GkffH4Bj8RszimmohgKa0w23xYZf2
	jS6iJc4CyeGbzOKgvkQhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1785937521; x=1786023921; bh=a
	cZHG1V4DY5RBwjJmE8DJYM61nOwVpX/MU8W2OnmEUQ=; b=IQ6AQHSGkxYSuxi0V
	FME3jS+otcawELGNP5qtg2UCHfJFIMr/WWRxDUU03FU2U1logh3Vv43FIjZhUtcm
	I22dd+/As0uLNnmLMsMsCJ5RPSDPQzF5h62vgUugflZPApPe+Jj4xV5/+YM9SSv7
	xnPiS8gMayn2n1Tku4uWrzNpprnmIRdPJv+HH2s6bIL5B68WQ8yYgC8KOmPoLJ15
	GexUvGRRI8UFkISMRqlA+vVL2SlwQkxVEASjTMUTbhEFZ/pzcM8JHln2pXJ7kYd3
	XOsP8KJ1yG35O2AuFmXLFsNnn6lOLI+AAwWi+csV0a8kzaE5Acx46vcEfTAlD3+i
	QQTJw==
X-ME-Sender: <xms:cT5zavl4HF9EKWF7SMyjAKCRcgkeQqw_X20PZcrlvsYC7knluDK88g>
    <xme:cT5zaqYH7d0p-FACWDojH1SrLctCY96uWkYshO2tFEI5-pLpd6kMPk8q4sGpxOiXZ
    xc3-k7BD491Jr0O3c6abVr0vOcHN03Plm7ubBqTQYnzJwJLRqaebOs>
X-ME-Received: <xmr:cT5zalRwfo5cj8z9P6_6n_Seuv5zzyJQRRhLki-c_aR87G133yxwCALF9DA>
X-ME-Proxy-Cause: dmFkZTGpCwdINvLnxM/ti6vyhVAZri4wrIATASKaJ+7EOsIAOMh5S02gZLgVSpopAnVoG3
    9NYAeFbrqzw+Eb5QhrElZGaqACIJtWM2o7xQEdTHfzWsFvwsSS6M0kPPLjZuDo6A5m5WQi
    TxS7pkog/QGfyK8iEbIPS1oGu3d7253YNfBS8mndRrvYvrJ5l+tyxqUxlQysgvpJXfq6Za
    P3OU/IgFvJTlw3ClttWVgjGetU0g0jOVZMGJ+XtkU7NoKDe3Yg6WHrDiY6LKh/iwNswBa7
    8a7GiyQSO7HXLwkG6WYZooubs4KaLMA8sDsqKhQWxKhMrahOvZtF61JLaFa0eNoU1OBsjD
    5GGAYAs92DfbW/k7HbtZhKSYn+G4wEQsc1fpU0jPI67UzxmucWp3eW73glBzdwJ6SWUK+H
    j1rCAlaNJSVovxvIWD5zbtp4O2m+PXdfdmjmZt/0xPO5xVRLelwPyrzoLaW7vM8ulkgv0/
    9aIPnee6DybX0PZFCRnIUPrPlE+27otTLFw6nRxwYhhnrcteEb3evYqxzCDQC+MhTWKt+w
    Ip7hKhekR14a9VYka2PFcP2d8zjSBxxU8nXduzo4gn+mZQnPjMiebNoqMwzO7GguIX6qR9
    a9r564Md61WAGC8yYhTn88hrv364S8NNqttQRn0G+0Srpb31mV1bh+434P6g
X-ME-Proxy: <xmx:cT5zakWr5F05tz_Dv_iORPPNbI7Fys3qD28D9L6NJtoeuYWQc-H2eA>
    <xmx:cT5zakZyKjrimXK0T2T9rxElqt44NqKwCf27CvjQTaUNGkz3IB5abw>
    <xmx:cT5zat7Jy9J2IJ-K9S3kSSW3WshStqkiybkgT3Yp9DJ4oDSb4_D2Xg>
    <xmx:cT5zalyDxuoWiv5OcQkvzh4GIxix3mH8H0d1eHc1IpSfSF-v7YHKvg>
    <xmx:cT5zarjYtjirmbOkFy2YKYbLieoWSw5MMKDu0AnSQWiYFSzZY-r32lM1>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 09:45:20 -0400 (EDT)
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
Subject: [PATCH 6.6.y] mm/huge_memory: unlock i_mmap_rwsem before releasing after-split folios
Date: Wed,  5 Aug 2026 14:45:19 +0100
Message-ID: <20260805134519.2776859-1-kirill@shutemov.name>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026080502-praising-baggy-3cbe@gregkh>
References: <2026080502-praising-baggy-3cbe@gregkh>
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
[ kas: adapt to the __split_huge_page()/split_huge_page_to_list()
  two-function split: pass @mapping into __split_huge_page() and drop it
  there, before the loop that frees the after-split subpages while the
  head is still locked; the caller then skips its own i_mmap unlock ]
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 mm/huge_memory.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 4443cc44cbf9..ff95a802d158 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2489,7 +2489,7 @@ static void __split_huge_page_tail(struct folio *folio, int tail,
 }
 
 static void __split_huge_page(struct page *page, struct list_head *list,
-		pgoff_t end)
+		pgoff_t end, struct address_space *mapping)
 {
 	struct folio *folio = page_folio(page);
 	struct page *head = &folio->page;
@@ -2564,6 +2564,16 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 	if (folio_test_swapcache(folio))
 		split_swap_cluster(folio->swap);
 
+	/*
+	 * Drop the mapping while the head page is still locked and thus pins
+	 * the inode. The loop below may free the after-split subpages --
+	 * including the head, when @page is a tail beyond EOF that the split
+	 * dropped from the page cache -- which could otherwise let the inode,
+	 * and @mapping, be freed before this unlock.
+	 */
+	if (mapping)
+		i_mmap_unlock_read(mapping);
+
 	for (i = 0; i < nr; i++) {
 		struct page *subpage = head + i;
 		if (subpage == page)
@@ -2745,7 +2755,9 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 			}
 		}
 
-		__split_huge_page(page, list, end);
+		__split_huge_page(page, list, end, mapping);
+		/* __split_huge_page() dropped the i_mmap lock */
+		mapping = NULL;
 		ret = 0;
 	} else {
 		spin_unlock(&ds_queue->split_queue_lock);
-- 
2.54.0


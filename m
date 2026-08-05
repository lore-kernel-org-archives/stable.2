Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B35472F65
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 13:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785937518; cv=none; b=UruNhrpc2ZS2Nl7YQoZryoCO3bOdPzpF88JVqe9mWFA36YQ5thNEf+dxblfKcygq1CcmBXkPuMHDGnEkXR64KpjgTIkWCLp7LEPfUsH0no//7Pj1dyyNvh5RruDItmnuiWEIPTDEqyO3ddmW5YHSwmSAmowJO1Mouz6k1Ecyn+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785937518; c=relaxed/simple;
	bh=dnfmCzjHuVTfGKyyPPZV7aB2Kaj19F0M+2o5/tC0ldE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bfez490u/RFjUctZWpOANVlQQfeU03Hu8aDz0PVoW8p5isph5/lcSkie8F6mjK/Cp52Ae3UrWfYdCl2iLlt8Or1Zrn4jHHVUti3GMl82rdobn3Z3lIptkrNFtgqIX+Gsj6oqSEuCrtsDTCksIixrqfdZaFaOjf90Wqr5DI7VW8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=bOLQTqBh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XaYowWlJ; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="bOLQTqBh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XaYowWlJ"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 525A51D0019C;
	Wed,  5 Aug 2026 09:45:15 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 05 Aug 2026 09:45:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1785937515; x=
	1786023915; bh=N6XDQL5udfymHhFZ/rZPZIp2Kys3itPYgy68Z+5Cqs4=; b=b
	OLQTqBhSGqxzoYSEojL7LNoVwoFzkEDWjOgGzmptzrcInxxP0xEdJLPo/+tx7ba6
	N3jBBd66fdmoh4Xg3CaKxuQDgnyYcqB/5uysAy82zGYZKGP5CPv9EUanJTvt0e6w
	tqkDOZ1Tx9dQiP9Nsmarcqt2zPtYzP1Hde4QJfy3SfScRRQgsRcEmlMMcvdNdi7t
	mde0ZAV+t/k5BGteM1nLlHbmX4hn1uEmBESS2+X0ooqmEGyiM1Vg3IpAtLkfxry4
	XROlgPGun5DFpXLkhIy7yatLGgE/Jg/rB2nJTThn/KC6vOyYzIzjXQkL6Y2mCbBm
	Ngyp3IwogRLjRnrXUsL6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1785937515; x=1786023915; bh=N
	6XDQL5udfymHhFZ/rZPZIp2Kys3itPYgy68Z+5Cqs4=; b=XaYowWlJW7UZc/RLQ
	zFx5IcJmunGR5M0ocecxGKyDpnUMyaDDzag002/SrqZC5TAvuxJh1KgICcB3oHVH
	JJp6hgjtBLNfnCTz/ChdPYjR3vFM7rot16t4nY2PBPio1m8yja19VXBU3jg/jo/b
	lGGSWtvzn9LA6yPTbddXKXlbwROLGqxMyCRz4uVw3G1Xk2rRv+UCJJ5CUiSqdWOb
	DiFG9Dwwy99hmFzmuELcF+DjUoaShPakgGPfX9xi0uuUg2T6yBxyInG8SkuQBuJH
	OZR6eW180EovYF+VJ09Kmgngm506htV8nyPKBAQ4IH75DMappMiiy7qKhmutArio
	++Ctg==
X-ME-Sender: <xms:aj5zagVdgOo0YInuBLAupL0tQwctHEwLIsGLI8Btrrk6HWH0kR4Mbg>
    <xme:aj5zasLoZ5mFDfnyiQbTXcGST2UcEOPQaRMPQpC_BZWlR3AxrwYmPooROWOGQ4398
    P7pyMz-KvzoMZ5DNFHvOZnKT0N5adECmb4TI8MqQHN-JPrrOkdjkaeq>
X-ME-Received: <xmr:aj5zakBx35Wcaz2NQzQtyI74FIibShfkRxmuBcQzlT_upA03dHZzyyJxklc>
X-ME-Proxy-Cause: dmFkZTGpCwdINvLnxM/ti6vyhVAZri4wrIATASKaJ+7EOsIAOMh5S02gZLgVSpopAnVoG3
    9NYAeFbrqzw+Eb5QhrElZGaqACIJtWM2o7xQEdTHfzWsFvwsSS6M0kPPLjZuDo6A5m5WQi
    TxS7pkog/QGfyK8iEbIPS1oGu3d7253YNfBS8mndRrvYvrJ5l+tyxqUxlQysgvpJXfq6Za
    P3OU/IgFvJTlw3ClttWVgjGetU0g0jOVZMGJ+XtkU7NoKDe3Yg6WHrDiY6LKh/iwNswBa7
    8a7GiyQSO7HXLwkG6WYZooubs4KaLMA8sDsqKhQWxKhMrahOvZtF61JLaFa0eNoU1OBsOE
    WgwKONaZ6Ee7tQV0yFWeebvgbHTa1gLNiSzv+ZCCV7uydFZKY+a3RpS10kD3UjNOBvzrGi
    hTcRxvFDjdkWGUA+0N1ZTC8w9ixrAF378Ki6l/nQwu/SVCigR2vCpID5V77CncbgSky1Ho
    y5pS5CHOWCuB4AhV7+FzWaIse+edspN8r/RpsSD0M5TehdvHdmi14f3Wr3i5e14bFLA9zH
    lwYE40IQcvKqqjT8Qf4uU4FOb+dLJ5cCSeiLA3dvqixTJjjkeZb3nc61tKU9rMhRAN+aHt
    7/c8DWLCWrYc1s55gD6EYABdGHsxD1qyaMRsG+8EAEIrgOXOEzYzAljIEo+g
X-ME-Proxy: <xmx:aj5zasEXlioX3_gVdZoRamlDTFqR3_ZC3qOJfHcnKHOGw2PnsxG6PA>
    <xmx:aj5zahILfVMO-oStqFFpf0RCd7bQW7jA_XHTI_gkcsOWUe01PypFdw>
    <xmx:aj5zarogTpS5hTCECLmGGvOtciwOYoQj_oqjIWy0K_TRbSAKbrkmXA>
    <xmx:aj5zaggnH0RDXN6K8gJtL3QoXYvdiyQzUN1mIQQZFw_7fn2dz0PL0Q>
    <xmx:az5zagSEyt9hRutTMmZXkMlsY5_6HflI_3g-Y_jUVoC7SPL36LEsKVZT>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 09:45:14 -0400 (EDT)
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
Subject: [PATCH 5.15.y] mm/huge_memory: unlock i_mmap_rwsem before releasing after-split folios
Date: Wed,  5 Aug 2026 14:45:12 +0100
Message-ID: <20260805134512.2776839-1-kirill@shutemov.name>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026080503-upbeat-facility-22c2@gregkh>
References: <2026080503-upbeat-facility-22c2@gregkh>
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
index 934c08de74f4..94398e024d3a 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2403,7 +2403,7 @@ static void __split_huge_page_tail(struct page *head, int tail,
 }
 
 static void __split_huge_page(struct page *page, struct list_head *list,
-		pgoff_t end)
+		pgoff_t end, struct address_space *mapping)
 {
 	struct page *head = compound_head(page);
 	struct lruvec *lruvec;
@@ -2476,6 +2476,16 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 		split_swap_cluster(entry);
 	}
 
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
@@ -2717,7 +2727,9 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
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


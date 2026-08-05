Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1656C47255B
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 13:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785937515; cv=none; b=fJ87/O92bUiMHrMVUwLcdGI365MLFHssjOOR2ZUE3JyQwmmOMdFJNEZLyjBHw1une5o8J2+19NstI8OdNO/RsEmezeM7CyyAiR23m1vDpVlL0CN0cCj+XAyBTVk3MvtlnE5u+j4bg1c0N50f7zL7U6uKPbwmkjY+OjPpfDz+ucE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785937515; c=relaxed/simple;
	bh=9WXQrWwxS3zMJI+in606pfk9O14a7dIK3ltbgaZLhfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qviaeUaBHCoeMFZdDl95a3lUhtlnG9wIYhO1CZxSEwgYkBdQmutDGkn1ZeF+RFfbVKNLu8ehOxa50ZhYu/3A86f26aVNWleXwzBKPyETKZdVKJf61DE+sWgABpGDPY/xE/Z0KxxYcLRY0kNa04dnUVr4vSrJ10WvtWTrwPIyFnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=FmUa+u0a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f2mOUJcZ; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="FmUa+u0a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f2mOUJcZ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id E21311D00108;
	Wed,  5 Aug 2026 09:45:11 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 05 Aug 2026 09:45:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1785937511; x=
	1786023911; bh=Osu5HAj31t3vA++SI5acuFL5HzmSaw12YbI9fEbrvLU=; b=F
	mUa+u0ak4xaT7826lwZnle35sqpt2524DLSZUVVLIs2UX/fhgGw3XLWA1vgC0mXv
	bPqp/Qf5eO3GivX68kHq2UXp3VYwIVkgDejCs7I15FHbXWnU23cF3Dq19p5y+xVe
	gswYQpMBZazzyPKfz1dQN1hzWAczlcuZBnci1qrLvhwpIkd7wBg9zOKHEka5qa7C
	GSyZPxr/GAnAAwqi5CnQkwgCndmb1fa8CTLqIiS/zL7B2sqKDCEQXXMC5V3F9B3G
	2q53ww3MPa114Uxx+g3nn3eHXj1NOpQ6tKykop9vs4/PQuijegJXKMQlEF+fOzND
	AVhOUjU85+dFWz/D8cmRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1785937511; x=1786023911; bh=O
	su5HAj31t3vA++SI5acuFL5HzmSaw12YbI9fEbrvLU=; b=f2mOUJcZghvn59LS1
	T4G/nZaOSa/fEHFHYKVMdTcgDCRY6/DqQ+IbBEde8rAnP5Rm885W0GliJhpfVlpb
	uBfpUWT8tSyoHIhZHBgt6LojMdv03TScVxPFLytgU8GlIsxpUpDYsWQAJy8TPGLx
	uZ5OnXXnTEK0h2J5jCPbstyK0YPGq90AqZLCOnZfJng5iur1DMvomuOLTX8AlDgL
	zTvt/7fHURhL0GadkFpl+FKzclR56O4b8H7eoShLtmwrv4jq5Z42EWE9NVcJ+ARV
	ZFDHCkNGLg4mKCffrdd+4i944+kTeZDScDOZt0fdP4ZOslhwyinsWwDK8WzxmrfY
	v6zhw==
X-ME-Sender: <xms:Zj5zavJ07o_CKhrQkUci5luRpwzxCKpUULs77BWCXh7koqlPrc9ZFw>
    <xme:Zj5zaqsGQ4cQZpv2oejrtbUcESXrl_wUyEYM3vCfwCzjbeoOOy0eedQqq7iSE3PME
    2f5oub6FXPgbI_2ybqRX4RUpnQ_eF9N3z6ZhzV_O5z4hkOEAZdXoZk>
X-ME-Received: <xmr:Zj5zanWD1lm2NA66xyrtLxWAudPKi99h76XAVMkNQNTbE8TLaDGnZaHKfPc>
X-ME-Proxy-Cause: dmFkZTGu97oI3pYUVfgfNzZrxwJPnm31USpJCOdyBwkzfqtZM+L3TiAQtP0rjGZJjYLOo4
    xWk0E7hNrOhKUloXiU8avxmSlRI2RGeRD1/gTEgVPaTUC1zaE4cMasb614gbRm8XXQZ50k
    xJgTwN1tyHXL089IzbJD2G8OjM6Gw0/sLqfvD74RKaaTgnpAVfEpa8hs2Cg2CXKf/pEADq
    4dnZB1dJz2axtJ7K25RLDyG5EULynjrVLDHVcyQACiXg2X7iZaun9E9RiUpaaHyarugFxH
    BcSZfbgRifuCSc+ehaiasTAbhZQS9sm29EkhCmls1Um4jDGdwXgfvWukq5LCWU5r4dUPOQ
    hsx9s1PBlz7liBb1t482ePolP06ZxY/cCLdcwHX/kK5fVGUMdddaF7LFFmtVo4nDnYm5wK
    BudoW/8vQafA55xssPh8IKgU8GJcAjmNsKtgaPUB2qBplJdPGt/eH09al/qw73YJQ0SWmG
    wk+08hcHltQJoB3PVpzqnDWaoly/L6M+p6hzXkBXyWsAioW4rY9+Sl94RkBGGnyJnso0NG
    DmzGUYPzu7oz8qhatS+58DEu30dgNs6vwPJKnI0KIY8FbMd2FSq+0B7vPNvRzwJXOcRvpI
    ij1y7m4lMWmyHduW/riG9llqwCmfnHpe+iwbKC0/9CHVRWlsYr40jY9F2S6A
X-ME-Proxy: <xmx:Zj5zalJ2AFSUqa88JsL-Cb7_xe1SEoIzs3g-ARZmSOI8t6Iif5NQLA>
    <xmx:Zj5zas-UaXIoQWV7S-eAzdpBvFGoVhtQmd8glGLwHRuG1HWu-n1UXA>
    <xmx:Zj5zajOUACNhECvsd89NMv8fuO2aTzcN_k2mj9D1rjS0jwozrZhKXw>
    <xmx:Zj5zao0HZbuKHBS9euFzyswaVspeeCSk-EWoxy2X99MQ3tmmhos4Cw>
    <xmx:Zz5zaiE79PsmpYscGjrg6ljBNVtBdQ-8THplervP3aBzj2jLfMVjIXbM>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 09:45:09 -0400 (EDT)
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
Subject: [PATCH 5.10.y] mm/huge_memory: unlock i_mmap_rwsem before releasing after-split folios
Date: Wed,  5 Aug 2026 14:45:07 +0100
Message-ID: <20260805134507.2776820-1-kirill@shutemov.name>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026080504-attitude-drizzle-259b@gregkh>
References: <2026080504-attitude-drizzle-259b@gregkh>
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
index fdcf89e3b1d2..f620861d0099 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2445,7 +2445,7 @@ static void __split_huge_page_tail(struct page *head, int tail,
 }
 
 static void __split_huge_page(struct page *page, struct list_head *list,
-		pgoff_t end, unsigned long flags)
+		pgoff_t end, unsigned long flags, struct address_space *mapping)
 {
 	struct page *head = compound_head(page);
 	pg_data_t *pgdat = page_pgdat(head);
@@ -2515,6 +2515,16 @@ static void __split_huge_page(struct page *page, struct list_head *list,
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
@@ -2746,7 +2756,9 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 				__dec_node_page_state(head, NR_FILE_THPS);
 		}
 
-		__split_huge_page(page, list, end, flags);
+		__split_huge_page(page, list, end, flags, mapping);
+		/* __split_huge_page() dropped the i_mmap lock */
+		mapping = NULL;
 		ret = 0;
 	} else {
 		spin_unlock(&ds_queue->split_queue_lock);
-- 
2.54.0


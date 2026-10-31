Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793439772;
	b=4QKsJz4Zp0WU3LOyJVpKEl0Px8OGhfF2PLP4OZN3YAYIY7EFw3vOkoD/csLnKarOCxrH
	 lBM239l5RscOjfdkMdge0SBXYUy7KnuetjT2ckf6Lk7xniNU3cBtsfDS/720qSnAaCz70
	 sWvZVT6GmsNSQaE/pCPW4a4kpda9MNcpzcZ1TWiaFBHhKWnJm2bk3agsgbrcP7nNxv56G
	 /kwkBBtsp0brk/qW/+rIKYedNzFQov0zxlK2iI501nds4i6in9cBpKDec4gy0w7b83dRN
	 KTnYoPkKJ1q0j34cP8MPg3IrdBPsPRdBh79uz4OOEoNePBPZNuVO7mfyMyDYCyxB50g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793439772;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=l+l7vL6OppC3xXbuZ+6FYNU9AQPqNjHig+EtP/8oH5c=;
	b=0y9AKssljG398wnAS/B+PqA33wcXMai1SyjP6t9fQcd0RJA/M6W9rwlaq5Cf1aQtMqlb
	 B4CdJg3tKkVctweb3FDGhIkDi+bk2JdatoIhjzS5P+Mi80HehLPWE8lPc8zBrUHVxgMeT
	 ALCOjCTiD+RcRsXTNWzN1wq0A8qr1yi4QjKSxyI//ssWct7e47Gj26LuM5Wk55YFFkmi+
	 nFQSoIWiGOLluqnDByAstMwR/LHU6F/hRlEaDmEfm+NsFwEkvZ0MdLrBtu2gJy/qcxwYy
	 I80FqdldVdA1B+vai9F9OqfwLa6Aq640xIIVmpuyp8kVUHMuch1dnWixGKn79d+LVzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SlvOoo7h;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C1E606A31C;
	Sat, 31 Oct 2026 09:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SlvOoo7h
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E61F31F00A1A;
	Sat, 31 Oct 2026 09:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793439771;
	bh=l+l7vL6OppC3xXbuZ+6FYNU9AQPqNjHig+EtP/8oH5c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=SlvOoo7h2NrGSce+EZ0r/TEXEBd2b3M+W3a5ZrbTwYZjlGRtxW/0dAR4JP4GA+76w
	 P+f7bAuUNu1Yv1g1H7D8kFS4QD5s2CZBGegKhPNpITqlN7Ip3qbNZ4cy/WVa1ZlmjD
	 /D2MxgtNqIQyQIzKHKj7qIVDjMAvkJf4rRPteq1rzuV+/rMCJ7D7uysNhe47S8OYi0
	 hM/g0ow18Z8BSkDidvpS/QUBtepf7GfsSShe5dLagt+hSjgLUsSJX9zgTlj9tPN+J/
	 0X8jIEgDjVqkM1UbZ87/UjTXIQyGyjjTepCGPRDVpmowDIpCv4zaqmYY0OHgBX6iW2
	 qTDUniZzh/0Ww==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Sat, 31 Oct 2026 10:39:39 +0100
Subject: [PATCH v3 10/47] mm/huge_memory: fix list corruption when
 deferred_split_scan() races with deferred_split_folio()
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
Message-Id: <20261031-fixes_core-v3-10-d6437171ecc3@kernel.org>
References: <20261031-fixes_core-v3-0-d6437171ecc3@kernel.org>
In-Reply-To: <20261031-fixes_core-v3-0-d6437171ecc3@kernel.org>
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
 stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
 Mani Tofigh <mt4022@columbia.edu>, 
 Muhammad Usama Anjum <usama.anjum@arm.com>, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3706; i=david@kernel.org;
 h=from:subject:message-id; bh=JLLChxKIypxsdt4WbVQ02kyFhDQ6FU9NlTqVcswW/5U=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLKebk8TMZnE9X4D4/OEzCXBE1Z9d/jC1rw4beqiza7Gr
 ftD/0+x6ihlYRDjYJAVU2QJCr5v8PLlutpqNz5mmDmsTCBDGLg4BWAitXmMDDuD94idilyy2OlJ
 +uw7ca5Hak9PM5FUNfP55rpY7WLg7Z0M/9NvzDOcl7v+Y92qeT0exhK3v3ycJN1/VN6Lyeh+8ln
 l97wA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

Since the deferred split queue became a list_lru, the isolate callback
moves the folios it took a reference on to an on-stack list, linked
through folio->_deferred_list, and deferred_split_scan() takes them off
that list with list_del_init() without holding the list_lru lock.

deferred_split_folio() does not know about the on-stack list. It only
holds the list_lru lock when it looks at the same list_head, and it can
run for such a folio: a THP is queued when it is mapped, as a candidate
for the underused check, and is queued "again" when a part of it gets
unmapped:

  CPU0 deferred_split_scan()          CPU1 deferred_split_folio()
  list_del_init(&folio->_deferred_list)
    next->prev = prev
    prev->next = next
    entry->next = entry
                                      list_lru_lock_irqsave()
                                      folio_set_partially_mapped()
                                      __list_lru_add()
                                        list_empty(item)  -> true
                                        list_add_tail(item, &l->list)
                                          item->next = &l->list
                                          item->prev = tail
    entry->prev = entry

The folio now sits on the list_lru with ->prev pointing to itself. The
next removal leaves the neighbours pointing to it, and they still do so
after the folio has been freed. With CONFIG_DEBUG_LIST:

  list_del corruption. prev->next should be ffd4000000270090, but was
  ffd4000000278090. (prev=ffd4000000270090)

Fix it by grabbing the lock around list_del_init() so
deferred_split_folio() cannot race with it.

Fixes: fafaeceb89a5 ("mm: switch deferred split shrinker to list_lru")
Cc: stable@vger.kernel.org
Reported-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Mani Tofigh <mt4022@columbia.edu>
Tested-by: Mani Tofigh <mt4022@columbia.edu>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/huge_memory.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index bd44d58e86845..4c0194af9016d 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -4522,8 +4522,7 @@ int split_folio_to_list(struct folio *folio, struct list_head *list)
  *
  * It is unsafe to call folio_unqueue_deferred_split() until folio refcount is
  * zero: because even when the list_lru lock is held, a non-empty
- * _deferred_list might be in use on deferred_split_scan()'s unlocked
- * on-stack list.
+ * _deferred_list might be in use on deferred_split_scan()'s on-stack list.
  *
  * The list_lru sublist is determined by folio's memcg: it is therefore
  * important to unqueue deferred split before changing folio memcg.
@@ -4665,10 +4664,22 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
 					    deferred_split_isolate, &dispose);
 
 	list_for_each_entry_safe(folio, next, &dispose, _deferred_list) {
+		struct mem_cgroup *memcg;
+		struct list_lru_one *lru;
 		bool did_split = false;
 		bool underused = false;
 
+		/*
+		 * Sync with deferred_split_folio(), which can requeue the
+		 * folio once list_empty() is true, and sets PG_partially_mapped.
+		 */
+		rcu_read_lock();
+		memcg = folio_memcg(folio);
+		lru = list_lru_lock_irq(&deferred_split_lru, folio_nid(folio),
+					&memcg);
 		list_del_init(&folio->_deferred_list);
+		list_lru_unlock_irq(lru);
+		rcu_read_unlock();
 
 		if (!folio_test_partially_mapped(folio)) {
 			/*

-- 
2.43.0


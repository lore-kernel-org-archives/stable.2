Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B154F4C6F0B
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788447657; cv=none; b=pI11B8GPZPHLh/IRu572PQN1CgDPGvZNO9bqTtuCkjE8JvTESJe+ja1l2II8ZUzLKaMuNrT8aMiCJ0k7HJwKgVfhTXPRQUc2xdv67KaK46CNtG64fcCB1D7fGxK8YT6wm5B4n64+3Ra3SuXNRmfRyOOjHouITD8NrrMZlIepNpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788447657; c=relaxed/simple;
	bh=qR6I65TBUXXYDlS3SqevKs29URLK3b41b2fD1aP8vEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ti83t3fCyz28948y3U4ZlkkUaEygC9BqkXG5YKP1s5VNrJHbpbew3sYEaPd/IzXp84PZIv3VK9VSf3oZdv8cg5T/yP7vKteL8bF9tyZnQhRLj0h7+J5SBSL8NKy3mhcpoLTzSxQVw2yLQEs7uXJrmRDZ8xgBoo0+7j4A/boyzQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDFSGLfc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDFSGLfc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ACDC1F00A3D;
	Thu,  3 Sep 2026 15:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788447655;
	bh=9qTvfI+I3HyQumKDOuMv4+M1D3yVbmAjws5fN5cBGvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FDFSGLfcsU/+Va9ZqaOmo9haLFSNBMX++yabBJXb5We9GzS892unZHzyv2xUtnFT+
	 ZaK17NN2r65UvF3avgitv88zRoonZYxVm/t3JmeAVsswE/bMEIdkjBREuazeJjCanK
	 /c4R6vB1+Xg9+ekxLLc0ByLbYScf4qfDH9+jv6OUwMyQ9h1SU6l6aU/P5cAyageli1
	 FLk2hNpm8bBZ35ysbQUPvJeGuO60eS/tMkdiiSmxtpIymyZJxnX3/04xVreqRHPVjG
	 M2SaUu2nYybISFW50Vwzq+Sdu6CNpFLqk+PtIHGJZFQXMxuu26AyZbf7McO/2d1exA
	 i2+3i079v9uTg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Andy Lutomirks^H^Hski <luto@kernel.org>,
	Borislav Betkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jann Horn <jannh@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Lance Yang <ioworker0@gmail.com>,
	Liam Howlett <liam.howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Matthew Wilcow (Oracle)" <willy@infradead.org>,
	Michal Koutn <mkoutny@suse.com>,
	Muchun Song <muchun.song@linux.dev>,
	tejun heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Zefan Li <lizefan.x@bytedance.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] mm: move hugetlb specific things in folio to page[3]
Date: Thu,  3 Sep 2026 11:00:49 -0400
Message-ID: <20260903150051.856389-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090322-cucumber-clumsily-daf5@gregkh>
References: <2026090322-cucumber-clumsily-daf5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Hildenbrand <david@redhat.com>

[ Upstream commit 4eeec8c89a0c4a8c20fb13a4e7093cc8efce383d ]

Let's just move the hugetlb specific stuff to a separate page, and stop
letting it overlay other fields for now.

This frees up some space in page[2], which we will use on 32bit to free up
some space in page[1].  While we could move these things to page[3]
instead, it's cleaner to just move the hugetlb specific things out of the
way and pack the core-folio stuff as tight as possible.  ...  and we can
minimize the work required in dump_folio.

We can now avoid re-initializing &folio->_deferred_list in hugetlb code.

Hopefully dynamically allocating "strut folio" in the future will further
clean this up.

Link: https://lkml.kernel.org/r/20250303163014.1128035-5-david@redhat.com
Signed-off-by: David Hildenbrand <david@redhat.com>
Cc: Andy Lutomirks^H^Hski <luto@kernel.org>
Cc: Borislav Betkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jann Horn <jannh@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Lance Yang <ioworker0@gmail.com>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Matthew Wilcow (Oracle) <willy@infradead.org>
Cc: Michal Koutn <mkoutny@suse.com>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: tejun heo <tj@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Zefan Li <lizefan.x@bytedance.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 078e1a0fc41a ("mm/gup: fix always draining LRU caches in collect_longterm_unpinnable_folios()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/mm_types.h | 27 +++++++++++++++++----------
 mm/hugetlb.c             |  1 -
 mm/page_alloc.c          |  5 +++++
 3 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 2113f7da182c6..08ae1793f29d9 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -382,20 +382,23 @@ struct folio {
 			unsigned long _flags_2;
 			unsigned long _head_2;
 	/* public: */
-			void *_hugetlb_subpool;
-			void *_hugetlb_cgroup;
-			void *_hugetlb_cgroup_rsvd;
-			void *_hugetlb_hwpoison;
+			struct list_head _deferred_list;
 	/* private: the union with struct page is transitional */
 		};
+		struct page __page_2;
+	};
+	union {
 		struct {
-			unsigned long _flags_2a;
-			unsigned long _head_2a;
+			unsigned long _flags_3;
+			unsigned long _head_3;
 	/* public: */
-			struct list_head _deferred_list;
+			void *_hugetlb_subpool;
+			void *_hugetlb_cgroup;
+			void *_hugetlb_cgroup_rsvd;
+			void *_hugetlb_hwpoison;
 	/* private: the union with struct page is transitional */
 		};
-		struct page __page_2;
+		struct page __page_3;
 	};
 };
 
@@ -430,8 +433,12 @@ FOLIO_MATCH(compound_head, _head_1);
 			offsetof(struct page, pg) + 2 * sizeof(struct page))
 FOLIO_MATCH(flags, _flags_2);
 FOLIO_MATCH(compound_head, _head_2);
-FOLIO_MATCH(flags, _flags_2a);
-FOLIO_MATCH(compound_head, _head_2a);
+#undef FOLIO_MATCH
+#define FOLIO_MATCH(pg, fl)						\
+	static_assert(offsetof(struct folio, fl) ==			\
+			offsetof(struct page, pg) + 3 * sizeof(struct page))
+FOLIO_MATCH(flags, _flags_3);
+FOLIO_MATCH(compound_head, _head_3);
 #undef FOLIO_MATCH
 
 /**
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index e910ed0c43d0b..4e4f3587731ed 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1702,7 +1702,6 @@ static void __update_and_free_hugetlb_folio(struct hstate *h,
 
 	folio_ref_unfreeze(folio, 1);
 
-	INIT_LIST_HEAD(&folio->_deferred_list);
 	hugetlb_free_folio(folio);
 }
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 259249a37faf0..d8209a512019e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1005,6 +1005,11 @@ static int free_tail_page_prepare(struct page *head_page, struct page *page)
 			goto out;
 		}
 		break;
+	case 3:
+		/* the third tail page: hugetlb specifics overlap ->mappings */
+		if (IS_ENABLED(CONFIG_HUGETLB_PAGE))
+			break;
+		fallthrough;
 	default:
 		if (page->mapping != TAIL_MAPPING) {
 			bad_page(page, "corrupted mapping in tail page");
-- 
2.53.0


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CE236CDE9
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 18:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788459453; cv=none; b=f+/pRj0ZGoIohqgsHm/Bt5WC4EJcY6MadcLzOttLvnUmbOW/IBGfA/kjvZ0wjbeEJnfTnHJN9PiWPbjX+WDS61DpWEXBC3bd48+4zjjjD4P1KZNVCa09KtO/HaqXMnMaYmRLakPdAQGGslpMw1pvuqXHQBFgjpqmg/jHwLKvN1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788459453; c=relaxed/simple;
	bh=LaLQDi7t/LKk7162wI9+9ilXI0SeZO/a3eOXNvEcEz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h3lwSLzB5EsqlP8aZUZ7k2qz9jTTPpXNuDW3f4wgPSxFlNCriSMyLZIAZlgRafx2n3PrhFqtkCTKtr+vJJFJ1Qa59YHQHJr9J3JyqURdBS6SHrVDtabnrW9tXqwAFJaBS/inbMdRWblZnbTQJ4nnLXq6062vNmWaaD6vdiY8zLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H63WgSvM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H63WgSvM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59CE71F000E9;
	Thu,  3 Sep 2026 18:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788459451;
	bh=ZOY3CMdigTJQXUbUoSM4L00tE1ihtzrrQTBuqmF1EQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H63WgSvMVc9Stua5QFet4/lwiQOit4i47g3C1NSXZo7twVoBAShC4Hb3T8xY3hoGn
	 tqvg5jzL/F3ByicFMDrpHMlZiIt+rAgqQhLwfjBCa5FM+kSlkCeO9f17Lty6w2srda
	 hMiRWDr/SIXs15wT1qbXNDy2cicVbqMIv4VJjfpjSkK7zxfpv+QqBa6aMKe2HOoHiF
	 Cz3600WotW0rUyLTMSZN0yF55W1Uy5lEr1aS7Dom3XWIVeobQDdARyi5DWuxQmxZN6
	 AhTW2mleZcjdzSN+Xwud8gEkVBXPIcAokgQIBBnjarNoTTBKFc8xO2SpYiwcr8OCoA
	 L7LDFRgOrPU2w==
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
Subject: [PATCH 6.6.y 1/3] mm: move hugetlb specific things in folio to page[3]
Date: Thu,  3 Sep 2026 14:17:25 -0400
Message-ID: <20260903181727.1432502-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090339-stapling-ecosystem-7341@gregkh>
References: <2026090339-stapling-ecosystem-7341@gregkh>
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
index ce3370823f9c7..469db1973362b 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -343,20 +343,23 @@ struct folio {
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
 
@@ -385,8 +388,12 @@ FOLIO_MATCH(compound_head, _head_1);
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
index edae641407b96..01078a7289d53 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1798,7 +1798,6 @@ static void __update_and_free_hugetlb_folio(struct hstate *h,
 		destroy_compound_gigantic_folio(folio, huge_page_order(h));
 		free_gigantic_folio(folio, huge_page_order(h));
 	} else {
-		INIT_LIST_HEAD(&folio->_deferred_list);
 		__free_pages(&folio->page, huge_page_order(h));
 	}
 }
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ffdc71103c2ad..93c9a094ee8b0 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1032,6 +1032,11 @@ static int free_tail_page_prepare(struct page *head_page, struct page *page)
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


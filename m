Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795554348;
	b=XoMAfycs/HnH01KLNdpWdQXODlN3FuteU9Rww36xA/biLsLFkyHsKnSY/BvW0WdIjD1N
	 20h9lMPORz6Jx5jB0+Uvx9WSsUr7aQXBMCdDKBvj2S5oEl2VdOxBSlDp5bch9hJ5FmAfw
	 X5fSIKkLxcD56Wf7l6GSGn1XUyibSvJH/RIh4Zoy5hwSJeSH774xhTJwNhPWxBPBO2ZOH
	 /J8hiSPZ7TD/UFrx+rIVnn5KFsj66hppz+BI4HwUm0V38nO3y9+2DMkKaZ3BB5mCfjLZP
	 FQuknIXUANiWG76JN8SRrLyNF8Yy7Kz9DVEBx6asvkZDGhH5a4L7+/Dp6+yMVcuKbAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795554348;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=zlLa/xVg1n7lDZ9VLxaZDCNKRa5uYsG0oiDi9ShXwEE=;
	b=PjfmdGT7Gz8EWiPrOsMw0RaOCUbHbR4mBIGLICvO6+tdIA+KN094tU6mqYAKjMKcI33P
	 kHMVlf6/0yJIUfyA5m7gDp3krLiD4+86kiPXssSZv1nq5/WjX0GbdevV5U7Ep3I+/lD4R
	 lkoQZGFTONbxKcZflraBnANZ34HggwmwSg8s4jx95/V+21mCaW5sy5RnUKLDWlVUB2mnl
	 GvRLssUQ23iRuicba7vuSBvNK9d0QUH1o0+SeH6/Byihk/MTg6koFi2Ok3z7O4mVeDaVx
	 UzYQVRuLrhExQHroF5oR97mink10++TVGkSiXkjldQIh2wYZ5oZi4sVD99CbeoVVO1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l7xWeZvS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73873606A327
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 21:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l7xWeZvS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D6E11F000D1;
	Tue, 24 Nov 2026 21:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795554347;
	bh=zlLa/xVg1n7lDZ9VLxaZDCNKRa5uYsG0oiDi9ShXwEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l7xWeZvS6crU2SkMpRriKIr7xTYXcvpalcsztUb3hifek5NvAHdfUX8sbp3Ws+dCw
	 okdgZQT5MjOQF+obhi5MIwFFSihStC4bhdYFFhcHy8NnhtmdCciy4N1SJ4XdAQLD3M
	 lPVH+G2OQPV1ZLSBbXvw8nEPzY8xEhBNKBFodOLK3/MzLfE4MdRawytwBUXK5Dn1Jz
	 De8N+bAaB6Wq+y4g6n+aJ7FKwHuayqRP4KN6dhcSE1+YUbHPGvMUDSU1IO0hg+6dAi
	 4iqcTVuuh6V2IAI8l7f4z3KS2U1lkcCCtxWWfVM3W8ZJ4r+aBHHONDUEGctgLGr8ok
	 5BgVLmYixIi3Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Brendan Jackman <jackmanb@google.com>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Barry Song <baohua@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Kairui Song <kasong@tencent.com>,
	Len Brown <lenb@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	Wei Xu <weixugc@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Zi Yan <ziy@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] mm: rejig pageblock mask definitions
Date: Tue, 24 Nov 2026 16:05:43 -0500
Message-ID: <20261124210529.2757387-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112410-negligent-mutiny-06fc@gregkh>
References: <2026112410-negligent-mutiny-06fc@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Brendan Jackman <jackmanb@google.com>

[ Upstream commit 3687c0fd67249cb971990b382a47f02f19ed9f67 ]

- Add a PAGEBLOCK_ prefix to the names to avoid polluting the "global
  namespace" too much.

- This new prefix makes MIGRATETYPE_AND_ISO_MASK look pretty long. Well,
  that global mask only exists for quite a specific purpose, and is
  quite a weird thing to have a name for anyway. So drop it and take
  advantage of the newly-defined PAGEBLOCK_ISO_MASK.

Link: https://lore.kernel.org/20260513-page_alloc-unmapped-prep-v1-3-dacdf5402be8@google.com
Signed-off-by: Brendan Jackman <jackmanb@google.com>
Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Cc: Axel Rasmussen <axelrasmussen@google.com>
Cc: Barry Song <baohua@kernel.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Kairui Song <kasong@tencent.com>
Cc: Len Brown <lenb@kernel.org>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport (Microsoft) <rppt@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Wei Xu <weixugc@google.com>
Cc: Yuanchu Xie <yuanchu@google.com>
Cc: Zi Yan <ziy@nvidia.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 2122887b04f3 ("mm/page_alloc: remove the zone_spans_pfn() check from get_pfnblock_bitmap_bitidx()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/pageblock-flags.h |  6 +++---
 mm/page_alloc.c                 | 18 +++++++++---------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/linux/pageblock-flags.h b/include/linux/pageblock-flags.h
index e046278a01fa8..9a6c3ea17684d 100644
--- a/include/linux/pageblock-flags.h
+++ b/include/linux/pageblock-flags.h
@@ -36,12 +36,12 @@ enum pageblock_bits {
 
 #define NR_PAGEBLOCK_BITS (roundup_pow_of_two(__NR_PAGEBLOCK_BITS))
 
-#define MIGRATETYPE_MASK (BIT(PB_migrate_0)|BIT(PB_migrate_1)|BIT(PB_migrate_2))
+#define PAGEBLOCK_MIGRATETYPE_MASK (BIT(PB_migrate_0)|BIT(PB_migrate_1)|BIT(PB_migrate_2))
 
 #ifdef CONFIG_MEMORY_ISOLATION
-#define MIGRATETYPE_AND_ISO_MASK (MIGRATETYPE_MASK | BIT(PB_migrate_isolate))
+#define PAGEBLOCK_ISO_MASK	BIT(PB_migrate_isolate)
 #else
-#define MIGRATETYPE_AND_ISO_MASK MIGRATETYPE_MASK
+#define PAGEBLOCK_ISO_MASK	0
 #endif
 
 #if defined(CONFIG_HUGETLB_PAGE)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 074178f4d7a07..d37596a9c60e9 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -398,7 +398,7 @@ get_pfnblock_bitmap_bitidx(const struct page *page, unsigned long pfn,
 #else
 	BUILD_BUG_ON(NR_PAGEBLOCK_BITS != 4);
 #endif
-	BUILD_BUG_ON(__MIGRATE_TYPE_END > MIGRATETYPE_MASK);
+	BUILD_BUG_ON(__MIGRATE_TYPE_END > PAGEBLOCK_MIGRATETYPE_MASK);
 	VM_BUG_ON_PAGE(!zone_spans_pfn(page_zone(page), pfn), page);
 
 	bitmap = get_pageblock_bitmap(page, pfn);
@@ -471,7 +471,7 @@ bool get_pfnblock_bit(const struct page *page, unsigned long pfn,
 __always_inline enum migratetype
 get_pfnblock_migratetype(const struct page *page, unsigned long pfn)
 {
-	unsigned long mask = MIGRATETYPE_AND_ISO_MASK;
+	unsigned long mask = PAGEBLOCK_MIGRATETYPE_MASK | PAGEBLOCK_ISO_MASK;
 	unsigned long flags;
 
 	flags = __get_pfnblock_flags_mask(page, pfn, mask);
@@ -480,7 +480,7 @@ get_pfnblock_migratetype(const struct page *page, unsigned long pfn)
 	if (flags & BIT(PB_migrate_isolate))
 		return MIGRATE_ISOLATE;
 #endif
-	return flags & MIGRATETYPE_MASK;
+	return flags & PAGEBLOCK_MIGRATETYPE_MASK;
 }
 
 /**
@@ -568,11 +568,11 @@ static void set_pageblock_migratetype(struct page *page,
 	}
 	VM_WARN_ONCE(get_pageblock_isolate(page),
 		     "Use clear_pageblock_isolate() to unisolate pageblock");
-	/* MIGRATETYPE_AND_ISO_MASK clears PB_migrate_isolate if it is set */
+	/* PAGEBLOCK_ISO_MASK clears PB_migrate_isolate if it is set */
 #endif
 	__set_pfnblock_flags_mask(page, page_to_pfn(page),
 				  (unsigned long)migratetype,
-				  MIGRATETYPE_AND_ISO_MASK);
+				  PAGEBLOCK_MIGRATETYPE_MASK | PAGEBLOCK_ISO_MASK);
 }
 
 void __meminit init_pageblock_migratetype(struct page *page,
@@ -598,7 +598,7 @@ void __meminit init_pageblock_migratetype(struct page *page,
 		flags |= BIT(PB_migrate_isolate);
 #endif
 	__set_pfnblock_flags_mask(page, page_to_pfn(page), flags,
-				  MIGRATETYPE_AND_ISO_MASK);
+				  PAGEBLOCK_MIGRATETYPE_MASK | PAGEBLOCK_ISO_MASK);
 }
 
 #ifdef CONFIG_DEBUG_VM
@@ -2179,15 +2179,15 @@ static bool __move_freepages_block_isolate(struct zone *zone,
 	}
 
 move:
-	/* Use MIGRATETYPE_MASK to get non-isolate migratetype */
+	/* Use PAGEBLOCK_MIGRATETYPE_MASK to get non-isolate migratetype */
 	if (isolate) {
 		from_mt = __get_pfnblock_flags_mask(page, page_to_pfn(page),
-						    MIGRATETYPE_MASK);
+						    PAGEBLOCK_MIGRATETYPE_MASK);
 		to_mt = MIGRATE_ISOLATE;
 	} else {
 		from_mt = MIGRATE_ISOLATE;
 		to_mt = __get_pfnblock_flags_mask(page, page_to_pfn(page),
-						  MIGRATETYPE_MASK);
+						  PAGEBLOCK_MIGRATETYPE_MASK);
 	}
 
 	__move_freepages_block(zone, start_pfn, from_mt, to_mt);
-- 
2.53.0


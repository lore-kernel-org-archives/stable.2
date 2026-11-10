Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794321264;
	b=Ueni+DzncaR+vFd8iuOv7Al+DMWdIkzcLuqJU1FqJi9MZkzIHawN34XIXvDK1GFaUAd4
	 4Nb83KLBxJvDWUR6WLvevZDQfRFxNkSec7YjvbhmU3JU0OLV8UispxMPHbUfM2l0jBcst
	 k49Pitd3glHR7dONDMfyLP6KwtZJqvumrWIzss6Zy++QCCiSMj4OZ0u8bvk+P5X0uX1rm
	 1yZFgWfNq29fOBmhfYPFFYaDTF2B4suM4OZ034WakDSbZ3h+KdfXXdbJEw9jRBWYgttp3
	 YlTncJsHukVgwyn8zk4dZFl1ok5JopTJ7IZrwRxRL8sdOxpm9TKozkDCFeDF6uIY3DQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794321264;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=lI/oWRESMA6JMKFe2n5UT9thBSX+SjP4EK0QfUDpgCQ=;
	b=LE8CRdtW9pR1/I7qli3tRcqSqjif1JHV4xZd90hc+L5M5pJIYI/r8n4ZyEIykqj4CAZR
	 5iJYNfE26rd/bnl+jT5+LJ/T/V8BFaBLZvmf5LzdSdaNMnE8K/E5usGojyTfzHRN8HniX
	 OYMoo85JZNuKgFG18vz7HFW0ZRAQ5Jz/7va76O8WDPHCKQBUExyzI4J3qZKS4536b5GQN
	 J8QR8bRDcJ88hpTkOVa4zYLNkj7EhmEk2d8Z/5h4Q2OEXcqxT40R/CEblgucZdBcKeXun
	 ykR5uBdKI93hawGlQ719VIRO46nQOskwxSfnQM04lodbX/dF84gmef20p/y1Y4MmLGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TCDjoz+O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6392760A2606
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TCDjoz+O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966381F008A2;
	Tue, 10 Nov 2026 14:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794321264;
	bh=lI/oWRESMA6JMKFe2n5UT9thBSX+SjP4EK0QfUDpgCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TCDjoz+OFndTfNCcxzVnJqY7J2jfdmjAwKVey4rZHGhJd7UHHFNLQ6bTfzRGMESmC
	 wUif/TYCwE8bJfH3jxc7bvnhZjlO/XhxL2EbQY2Mm3C5ZTafX1uueuF1l6pXw0vdOL
	 gyZW8aWEEC4hXhKOJcD0G+BzP6ig9TlktP40OyZM/8JMBPssmhFp7GolYKYoV6JI7j
	 7a2tDggGLoKlqJLeWGJoPf2qjkUEKmxWPx7/RRCZAw0L+D2G3XPgskErXNqLnWjnw/
	 YD5P+upd95WfVEjCrjbGo91nYQuPZcsIHtGZlsGHZbnIZKTlWmkLO1jyA2nmx68moo
	 mfiIihk+7ncEg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sidhartha Kumar <sidhartha.kumar@oracle.com>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <songmuchun@bytedance.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	Bui Quang Minh <minhquangbui99@gmail.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Mina Almasry <almasrymina@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/4] mm/hugetlb_cgroup: convert hugetlb_cgroup_migrate to folios
Date: Tue, 10 Nov 2026 09:34:17 -0500
Message-ID: <20261110143410.1902001-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110143410.1902001-1-sashal@kernel.org>
References: <20261107054727-failed-6.1-23fac055c211@kernel.org>
 <20261110143410.1902001-1-sashal@kernel.org>
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

From: Sidhartha Kumar <sidhartha.kumar@oracle.com>

[ Upstream commit 29f394304f624b06fafb3cc9c3da8779f71f4bee ]

Cleans up intermediate page to folio conversion code in
hugetlb_cgroup_migrate() by changing its arguments from pages to folios.

Link: https://lkml.kernel.org/r/20221101223059.460937-5-sidhartha.kumar@oracle.com
Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Cc: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Mina Almasry <almasrymina@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 23fac055c211 ("mm/hugetlb_cgroup: move per-node usage on cgroup reparenting")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/hugetlb_cgroup.h | 8 ++++----
 mm/hugetlb.c                   | 2 +-
 mm/hugetlb_cgroup.c            | 8 +++-----
 3 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/include/linux/hugetlb_cgroup.h b/include/linux/hugetlb_cgroup.h
index f0d9f295413be..c70f92fe493ef 100644
--- a/include/linux/hugetlb_cgroup.h
+++ b/include/linux/hugetlb_cgroup.h
@@ -177,8 +177,8 @@ extern void hugetlb_cgroup_uncharge_file_region(struct resv_map *resv,
 						bool region_del);
 
 extern void hugetlb_cgroup_file_init(void) __init;
-extern void hugetlb_cgroup_migrate(struct page *oldhpage,
-				   struct page *newhpage);
+extern void hugetlb_cgroup_migrate(struct folio *old_folio,
+				   struct folio *new_folio);
 
 #else
 static inline void hugetlb_cgroup_uncharge_file_region(struct resv_map *resv,
@@ -286,8 +286,8 @@ static inline void hugetlb_cgroup_file_init(void)
 {
 }
 
-static inline void hugetlb_cgroup_migrate(struct page *oldhpage,
-					  struct page *newhpage)
+static inline void hugetlb_cgroup_migrate(struct folio *old_folio,
+					  struct folio *new_folio)
 {
 }
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 89c82bdf2f217..76da1d9650bd4 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7545,7 +7545,7 @@ void move_hugetlb_state(struct page *oldpage, struct page *newpage, int reason)
 {
 	struct hstate *h = page_hstate(oldpage);
 
-	hugetlb_cgroup_migrate(oldpage, newpage);
+	hugetlb_cgroup_migrate(page_folio(oldpage), page_folio(newpage));
 	set_page_owner_migrate_reason(newpage, reason);
 
 	/*
diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index 001828b062d43..4cd57f979245f 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -884,13 +884,11 @@ void __init hugetlb_cgroup_file_init(void)
  * hugetlb_lock will make sure a parallel cgroup rmdir won't happen
  * when we migrate hugepages
  */
-void hugetlb_cgroup_migrate(struct page *oldhpage, struct page *newhpage)
+void hugetlb_cgroup_migrate(struct folio *old_folio, struct folio *new_folio)
 {
 	struct hugetlb_cgroup *h_cg;
 	struct hugetlb_cgroup *h_cg_rsvd;
-	struct hstate *h = page_hstate(oldhpage);
-	struct folio *old_folio = page_folio(oldhpage);
-	struct folio *new_folio = page_folio(newhpage);
+	struct hstate *h = folio_hstate(old_folio);
 
 	if (hugetlb_cgroup_disabled())
 		return;
@@ -904,7 +902,7 @@ void hugetlb_cgroup_migrate(struct page *oldhpage, struct page *newhpage)
 	/* move the h_cg details to new cgroup */
 	set_hugetlb_cgroup(new_folio, h_cg);
 	set_hugetlb_cgroup_rsvd(new_folio, h_cg_rsvd);
-	list_move(&newhpage->lru, &h->hugepage_activelist);
+	list_move(&new_folio->lru, &h->hugepage_activelist);
 	spin_unlock_irq(&hugetlb_lock);
 	return;
 }
-- 
2.53.0


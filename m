Received: from mta0.migadu.com (out-100.mta0.migadu.com [91.218.175.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7871424336D
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 02:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789700202; cv=none; b=YeYc8L9butaRq5tId1hud5jsQpZDRhPv4c3OBlgoAOX/Lc7Ip91ONnEvcHTOlznJXrTSOZjZ6PcmRE/B07P37QD9BptRe4q367pZLjvBTgwd+PVR98pY/ZiHgXYSZSBs5pE2bHxgzPaN+uMCspaqla5e+vrtEobbR9HkcL0IJoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789700202; c=relaxed/simple;
	bh=9u6epy2ZAg7e55qO1Fon8xryNFbohlp/e75WuCwRfPs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CBMBop6m9w2DkwJVXCGjWF0+rcs98yVVaVNe3VTM+ztKqy0i9gsyujgLNxYles/+AV5YGEzC9+Q3JsuJ7GMegYKHFuOUbyM+BW6eLBhb8UVkXYg36haiqBgjlrVnqS0eGaecndqWPL+O12QVTXIJAfhbVHwEfQndufQOFUuZSyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OO22uDOx; arc=none smtp.client-ip=91.218.175.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OO22uDOx"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=9u6epy2ZAg7e55qO1Fon8xryNFbohlp/e75WuCwRfPs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789700195; v=1; x=1790304995;
 b=OO22uDOxXILEOeYIwRkNS6xATYfJXsM5caSAsWGGGtr5GP/Rp8bZYzpGZs7yzVIn7wHt6lK4
 uNcS5xC2ZU48jsUvVfV9YZgdMFE4qNS3GGm74/9r13mgZ0WiFw9MevCAK/wIZiIvq0gS/cTA0K5
 3f8nh5/PWoIiU61q2og7mbzs=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e182d4fe0f507fa4;
	Fri, 18 Sep 2026 02:56:35 +0000
X-Mizu-Trace-ID: e182d4fe0f507fa4
X-Migadu-Flow: FLOW_OUT
From: Hongfu Li <hongfu.li@linux.dev>
Date: Fri, 18 Sep 2026 10:56:10 +0800
Subject: [PATCH v2 1/2] mm/hugetlb_cgroup: move per-node usage on cross
 node migration
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-for-hugetlb-charge-v2-1-2b6d8c2bdc36@kylinos.cn>
References: <20260918-for-hugetlb-charge-v2-0-2b6d8c2bdc36@kylinos.cn>
In-Reply-To: <20260918-for-hugetlb-charge-v2-0-2b6d8c2bdc36@kylinos.cn>
To: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 David Hildenbrand <david@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, 
 Colin Ian King <colin.i.king@gmail.com>, 
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Mina Almasry <almasrymina@google.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, hongfu.li@linux.dev, 
 Hongfu Li <lihongfu@kylinos.cn>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789700179; l=2631;
 i=lihongfu@kylinos.cn; s=20260915; h=from:subject:message-id;
 bh=0UZdbc9Ox8ZjROT1qQ4ifIs6d3OxXlfJxcPA9bn5O0g=;
 b=En8vl3OUqwBj0Vz+EXcDxP2ydhp6W543BGUr7oBnxhYZP63azlfAA49Euwx8FD1ItN5ud6Nrc
 aGbYMXI7QnpB0T9B5Tu2kpkD02NR9nbgeegmbkYHlWTj5lj4ymZUe5z
X-Developer-Key: i=lihongfu@kylinos.cn; a=ed25519;
 pk=rUpDSpB3neoNZRlGG6dHlFb3RepiJakcev+ucyqaZzw=

From: Hongfu Li <lihongfu@kylinos.cn>

hugetlb.<size>.numa_stat uses folio_nid() to account usage in
__hugetlb_cgroup_commit_charge() and __hugetlb_cgroup_uncharge_folio().
hugetlb_cgroup_migrate() only moves hugetlb_cgroup pointers, leaving
per-node usage behind on the source node during cross-node migration.

When the migrated folio gets uncharged, we subtract usage from the
destination node counter. This creates stale usage on the source node
and unsigned long counter underflow on the destination node.
The hugetlb.<size>.numa_stat interface exposes these incorrect per-node
usage values to userspace.

Add a hugetlb_cgroup_move_usage() helper which moves the usage from the
old node to the new node, and call it from hugetlb_cgroup_migrate().

Fixes: f47761999052 ("hugetlb: add hugetlb.*.numa_stat file")
Cc: stable@vger.kernel.org
Signed-off-by: Hongfu Li <lihongfu@kylinos.cn>
---
 mm/hugetlb_cgroup.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index ecb6e0b7819a..7cf7c18119b4 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -179,6 +179,34 @@ static void hugetlb_cgroup_css_free(struct cgroup_subsys_state *css)
 	hugetlb_cgroup_free(hugetlb_cgroup_from_css(css));
 }
 
+static void hugetlb_cgroup_move_usage(struct hugetlb_cgroup *from,
+				      struct hugetlb_cgroup *to,
+				      struct folio *from_folio,
+				      struct folio *to_folio)
+{
+	int idx = hstate_index(folio_hstate(from_folio));
+	unsigned long nr_pages = folio_nr_pages(from_folio);
+	int from_nid = folio_nid(from_folio);
+	int to_nid = folio_nid(to_folio);
+	unsigned long usage;
+
+	lockdep_assert_held(&hugetlb_lock);
+
+	if (!from || !to)
+		return;
+
+	if (from == to && from_nid == to_nid)
+		return;
+
+	usage = from->nodeinfo[from_nid]->usage[idx];
+	if (WARN_ON_ONCE(usage < nr_pages))
+		return;
+	WRITE_ONCE(from->nodeinfo[from_nid]->usage[idx], usage - nr_pages);
+
+	usage = to->nodeinfo[to_nid]->usage[idx];
+	WRITE_ONCE(to->nodeinfo[to_nid]->usage[idx], usage + nr_pages);
+}
+
 /*
  * Should be called with hugetlb_lock held.
  * Since we are holding hugetlb_lock, pages cannot get moved from
@@ -906,6 +934,9 @@ void hugetlb_cgroup_migrate(struct folio *old_folio, struct folio *new_folio)
 	/* move the h_cg details to new cgroup */
 	set_hugetlb_cgroup(new_folio, h_cg);
 	set_hugetlb_cgroup_rsvd(new_folio, h_cg_rsvd);
+
+	hugetlb_cgroup_move_usage(h_cg, h_cg, old_folio, new_folio);
+
 	list_move(&new_folio->lru, &h->hugepage_activelist);
 	spin_unlock_irq(&hugetlb_lock);
 }

-- 
2.54.0


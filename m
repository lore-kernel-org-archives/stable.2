Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794321266;
	b=ZiQSaRlxQENyWGgGAODYMSKKMwkf4b83nAahpW1gc0TZk8j0MCQMFkBEKbB6LOQEdn/Z
	 ZKb0EKC3UeSRCdrunqh0iJSbc0PcPkl8+MMapPEji2+dA6EeuyTs+RUXVEGillBdT+TnC
	 e3KAHSuFWTedS3efpXqn2OXBCEzMR03tL+BLefg8ibQsD4Dn8pWGtwJyqcoK6NFSMBx4v
	 xUrRcBJXBmMmLV5E81q5eI1bohQTCC3Q4E0wQl/VZRFEZld9lsosEPf6vG5xVr1qKMQR6
	 OdigeKIxkk1u0YVrRuJyWiQZXMLp1J4DYnkyWXovk+Vl3NscaTw1db3OXEedx+Ago7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794321266;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=mPb5FfClnSAcjIxOZBnMGLynTKLbBRtuwAxYY/0UaUI=;
	b=k+szQgGYd9DLbneFp4oMnNOykvbhChP5YZUoiWkuRbmGLYGFZIBWbO04cVq1oqzlmMhP
	 rKVw872bx9Wg2NKTy3Fu6ABSgkzbmpsKccTYmKzZRYRwvEKO53nt0TZPbLlFI9OGi6jd8
	 ggC47W65FVX761+9ZFgt9DfTNwSi2ZZ84ywvqimgQdeNKFZjQFZQUNs2N6a8sXZSwfEny
	 IPYfwbesbO76LlFpx667R0rKpbJF4VAYjXS2GqwYCdAg8ishmEzhmNF0L0HdNwR++5W+j
	 AmIP3ONc8snWqudQBSj2a61R4NGQK+nIvqN6Ik1p09ojzaUiW6LMrTLfaexJdKN2edw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fyoej6ZL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7B0606A339
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fyoej6ZL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E45D1F0089F;
	Tue, 10 Nov 2026 14:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794321265;
	bh=mPb5FfClnSAcjIxOZBnMGLynTKLbBRtuwAxYY/0UaUI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fyoej6ZLzBtcLbSe5yxXrR1Y16YlOZoyeTCecQQALf9/wws7ChC07D2bfUJVo0fGq
	 CLCqC8QTaGDSz1IVZtGtwKhqpxiZz5RTlMzRX+YqVF2f4jGxPwCYU5VSTeJa+ybsVW
	 Bn4sYEfhDHkvQ3XRFMej7+GoeN8sobFVnE21GjXOeAM+2iTsJF1GLxJ0Y2/kSM6Swk
	 /2khMPSAeZR/jIic5wz5oNyxYCEtoaHntjQKShhKRrgaquguALAml9MeP9fVs2n0EM
	 bpvM2b7bAAuJoNQGAp7I1LbueIOkHBYpZRJs08BLse4ajtztHL3bDb0B+FhVCqO7pK
	 9NrXt3QVx22Vg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hongfu Li <lihongfu@kylinos.cn>,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Colin Ian King <colin.i.king@gmail.com>,
	David Hildenbrand <david@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Oscar Salvador <osalvador@suse.de>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/4] mm/hugetlb_cgroup: move per-node usage on cross node migration
Date: Tue, 10 Nov 2026 09:34:18 -0500
Message-ID: <20261110143410.1902001-3-sashal@kernel.org>
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

From: Hongfu Li <lihongfu@kylinos.cn>

[ Upstream commit fe0ba1909c59660f078560f5130e7af7c6004f12 ]

Patch series "mm/hugetlb_cgroup: move the per-node usage along with the
folio", v2.

The per-node usage reported by hugetlb.<size>.numa_stat is accounted
against folio_nid() in __hugetlb_cgroup_commit_charge() and
__hugetlb_cgroup_uncharge_folio(), so it is only correct while a folio
stays charged on the same node and in the same hugetlb_cgroup.

Two paths move a folio which stays charged, and neither moves the usage
with it.  hugetlb_cgroup_migrate() only moves the hugetlb_cgroup pointers
of a folio migrated to another node, and hugetlb_cgroup_move_parent() only
moves the page_counter charges and the hugetlb_cgroup pointer of the
folios of a dying cgroup.  In both cases the node (or cgroup) which was
charged keeps a usage which never goes away, while the node (or cgroup)
which ends up uncharging the folio underflows as soon as the folio is
freed.

Patch 1/2 moves the usage along with the folio on cross node migration,
patch 2/2 does the same for the folios a dying cgroup reparents.

This patch (of 2):

hugetlb.<size>.numa_stat uses folio_nid() to account usage in
__hugetlb_cgroup_commit_charge() and __hugetlb_cgroup_uncharge_folio().
hugetlb_cgroup_migrate() only moves hugetlb_cgroup pointers, leaving
per-node usage behind on the source node during cross-node migration.

When the migrated folio gets uncharged, we subtract usage from the
destination node counter.  This creates stale usage on the source node and
unsigned long counter underflow on the destination node.  The
hugetlb.<size>.numa_stat interface exposes these incorrect per-node usage
values to userspace.

Add a hugetlb_cgroup_move_usage() helper which moves the usage from the
old node to the new node, and call it from hugetlb_cgroup_migrate().

Link: https://lore.kernel.org/20260918-for-hugetlb-charge-v2-0-2b6d8c2bdc36@kylinos.cn
Link: https://lore.kernel.org/20260918-for-hugetlb-charge-v2-1-2b6d8c2bdc36@kylinos.cn
Fixes: f47761999052 ("hugetlb: add hugetlb.*.numa_stat file")
Signed-off-by: Hongfu Li <lihongfu@kylinos.cn>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Acked-by: Muchun Song <muchun.song@linux.dev>
Cc: Colin Ian King <colin.i.king@gmail.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: Kees Cook <kees@kernel.org>
Cc: Mina Almasry <almasrymina@google.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: <stable@vger.kernel.org>
Stable-dep-of: 23fac055c211 ("mm/hugetlb_cgroup: move per-node usage on cgroup reparenting")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/hugetlb_cgroup.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index 4cd57f979245f..f68829f1dabad 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -177,6 +177,34 @@ static void hugetlb_cgroup_css_free(struct cgroup_subsys_state *css)
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
@@ -902,6 +930,9 @@ void hugetlb_cgroup_migrate(struct folio *old_folio, struct folio *new_folio)
 	/* move the h_cg details to new cgroup */
 	set_hugetlb_cgroup(new_folio, h_cg);
 	set_hugetlb_cgroup_rsvd(new_folio, h_cg_rsvd);
+
+	hugetlb_cgroup_move_usage(h_cg, h_cg, old_folio, new_folio);
+
 	list_move(&new_folio->lru, &h->hugepage_activelist);
 	spin_unlock_irq(&hugetlb_lock);
 	return;
-- 
2.53.0


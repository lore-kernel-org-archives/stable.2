Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048454;
	b=4uNvA+ZDQJt64dOnOerbHyM0xQBvcvBXb9WUuj0qip9da2T8iTygKfNR+U3gL98YGECj
	 1GaxzQuflYVuuWZr1LIv4CvSpPqZ70kXAMBfUUdqz+sk9qzxKzU/1Yte6HfvcJfRHalr+
	 tHHuVTkD2TzOUb5ToKkcat5ipWT2KhiAvJ7HfTMyLKdM7WaCbQR6KIYJmzfE8KBo2/V4z
	 Cle2hqbYk05Tze1ubCZylHfCdGC2Pfl0X6yeSka0qLAQz61wqL9Q6eYhI04lDaMeI3OU0
	 Zh949WGnIiGhTjgyVyl7iJ0Pd6CHy9fvFLmHSOyi4aTRW/oK9U1TJJ72k6OyM+EZspQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048454;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=gScBU1fCeK3Ja8lsE7m4nHRdCBv0Cjo9bWJtKbCC+Tk=;
	b=GwqXdmpAOEAAcJjCGMcA8vYNg71krebCENEXCNiJUREkFtXcREy7JZuP2AncO4ijTYR5
	 JgVerLW8t5dq7CGDxNrYBoTLj0VQYFjoen+exNO0dZRoN0qGByf21S+u601qSYN6UfMhX
	 /FbSoUi3TcBd1UO3OBjr+6n4EWAaupI7x5MP/oZfKYTLLkiwxQbGfJxBZ0m+cZhZvzCF9
	 evTBTLSLjZM/1TNKKauYs2iAPLkV04JiJBSfr63gtpkHarViq3WiNFcR9DP07wM3O6UvV
	 vxQKw7oJxNypNwkLSwX0L1rnlTcaz4pYUHyITBBM6JAe7ojWAtipnFeC6g3KQolU8kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=otz9kjmY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09D4606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=otz9kjmY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1A921F008A2;
	Sat,  7 Nov 2026 10:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048453;
	bh=gScBU1fCeK3Ja8lsE7m4nHRdCBv0Cjo9bWJtKbCC+Tk=;
	h=From:To:Cc:Subject:Date;
	b=otz9kjmYyXcVsxLasnCwMsKUXHm9JyXcjQ2C3Lq/SR8PiPPDSDvATB7zRTXRSjyQb
	 Qisr1AkcGQRKyp3FpmM9AkUzo/ey85JbPC27LHhQvoYIocooJVZU51BmxndhZC8wXM
	 6wXiq1gtTUBvHVU/E3O1CAL2VZynLHoccz/bhkfHv22LYXaBovrpbdNLsQ/9OR82g8
	 6qtITqlofU6NVUUhKZnatTPxqgd0R7wNWLgXmkywGlLqnC1HokpGgRM9oEcDdzAKb5
	 ledgeEuRpiY6VWigpbS7z6CXkCuYIu437RmdHXP9bpmJF0LPNXMMLU7x+S8td9YDvb
	 TGh60pUtJtfbA==
From: Sasha Levin <sashal@kernel.org>
To: lihongfu@kylinos.cn,
	akpm@linux-foundation.org,
	muchun.song@linux.dev,
	colin.i.king@gmail.com,
	david@kernel.org,
	kees@kernel.org,
	almasrymina@google.com,
	osalvador@suse.de,
	shakeel.butt@linux.dev
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/hugetlb_cgroup: move per-node usage on cross node migration" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:47:31 -0500
Message-ID: <20261107054731-failed-6.1-fe0ba1909c59@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x fe0ba1909c59660f078560f5130e7af7c6004f12
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054731-failed-6.1-fe0ba1909c59@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From fe0ba1909c59660f078560f5130e7af7c6004f12 Mon Sep 17 00:00:00 2001
From: Hongfu Li <lihongfu@kylinos.cn>
Date: Fri, 18 Sep 2026 10:56:10 +0800
Subject: [PATCH] mm/hugetlb_cgroup: move per-node usage on cross node
 migration

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
---
 mm/hugetlb_cgroup.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index ecb6e0b7819a0..7cf7c18119b43 100644
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
2.53.0





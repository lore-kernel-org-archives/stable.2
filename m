Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046466;
	b=RoVJ2Aw44AMfewb11SmM+nMxddZU41A6edXd+dGDxgVgYmmAhVBEGFFGL9MWeqC1+CoP
	 qAeOdW8VlzhvPZUKOtTYEt2HX8zRMGKZXechLdlEQhrDMb+1zkwL2npSEmMJHN9+sS9AZ
	 aO2ze0krrhCFDliXUrcD4O+Ma4csUUJdEmjmmTlD36qyYDX1Ve5XQPkzn5HKiuoGzNAM8
	 4Ggtg4RS8HT5zetRASAxvncnvsS6UMgBDLTLEv+6SwX9IVmqG8eMaj/SYZ05IWWSQTEk4
	 NSScRubW4cqESR4N2M+pCTh98i8i6bqsJbhFNGhEBLXNA4yJ4hZ5mpxKOpWdoFBwLow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046466;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=rXTrEj5VgTtQ26/LCtzn+Zx60ZHRzH/xkpdkpP71lj8=;
	b=ab+oJNsNYlWGPPThCkr7M0OC9xRruqhrKXTw6QTWT8s26yZxikAjHvgsTwjnPnQzlGOM
	 u+xJ/GebV3zH9xQJpPDFcfHE1U6KATkn+MHo/8a10oAPsFdJ7ktZIVcqMfsU1npiVM3Fc
	 3opLOEby7cv2SVJf4xP3FljrjRFXAI+dd1QFLDP9SWX34k6Zcth3uoqGJlLEyg9uiqtTu
	 OVP/MsPolSHdahIWq7UWsknW3JVnuSCg+xfnXH36hki8xI3cSQEFrfnkWW22iysLZt6eg
	 lHdSuIrKnPBp+gdeKU6N4evh1QXKdWtjP4APYd1Xs7VVjx2Wg36q2hGxiXzLtXwd8gQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="HgRQW4/A";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFFA606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HgRQW4/A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE411F0089F;
	Sat,  7 Nov 2026 10:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046466;
	bh=rXTrEj5VgTtQ26/LCtzn+Zx60ZHRzH/xkpdkpP71lj8=;
	h=From:To:Cc:Subject:Date;
	b=HgRQW4/AK7OOh2MLHdeMChLWSicnQMiVa4pUGwP4DahwBkVgkeV0BPIHDCWoH29vT
	 SECBWjHbY+8W+Np19UCSCy8FTnhduT7v381NQdTPDorV8p/iUFuGCK49G0PTaJYG5d
	 u/I9ad4CkdiYhzyOyYXgxFzDqh90E8RNVIWa/WVVmzxS8i0BOnKDHyanUR0ThGibs7
	 GmXMpRbibdqiu6WtbG6w+xqg/w86NW01wykeKUbWyIp0IVIE8rJlC6oYne1usN5FZc
	 wgy80S05IFNZekLCt6RPX25AN3/p4w5opbB2fAbtx4sv90uxOOxPat75rxFQJeSPZh
	 BO5sGWinhnr/Q==
From: Sasha Levin <sashal@kernel.org>
To: lihongfu@kylinos.cn,
	akpm@linux-foundation.org,
	joshua.hahnjy@gmail.com,
	osalvador@suse.de,
	muchun.song@linux.dev,
	david@kernel.org,
	shakeel.butt@linux.dev,
	mhocko@suse.com,
	hannes@cmpxchg.org,
	nphamcs@gmail.com,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	chris@chrisdown.name
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/memcg: migrate per-node hugetlb lruvec stat together with hugetlb folio" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:14:23 -0500
Message-ID: <20261107051423-failed-6.18-02e0c8cc2815@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 02e0c8cc2815f0082b5b5aabafe3b46688082adc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051423-failed-6.18-02e0c8cc2815@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 02e0c8cc2815f0082b5b5aabafe3b46688082adc Mon Sep 17 00:00:00 2001
From: Hongfu Li <lihongfu@kylinos.cn>
Date: Wed, 23 Sep 2026 10:05:16 +0800
Subject: [PATCH] mm/memcg: migrate per-node hugetlb lruvec stat together with
 hugetlb folio

memory.numa_stat exposes per-node hugetlb counters from per-node lruvec
stats.  These stats are accounted against folio_nid(): incremented on the
folio's node when handed to a user, decremented when the folio is returned
to the pool.

During hugetlb folio migration, mem_cgroup_migrate() moves the charge to
the new folio and drops the memcg data of the old one, so the free of the
old folio right after the migration skips the memcg per-node lruvec
decrement.  The hugetlb count stays attributed to the old node for the
rest of the life of the charge, while the target folio gets no increment
on the new node; its later free decrements a counter that was never
incremented.

Migrate the per-node lruvec accounting alongside migration.  Global memcg
totals remain balanced because they track resource consumption, not node
placement.

Link: https://lore.kernel.org/20260923-for-hugetlb_state3-v2-2-e8a36245bfab@kylinos.cn
Fixes: 05d4532b60e3 ("memcg/hugetlb: add hugeTLB counters to memcg")
Signed-off-by: Hongfu Li <lihongfu@kylinos.cn>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Tested-by: Joshua Hahn <joshua.hahnjy@gmail.com>
Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Acked-by: Muchun Song <muchun.song@linux.dev>
Cc: David Hildenbrand <david@kernel.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Nhat Pham <nphamcs@gmail.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Chris Down <chris@chrisdown.name>
Cc: <stable@vger.kernel.org>
---
 include/linux/memcontrol.h |  8 ++++++++
 mm/hugetlb.c               | 25 +++++++++++++++++++++++++
 mm/memcontrol.c            |  5 ++---
 3 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 64c183be8cbfe..cd223f60b3a24 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -983,6 +983,9 @@ unsigned long lruvec_page_state_monotonic(const struct lruvec *lruvec,
 unsigned long lruvec_page_state_local(const struct lruvec *lruvec,
 				      enum node_stat_item idx);
 
+void mod_memcg_lruvec_state(struct lruvec *lruvec,
+			    enum node_stat_item idx, int val);
+
 void mem_cgroup_flush_stats(struct mem_cgroup *memcg);
 void mem_cgroup_flush_stats_ratelimited(struct mem_cgroup *memcg);
 
@@ -1451,6 +1454,11 @@ static inline unsigned long lruvec_page_state_local(const struct lruvec *lruvec,
 	return node_page_state(lruvec_pgdat(lruvec), idx);
 }
 
+static inline void mod_memcg_lruvec_state(struct lruvec *lruvec,
+					  enum node_stat_item idx, int val)
+{
+}
+
 static inline void mem_cgroup_flush_stats(struct mem_cgroup *memcg)
 {
 }
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 4a07eada7779b..68f782f002d31 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -23,6 +23,7 @@
 #include <linux/mmdebug.h>
 #include <linux/sched/signal.h>
 #include <linux/rmap.h>
+#include <linux/rcupdate.h>
 #include <linux/string_choices.h>
 #include <linux/string_helpers.h>
 #include <linux/swap.h>
@@ -7396,12 +7397,36 @@ void folio_putback_hugetlb(struct folio *folio)
 	folio_put(folio);
 }
 
+static void move_hugetlb_lruvec_stat(struct folio *old_folio,
+				     struct folio *new_folio)
+{
+	struct mem_cgroup *memcg;
+	long nr_pages = folio_nr_pages(old_folio);
+	int old_nid = folio_nid(old_folio);
+	int new_nid = folio_nid(new_folio);
+
+	if (old_nid == new_nid)
+		return;
+
+	guard(rcu)();
+
+	memcg = folio_memcg(new_folio);
+	if (!memcg)
+		return;
+
+	mod_memcg_lruvec_state(mem_cgroup_lruvec(memcg, NODE_DATA(old_nid)),
+			       NR_HUGETLB, -nr_pages);
+	mod_memcg_lruvec_state(mem_cgroup_lruvec(memcg, NODE_DATA(new_nid)),
+			       NR_HUGETLB, nr_pages);
+}
+
 void move_hugetlb_state(struct folio *old_folio, struct folio *new_folio,
 			enum migrate_reason reason)
 {
 	struct hstate *h = folio_hstate(old_folio);
 
 	hugetlb_cgroup_migrate(old_folio, new_folio);
+	move_hugetlb_lruvec_stat(old_folio, new_folio);
 	folio_set_owner_migrate_reason(new_folio, reason);
 
 	/*
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4d00748c8a5b8..f2ad4de8d8056 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1015,9 +1015,8 @@ static void __mod_memcg_lruvec_state(struct mem_cgroup_per_node *pn,
 	put_cpu();
 }
 
-static void mod_memcg_lruvec_state(struct lruvec *lruvec,
-				     enum node_stat_item idx,
-				     int val)
+void mod_memcg_lruvec_state(struct lruvec *lruvec,
+			    enum node_stat_item idx, int val)
 {
 	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
 	struct mem_cgroup_per_node *pn;
-- 
2.53.0





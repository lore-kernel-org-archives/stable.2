Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794355767;
	b=gzxfT7RBv7LV/TSnkqZ025KpC1q2H8AhN82mjY6AQYQeiLPwYtLMC5qXnIgfK9R3m4E8
	 7KBeM4Lc8jlXJHGoWgqxTWu5iCG6k0lED6XJ7m/HXsnI7kxeJjVR9nLQKeZr3kbxn737R
	 PQaCgMAZIjGnW9TE5fJ8iE8DLKtSOREnh0b4g/3diAafeDaYE3yzz/YACHHUQf/6aH4xs
	 GZFdjdUSMRjTRPvpkAJiLkJcPIcYkjKYl0X1zAc6blRi5RTWvRJLpsn7b2r/3wVQjsWsE
	 gzJ/8hFyI1MNDKNbYGDXJXqzlVdCjubAHeKo952W81zBG+mOZFAW6q6t+RaZpN1lLNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794355767;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Satpe2sJan3JJDVPpUeuek7THsNxkqrFm8p3OavbLMo=;
	b=ugW8ua1gpO6lXPZgAh0hswk+EakC28/VZlND/HeT91bBTNFmNxCruK4nlmz5ld4PqlU0
	 S4c7RmGLv7i1f9jd2G3mpkfVzgX1Y0MpdI76FcEsDCbgBdufOQSywwgEemSyNfMK8K21D
	 IZ9iJpTXj8QeDHhjeRvnXWAoPgXiEYVenzBUlqBlv+nAblflPWZIEIjXfnyXOpg23YnM8
	 wYZ9xybbZaBvmNjXvF2uYi0TRHGlIT2rPJmStMfDC2iMHh2EGGSGJDwGJDBjkTf0bH/o6
	 BlTvVBy8YFxamPGzII5QTwt1UFnW8yoqfacmL4JWXD+bXNyGJJPMcsCPo/nWskXicoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="BPpTG2/j";
	arc=none smtp.remote-ip=95.215.58.151
Received: from mta1.migadu.com (out-151.mta1.migadu.com [95.215.58.151])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E4B606A335
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 00:09:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22E4B606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=BPpTG2/j
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=JGCe53txtCdD4ibzW3yg/dD5ngq8trn1hFKLU/CEDQs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794355764; v=1; x=1794960564;
 b=BPpTG2/jWPIF4tZwVdE3aYt+28t/VLVsNNegjFk+KPbrE2MfOcUuQXwWm5qrGvxUo4LR5wrY
 FCzDUcvmkgiNk881NBde9JgBN33Q4wPogUb0z8CSjqs9QwsfkYJExP2wQYZXS85NQbakzRc3wgG
 End/fklScVR7zBDG59N1UoUg=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e153a5c284ed39a7;
	Wed, 11 Nov 2026 00:09:24 +0000
X-Mizu-Trace-ID: e153a5c284ed39a7
X-Migadu-Flow: FLOW_OUT
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	David Hildenbrand <david@kernel.org>,
	Qi Zheng <qi.zheng@linux.dev>,
	Kairui Song <kasong@tencent.com>,
	Barry Song <baohua@kernel.org>,
	Meta kernel team <kernel-team@meta.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Noah Feldt <noah@feldt.systems>,
	stable@vger.kernel.org
Subject: [PATCH] mm: mglru: splice all generations when reparenting a memcg
Date: Tue, 10 Nov 2026 16:09:13 -0800
Message-ID: <20261111000913.22943-1-shakeel.butt@linux.dev>
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
Content-Transfer-Encoding: 8bit

Noah reported list_del corruption on single-node hosts running 7.2.11,
which already has commit bf4ade7dbd76 ("memcg: keep folio's objcg same
as its node"). The bad pointer is an MGLRU list head in a freed
mem_cgroup_per_node:

  slab mem_cgroup_per_node start ff31bfa36a3c9e00 pointer offset 528 size 1920
  list_del corruption. next->prev should be ffacf881ccc70e08, but was ff31bfa36a3ca010. (next=ff31bfa36a3ca010)

When a memcg goes offline, __lru_gen_reparent_memcg() moves its MGLRU
lists to the parent. It moves only the generations (gens) from min_seq
to max_seq, and it puts each list at the same index in the parent.

A folio's gen in folio->flags can be ahead of the list it is on. In the
parent, the same index can stand for an older gen, so the folio's gen
can end up older than its list. Once the parent's min_seq passes that
gen, sort_folio() puts the folio on the list for max_seq + 1, where it
stays until the next aging.

If the parent goes offline before that aging, the folio is not moved to
the grandparent. It stays on the parent's list after the parent is
freed, and the next list_del() on it touches freed memory. This needs
two cgroups on one branch to go offline one after the other, such as a
container and then its pod.

The parent always has MAX_NR_GENS gens at this point, so every index is
valid in it. Move all MAX_NR_GENS lists, not only the gens from min_seq
to max_seq.

A reproducer that drives these steps through the lru_gen debugfs file
gets a KASAN use-after-free on the freed mem_cgroup_per_node without
this patch, and no report with it.

Fixes: f304652609ea ("mm: vmscan: prepare for reparenting MGLRU folios")
Reported-by: Noah Feldt <noah@feldt.systems>
Closes: https://lore.kernel.org/all/20261110132853.71228-1-noah@feldt.systems/
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
Cc: <stable@vger.kernel.org>
---
 mm/vmscan.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 6a1af9b92349..902616a3b755 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4751,19 +4751,25 @@ void max_lru_gen_memcg(struct mem_cgroup *memcg, int nid)
  * The same generation has different meanings in the parent and child memcg,
  * so this compromise method will cause the LRU inversion problem. But as the
  * system runs, this problem will be fixed automatically.
+ *
+ * Move all MAX_NR_GENS lists, not only the gens from min_seq to max_seq.
+ * An earlier reparenting can leave a folio whose gen is older than the list
+ * it is on. Once min_seq passes that gen, sort_folio() puts the folio on the
+ * list for max_seq + 1, where it stays until the next aging. If that list
+ * were skipped, the folio would stay behind on a memcg that is about to be
+ * freed. The parent has MAX_NR_GENS gens here, so every index is valid in it.
  */
 static void __lru_gen_reparent_memcg(struct lruvec *child_lruvec, struct lruvec *parent_lruvec,
 				     int zone, int type)
 {
 	struct lru_gen_folio *child_lrugen, *parent_lrugen;
 	enum lru_list lru = type * LRU_INACTIVE_FILE;
-	int i;
+	int gen;
 
 	child_lrugen = &child_lruvec->lrugen;
 	parent_lrugen = &parent_lruvec->lrugen;
 
-	for (i = 0; i < get_nr_gens(child_lruvec, type); i++) {
-		int gen = lru_gen_from_seq(child_lrugen->max_seq - i);
+	for (gen = 0; gen < MAX_NR_GENS; gen++) {
 		long nr_pages = child_lrugen->nr_pages[gen][type][zone];
 		int child_lru_active = lru_gen_is_active(child_lruvec, gen) ? LRU_ACTIVE : 0;
 		int parent_lru_active = lru_gen_is_active(parent_lruvec, gen) ? LRU_ACTIVE : 0;
-- 
2.51.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.219
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794915436;
	b=Mh4OZTHH22oZPwMLjkfI8O8qXI39Uu6JCMv0leRoepwnNBdRi3OxAmSo2fSBBlCWR57+
	 XzMWfp1OZixDvAhvn68ONA4EOYLZO8z/SyHBPgn/cZ5XpUo84vC3+JSjRhaPIgcvaIOLx
	 vuK+raHZ7FZ/9S2kOA7tZzoI5VcKQX24aN84uPEAbCvvfZIjZ1Q6KJDRJbf447ndfNnTn
	 cDMuRrYPciAK7IqQpNPfErhwXtS6wcuTSWU+1S4NjLzA0npNt08dtSCOzcAx8vD5YOY1h
	 +vakWOhHabD2SlSnuLhQsOdZuGI5BSZAGmaOnjVdFQsMpj8hRlYgjk/z3icpHM1P3aQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794915436;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=FIq/acdz95vjbYoS5MNj8HtOBDIDNoJ60+7a7u5rlJg=;
	b=OJ9LEjw5tXNvryfrqnyc52+CXjmt4P/L4sWMZWFstA4XH/i3BIERgDBJXLIx0lZHxUBp
	 286dz+uQBdlfZAI/AbjdhQGBme/7L5dgRD3dncZDf/Z8PuId/sn0b2zRjabyWXcz0qLTe
	 gIXhS72IY7CfBGHKb1m9hw+5Vy4wN545bLH9N7xmlq3OLj7luuDJzr3LP/2de/PjjVHzu
	 Bnl6zKAVHTpRQuZWvW8Y2lthhHYkc6bVLU59kN9vtluvx89qMWgTMLL0NM7b0jnCd4V/b
	 D5t4/nBJ9rgCEcvk7pe76CQv/Q1WYak8TiZxaqkfBsFS6VxFIB8wl14TA6JEcvgGEVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=fEjtek8B;
	arc=none smtp.remote-ip=91.218.175.219
Received: from mta0.migadu.com (out-219.mta0.migadu.com [91.218.175.219])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CF4606A32A
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 11:37:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30CF4606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=fEjtek8B
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=1c0H7lzsrOLvPgIaEgNX/VBYlRpSEzqvqTJWZfntygs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794915433; v=1; x=1795520233;
 b=fEjtek8BsUI4xWPpUqbNZFhH/ighpcAaON8N8vgwoQDHr+DXcSZ/NtEr9kBvqsykxPpJDysS
 ny7ld8ldQvtiv3gU5NNkhI/AiXgwE8S1zS1MO3yh7d3oV9s0onqWDa/U4XAXTkLZy6foghdNcFs
 wamZ869X+UZmGjT5BYnmNquY=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d92e4996c9b348da;
	Tue, 17 Nov 2026 11:37:13 +0000
X-Mizu-Trace-ID: d92e4996c9b348da
X-Migadu-Flow: FLOW_OUT
From: "Hui Zhu" <hui.zhu@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Kairui Song <kasong@tencent.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	David Hildenbrand <david@kernel.org>,
	Michal Hocko <mhocko@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Harry Yoo <harry@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Hui Zhu <zhuhui@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] mm: mglru: reset the mm iteration cursor in try_to_inc_max_seq_nowalk()
Date: Tue, 17 Nov 2026 19:37:00 +0800
Message-ID: <20261117113700.453044-1-hui.zhu@linux.dev>
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

From: Hui Zhu <zhuhui@kylinos.cn>

iterate_mm_list_nowalk() and try_to_inc_max_seq_nowalk() both advance
mm_state->seq without walking the mm_list, but only the former drops the
cursor. When the latter races with an ongoing page table walk, head is
left pointing into the middle of the fifo.

The next walker reads that as "this generation already started": it skips
reset_bloom_filter() and resumes after the cursor. Every mm before the
cursor is skipped, and none of them have bits in the filter being read, so
walk_pmd_range() descends into none of their PMDs and harvests no accessed
bits. try_to_shrink_lruvec() ignores the failed try_to_inc_max_seq() and
keeps evicting, so those hot folios become reclaim candidates and refault
in the parent memcg, until head wraps around a generation later.

Factor the pattern into skip_mm_iteration(), which carries the rationale
that used to sit in a comment in try_to_inc_max_seq_nowalk(), so the two
callers cannot drift apart again. The wrap-around in iterate_mm_list() is
left open-coded on purpose: there head is already back at the fifo, and
tail has to survive for the force_scan test. Dropping the cursor is safe:
get_next_mm() holds an mmgrab() reference, and a concurrent walker bails
out at "walk->seq <= mm_state->seq" before touching head again. The
unwalked part of the fifo restarts from the head next generation, as
iterate_mm_list_nowalk() already does.

Only reachable from memcg_reparent_objcgs() -> max_lru_gen_memcg(); not a
memory safety issue, since lru_gen_del_mm() repoints head and tail under
mm_list->lock.

Fixes: f304652609ea ("mm: vmscan: prepare for reparenting MGLRU folios")
Cc: stable@vger.kernel.org
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
---
 mm/vmscan.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 6a1af9b92349..0dc4017b87e4 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3235,6 +3235,7 @@ static bool iterate_mm_list(struct lru_gen_mm_walk *walk, struct mm_struct **ite
 	do {
 		mm_state->head = mm_state->head->next;
 		if (mm_state->head == &mm_list->fifo) {
+			/* head is back at the fifo; keep tail for force_scan below */
 			WRITE_ONCE(mm_state->seq, mm_state->seq + 1);
 			last = true;
 			break;
@@ -3263,6 +3264,18 @@ static bool iterate_mm_list(struct lru_gen_mm_walk *walk, struct mm_struct **ite
 	return last;
 }
 
+/*
+ * Advance mm_state->seq without walking the mm_list. The cursor must be
+ * dropped as well: iterate_mm_list() resumes from head, and resets the Bloom
+ * filter only when head == &mm_list->fifo.
+ */
+static void skip_mm_iteration(struct lru_gen_mm_state *mm_state)
+{
+	mm_state->head = NULL;
+	mm_state->tail = NULL;
+	WRITE_ONCE(mm_state->seq, mm_state->seq + 1);
+}
+
 static bool iterate_mm_list_nowalk(struct lruvec *lruvec, unsigned long seq)
 {
 	bool success = false;
@@ -3275,9 +3288,7 @@ static bool iterate_mm_list_nowalk(struct lruvec *lruvec, unsigned long seq)
 	VM_WARN_ON_ONCE(mm_state->seq + 1 < seq);
 
 	if (seq > mm_state->seq) {
-		mm_state->head = NULL;
-		mm_state->tail = NULL;
-		WRITE_ONCE(mm_state->seq, mm_state->seq + 1);
+		skip_mm_iteration(mm_state);
 		success = true;
 	}
 
@@ -4686,15 +4697,11 @@ static void try_to_inc_max_seq_nowalk(struct mem_cgroup *memcg,
 	DEFINE_MAX_SEQ(lruvec);
 	bool success = false;
 
-	/*
-	 * We are not iterating the mm_list here, updating mm_state->seq is just
-	 * to make mm walkers work properly.
-	 */
 	if (mm_state) {
 		spin_lock(&mm_list->lock);
 		VM_WARN_ON_ONCE(mm_state->seq + 1 < max_seq);
 		if (max_seq > mm_state->seq) {
-			WRITE_ONCE(mm_state->seq, mm_state->seq + 1);
+			skip_mm_iteration(mm_state);
 			success = true;
 		}
 		spin_unlock(&mm_list->lock);
-- 
2.53.0


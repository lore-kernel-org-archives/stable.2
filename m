Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793029774;
	b=fh1Y3K+RLU3KF6OVzDQT1BPKbWPXpUtEPRB3mwIoK4/Fp/ol10nKEv0B3m/ilt3ZNYTt
	 JYMCQSz/uES6906jDFgvj9HT4jTSeo60QSEtHw5R7ex4sucTOdT4dQxUnqrfv1QUta8wu
	 kwtDTLXqfHEKA106ndlyNTuNaP03huSi6fNDhBu0U60hPPAi37P+tGSmKeL8JS3/mq36+
	 KXe51v+FrQmBXXKX8sdu2HB3nA0Voe1OPWVy+OW1VDBPyNUYn9WMFbtOdUkK1KNLZTCjh
	 5FzfD1HyeIP4kSWneQBaU0Kp1gF4wkMaxcs1/S8/ZuklIWITUo2HR8hpfgY5dS/+cnQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793029774;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=gIMYYwsrKzPtbWDE7RlZn+P90F1xn6M8q6wSRrrBMk8=;
	b=ZPjM8ftPeJmEk1BuMiRQRFaLW7Y2G/oqJ9Pnm00/fiTvXc7NkHiaMsfuLsSpw7DBTNAm
	 HHjZJQ8JBuzjrNSLtbrzATay03a71OIf6BUBsQl5jGgVjjMMAu2wR+3iwrERI4Oa+jyg3
	 bIuvnLZ4vPYRcr77i8Wp8zZjwvvfVavHxYVRsyWxYbsJuyns6bigH9jA2RHnKkryC+w8W
	 dLGKDC5U9SiFYP0aLVTTwDCqk+E3pNFVFJCmbTXubM+4izAIMJgOr60QrUcgXHnuEpWoS
	 UYLsQu4m10uw7gwAD5gGC/tlkbLiQ+oe+KvPo2xGiuHEZ9J/GCg/uscpfEYYnH/9Krg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YtHtmEUE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21A3606A31B
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 15:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YtHtmEUE
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793029773;
	b=vglOcF15WhH+RqehvEcb80YASNXClssjClOU5v5dCP2Ve8XAd7tLK1wPfC0gkt9hBGw9
	 ZZe8Q7C3rn/UfI3wZl9E140UFBomhqyYXziMyizFWVeHABJjCFl3ya+izYyRGxwCl8aT5
	 8HePOk3kKxteVYDXNZt5DZuRO7dRgS/Lk4HFSj3qamLD4s/T4bRuizjQLWBxI6JkbZycG
	 9YiWWAUVmMub3a/RmtntetFFsMWd9Dh8XW4ascCFK6J2q5mjNybGbokmpW5q2n0+IUfTm
	 Cz6/LxnIximakTgJjx/RRANhGQ0vH0ngdZtjrTdfDTaFGpo0WrDdJ7MddpNmWfYISPA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793029773;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=gIMYYwsrKzPtbWDE7RlZn+P90F1xn6M8q6wSRrrBMk8=;
	b=CU/igJrYeoC8GDaIr1N5k3lYZCg2PaB3RBEzwonhsO4v/NRuGNiKCbXswAPIUGTZcIo0
	 rto/PNc81NTL0f/H+Va9jNOY4xrzZchyNv4Emli73OE0yITVgvINZOqctmrvRkVTrqTXP
	 U5ysh5TTdAiJ5OY/4//zjc28fifgCXQlhyOpEaLdM38goc9U6rP03hpSx+k1ztCpW4ByC
	 EyEtGAgD1TvTDDbkGU0cK5WnAWUjJpQNCLutRKZanBG+swREsMouxPWlEZ3NV3r+3y8fU
	 gAO9VM5jCMIh8jw7q3lXnp2IY46Q8QRJWCFGAVKOwV+FbamahYy2qruKqzThmhVXQrw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id DEB451F01828;
	Mon, 26 Oct 2026 15:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793029773;
	bh=gIMYYwsrKzPtbWDE7RlZn+P90F1xn6M8q6wSRrrBMk8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=YtHtmEUEjIT+7lQtTrjn9krP2KqVk3IgixVwej3hV4uPuUfN3FTzdZngqeq++cBVo
	 wrYxjaIXLygCgqdwX2aiNM2+kt4tCylhS7qX4NVWzWdiaolqGOaMxsMugiH7wvLcQA
	 JuDSMnyo72jzPaeX68L1AKcaA8VpsggBCk7b6zjcjBluF30M+O1gFfmXsVzBCzJwdv
	 KxQ0ZQqS/JZmrxWFmubJV7itOmb40ERXSzlrUjnzEm3wNA5jA1S4LWGT86HuZILJ6P
	 Mpe5TBSqquxjv5Eu61pWA0Ie+9lO2/V7PFWPmI6zbkkX6P29wGR9Po9wz+wIbGsbjS
	 R6uwgJOEgQ08Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 6FEE744D72;
	Mon, 26 Oct 2026 15:49:32 +0000 (UTC)
From: Leno Hou via B4 Relay <devnull+lenohou.gmail.com@kernel.org>
Date: Sat, 24 Oct 2026 13:38:44 +0800
Subject: [PATCH PATCH 6.1 v2 1/2] mm/vmscan: wake up flushers conditionally
 to avoid cgroup OOM
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261024-linux-6-1-y-v2-1-92958fc61228@gmail.com>
References: <20261024-linux-6-1-y-v2-0-92958fc61228@gmail.com>
In-Reply-To: <20261024-linux-6-1-y-v2-0-92958fc61228@gmail.com>
To: stable@vger.kernel.org
Cc: Leno Hou <lenohou@gmail.com>, Wei Xu <weixugc@google.com>, 
 Zeng Jingxiang <linuszeng@tencent.com>, Kairui Song <kasong@tencent.com>, 
 Chris Li <chrisl@kernel.org>, "T.J. Mercier" <tjmercier@google.com>, 
 Yu Zhao <yuzhao@google.com>, Andrew Morton <akpm@linux-foundation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792820328; l=5755;
 i=lenohou@gmail.com; s=20260311; h=from:subject:message-id;
 bh=0d7QVgoVckaBOurFR1f+iOafa5xlnfuyL335LZOiMh0=;
 b=oqV08dxSUTK3kz6r3WZidCMHRwYVWgIipIbILLUKws2UHy/70FGgWgyRl9Fgaa8Qbp3/Y/eiy
 0Uj4DM0DNYNA0SjoOUZmIJIm//0yXnPRyYvlDjhBwvmQnepHzm1e7yB
X-Developer-Key: i=lenohou@gmail.com; a=ed25519;
 pk=8AVHXYurzu1kOGjk9rwvxovwSCynBkv2QAcOvSIe1rw=
X-Endpoint-Received: by B4 Relay for lenohou@gmail.com/20260311 with
 auth_id=674
X-Original-From: Leno Hou <lenohou@gmail.com>
Reply-To: lenohou@gmail.com
Content-Transfer-Encoding: 7bit

From: Leno Hou <lenohou@gmail.com>

[ Upstream commit 1bc542c6a0d1444559ab75823a89a94d244bf933 ]

Commit 14aa8b2d5c2e ("mm/mglru: don't sync disk for each aging cycle")
removed the opportunity to wake up flushers during the MGLRU page
reclamation process can lead to an increased likelihood of triggering OOM
when encountering many dirty pages during reclamation on MGLRU.

This leads to premature OOM if there are too many dirty pages in cgroup:
Killed

dd invoked oom-killer: gfp_mask=0x101cca(GFP_HIGHUSER_MOVABLE|__GFP_WRITE),
order=0, oom_score_adj=0

Call Trace:
<TASK>
dump_stack_lvl+0x5f/0x80
dump_stack+0x14/0x20
dump_header+0x46/0x1b0
oom_kill_process+0x104/0x220
out_of_memory+0x112/0x5a0
mem_cgroup_out_of_memory+0x13b/0x150
try_charge_memcg+0x44f/0x5c0
charge_memcg+0x34/0x50
__mem_cgroup_charge+0x31/0x90
filemap_add_folio+0x4b/0xf0
__filemap_get_folio+0x1a4/0x5b0
? srso_return_thunk+0x5/0x5f
? __block_commit_write+0x82/0xb0
ext4_da_write_begin+0xe5/0x270
generic_perform_write+0x134/0x2b0
ext4_buffered_write_iter+0x57/0xd0
ext4_file_write_iter+0x76/0x7d0
? selinux_file_permission+0x119/0x150
? srso_return_thunk+0x5/0x5f
? srso_return_thunk+0x5/0x5f
vfs_write+0x30c/0x440
ksys_write+0x65/0xe0
__x64_sys_write+0x1e/0x30
x64_sys_call+0x11c2/0x1d50
do_syscall_64+0x47/0x110
entry_SYSCALL_64_after_hwframe+0x76/0x7e

memory: usage 308224kB, limit 308224kB, failcnt 2589
swap: usage 0kB, limit 9007199254740988kB, failcnt 0

...
file_dirty 303247360
file_writeback 0
...

oom-kill:constraint=CONSTRAINT_MEMCG,nodemask=(null),cpuset=test,
mems_allowed=0,oom_memcg=/test,task_memcg=/test,task=dd,pid=4404,uid=0
Memory cgroup out of memory: Killed process 4404 (dd) total-vm:10512kB,
anon-rss:1152kB, file-rss:1824kB, shmem-rss:0kB, UID:0 pgtables:76kB
oom_score_adj:0

The flusher wake up was removed to decrease SSD wearing, but if we are
seeing all dirty folios at the tail of an LRU, not waking up the flusher
could lead to thrashing easily.  So wake it up when a memcg is about to
OOM due to dirty caches.

I did run the build kernel test[1] on V6, with -j16 1G memcg on my local
branch:

Without the patch(10 times):
user 1449.394
system 368.78 372.58 363.03 362.31 360.84 372.70 368.72 364.94 373.51
366.58 (avg 367.399)
real 164.883

With the V6 patch(10 times):
user 1447.525
system 360.87 360.63 372.39 364.09 368.49 365.15 359.93 362.04 359.72
354.60 (avg 362.79)
real 164.514

Test results show that this patch has about 1% performance improvement,
which should be caused by noise.

Link: https://lkml.kernel.org/r/20241026115714.1437435-1-jingxiangzeng.cas@gmail.com
Link: https://lore.kernel.org/all/CACePvbV4L-gRN9UKKuUnksfVJjOTq_5Sti2-e=pb_w51kucLKQ@mail.gmail.com/ [1]
Fixes: 14aa8b2d5c2e ("mm/mglru: don't sync disk for each aging cycle")
Suggested-by: Wei Xu <weixugc@google.com>
Signed-off-by: Zeng Jingxiang <linuszeng@tencent.com>
Signed-off-by: Kairui Song <kasong@tencent.com>
Reviewed-by: Wei Xu <weixugc@google.com>
Tested-by: Chris Li <chrisl@kernel.org>
Cc: T.J. Mercier <tjmercier@google.com>
Cc: Yu Zhao <yuzhao@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Leno Hou <lenohou@gmail.com>
---
 mm/vmscan.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index d39d3f88e0d2..f58651d45540 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4748,6 +4748,7 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
 		       int tier_idx)
 {
 	bool success;
+	bool dirty, writeback;
 	int gen = folio_lru_gen(folio);
 	int type = folio_is_file_lru(folio);
 	int zone = folio_zonenum(folio);
@@ -4803,9 +4804,17 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
 		return true;
 	}
 
+	dirty = folio_test_dirty(folio);
+	writeback = folio_test_writeback(folio);
+	if (type == LRU_GEN_FILE && dirty) {
+		sc->nr.file_taken += delta;
+		if (!writeback)
+			sc->nr.unqueued_dirty += delta;
+	}
+
 	/* waiting for writeback */
-	if (folio_test_locked(folio) || folio_test_writeback(folio) ||
-	    (type == LRU_GEN_FILE && folio_test_dirty(folio))) {
+	if (folio_test_locked(folio) || writeback ||
+	    (type == LRU_GEN_FILE && dirty)) {
 		gen = folio_inc_gen(lruvec, folio, true);
 		list_move(&folio->lru, &lrugen->folios[gen][type][zone]);
 		return true;
@@ -4921,6 +4930,8 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
 	__count_memcg_events(memcg, PGREFILL, sorted);
 	__count_vm_events(PGSCAN_ANON + type, isolated);
 
+	if (type == LRU_GEN_FILE)
+		sc->nr.file_taken += isolated;
 	/*
 	 * There might not be eligible pages due to reclaim_idx, may_unmap and
 	 * may_writepage. Check the remaining to prevent livelock if it's not
@@ -5051,6 +5062,7 @@ static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swap
 		return scanned;
 retry:
 	reclaimed = shrink_folio_list(&list, pgdat, sc, &stat, false);
+	sc->nr.unqueued_dirty += stat.nr_unqueued_dirty;
 	sc->nr_reclaimed += reclaimed;
 
 	list_for_each_entry_safe_reverse(folio, next, &list, lru) {
@@ -5251,6 +5263,13 @@ static void lru_gen_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc
 	if (sc->nr_reclaimed - reclaimed >= MIN_LRU_BATCH && !need_aging)
 		sc->memcgs_need_aging = false;
 done:
+	/*
+	 *  If too many file cache in the coldest generation can't be evicted
+	 *  due to being dirty, wake up the flusher.
+	 */
+	if (sc->nr.unqueued_dirty && sc->nr.unqueued_dirty == sc->nr.file_taken)
+		wakeup_flusher_threads(WB_REASON_VMSCAN);
+
 	clear_mm_walk();
 
 	blk_finish_plug(&plug);

-- 
2.55.0



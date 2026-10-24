Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793029703;
	b=Zba1MyAiQms8d5ACduBP7mvgB0vvu0Mhq3/ndylDYX7wdAJ4PAsU4Fr6BWGhIz0EaGre
	 ZECkPlMjLboh22BHTSFU5FbspY3VPv88A1cM4TNYZXto7J9JcDx1NLazrZvjdKEqXx7ZB
	 lN8c2thgrxlEKOUW1QJObaiOm+tmHF8lYR8s3VgDkgxae1BqFB6Gr4IRaUHpu2JLgVGj0
	 XzRKcJJ44rUdm6LjE/MD1yBWcHchjR17HaZoJWWMSJiv6Qwz7ngJnkl+ZcNxIaoHMvup1
	 RWk2ozGFukZD6WF0g948Fry41MyojDHPHKkGu/xb4Q6tElwmv/X+Jeu5s1cJR4fw6Sg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793029703;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=nByaPGifWhdymgTv0l+Yl389VEYp9ZKjAN6bLOnaRG0=;
	b=yuf4aDAoS+AfGV88+Xo1Rc/wVddqqjNboYrTcJBh3pCE408TU4kFc5VBjf46rezB8aR4
	 3bemVeHs3hepKO+XatBPolM/SC4Qs5QZ1Uyu2KqUE/lCLmZ99p4ZjdTCNfagwwwIM4v4Y
	 sgyV4dl9PFAd+U9qLhDtPSP4raB/Lg/dQVr1KXoB62zdXy1Sbjbwnvg223qAz8fqkutG0
	 iOVg6uQXHxPtubBO1FU+nRn0rh9oS3k6GiarzVhS5RlaTeeIrZtVwnCl1SPk58zhklvhd
	 NTg/5ieIvTqqvHdcPLUgQVXsDbl+SnV/ssYmbPoHnWZ9mAHtRIYsC2UOyJdJemC19zw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nAUMnlEc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81991606A31D
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 15:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nAUMnlEc
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793029702;
	b=HWdOUAGa5mgqhcvKBKqcBwJ+OAkyEBhaOMOqmWWBNGJ4H8szmN9fMq5HKbhHcHHnj6b+
	 RHreCe3Sifx/8fR4Ov73IBwBSQ/w7mstBLYAe7Gm4tvEKJZ4Ns5gg+k1fuTrG4b2DFbJ6
	 Zrdsp+pLOt7ZLPDiz41aFltCAq/PRijOL6k+PTgWUaEvz0ypR9ENosuZpV+t/60OW1mYQ
	 dM+n0XUPkL6rbuVwlDFnjEXWq+cOXdkWUEPB7a8Ax3u43iWAECISdRsheogm7xVwEB1Oj
	 G2hhPhSmoN8CsekunKh0Po8ZpduBNQrfpPlAR35Zu+lxB+a3Zb3ahPmVvY57aYodnKQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793029702;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=nByaPGifWhdymgTv0l+Yl389VEYp9ZKjAN6bLOnaRG0=;
	b=0dpywp094lWTj/OURxUE2zO3uf0xnpF2LVbUuGuljTSPVZbS43DAgIbYmrcu/cu1rbKR
	 a5n4I+lJ0mXFltbg5B5uM8kWBy+IZaXdNSLdiILGld2RDQg3zz6DPcveEaQfFlHS0sfkv
	 2R6t+vuHmau+mDy01tfnDvZHtsp0iLWT2gq7keowa1w2E8ihs9UpC96N5mieOAhUoBg80
	 w4h7NsWXUfZ1SFWv6ns2VwTjo9EhLNDWmmRY6XHrdCX9C+cprCLIriysVeOVo3BlFmWQd
	 tyz/sJ+WfIeMBtaD00X7biUWncFVGtEhl0rJbtPI1Te4XzBJi8ZJaYvZ/8Mk61rveTA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 801E21F01828;
	Mon, 26 Oct 2026 15:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793029702;
	bh=nByaPGifWhdymgTv0l+Yl389VEYp9ZKjAN6bLOnaRG0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=nAUMnlEcl2/iXdzvL6Wu+PGrnF9fhZzCAOXvL2inDX6tQb7WmXiuUyY6FTU6KvMoZ
	 HFmDQjHlGXT+zkYte90oMACRxG4kiWZhudAps22h5q8IjOElgjYli1DPCrrRFQh3Qo
	 fIKduTY+nDO5Qm+U+Nb1g/iJ9Rjoz5DlrChXt4qJLlhnE/LJJvYhulK0cxmzxvK6Zw
	 dTucHVOM4CvX+u0yR85agP6cj+W/Vtat0okcPINLNpvoqo+9HaPeWpM2UNh3+5xqaU
	 0dP7u5ctFGwJ3tn8T46q+a8c/HGVQwfYKwD0MB28D4PnB+5Xebo/wMyEGfu/1Oj4l1
	 1TkVY2F14Obpw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id EF17544D69;
	Mon, 26 Oct 2026 15:48:20 +0000 (UTC)
From: Leno Hou via B4 Relay <devnull+lenohou.gmail.com@kernel.org>
Date: Sat, 24 Oct 2026 13:37:25 +0800
Subject: [PATCH PATCH 6.6 v2 1/2] mm/vmscan: wake up flushers conditionally
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
Message-Id: <20261024-fix-mglru-v6-6-v2-v2-1-6ca69ba6e9ae@gmail.com>
References: <20261024-fix-mglru-v6-6-v2-v2-0-6ca69ba6e9ae@gmail.com>
In-Reply-To: <20261024-fix-mglru-v6-6-v2-v2-0-6ca69ba6e9ae@gmail.com>
To: stable@vger.kernel.org
Cc: Leno Hou <lenohou@gmail.com>, Wei Xu <weixugc@google.com>, 
 Zeng Jingxiang <linuszeng@tencent.com>, Kairui Song <kasong@tencent.com>, 
 Chris Li <chrisl@kernel.org>, "T.J. Mercier" <tjmercier@google.com>, 
 Yu Zhao <yuzhao@google.com>, Andrew Morton <akpm@linux-foundation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792820248; l=5683;
 i=lenohou@gmail.com; s=20260311; h=from:subject:message-id;
 bh=nKAzG19+qMzUxs7SJjNjH/nBPOniYdoxadIdZNRaLLU=;
 b=dUZo43mInN2lG0/tGEROH+dfi9QWLW/fpeuGoKrmiKuWgCenmAguqhOw23mAXxdW7gzuh8iC3
 sayk/PbefPTCuWchbRXmvQ24EGl3iLx9OINT6SC+JNcuqWeZcICzOHh
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
 mm/vmscan.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 4197e10a27b6..a165f685216d 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4913,6 +4913,7 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
 		       int tier_idx)
 {
 	bool success;
+	bool dirty, writeback;
 	int gen = folio_lru_gen(folio);
 	int type = folio_is_file_lru(folio);
 	int zone = folio_zonenum(folio);
@@ -4961,9 +4962,17 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
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
@@ -5075,6 +5084,8 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
 	__count_memcg_events(memcg, PGREFILL, sorted);
 	__count_vm_events(PGSCAN_ANON + type, isolated);
 
+	if (type == LRU_GEN_FILE)
+		sc->nr.file_taken += isolated;
 	/*
 	 * There might not be eligible folios due to reclaim_idx. Check the
 	 * remaining to prevent livelock if it's not making progress.
@@ -5203,6 +5214,7 @@ static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swap
 		return scanned;
 retry:
 	reclaimed = shrink_folio_list(&list, pgdat, sc, &stat, false);
+	sc->nr.unqueued_dirty += stat.nr_unqueued_dirty;
 	sc->nr_reclaimed += reclaimed;
 
 	list_for_each_entry_safe_reverse(folio, next, &list, lru) {
@@ -5415,6 +5427,12 @@ static bool try_to_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
 		cond_resched();
 	}
 
+	/*
+	 *  If too many file cache in the coldest generation can't be evicted
+	 *  due to being dirty, wake up the flusher.
+	 */
+	if (sc->nr.unqueued_dirty && sc->nr.unqueued_dirty == sc->nr.file_taken)
+		wakeup_flusher_threads(WB_REASON_VMSCAN);
 	/* whether this lruvec should be rotated */
 	return nr_to_scan < 0;
 }

-- 
2.55.0



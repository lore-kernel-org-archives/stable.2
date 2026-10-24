Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793029590;
	b=aVabjMLclIOF1Aox5syV6sTFs90TDfcH9zWNyxowFBHhuIBKL+HuzbF0N2CaTsRvHb2I
	 WnANsyGPnojoNLFJ3hTbvQ6Zu0p0+Kc/ps8p6802ElbroOMlUvRXDxP+gzB5ouU4fXjbE
	 g5gn5C5OV4XORC4yUUFsgpLfEsNQn28MNYnzX0q0BFjoietigLO0ROqn80MvKH34BeOWM
	 qEQOeqkDb5cba0oxgmtYLiigM2cA+6htPQG2MRytjxRT6zOuEyzy3D3M/Brv/GBJdEnPA
	 lGTNWOOS8wcWJWjLhlNars4i+EH55bCKD56AzlzUjJIeEtBXAWanubiKousJ062SX8Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793029590;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=nByaPGifWhdymgTv0l+Yl389VEYp9ZKjAN6bLOnaRG0=;
	b=FJbDhETX1uCgzq1r3FCWd1amxfEmI3SkXw9ZPMpjB5UKT3xL7GGyAAviEkvn3PHY8bZr
	 FgUgqUE+czAmDQwILwcHe4hZQI9CUshByZm2+GAd6COq7steI9d8JLkLC1pJJhoXc9kLa
	 2/AkqJBMY2xy0HCT5vCbkPevc5+8r36lBW0CnIrlTnBU/bCOC/nIvgBqsvGzHmfIc02z4
	 D90jUB6uc4T9n5Lj58qNWtUvmkjg+fTqvL0cPab7pLsG0lRmW3VFvC1SFehf4H0XWO+Vt
	 np+mp2lf2tyGoggjuN55N7MRKi+71hdjxHz420IGUtAGUNkl1NlWrTAzVEK5pEiZXrQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BGPMJO+m;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18AF606A328
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 15:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BGPMJO+m
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793029589;
	b=kXgsud4fJj1SFJUKGh3IDcrQuunMzk3wRvivES/bSlNRm6d6z+AzAfBILv+V6K0MEDDj
	 Y/bvucdbQhTEOeKoj7Y6xxTAGqzTF7W/O0VPJvPYeWDam/fP5PCs0ooWuGqyY83vJgecw
	 RhquU2mJZqON7bDEk1kTYVuY/Vu9lshgBMdwwO3n755g+mlTcTj1tDj2b3oHhxLtd+uTb
	 ji8lPTnOyKoEavmhEyi2JMrd3Xo9jEOYJsceBF29Z/7eMtyRdQKEMmTeAFmXzS+TykmGc
	 U0+iAc3N/lJQJDsZ+r/dEaJKPRAeg7NMbchzt6lpdkGo4tbHIzk5M9cnAzZIn8Q7TEA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793029589;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=nByaPGifWhdymgTv0l+Yl389VEYp9ZKjAN6bLOnaRG0=;
	b=NZUcvd3KvTYOH0Hb8VyGlGMGpOxQ1w5lI2ARoQHpzgZHxTYFOmVrT+kBFsVwp2q1tars
	 tp5g3gzcGpEEIiGt8hLdSJhlGBPpC6hJdVAMpPLqEdKecVUE6+/aevhT+4+B/mpDpgTk8
	 CcnWd8UEjcUlhKqyB3GHsHGT6XZz53t7BUbKGmxEWbVPtCmJNjyCARn5DI6JoKpcAHI27
	 BJsZBSNeVkf2u7/S321RECxp/NzuK4DvxDzq5pQX9ZSWLNgsJ5fI3Nk5NTzCo1czhzdXH
	 v3OdqX7inGEDzHyFL4di6fJb1Y+Wb88opX5ACBUPX7ClDN1uyzIRwHMj4mwds4hJKsw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 0A0C41F031E3;
	Mon, 26 Oct 2026 15:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793029589;
	bh=nByaPGifWhdymgTv0l+Yl389VEYp9ZKjAN6bLOnaRG0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=BGPMJO+mPq+KWQptfZ0eFm72ZXPZ6ZisHruSX2K4jXboNbOm941x4lDodeZ1qh0Zk
	 alNqFZ/xwxadfHpA4ushtRlPr+Sc51HFhghnkdJvGQWx5GRt1QwvcmXU+bPE/ewO7u
	 HtMPKFNBkYHdpfkfMWzDk4VR0ug0+WDimdRhtQYQejUnDCecc8EODhGxkEh2WhM/Dr
	 K9BX6luVQW54Y7VZQvTlIu+JYWkadaTnWC6HpmCfw2jsyAjxshSIhSMaCGW99KR6ta
	 IKs+tt3J0QHH4SL2yRkzXzTUP/y6ZKA4/I0QwPN1nr9IxjSt74Ossf7QjnwlJjvQC9
	 FoWIP8v6z+2fQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 704FF44D51;
	Mon, 26 Oct 2026 15:46:28 +0000 (UTC)
From: Leno Hou via B4 Relay <devnull+lenohou.gmail.com@kernel.org>
Date: Sat, 24 Oct 2026 13:35:03 +0800
Subject: [PATCH PATCH 6.12 1/2] mm/vmscan: wake up flushers conditionally
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
Message-Id: <20261024-fix-mglru-v6-6-v2-v1-1-8c9b40f9fc24@gmail.com>
References: <20261024-fix-mglru-v6-6-v2-v1-0-8c9b40f9fc24@gmail.com>
In-Reply-To: <20261024-fix-mglru-v6-6-v2-v1-0-8c9b40f9fc24@gmail.com>
To: stable@vger.kernel.org
Cc: Leno Hou <lenohou@gmail.com>, Wei Xu <weixugc@google.com>, 
 Zeng Jingxiang <linuszeng@tencent.com>, Kairui Song <kasong@tencent.com>, 
 Chris Li <chrisl@kernel.org>, "T.J. Mercier" <tjmercier@google.com>, 
 Yu Zhao <yuzhao@google.com>, Andrew Morton <akpm@linux-foundation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792820120; l=5683;
 i=lenohou@gmail.com; s=20260311; h=from:subject:message-id;
 bh=nKAzG19+qMzUxs7SJjNjH/nBPOniYdoxadIdZNRaLLU=;
 b=hs5esTyf1IUbt08zd7+Sw38VRY1s12/NwQfFxT+xddn4b5GK084d27pabGqpQQsTCd2zzXIM+
 xLNYwoog8NdDaGeZT9Se+vWZLD6WbW46zAaHKvoER0DoWvRC/qA5ZiF
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



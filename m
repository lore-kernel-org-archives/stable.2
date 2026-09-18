Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E600509F10
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 18:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789754945; cv=none; b=KbesIAKKPYN0qDlBMl71HHpIUgP6a7UE3F6H/U0bpZH7aqGHXWEtkCKliRKfFZI8RB2sNVQ8j5p29YPFqTTNVE5y/AKxJgOMgApuWcrMKFCos/TMmqKIZgsNh9m8cHHJW8HvCarYqRbxVCFjdeEvUM1Kb9+MzlFflRgzKCPlHHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789754945; c=relaxed/simple;
	bh=LR4JEdw2wPTCUDDNs92OFOmz3Z/nYs/LyYeJDcSo02A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=buHUF442DGYJtzaDMKXWqcIgghR1w7vIsF0la/ZNEVELo2JbZfmmFb3chcVyIQj1bvL9I+28r/U0xLpokfqOEHFS0yiJz8SIAlGuae9vCvNYkgt//K6YUqtipx24nT2igWcc5jagiWr5YnSpcaBjXsLxX22EYHNClUYQ+T3cPQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rixzf66W; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rixzf66W"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-398beb616f5so420611a91.1
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 11:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789754943; x=1790359743; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2TdKGVlDtVwGrUdWbCMPXi1XpcC9vFU18b6XTOJl8K0=;
        b=Rixzf66WwqvzAflAVZvjyauANE/GfJHfwRM3jyIz3Ho1uf+0NZ4NH0/OVka0BK2R0Z
         aoAUS8b4UJgGM9U1LSt2227nIGX3Gg4m85uoBX7H/5Q9CzxLOhlbEHx4l+fB0S/hXc2r
         Z/f0n4JzxFZyDA3nZMHnAAXdaqXpUNPWEjeluUM22JzCFj69RUvqg3ok01ppLjPcVt5+
         p+i51E0aTNANWdTATDgY1Ec999ZzfQleSvfUEqe+EQx5A4cvLPIad0ydgIuglX6CA5Se
         5YGKMwEoOu1A2JBpyWZftBSZ/SbQB0N6QxQIouVYe6L/yGEcEqIY+lX+ctlobOZihIdZ
         nWjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789754943; x=1790359743;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2TdKGVlDtVwGrUdWbCMPXi1XpcC9vFU18b6XTOJl8K0=;
        b=PQhBBtZEKGEAGXMGgoIJQ1niw6b+dj8LxGXY7rZR07EmQyUjwnOQPkbpMtc22jXMah
         VfAEegBG4oxJNZ8K7Vpk229E3cY0u7rg50jvYTAJZI1Vk2ZX2ai19dd15jo4X4xB/Zme
         uVSsT1eEmBbEHhYhZluHuwFCyMoDNhzYyd3Txf4q2jY7EbAq9XAGngzFLHmAnCOOQ5kO
         LW4clLoKK5/gG/0rIRQkk0c0wggZUYTBe9J1X1JH0zDLPDYUylGGrA3FtxxNyJvwB4h5
         SONUnhLyX9f+4/xDIllIRIXSJmf1IQ3s064NvjdC9ocRwleK4XkidhA9iSQrLdbWPtOB
         jePg==
X-Gm-Message-State: AFuF++non4Q1r6ary8Opt3TfZZfIaijI77p97c45IcDOatdsXz4WSOw9
	tOtHAlPMg6V3eTQb4FGTK1ShRhRbjbQMrEHs+HzRb274yeHmf5UgvJ3g
X-Gm-Gg: AYBFou0f/uUVqz94p5sr4RITXwF4IU/XgA2KiLwU4ku9zOykqMsN36KDVvTmpfHBzr5
	kMERWweZrobIRjjndIv82qFvlecthHHl4gaDRTx8L6TW5/k5tc+EzrZmgixoWv2MJIvGCLfz0BP
	j9eC7W9Aci7qjZF3fSyVgZxlZm/lDUydA68cMkYTC7MdPUwQ/OoXnzJ1Ij4pv6f3i5atCPL8cEl
	dRWCBsZjyQvpnxyL46kYX0xTV0dCQWq/r9f6eYgTx3L6EQ4rPIF5zq7yhIqtFHRrhn/b1xuFoCt
	rOE03HdhQnY1eOt4A5PnMZa7OzTuReVV/OMTK7TUtjYnn4FGwQC21dKbedeivo7fogq3wdemzfS
	4ipaQ/0yaXGgM93IHGwAGYg2Gd6aD+2A/Mw3X1ynPnb7b2U2a0Tbo8hP4bNfqT0UoRfMnF8jGyX
	d+BBsr1BRRoyE9oAeBgwFQGMWiCcygXrcQ/sdoKeHMY9p+oLVjP96i0jVMUs5NRsicIJhIvOysU
	RnGer/fFqJeL6rilR4fPOA=
X-Received: by 2002:a17:90a:4cc3:b0:39e:6c68:fd96 with SMTP id 98e67ed59e1d1-39e6c68ff4fmr319964a91.43.1789754942643;
        Fri, 18 Sep 2026 11:09:02 -0700 (PDT)
Received: from localhost ([124.79.30.231])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e55ff3a2csm1753898a91.1.2026.09.18.11.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 11:09:02 -0700 (PDT)
From: Leno Hou <lenohou@gmail.com>
Date: Sat, 19 Sep 2026 02:08:48 +0800
Subject: [PATCH 6.1.y 1/2] mm/vmscan: wake up flushers conditionally to
 avoid cgroup OOM
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260919-linux-6-1-y-v1-1-577b5191263c@gmail.com>
References: <20260919-linux-6-1-y-v1-0-577b5191263c@gmail.com>
In-Reply-To: <20260919-linux-6-1-y-v1-0-577b5191263c@gmail.com>
To: stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
 Yu Zhao <yuzhao@google.com>, Steven Barrett <steven@liquorix.net>, 
 Oleksandr Natalenko <oleksandr@natalenko.name>, 
 Suleiman Souhlal <suleiman@google.com>
Cc: Brian Geffon <bgeffon@google.com>, Leno Hou <lenohou@gmail.com>, 
 Wei Xu <weixugc@google.com>, Zeng Jingxiang <linuszeng@tencent.com>, 
 Kairui Song <kasong@tencent.com>, Chris Li <chrisl@kernel.org>, 
 "T.J. Mercier" <tjmercier@google.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789754932; l=5740;
 i=lenohou@gmail.com; s=20260311; h=from:subject:message-id;
 bh=LR4JEdw2wPTCUDDNs92OFOmz3Z/nYs/LyYeJDcSo02A=;
 b=/UAWFII2dEAY8cYm9uCOnrwudZl145XKbF2saRKSLhR17zhbsXzEufpRB37N8yWcVpqu0z+0n
 ikfz+NxoquAA8vklP5MMC64xRC958YVoJcGMWVzaMSu3nvu/BVL5Csz
X-Developer-Key: i=lenohou@gmail.com; a=ed25519;
 pk=8AVHXYurzu1kOGjk9rwvxovwSCynBkv2QAcOvSIe1rw=

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
index 1f7a90ecc700..03fbe8b2035b 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4741,6 +4741,7 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
 		       int tier_idx)
 {
 	bool success;
+	bool dirty, writeback;
 	int gen = folio_lru_gen(folio);
 	int type = folio_is_file_lru(folio);
 	int zone = folio_zonenum(folio);
@@ -4796,9 +4797,17 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
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
@@ -4914,6 +4923,8 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
 	__count_memcg_events(memcg, PGREFILL, sorted);
 	__count_vm_events(PGSCAN_ANON + type, isolated);
 
+	if (type == LRU_GEN_FILE)
+		sc->nr.file_taken += isolated;
 	/*
 	 * There might not be eligible pages due to reclaim_idx, may_unmap and
 	 * may_writepage. Check the remaining to prevent livelock if it's not
@@ -5044,6 +5055,7 @@ static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swap
 		return scanned;
 retry:
 	reclaimed = shrink_folio_list(&list, pgdat, sc, &stat, false);
+	sc->nr.unqueued_dirty += stat.nr_unqueued_dirty;
 	sc->nr_reclaimed += reclaimed;
 
 	list_for_each_entry_safe_reverse(folio, next, &list, lru) {
@@ -5239,6 +5251,13 @@ static void lru_gen_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc
 
 		cond_resched();
 	}
+	/*
+	 *  If too many file cache in the coldest generation can't be evicted
+	 *  due to being dirty, wake up the flusher.
+	 */
+	if (sc->nr.unqueued_dirty && sc->nr.unqueued_dirty == sc->nr.file_taken)
+		wakeup_flusher_threads(WB_REASON_VMSCAN);
+
 
 	/* see the comment in lru_gen_age_node() */
 	if (sc->nr_reclaimed - reclaimed >= MIN_LRU_BATCH && !need_aging)

-- 
2.55.0


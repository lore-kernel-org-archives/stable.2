Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793029774;
	b=3s95YPaluEkeSgYYBJgyF8qa71fzN0DF9iXtKamx3BZAZBzkBDlFUK/93BhoEoHpAdSG
	 rlDXr0IMAC97HVwFfVoZzFqCdVr7nCHoCgT8KtcDNRItWUwhS0BdRgVfw7qrZeqqE3K+r
	 Y0zGtYjGno2DkVBj2JLQ6SCmSQWh/w5hN5TkCqyGHiCWNibib+n54PpdiUS2FSKHcVPbt
	 kcQptUl7N3jWJcUdSUWo3PNgTk3LTiEgNuTLGih8mStOfJ4s5SE3/UaYFO4mm5tO26Vie
	 7G/dszln5P7pRrh65J5N0y8S/yKqwH53w1c2w+PWm//nFKAdQzpiF8f88XOWzhydaFA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793029774;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=P9Y6ArcLY3chgAZaw9C1sD+TjXYhG8OFFYFP+hYQc+c=;
	b=lbqQP7b32KdN+wxd77fxjQQEgUScvMkvLnYEJ6mPRYPyJJD7z/VoWdguj/uTqUD9M+AQ
	 JqHmdfWbV7Sy7+fnKaLBtznXj5A7OSEIj0GwzmK/lQkAO9egabvTjs5Yb0gPgFkXR7gtt
	 nzKDu/OoNPhEChC2okyxrHxvaQ8fEWcAiTaPIwuf9MjdS19+LpHyM85k5kIf+tS8z7N9A
	 Mg8ILJDFQK9LRaV6wJWhLjXDiUgDpPdRTX2qdrlHUjPyp+iWE1H7rUexNsMRmccRa8eQ8
	 dCejiZCY/T6Iqp1JHrIV08EGVgFZkFS6JE/fUqkXxY/K0OdG/AWbl3u/rq8L8hCE2zA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a7rfBAC3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E699606A31A
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 15:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a7rfBAC3
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793029773;
	b=PF/6ZewfmSHltmclaKZMiYqknPsStISNFI/Mtn2B6670hvyS7fPxyRJR2YeJKihLzJPY
	 UOZCph8cUlWgcNuAlAe49IuXqO1htWhADEJxAQciE+mdelliEXrb/PuNxQB2K5vMnY+kQ
	 zmweQbVcE6ou8ASHyKIgn2kfRYKTDVq3k27vX+BMVlrV94JbTftvX5coNgqbi3eGS+V3f
	 gQAkKY5whOzD3tqoRt2jV/PtP37lKVBWI5YT2M0EaDE/I1pLScz1eKYNMClRqylhKyDFP
	 t3rL7qr86Y+KObI1ur4A3zojn775l9CUaJ2qDoPvoCraTGCZP/4fWSlxVTwaq9LumKQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793029773;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=P9Y6ArcLY3chgAZaw9C1sD+TjXYhG8OFFYFP+hYQc+c=;
	b=tWePtv3JnRtUKoRuKuEMkIR9xvAMQRMR4iPoK0m0LL/QQczFaCrJzZgq505CeRvQE/bx
	 YmGu+wiWeiqoO9JyIRwzij6YBBNLTrPGKOBrx0QSEhA0Rtd3Jb999WpP9yMvMCFcPzrwn
	 ME/204We4KbV6L+XzPLSA/86DZBYy+j/yitadvEhtHIzaOndGSlmzzL0fgMy6rnvdW2ku
	 H6MLMZYDjT2el21xEHaBPpYjIXFdKTcZp454aPFZt9s1IuxtjifY9/SwD6H0CyYqP60OH
	 3FZzKmVVmj31n1FsIcfiYDcD1jmnyBpYbyb2vKjKeMaELTZG6Pleq4j0c8q8u21bIOQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E85941F01829;
	Mon, 26 Oct 2026 15:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793029773;
	bh=P9Y6ArcLY3chgAZaw9C1sD+TjXYhG8OFFYFP+hYQc+c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=a7rfBAC35HbMQJ8M25MSXLvxNQlR6Z5C/qLENRn16Jzbvpkd+RZt1OctJmbxMUJCO
	 k1P6IrGudxh5EOGLHLY0dDN+NCT8V+ihSaIU7ZmmuN7PNe/OjtBuOKZuX+xl071fhY
	 NrBbHG7HrAB2cKjX/JGx2Kxn07zC5CtRdP0/6y8FeBYd/1cWevnNaxTn2snhDtBGoE
	 cpocmb5Flyv0EZZzrjVuA9k4OO1qmyDyPUifXyknse4yCoVecX6becTpDi6EoI+vMj
	 CQBswBeBHXTXcPk03Y4tBgihCwzI8cNjJBtvrUr+FXvjgMRocnrh3TUePNvhzCF3O/
	 yWP7BZ/qxCXpw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 79BB344D73;
	Mon, 26 Oct 2026 15:49:32 +0000 (UTC)
From: Leno Hou via B4 Relay <devnull+lenohou.gmail.com@kernel.org>
Date: Sat, 24 Oct 2026 13:38:45 +0800
Subject: [PATCH PATCH 6.1 v2 2/2] mm: vmscan: fix dirty folios throttling
 on cgroup v1 for MGLRU
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
Message-Id: <20261024-linux-6-1-y-v2-2-92958fc61228@gmail.com>
References: <20261024-linux-6-1-y-v2-0-92958fc61228@gmail.com>
In-Reply-To: <20261024-linux-6-1-y-v2-0-92958fc61228@gmail.com>
To: stable@vger.kernel.org
Cc: Leno Hou <lenohou@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>, 
 Kairui Song <kasong@tencent.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Axel Rasmussen <axelrasmussen@google.com>, 
 David Hildenbrand <david@kernel.org>, 
 "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>, 
 Michal Hocko <mhocko@kernel.org>, Qi Zheng <zhengqi.arch@bytedance.com>, 
 Wei Xu <weixugc@google.com>, Yuanchu Xie <yuanchu@google.com>, 
 Andrew Morton <akpm@linux-foundation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792820328; l=3224;
 i=lenohou@gmail.com; s=20260311; h=from:subject:message-id;
 bh=D2gFt3Bs+PV7C5qZxnAC9J6trppD5tGWe+3gmfZI3lg=;
 b=6hcf1ymN7N6QeHeSb9EYqcBgWADUfu+WpU5YEekYDp4QKLhMkSLxJVIUc2UToATN+yaSNASyY
 vKUE+3wPY2/DIW2HBN0ft2ZfMmZUAfQoUxPmYvehp1p/A88a1c2xZpM
X-Developer-Key: i=lenohou@gmail.com; a=ed25519;
 pk=8AVHXYurzu1kOGjk9rwvxovwSCynBkv2QAcOvSIe1rw=
X-Endpoint-Received: by B4 Relay for lenohou@gmail.com/20260311 with
 auth_id=674
X-Original-From: Leno Hou <lenohou@gmail.com>
Reply-To: lenohou@gmail.com
Content-Transfer-Encoding: 7bit

From: Leno Hou <lenohou@gmail.com>

[ Upstream commit 13b6b620910436c29dea398382e83c9499fd13e4 ]

The balance_dirty_pages() won't do the dirty folios throttling on
cgroupv1.  See commit 9badce000e2c ("cgroup, writeback: don't enable
cgroup writeback on traditional hierarchies").

Moreover, after commit 6b0dfabb3555 ("fs: Remove aops->writepage"), we no
longer attempt to write back filesystem folios through reclaim.

On large memory systems, the flusher may not be able to write back quickly
enough.  Consequently, MGLRU will encounter many folios that are already
under writeback.  Since we cannot reclaim these dirty folios, the system
may run out of memory and trigger the OOM killer.

Hence, for cgroup v1, let's throttle reclaim after waking up the flusher,
which is similar to commit 81a70c21d917 ("mm/cgroup/reclaim: fix dirty
pages throttling on cgroup v1"), to avoid unnecessary OOM.

The following test program can easily reproduce the OOM issue.  With this
patch applied, the test passes successfully.

$mkdir /sys/fs/cgroup/memory/test
$echo 256M > /sys/fs/cgroup/memory/test/memory.limit_in_bytes
$echo $$ > /sys/fs/cgroup/memory/test/cgroup.procs
$dd if=/dev/zero of=/mnt/data.bin bs=1M count=800

Link: https://lore.kernel.org/3445af0f09e8ca945492e052e82594f8c4f2e2f6.1774606060.git.baolin.wang@linux.alibaba.com
Fixes: ac35a4902374 ("mm: multi-gen LRU: minimal implementation")
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Barry Song <baohua@kernel.org>
Reviewed-by: Kairui Song <kasong@tencent.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Axel Rasmussen <axelrasmussen@google.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: Wei Xu <weixugc@google.com>
Cc: Yuanchu Xie <yuanchu@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Leno Hou <lenohou@gmail.com>
---
 mm/vmscan.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index f58651d45540..468207509840 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -5267,8 +5267,22 @@ static void lru_gen_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc
 	 *  If too many file cache in the coldest generation can't be evicted
 	 *  due to being dirty, wake up the flusher.
 	 */
-	if (sc->nr.unqueued_dirty && sc->nr.unqueued_dirty == sc->nr.file_taken)
+	if (sc->nr.unqueued_dirty && sc->nr.unqueued_dirty == sc->nr.file_taken) {
+		struct pglist_data *pgdat = lruvec_pgdat(lruvec);
+
 		wakeup_flusher_threads(WB_REASON_VMSCAN);
+		/*
+		 * For cgroupv1 dirty throttling is achieved by waking up
+		 * the kernel flusher here and later waiting on folios
+		 * which are in writeback to finish (see shrink_folio_list()).
+		 *
+		 * Flusher may not be able to issue writeback quickly
+		 * enough for cgroupv1 writeback throttling to work
+		 * on a large system.
+		 */
+		if (!writeback_throttling_sane(sc))
+			reclaim_throttle(pgdat, VMSCAN_THROTTLE_WRITEBACK);
+	}
 
 	clear_mm_walk();
 

-- 
2.55.0



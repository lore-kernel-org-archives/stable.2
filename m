Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793029590;
	b=pDpfuArWIfvAwIM67XKPc/W2JUfIMo/sSP8x94WpRUhgWv8baoD1Dsjx0QlVeOWKklmE
	 Tq2IjdVMNHNdtF1au4f8BM3qNXyuVfrD1sXXfVvCZK6+ZVDJvVUav1LI0Y9FQMir21c15
	 hwb/mZvBccJU3Q8Z6mcNDdT/5Vz9JWSQNaf0OK4KitbY8tzrh8tYB/r8hLv+eW/7/sjTV
	 1t5EZ8SmfOsBLjxDSYkJ2Do/D9TIO2MJA3UkxHX55B98+nslnh6UVfkq/N7mThI38Fx2K
	 Q1r132exYLpHd/V1K/S8CvUVhoBzqIjA459d94NUMyfQhH7mHmSLvr13JAp/ueD8K8A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793029590;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ypy55PQIRY/Gie/kAEltN807fD7sUXsm8MivRuhOtp0=;
	b=ZoD5zP9VK2h36Tlq7aDue+qH4uPnj3Lo4XhDDgYSx2Ki0jX1FIJi79jYXVq6oV6FCoN8
	 Vr7NdbNIC+FLAl+DTa13Qa93F6awT7OEbmgV3Qy/2YeLHH/AuhcPboJYY9adcnPiuwVrx
	 hR8N1COXMrA63f89DUtiHeoC81z44DNdNHcrHrtHgtZMzX+3jIzswbMs8mwmD/HHQj4Tn
	 smuG8JNV+hKfGGuscLaeQtyr0wX9cYuV6X8Hqx0yzi7J4kA6gyqS2vm3g0nVGbt/v/FG4
	 DZ39mgBqgFalA54/NPVO84kGiKYuyAz6V6C5ASwg9T7jE0z+LXtgzBOEY/4GzsqSbEQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TxkyZSMw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66456606A321
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 15:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TxkyZSMw
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793029590;
	b=bHWDoVTyot6lav2YnPBuJqiGioEnFWEtz2xnJM4Ohrv7qn6ZwXz/OMMWMU2fDExJu+a/
	 FZN8AkDw95KpsX0Tvv9rmu7sldPoNG9Gzwp5zL4iB/H0lNXM9tS40AvuUFhKBP4jLjWMB
	 IvRnC7PZbxg/HYNYQWl4tNVI97Uhg1qzNq6zqI67Xcbn8N0bxodiFDT0rU+cnfMXMf04/
	 +JFd0NnI115lDp+tUy2zSR6+v4Mu+D0cNofGG1Lv2+fljvX7IBCueCNtwEA/MfMzghU33
	 I1OqdaxLmYBlq0YxQETKqTDQSMJqtMf7zRYDHdGzgtyCYaW2JJViqlw8AFXQkXh5j5A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793029590;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ypy55PQIRY/Gie/kAEltN807fD7sUXsm8MivRuhOtp0=;
	b=pnpLceg9osSJy1i20ijmJs242xomQMYpk/tlyxaCFeU2UVD5+Zj3SVgIdaMEYYldH4VC
	 CEBVzWQ0i3rzvrNhDVmO/YDOa/eiFUs99Iu7yAhVsk3ynIeq/STuW0rlBhA5hJlfkpAuq
	 u7nmdK2nMNRxaVnmx56zVE9eSsokvqW5gDDTMkWHZQ7wpz3bBzd1UCpEK6Mv/6GlKWq97
	 FDRARQoUO+GvBimlDo8YSVq9ddd9XysvPlHDdzy/2EVoJd/EcwfupWG248w5ITM/UF3w3
	 HUSFD04z3LmGxFOhuPxBOABt7OwvOGngh6rsQNRdKDqk05xMsFZLkQ2ZtSJ2Vft3gfQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 100991F031E4;
	Mon, 26 Oct 2026 15:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793029590;
	bh=ypy55PQIRY/Gie/kAEltN807fD7sUXsm8MivRuhOtp0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=TxkyZSMwP+xTp3M0/BTClMBB2EMsh57X1al07sxuUgxyckLMsZaCFfvI6SSKFtUOb
	 X1g34FbfT4cDUsxBQLF0YAuq5dfbKnvHFGM0T2LBUwcfeNCXtHGel//2wN6fFhiMnv
	 VeSOXVgYS32NDUiez5/KV4SzUgbyA125z/peen2d8PskXoZcT8rwUkpmCcHZvwiKHi
	 GRwUuvybsJuoM/KICV4ZEAAstwApQRyCejdnMhw86Pdd7b9d/ejeMU6voO2lFFuGIW
	 b8L+diseAEPlsCuNFKREZg07p5ZHHYNc1A9wAx/9V49alwr5nGXhJSpOqR9lozz7B4
	 O1T/VhJVnoAbw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 80D1144D61;
	Mon, 26 Oct 2026 15:46:28 +0000 (UTC)
From: Leno Hou via B4 Relay <devnull+lenohou.gmail.com@kernel.org>
Date: Sat, 24 Oct 2026 13:35:04 +0800
Subject: [PATCH PATCH 6.12 2/2] mm: vmscan: fix dirty folios throttling on
 cgroup v1 for MGLRU
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
Message-Id: <20261024-fix-mglru-v6-6-v2-v1-2-8c9b40f9fc24@gmail.com>
References: <20261024-fix-mglru-v6-6-v2-v1-0-8c9b40f9fc24@gmail.com>
In-Reply-To: <20261024-fix-mglru-v6-6-v2-v1-0-8c9b40f9fc24@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792820120; l=3276;
 i=lenohou@gmail.com; s=20260311; h=from:subject:message-id;
 bh=JnVRp/o3pn75fe9dOg9lgs8yva4bEL6E9tCoeF7HgKg=;
 b=Nx1C3LDTRC0lBwysYQHdw6QqeacDi+EolkMCy1P48+P2rKgJNUYORm4e7888i2pVBYUBx2NoP
 PVzhUyWz+mTCGkoMUqTEnDCqyg8PfKAYVZtC2VWnIH2v+83R60To2fZ
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
index a165f685216d..43b808e4e9f2 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -5431,8 +5431,22 @@ static bool try_to_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
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
 	/* whether this lruvec should be rotated */
 	return nr_to_scan < 0;
 }

-- 
2.55.0



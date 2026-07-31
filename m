Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E94377560
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 07:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785482356; cv=none; b=Zxq9OCby0irRP804PvXS2mMTvcAKlwCwVIoRhk4qZS3jCsppWkHTXKN37+P5fzCr0fde9FhKXQ87Xpm12qV6VzOirA2ODRxNFfRdY5vB911mF+Ho989ELa/rtAJgfnRy+VlCgGhrgBLTFWJfXfVGgLbMUssOL/STiNG6TOWyvpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785482356; c=relaxed/simple;
	bh=suVJwXj9J0WrH/TJSUVVbfERwKD0n1Mtu8Q4/JAWNbE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ALB57F9DFxZzmbvZZzaDW+ANGuBiLB0Jze9TbOX4117cRaS9a/HVUMxzGZmmlo9jH0EikTI74LOqN23NPwEiYneLOZ8x+R+/2W0hWeUEp4UChTXT19jU0OCMTxdQ4iTlvw5y6MCVnyaUqUW1SQUOWFTUXjxEDQhcqEsvJcXwSew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6fMc/1a; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6fMc/1a"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38deea72eebso725031a91.1
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 00:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785482354; x=1786087154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XTbbTCD4egv0utHJvm00B5iv3aXVh0vE7Y+3UdThKEs=;
        b=E6fMc/1akWHPGJnGCevUZDJyQJNAVGwa7nuiqZVBb/4+WD4kor/T0+a5Y44WzO050s
         5XetDO2j/4x7eccGG5O/+cMdkAIt2G5TINkNrluT9qI56HXUpnRiFDvku4Q4Z+ycpR7/
         eiVkc9EjotOE+J76oOF0jKkcwzSH6V5fR40hF8zYXFr2qo1KdrcLWFX2b/hHSN3eyT4b
         VFiNoROF6P3VLYrJ5vF9phfef8iuemAirFQwRB2ax/E90AT6N25EXbOOFM/p46hha458
         fnA4daztsMRJnlVM3cG/4zVFIe8F/+BZezFBLZFzzgy7W/uktkdlhB6rT+cFdbwJuUTv
         NaQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785482354; x=1786087154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XTbbTCD4egv0utHJvm00B5iv3aXVh0vE7Y+3UdThKEs=;
        b=IFcgW5yVCvUsdbwblrKkeo97ib/xdwE+BVOCyakv4WCU9+gN9S4iCb8NKl/wbN1Oof
         nvLqCXWRLbzIFoMz/eeOVW1V9KiCRRETz+b7yG72nCAVw5BGFEBsb5X9LHHlIlcsA9ef
         rxN39RyfrWD6gO6WmjfGMaAyvxpWxyO34THWcILOxJHwJEp5ZScjiIgiQaHsnQo9obEf
         czrq0U6pquxhFGdq1KwmN4GwIBMeDpivF3GHsy6vLpS8JtV+YHuiFqsXFT4NCHEXM+0/
         5WuKwZfBWiz4lvtFa4+azFuk+ExWQKFdxlcrgxq0xUqig1WuoZ+RSxnWiPEGJ+Wj3m1y
         FPqQ==
X-Forwarded-Encrypted: i=1; AHgh+RqVq6HZ5mvkMRePse6uV8tJpwL18AuVs0qZDKMEQRGUJs7U+Yzz2DEFBD0AGGMZ/0Uc8Cmlu8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZXBjTTPUksjYa49yAgZWo0my9TwWXkfb6WX3ivSZ9QAV2zic5
	DWFr4khrWR4IgMHg7vP1PcT209v229CnQgbXI18i0rQEAwIBsWfsZLwZ
X-Gm-Gg: AR+sD13YCtRc6/eEt85x3JhWOfiMhgtSAayl5IYwQgxfzZcjzl2Eb4JrHjcBxYjRUS6
	fCWmpQGBe3PVCO0nTBR2aGP4HCnndfSxNHNB41YaugRNjMOFDrApcWQ97sAZ5tAM/zTT4oY8Msi
	wbyuG8u+YTk709M9Uz7PtDVPo69idCzIiPDB8gSGhjjH32vP+acxPWIL0Fo9USBSQEhwN1GoWOX
	FeLMfRPe4MpLjQJklLwESnnwXdgflp9vhxcFu+C2FEY29lf8end5UxPycg1HbTKBU6r2MtI/cBn
	JhMAGagQQXRpvgJEyYm1jehZtw9xNMXy3jqz/hj8KK/gRQHXJZp6nmjgqmcvG6iZB+O8uZkhOrU
	PSmQ6gTgIqM5uhXLjTzDZ0Gf7TsrsW+wWBTYW5Z8MAOt4n+9SoU+Ft5KQegU5HmZJn2DZVIg9CI
	TJkEVfRizQAAZi5KMit7NlxVcR5wAJAjbLdtlvkm3cxp44fqTlUMOTVz+S12uMSUCujY49VTQWT
	bVKt4RmYIItq5EG
X-Received: by 2002:a17:90b:1c81:b0:38e:2517:5d1f with SMTP id 98e67ed59e1d1-38fb114f74bmr924299a91.9.1785482353580;
        Fri, 31 Jul 2026 00:19:13 -0700 (PDT)
Received: from localhost.localdomain ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb311994esm298909a91.17.2026.07.31.00.19.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 31 Jul 2026 00:19:13 -0700 (PDT)
From: Hao Jia <jiahao.kernel@gmail.com>
To: hannes@cmpxchg.org
Cc: akpm@linux-foundation.org,
	chengming.zhou@linux.dev,
	jiahao.kernel@gmail.com,
	jiahao1@lixiang.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mhocko@kernel.org,
	mkoutny@suse.com,
	muchun.song@linux.dev,
	nphamcs@gmail.com,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	stable@vger.kernel.org,
	tj@kernel.org,
	yosry@kernel.org
Subject: [PATCH v3 2/2] mm/zswap: Support batch writeback in shrink_memcg()
Date: Fri, 31 Jul 2026 15:19:00 +0800
Message-Id: <20260731071900.38942-1-jiahao.kernel@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <amufiuAaZbuDdKkQ@cmpxchg.org>
References: <amufiuAaZbuDdKkQ@cmpxchg.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hao Jia <jiahao1@lixiang.com>

Currently, shrink_memcg() writes back at most one entry per-node during
its traversal. This makes shrink_worker() inefficient, as it must
repeatedly re-enter shrink_memcg() to make any substantial progress.
Under high memory pressure, this can cause the writeback speed to be
too slow to keep up with refaults, leading to zswap store failures and
forcing pages to skip zswap and go directly to disk, which results in
an LRU inversion.

To address this, extend shrink_memcg() and rewrite its LRU iteration logic,
enabling batch writeback for both the shrink_worker() and zswap_store() paths.
To prevent shrink unfairness across NUMA nodes caused by a shared global scan
quota, limit scanning to up to SWAP_CLUSTER_MAX pages per node and write back
any reclaimable entries found.

Test Setup:
- Total memory: 32 GB, 1 NUMA node.
- zswap settings: accept_threshold_percent=50, shrinker_enabled=N.

Test Case 1:
Set max_pool_percent=1, allocate 512MB of anonymous pages, and fill them
with random data (to avoid compression). Then, use cgroup memory.reclaim
to force a large amount of anonymous pages into zswap. At an interval of
2ms, allocate a 4K anonymous page where the first 4 bytes are random numbers
and the rest are zeros, and then trigger reclamation of this 4K page through
cgroup memory.reclaim. When the pool threshold is reached, shrink_memcg()
will be triggered.
The test data after running for 120s is as follows:
                                Baseline      Patched
shrink_worker wakeups              5,363          169
shrink_memcg calls            11,373,201      350,703
written_back pages                40,212       40,241
zswap_store calls                161,190      163,753
   store succeeded (ret=1)       102,743      117,183
   store rejected (ret=0)         58,447       46,570
   store reject rate                ~36%        ~28%
pool_limit_hit delta              55,826       33,760
pswpout                           98,659       86,811
pswpin                                 2            0

Test Case 2:
We evaluated the following two sub-configurations using stress-ng inside
a cgroup capped at memory.max=1G for 120 seconds:
  Test Case 2a (max_pool_percent=1): Continuously triggers the global
  zswap pool limit, thereby waking up shrink_worker() to perform asynchronous
  shrinking.
  Test Case 2b (zswap.max=320M, max_pool_percent=50): Continuously triggers
  the cgroup's zswap.max limit, thereby invoking synchronous shrinking.
Command executed for both setups:
   bash -c 'echo $$ > /sys/fs/cgroup/zswaptest/cgroup.procs ; \
   exec stress-ng --vm 4 --vm-bytes 4G --vm-keep --vm-method rand-set -t \
120s -q'

Test Case 2a (max_pool_percent=1):
                                Baseline       Patched
shrink_worker wakeups              5,640         1,308
shrink_memcg calls             8,481,500     3,140,972
written_back pages                   260       468,216
zswap_store calls              2,742,756     2,011,269
   store succeeded (ret=1)       934,640       947,988
   store rejected (ret=0)      1,808,116     1,063,281
   store reject rate                ~66%          ~52%
pool_limit_hit delta           1,181,310       196,882
pswpout                        1,808,376     1,531,497
pswpin                         4,288,497     3,635,365
Test Case 2b (zswap.max=320M, max_pool_percent=50):
                                Baseline       Patched
shrink_worker wakeups                 0              0
shrink_memcg calls              687,608         54,002
written_back pages              639,176        846,663
zswap_store calls             1,224,222      1,228,548
   store succeeded (ret=1)      992,816      1,208,123
   store rejected (ret=0)       231,431         20,425
   store reject rate               ~19%            ~2%
pool_limit_hit delta                  0              0
pswpout                         870,745        867,360
pswpin                        1,707,823      1,216,814

Under identical workloads and runtimes, batched zswap shrinking
exhibits a significant reduction in both shrink_worker() wakeups
and shrink_memcg() calls. Furthermore, the sharp drop in both pswpin
and zswap_store() rejections demonstrates that batching zswap shrink
operations effectively mitigates zswap_store() failures caused by
hitting the pool limit. This significantly prevents pages from bypassing
zswap and falling back directly to disk, thereby reducing LRU inversion.

Suggested-by: Yosry Ahmed <yosry@kernel.org>
Acked-by: Yosry Ahmed <yosry@kernel.org>
Acked-by: Nhat Pham <nphamcs@gmail.com>
Signed-off-by: Hao Jia <jiahao1@lixiang.com>
---
 mm/zswap.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 48fc7b575e24..d406c14925d8 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1275,6 +1275,21 @@ static struct shrinker *zswap_alloc_shrinker(void)
 	return shrinker;
 }
 
+/*
+ * Scan up to SWAP_CLUSTER_MAX pages on each per-node zswap LRU of @memcg
+ * and write back the reclaimable ones.
+ *
+ * Since the second-chance algorithm rotates referenced entries to the
+ * LRU tail, the per-node scan is capped at the current LRU length so
+ * each entry is scanned at most once per call. It is up to the caller
+ * to handle retries, deciding whether to scan another memcg to complete
+ * the full iteration, or to rescan the current memcg to drain its zswap
+ * entries.
+ *
+ * Return: 0 if at least one entry was written back, -EAGAIN if entries
+ * were scanned but none could be written back, or -ENOENT if @memcg has
+ * writeback disabled, is a zombie cgroup, or has empty zswap LRUs.
+ */
 static int shrink_memcg(struct mem_cgroup *memcg)
 {
 	int nid, shrunk = 0, scanned = 0;
@@ -1290,13 +1305,24 @@ static int shrink_memcg(struct mem_cgroup *memcg)
 		return -ENOENT;
 
 	for_each_node_state(nid, N_NORMAL_MEMORY) {
-		unsigned long nr_to_walk = 1;
+		unsigned long nr_to_walk, node_budget;
+
+		/*
+		 * Cap the scan at the per-node LRU length so each entry is
+		 * scanned at most once per call.
+		 */
+		node_budget = min(SWAP_CLUSTER_MAX,
+			     list_lru_count_one(&zswap_list_lru, nid, memcg));
+		if (!node_budget)
+			continue;
 
+		nr_to_walk = node_budget;
 		shrunk += list_lru_walk_one(&zswap_list_lru, nid, memcg,
 					    &shrink_memcg_cb, NULL, &nr_to_walk);
-		scanned += 1 - nr_to_walk;
+		scanned += node_budget - nr_to_walk;
 	}
 
+	/* Nothing was scanned: every LRU under @memcg was empty. */
 	if (!scanned)
 		return -ENOENT;
 
-- 
2.34.1


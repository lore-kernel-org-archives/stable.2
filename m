Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD00F33F368
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 06:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791181381; cv=none; b=bi2DMrO3h0CNqP94l42VTQ1lbJj+IPRYgivOPnHyovizw4JVlUUNaWXf0j1T6P0jXmircbyIze3DajO0dSw0z3CisiYwviqc9SW1sInt2GxzunJwx/EjHgTkyU2BB3zUUsT1jCGY7gJI0iw+EkCkUzdHuIJZAH5ZndGNCdeftFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791181381; c=relaxed/simple;
	bh=B1rUO/u1yZK5lxU112EnHVMjQBFnPZUb8pDBsyHxQUE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZJot/igOsw9aga0h85j+Z9Ky1OjYQqUXE3AnWkQLnkO/Ulf4Ikyo6v/S57SBL6DEBo3CWQwMcFC/rFJqvsIngOQjdq8PBfUWhmArScu6CEjVaBVWHnNj8E5mNRXxbMjd5+ilMYECgRU3m1GSzmq3B8ro+GwOAe/n91lO7Ndk6Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ugb6AfYC; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ugb6AfYC"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3a7d7287703so741379a91.2
        for <stable@vger.kernel.org>; Sun, 04 Oct 2026 23:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791181379; x=1791786179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sK5flBSyUz9JPc2AauHO028it+gKWcI0pXP1AO189cA=;
        b=Ugb6AfYCAIY8EVoqgB4yHxYkebtOWSa9/Ivo1IL/voScXitIbGIvXQa7IZC1+ILh+b
         1kCuQrYTA7k3i8x9LbZrdwSsga6LT+YoI73IY+FUrDVFDoYWGQvzFDd8q/PKC4C2KXc+
         x7Sxa9LeDB4P38/+I9UGngt6XQy+sH+J5pTmRcjjzbEpx27W6g1relUALrhLl7S9SRev
         vaaJ6mJbpwYB0OXOk06s2fSbkfLUosXzlZvRFJuJCYVBqC7mOUf1nQdNM4rmjwjQps1t
         Az9k7Mc2r/PeiEdnPJaXAhDOHNq8/2JC+6rpTBzA6iaNC+8zSq/q+sXCp6z7IwK5gnR7
         /EYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791181379; x=1791786179;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sK5flBSyUz9JPc2AauHO028it+gKWcI0pXP1AO189cA=;
        b=2SGWt8cz9yHNSOa7SnTibGe/GdPkCfYnJHkzVp48IJCQPpJIzfu4c5+nzQKKVlMkeu
         T5hvCz6slQH6AdMhofv+DOfy4MD7QxkETg1Lce+m6zAoW+odjagnhU0HLi2C3neWPeKH
         QhZz3jYXcgipoiY2O54B8MBXvvGJAHKD5T/FIFW42MyS+w+yfGfa1FlyUrMt8mIbJVe2
         ixI6aLpXP3rubl4d3s8NNXn1Tj7VlTbMCqTxUqdOvg4/P7GhVqjaLoN337kEd6vlFTGS
         KfgZ9dj8qPnTScqWu3AhA03ph4KrykynwEJEZvEEpa54zpphQ8J9/xFLKp+l1axAB4/5
         c9oA==
X-Forwarded-Encrypted: i=1; AKwUvBzJAZVhElsSY3tOJHm6t25Euk5RNWbDimxv1R5+o0L/87DOr9pPxEkHk+Ym3Fs58mI9FYD5ucM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ2xbLGO+L4WUB6MEGxIYy5tplc/KYaTBKLndNZVkPPDfHqOs0S
	968tnoG3PIJ2CfzmfRVXVUkTkF1qGyMrfyVGUvMuTB+Q+V86f2WWw9H5
X-Gm-Gg: AYBFou1Ey7VkgaHyym9QJaXvQVx9QdlDmnpFpmmHq1RJ1VsrVOPRLGqrlO7wzAJiEa6
	qke5gEFmAl4qOAqKWiXHdrBRdpfo+Z6oiZx8Jfs83JdBIpONgcoL6A75r4EXCm+ffF9YsWEIzlE
	wc+RteTJr27SHVjBXkHSpEd17Fwel8yOUwpoCG4a/vUyMX8IFIgggRi/g50xxcZyN77j+Ns8QG7
	G0q6wp72nAhDlrupMc5Mpt/Wr8DspbVOoWBNyH8UTvCDOFT54ak/0CurB/cqMmJxLtMKq+a+A56
	Auh/mL2FT4+IODYi9s2r9gWlk5SQ4MgxjYZqnAfsAptXq5jj1vU+TFToKaCEI9B+akHl7/DmoDq
	V84cRBTzUknwA1Uja2ra0pSVFKq6ke6BZlfAbvs44u/TakSJh1a9GwezcEN/TLJxE6j3F/rIasD
	Z9XGliD565YplzoirsCqXe5B/FPE2L/XtmbaL26A12i+V23xsuJe02EdFzZE2Id2A5FBRkmDv2B
	KFbzKnHLw28XA==
X-Received: by 2002:a17:90b:2f0e:b0:3a8:1cc6:c8e0 with SMTP id 98e67ed59e1d1-3a81cc6c99amr788163a91.6.1791181379004;
        Sun, 04 Oct 2026 23:22:59 -0700 (PDT)
Received: from localhost.localdomain ([240e:b8f:1df9:a600:c693:b19f:ada0:748])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a78e4a1bfesm10661197a91.12.2026.10.04.23.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 23:22:58 -0700 (PDT)
From: Vernon Yang <vernon2gm@gmail.com>
To: akpm@linux-foundation.org,
	david@kernel.org,
	kasong@tencent.com,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	baoquan.he@linux.dev,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	ljs@kernel.org,
	roman.gushchin@linux.dev,
	dave@stgolabs.net
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Vernon Yang <yanglincheng@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] mm: vmscan: don't count per-node proactive reclaim as memory pressure
Date: Mon,  5 Oct 2026 14:22:36 +0800
Message-ID: <20261005062236.564210-1-vernon2gm@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vernon Yang <yanglincheng@kylinos.cn>

When the cgroup has no memory pressure at all, writing to
/sys/devices/system/nodeX/reclaim triggers proactive reclaim on
NUMA node, causing increase in the writer cgroup's memory PSI.

Due to this reclaim is performed in the context of the write(),
accounted as memory pressure on the writer, like
commit e22c6ed90aa9 ("mm: memcontrol: don't count limit-setting reclaim
as memory pressure"). This is unexpected, the phenomenon resembling
senpai will appear again.

The Documentation/ABI/stable/sysfs-devices-node documentation also
notes that "This interface is equivalent to the memcg variant."

This patch unifies the semantics of the memcg and node interfaces:
per-node proactive reclaim is no longer counted as memory pressure,
and the per-node proactive reclaim interface no longer produces
phantom pressure.

I ran demo[1] that performs per-node proactive reclaim 10000 times
in qemu, writer cgroup memory.pressure as follows:

without patch:

some avg10=31.53 avg60=13.42 avg300=3.31 total=10602985
full avg10=31.53 avg60=13.42 avg300=3.31 total=10602985

with patch:

some avg10=9.59 avg60=3.41 avg300=0.81 total=2686221
full avg10=9.59 avg60=3.41 avg300=0.81 total=2686221

[1] https://github.com/vernon2gh/app_and_module/tree/main/reclaim_node_psi

Fixes: b980077899ea ("mm: introduce per-node proactive reclaim interface")
Cc: stable@vger.kernel.org
Signed-off-by: Vernon Yang <yanglincheng@kylinos.cn>
---
 mm/vmscan.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 91295070ca33..8e22b8a6038b 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -7988,13 +7988,10 @@ static unsigned long __node_reclaim(struct pglist_data *pgdat,
 {
 	struct task_struct *p = current;
 	unsigned int noreclaim_flag;
-	unsigned long pflags;
 
 	trace_mm_vmscan_node_reclaim_begin(pgdat->node_id, sc->order,
 					   sc->gfp_mask);
 
-	cond_resched();
-	psi_memstall_enter(&pflags);
 	delayacct_freepages_start();
 	fs_reclaim_acquire(sc->gfp_mask);
 	/*
@@ -8011,7 +8008,6 @@ static unsigned long __node_reclaim(struct pglist_data *pgdat,
 	memalloc_noreclaim_restore(noreclaim_flag);
 	fs_reclaim_release(sc->gfp_mask);
 	delayacct_freepages_end();
-	psi_memstall_leave(&pflags);
 
 	trace_mm_vmscan_node_reclaim_end(sc->nr_reclaimed, NULL);
 
@@ -8021,6 +8017,7 @@ static unsigned long __node_reclaim(struct pglist_data *pgdat,
 unsigned long node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned int order)
 {
 	unsigned long ret;
+	unsigned long pflags;
 	/* Minimum pages needed in order to stay on node */
 	const unsigned long nr_pages = 1 << order;
 	struct scan_control sc = {
@@ -8067,7 +8064,10 @@ unsigned long node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned i
 	if (test_and_set_bit_lock(PGDAT_RECLAIM_LOCKED, &pgdat->flags))
 		return 0;
 
+	cond_resched();
+	psi_memstall_enter(&pflags);
 	ret = __node_reclaim(pgdat, nr_pages, &sc);
+	psi_memstall_leave(&pflags);
 	clear_bit_unlock(PGDAT_RECLAIM_LOCKED, &pgdat->flags);
 
 	if (ret >= nr_pages)
@@ -8193,6 +8193,7 @@ int user_proactive_reclaim(char *buf,
 						  &pgdat->flags))
 				return -EBUSY;
 
+			cond_resched();
 			reclaimed = __node_reclaim(pgdat, batch_size, &sc);
 			clear_bit_unlock(PGDAT_RECLAIM_LOCKED, &pgdat->flags);
 		}
-- 
2.53.0


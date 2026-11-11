Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794407062;
	b=4eetX9Hfs0FX5FijLDErjzijuyYlTEqdz4dAyX8CiMucUIsf3E/DMi9VGYi/CEBP1sUi
	 tIBpHKiLcsRB7VWvLKPSwwto5VM0a0Wog039ZiyDYRsTjj1ff/zOgCil4BX3d1J15WoX/
	 0U1HSAWg4cVasXsRY59UFC9Qc0ZHaEOLFcxZEZAoHI7xui5lPk6Eo7zS9hJwef0GDnAtj
	 6ITjT8R0MSJEQD2bDXRCdPkvV/zd2fDHu+YK3lLZUHmF/GPR/Gg93f4BcirRxchkQdxbq
	 ycr0H2TK4FEvLBtp/0/hosg5389Fgn7BiEwKDPUbu1XssAvYpBXbNinzlxrvtTpjGuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794407062;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=DpRoKsjuAYlM4uMR7aDecpUr6tTt/J+CC9+sN7mYOWw=;
	b=MawJaz2Z/LahdvjHOK5B3eFQ6sFt3M7VrP8H3oHcYuOdYDfBSKQNnbIdr2YNwJIjd6h4
	 uhhJg1eOkkqeUGxtHQMUCKWLkJsKVrnGy5+Vvba9G1Fe61Kjpy3Z7Vp72v0cM8zND9yOe
	 2pFWHwqJxErXFoXNdqT/DwmRtQW3Y1Cwq6JItxhblLhgLMLbHrYD1CZMZeDWAF5pBuG49
	 /q/3HHaBNb7A/zfuw1F/o5m+X58jsliInOLiVQdNi9XOjrCwoaJfteKvF4X8YJ/Jn1xjp
	 3GKE8uj9id9F2/UzI9PoBCpHL/w1FDTlsVy3d+oe92eWrKY7poxhZIoHCwY+C9K6jGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="VNqU7vf/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2EF60A263A
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 14:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VNqU7vf/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 963B41F00A08;
	Wed, 11 Nov 2026 14:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794407062;
	bh=DpRoKsjuAYlM4uMR7aDecpUr6tTt/J+CC9+sN7mYOWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VNqU7vf/jSw532fD6s4gkiZ0LCMGrYrM27t6X3QPFmLDKk2xp5NJjtVHSvxPi0Cv6
	 0g3SR/l7pX9BU0VMMheLymjEn4iiiBcHU9duyEbwDmY/mH3wlblEnwkCFxbAN37DHC
	 5NrjusHaVfcJRUSvlO74aAYcSyWRs70koLt9pQtVN7vtVR3JL0qeLoUtmJyOGtU5s9
	 GD86M9WKSME9fIqMrysHkJNtAUveMPcV/Sh9mpc2MUDOI61Csmf5tK+07KiUYlcg9d
	 rH718Ary5/GywUrUICIbkukyHhn/t0JNViNJYNNr7ZTBaBKBDJcDL1tIfBkaSiAxFa
	 zFxwSofCv9jwQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	SJ Park <sj@kernel.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Hugh Dickins <hughd@google.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] mm/shmem: report RCU-tasks quiescent states while undoing a range
Date: Wed, 11 Nov 2026 09:24:20 -0500
Message-ID: <20261111142314.2301783-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062140-failed-5.10-ebd1a08c1921@kernel.org>
References: <20261107062140-failed-5.10-ebd1a08c1921@kernel.org>
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

From: Breno Leitao <leitao@debian.org>

[ Upstream commit ebd1a08c192109c83a87ddf42793ed6283180faf ]

This shows up in the Meta fleet on ftruncate() of large tmpfs files:

  INFO: rcu_tasks detected stalls on tasks:
  00000000752fd185: .. nvcsw: 59455/59455 holdout: 1 idle_cpu: -1/0
  task:rocksdb:bottom  state:R  running task
    __folio_split
    find_get_entry
    find_get_entries
    truncate_inode_partial_folio
    shmem_undo_range
    shmem_setattr
    notify_change
    do_ftruncate
    __x64_sys_ftruncate
    do_syscall_64

shmem_undo_range() walks the whole of the requested range in folio_batch
sized steps, twice, and its two cond_resched() calls are the only
reschedule points in that walk.

cond_resched() is not an RCU-tasks quiescent state.  Use
cond_resched_tasks_rcu_qs() at both points so the walk reports an
RCU-tasks quiescent state as it proceeds.

Link: https://lore.kernel.org/20260918-shmem-tasks-rcu-v1-1-79acf91a2569@debian.org
Fixes: 8315f42295d2 ("rcu: Add call_rcu_tasks()")
Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: SJ Park <sj@kernel.org>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>
Cc: <stable@vger.kernel.org>
[ sashal: adjusted loop context from folio batches to existing page vectors with explicit index advancement ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/shmem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 5f8d8899bd0e7..6f2e267aa092f 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -957,7 +957,7 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 		}
 		pagevec_remove_exceptionals(&pvec);
 		pagevec_release(&pvec);
-		cond_resched();
+		cond_resched_tasks_rcu_qs();
 		index++;
 	}
 
@@ -991,7 +991,7 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 
 	index = start;
 	while (index < end) {
-		cond_resched();
+		cond_resched_tasks_rcu_qs();
 
 		pvec.nr = find_get_entries(mapping, index,
 				min(end - index, (pgoff_t)PAGEVEC_SIZE),
-- 
2.53.0


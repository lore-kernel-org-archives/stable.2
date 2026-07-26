Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E498379C5F;
	Sun, 26 Jul 2026 20:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785099361; cv=none; b=OxnlinAQN9uIKk5pJZgREkRJLbuQPbIwe2EIG7LKW7podV44MgJKK7d0/Bz7Ny1YQ7xii9Fa22sBB4Ae6sUip8pbB7mMHo0ww8flsgYuxeBtHAefBD1lphUSngJSdmLCl3DhemPp3MZLAYbebz0mEgShzdAFpC8eXVURPMHcUm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785099361; c=relaxed/simple;
	bh=AbdV9VjhE6LTaOq0QiOaDkZKgquyYn4aQm+lx4mTY2o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q+OebAh/TK9p/xcWGDo69dJfOzVWjK3+hxRvsCj/2/rYweP+9Vo0QK153wPeYYADAO6sbTl/0/+1JbWmmKBaGAxdAhh9GWflN6Olc3kPkpUOe2mgpk40n+gHpyO4FPyYxlXNUJoflG5umooJ75lilXPDggltiTNWCMz0nfljP7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mcbZP66i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mcbZP66i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83D4C1F000E9;
	Sun, 26 Jul 2026 20:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785099359;
	bh=Cy1jhkVJMikuaizngOmkeHoHcCAWhI3GKKlTl+pKDaY=;
	h=From:To:Cc:Subject:Date;
	b=mcbZP66iHAvO7Cktqkzc9+AqeuV8RWgPJ5gtYgefh4R164h5kjvdkM3rU7tKU7cWW
	 dPxWFDuItoovOEY4JdMDkayHK9EzSfkYbWIib/xDP/R956LgfAZMrnvTrlPzC7uOO8
	 dnYo8kYcuFAnJeqL+Po92OFFoLcu2sdbnN1ZzXTRYanbemJGHEIwBiExnMGQ12KkP/
	 Q9oylu9KQudphgD/Pc4+9PwbpZ4wFaBXSCej8aLZU7Qcf+ZJnkkhXnMqD4whsmiq/t
	 FErlGOYnWiXVYU/lKnCmJqw5eNuWybGXUQTcXczHNpe0Uhq2+Btjdsdo8C8vRpuEyi
	 k/yV4yJfl4tbw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Honggyu Kim <honggyu.kim@sk.com>,
	Hyeongtak Ji <hyeongtak.ji@sk.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH] mm/damon: adjust isolated pages stat for DAMOS_MIGRATE_{HOT,COLD}
Date: Sun, 26 Jul 2026 13:55:46 -0700
Message-ID: <20260726205548.2287-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Callers of migrate_pages() should adjust NR_MIGRATED_{ANON,FILE} for
isolations and putback of the folios.  That for migration succeeded
folios is done by migrate_pages(), in migrate_folio_done().  That for
MR_DEMOTION reason is an exception though.

DAMOS_MIGRATE_{HOT,COLD} call migrate_pages() but mistakenly not doing
the stat adjustment.  As a result, use of DAMOS_MIGRATE_{HOT,COLD} could
corrupt the stat.  It could confuse too_many_isolated(), make compaction
and reclaim to behave in unexpected ways.  The stat corruption can be
reproduced and confirmed using DAMON user-space tool [1] on NUMA
systems, like below.

    $ numactl --hardware
    available: 2 nodes (0-1)
    [...]
    $ sudo ./damo start --damos_action migrate_hot 1
    $ sudo cat /proc/sys/vm/stat_refresh
    $ sudo dmesg
    [...]
    [   80.215554] vmstat_refresh: nr_isolated_anon -5578
    [   80.216842] vmstat_refresh: nr_isolated_file -34400

This issue was discovered [2] by Sashiko.

[1] https://github.com/damonitor/damo
[2] https://lore.kernel.org/20260726164356.87940-1-sj@kernel.org

Fixes: b51820ebea65 ("mm/damon/paddr: introduce DAMOS_MIGRATE_COLD action for demotion")
Cc: <stable@vger.kernel.org> # 6.11.x
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/ops-common.c | 2 ++
 mm/damon/paddr.c      | 2 ++
 mm/damon/vaddr.c      | 3 ++-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index e59f77eca83b2..9809fa12b09a8 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -374,6 +374,8 @@ static unsigned int damon_migrate_folio_list(struct list_head *folio_list,
 	while (!list_empty(folio_list)) {
 		folio = lru_to_folio(folio_list);
 		list_del(&folio->lru);
+		node_stat_sub_folio(folio, NR_ISOLATED_ANON +
+				folio_is_file_lru(folio));
 		folio_putback_lru(folio);
 	}
 
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 5a6a78054784a..5c6c3a597fd0b 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -346,6 +346,8 @@ static unsigned long damon_pa_migrate(struct damon_region *r,
 
 		if (!folio_isolate_lru(folio))
 			goto put_folio;
+		node_stat_add_folio(folio, NR_ISOLATED_ANON +
+				folio_is_file_lru(folio));
 		list_add(&folio->lru, &folio_list);
 put_folio:
 		addr += folio_size(folio);
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 4976775fe2762..0648400b2d65b 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -627,7 +627,8 @@ static void damos_va_migrate_dests_add(struct folio *folio,
 isolate:
 	if (!folio_isolate_lru(folio))
 		return;
-
+	node_stat_add_folio(folio, NR_ISOLATED_ANON +
+			folio_is_file_lru(folio));
 	list_add(&folio->lru, &migration_lists[i]);
 }
 

base-commit: 1e15fbef3a3c465a6a2db0f38e3980d75420bd6d
-- 
2.47.3

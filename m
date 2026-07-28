Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C0A4477EF;
	Tue, 28 Jul 2026 14:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785247449; cv=none; b=BohyWn2CmeBTSna/k6WL4aHhPh10OPS97TVuB0hLAwS9rCQUUkhUUMUGgVgoqoUe4LSBE23G6sH0q2OP3RCkyCUGyDUc2/n/u0pVF5z40D5FfhfFNjo7vpoR5Udtj4IIh7ONo7xhoFWb67lHaUrMMREicfKUglEV8urUkgT/itM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785247449; c=relaxed/simple;
	bh=E2ezk5pDmLoocv45qdhim+rZ1dWzYDJrTvaezvi+15o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fmKkSzCfU8YBs9ZA1W5JF2ky/3iWtsGZaHSDZudPb4tjmbBPyzh5Bbz0viQlJvggpitJkkZHvDiPiJ60ziLJTPcvIdVDLf4E9ObJWXNGEKFdXX6mY8vH/EtZLeIV7nP3/5jtYrTS8cVmLKV+x0xUU5DW3DOsUn6GGOAuDf8+g2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7vCzb67; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7vCzb67"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12BA11F000E9;
	Tue, 28 Jul 2026 14:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785247448;
	bh=66CFSKBjIR3I/xFltSKtBPbEufWyPg50Fofda3KYJxg=;
	h=From:To:Cc:Subject:Date;
	b=V7vCzb67PwUnlf9KUIkZeTYUAwkwY6498zx1mIJeUZmSHIw6UcXOd33Oexb7eo7dT
	 mqX4DDA4GYRv3S0YBhdx8qyMJtyCzaS8UPspkdtdA4cPa0KAEtSzl3EQAYK6UXzIcN
	 sL6JQie3qQLPX+y8OcOp8b1pV2+BBuNA0teXZXaJPdrwIu5ydhbCtZ19pjgTTgnjnU
	 yV2u4yrxwe6EJ6RCtdo0NzHQBvtRmkgi+Tgrjt4awqF6ri0obg6LsJfrYDdywaG//R
	 DrlgqNcSAA1B7KvbQeHL/mlbsF8FV5R0NRZO97aZVAhwjV98N6R/OarbDDcucQKwbr
	 ++NoZXLGpdiAA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Honggyu Kim <honggyu.kim@sk.com>,
	Hyeongtak Ji <hyeongtak.ji@sk.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH] mm/damon: adjust isolated pages stat for DAMOS_MIGRATE_{HOT,COLD}
Date: Tue, 28 Jul 2026 07:04:03 -0700
Message-ID: <20260728140404.94476-1-sj@kernel.org>
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
Changes from RFC:
- RFC: https://lore.kernel.org/20260726205548.2287-1-sj@kernel.org
- Rebase to the latest mm-new.
- Drop RFC tag.

 mm/damon/ops-common.c | 4 ++++
 mm/damon/paddr.c      | 2 ++
 mm/damon/vaddr.c      | 3 ++-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index 0981a5e3af172..fbda70d8ea4d0 100644
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
 
@@ -396,6 +398,8 @@ unsigned long damon_migrate_pages(struct list_head *folio_list, int target_nid)
 			struct folio *folio = lru_to_folio(folio_list);
 
 			list_del(&folio->lru);
+			node_stat_sub_folio(folio, NR_ISOLATED_ANON +
+					folio_is_file_lru(folio));
 			folio_putback_lru(folio);
 		}
 		return nr_migrated;
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
 

base-commit: 53f9deb696041883ca3d03b33b565e4cd3ba54dd
-- 
2.47.3

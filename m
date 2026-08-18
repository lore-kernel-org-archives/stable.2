Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31E9233923;
	Tue, 18 Aug 2026 06:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787034645; cv=none; b=koLfQkOdOXe+2UtiZyb02FVckfFAPiZP6t93AiFkmWiDZj3cDHZ50/6/3NVuOsEY8S4BU1hP7Htn6SiFfzvqi6iHh+xoieEohX2yqG2epvn34ZsWUy6bAA3SO/5w008yS/OOHqbkv9FtrZjcihCFfWcNj+dc0anhcvTmdTFXhpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787034645; c=relaxed/simple;
	bh=cPgJoejp0TM14pZBT8J/v0NSJOWsV74vujD/5KAEtII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LEN6QVMHin85yjTabeCJwydmr6jL3O8osikf+/cf6z1klTOezavTQtLqgN0UY83CPHYYCqVSUNHimVpgWdHlE2xB/k8xCCJrrAF3dvIT0oFO7q+P2NHYfTMDK4BPWPV0NBNer6shXimJruOhg4vcuaMfFmWhrlcs+XqE6ruXfao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwHqJbHJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwHqJbHJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CCE11F00A3D;
	Tue, 18 Aug 2026 06:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787034644;
	bh=Ylhttfsnkf7BkH9DuVvTNKgnTLaIvijgbABXClZrsoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lwHqJbHJ0heYAJU35QoUXIZ5U9iGvursUSLhiL8CXJRWgWJe4CsMyXD+chwmE1PDW
	 l5wWMC2pIcrQ9v8SmRDumG8yIQ9vjg8XST7CnAw3YzMOC4FQ4WxIK21BcufZ1xzuEL
	 z3Aje8GR+Dy022CBdVcDIzIAYG+yRf1tLr33kRBPkBjc4cUDBz/Wecds3K4cOC4B1R
	 7fCPjIVkcgAxMiUSs0M/srnX2nWROfI0GbTesFxfjaOUYfUUyIE8k/aqqcHJK2tyyY
	 dpjy4KorLCiMm1A0htQ/2T+jQmPOa7unFHsCNqcSBsq3RayJOX96zK6ZkHUM/DKQt6
	 Y6LdA1M8HTUpQ==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Honggyu Kim <honggyu.kim@sk.com>,
	Hyeongtak Ji <hyeongtak.ji@sk.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.12.y] mm/damon: adjust isolated pages stat for DAMOS_MIGRATE_{HOT,COLD}
Date: Mon, 17 Aug 2026 23:30:39 -0700
Message-ID: <20260818063041.94512-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026081758-bagged-engaged-79ec@gregkh>
References: <2026081758-bagged-engaged-79ec@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Callers of migrate_pages() should adjust NR_MIGRATED_{ANON,FILE} for
isolations and putback of the folios.  That for migration succeeded folios
is done by migrate_pages(), in migrate_folio_done().  That for MR_DEMOTION
reason is an exception though.

DAMOS_MIGRATE_{HOT,COLD} call migrate_pages() but mistakenly not doing the
stat adjustment.  As a result, use of DAMOS_MIGRATE_{HOT,COLD} could
corrupt the stat.  It could confuse too_many_isolated(), make compaction
and reclaim to behave in unexpected ways.  The stat corruption can be
reproduced and confirmed using DAMON user-space tool [1] on NUMA systems,
like below.

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

Link: https://lore.kernel.org/20260728140404.94476-1-sj@kernel.org
Link: https://github.com/damonitor/damo [1]
Link: https://lore.kernel.org/20260726164356.87940-1-sj@kernel.org [2]
Fixes: b51820ebea65 ("mm/damon/paddr: introduce DAMOS_MIGRATE_COLD action for demotion")
Signed-off-by: SJ Park <sj@kernel.org>
Cc: Honggyu Kim <honggyu.kim@sk.com>
Cc: Hyeongtak Ji <hyeongtak.ji@sk.com>
Cc: <stable@vger.kernel.org> # 6.11.x
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 1ec0e6b6f7321feb769f50d2f094a0aa6c2eda63)
Signed-off-by: SJ Park <sj@kernel.org>
---
NOTE: This patch should be applied after the manual backport [1] of
5deb65c34e68 ("mm/damon/ops-common: putback folios on invalid migrate
nid").

[1] https://lore.kernel.org/20260818062518.91960-1-sj@kernel.org

 mm/damon/paddr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 884042856f7ea..d4a4d51750f5f 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -414,6 +414,8 @@ static unsigned int damon_pa_migrate_folio_list(struct list_head *folio_list,
 	while (!list_empty(folio_list)) {
 		folio = lru_to_folio(folio_list);
 		list_del(&folio->lru);
+		node_stat_sub_folio(folio, NR_ISOLATED_ANON +
+				folio_is_file_lru(folio));
 		folio_putback_lru(folio);
 	}
 
@@ -437,6 +439,8 @@ static unsigned long damon_pa_migrate_pages(struct list_head *folio_list,
 			struct folio *folio = lru_to_folio(folio_list);
 
 			list_del(&folio->lru);
+			node_stat_sub_folio(folio, NR_ISOLATED_ANON +
+					folio_is_file_lru(folio));
 			folio_putback_lru(folio);
 		}
 		return nr_migrated;
@@ -487,6 +491,8 @@ static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s)
 
 		if (!folio_isolate_lru(folio))
 			goto put_folio;
+		node_stat_add_folio(folio, NR_ISOLATED_ANON +
+				folio_is_file_lru(folio));
 		list_add(&folio->lru, &folio_list);
 put_folio:
 		addr += folio_size(folio);
-- 
2.47.3


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E4241D131
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 12:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786970522; cv=none; b=I6T9USJbLVZGjUAPyrVZeEjKYWpjoudlWOgDERBMg4w14WDRuAl2mQB8R/xqy4wfe3ppV31tlD8Aulw0A/WGDmhvOG18DlEw+wrv7Lx0JvqKJlBpnElvL+t0JeRHcu3U8jAIhLBJOlxmpfNFCWZrqA7a3cYC7T8jgYgF03duwOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786970522; c=relaxed/simple;
	bh=zPcMCfeAgMLo3VZjpqAZGJCNIbu1FBTUFlA7IdbSZvM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=aiHuqOOQX/gVZ0V5nhUVSltWPqJ2CDJ6sReEA+jIX0mhSC4vJ6MPz7jqruEV43aFsIDfIPoCaTOmBhVC2/aw/vQhertusJT9vUvSfwzxtj0mMjZ51VSpqEmz7i3lW9Yzkyv/NI48w7Zz7P/gIqd1ax8ZYvHBcHdWexdBZSrlmw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v2/x6byp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v2/x6byp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B12A1F000E9;
	Mon, 17 Aug 2026 12:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786970521;
	bh=FW7TRtPwo3leK2XymOp+0UIPo72ZSRwnW9ElniDTq+A=;
	h=Subject:To:Cc:From:Date;
	b=v2/x6byp8jTWya3eRYbRDgga0kllwRJPOqTGl4f1yEpjw9LEe1ke7sk2+I+TEcFhp
	 4xcwQ4QRnu0wumELsT1KDtqJhxorlc0pk+pvF7J7JXkxfWSFUTGxlFNajBR1RMXP1l
	 aixrOIj2ADuCNpPcKPBstEAyhHriD1NFoMsnk9jI=
Subject: FAILED: patch "[PATCH] mm/damon: adjust isolated pages stat for" failed to apply to 6.12-stable tree
To: sj@kernel.org,akpm@linux-foundation.org,honggyu.kim@sk.com,hyeongtak.ji@sk.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 17 Aug 2026 14:36:58 +0200
Message-ID: <2026081758-bagged-engaged-79ec@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 1ec0e6b6f7321feb769f50d2f094a0aa6c2eda63
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026081758-bagged-engaged-79ec@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1ec0e6b6f7321feb769f50d2f094a0aa6c2eda63 Mon Sep 17 00:00:00 2001
From: SJ Park <sj@kernel.org>
Date: Tue, 28 Jul 2026 07:04:03 -0700
Subject: [PATCH] mm/damon: adjust isolated pages stat for
 DAMOS_MIGRATE_{HOT,COLD}

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

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index 9c178c175832..0bcad6b1e5b9 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -375,6 +375,8 @@ static unsigned int damon_migrate_folio_list(struct list_head *folio_list,
 	while (!list_empty(folio_list)) {
 		folio = lru_to_folio(folio_list);
 		list_del(&folio->lru);
+		node_stat_sub_folio(folio, NR_ISOLATED_ANON +
+				folio_is_file_lru(folio));
 		folio_putback_lru(folio);
 	}
 
@@ -397,6 +399,8 @@ unsigned long damon_migrate_pages(struct list_head *folio_list, int target_nid)
 			struct folio *folio = lru_to_folio(folio_list);
 
 			list_del(&folio->lru);
+			node_stat_sub_folio(folio, NR_ISOLATED_ANON +
+					folio_is_file_lru(folio));
 			folio_putback_lru(folio);
 		}
 		return nr_migrated;
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 5c2da45f988c..f7613ce279a2 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -350,6 +350,8 @@ static unsigned long damon_pa_migrate(struct damon_region *r,
 
 		if (!folio_isolate_lru(folio))
 			goto put_folio;
+		node_stat_add_folio(folio, NR_ISOLATED_ANON +
+				folio_is_file_lru(folio));
 		list_add(&folio->lru, &folio_list);
 put_folio:
 		addr += folio_size(folio);
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index e73ec1ce016e..2c1c1952c008 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -649,7 +649,8 @@ static void damos_va_migrate_dests_add(struct folio *folio,
 isolate:
 	if (!folio_isolate_lru(folio))
 		return;
-
+	node_stat_add_folio(folio, NR_ISOLATED_ANON +
+			folio_is_file_lru(folio));
 	list_add(&folio->lru, &migration_lists[i]);
 }
 


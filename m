Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABEF339B3D;
	Tue, 18 Aug 2026 06:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787034331; cv=none; b=VxDXwhy7aqoZ/jgERenLJizdgW8aQjxWPEheSuZ33hQ0V6FRsTOqL7dUKGkMPS0O7EV0hQOk1Qu8IvLppHlB8Qnz8mCPrkEEPUPaGYtHOUvSUNP6rt+D27ncrdnc8akgXtBM5gV9eFb2Yr0xUVSZSvxdmyYzmS3h1R5YxdvT8Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787034331; c=relaxed/simple;
	bh=mq8mU4O142wzQlu5JNZhjs7+BN+rtI92TO/Pe4uZaGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oc76M7cHRQskwLL1b4ymkRh4js1ainG+YLmH/iXT9hulmXwnbYyTtIJdxAbgi9knVB+3ipdAznqozcUp/NIG3f0m3oA2Vu+tKOKBAS7vL51IZCu+7FncO7zvOijpxhUeKEa6L8jBUWR1odY2phpBzdMUXGsJx0YCrtU/gXEAre8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzCRotzs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzCRotzs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C98611F000E9;
	Tue, 18 Aug 2026 06:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787034329;
	bh=7RpIoip1f+O06XchM2E975Jo4I+SSwAkUa44tnxxD8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kzCRotzscOYG8BQ5oGnXnZhsfzWGryNyI+oLCnHfsudP+QmLNLvpLPBr8UuiKqj4T
	 Pb13lXdZbxmh3WB1fYyUvcYBm497rBYeqBK1w6AMJ1n7bADrCHANv2VJl5Lw8P/vcI
	 blXyUkqKWbJ0pR6hOLqDQW/FllUxZgJmspHwVKunSnLKJIThms+WeA7OyVvhGjRqXo
	 GqeSjROkzHFnyv3zC8e/Z8IE3YiwBkXrxLXO/1SPD280uNlISxA2XMb2Yo99kWEPYD
	 OQUCWFsS6+BzrW5tAY1HZk3zQOmiIu3UM33f6/tESGu1V9eYTWMjTZ4u3Zu5pQID7V
	 fB9i0PSEyY2mw==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	liyouhong <liyouhong@kylinos.cn>,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.12.y] mm/damon/ops-common: putback folios on invalid migrate nid
Date: Mon, 17 Aug 2026 23:25:18 -0700
Message-ID: <20260818062518.91960-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026081721-strainer-detract-6eed@gregkh>
References: <2026081721-strainer-detract-6eed@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: liyouhong <liyouhong@kylinos.cn>

damon_pa_migrate() and damos_va_migrate() isolate folios into a local list
and then call damon_migrate_pages().  When target_nid is invalid
(including the scheme default NUMA_NO_NODE / -1), damon_migrate_pages()
returns early without putting the folios back to the LRU.

Callers then discard the list head while those folios remain isolated with
an extra reference taken by folio_isolate_lru().  The pages stay off the
LRU for as long as the mapping exists (anon active+inactive counts drop
while RSS does not), and the leftover references can pin the pages after
the mapping is gone.

Put the folios back on the invalid-nid path so ignored migration requests
still return them to the LRU.

Link: https://lore.kernel.org/20260726014815.1280757-1-dayou5941@163.com
Fixes: 7e6c3130690a ("mm/damon/ops-common: ignore migration request to invalid nodes")
Assisted-by: Cursor:grok-4.5
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: liyouhong <liyouhong@kylinos.cn>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 5deb65c34e682e7c5f5df417a70e223e8fcc5f5a)
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/paddr.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 4120a73f49339..884042856f7ea 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -432,8 +432,15 @@ static unsigned long damon_pa_migrate_pages(struct list_head *folio_list,
 		return nr_migrated;
 
 	if (target_nid < 0 || target_nid >= MAX_NUMNODES ||
-			!node_state(target_nid, N_MEMORY))
+			!node_state(target_nid, N_MEMORY)) {
+		while (!list_empty(folio_list)) {
+			struct folio *folio = lru_to_folio(folio_list);
+
+			list_del(&folio->lru);
+			folio_putback_lru(folio);
+		}
 		return nr_migrated;
+	}
 
 	noreclaim_flag = memalloc_noreclaim_save();
 
-- 
2.47.3


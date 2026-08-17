Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E1141CB3F
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 12:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786970473; cv=none; b=UH3aZBRJ+a2uueEJU8X0XUhagAaTw3NwOjpn++jwYta15aNhd5Pj6wGa8pHUGnWA6VACDSSXW+Yn/AjEfXX4g+CLy0y7JWRbmfUiBWxbMOp4zebNN0HkTon/ucrZxg10sQc4h+t8AiAgtblmcW4ipwY4idMEPoQ2wWP4B+GddOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786970473; c=relaxed/simple;
	bh=i9m4vgQrnIdXwpchWh68xvl5OgwtXwHf226OUM+yc3I=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=nqDE2+9Po66dx/0plX5wqYtMWLVwecuFErPXQaTPuKszSgO/g3T5prliKgdvg8TaXfL/cuFXjveY+krB4gDkPUKwLzjFccRMk+KwmxH4SSiL5Gff6oEY8CWwK0hB4hG27LbsND3FhZ9AsvcgkLkmp0QYmYUlOY6EhbEiLzkmz+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k1raDSSb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k1raDSSb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7CE51F00A3F;
	Mon, 17 Aug 2026 12:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786970472;
	bh=ow+XlSzFM3yXvKAke/lmaPxRozigLgsNOLzpm91vyG0=;
	h=Subject:To:Cc:From:Date;
	b=k1raDSSbsZWCgbLJZieoCPCVYcqqz4H6mkjiIWVtUyAfJgl65y7lC7gjaQtorJE6V
	 XrslczpURli3ZQU2YWNAVp7N1pQkTZ0FGw2gG8RR6kzkPVuqqsQ1ibH57VQzDenkve
	 GTngHjwwtu4M9mcUjYap771jTTu8wReSRaSCh7uQ=
Subject: FAILED: patch "[PATCH] mm/damon/ops-common: putback folios on invalid migrate nid" failed to apply to 6.12-stable tree
To: liyouhong@kylinos.cn,akpm@linux-foundation.org,sj@kernel.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 17 Aug 2026 14:35:21 +0200
Message-ID: <2026081721-strainer-detract-6eed@gregkh>
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
git cherry-pick -x 5deb65c34e682e7c5f5df417a70e223e8fcc5f5a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026081721-strainer-detract-6eed@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5deb65c34e682e7c5f5df417a70e223e8fcc5f5a Mon Sep 17 00:00:00 2001
From: liyouhong <liyouhong@kylinos.cn>
Date: Sun, 26 Jul 2026 09:48:15 +0800
Subject: [PATCH] mm/damon/ops-common: putback folios on invalid migrate nid

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

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index 6bdd1cfd3863..9c178c175832 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -392,8 +392,15 @@ unsigned long damon_migrate_pages(struct list_head *folio_list, int target_nid)
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
 


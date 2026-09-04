Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF8552B1F8
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 20:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788553952; cv=none; b=GuIi8NRt+eqIOKe961YWyMvNgPrgxmDLETPXNGtOmFR8RqD1SIh/5RZBCQkGtNRobRZXQfbnbLXKHpkO7FX+bg2+1Y2BGRZYCGnispWMiSokyr63w6mYtzx9i0FSMdLN3kDKiG/nQRj/uWonOCWu2t7nLWuNytr2nL0dSkHpj5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788553952; c=relaxed/simple;
	bh=h8seaiCenXDfRApYwohoHonZwSQrDgTNG7mLvcNVv2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cM+I4M+LtRawtqEGxuvVcHCgVOwWdH7lURGUjhi2EiPgbdXCr/gmUTuqWMDyHYYdYuptc4KrmrNexvQYhcrAGqG8/zybAYvyd9LnOjK3xG7FOVJ/PgILjkJihsF0wS2k1Qxuq0+CtlD7PRjFrFc90X7EIS+eHwnIfd3ba4IgIaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EbN+9SSP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EbN+9SSP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A72C1F00AC4;
	Fri,  4 Sep 2026 20:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788553943;
	bh=hIO24by7EtizenEkAkHY8OM3K5n6k3FgR76aKKUREBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EbN+9SSPZTDOYV6MRxEe8anNlPy0BsuFzk39fVV5sjmm77HS5NpMAbBCK4k4Vrikp
	 ekjf8iFu4YN0XbA+RYzkJi3o5BxSc9U/DzR5GMAv+yZWFCQ0UOG/cxIVac81kWRJIk
	 rPieRyAl4vd2CjCe5Xdh02z6/3Pdlh5e5znGxSaRThdjO1QF6xxbY1AatGgXW7bPJF
	 2P8FQ6f/QMrir3biGogMH9JMtmxHzGU58HuQq7SBlCB2c250HiGUTxmEbX7A0cQ8FA
	 mH6D4lRa6zq212Hho1AAuB4lxWfzocobZgWKoOOfjplYy3s/tTe6JB93pJJRnYaXeh
	 tzk/TaWPsVJag==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chengming Zhou <zhouchengming@bytedance.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Minchan Kim <minchan@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/9] mm/zsmalloc: remove_zspage() don't need fullness parameter
Date: Fri,  4 Sep 2026 16:32:12 -0400
Message-ID: <20260904203217.1548415-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904203217.1548415-1-sashal@kernel.org>
References: <2026090349-deniable-copilot-d36a@gregkh>
 <20260904203217.1548415-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chengming Zhou <zhouchengming@bytedance.com>

[ Upstream commit 67eaedc1c52f0ac3ea99e4fc0bc3d7940344b94b ]

We must remove_zspage() from its current fullness list, then use
insert_zspage() to update its fullness and insert to new fullness list.
Obviously, remove_zspage() doesn't need the fullness parameter.

Link: https://lkml.kernel.org/r/20240220-b4-zsmalloc-cleanup-v1-2-5c5ee4ccdd87@bytedance.com
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Nhat Pham <nphamcs@gmail.com>
Cc: Yosry Ahmed <yosryahmed@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: f7bf5cd5b5f2 ("zsmalloc: account for handle size in class lookup")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/zsmalloc.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 075e2a692acd9..0cf814a809ec1 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -688,10 +688,10 @@ static void insert_zspage(struct size_class *class,
  * This function removes the given zspage from the freelist identified
  * by <class, fullness_group>.
  */
-static void remove_zspage(struct size_class *class,
-				struct zspage *zspage,
-				int fullness)
+static void remove_zspage(struct size_class *class, struct zspage *zspage)
 {
+	int fullness = zspage->fullness;
+
 	VM_BUG_ON(list_empty(&class->fullness_list[fullness]));
 
 	list_del_init(&zspage->list);
@@ -717,7 +717,7 @@ static int fix_fullness_group(struct size_class *class, struct zspage *zspage)
 	if (newfg == currfg)
 		goto out;
 
-	remove_zspage(class, zspage, currfg);
+	remove_zspage(class, zspage);
 	insert_zspage(class, zspage, newfg);
 out:
 	return newfg;
@@ -879,7 +879,7 @@ static void free_zspage(struct zs_pool *pool, struct size_class *class,
 		return;
 	}
 
-	remove_zspage(class, zspage, ZS_INUSE_RATIO_0);
+	remove_zspage(class, zspage);
 	__free_zspage(pool, class, zspage);
 }
 
@@ -1610,7 +1610,7 @@ static struct zspage *isolate_src_zspage(struct size_class *class)
 		zspage = list_first_entry_or_null(&class->fullness_list[fg],
 						  struct zspage, list);
 		if (zspage) {
-			remove_zspage(class, zspage, fg);
+			remove_zspage(class, zspage);
 			return zspage;
 		}
 	}
@@ -1627,7 +1627,7 @@ static struct zspage *isolate_dst_zspage(struct size_class *class)
 		zspage = list_first_entry_or_null(&class->fullness_list[fg],
 						  struct zspage, list);
 		if (zspage) {
-			remove_zspage(class, zspage, fg);
+			remove_zspage(class, zspage);
 			return zspage;
 		}
 	}
-- 
2.53.0


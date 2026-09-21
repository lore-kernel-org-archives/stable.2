Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD203C871D
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 20:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790021257; cv=none; b=TQeoCH4RGO6q8CeX7GzvKKSi7+vhzVs4Yi5Os02C6l4tJB2ub4k7k0y+hzFVr3OfkXfeHBmSITvkvfd5O3g7oaKqTrOAJLLVRBOuM1E/3oFTjrYmycPpMcvI1zVBg/GMwH1vVXZmllXqMjqLteNfr78hYM91ZramEjGCig6N+K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790021257; c=relaxed/simple;
	bh=3vXE7lcQFe0Ihorih0Ly7xdqxebP2q99jKEPnxKX+mU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VvO7K7XGBEM1ySDvvXkJLb9ro5DQlUUcFxsSowZgqkiYZgOgJkGOseOK6BTau3I7yxdDNMIzmtegaziRtLgSAvVnDCd2NptfG3ZxX9nChjBNbK7Cq1MiqxylzBciqpohBHxKPnKja0Jqaj/Jxb/yLDnZUOO5l4eckClFnaiySQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=IVJ242w4; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="IVJ242w4"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccb652d7so3099728a91.0
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 13:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1790021255; x=1790626055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A4qzWgzNNZY14DzhBVqEY1Mje98vG/0yM0yF+Z9V/Bg=;
        b=IVJ242w4vD43Q/eF3sfcPGvWTylhHY0x9f6jsXVW9+Bv2ln0VBpM9oL7VvybLjb0rE
         WwfPdXEH4RmbDFWPl7reW0dDZf36FG9plKPJqGHtE/B8rUrDYWpycrY2q1BgOyMczjQ6
         kVcSGcDr1Ug1VwoJz+7y+NRwNft9ZLVSW6xaVGxQw3GBhZoKEs5YwXGXGnzNpiwRxA9y
         hPJTGkNSBiD6X4LVBOOX2rIL2r13BisHGfOfv8GL3xrZVKpuJ4up/mT30b8xRoegpfLK
         LexCMlIyN2uQhDmxJRT+EuUd4CbkJY1txMkMdAt6K6HvS9JXKwFP2Uf3cNjORIFdJAra
         XOSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790021255; x=1790626055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=A4qzWgzNNZY14DzhBVqEY1Mje98vG/0yM0yF+Z9V/Bg=;
        b=s/7tMXnE8x0Lk1/Un6jWtnZByNA7WeXapFNzWx2vpCW6V1B6B0R1z7ZeCKt2Ala9LQ
         IYhbZVVgmfiRKvRXBjc87m+XwCFxX1OUp2+EHVu2qznybmoKsDi/CkK0x4xieFpgLRrK
         m1SKbFLvvkpze7otK4ofM7PmVAdO9VNyPvoY5oOFIu8dDdBtjgstkhqFQbUysPx3UX3s
         koHMvp0M3aqNTV5hTKZr1L09ewBUvJblWg8gZuvKdh9t77D1ohtdp7OonEOC4GvwSpsv
         nb/5wR7CZXVj4r6uCJ1ANJmjI3GMdOi/E1JL7epQUuhpPQ7j0KOMWanMN4VawgIFR/LJ
         yknw==
X-Gm-Message-State: AFuF++mfazjfR/CfoHko1jctdc1UMyATBWv32cQHlqJCpLcTlbTuSumF
	2NGhTZLuVG60zuQL6mkhjLdYJR3GpAx3xmH1iRxsNeVEV5caKDcRqkcJ+85vgaTAaBDc2p8a/8/
	BHnAS1Uk=
X-Gm-Gg: AYBFou3Ao3vuzzw2WCtFBYe92zqX4oX5j6Vw6IwkMRvOGq47XnijFGSMMXA2FVW93bY
	FRV9De1nSAOvbp5oom+YmxYcsjZ47pp4S9B1zwNcrPDtdQXNoD3Gfho3ta3UCdsWIItYhvDXzoB
	ccgNjK+4kO86WhnFdW6JcmhRRd5VDTywAMYKph1j6xML0tbbzeYAcJUSqbgB1mY686Es8jjo2ka
	2kLpZDMjIJcEUJtH2VgQutxYsgHHeuSManQ03yogpa1gQAsJvtAI+N794K4xowXECrzHR2wymEQ
	FHRuVaa8/dTE93W5pkcIR8CMTXq0B7HhfbVQCQn/3gD7gUTmkbHzXyrZXRw0UzFi56S9U43aOrx
	qodqzsMClS3FEpPVnE4aykIySNmd+qll+TzNKpecoeuq1v3v+brvGg2wyXjt4iAQKQAXkACMoQA
	YGUYlLNTJPcz8tL3rF9EILtiN0juzKL8o2tV9O0AdHZBvS7vNi/My/HIvGLspyYL0z/mZkzwpeG
	s12omchW4qcVmmkusevsRiGiCVmc/O9eAbpOZpwSEx/UZ6Tx30b+vo+VoWqnjgUPp+W4gyrA6ID
	qxbBqw==
X-Received: by 2002:a17:90b:2649:b0:39e:3713:c2e4 with SMTP id 98e67ed59e1d1-39e54dce754mr19264623a91.14.1790021255157;
        Mon, 21 Sep 2026 13:07:35 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:289a:f600:f11e:a45c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e5ebcdbe8sm501164eec.15.2026.09.21.13.07.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 21 Sep 2026 13:07:34 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengming Zhou <zhouchengming@bytedance.com>,
	Ming Lei <ming.lei@redhat.com>,
	Yi Zhang <yi.zhang@redhat.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 6.1.y 2/2] blk-mq: fix tags UAF when shrinking q->nr_hw_queues
Date: Mon, 21 Sep 2026 16:07:26 -0400
Message-ID: <20260921200728.84114-3-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921200728.84114-1-artem@trailofbits.com>
References: <20260921200728.84114-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chengming Zhou <zhouchengming@bytedance.com>

[ Upstream commit 6be6d112419713334ddd9c01f219ca16adaa4c76 ]

When nr_hw_queues shrink, we free the excess tags before realloc'ing
hw_ctxs for each queue. During that resize, we may need to access those
tags, like blk_mq_tag_idle(hctx) will access queue shared tags.

This can cause a slab use-after-free, as reported by KASAN. Fix it by
moving the releasing of excess tags to the end.

Fixes: e1dd7bc93029 ("blk-mq: fix tags leak when shrink nr_hw_queues")
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Closes: https://lore.kernel.org/all/CAHj4cs_CK63uoDpGBGZ6DN4OCTpzkR3UaVgK=LX8Owr8ej2ieQ@mail.gmail.com/
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Link: https://lore.kernel.org/r/20230908005702.2183908-1-chengming.zhou@linux.dev
Signed-off-by: Jens Axboe <axboe@kernel.dk>

[ Backport to 6.1.y follow-up to e1dd7bc93029: move those frees after
  hctx resizing using cur_nr_hw_queues, preventing its tag UAF. ]
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Stable submission note: patch 2/2 in the CVE-2023-54227 series for Linux
6.1.y.

CVE: CVE-2023-54227

Build: This patch was included in the x86_64 allmodconfig and
CONFIG_WERROR=y build. It produced no new warnings or errors.

 block/blk-mq.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index b6215bee3d3c45..bf69079f6bd517 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4509,13 +4509,9 @@ static int blk_mq_realloc_tag_set_tags(struct blk_mq_tag_set *set,
 				  int cur_nr_hw_queues, int new_nr_hw_queues)
 {
 	struct blk_mq_tags **new_tags;
-	int i;
 
-	if (cur_nr_hw_queues >= new_nr_hw_queues) {
-		for (i = new_nr_hw_queues; i < cur_nr_hw_queues; i++)
-			__blk_mq_free_map_and_rqs(set, i);
+	if (cur_nr_hw_queues >= new_nr_hw_queues)
 		return 0;
-	}
 
 	new_tags = kcalloc_node(new_nr_hw_queues, sizeof(struct blk_mq_tags *),
 				GFP_KERNEL, set->numa_node);
@@ -4804,7 +4800,8 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 {
 	struct request_queue *q;
 	LIST_HEAD(head);
-	int prev_nr_hw_queues;
+	int prev_nr_hw_queues = set->nr_hw_queues;
+	int i;
 
 	lockdep_assert_held(&set->tag_list_lock);
 
@@ -4831,7 +4828,6 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 		blk_mq_sysfs_unregister_hctxs(q);
 	}
 
-	prev_nr_hw_queues = set->nr_hw_queues;
 	if (blk_mq_realloc_tag_set_tags(set, set->nr_hw_queues, nr_hw_queues) <
 	    0)
 		goto reregister;
@@ -4869,6 +4865,10 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 
 	list_for_each_entry(q, &set->tag_list, tag_set_list)
 		blk_mq_unfreeze_queue(q);
+
+	/* Free the excess tags when nr_hw_queues shrink. */
+	for (i = set->nr_hw_queues; i < prev_nr_hw_queues; i++)
+		__blk_mq_free_map_and_rqs(set, i);
 }
 
 void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues)
-- 
2.39.5


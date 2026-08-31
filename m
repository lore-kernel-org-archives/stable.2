Received: from va-2-28.ptr.blmpb.com (va-2-28.ptr.blmpb.com [209.127.231.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E1E4302E6
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 16:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788193381; cv=none; b=RZz9IK5RiVvEVIft1evKPhIkGCkHqVexq6iqeiY95AJK6CDPpem7qNj2dKpsvK2frMdrtlkw+bJCbp6Ozt/4r5AhJogt0KHbXAUwTQvbd5JB7NFoRAFQTFTcX+6eqjYPwbMGPFBfz0OXY/MgxSaRsU08dZ8LEtd8kGrzNNI4Lvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788193381; c=relaxed/simple;
	bh=lndwonqhLDph5lNWOcCTfeZP/5ya24PfgDSXzwEYCfg=;
	h=From:Content-Type:Date:Subject:Mime-Version:To:Message-Id:Cc; b=i/Ohj33cdtSp1oBtIybO6+S5D+rVse5FP7U6JhRyt+IBbUknOQwW0IjwZGwpGFDDL7lMlx4R/emF58pjHGBxPs1SPMEUi+cYyAT22b2Qwol2+nkzEhmGF0cpk04NZAV7UOM041FMj4/877WuxNvyyPKpOdeDH1DiceQjgu6Z10o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moonshot.ai; spf=pass smtp.mailfrom=moonshot.ai; dkim=pass (2048-bit key) header.d=moonshot.ai header.i=@moonshot.ai header.b=cbnX02Ba; arc=none smtp.client-ip=209.127.231.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moonshot.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moonshot.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=moonshot.ai header.i=@moonshot.ai header.b="cbnX02Ba"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2510091218; d=moonshot.ai; t=1788193369; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=cKkA0rhlQS33p/wzeNT4lOjxQMCU4D8V1A0GSI6eF7A=;
 b=cbnX02Ba+XJ0mhwZ28iFmO6J8vzmI8Ly+HkI0EPKB6iAF1faYq/5awvGWI/s2u6ACIvFiB
 GQoG+EcvFzr/khAnq1lBqjz7mpw6AP5Dv+fEF5Ug0IMmYLCjDxzIIzmwJpGJomh5z4fXiX
 S6IszXEWTZOnPG/4QwrGco/UaOaTIIRUHLxx/nO6Sveg7zGeaAhsqkc5bnSo6NEWa844SM
 mHP9SujWRcRuQtz7GB8+l+HPtJAOYRmgjZ/Chc4H4JbgRlqWubnLsgA2ieQ6F5kxXAi4ko
 Gng1stOAQIrfaltFiYF0nQ0W7opSJ+noVYCguF/rqgmCwHaRSBgCykWESou0Qw==
X-Mailer: git-send-email 2.34.1
From: "Yilin Zhang" <yilinzhang@moonshot.ai>
Content-Transfer-Encoding: 7bit
X-Original-From: Yilin Zhang <yilinzhang@moonshot.ai>
Content-Type: text/plain; charset=UTF-8
Date: Tue,  1 Sep 2026 00:21:55 +0800
Subject: [PATCH v4] perf: Fix use-after-free when perf mmap() revival races with the last munmap()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26a95aa57+fb0419+vger.kernel.org+yilinzhang@moonshot.ai>
To: <peterz@infradead.org>
Message-Id: <20260831162155.1437652-1-yilinzhang@moonshot.ai>
Received: from dev.msh-dev.svc.cluster.local ([117.157.206.135]) by smtp.feishu.cn with ESMTPS; Tue, 01 Sep 2026 00:22:46 +0800
Cc: "Yilin Zhang" <yilinzhang@moonshot.ai>, <mingo@redhat.com>, 
	<acme@kernel.org>, <namhyung@kernel.org>, <kylebot@openai.com>, 
	<david.lee@trailofbits.com>, <linux-perf-users@vger.kernel.org>, 
	<stable@vger.kernel.org>, "Kimi Security Team" <bug-report@moonshot.ai>, 
	"Weiming Shi" <shiweiming@moonshot.ai>

perf_mmap_close() drops rb->mmap_count *without* holding
event->mmap_mutex (the refcount_dec_and_test() right before the
refcount_dec_and_mutex_lock() of event->mmap_count). A concurrent
perf_mmap_rb() can slot its entire "revival" path into that window
(perf_mmap holds event->mmap_mutex for its whole duration, including
rb_alloc):

  munmap side (perf_mmap_close)          mmap side (perf_mmap_rb)
  -----------------------------------    --------------------------------
  rb->mmap_count 1 -> 0   (no lock)      (holds event->mmap_mutex)
                                         inc_not_zero(rb->mmap_count) fails
                                         ring_buffer_attach(event, NULL)
                                         rb_alloc() + attach new rb
                                         refcount_set(&event->mmap_count, 1)
  lock; event->mmap_count 1 -> 0
  ring_buffer_attach(event, NULL)
  ring_buffer_put() -> frees the *new* rb

The revival's refcount_set(&event->mmap_count, 1) is an invisible
1 -> 1 write: the close frees the just-revived buffer although the
other process still has it mapped -- a page-level use-after-free
allowing local privilege escalation to root by any unprivileged user
(default kernel.perf_event_paranoid=2).

Swap the order of the two counter updates: event->mmap_count is
dropped first via refcount_dec_and_mutex_lock(), so its 1 -> 0
transition and the ring_buffer_attach() stay serialized with
perf_mmap(). rb->mmap_count == 0 then implies every event using the
buffer is detached already, so the result of the rb->mmap_count drop
can gate the remaining teardown directly and detach_rest is no longer
needed.

An earlier fix for this race from Kyle Zeng and David Lee takes
event->mmap_mutex around both counter updates [0]; here the not-last
close stays lockless.

Fixes: 59741451b49c ("perf: Identify the 0->1 transition for event::mmap_count")
Link: https://lore.kernel.org/linux-perf-users/20260804060931.711308-1-david.lee@trailofbits.com/ [0]
Cc: stable@vger.kernel.org # 6.18+
Reported-by: Kimi Security Team <bug-report@moonshot.ai>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Co-developed-by: Weiming Shi <shiweiming@moonshot.ai>
Signed-off-by: Weiming Shi <shiweiming@moonshot.ai>
Signed-off-by: Yilin Zhang <yilinzhang@moonshot.ai>
---
v3: https://lore.kernel.org/linux-perf-users/20260831133152.1231045-1-yilinzhang@moonshot.ai/
v4: restore the ordering comment; no functional change

 kernel/events/core.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index a6c8e38a3110..f02780529b43 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7029,7 +7029,6 @@ static void perf_mmap_close(struct vm_area_struct *vma)
 	mapped_f unmapped = get_mapped(event, event_unmapped);
 	struct perf_buffer *rb = ring_buffer_get(event);
 	struct user_struct *mmap_user = rb->mmap_user;
-	bool detach_rest = false;
 
 	/* FIXIES vs perf_pmu_unregister() */
 	if (unmapped)
@@ -7060,17 +7059,18 @@ static void perf_mmap_close(struct vm_area_struct *vma)
 		mutex_unlock(&rb->aux_mutex);
 	}
 
-	if (refcount_dec_and_test(&rb->mmap_count))
-		detach_rest = true;
-
-	if (!refcount_dec_and_mutex_lock(&event->mmap_count, &event->mmap_mutex))
-		goto out_put;
-
-	ring_buffer_attach(event, NULL);
-	mutex_unlock(&event->mmap_mutex);
+	/*
+	 * Drop references in reverse order of perf_mmap() to prevent
+	 * rb revival after rb->mmap_count reaches zero.
+	 */
+	if (refcount_dec_and_mutex_lock(&event->mmap_count,
+					&event->mmap_mutex)) {
+		ring_buffer_attach(event, NULL);
+		mutex_unlock(&event->mmap_mutex);
+	}
 
 	/* If there's still other mmap()s of this buffer, we're done. */
-	if (!detach_rest)
+	if (!refcount_dec_and_test(&rb->mmap_count))
 		goto out_put;
 
 	/*
-- 
2.43.0

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1829C3BF66B
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 11:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787311999; cv=none; b=ZvJOiY4hVk6Z+Ub5LyBHoGM6TMYpJf+qQbqcKEHeraMRYwdJc2tV9ArDBbgl4Rhp4aSGKMUg2D0U3g5hhjR0QgPz16XRybqrPDauyauHeuaIa+lBH8ykdvsi5TpNqEEE08DnstEfkXlsEbuubj/D2xfbqQ+94b7bdl3ccwlnWC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787311999; c=relaxed/simple;
	bh=IXAB/X5+/b2NgiT/A5BMyPyDxkLyyq4eunIU9JSDnE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GcjKLct63sEVYWSQEzyMH2wjN6gwNWA+ww1ysRi2LM3b4K5jfh+v2iaE9InebwZOvriHwggAMJR8iXH+Y0iT/1ONjKi4k7NogVv7MjMi7uMhGoTxCTbPFZ1a6wqWLDUXUjN3ZSyyoXz9sV1KsS++jbI0H7TIVfjKl66mAy8DTI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mw4P0qxa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mw4P0qxa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 394A51F00A3A;
	Fri, 21 Aug 2026 11:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787311997;
	bh=VPIfxGTvoihViQ5c2tG+yfbazO7IYVeH5S9hqDtP5/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Mw4P0qxawT8by7CIfmVvq6+cOYM9dNg+Kw2RD2rmFcNiQCes1EV+U8Oi4tQXHZigr
	 4XIJ3/ahTjBc0ZgIgwURcOc0uimzDWk87fYasmW+412y79LHdwL/50NqyE9F3ipJJV
	 XnbhhbkOJeJJ25JQnwFotsZ86OsVRCyvP311mEb+0I/xR6z3HfB63hYykO0cKXc/uf
	 Jx4MEI4SDj9LrWEA2MqVHOcXwuzU8eQnfAnwyevgiK/XLXPgCLbF0qo8Z2m69VOOU0
	 zEfHELCs9M9uflX8nh0oxSV0NBcdeVtx42HxmN79BnVMo8Lgq8mAT9xuGXEI4BGNy/
	 KrtiNsv6uoawQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yeoreum Yun <yeoreum.yun@arm.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	David Wang <00107082@163.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/3] perf: Fix dangling cgroup pointer in cpuctx
Date: Fri, 21 Aug 2026 07:33:08 -0400
Message-ID: <20260821113309.2981106-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821113309.2981106-1-sashal@kernel.org>
References: <2026081732-unmixed-crudely-500c@gregkh>
 <20260821113309.2981106-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yeoreum Yun <yeoreum.yun@arm.com>

[ Upstream commit 3b7a34aebbdf2a4b7295205bf0c654294283ec82 ]

Commit a3c3c6667("perf/core: Fix child_total_time_enabled accounting
bug at task exit") moves the event->state update to before
list_del_event(). This makes the event->state test in list_del_event()
always false; never calling perf_cgroup_event_disable().

As a result, cpuctx->cgrp won't be cleared properly; causing havoc.

Fixes: a3c3c6667("perf/core: Fix child_total_time_enabled accounting bug at task exit")
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: David Wang <00107082@163.com>
Link: https://lore.kernel.org/all/aD2TspKH%2F7yvfYoO@e129823.arm.com/
Stable-dep-of: 42c5ca1f0a28 ("perf/core: Fix group leader use-after-free after sibling detach")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/events/core.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 756152374a3b9..5e4d1b090db70 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2117,18 +2117,6 @@ list_del_event(struct perf_event *event, struct perf_event_context *ctx)
 	if (event->group_leader == event)
 		del_event_from_groups(event, ctx);
 
-	/*
-	 * If event was in error state, then keep it
-	 * that way, otherwise bogus counts will be
-	 * returned on read(). The only way to get out
-	 * of error state is by explicit re-enabling
-	 * of the event
-	 */
-	if (event->state > PERF_EVENT_STATE_OFF) {
-		perf_cgroup_event_disable(event, ctx);
-		perf_event_set_state(event, PERF_EVENT_STATE_OFF);
-	}
-
 	ctx->generation++;
 }
 
@@ -2422,6 +2410,7 @@ __perf_remove_from_context(struct perf_event *event,
 			   struct perf_event_context *ctx,
 			   void *info)
 {
+	enum perf_event_state state = PERF_EVENT_STATE_OFF;
 	unsigned long flags = (unsigned long)info;
 
 	if (ctx->is_active & EVENT_TIME) {
@@ -2430,6 +2419,12 @@ __perf_remove_from_context(struct perf_event *event,
 	}
 
 	event_sched_out(event, cpuctx, ctx);
+
+	if (event->state > PERF_EVENT_STATE_OFF)
+		perf_cgroup_event_disable(event, ctx);
+
+	perf_event_set_state(event, min(event->state, state));
+
 	if (flags & DETACH_GROUP)
 		perf_group_detach(event);
 	list_del_event(event, ctx);
-- 
2.53.0


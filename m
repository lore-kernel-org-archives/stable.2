Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C220525CC57
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 03:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787284786; cv=none; b=bd5pV0X5ykpNM4psOufAgdCoOWFDxrCHRJkNlnMTPagvC7uD3L4wWFMV4tHZqax7oFmm2szOtoe36fFRUEA3Oyi9WnhY/YwUAqu/UqjCk0EehqZvqJR2avBQQTtSbJ5cW2cPsLPa6J6swIQe5+jFsM80XF6eQqUHjeOiTJuCgWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787284786; c=relaxed/simple;
	bh=STdYgz1HW4viaXIzk0KaNmqV960HUo7uoAynv6acxr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lvy3cZLf6IEEXm2AFNPQVsIP5OdRz3NtMStFOkuOGx+1OqwMfkxHw65A1y8TN5E2Hg0CWWi6jL/h4/dq8bMBs8k8ov1lPdemo4+EnlINXPdh5M6+mTFfzKBdsMMzjbu4jufOUxo47LB4AGMbcQ72vdHzwjgLeO/dDCMub0Ox6CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=doP25P98; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="doP25P98"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E53D1F000E9;
	Fri, 21 Aug 2026 03:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787284785;
	bh=GByhQVq5JmmDLgsbUG/oIDPUgEeU94vnv62IJgY7sJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=doP25P98d/UQBDRwkjdyNOFqSa1XNqC+RWYS/KlwCvCA4ZnGRfGhq+CCXMM/aZSsj
	 xFaUYCNv3NiJZV7+WauyRli/PZqCHwiDHH7zNCn+b1wWrIYY+lVpa3KnH5Kmr09TdD
	 NNZ3zzDiTTLcFGz38h/2psOhcnfRr7P3tjpYHrT+SpecHyKIruqxclKS69FXLC9zPh
	 VhR2ENclP5FMx6RPvehBvbnYRnRRNUWsocK/CHGylluxJdPVhULUCPzP6yaXRtLv4l
	 SaRmnf3tRPkfF3Rdy/c/d0RbX8wj+VznW5g0wPVhw9mCDfe3ixDivsGLcElrIYqpIS
	 Y2gHuXf6oVTRw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yeoreum Yun <yeoreum.yun@arm.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	David Wang <00107082@163.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/4] perf: Fix dangling cgroup pointer in cpuctx
Date: Thu, 20 Aug 2026 23:59:39 -0400
Message-ID: <20260821035940.2526518-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821035940.2526518-1-sashal@kernel.org>
References: <2026081730-distance-sherry-000f@gregkh>
 <20260821035940.2526518-1-sashal@kernel.org>
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
 kernel/events/core.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index cdbcc5a29b063..1ba4c5e5e4fbf 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2031,18 +2031,6 @@ list_del_event(struct perf_event *event, struct perf_event_context *ctx)
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
 
@@ -2396,6 +2384,10 @@ __perf_remove_from_context(struct perf_event *event,
 		state = PERF_EVENT_STATE_DEAD;
 	}
 	event_sched_out(event, cpuctx, ctx);
+
+	if (event->state > PERF_EVENT_STATE_OFF)
+		perf_cgroup_event_disable(event, ctx);
+
 	perf_event_set_state(event, min(event->state, state));
 	if (flags & DETACH_GROUP)
 		perf_group_detach(event);
-- 
2.53.0


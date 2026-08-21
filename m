Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7406D37756A
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 04:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787286224; cv=none; b=aPz3d19Bd26ljd0lJ141Yv4D0zqeHbSFxWPiuK5j+oGOOe89nGeV1J1XwYNVquJGWwkq0cUalKVb/0uLK/a7Tl3GeCop4PdHPz25dkkOnhJLUNV8Bxzc//GjoYZUu0MNSZMYF83lORPzxBGavLkpIsGL44+c4EVov4RKYaI6Rkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787286224; c=relaxed/simple;
	bh=TlZhyz1i+6oykMpWVohZYGXVUXJNaQwtRNxIcmwCI9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=juDHnLJUBEl2l+NmoIZkl6KHffukB/HepEGVrne2FaC/0S5dD4jCqsgrxDjR3C4nzMLPE1w6XYjVzGspJv7SY/0YPQAbikt3gjV6OfpliHplv1YwjBlcuYf7ZBjsH+wy1rwGu6vHZASRG/9Yx6KAqTv3xFyhC3/W/jY/FFXUqjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SR/pzx+O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SR/pzx+O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 944FC1F00A3A;
	Fri, 21 Aug 2026 04:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787286223;
	bh=Q05x53VkMNUbOOmWO0zayYX2eYwGtcNm+9ey6gCfckU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SR/pzx+On24E0Ot+u0pgVBAGfDOvL9fCRQhEQU96vEEaxTg/qrG1t/IeIGzwmXZT5
	 TJNz+7Ze1lZZs4RVtsYxrNkZrg2788V8bXbPozz03zwCHUo7bW39BhGcO7KlWsxh7N
	 SGvwQ9xXg4GxmtAUEI3lrKxc8pDIzu8V8Uc5v6dFTt76T8i356duASZcbKrxGrBajb
	 pbZVljGhTjHbKVXu4+EDp8KdF3Gp3EZmFQDLKOaYap+fgAkEH22niFTrnaGQ4RTVnJ
	 NGOxDFOQcytRH1cRqIfbiHiYMSOgFFxiRix9j1hphQi512TREKMk8fzKpSzEgUQF3t
	 7i6ylX2/gyhjw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yeoreum Yun <yeoreum.yun@arm.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	David Wang <00107082@163.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/4] perf: Fix dangling cgroup pointer in cpuctx
Date: Fri, 21 Aug 2026 00:23:38 -0400
Message-ID: <20260821042339.2534361-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821042339.2534361-1-sashal@kernel.org>
References: <2026081731-publisher-ship-c8bd@gregkh>
 <20260821042339.2534361-1-sashal@kernel.org>
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
index c8a34a19a47fc..07cb8a2d048b3 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2110,18 +2110,6 @@ list_del_event(struct perf_event *event, struct perf_event_context *ctx)
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
 
@@ -2469,6 +2457,10 @@ __perf_remove_from_context(struct perf_event *event,
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


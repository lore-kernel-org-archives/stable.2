Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9289131715B
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 14:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783607406; cv=none; b=JuQcdKsJ7byVeF+1Auv7tuqrDsBqp27Javl8hNA9/BkK0bztNv1a9jwQ3X/i0tBlCbGtvcb2nQtLbIPut1NbL52YfYZyPQDLJvkCtJhrRgQtKmd69D8VpNb85mpyF2Pv2m4HIMrxHpr2VnFy2TjJ7SFmk0FvM36DbWCLTHDyngQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783607406; c=relaxed/simple;
	bh=EX96KbAAlvGiO07dFoY1eGvM813//hjk3jOsJGyQMy8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dsWJ5pw5WlzW3/aiVcBdyIW+6Mjnm1BHBc1vlk1nVmpzgLHnN3d2PZxnZNsBavM9+NNix7hKSad66cz9xDLruCiml6A6xcVe7dinS7v0WiG7Re3fIdlqbx3QgSVXiniJhRmDC7l+r592GJjE3xndhdRXQGB+uzp4/YNXcZ+n9hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theori.io; spf=pass smtp.mailfrom=theori.io; dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b=BZDSTi6W; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theori.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theori.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b="BZDSTi6W"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ca70925c25so26821415ad.1
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 07:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theori.io; s=google; t=1783607404; x=1784212204; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N2EVzBOjNg/Bnd68FOAqniWlfmqjL7EQnrstt79DR3M=;
        b=BZDSTi6WjHx3FcEPeTIR9Ap/ej2EeiqP0ktYlE3EvsfMel7dCXLtUX8/vniG5Qvypk
         CoK3xgR6dL6JnZTbaSSYJZ5fwj5m7ipR7YM14FKoy0vDUlEJGuTLaa5gVUH9YjeRnQV2
         hkqotgDUlf5JvUQFjaq3F8fqA8J0nVIKQgKp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783607404; x=1784212204;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N2EVzBOjNg/Bnd68FOAqniWlfmqjL7EQnrstt79DR3M=;
        b=FfBhbaZTEyX3rT7CS7pfmvponqOsdoLTYmsvYpbZLn8nE8OnpaHJWO9nf4Smy1URb4
         RQlnF6EzEG7Go1YeGbKM9sz5+7s2r0yU2rcMXXKQ4k3uhIJKx9GPJHNH4MDmnZKUp+hw
         uMZVC0F3U9L+cDdTRMq2BCMhartistIdCUBizUET0CviyXPFUtusRygSt5ZQa2d7wxAQ
         j32yUBQ2xyd5nO3JYeroyfhR4duu2X6MJdMBqJ70v3v588Ov5Fpr6uHJ3CFd9C1B1f4d
         cLWXJkCuImjaJH4RUYGamdfkwx2Gm4dpryzBdXyzTNoQiyuoTkxxv5gPnXrJ9oc5kyri
         v3lA==
X-Gm-Message-State: AOJu0YzSUfYnzauqJwT5BveQJf34OhglSblsPg2tAR7TIPLfNOYrMudR
	dcaFat+yfnoGFJ6EG5yrSTTfWuvsMj79/oEe2AYg4FcGwVdkntOM2xML0v40oTryvpI24Qet1IP
	Z+A22
X-Gm-Gg: AfdE7cnt/Ci6e/vfGEujArq+0hkj1NQkZGcKP9nyezsUUn7hwqJrlWsTSFSriWn3dvr
	JBeBXSgYYOz0lkA/6hmc3H1Cv2NpeHx7pXl7bbpFlbW3bB1/Tu8LCstz06h2cTNE5/+mIsgE73x
	jHItRwqGFpdAqxmyp8GVeUVpCzapTVzC+q/MrEdT3QuFlEL2/iAl/+LHBHlUVeqGQkHJI7p7R7U
	Ud77HeNUP9DdnC/sPNeSjE7ai70ruIRY203WEwMvMSGx2XsZ/qf+x1qv5TGQ89D2CpY6WeLqUuN
	E9FIFTJ6p9Gd443smblXmiq/WXMtsKoYHp7d4JD2pmV3fwUWe0E5qEsSWgFrS3/WeEmh5g2B9m8
	W/9/AM/9DsxRgDA1J6vvJ10CL7A568WUl/8N6S6hjLAr0vbT7WDHWVGfCn/PNderRcFk2+gMEwu
	EJMgBadYX01f3CR5Y+YaCC1qhkQ4OL4WJE4Tr7dKNHwrSweZLjI7d3xAPMTw8Ea4LHV8I=
X-Received: by 2002:a17:903:3c30:b0:2c9:e9c4:82c1 with SMTP id d9443c01a7336-2ccea348b05mr80555255ad.26.1783607403713;
        Thu, 09 Jul 2026 07:30:03 -0700 (PDT)
Received: from Taeyangs-MacBook-Pro.local ([59.6.107.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccf797ebc4sm19121075ad.83.2026.07.09.07.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 07:30:03 -0700 (PDT)
Date: Thu, 9 Jul 2026 23:29:58 +0900
From: Taeyang Lee <0wn@theori.io>
To: stable@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 6.6.y] perf/core: Detach event groups during remove_on_exec
Message-ID: <ak-wZqvIG4SxKA_2@Taeyangs-MacBook-Pro.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

[ Upstream commit 037a3c43edfb597665dd34457cd22b14692f2ba3 ]

perf_event_remove_on_exec() removes events by calling
perf_event_exit_event(). For top-level events, this removes the event from
the context with DETACH_EXIT only.

This can leave inconsistent group state when a removed event is a group
leader and the group contains siblings without remove_on_exec. If the group
was active, the surviving siblings can remain active and attached to the
removed leader's sibling list, but are no longer represented by a valid
group leader on the PMU context active lists.

A later close of the removed leader uses DETACH_GROUP and can promote the
still-active siblings from this stale group state. The next schedule-in can
then add an already-linked active_list entry again, corrupting the PMU
context active list.

With DEBUG_LIST enabled, this is caught as a list_add double-add in
merge_sched_in().

Fix this by detaching group relationships when remove_on_exec removes an
event. This preserves the existing task-exit and revoke behavior, while
ensuring surviving siblings are ungrouped before the removed event leaves
the context.

Fixes: 2e498d0a74e5 ("perf: Add support for event removal on exec")
Signed-off-by: Taeyang Lee <0wn@theori.io>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/ai65GgZcC0LAlWLG@Taeyangs-MacBook-Pro.local
---
 kernel/events/core.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index a4187dea6402..d1f6f37ce0ec 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4450,7 +4450,8 @@ static void perf_event_enable_on_exec(struct perf_event_context *ctx)
 
 static void perf_remove_from_owner(struct perf_event *event);
 static void perf_event_exit_event(struct perf_event *event,
-				  struct perf_event_context *ctx);
+				  struct perf_event_context *ctx,
+				  unsigned long detach_flags);
 
 /*
  * Removes all events from the current task that have been marked
@@ -4477,7 +4478,7 @@ static void perf_event_remove_on_exec(struct perf_event_context *ctx)
 
 		modified = true;
 
-		perf_event_exit_event(event, ctx);
+		perf_event_exit_event(event, ctx, DETACH_GROUP);
 	}
 
 	raw_spin_lock_irqsave(&ctx->lock, flags);
@@ -13231,10 +13232,11 @@ static void sync_child_event(struct perf_event *child_event)
 }
 
 static void
-perf_event_exit_event(struct perf_event *event, struct perf_event_context *ctx)
+perf_event_exit_event(struct perf_event *event,
+		      struct perf_event_context *ctx,
+		      unsigned long detach_flags)
 {
 	struct perf_event *parent_event = event->parent;
-	unsigned long detach_flags = 0;
 
 	if (parent_event) {
 		/*
@@ -13249,7 +13251,7 @@ perf_event_exit_event(struct perf_event *event, struct perf_event_context *ctx)
 		 * Do destroy all inherited groups, we don't care about those
 		 * and being thorough is better.
 		 */
-		detach_flags = DETACH_GROUP | DETACH_CHILD;
+		detach_flags |= DETACH_GROUP | DETACH_CHILD;
 		mutex_lock(&parent_event->child_mutex);
 	}
 
@@ -13329,7 +13331,7 @@ static void perf_event_exit_task_context(struct task_struct *child)
 	perf_event_task(child, child_ctx, 0);
 
 	list_for_each_entry_safe(child_event, next, &child_ctx->event_list, event_entry)
-		perf_event_exit_event(child_event, child_ctx);
+		perf_event_exit_event(child_event, child_ctx, 0);
 
 	mutex_unlock(&child_ctx->mutex);
 
-- 
2.50.1 (Apple Git-155)


Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7653BB661;
	Mon, 10 Aug 2026 10:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786357788; cv=none; b=WTqctul64eK0u7sltLVlEDQicHFmjGW1ZsWIam/mcKVkEhxlwd3dLd2mAJeC46dE6/H0VCBvXmBVd1BM8qyBS+TqcYSUqI6iSk53VRJxEvJsZEqhGdDyFcCvOYtyKcuRPd6a0TWC8Fco/c46PmoYw8Rd95Yt8vbPnh91GpJ8A78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786357788; c=relaxed/simple;
	bh=Jrz/0Mi1KDudm1X4N+8HXr518Cv0ABG2tzDbyTUyLOI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hx5CtRGWeu/Jsi2ZQwndfgHREup3bD3Czvs7/PjjXzUfU/FW6cijZV24D1cwKzt60DTbyA5BaCZCoV17Ikk539PJFv6gB34qIzChbIMHkIBq6c5PiYjGwML6DLBf0MOkh3B4Rb2TN4z1LXYLOq6gOHqorY6bIMGPYeMcw+kRJOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CfzOeWJU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NP9ngm31; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CfzOeWJU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NP9ngm31"
Date: Mon, 10 Aug 2026 10:29:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1786357784;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/8Tg+mYeIYMcs8RViJlFm1FNqAfhEeIw0T3zREV+C4g=;
	b=CfzOeWJUHubM/lOvC6WiCpVOeRqs8j9D0kb1cGSEezsFGFeKh+tr/9RiBJ2tXQ1PQhyAv7
	bMkyYgUlvw/8WZCiH8JysBs7+FHs65btzw0SpuITzl33i2qhT3E/vblCV4tshJ9Fbsspd2
	LjKlhX4tgedwUFrztlLk/MNs6IJNTmnF8d7nO/YYmj+ZZ+iB3q5OBrBTgHh3D370R04qVy
	qeVcBWFg0UOkbsub+MyIq88n+dD5Tv/960/UELOz04JyVSkF8qy+2gSki7bqKVad+/2aTz
	61L1yvs9uODsx+qQylFCoWP73/ybCVsxjCICTQC7K88xO+vrra1qbgNmtpoRcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1786357784;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/8Tg+mYeIYMcs8RViJlFm1FNqAfhEeIw0T3zREV+C4g=;
	b=NP9ngm31nZ+6Nu+T4zTB/RS9uT/vpXr8nea3FmBWcLsw6Y/gDfLS/87v/QSWnB1maSt/T3
	hG9W4xRXKaiGkeDg==
From: "tip-bot2 for Aditya Chillara" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/core: Fix group leader use-after-free after
 sibling detach
Cc: Aditya Chillara <aditya.chillara@oss.qualcomm.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <20260807-fix-group-leader-uaf-v3-1-b0c2310c9a0d@oss.qualcomm.com>
References: <20260807-fix-group-leader-uaf-v3-1-b0c2310c9a0d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178635778253.442315.7332324220762220623.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     42c5ca1f0a288a52878bd72a5595b08261057438
Gitweb:        https://git.kernel.org/tip/42c5ca1f0a288a52878bd72a5595b082610=
57438
Author:        Aditya Chillara <aditya.chillara@oss.qualcomm.com>
AuthorDate:    Fri, 07 Aug 2026 18:11:52 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 07 Aug 2026 18:27:05 +02:00

perf/core: Fix group leader use-after-free after sibling detach

perf_group_detach() handles leader and sibling detach differently. When the
group leader is detached, all siblings are promoted to singleton events and
their group_leader pointer is reset to themselves. When a sibling is
detached, it is removed from the leader's sibling_list, but its
group_leader pointer is left pointing at the old leader.

That is harmless when the sibling is being closed and freed immediately, as
in the DETACH_DEAD path. It is not safe when the sibling is detached but
kept alive, such as during CPU hotplug with DETACH_GROUP. In that case the
sibling is removed from the context, while its file descriptor can still
keep it alive.

A typical failing sequence is:

  - A group contains leader L and sibling S.
  - CPU hot-unplug detaches S with DETACH_GROUP, removing it from
    L->sibling_list but leaving S->group_leader =3D=3D L.
  - L is later closed and freed.
  - A PERF_IOC_FLAG_GROUP ioctl on S follows S->group_leader and
    dereferences the freed leader.

This was reproduced by running the perf event fuzzer, CPU hotplug, and a
stress workload concurrently:

  Unable to handle kernel paging request at virtual address 006b6b6b6b6b6cdb
  CPU: 2 PID: 12489 Comm: perf_fuzzer 6.18.7 PREEMPT
  pc : perf_ioctl+0x34c/0xc68
  x20: ffffff89a3fa2c70 x8 : 6b6b6b6b6b6b6b6b
  Code: 943c4a0e 340047a0 f9404a94 f9411e88 (f940b908)
  Call trace:
  perf_ioctl+0x34c/0xc68 (P)
  __arm64_sys_ioctl+0xa0/0xf4
  invoke_syscall+0x58/0xe4
  el0_svc_common+0xa8/0xdc
  do_el0_svc+0x1c/0x28
  el0_svc+0x40/0xc0
  el0t_64_sync_handler+0x68/0xdc
  el0t_64_sync+0x1c4/0x1c8

The fault happened in perf_ioctl(), where perf_event_for_each() follows
the stale group_leader pointer and perf_event_for_each_child() then
dereferences the freed leader's context.

Fix the use-after-free by promoting the detached sibling to a singleton.
Also fix __event_disable() cgroup accounting and event state change.

Fixes: 8a49542c0554 ("perf_events: Fix races in group composition")
Assisted-by: PatchWise:gpt-5.5
Signed-off-by: Aditya Chillara <aditya.chillara@oss.qualcomm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260807-fix-group-leader-uaf-v3-1-b0c2310c9a0=
d@oss.qualcomm.com
---
 kernel/events/core.c | 67 +++++++++++++++++++++++--------------------
 1 file changed, 37 insertions(+), 30 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index bd25e19..1a73ba0 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2343,6 +2343,34 @@ static inline struct list_head *get_event_list(struct =
perf_event *event)
 				    &event->pmu_ctx->flexible_active;
 }
=20
+/* @sibling must already be unlinked from its old leader's sibling_list. */
+static void perf_promote_sibling_to_leader(struct perf_event *sibling,
+					   struct perf_event_context *ctx,
+					   int group_caps)
+{
+	/*
+	 * Events that have PERF_EV_CAP_SIBLING require being part of
+	 * a group and cannot exist on their own, schedule them out
+	 * and move them into the ERROR state. Also see
+	 * _perf_event_enable(), it will not be able to recover this
+	 * ERROR state.
+	 */
+	if (sibling->event_caps & PERF_EV_CAP_SIBLING)
+		__event_disable(sibling, ctx, PERF_EVENT_STATE_ERROR);
+
+	sibling->group_leader =3D sibling;
+	sibling->group_caps =3D group_caps;
+
+	if (sibling->attach_state & PERF_ATTACH_CONTEXT) {
+		add_event_to_groups(sibling, ctx);
+
+		if (sibling->state =3D=3D PERF_EVENT_STATE_ACTIVE)
+			list_add_tail(&sibling->active_list, get_event_list(sibling));
+	}
+
+	perf_event__header_size(sibling);
+}
+
 static void perf_group_detach(struct perf_event *event)
 {
 	struct perf_event *leader =3D event->group_leader;
@@ -2366,8 +2394,9 @@ static void perf_group_detach(struct perf_event *event)
 	 */
 	if (leader !=3D event) {
 		list_del_init(&event->sibling_list);
-		event->group_leader->nr_siblings--;
-		event->group_leader->group_generation++;
+		leader->nr_siblings--;
+		leader->group_generation++;
+		perf_promote_sibling_to_leader(event, ctx, event->event_caps);
 		goto out;
 	}
=20
@@ -2377,32 +2406,14 @@ static void perf_group_detach(struct perf_event *even=
t)
 	 * to whatever list we are on.
 	 */
 	list_for_each_entry_safe(sibling, tmp, &event->sibling_list, sibling_list) {
-
-		/*
-		 * Events that have PERF_EV_CAP_SIBLING require being part of
-		 * a group and cannot exist on their own, schedule them out
-		 * and move them into the ERROR state. Also see
-		 * _perf_event_enable(), it will not be able to recover this
-		 * ERROR state.
-		 */
-		if (sibling->event_caps & PERF_EV_CAP_SIBLING)
-			__event_disable(sibling, ctx, PERF_EVENT_STATE_ERROR);
-
-		sibling->group_leader =3D sibling;
 		list_del_init(&sibling->sibling_list);
=20
 		/* Inherit group flags from the previous leader */
-		sibling->group_caps =3D event->group_caps;
-
-		if (sibling->attach_state & PERF_ATTACH_CONTEXT) {
-			add_event_to_groups(sibling, event->ctx);
-
-			if (sibling->state =3D=3D PERF_EVENT_STATE_ACTIVE)
-				list_add_tail(&sibling->active_list, get_event_list(sibling));
-		}
+		perf_promote_sibling_to_leader(sibling, ctx, event->group_caps);
=20
 		WARN_ON_ONCE(sibling->ctx !=3D event->ctx);
 	}
+	event->nr_siblings =3D 0;
=20
 out:
 	for_each_sibling_event(tmp, leader)
@@ -2592,12 +2603,7 @@ __perf_remove_from_context(struct perf_event *event,
 	if (flags & DETACH_DEAD)
 		state =3D PERF_EVENT_STATE_DEAD;
=20
-	event_sched_out(event, ctx);
-
-	if (event->state > PERF_EVENT_STATE_OFF)
-		perf_cgroup_event_disable(event, ctx);
-
-	perf_event_set_state(event, min(event->state, state));
+	__event_disable(event, ctx, state);
=20
 	if (flags & DETACH_GROUP)
 		perf_group_detach(event);
@@ -2666,8 +2672,9 @@ static void __event_disable(struct perf_event *event,
 			    enum perf_event_state state)
 {
 	event_sched_out(event, ctx);
-	perf_cgroup_event_disable(event, ctx);
-	perf_event_set_state(event, state);
+	if (event->state > PERF_EVENT_STATE_OFF)
+		perf_cgroup_event_disable(event, ctx);
+	perf_event_set_state(event, min(event->state, state));
 }
=20
 /*

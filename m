Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7655934FF41
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 19:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787081461; cv=none; b=YrPoN5nwlg4/7tSMjCDm9gWQmr7mthQ5rsC0BAUgbRvKEKEAanew6pDpCQvbkxzrsOL7CB/SaE7XNRU6taJPn6upTQEW+RRXgIYFUKmdRqpksapTujsZdzGv/00l942k/naPer9LzysACvdC+k4S3j8wlxWszf8QidhgDNcu2ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787081461; c=relaxed/simple;
	bh=K0t0xsyyBbxjWYnT1FWBwMxKCp9zEFYncLifivS5/8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cg9SObhh8L4UfORWfKcptH+QoLKm+qK7pj/u+Qz4vQkt7NtaREuIdRGmwA4d+JZa+fGXAsedwnO5m+Mf/yrMHQTau569lUoc+513bDGJ6k0h+b8lIvg0AGMa27H6elKx02C+1T3pZg25nfunzhIwMpv5xcCK4SDPLPPYcI07Uu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AmMWcqSp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmMWcqSp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 995651F00A3A;
	Tue, 18 Aug 2026 19:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787081459;
	bh=ANfWjOGhNPMUwGsbepLhgn45a1xRlpBgIOP3HRdnTys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AmMWcqSpmY5DyRFEoGvRdz+NfmtHyB+k8FrCen/wZQNCJmFXFaxH9IaMG9iGeqqHn
	 TgFvZEpdF/Tv3RFoQZ2vmeWBOBDk/OJ3/Ad7ALzI6mTO76h0yQxREQEh1VgalQAMRZ
	 wOFc0aW7vF/RBv5UXbjw/Z/fCt0J6EvvocwYPX+sMHmhkEh4fznsgW/3yLCxE/ZYaL
	 bPLeKTuiUtDKorrwBbfme+CSsHHJFN1i0CyiP9svnwpPvfvUcPiiWEyr+nJd8eD0eu
	 PLN0vIZvSmm43yDVylnvxvGLdDewvTzI6qNH3rznyQzUx1+IKqKxrEEsdM7xgOIH9b
	 Y4CgE3EElvR8A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Sashiko AI <sashiko-bot@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Matt Fleming <mfleming@cloudflare.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] sched/psi: Shut down rtpoll_timer in psi_cgroup_free()
Date: Tue, 18 Aug 2026 15:30:56 -0400
Message-ID: <20260818193056.3302866-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026081706-verdict-hangout-e22e@gregkh>
References: <2026081706-verdict-hangout-e22e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tejun Heo <tj@kernel.org>

[ Upstream commit 5457025fa8ca3c0d2732109513de839e3e797190 ]

psi_schedule_rtpoll_work() is called locklessly from the scheduler hotpath
and can race psi_trigger_destroy() taking down the last rtpoll trigger under
rtpoll_trigger_lock:

  psi_schedule_rtpoll_work()        psi_trigger_destroy()

  rcu_read_lock();
  task = rcu_dereference(rtpoll_task);
                                    rcu_assign_pointer(rtpoll_task, NULL);
                                    timer_delete(&rtpoll_timer);
  mod_timer(&rtpoll_timer, ...);
  rcu_read_unlock();
                                    synchronize_rcu();
                                    kthread_stop(task_to_destroy);

The group can then be freed with the re-armed timer still pending, and
poll_timer_fn() runs on freed memory.

461daba06bdc ("psi: eliminate kthread_worker from psi trigger scheduling
mechanism") deleted the timer synchronously after the synchronize_rcu(),
which prevented this but raced trigger creation instead: the deletion could
cancel the timer that a new trigger set armed during the grace period and,
as creation also reinitialized the timer at the time, corrupt it.
8f91efd870ea ("psi: Fix race between psi_trigger_create/destroy") moved the
initialization into group_init() and the deletion into the locked section,
trading the creation races for the window above.

Neither placement in the destruction path works. A pending timer firing
while the group is alive is harmless though. poll_timer_fn() just wakes the
rtpoll waitqueue and doesn't re-arm itself. Bind the timer to the group's
lifetime instead and shut it down in psi_cgroup_free(). Nothing can arm it
by then. timer_shutdown_sync() because the timer is never armed again.

Fixes: 8f91efd870ea ("psi: Fix race between psi_trigger_create/destroy")
Cc: stable@vger.kernel.org # v5.10+
Reported-by: Sashiko AI <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260711000434.36C4A1F000E9@smtp.kernel.org/
Signed-off-by: Tejun Heo <tj@kernel.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Tested-by: Matt Fleming <mfleming@cloudflare.com>
Acked-by: Suren Baghdasaryan <surenb@google.com>
[ adapted `cgroup->psi->` pointer dereference to embedded `cgroup->psi.` and renamed `rtpoll_*` members back to `poll_*` ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/psi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index fa88bf6ccce0..a7bac5fe2994 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -972,6 +972,12 @@ void psi_cgroup_free(struct cgroup *cgroup)
 		return;
 
 	cancel_delayed_work_sync(&cgroup->psi.avgs_work);
+	/*
+	 * A psi_schedule_poll_work() call racing the last trigger's
+	 * destruction may have re-armed the timer after psi_trigger_destroy()
+	 * deleted it. Spurious firing while the group is alive is harmless.
+	 */
+	timer_shutdown_sync(&cgroup->psi.poll_timer);
 	free_percpu(cgroup->psi.pcpu);
 	/* All triggers must be removed by now */
 	WARN_ONCE(cgroup->psi.poll_states, "psi: trigger leak\n");
-- 
2.53.0


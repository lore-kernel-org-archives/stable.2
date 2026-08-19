Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F740343D63
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 11:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787138103; cv=none; b=tTBFL2qFuHd/HYDwSSw4kO18ooqny78kxRUIxJtKTyOc+lx0sWePGVOWY+mmR/NNs09b9AuitxByGFTBDBF4T3mvudVB9Zqufs9OG3Kj1NkLpKIw21xNK3p7t8fL53SNuBR8McE9Jg9RD7gTmKZo3B2AyLxnVGaX3XhDaCaT5kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787138103; c=relaxed/simple;
	bh=EoJWtthd+4OSZhxbmxJVrglXe7LW+4OYSSlTB2Yl7Z0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lIrJDSAHhUqRjuf9pF1J0SSKXSvws0ls82bk5Io5/UEcfWo9MfevoxvsrtWdmzYwaj4XlI/deTjSAyHXINnGCyvn+i2RVYVCGNS/IE1/XfYA2oE4vp545swOA04u9+UXwsxW8dXSaQzdNjDyiRx1GzLhVOGVKJvC7e4g6sCo6f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kk3pCJZr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kk3pCJZr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F8FE1F000E9;
	Wed, 19 Aug 2026 11:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787138102;
	bh=6Msi2tYJ1tpG8IboBmQH6ftOt+pePQWrno8/HEV62Fo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Kk3pCJZrglvSiAw4IloF1AKCb2Vfuhgf5uCcJztJFu9DyXBTEE1RiWrckifxG87py
	 ZxkKgDNCPhoMGKYQy7AkUaJPDyDqBHaoIHecfQb3dznBjCW1CFcIrsIc9RkZQVN2l4
	 tXFnRmf55A703HKrbAdKntpt0IZC5wUotLMGivmtj3pHsw/K8igLf0HiZor98uxr1N
	 7IyqL8GoaUKQ9gKvz2/0GlXYlAt2bz2QgwgZjbyYXxU3K5VmhrKqA73+yxMk2hQ9Gg
	 4phEbRS34uyT8TQvAdIWj2ToqbWJyUENZr4OCNlGCmO+JdFTQr6PZVQOC6Z+TsYS1b
	 wn9uTI5nLKNfQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Sashiko AI <sashiko-bot@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Matt Fleming <mfleming@cloudflare.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] sched/psi: Shut down rtpoll_timer in psi_cgroup_free()
Date: Wed, 19 Aug 2026 07:14:59 -0400
Message-ID: <20260819111459.3552196-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026081707-cozy-flier-448d@gregkh>
References: <2026081707-cozy-flier-448d@gregkh>
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
[ Adapted `cgroup->psi->` to embedded `cgroup->psi.`, `rtpoll_timer` to `poll_timer`, and `timer_shutdown_sync()` to `timer_delete_sync()`. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/psi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index debaeb07ae53..f31ae8834775 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -950,6 +950,12 @@ void psi_cgroup_free(struct cgroup *cgroup)
 		return;
 
 	cancel_delayed_work_sync(&cgroup->psi.avgs_work);
+	/*
+	 * A psi_schedule_poll_work() call racing the last trigger's
+	 * destruction may have re-armed the timer after psi_trigger_destroy()
+	 * deleted it. Spurious firing while the group is alive is harmless.
+	 */
+	timer_delete_sync(&cgroup->psi.poll_timer);
 	free_percpu(cgroup->psi.pcpu);
 	/* All triggers must be removed by now */
 	WARN_ONCE(cgroup->psi.poll_states, "psi: trigger leak\n");
-- 
2.53.0


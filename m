Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1122441E6B2
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 13:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786972320; cv=none; b=sU+II9FRIKqF+R/u/6FmCFrcdm8J3Jf2/F7Pi9oEUpX9O8CnBaaTj4ncDNXNcv+HSMgynwXb0Abmv6daQcaVbe/4M4PPFY798M3PGEn6dWJzb23vijreYgyNcbfIbIZ5kpiN9YIn1lx7oK4SKf4NfamfKH0/eQ2jl8qlLSSu2IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786972320; c=relaxed/simple;
	bh=DHxX/ZH8zfRemdWk2Fr1v4RWS4fX6EvRVrxn6MdiqQs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hkxaJO3hyzlRFefK6vjDE8Qatah34Q8Gg3Cxo0efpBtRYmG4RDsOYWUXwzeUP92XOjH56iRZn4MVlWc/TcR9ALiUmhB2wUYnzAjtvKNy3FIt9H/RKGCpAnmk7JiCzvgPuoLg5CySowbua16/pFwMNmrQ0OKgzXArseC/39mEbYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0WsNzuQT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0WsNzuQT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF041F00A3A;
	Mon, 17 Aug 2026 13:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786972316;
	bh=SkQcsJdhCa/HYTNoIEMGedmAlxyVNJMUVG9Lo/ohQhA=;
	h=Subject:To:Cc:From:Date;
	b=0WsNzuQTqBGzoPtQvS+1K28fJNOGcml4GX7rsDHXD+/eK/jkqFezLhsD/oJV0M4BG
	 wYUkY6q3zrJrPnW/bwW0uoCYc2uOVwi5alTJAWVkZQQKav2lx3EPC+aphKgSojcYCo
	 cRPlkgTk4QUzq+WqyVQYtSj/7JutqZ6NA18zybEg=
Subject: FAILED: patch "[PATCH] sched/psi: Shut down rtpoll_timer in psi_cgroup_free()" failed to apply to 5.15-stable tree
To: tj@kernel.org,hannes@cmpxchg.org,mfleming@cloudflare.com,sashiko-bot@kernel.org,surenb@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 17 Aug 2026 14:59:06 +0200
Message-ID: <2026081706-verdict-hangout-e22e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 5457025fa8ca3c0d2732109513de839e3e797190
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026081706-verdict-hangout-e22e@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5457025fa8ca3c0d2732109513de839e3e797190 Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Sun, 12 Jul 2026 07:23:55 -1000
Subject: [PATCH] sched/psi: Shut down rtpoll_timer in psi_cgroup_free()

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

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 565ec7b80743..e2e825dcd088 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -1134,6 +1134,12 @@ void psi_cgroup_free(struct cgroup *cgroup)
 		return;
 
 	cancel_delayed_work_sync(&cgroup->psi->avgs_work);
+	/*
+	 * A psi_schedule_rtpoll_work() call racing the last trigger's
+	 * destruction may have re-armed the timer after psi_trigger_destroy()
+	 * deleted it. Spurious firing while the group is alive is harmless.
+	 */
+	timer_shutdown_sync(&cgroup->psi->rtpoll_timer);
 	free_percpu(cgroup->psi->pcpu);
 	/* All triggers must be removed by now */
 	WARN_ONCE(cgroup->psi->rtpoll_states, "psi: trigger leak\n");


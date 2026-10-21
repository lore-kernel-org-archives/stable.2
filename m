Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792594934;
	b=BUgXgehSAvvN6VwQIMls4zSlsHJyhwPyaiQcAxyrOKBnzfSuoseu5Uia3tDDPClQvIc+
	 wA3ijDxlDHtdtCQLUb2KHWHMPXDcZnBn46sBVagIpyQy+LucnUvGgkXnKE4uFUyRECEwE
	 FNWD354XpySzvncRgeMNIKCU8cyaM+gJ0SSMV+8Ymq28/aXk9E78huYg4GG/FUOWb23La
	 /euNY9ThwkKtuImsbfcQbk0DmC38fCrRhOd62pRjoGm2eA0Zdm4XTj8oSMcE3bP0ywEJl
	 RIoSVKNyKN4fwVlYpD+L6AtgChTB3yK+DwAfuYEzqWFPuqOboNOSg29sgzOARHpPldw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792594934;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=rT0lcj78m3hKLq1gI4Qh637rM2DKuQ8cAxTfZ+P58Po=;
	b=SzjfDHiBYrsLAJSL+oEVbKKCussw2PIQei2GafIworh0hSjgS1DEaHVxw2/EE49AGSZ6
	 SlUCGRMO2hpFUXgSE5o2P0FQ0d7qEIaX307jSlXATqk1Ndx2ZSkdoQrz5jQretujv2Ljj
	 JCM+ypDlF9u2RyyepZRfe7mBrCyDUR0DrqTbshOCZidrFSytRfmpPg8J4lj30esoQsMTP
	 cdRuAmF6UVF+sLCFl/hBf4rOj5PwGNTKFebJDLcoXqDG2CSTPo1ZWZrL8i6vHQP29ROEM
	 IBhjBDaxlWcozna7UFsFxXTtvtRFYhk3veFf996xXoXoDoFlkeYmscZwwqvTIQVRaGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="dUh/9HPU";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CCF606A319
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 15:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=dUh/9HPU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E94C51F000C1;
	Wed, 21 Oct 2026 15:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792594933;
	bh=rT0lcj78m3hKLq1gI4Qh637rM2DKuQ8cAxTfZ+P58Po=;
	h=Subject:To:Cc:From:Date;
	b=dUh/9HPU1jTd1sqKvtLfeJsqecpZpilhmQwGRl8u7luLv+v7V1/GcEu3i9jyHKaWW
	 L0mWC8TlXCcYrQWkDcIkFnvx/MImexFkP5jQzx4g/IhHZNJN3jvJ0AfnDPFCq3ZTRg
	 k2zvqhmXSDY7/N6t55K1pDUZ6qVdnFBjxt4CixSw=
Subject: FAILED: patch "[PATCH] sched_ext: Fix stall when a task enqueued with SCX_ENQ_LAST" failed to apply to 6.12-stable tree
To: tj@kernel.org,schatzberg.dan@gmail.com,xbu@meta.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 Oct 2026 16:50:01 +0200
Message-ID: <2026102101-kilogram-periscope-454b@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 7a9df76679633cf26e0fea882a684012c6ec245a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102101-kilogram-periscope-454b@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7a9df76679633cf26e0fea882a684012c6ec245a Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Wed, 7 Oct 2026 06:26:47 -1000
Subject: [PATCH] sched_ext: Fix stall when a task enqueued with SCX_ENQ_LAST
 lands back on its CPU's local DSQ

With SCX_OPS_ENQ_LAST, the last runnable task on a CPU is passed to
ops.enqueue() instead of being kept running. Exiting tasks without
SCX_OPS_ENQ_EXITING, migration disabled tasks without
SCX_OPS_ENQ_MIGRATION_DISABLED and tasks on an offline rq skip ops.enqueue()
and go straight to the local DSQ. This happens in put_prev_task_scx() after
the pick has settled on idle, so nothing reschedules the CPU, which idles
with the task queued until an unrelated wakeup lands on it or the watchdog
fires.

scx_mitosis, which sets SCX_OPS_ENQ_LAST without SCX_OPS_ENQ_EXITING, hit
this during mass cgroup teardown: exiting tasks stuck in exit_mmap() for
over 40 seconds.

A task put on the local DSQ runs, as anywhere else. If the SCX_ENQ_LAST
enqueue left the task on this CPU's local DSQ, set need_resched on the task
being switched in, as proxy_resched_idle() does. resched_curr() would flag
the task being put instead, and __schedule() clears that right after the
pick.

Fixes: f0e1a0643a59 ("sched_ext: Implement BPF extensible scheduler class")
Cc: stable@vger.kernel.org # v6.12+
Reported-by: Xiangyu Bu <xbu@meta.com>
Link: https://github.com/sched-ext/scx/pull/3870
Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Dan Schatzberg <schatzberg.dan@gmail.com>

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index ac8fe70a9fb6..64d937fb2b24 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -3213,8 +3213,7 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 		/*
 		 * If @p is runnable but we're about to enter a lower
 		 * sched_class, %SCX_OPS_ENQ_LAST must be set. Tell
-		 * ops.enqueue() that @p is the only one available for this cpu,
-		 * which should trigger an explicit follow-up scheduling event.
+		 * ops.enqueue() that @p is the only one available for this cpu.
 		 * This doesn't apply if the baseline access on the CPU is lost.
 		 *
 		 * Under core scheduling, a pick dispatches only when nothing is
@@ -3226,6 +3225,16 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 			WARN_ON_ONCE(!sched_core_enabled(rq) &&
 				     !(sch->ops.flags & SCX_OPS_ENQ_LAST));
 			scx_do_enqueue_task(rq, p, SCX_ENQ_LAST, -1);
+
+			/*
+			 * A task put on the local DSQ runs, as anywhere else.
+			 * Here the insert can't reschedule on its own: the pick
+			 * has settled on @next and @p is still curr, so
+			 * resched_curr() would flag @p and __schedule() clears
+			 * that right after the pick. Flag @next instead.
+			 */
+			if (p->scx.dsq == &rq->scx.local_dsq)
+				set_tsk_need_resched(next);
 		} else {
 			scx_do_enqueue_task(rq, p, 0, -1);
 		}
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 5b37faa532d6..85579fcabf52 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -1774,8 +1774,9 @@ enum scx_enq_flags {
 	 * %SCX_OPS_ENQ_LAST is specified, they're ops.enqueue()'d with the
 	 * %SCX_ENQ_LAST flag set.
 	 *
-	 * The BPF scheduler is responsible for triggering a follow-up
-	 * scheduling event. Otherwise, Execution may stall.
+	 * If the task is queued on the local DSQ of the CPU it was running on,
+	 * it continues to run. Otherwise, the CPU goes idle. A scheduler that
+	 * wants a full dispatch cycle on the CPU should kick it.
 	 */
 	SCX_ENQ_LAST		= 1LLU << 41,
 


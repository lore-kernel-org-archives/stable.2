Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795603023;
	b=LbfLQ7OpZLgXyAlz0n1Ozk38lkFtZow0AFNzwf3wee/2JsMHCoj5gnFumX1EbCKZ5kme
	 z0J6xOxLIFWX1othI9aYorUGuh4n6Odd/r58q9b9PNz0qd7KHqPTEckNKQ0LNeNXfmPDH
	 Its3rE83RAxPLuLxXVzHcfZLLfh+rCncy1UlLWCppodUTpYU5p1UkDlhAug24itNpabSp
	 bx+dt9VYftSrwbfn6ulnnCB8tjDQL7HzuRdircp6qf/PltSfGJnAPozMn50yaIiAv/mpR
	 WvknfWNIj7MWNE27vSBK4dd7zFPmRPNqGQRMiHKDxB7X87hdnBLcu8ZFh9XIE9xchxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795603023;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=K14Q5jca9V1fy6N4nskzw3+7gvYpKMLd2sc2Zoa4FPs=;
	b=06JI0MbsC27v5E99aLbnhLGBVKFcirUft9VENGj36iEAjvPZ9seUK4tVw7SUlrF7HMN1
	 B1K6KIqRltFgIum9b5BfDdGz5ZA3KXodGhZDx6v9vp/x8aoVRCfFKS2PpJEIXH370Prq0
	 CwAGjTfOss5c0HX9pUYNLcaB6g/z21KaF2iP5pMHhUGmOdlVBKIfffvnnqvY6I+foKqLr
	 oQE2W/HfXvZEBShY3Dv5OjtU2CK6P72CA0qE1UAgj0IkCGoWPoPqon5lh4P80WLRvkHXo
	 ujpQ7ynYFYDTBiZsMEWqOqiHy9A2TM0olJn0hWT9a5cDt9p669Q/rnARI905K1gkBWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=lbVTj1vJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C4F606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=lbVTj1vJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C407C1F000C4;
	Wed, 25 Nov 2026 10:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795603023;
	bh=K14Q5jca9V1fy6N4nskzw3+7gvYpKMLd2sc2Zoa4FPs=;
	h=Subject:To:Cc:From:Date;
	b=lbVTj1vJcqaPc2mQoVI7w//4eMcU+Vn3fLtNI/KhnLKrAGMbzrRD+lGCpKnMmQITj
	 kpSrRC3Tv76Zf4btm8gK9UyWyiNEddaURex8FpFqYoXsKY0XfeuWJhoS0bfCOYwN9O
	 UerwuGWPVYCjQdfUjQZrqIDTc0QhINdhxcyAxUYs=
Subject: FAILED: patch "[PATCH] sched_ext: Factor out drain_offline_rq()" failed to apply to 6.12-stable tree
To: tj@kernel.org,arighi@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:22:17 +0100
Message-ID: <2026112517-tipping-unblessed-bf3f@gregkh>
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
git cherry-pick -x 1826e5aa068cf6c21791773f160b4a2ce5d5f9a5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112517-tipping-unblessed-bf3f@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1826e5aa068cf6c21791773f160b4a2ce5d5f9a5 Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Sat, 31 Oct 2026 07:05:40 -1000
Subject: [PATCH] sched_ext: Factor out drain_offline_rq()

Factor drain_offline_rq() out of rq_offline_scx() so that the drain can move
to handle_hotplug() in the following patch, which removes the rq_online and
rq_offline hooks. The drain is the rescue flush and the re-enqueue of an
offline cpu's tasks onto its local DSQ. No functional change.

Cc: stable@vger.kernel.org # v6.12+
Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Andrea Righi <arighi@nvidia.com>

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index e533c1a5c56d..0d64253569e8 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -2428,7 +2428,7 @@ static void set_task_runnable(struct rq *rq, struct task_struct *p)
 	}
 
 	/*
-	 * list_add_tail() must be used. scx_bypass() and rq_offline_scx()
+	 * list_add_tail() must be used. scx_bypass() and drain_offline_rq()
 	 * depend on tasks being appended to the runnable_list.
 	 */
 	list_add_tail(&p->scx.runnable_node, &rq->scx.runnable_list);
@@ -4314,6 +4314,24 @@ static void set_cpus_allowed_scx(struct task_struct *p,
 		scx_call_op_set_cpumask(sch, task_rq(p), p, (struct cpumask *)p->cpus_ptr);
 }
 
+static void drain_offline_rq(struct rq *rq)
+{
+	struct task_struct *p, *n;
+
+	scx_rescue_flush(rq);
+
+	/*
+	 * An offline CPU no longer calls ops.dispatch(). Re-enqueue its tasks
+	 * onto the local DSQ so that they run here and balance_push() moves
+	 * them off.
+	 */
+	list_for_each_entry_safe_reverse(p, n, &rq->scx.runnable_list, scx.runnable_node) {
+		if (p->scx.dsq == &rq->scx.local_dsq)
+			continue;
+		guard(sched_change)(p, DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK);
+	}
+}
+
 static void handle_hotplug(struct rq *rq, bool online)
 {
 	struct scx_sched *sch = scx_root_protected();
@@ -4401,26 +4419,13 @@ static void rq_online_scx(struct rq *rq)
 
 static void rq_offline_scx(struct rq *rq)
 {
-	struct task_struct *p, *n;
-
 	rq->scx.flags &= ~SCX_RQ_ONLINE;
 
 	/* sched domain rebuilds call rq_offline with the CPU staying alive */
 	if (cpu_active(cpu_of(rq)))
 		return;
 
-	scx_rescue_flush(rq);
-
-	/*
-	 * An offline CPU no longer calls ops.dispatch(). Re-enqueue its tasks
-	 * onto the local DSQ so that they run here and balance_push() moves
-	 * them off.
-	 */
-	list_for_each_entry_safe_reverse(p, n, &rq->scx.runnable_list, scx.runnable_node) {
-		if (p->scx.dsq == &rq->scx.local_dsq)
-			continue;
-		guard(sched_change)(p, DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK);
-	}
+	drain_offline_rq(rq);
 }
 
 static bool check_rq_for_timeouts(struct rq *rq)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 6c7c5633524a..2cc16c01b168 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -4294,7 +4294,7 @@ extern void balance_callbacks(struct rq *rq, struct balance_callback *head);
  * Typically this must be called while holding task_rq_lock, since most/all
  * properties are serialized under those locks. There are currently two
  * exceptions to this rule in sched/ext which only hold rq->lock: scx_bypass()
- * and rq_offline_scx().
+ * and drain_offline_rq().
  */
 
 /*


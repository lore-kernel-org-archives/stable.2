Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2974AA3ED;
	Thu, 15 Oct 2026 08:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792053845; cv=none; b=FXt/BueedcY7JuI986zFiLxNWGvh6ZZPn8lZRx/ZOrrEOrPIEp/aRtHqcDX2UUH8YeNRW0RATh900TKjU0Zl4PUg5yHr/NjKas/isTjwwv4nglZAC+Yr+e7pRdpveJrhzXZ7ZUbv1LMqpzSBgxaKjQcfko5OBtNrvlRsp282CSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792053845; c=relaxed/simple;
	bh=WPymwV48CNE0XbNCkIdQF4sYHFBHkFUXQuJplgqg3m0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IPteP/mLz5EAqGO5WFLOLr4KDGMpiW3nFhS1IQ3kKX+tkwNHrBgmQjZq5DdUEQg1D5WmlwznqwBhvnk3x6xh7aRx7lalSOSDfyn2cR8k6EA42KgM2mv9fKFj5GLYurMRMgvFGlYSmOJQGdtqk2uQCzw9hM7ByPnk3iM5qAYlOg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N5VCMGDW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bhMi+pDh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N5VCMGDW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bhMi+pDh"
Date: Thu, 15 Oct 2026 08:43:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792053834;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+hD/joEpppufLDVKhdccfeos+WhILrdJ4oa82IBwIsQ=;
	b=N5VCMGDWSMxflnSmPkt6nGsnDqIlDg76DlcN8JqvvUCcTcUoGnXWUPimUv//duoXnlradG
	P4VBr3x+e6m6mGvJObqpWF0t847mvBoELNdpOnEe1q9P+wii/54GRd6ssF1c1iYVJ9bqi2
	guXgkSENqfRIJZgnpf/MrXu70sEkM6Shvl2+53rAqy/VDwKPowfDP9N1WJIOCVM/r78bwb
	3Egi4WhTrupeTcaNDv02hJ9025OwUs2aZmun8V/u5C45Zh93sxmId2c+uS85ejDZh6KC37
	VSx9nOKTj2Wsi9AglQlRS8uAPEhAfYrp9JA+NwmOEtseD8VdGHuyU4AoSWVC8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792053834;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+hD/joEpppufLDVKhdccfeos+WhILrdJ4oa82IBwIsQ=;
	b=bhMi+pDhT098tZNmYioK9CSsRhw/c1+qUMHCkPMPQYYPRx6OzT12hV5CFekJEehlt3/Sn3
	jspyMDTfK8ROORBw==
From: "tip-bot2 for Richard Patel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Defer kfree(irqaction) until
 irq_thread_dtor() finishes
Cc: Richard Patel <ripatel@wii.dev>, Thomas Gleixner <tglx@kernel.org>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 maz@kernel.org
In-Reply-To: <20261009145842.1616117-2-ripatel@wii.dev>
References: <20261009145842.1616117-2-ripatel@wii.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <179205383286.2666988.11679524965760153827.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     313fa9ffa302f81b437e1ebbb1e6abae06be0cad
Gitweb:        https://git.kernel.org/tip/313fa9ffa302f81b437e1ebbb1e6abae06b=
e0cad
Author:        Richard Patel <ripatel@wii.dev>
AuthorDate:    Fri, 09 Oct 2026 14:58:41=20
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Thu, 15 Oct 2026 10:38:13 +02:00

genirq: Defer kfree(irqaction) until irq_thread_dtor() finishes

When an interrupt thread exits abnormally via do_exit() (e.g. the interrupt
handler oopses) without returning from irq_thread(), a concurrent call to
free_irq() could free the irqaction before the irq_thread_dtor() exit task
work runs.

  irq thread (oopsed)                 free_irq()
  -------------------                 ----------
  do_exit()
    exit_mm()
      complete_vfork_done()  -------> kthread_stop() returns
    exit_files() ...                  kfree(action)
    exit_task_work()
      irq_thread_dtor()
        action->...                   <- use-after-free

Track the pending exit work with the IRQTF_EXIT_WORK thread flag, and have
__free_irq() wait for the bit to clear before kfree().

irq_thread_dtor() only runs on irq_thread abnormal exit. If that dtor also
faults, free_irq() will hang indefinitely, but double IRQ thread faults
require a reboot anyways.

Fixes: ed3e694d78cc ("move exit_task_work() past exit_files() et.al.")
Signed-off-by: Richard Patel <ripatel@wii.dev>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261009145842.1616117-2-ripatel@wii.dev
---
 kernel/irq/internals.h |  2 ++
 kernel/irq/manage.c    | 25 +++++++++++++++++++------
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index 0ce21dd..2c30e75 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -36,6 +36,7 @@ extern struct irqaction chained_action;
  * IRQTF_AFFINITY  - irq thread is requested to adjust affinity
  * IRQTF_FORCED_THREAD  - irq action is force threaded
  * IRQTF_READY     - signals that irq thread is ready
+ * IRQTF_EXIT_WORK - irq thread exit task_work is pending
  */
 enum {
 	IRQTF_RUNTHREAD,
@@ -43,6 +44,7 @@ enum {
 	IRQTF_AFFINITY,
 	IRQTF_FORCED_THREAD,
 	IRQTF_READY,
+	IRQTF_EXIT_WORK,
 };
=20
 /*
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 57eff26..e882a06 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1176,17 +1176,14 @@ void wake_threads_waitq(struct irq_desc *desc)
 		wake_up(&desc->wait_for_threads);
 }
=20
-static void irq_thread_dtor(struct callback_head *unused)
+static void __irq_thread_dtor(struct irqaction *action)
 {
 	struct task_struct *tsk =3D current;
 	struct irq_desc *desc;
-	struct irqaction *action;
=20
 	if (WARN_ON_ONCE(!(current->flags & PF_EXITING)))
 		return;
=20
-	action =3D kthread_data(tsk);
-
 	pr_err("exiting task \"%s\" (%d) is an active IRQ thread (irq %d)\n",
 	       tsk->comm, tsk->pid, action->irq);
=20
@@ -1203,6 +1200,14 @@ static void irq_thread_dtor(struct callback_head *unus=
ed)
 	irq_finalize_oneshot(desc, action);
 }
=20
+static void irq_thread_dtor(struct callback_head *unused)
+{
+	struct irqaction *action =3D kthread_data(current);
+
+	__irq_thread_dtor(action);
+	clear_and_wake_up_bit(IRQTF_EXIT_WORK, &action->thread_flags);
+}
+
 static void irq_wake_secondary(struct irq_desc *desc, struct irqaction *acti=
on)
 {
 	struct irqaction *secondary =3D action->secondary;
@@ -1263,6 +1268,7 @@ static int irq_thread(void *data)
 	else
 		handler_fn =3D irq_thread_fn;
=20
+	set_bit(IRQTF_EXIT_WORK, &action->thread_flags);
 	init_task_work(&on_exit_work, irq_thread_dtor);
 	task_work_add(current, &on_exit_work, TWA_NONE);
=20
@@ -1283,6 +1289,7 @@ static int irq_thread(void *data)
 	 * oneshot mask bit can be set.
 	 */
 	task_work_cancel_func(current, irq_thread_dtor);
+	clear_and_wake_up_bit(IRQTF_EXIT_WORK, &action->thread_flags);
 	return 0;
 }
=20
@@ -1853,6 +1860,12 @@ out_mput:
 	return ret;
 }
=20
+static void irq_stop_thread(struct irqaction *action)
+{
+	kthread_stop_put(action->thread);
+	wait_on_bit(&action->thread_flags, IRQTF_EXIT_WORK, TASK_UNINTERRUPTIBLE);
+}
+
 /*
  * Internal function to unregister an irqaction - used to free
  * regular and special interrupts that are part of the architecture.
@@ -1958,9 +1971,9 @@ static struct irqaction *__free_irq(struct irq_desc *de=
sc, void *dev_id)
 	 * the same bit to a newly requested action.
 	 */
 	if (action->thread) {
-		kthread_stop_put(action->thread);
+		irq_stop_thread(action);
 		if (action->secondary && action->secondary->thread)
-			kthread_stop_put(action->secondary->thread);
+			irq_stop_thread(action->secondary);
 	}
=20
 	/* Last action releases resources */

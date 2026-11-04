Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801770;
	b=g+SDz5JZHHv7EddX5Rq5y1F+dBo45fBwbjpVox29fZ+N2uFgl77rv7qdSLk9BsrOwAUB
	 S2vIfYypAo0jVdacrX3Cd0k4muvSaYkoBGe9HXYBSjxWaD2V0Q4nvSzrY7kPIWYTKQCoq
	 caifmJYrgV+9hIemfIWU19cxmiiQhMyKFUV8gYr60CiRg6/TCdjKC9ZgayIC9swfquGZs
	 cJdWvdrta5pgwbc6QsVuMXEuU8aHqimBnBfPjDjGs6iBnvqIavRWjyJS61EVmxb3cKp9G
	 HsMCCiI4+nvUSIo4mDzbN4sWCnEvrVh4UPlM4qLHiGmlE347YV0tP7jmAYaSuw4OksQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801770;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Cv5eDjwIXnAhcfcJ2xYv3l7kp0KHW5qIeCEgUrOjiVY=;
	b=YaQxhazul3DKyvXNlyPirsfZM1XRHgc/jez7Ji+Adun03U7IR1GRzK0+U1oALpy5Oaga
	 o6efZomcnwXCVqrQTAT6rV48noYe0Zxzyhnj8nyk6m+ti7GAz2UzpIMGmSgwvAUpl84Gg
	 2ieOo4kfZs56lef2KXdIGvVQ8217N/egDtMDJW8ahcQGU0L6KYWdzr/+vCGRNslvDlGEx
	 I8T0KVIqzIkfpRmypjU5djyDl7Vgd0tzstGgPr2xe7vFzFuFIoqMhhGom33PoIPep1RE9
	 t0JobqLLmcPkM0uk+j9Aw7lwgxXQE4xer5+7A2fyA6Z38XQ9fkzbqpQHHanj2cl7KXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=NPBOR7fw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B79606D81F
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 14:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=NPBOR7fw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D148B1F000C1;
	Wed,  4 Nov 2026 14:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793801769;
	bh=Cv5eDjwIXnAhcfcJ2xYv3l7kp0KHW5qIeCEgUrOjiVY=;
	h=Subject:To:Cc:From:Date;
	b=NPBOR7fwP7046B1w+Os84al/btFiDmWEjhdtQE2K36SpY2e/zDZJM9Ue/Vd947w/U
	 3h8wvKZCIIgmV6tjE/piJBJ0fXSnodbKFClyfg7rQ/SBDQXUrX2RRS0tSYhSKSJuGD
	 PjpALW6UdCBLW/SBTQ5Y/77Ly0HPDdzgOpni1ORw=
Subject: FAILED: patch "[PATCH] genirq: Move interrupt thread exit_work object to irqaction" failed to apply to 5.10-stable tree
To: ripatel@wii.dev,tglx@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 15:16:06 +0100
Message-ID: <2026110406-unstable-science-81d8@gregkh>
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


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 89a9e003a2ef73f67dff03dfd59e0a5474b56b0b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110406-unstable-science-81d8@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 89a9e003a2ef73f67dff03dfd59e0a5474b56b0b Mon Sep 17 00:00:00 2001
From: Richard Patel <ripatel@wii.dev>
Date: Fri, 9 Oct 2026 14:58:42 +0000
Subject: [PATCH] genirq: Move interrupt thread exit_work object to irqaction

irq_thread() registers irq_thread_dtor() as exit task_work using a
stack-allocated callback_head.  On normal interrupt thread exit, this work
gets cancelled and never runs.

On x86, an abnormal interrupt thread exit (e.g. handler oops) discards the
stack, including the callback_head, while that callback_head is still
pending. By the time exit_task_work() runs, the stack memory formerly
backing callback_head is already clobbered.

  irq_thread()                      <-- on_exit_work allocated
    ** IRQ handler faults **
    oops_end()
      rewind_stack_and_make_dead()  <-- on_exit_work freed
  make_task_dead()
    do_exit(SIGSEGV)
      ...
      exit_shm()                    <-- on_exit_work clobbered
      ...
      exit_task_work()              <-- stack use-after-free
        exit_shm()+0x30             <-- wild jump to return addr

Thus, a benign threaded IRQ oops (e.g. a NULL pointer deref) is
turned into a wild jump. This is caught by kernel IBT:

  ** first fault **
  Oops: general protection fault, kernel NULL pointer dereference 0x3c0: 0000 [#1] SMP NOPTI
  ...
  ** second fault **
  Missing ENDBR: exit_shm+0x30/0x1c0
  kernel BUG at arch/x86/kernel/cet.c:133!
  ...
   ? task_work_run+0x5c/0x90
   ? do_exit+0x209/0x460
   ? rewind_stack_and_make_dead+0x16/0x20
  ...
  note: irq/165-AudioDS[1427] exited with irqs disabled
  Fixing recursive fault but reboot is needed!

Fix this by storing the callback_head in struct irqaction.  The irqaction
is only freed once irq_thread_dtor() finishes.

Fixes: 2deb4be28077 ("x86/dumpstack: When OOPSing, rewind the stack before do_exit()")
Signed-off-by: Richard Patel <ripatel@wii.dev>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261009145842.1616117-3-ripatel@wii.dev

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 3bf969ad8fe0..50745608dc15 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -119,6 +119,7 @@ typedef irqreturn_t (*irq_handler_t)(int, void *);
  * @thread_flags:	flags related to @thread
  * @thread_mask:	bitmask for keeping track of @thread activity
  * @dir:	pointer to the proc/irq/NN/name entry
+ * @thread_dtor:	task_work for @thread irregular exit cleanup
  */
 struct irqaction {
 	irq_handler_t		handler;
@@ -137,6 +138,7 @@ struct irqaction {
 	unsigned long		thread_mask;
 	const char		*name;
 	struct proc_dir_entry	*dir;
+	struct callback_head	thread_dtor;
 } ____cacheline_internodealigned_in_smp;
 
 extern irqreturn_t no_action(int cpl, void *dev_id);
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 87a2476ea259..3b647d9b458a 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1201,9 +1201,9 @@ static void __irq_thread_dtor(struct irqaction *action)
 	irq_finalize_oneshot(desc, action);
 }
 
-static void irq_thread_dtor(struct callback_head *unused)
+static void irq_thread_dtor(struct callback_head *work)
 {
-	struct irqaction *action = kthread_data(current);
+	struct irqaction *action = container_of(work, struct irqaction, thread_dtor);
 
 	__irq_thread_dtor(action);
 	clear_and_wake_up_bit(IRQTF_EXIT_WORK, &action->thread_flags);
@@ -1250,7 +1250,6 @@ static void wake_up_and_wait_for_irq_thread_ready(struct irq_desc *desc,
  */
 static int irq_thread(void *data)
 {
-	struct callback_head on_exit_work;
 	struct irqaction *action = data;
 	struct irq_desc *desc = irq_to_desc(action->irq);
 	irqreturn_t (*handler_fn)(struct irq_desc *desc,
@@ -1270,8 +1269,8 @@ static int irq_thread(void *data)
 		handler_fn = irq_thread_fn;
 
 	set_bit(IRQTF_EXIT_WORK, &action->thread_flags);
-	init_task_work(&on_exit_work, irq_thread_dtor);
-	task_work_add(current, &on_exit_work, TWA_NONE);
+	init_task_work(&action->thread_dtor, irq_thread_dtor);
+	task_work_add(current, &action->thread_dtor, TWA_NONE);
 
 	while (!irq_wait_for_interrupt(desc, action)) {
 		irqreturn_t action_ret;


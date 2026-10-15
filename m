Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15024A0938;
	Thu, 15 Oct 2026 08:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792053838; cv=none; b=PhFEns5Mt83cV4FNdq2qTII93frNCuX3SLfczTEU1COhc3dIY7m8ZjYj4h6mmnf+rmMrheeqdGw+Bh6XaivduFcybWgVvblZD+V6HFq9GWoApoMzxSpWUw9LJltfiHVFo7Kp0/YzYXYKt+DiriE099A+MH6WAjR7l9LM1wMq5G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792053838; c=relaxed/simple;
	bh=7vKH0LWy7XKwh4SIr68svvRfKtu5E4ugD+SVkG75OSQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LbyTOkwf3shvLGFGgT4E8GPL3vUXxlp9IVvex5B8OLYMEbtVTijsWs7zN4yXjUEiSwFaoMK2uHFKH3y2YBpLxqGfCgA1bg4hrWtFcI3PYRExNVfXr71Qz2JdH8lsgOz4574EqLHRigi778fe2epRaCbwplDXkXu23XDT4tlj1Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=StWP/4G2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/x2sZ1E2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="StWP/4G2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/x2sZ1E2"
Date: Thu, 15 Oct 2026 08:43:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792053833;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r012UVNkIUA1nnKt4RhRX2K12heC26iFIR27Ih4kJYc=;
	b=StWP/4G2j9JEL+Q9rFcg7mn/RmWTjq1d/iLptMeJEmOSOHA81eA9pPyaNOGkxiWzixse4l
	TDEv7fNTE8ZhW31lg42jinqaLsOb+R+GDVYQZ2SWfpwqhJcJvv7nyqaDneDzZpYmj3YKEa
	kXFVvcBvJDxlAc2XiP0hf7FJKYz7RVql5q7SJ72MX141ng4/w0wkGB9Tnd2x6Lvn4OAa8Z
	W56KYHKKsokkbwKKnTQgkpnP4ezORdGpHgknGweS2Fz7P7cVk/GzBmz0FcVWs17efh+hv/
	L7WMOjAVk6zm8+wU+BeoTe31xg2gJsh6Dwlac7i+6+GFp9yoP/OiRDjdckvL/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792053833;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r012UVNkIUA1nnKt4RhRX2K12heC26iFIR27Ih4kJYc=;
	b=/x2sZ1E2dpyJUOC/PYg8AuIDeMPJRXT6jS6phks086yuZhvWYDgqxRODzP+URMeHTI8UXz
	eXRS7qgtW5PyCRBQ==
From: "tip-bot2 for Richard Patel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] genirq: Move interrupt thread exit_work object to irqaction
Cc: Richard Patel <ripatel@wii.dev>, Thomas Gleixner <tglx@kernel.org>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 maz@kernel.org
In-Reply-To: <20261009145842.1616117-3-ripatel@wii.dev>
References: <20261009145842.1616117-3-ripatel@wii.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <179205383139.2666988.9099225047757634453.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     4fa7269c2e7f723965640ea75899fac83e3dfe7b
Gitweb:        https://git.kernel.org/tip/4fa7269c2e7f723965640ea75899fac83e3=
dfe7b
Author:        Richard Patel <ripatel@wii.dev>
AuthorDate:    Fri, 09 Oct 2026 14:58:42=20
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Thu, 15 Oct 2026 10:38:13 +02:00

genirq: Move interrupt thread exit_work object to irqaction

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
  Oops: general protection fault, kernel NULL pointer dereference 0x3c0: 0000=
 [#1] SMP NOPTI
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

Fixes: 2deb4be28077 ("x86/dumpstack: When OOPSing, rewind the stack before do=
_exit()")
Signed-off-by: Richard Patel <ripatel@wii.dev>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261009145842.1616117-3-ripatel@wii.dev
---
 include/linux/interrupt.h |  2 ++
 kernel/irq/manage.c       |  9 ++++-----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 3bf969a..5074560 100644
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
=20
 extern irqreturn_t no_action(int cpl, void *dev_id);
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index e882a06..4fbb8f9 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1200,9 +1200,9 @@ static void __irq_thread_dtor(struct irqaction *action)
 	irq_finalize_oneshot(desc, action);
 }
=20
-static void irq_thread_dtor(struct callback_head *unused)
+static void irq_thread_dtor(struct callback_head *work)
 {
-	struct irqaction *action =3D kthread_data(current);
+	struct irqaction *action =3D container_of(work, struct irqaction, thread_dt=
or);
=20
 	__irq_thread_dtor(action);
 	clear_and_wake_up_bit(IRQTF_EXIT_WORK, &action->thread_flags);
@@ -1249,7 +1249,6 @@ static void wake_up_and_wait_for_irq_thread_ready(struc=
t irq_desc *desc,
  */
 static int irq_thread(void *data)
 {
-	struct callback_head on_exit_work;
 	struct irqaction *action =3D data;
 	struct irq_desc *desc =3D irq_to_desc(action->irq);
 	irqreturn_t (*handler_fn)(struct irq_desc *desc,
@@ -1269,8 +1268,8 @@ static int irq_thread(void *data)
 		handler_fn =3D irq_thread_fn;
=20
 	set_bit(IRQTF_EXIT_WORK, &action->thread_flags);
-	init_task_work(&on_exit_work, irq_thread_dtor);
-	task_work_add(current, &on_exit_work, TWA_NONE);
+	init_task_work(&action->thread_dtor, irq_thread_dtor);
+	task_work_add(current, &action->thread_dtor, TWA_NONE);
=20
 	while (!irq_wait_for_interrupt(desc, action)) {
 		irqreturn_t action_ret;

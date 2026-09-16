Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA634B0E27;
	Wed, 16 Sep 2026 16:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577304; cv=none; b=EzMtYUA0WNO169qonpe2YU/Xa4ClP6d8yVpPwNVEU4pi7Lfufl+5UhwWPd4PRSW10lefwqr1CSDFJYqO5GhspkicEix6U8VKgnKgtvnRx+F+4zpjHb5M81KmMHV+NoogGeDlMWYJunnxngvFK41o+1Yga/BcqvK8YnSa3ADLmyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577304; c=relaxed/simple;
	bh=PIIy47qrQZyTqT45J1I7cuvBm6ajTYhh+DbwFjVcyJU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CZuQe/RIEDtIY16R419CxZH+YYmrGu4xlNQ4nEey1eNJJ1aZbHhwKUzTzJS1jUb+SiYoNK6oLcADvKXEdMg+OE+aPACmKq6zCs5B7wX7/ziw5STpdfvAQEPlw3QYyS3rsml8HTAVjoZtss1GAG0yjBfSPdn4wgn+CMhtnvoF4JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=14p37GNT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PNLJlgJ/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="14p37GNT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PNLJlgJ/"
Date: Wed, 16 Sep 2026 16:48:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1789577293;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RCP6Y2dz+gG6ZoYyYqBnbJ4jmInGhTfSXq1ocZ/vF2c=;
	b=14p37GNTJX8Bof+b74ONxpykbhvlwvEz4pcTVpFRy4aWzzSwjED4wceJ+5sg0PkWMEYebP
	+1UqCUsEpWBjgnm1ZhpFyydXFtHonIMuPCYcPGk/Twj/wLo858+LDvzVfdhiKzTmjTZa0w
	jBPS4Vf9w8Gcj+tyI6Zdd0VpzsbBpubQhBZclpRO3dlkfFRulThIymjlHBmg3hOLH5S80O
	CPl/xcEeU5YQyNNwp1Sw+Wl7Vr++kDz33PLY8gRuduqIBwyD/RLPl6bWFba8F1wMBlOD18
	TfZeIqxVpxvwlnZXvCnvPG+twc8kPHy13+H0mtyzLZRFTFvJL5T14H3gOf6neg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1789577293;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RCP6Y2dz+gG6ZoYyYqBnbJ4jmInGhTfSXq1ocZ/vF2c=;
	b=PNLJlgJ/7pxovp/Cun7sIr7KQY7qc7z9zNF/NezcLkfsnZTKwozsIiho/0hFkFJtqFzm9z
	RtIRYSBi+EB7J5BA==
From: "tip-bot2 for Hyunwoo Kim" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] exec: Cleanup POSIX timers right after de_thread()
Cc: Hyunwoo Kim <imv4bel@gmail.com>, Thomas Gleixner <tglx@kernel.org>,
 Kijo Park <red993688@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
 Frederic Weisbecker <frederic@kernel.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260911090541.627712075@kernel.org>
References: <20260911090541.627712075@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178957729153.1720534.6856624055677236156.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     acb03d3881818581052924a9bbbe92b8741ed448
Gitweb:        https://git.kernel.org/tip/acb03d3881818581052924a9bbbe92b8741=
ed448
Author:        Hyunwoo Kim <imv4bel@gmail.com>
AuthorDate:    Fri, 11 Sep 2026 11:09:17 +02:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Wed, 16 Sep 2026 18:44:03 +02:00

exec: Cleanup POSIX timers right after de_thread()

A per-thread CPU timer holds a reference to the PID of the thread it is
attached to and, while it is armed, its node is queued in that thread's
posix_cputimers. The task is looked up by that PID.

When a non-leader thread exec()s, de_thread() changes which task owns
that PID. pid_task(timer->it.cpu.pid, PIDTYPE_PID) then returns NULL,
but the node is still queued on tsk, which is alive. timer_lock_sighand()
takes a failed lookup to mean that the node is already dequeued, so it
has nothing to undo.

begin_new_exec() calls posix_cpu_timers_exit(me) right after
exec_task_namespaces() and that removes the leftover node, so the state
normally stays invisible. But bprm->point_of_no_return is set before
de_thread(), so if unshare_files(), set_mm_exe_file(), exec_mmap() or
exec_task_namespaces() fails, the task dies before it gets there.
exit_itimers() then frees the k_itimer while its node is still queued,
and reaping tsk later erases that freed node from the rbtree.

In short:

      the non-leader thread B           the parent

  timer_create(CLOCK_THREAD_CPUTIME_ID)
  timer_settime()
    arm_timer()            // the node is queued on B
  execve()
    de_thread(B)
      exchange_tids(B, leader)  // B's PID now belongs to the leader
      release_task(leader)
        __exit_signal(leader)
          posix_cpu_timers_exit(leader)  // cleans leader's queue, not B's
          __unhash_process(leader)  // that PID has no task anymore
    exec_mmap()
      mmap_read_lock_killable(old_mm)
                                kill(B, SIGKILL)
      // -EINTR
  get_signal()
    do_exit()
      exit_itimers()
        posix_timer_delete()
          posix_cpu_timer_del()
        posix_timer_unhash_and_free()  // freed while still queued
                                wait4()
                                  release_task(B)
                                    posix_cpu_timers_exit(B)
                                      cleanup_timerqueue()
                                        timerqueue_del()  // use-after-free

Move the POSIX timer cleanup right after de_thread() before any of the
later failure conditions brings the task into do_exit().

[ tglx: Move the cleanup right after de_thread() ]

Fixes: 55e8c8eb2c7b ("posix-cpu-timers: Store a reference to a pid not a task=
")
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Tested-by: Kijo Park <red993688@gmail.com>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/ao7Q8miiuLAPVnWv@v4bel
Link: https://patch.msgid.link/20260911090541.627712075@kernel.org
---
 fs/exec.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index d3081c8..8196434 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1115,6 +1115,17 @@ static struct file *bprm_identity_file(const struct li=
nux_binprm *bprm)
 	return bprm->file;
 }
=20
+static void posixtimer_exec(struct task_struct *me)
+{
+#ifdef CONFIG_POSIX_TIMERS
+	spin_lock_irq(&me->sighand->siglock);
+	posix_cpu_timers_exit(me);
+	spin_unlock_irq(&me->sighand->siglock);
+	exit_itimers(me);
+	flush_itimer_signals();
+#endif
+}
+
 /*
  * Calling this is the point of no return. None of the failures will be
  * seen by userspace since either the process is already taking a fatal
@@ -1152,6 +1163,16 @@ int begin_new_exec(struct linux_binprm * bprm)
 	retval =3D de_thread(me);
 	if (retval)
 		goto out;
+
+	/*
+	 * This must be done here to ensure that POSIX CPU timers which were
+	 * armed on the current task are dequeued from me::posix_cputimers.
+	 * Otherwise in case of a TID switch the deletion of the related POSIX
+	 * timer would not remove an enqueued timer because the TID lookup
+	 * of the old TID fails.
+	 */
+	posixtimer_exec(me);
+
 	/* see the comment in check_unsafe_exec() */
 	current->fs->in_exec =3D 0;
 	/*
@@ -1206,14 +1227,6 @@ int begin_new_exec(struct linux_binprm * bprm)
 	if (retval)
 		goto out_unlock;
=20
-#ifdef CONFIG_POSIX_TIMERS
-	spin_lock_irq(&me->sighand->siglock);
-	posix_cpu_timers_exit(me);
-	spin_unlock_irq(&me->sighand->siglock);
-	exit_itimers(me);
-	flush_itimer_signals();
-#endif
-
 	/*
 	 * Make the signal table private.
 	 */

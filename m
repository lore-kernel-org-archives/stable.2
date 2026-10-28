Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793201800;
	b=gzp6Jy1fgjl1+YxKWMebupCUV0hDJIx/vSm3CmGHF9fWbNWMnuXPK/MKUyTfw3HGi/4S
	 hQ/KItMrucGkeI7qTGwATeW1CNXi7YX0fdCyxUgzvCJ67n3nmkXqiodhHyoTyAj7y4Xe3
	 yhgaFv+tG4yUQnNyDL8dC3yOgqWWJPtwmSDNtcITBVNAx1BGmAGyKrH6tLfpvlYWOm5Dk
	 a3yyZnMAeGYsuQWL5lbhfVE6mQDqEpJaeOE8U4ThPx0vPrqyYY2a8G8jTQUYBVPOL1vhE
	 dyw7jgWB9+DI9WDSO9T0pIyFZ7r1L4avMKQRVnOkAhHbBGrf6Dynx9ULVggwdlvTobw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793201800;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=6SUr8oqU29oJQBgtP6zRZWP3CG5TKqiZPrOy7h5oOps=;
	b=1zQQlHllYf3itaiQPpM3pTFa0sV6yGIoGUCjkdkeJQuHe2UW5CwJCViWb133+BCX+pC9
	 J9rg5bW7fA5xQlV3X/PMTEPP3J5qjkSjHmocTCyuI2Fp0tp6LNqOCBp7+3tSqmj/vUOBm
	 qyKA1Ghy6RMPW0iaBtOil9JV6nJLKNHiJHvKMyK9pnBq0ksldLGlGdj4LLqjJK0xIdA4M
	 jL0oa9bT9EuRv4Dl+ud2Ore4sWhXjTDlu3wc1Ee71T+e6bIsl60LGOj89riLR2tWn+n0O
	 ibegn7rTHFm65fnfamKgzXOxx0zeKB3WkX8cLX3wD2OWGWdFBEbfEbJHAI0jIBu7FUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=JwHo560A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B1C606A31A
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 15:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=JwHo560A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E0BF1F01240;
	Wed, 28 Oct 2026 15:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793201800;
	bh=6SUr8oqU29oJQBgtP6zRZWP3CG5TKqiZPrOy7h5oOps=;
	h=Subject:To:Cc:From:Date;
	b=JwHo560AMJFXa4NiEWwdOOi+AFP8ctFQTRaup5LMOOyHTAaDD1QhBFklZSMNX5w3W
	 scDchrXdJb1PEKcR3DaOx4kYA8TB0i+55TewGTwkeIQk7F+6JSDWrjd9t/DaVOfQ+P
	 xFKTn45yLM2WGvOdYHu4dSrvnCbtI/dg0jmzi1fQ=
Subject: FAILED: patch "[PATCH] exit: hang up the tty before closing the files" failed to apply to 5.15-stable tree
To: brauner@kernel.org,mason@kernel.org,oleg@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 28 Oct 2026 16:36:28 +0100
Message-ID: <2026102828-impotency-harddisk-0e94@gregkh>
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x ad016f0131ebfec250a3360ea75d35128b3f4aa8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102828-impotency-harddisk-0e94@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ad016f0131ebfec250a3360ea75d35128b3f4aa8 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 21 Sep 2026 15:44:57 +0200
Subject: [PATCH] exit: hang up the tty before closing the files

do_exit() closes the task's files in exit_files() and hangs up the
controlling tty of a session leader in disassociate_ctty(1) after
that. Since commit d99d38540bf0 ("fs: make close_files() synchronous")
the final __fput() of every file runs inside exit_files(). So when the
session leader holds the last open of its tty the tty is released
before disassociate_ctty() runs. tty_release() clears signal->tty for
the whole session in session_clear_tty() once the count drops to zero
and sends no signal doing so. disassociate_ctty(1) then finds neither a
tty nor a tty_old_pgrp and does nothing. The foreground process group
loses its SIGHUP:

    do_exit()
      exit_files()
        close_files()
          tty_release()             tty->count == 0
            session_clear_tty()     signal->tty = NULL, no signal
      disassociate_ctty(1)
        get_current_tty()           NULL
        signal->tty_old_pgrp        NULL, nothing sent

That only affects real ttys. For a pty the master's open keeps the
slave's count above zero. And it only affects a foreground job that
holds no descriptor to the tty anymore while its session leader exits.
Everything else is unchanged. The DTR drop on the last close happens in
tty_port_shutdown() regardless, stopped jobs get their SIGHUP from
kill_orphaned_pgrp() and signal->tty is cleared either way.

Before that commit the final __fput() ran from exit_task_work() which
comes after disassociate_ctty(). That order isn't old. Until v3.14
exit_task_work() came right after exit_files() and before v3.6 fput()
was synchronous, so the tty was always released first. Commit
c39df5fa37b0 ("exit: call disassociate_ctty() before
exit_task_namespaces()") moved disassociate_ctty() up to fix a pppd
crash and in front of exit_task_work() as a side effect. The hangup in
this case has worked since then and that's eleven years of userspace
being able to rely on it.

Hang the tty up before closing the files. This is the ordinary hangup
with the file still open: __tty_hangup() swaps in hung_up_tty_fops and
tty_release() runs from the close afterwards as it does when a modem
drops the line. disassociate_ctty() stays in front of
exit_task_namespaces() which the pppd fix needs.

Reported-by: Chris Mason <mason@kernel.org>
Link: https://patch.msgid.link/20260921-work-coredump-fixes-v3-8-8e4adb1619e6@kernel.org
Acked-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

diff --git a/kernel/exit.c b/kernel/exit.c
index 55dbea3b242e..9ed5eb03d0e1 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1003,10 +1003,11 @@ void __noreturn do_exit(long code)
 
 	exit_sem(tsk);
 	exit_shm(tsk);
-	exit_files(tsk);
-	exit_fs(tsk);
+	/* Hang the tty up before the last close of it can clear the session. */
 	if (group_dead)
 		disassociate_ctty(1);
+	exit_files(tsk);
+	exit_fs(tsk);
 	exit_nsproxy_namespaces(tsk);
 	exit_task_work(tsk);
 	exit_thread(tsk);


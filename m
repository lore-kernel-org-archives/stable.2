Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793220429;
	b=JOdHrQayX6NB0gDcKc4E2hS9/ziCCpZ9OixZTT6LiO+dAn2hEixafLNESUE3BnqFUeyg
	 ZBrdJr3HnKHk6G7y3p7cVxLu6HNmq08EAHdAw8l6P6bjq1kbBoQIdeDngpSjzlvI2wcdY
	 XNr/L3sxKUVdJKugR9Q/g5/iJDE8KPPI1aMJSmndybkOWzbWLuQ+a3eGytYFX+23Aq0n2
	 YNINkx3frCwJdUpYJcL/CkgezAMQp4W+OksnCDRaxsvRGwLd4+8fS+DRFs8lHpakFxBoq
	 Y1cbL9rp6+lU3h4veN3rX4OvcAkUm8pZdIEObkB4+IHTl6pgaR4vSyw+ScKTvoU+13A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793220429;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=+KrBiM1e/3Dxrjo3VjzM4b5Xz9mDtR9CBdPVOp2te00=;
	b=TGirSNzPT+deonT2ZzHdiGerqsJvnwnvdI218ZuAakrcz+TZQYlpdLPZ1zm9YvpdIUqf
	 kB0p4VgPM+3Iuza0l+5MzxXFAFrmclewN1MtRKBICtTI5wmxz+3pP6CL7kmDhEZdNJWXj
	 WZrQ/NM3AnPLhLGvwhfLd0egV4DT35a40ggYL5EzJdTpOWNBaO5+rxuVAAMooIlqtdAzB
	 GatWFFhz2TBuZUqdyWn18LQ/q44Gk4J66Rpp782jYkzOvo2jfv9NM7h+UFqBZbUp5VilG
	 KDDt77rs9c0ejdZ0P1FJoyb/40iT/rxtAHWYz5VAYp1QIdR6VHi1nEFI9AMx3s++Ikg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GDG5o8B2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F61606A32D
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 20:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GDG5o8B2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D18911F01825;
	Wed, 28 Oct 2026 20:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793220428;
	bh=+KrBiM1e/3Dxrjo3VjzM4b5Xz9mDtR9CBdPVOp2te00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GDG5o8B2WZJjZmXs/dx1bcDnWe0Q2W9X9igW5cmwoPLaXQnedA0Xntd1+8PoiXgbO
	 pkhHOtqXD6Z5vUpnp9Q7lS+/sFJ3dQeHzCiYhEVc6V4AC4o45ERam5SFrS76OWdIwN
	 39cgD+rJN2vvHgByOy/UGvmmv5h3WqlKMNAeSrBJ4KnBzQo1TJ6dOhd6okbxXCgM07
	 1+OA7IHmJvVjuyPiY0NZor/GLz+OtfmeCjYLlwJw8Y2EVlC1XnHQTkz5YIJ3yhVPBr
	 V6EMsXygTMnhF+lq3qYBUAsTZK0Fj2+wTItzTO/pojFGMLy6SO7JrZ9wqV2XMC86gJ
	 8Z2s41CkVLoHw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Chris Mason <mason@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] exit: hang up the tty before closing the files
Date: Wed, 28 Oct 2026 16:47:06 -0400
Message-ID: <20261028204648.2123515-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102828-playable-stallion-c6ad@gregkh>
References: <2026102828-playable-stallion-c6ad@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit ad016f0131ebfec250a3360ea75d35128b3f4aa8 ]

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
[ sashal: adjusted context for exit_task_namespaces() instead of exit_nsproxy_namespaces() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/exit.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index b3cfeba72dc02..ca606f1b68720 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -879,10 +879,11 @@ void __noreturn do_exit(long code)
 
 	exit_sem(tsk);
 	exit_shm(tsk);
-	exit_files(tsk);
-	exit_fs(tsk);
+	/* Hang the tty up before the last close of it can clear the session. */
 	if (group_dead)
 		disassociate_ctty(1);
+	exit_files(tsk);
+	exit_fs(tsk);
 	exit_task_namespaces(tsk);
 	exit_task_work(tsk);
 	exit_thread(tsk);
-- 
2.53.0


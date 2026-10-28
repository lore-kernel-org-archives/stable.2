Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793224989;
	b=Ncoe/iGdVHbTG9wvpjcZPjEqYQKZoDqeSEPMsgmTtXBQOp6Bl69AV3UV5jOysnfmJM65
	 bmKscsaEB4FP5sbTAH3NX6LP4Whm9WPFQkGXJjmODJpeblJ2XXAcRkTJ4OKcA7Zl1da/l
	 T40vTGCBpAQ7u8hFnASScyexs4dUDqp+BLDu/IqZ8SV0g5d6U9xOs6LOXwF59BhlHm1or
	 5Fq+bIMZbivArwvwaspIErSqMprm07a/7rKRKJVCwYpuqFY5Q7BZrhdygc2ekbct3bQ7t
	 j+ZYx0lLGiAd25Hsxa8p2coBWdw1RUXWpIMnjBp597o0BX3IhJSGQfG0nFrwmZESg9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793224989;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Te+QJvoBTbAiGqNs725SvrBIQBFuEpgKQwydziQT/nM=;
	b=3CyDH4xZYzCZ9RHTY8J0Xkc0lnmCMl3SmvFQ/ogCZlV4pafnnB4aDWKew5Myc+VckPlo
	 th4C93Ose6EQZkpTuqYk23peCzMt4/cvRw5kbtO+xGYelTnBzKyouLb0YxfqwnwV4kyD7
	 PCjgeff4yu5X7ii9ROPBzgomauKjmj2DFNxvogR9m2dqpgwGduovYpgG1Fbox9p/C/mg0
	 AVVhrD/BbmjkJVO7MY9A6Tr2foXb5qjWN2zGn0W7J1SLxA3RNUgsxBwCwpWvj3G6BevYW
	 WY1c+eKisGs3pifnnz2O26U/b2LA5BbflYNoUjqTJlluElz9cBATRiBBWnUHtb+ADsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eciyZ+nk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F30606A31A
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 22:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eciyZ+nk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54E2C1F01825;
	Wed, 28 Oct 2026 22:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793224988;
	bh=Te+QJvoBTbAiGqNs725SvrBIQBFuEpgKQwydziQT/nM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eciyZ+nkXGH/wrbTeH8ELuh9TMla/BBf2+/zlONETxcOYBp24Ct83/XYiEAhV4Ej/
	 /tIOe+hNQMjBC6w0L0xMlkR6b+cxJw5CyHfEDFBiiczWMi/UKOOwZ5Rcfgodwn4qDD
	 meHoALFn2SAZB3OEUUu3DQm/bY77Ej78MOgaH7v8uDEcYLzl20gAR5kEYTRSE6GSPU
	 p7r6RmhWmdB+5P29hH2/Vo/7pVIwNc0TFvmvjrcHTCWR+ZaVv1vVD2uPXg7x2TLrl6
	 8iTXZHiJl4EUe9zLL52u7LbQ2ZaWkCPfuIGHHbd97I2cut+FQg93ruByDNy7EvtqLG
	 tHICZfcWQHF/Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Chris Mason <mason@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] exit: hang up the tty before closing the files
Date: Wed, 28 Oct 2026 18:03:07 -0400
Message-ID: <20261028220251.2366488-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102828-impotency-harddisk-0e94@gregkh>
References: <2026102828-impotency-harddisk-0e94@gregkh>
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
index 776994c28887a..be36344282182 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -882,10 +882,11 @@ void __noreturn do_exit(long code)
 
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


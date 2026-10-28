Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793212522;
	b=xKX7aIDghPLcsq/LjnBIttaA+PLKjG5DKe2JHLOK7oRuOvLJD+guj9i8S6mgVwaoLDBk
	 x6mp2mTesMozn5TaOeGzoDZRs/NQQybJsX9YzlG2Tw6TpQelUk85UA6kKGEP3RpouRjri
	 XbVbF8pdlYe1x5MJb917jfiqY5uB/+/BdpHVbiXZr/OuURt897lW/t8CbVEkWnh79QG5m
	 svI/KcDHE0mE7eEttYwJEa2VBQMySPJtOFxAT+8zKuLOKwhvpnSI5yZ4fAuyE5QDYGaLU
	 WU3aSx91PjEcBO2qRiYfkWPug+JTP/PmHKjCUa7ugFNKOZm6ITdRzQYFXApex0DXOsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793212522;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=a9KyGvb3BFnTO2v34ic6gbb9wPaeNP8aywO2Ns4A3DA=;
	b=e1JsOcYOeiAY26LRHeUueEDMnhzS0ACuESgXNIHmnRNh0QXUp6Xooh5HB88f+GVC0sgE
	 Z/0G6JpVbuKqinwL4L+R17knS3y4R8B3SaPQpsytjK7gAw4LfaEl4KhPTOWuPk8WLrAw4
	 K0RklvnUEO0nsCxjXDQnd7FCMtcBFXG9+qllo831WaHDSI8rC/06RpSl6llLPODqy9+NU
	 gvKWu6HrW+8jpSI7ZKacMhe0JKH7Ms1u2UBJX6KAWZO4vVD+9swLnJPq+vbFAjsmcI3pA
	 b1gnsK1ifn+DEfril4MzvEASEDoNJc9gfSHXuxo91ZlDlFp7Wh135EbVt+zeGNCn42Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QCqEkkm7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B1B606A31E
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 18:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QCqEkkm7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C7001F01828;
	Wed, 28 Oct 2026 18:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793212522;
	bh=a9KyGvb3BFnTO2v34ic6gbb9wPaeNP8aywO2Ns4A3DA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QCqEkkm75Nmj5yL/oqgValM1a/mNMScAakBIhvqXetbdkE4Sy10V13URoPPRxArPE
	 EY9ul/8WfJRf3o5AwcQQ7j2CtJ+dPKGXxqpCp77+u0inDkXbFmvQ4LZ5XsvcWQAP88
	 N5WhOcJWyCQblKPEt1DNSd3ZrK4UYVUNnrjasHdLzu86py5adnZ91P7NOmgHnImp3y
	 u9Cmq0XWTGRWNK49SO1FZVw2Q88VxFVcwadlYxQhesd0ei2lKUVPNNB/5cUgn8Qw9F
	 LSVqiVmWnUdlgWA92/StBmBYwLJykm+07qqVtNUGgzpTmQGbNh7rSVbVIWWKXnv08P
	 4K1CC6HYDosRA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Chris Mason <mason@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] exit: hang up the tty before closing the files
Date: Wed, 28 Oct 2026 14:35:20 -0400
Message-ID: <20261028183506.1720832-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102826-sierra-parted-e606@gregkh>
References: <2026102826-sierra-parted-e606@gregkh>
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
[ sashal: Adjusted context to use exit_task_namespaces() instead of exit_nsproxy_namespaces(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/exit.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index 5b1b1c52e72c5..0d6c5c76403e0 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -946,10 +946,11 @@ void __noreturn do_exit(long code)
 
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


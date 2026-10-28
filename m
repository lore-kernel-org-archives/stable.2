Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793219252;
	b=U6rjIC3xuBRvsluoUGXPtEwf1Ol0r3iybht2SINg9D7hn1SnNzhmLCo3Q/J3xW7umKjm
	 4aPR8zfrl0xtzOI7bKUfCb3JMs7j4mdHaI6HopiuQKxvZhvXzNZzulwrpOXSJwDeCDuS7
	 4enrH7CEJXYAXUmJoyBUUe3fxA4w29zKACgh4owbKCURdbkqe6TsE58HhR9sOH0w80YFG
	 RuaFEw93MEmDGZdgVlMV5BCWC68NmTsmVOu/dNJ6hyRHvyQN+MpRaQZMmjQqGUAK040hc
	 ecc7/tUTz0O6IRUFr2GRl0on5XzP5OjHLFGHbweFm0e0TWaIpIYK4oG1tyFdkQY6bOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793219252;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Z3BcHilPWCdg/Jm+0tz7mqsuE+4BZVQQWsGtHYosXAg=;
	b=YzVX09olk0LbLt2vVucFvBG+8nsO/s48n0StzQ7qxK5CZ3UZXBz4KXiTd0oLMk/PmRp5
	 ARjz5cq5PA8AwGcWpGWOP3XHLsRiyYge4/qDf9lPLvsITrEieh01XrK7IM4lsQ9VA2JYn
	 3MQ37UlgWjZ+SYJqPPH9cNAk0Qh4PlWCkpnK8w9Z9JLRwKqAUILGeeRryp92s5haxNS/i
	 KNqz3pOZZ7yhWuauVHEO3ucPkdwub+whU/eePn6s1c/G7VY2T6a8ttxLqaHw+vjohSGix
	 HVPvJkE+jAMXznlw6R9vwukgk8SshUJFR7erUtXM68TmBWxl2vyjeVAR3+ZVOIAf6Yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="JRI/TsOu";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1E7606A31A
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 20:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JRI/TsOu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 238341F01828;
	Wed, 28 Oct 2026 20:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793219251;
	bh=Z3BcHilPWCdg/Jm+0tz7mqsuE+4BZVQQWsGtHYosXAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JRI/TsOuAFeig+kgMo4Vgr9YXSL3cwYJURWraurJCN9EF8ayLnrpkA+3BMD0uoYEU
	 kN5IXqypZgRP7soVx5BdlcnYmdhqr93zzvF1s9caEC7OZvG5cnri9pkh4VT+//eU7M
	 jJrR3zk8yFcYsQlDl6j+urm1PIZ+Zu6t9cy37/JBCkoyz5nXjAAw4ZaFDI/TXpRaXF
	 fzQy79aNtyIHEIeK2iAYU1JH7Wo23qHRWa3K8ibt3dyFXCafwozCsl61BBAWUOXIbD
	 bIsh0TBQtg1E4Z2IbderBcE+NeTKNeoWlpVa0MOR1d35+M9eOa0EBJ/p/OIla66LW1
	 l8+F2ppFQp+Kw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] exec: cancel io_uring requests before de_thread()
Date: Wed, 28 Oct 2026 16:27:29 -0400
Message-ID: <20261028202721.2255160-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102820-majorette-entwine-2e07@gregkh>
References: <2026102820-majorette-entwine-2e07@gregkh>
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

[ Upstream commit b42c85c20d84ff3e4f0f027d6596c3b3b4a20657 ]

begin_new_exec() cancels the exec'ing thread's io_uring requests after
de_thread() made it the only thread in the thread-group. Now
io_uring_task_cancel() runs task work after. If it runs a
create_worker_cb() item then a io-wq queued on the thread before the
exec creates a new io-wq worker thread.

Said thread joins the thread-group which de_thread() just took down. The
io-iwq sticks around until it notices that its workqueue is dying. But
code after de_thread() relies on being single-threaded.

Move io_uring_task_cancel() before de_thread() but behind the point of
no return. Any worker created during task work run from
io_uring_task_cancel() is just a sibling thread that de_thread() will
take down and reap.

Once io_uring_task_cancel() returned the thread has neither a task
context nor a workqueue left so nothing can add a thread behind
de_thread()'s back anymore.

Suggested-by: Oleg Nesterov <oleg@redhat.com>
Link: https://lore.kernel.org/r/aq0_lvHDViIpX_Mu@redhat.com
Fixes: 3bfe6106693b ("io-wq: fork worker threads from original task")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260921-work-coredump-fixes-v3-12-8e4adb1619e6@kernel.org
Acked-by: Oleg Nesterov <oleg@redhat.com>
Reviewed-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/exec.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 4f59e453cecdc..7833518692eaa 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1268,6 +1268,13 @@ int begin_new_exec(struct linux_binprm * bprm)
 	 */
 	bprm->point_of_no_return = true;
 
+	/*
+	 * Cancel any io_uring activity across execve. This runs task work
+	 * that may still create an io-wq worker, so do it while de_thread()
+	 * can still zap it.
+	 */
+	io_uring_task_cancel();
+
 	/* Make this the only thread in the thread group */
 	retval = de_thread(me);
 	if (retval)
@@ -1284,10 +1291,6 @@ int begin_new_exec(struct linux_binprm * bprm)
 
 	/* see the comment in check_unsafe_exec() */
 	current->fs->in_exec = 0;
-	/*
-	 * Cancel any io_uring activity across execve
-	 */
-	io_uring_task_cancel();
 
 	/* Ensure the files table is not shared. */
 	retval = unshare_files();
-- 
2.53.0


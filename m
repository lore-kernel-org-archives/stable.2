Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793212527;
	b=01zhkwy1oy+x29OH81Oat5fOLz214hKehgXQZSZogvzqGQa0k4Nmx9nCD5riI/Nkcze0
	 TG0xnYaIMXJXRkvQSmbJFVP1p5ij6kty5nY+gpkr2jlZVsFZsZw7xc98GoCKTZ6F9LhJF
	 52NNdyP87vPaXoscdoFNy5QTzkIXdHsu7jJhFVOQk/HuAzDuP+TIqJQx6xEoHZyIi0yXH
	 JWCjdzyR2fpEKv3N4Qj6Q7cYncRR5ww/xwq9xC78soITwrAIGrXXEPv92gp0I8GlAJSWE
	 DoIymJKV9rdDL6Z5qbavJhhQr3pOIEk6CeSPN9yhtXhW3lFWx9r8eTcZU6RKkVRzP1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793212527;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=PGxBXdvRYmeJRxvLbUDpVIAwOnqSFWIQWFkP29YxP+Q=;
	b=40FXFiU/zvluM7naaYsMI15qNPaQQM7x7mGk64hozqXN/sydFyct6Ub1sGlQ1ArWZTV1
	 O3yn73zFB2klePu7vijKXeTfDnmaumOjqkdw9q+OsMk9vnhz2wCkAeetwwx/+5qqm+jMn
	 peM31HQHfwXPOD78A1H92ncBN/8AP0RqX5QD+3WDTVuwLkVlQ4reeELO3BAQYEJUQE7nj
	 uLnEIaoLc2/SEsVi0+MfMKhE+9UtrCZpLaD1f2hhqVE5rnBkxCPO0tPPEqLRNk+vqg43d
	 EhUjRFFrKPtGkrnWDOcT0mpqX9bv1PeoFSuCtujC7L5bL1cWtwyzLcDPva8NcefFd1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LHpArxal;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324AC606A322
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 18:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LHpArxal
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 701361F01828;
	Wed, 28 Oct 2026 18:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793212527;
	bh=PGxBXdvRYmeJRxvLbUDpVIAwOnqSFWIQWFkP29YxP+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LHpArxalR5JoOc6/ZAZYNkMFEkKn07EI0VCOPwSht6aqWFPWGZn7NKrE1bSf6ikNu
	 DTZhlwEYJso2sBRqeF4AO18AfizzrEsyRMZ/6nhQpxLsmZmhV0o04PnRKwCoKXsYE1
	 Ol5vodjfzv3NEe3jYK6QPN1hcD2O9T6IuHVlZVp/0Wjy7G4cbsTbJ/thWIxzqKowbT
	 CT4dWclZ5mKNGLEsBBkQWAkctcRUM5/zwqwBMfuA9FR/uJXvTx9G91uMm59gm6/x3v
	 1JdV3WovSLxlrNyX43LscluWU8HIZgUbt/abdArk2bcmIi4Afx/e/YDy5+xGL8VhR2
	 Wv5BJHB5xUV8g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y] exec: cancel io_uring requests before de_thread()
Date: Wed, 28 Oct 2026 14:35:25 -0400
Message-ID: <20261028183507.1722382-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102818-cauterize-secluded-dd6b@gregkh>
References: <2026102818-cauterize-secluded-dd6b@gregkh>
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
index a5269b5e00df1..e738144cee6ba 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1160,6 +1160,13 @@ int begin_new_exec(struct linux_binprm * bprm)
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
@@ -1176,10 +1183,6 @@ int begin_new_exec(struct linux_binprm * bprm)
 
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


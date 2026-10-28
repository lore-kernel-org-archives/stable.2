Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793216628;
	b=1f+srn9z5dbhPCb4aa9NaOIUEhPR0YJRtafnVjuqKywktIAL4e/Xvp4eRUE6p8avXprT
	 IKWPsRCdQzJp7stIzfLpcLVf+SQ5BD5/os1sok4mjCkb2ug96OMgOFxXg6w8do5abX7MQ
	 9LdRbVa/+DeXZJ2ctTVnGtO5eUXO5jxJJxRokeTPgOwaIGrfA+VeLYdcjsRWd/KIPygDq
	 yHtCsUE9frcTvrPGuMg0h19OAF5RTz7TrDMoi+CGiKoBcmHHb0JbMBrlXFs0ICdBHK8f8
	 lYHcbPq07t1Iv992u43J0swTyqc9GJRu4z3G8Z7G3C+ZLDUMfB5IcJSNfOTin5CEo9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793216628;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=aYSkEtpq0pCqdur7sMsZg7kyohvC33OpGa17kLyyUbo=;
	b=bORJr7KUAYQH3N/W5h4gRMUHbk747e9IOtmmcXp7dFUbHM6nJrRkGNb5GaOCtOkauvPD
	 RMBKg4B9QuI4440CRAHk2eJbQi9j7I0pVTxDor9dRyyPGKKP73vY5A8xLZS69WGyYE0S5
	 M9Fb3hGM5rjaTYGF4vLp94ViH47RNaQH68Cq18XB64u9dHHl7at19OVDUXF1AdNQEnVnI
	 u4g1wgXWHS4mQpFlIps9Jay27NfPmNyUGBPv7Y1NUPdPqORwXXLMaLPJdd2DERuhhvfdV
	 KcCTSMrZGTO6G6hovbRY4LVC2MGyAzePVlx2DUgiEo2JBozEw3UoVNpqT8h/zOvpQBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T8QhqTw6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EFE606A31D
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 19:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T8QhqTw6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2EF71F01828;
	Wed, 28 Oct 2026 19:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793216627;
	bh=aYSkEtpq0pCqdur7sMsZg7kyohvC33OpGa17kLyyUbo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T8QhqTw6rMIdxsdxh2nphNIzAE0Wr62nrOTisuwmAXkf6NoS894Vr15eBMbSlw2H4
	 rNX+k7hApC9uuJP82CfH6m6XzTHqwVXKoFcd9o6T+FK4u3LzCKhYwpCQXy9OIjD22J
	 CSCTv8aJLpCFir8gv7PbYEPSyjmywHpMbxeLVFSNy0hECl1fHhEqU/sAS48L42BjiE
	 WOuHqE8wIeE8b7mjwe6TEjueaRcifvl6xd/MsYoWoGY+fskVoHpKaCiXuhWOgzrPVm
	 r4ZtvemaaBStDqgXgkgQ+u9onT0TqTaaEK8kNsRQYjxpaWH9+5hFm/VqLMPmVJW7gn
	 mgf303/46ydyA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] exec: cancel io_uring requests before de_thread()
Date: Wed, 28 Oct 2026 15:43:45 -0400
Message-ID: <20261028194317.2085969-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102819-underpay-angelic-b6e8@gregkh>
References: <2026102819-underpay-angelic-b6e8@gregkh>
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
index 4aa6905259591..3f301138e65a0 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1134,6 +1134,13 @@ int begin_new_exec(struct linux_binprm * bprm)
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
@@ -1150,10 +1157,6 @@ int begin_new_exec(struct linux_binprm * bprm)
 
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


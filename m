Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793218415;
	b=EyUrbggVFqWioIAF5SnqZcIzvt2ZQDAipnKzYwbilQ4dBMfBOWX2B0wz6h5T8EYQ1nNV
	 2i18rSC7z0LOsCl8AlplVpLSKgL2HYp19zvod8mPgvEdeUtpmRzz12Yje6hUGo8JiApyI
	 /THcFOytR+b0y5Yy+B1vuycFqFJtA4QcqGVPBbRfiU5JGFSegc58z/p0Srdy+4kKhR0aP
	 +v1MmBum/HKSU6Y+KdmtIXGoFzdNvc60lJZsBRnuOGWo8CgBGCL7qgtRxFoUj9U5EcH/I
	 NwtjRjM1viFOxXboS/sI16Sd6fq7hGMF2LkDV3Xt/8XjMhZYoJJQU1MCZEvgodXf4TQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793218415;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FxrjgfXmb0WFPqD0MLL3SKSNt9ImyVAxft9uZqXlK7Y=;
	b=FCKuejcYlV+xnxgcrQqaCF+MDoXYrVFNmzcNzyh3DnG8BYy3Fj9RtvIPZvCO+lit+RSq
	 M0G3jfG+A5RIWuf9UuLvc6ndAkkJ94SeNjKl23kyt2zJZea2LO4bwYuKEl+doWaV92JOx
	 eJXgXMhffJzCpMuai2V8Ap4gEgXHDlPfv0iAaKn+t+bZ6jMyyuF8eAzKp0ucSTwawDfo5
	 +vi5wfHVtp9/FXKiN/twcA6Ltid5aPTM09PhHKk1fd3bGr2yNzmBhzf63IEM/J2vMAPEO
	 Ag7Oc8R6XRg33C2AnpMgfQRED98lJCyOqBHWLg+0iwJhJs43lFBwmDIyNO8Mks4VUbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FernHeF6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFEA606A31A
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 20:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FernHeF6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 544101F01825;
	Wed, 28 Oct 2026 20:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793218414;
	bh=FxrjgfXmb0WFPqD0MLL3SKSNt9ImyVAxft9uZqXlK7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FernHeF6QGO7frZjhqQMSf8vJe4pZu9+kWRxFzVTFnBezVSJ3PaA6UEOE28RPFgcx
	 BI/dLXgU5npu5IaWrAg1T4/F8UXyG8Jk//XLeVD5tfPIXs9foSnLPyq3IOZ+mHWo7i
	 +k8Ox8K8SvhT0fDNS9cx6t+T3fZK+/yCBRvXifeoj7fQqL39liG27KpnjV6W8DmhBV
	 Jd4B8PZkO9WzZa+TV24kftG0hTY6CRH3sqlyupAbCvAR+hCBSkgVt55pm06QNfIbzv
	 hi/iX8N0rm7+xb35vx3x5pZRu02uFMfKxo4EcRr/1OQUVP9YVy2LY4MH0ktP4dpOdH
	 xQb+QA2VESBqA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] exec: cancel io_uring requests before de_thread()
Date: Wed, 28 Oct 2026 16:13:33 -0400
Message-ID: <20261028201322.2122828-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102819-flick-landless-21e4@gregkh>
References: <2026102819-flick-landless-21e4@gregkh>
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
index 829c74c7690d8..3c84578f48db0 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1257,6 +1257,13 @@ int begin_new_exec(struct linux_binprm * bprm)
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
@@ -1273,10 +1280,6 @@ int begin_new_exec(struct linux_binprm * bprm)
 
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


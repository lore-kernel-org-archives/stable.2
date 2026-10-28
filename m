Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793222950;
	b=gdJqRBSM70KsVn+ZlfGM+4nK5VNweho4IOT+qL5mSgDj39luxQbwsSqBAF8v0p6F+Edm
	 Khp2XvQwEibEFZRTF21m68o7OE5e1NuX+P+Pl26u4xegHw7AMzmLvTOS1KthOn32aMrmD
	 RIM68yHL+YEOPD8ee2DTLbqcwSuG8ixX5vWX/rBNAuC/72Ld8UDi9X/X5ygCpZzIEWVHM
	 pDP7GYwtXc8ABBJJBU/ft82ztIINcncwa8KOlXxKIJ8Z2/C+5snIDJl09su8muttGr0BC
	 uvs17m4tM1ZFAs7uI8Xs/PvxOdhSO7X9jwOzIzDSqst31Hx2NXDdzx1kbnFjrIKl8bQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793222950;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=DH6Vxuh3Tv9IQWE6F6iKwGK30v1MKjDFrks/fkKBbRg=;
	b=K/dd6SOQKvcRS00vHpA3/GK+HA+cJAEGSS1wFgk7j7LowjIhNATuduAYao8V4Y7XJ8eN
	 t2pcCUmomLdkpVH8ZS6cgh3/ONFbVh5EQnvHgKpE1uQHVEIV8R0FwamlemJ+DcVwaH8vd
	 X1Gwc96TSiv5VHeAYZQs8loAXcVuWHHdEodmM1fA3T1C9HU47sFYXTyTqJ56qm6JU0cgx
	 kuxzRLwOM2NV2r3SjREbCaTbVESq67skHri/qfpWnBHc8hBKqFqG9OpCTr3PwaJuNqqZF
	 HEbolO3lCCjGIjtLuFMBNK4VWE7qfefxwiIYg4WdS1k4tZAXfbMyOmPtXPJI9NsBkhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CXqQ1nV0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766B8606A31D
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 21:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CXqQ1nV0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 695BD1F01825;
	Wed, 28 Oct 2026 21:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793222950;
	bh=DH6Vxuh3Tv9IQWE6F6iKwGK30v1MKjDFrks/fkKBbRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CXqQ1nV0Lz+8CTDYlkrLYEiJuEQvv4AJbcp2g6YqRYj7s0n3YtmrmHdzPJAaWoJl5
	 f3n4X6TDZpyMj3NpncJ+XL7wVlqE84Vf5JGBf4h8vfwgDP1vH40q2CAv9MNhefrr5S
	 jc7AbFlpWw3zUmKhbflJsm2Q32Kij9zEsaeO89VtGfa08BHp/cg0y0tMxwX0eSy9C9
	 VVz+qr2zABdUQnNUI69W+xRSW22THmgmE7opP8yBGz/jIogszuFGrQwM4ssIJOceSH
	 EUmhtYPafbamUDgRNb5WeMfBpLe9IfTUjJxq4ei4ftf9lRqry7nQrrSrTNdUumiEvC
	 CCVk9OiXakRzw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] exec: cancel io_uring requests before de_thread()
Date: Wed, 28 Oct 2026 17:29:08 -0400
Message-ID: <20261028212846.2284935-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102820-emptier-goofiness-f4f7@gregkh>
References: <2026102820-emptier-goofiness-f4f7@gregkh>
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
[ sashal: Adjusted context around de_thread() to accommodate existing POSIX timer cleanup. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/exec.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 7391ec00a1cc1..05356a5122f08 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1261,6 +1261,13 @@ int begin_new_exec(struct linux_binprm * bprm)
 	 */
 	bprm->point_of_no_return = true;
 
+	/*
+	 * Cancel any io_uring activity across execve. This runs task work
+	 * that may still create an io-wq worker, so do it while de_thread()
+	 * can still zap it.
+	 */
+	io_uring_task_cancel();
+
 	/*
 	 * Make this the only thread in the thread group.
 	 */
@@ -1283,11 +1290,6 @@ int begin_new_exec(struct linux_binprm * bprm)
 	flush_itimer_signals();
 #endif
 
-	/*
-	 * Cancel any io_uring activity across execve
-	 */
-	io_uring_task_cancel();
-
 	/* Ensure the files table is not shared. */
 	retval = unshare_files();
 	if (retval)
-- 
2.53.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793214201;
	b=VH2B3aBHoXyIi6eH2qq9XUoX8nZ0UOum/2MsIleT3ySLAo29sBR8U+U5PiV4LhGv4whX
	 fJQL5h1YcB3C5nsTsfBQtiEU1ZnhogsG6AcnNTRoCHuVI2pgbqev9YtfBKzDJPIx5TwLR
	 jxGe6c+HOmOuJrCOv/gt/shN29NEUUR1qEYW8PWGJNkhJoirVrjxus8A2Sqv98RfLPkZ3
	 HNj0+8wEj/umglte9Gie+8pA6QnFs4vGC80sJ2SrO9xpYb04/U+DsVpDEaoXLFvQFoUoA
	 dbaKA7qml04eLR6HhlKc8jd1lNZTRaF4/Mkx0bjRXW6tdOvfew/CQ/Znz+kPwwadGHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793214201;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=3NKg7E602YNWIS7gNqk7cF6kW5vAxqI0J5F8mbPed8g=;
	b=upMWD9Wlh+AMheuXsdpz9krbItGq/wCLhJkxK+gblDZ/xNHt9waB2dAzDIyuHN5/SVcB
	 4Qzg5gLahhKaxVa6LjUn99DFtivljowp93PMpX9dczfAscK7qL+FtoHfO7rtzXE5djn88
	 /Zk20elscJ8EXzNW0EHaBhzWhqnMOXvVETktrpbdajPORhd4lth0Ti7n/fEUhMoL+cq+O
	 dZrTwOm+qwzW5dn473z5iPoJj0HbL0QquasNy8p07XuqMOg7UKedTXMK6mondGUHh3i9U
	 Yc8qo0Zq/kn6hkE6dGsc0AH6skznKRT3NzVFJGuU9Zt6qW+XTbtJ36pkMdkzGw1RUHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lu8p9hwG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02570606BF93
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 19:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lu8p9hwG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 382F81F013C2;
	Wed, 28 Oct 2026 19:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793214200;
	bh=3NKg7E602YNWIS7gNqk7cF6kW5vAxqI0J5F8mbPed8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Lu8p9hwGJJL01gG4czJzzRG1nXRJvhkxsXZFiLRC7323aPKJFt0oOWpJ2701BF5Ds
	 3bPB3w7Ze03qspvVt/Zp2tsnEkFTVRkTP0xT1fj9Xr1pw82UgVkiEdOcM8y5BtFtFd
	 bpww4wEcqAJJlMuOqPeEgg6uK0ZSKmN1EKTMGvmcNSLSbVCOJ+gD4qZtv6ZSq/ROJH
	 DMXbysFdu+TLCQOjrvaqX7RFSBIKWFLfI5dEikfSrIKais1FO3p2pev5bESSp1vXEy
	 aDHhl3eDv+GCsajmNB5o5nZ9oNktJvibaeIngcJo9zs6wvVouWCXukCZ3FD4K0XI01
	 t6IPc4NvBLZRg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y] exec: cancel io_uring requests before de_thread()
Date: Wed, 28 Oct 2026 15:03:19 -0400
Message-ID: <20261028190311.2073244-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102818-halt-spruce-26fc@gregkh>
References: <2026102818-halt-spruce-26fc@gregkh>
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
index a598d48b5ffcc..bd3e3aac90efd 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1145,6 +1145,13 @@ int begin_new_exec(struct linux_binprm * bprm)
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
@@ -1161,10 +1168,6 @@ int begin_new_exec(struct linux_binprm * bprm)
 
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


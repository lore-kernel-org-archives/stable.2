Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DF14AA588;
	Mon, 21 Sep 2026 13:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789998351; cv=none; b=hzbjJH+ogrNENtrMNjvIINtKt1SQY1iUrdZCs9UMbYKxXrgmVC7yFrRiM+98GlIW/mFKd1TF4NGQVvcF4hpu9Ep/2AGTC1C2UnylioUSooLy/7PhrqQa9TwNnFY5YCbb9VFIGf7qsIv1S0Olu2si3Y/1IDE3SHW13wbCeKN/u6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789998351; c=relaxed/simple;
	bh=E2TTe46dbf8f5z7wtULy+9nnGSgHQ2lB5ZQgulfnziY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RTZ27VLUDj7jsk8xGlTdGBCJyHpk7JP2VYq+3Uc9yL/ciUdPJRdWb59dYPVzafMeMkOfLLvVhHKVJw5had4xRq3HubFuvHF5ErMfxQRpSqvAEWbBhg80+d8ngx2EyWwP10w4X2LAcUSkOguU8jB3BJuqyrS1oq/s4ycTt3e1HBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CgZHKp3f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CgZHKp3f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A44CE1F000FF;
	Mon, 21 Sep 2026 13:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789998349;
	bh=7befY0H1lv8bz0CNNtoWy7rE2i+jj9bv4BeRmq6iXmU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=CgZHKp3fFsHD6pZE97W2eHD0S/3+v5Jskr/Gt2dFx6r/HuEBeQMiDXtAjxQWCqXp4
	 cLwxQU3j9NQXW9pDWvSy8koH7wakDDu7qYjJRgKoVlB8esyac5o2s5Qy/byRZTJDyH
	 8zj5PYZDq+yROLWGS5JwiupukUpGrmt6rWYhMmss5MbzhuxwrYb4YqlO6xmHL8yy0u
	 ZMauVv2gS/wowDY2H6lJUXx+uMf76vsUV9dCsxzN/2XocDAdmaIlq2XQU1jyOXzyOW
	 7oLI/s4Tn0cGNXGkAMqODU9/zcSlSF8i/XxDig3vKaHrGIaci6i1+TQj+O1XyHkNBW
	 7Og2PBwKLddRg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 21 Sep 2026 15:45:01 +0200
Subject: [PATCH v3 12/17] exec: cancel io_uring requests before de_thread()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-work-coredump-fixes-v3-12-8e4adb1619e6@kernel.org>
References: <20260921-work-coredump-fixes-v3-0-8e4adb1619e6@kernel.org>
In-Reply-To: <20260921-work-coredump-fixes-v3-0-8e4adb1619e6@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>, Chris Mason <mason@kernel.org>, 
 linux-fsdevel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 linux-mm@kvack.org, io-uring@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=2082; i=brauner@kernel.org;
 h=from:subject:message-id; bh=E2TTe46dbf8f5z7wtULy+9nnGSgHQ2lB5ZQgulfnziY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRtNLlTFOJ1IImRndEjO6tTMrTxl7/dfrfjKxhZvNn9+
 I+xJ37tKGVhEONikBVTZHFoNwmXW85TsdkoUwNmDisTyBAGLk4BmEhiIyPDDMF5X7h1WBpmPs5M
 a7yy/qhty+TYX6K3bVenhD1XbZ8GVHFO1VFadPY/X8YfQVEL2nIkrD5emJcf7N3La+vy3ak1jx8 A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

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
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/exec.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 075a744421e1..334e6d358c56 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1149,16 +1149,19 @@ int begin_new_exec(struct linux_binprm * bprm)
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
 		goto out;
 	/* see the comment in check_unsafe_exec() */
 	current->fs->in_exec = 0;
-	/*
-	 * Cancel any io_uring activity across execve
-	 */
-	io_uring_task_cancel();
 
 	/* Ensure the files table is not shared. */
 	retval = unshare_fd(CLONE_FILES, &files);

-- 
2.53.0


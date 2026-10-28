Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793206534;
	b=2z6Z5jTlkaQlFcwchQOPXgqmY0axx84/SQ1WROS2DDnS/mJLrLI8V0QgDInDcCMQVaR4
	 Yl4SO/FKjwf90719vnh23MYn3B7R31eGdW8qhj+WKW4Quos/h+rlNa2a1tP9vXHxY4mwG
	 r1qJnHbbw4vMH/8k37KJ6OVrwpgwS+7S62hMmkhzx/Ilil5zYUvnZgUVDIv6U4trPF738
	 q02JEy75q6QbnhfzEL0SQxGGFO3+midbQXx6ExoDPhoG0U7pn4YI9pH0JpaSVUn041t6s
	 b8wZfjYUz5wtD8MSKGa0oua6hL8MRp+D44LNSbD00J+ptn4Sj5VctpezaQUZOp9KMMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793206534;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Ma15neELvhvz2ryIeZJyOfJGuvV5Nz4drDvOI92YpG8=;
	b=XVLgVl43Ifn2UMn++4ZKdqajSIzSuwRajTTH5M54QjuW45kSYCdULuaISIYIc3t8o8gK
	 pEE3tOKBwvlKXof7Lx1XB+lg+xIi6smFEqdlGxv+mwgQXcxF3FK5/uZDvCuVS9mWSIvUu
	 nChjxEOSMds8PNZqb7tYXCL/hghZksevwee3+0GF4PulBbCFF9ZBjVaiWYt2gqUVT4dPi
	 UPDVmgablcju5nLGmqsgZerru7XSRn0W+YnirJLuOMUJhpZhlHXy4bxkjLhLzVwHwtZ38
	 uMJoOBlrl/L5QkKvfJ1jlM5xd9LOt3R2jr/yXerF3YU1F9VH4+EZLlIE9OhDnWad/ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yom1dx0F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D00606A321
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 16:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yom1dx0F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9437B1F01828;
	Wed, 28 Oct 2026 16:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793206534;
	bh=Ma15neELvhvz2ryIeZJyOfJGuvV5Nz4drDvOI92YpG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Yom1dx0FzkH55B0hqeY9K5egtW0j6IZIsvTOAOel0ONok7YdTxtPkO/NT95bdn2uC
	 V+myEX2g5xBCGWjZW7oPNEVVcMd8QRifl4GN6mc279gwZm/swKTJ6PYFNvu5rEcFBq
	 OBn2qwoxQLw0X97Xm6Gj9qjs5E7Jxm9+KzU9pkKNTrOffGkhVhguiHKCUlT9Putx+3
	 2lu8+MY8hXOdpyNPnZ4k5ZQLl79zw2XFdaiw4P5x71deMdLq3yUyshN12ZCxgl4qgG
	 RzvmD+bjZnWZdxFRsc1s2PHJhcL0ANtXFCU2zTpI1oNm+7/WRxvIBLpsZRHUsPijF1
	 nwSybqGFuhHSg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 2/2] fork: don't create io threads once PF_POSTCOREDUMP is set
Date: Wed, 28 Oct 2026 12:55:31 -0400
Message-ID: <20261028165506.1601934-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028165506.1601934-1-sashal@kernel.org>
References: <2026102848-foster-escapade-ec01@gregkh>
 <20261028165506.1601934-1-sashal@kernel.org>
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

[ Upstream commit 1f978881ce6c9ac4f4d4a7b6a6e52339eadcd350 ]

zap_process() skips every thread that already has PF_POSTCOREDUMP set.
Such a thread is past synchronize_group_exit(), so a coredump can't
catch it anymore. It isn't counted in core_state->threads_remaining and
it isn't sent SIGKILL.

do_exit() sets PF_POSTCOREDUMP in synchronize_group_exit() and calls
io_uring_files_cancel() right after that. The cancellation runs task
work and a create_worker_cb() that io-wq queued before the exit creates
a new io-wq worker from there. If another thread started a coredump in
the meantime that worker joins a thread-group which is already being
dumped. zap_process() never saw it so it was never counted. But when it
exits it sees signal->core_state in synchronize_group_exit() and
decrements threads_remaining like any other thread.

So the count reaches zero one thread early and the dumper leaves
coredump_wait_inactive() while a thread it counted is still running.

The task has no fatal signal pending because zap_process() deliberately
didn't send it one, and it never went through get_signal() so it doesn't
have PF_SIGNALED either.

Refuse to create an io thread when the creator has PF_POSTCOREDUMP.
That costs nothing. io_uring_files_cancel() raises IO_WQ_BIT_EXIT
before it runs any task work, so a worker created from there only ever
gets to exit again, and io_should_retry_thread() doesn't retry -EINTR.

Clearing PF_POSTCOREDUMP for the new thread in copy_process() was the
other option. It makes the worker a thread like any other, but it only
helps while the dump hasn't started. A worker born after zap_process()
has run is invisible to it whatever its flags say and still decrements
threads_remaining on the way out. Refusing to create it covers both, and
then no task is ever born with the flag, so there is nothing to clear.

Moving io_uring_files_cancel() ahead of synchronize_group_exit() closes
the same window. It runs the cancellation, and whatever that can block
on, before the thread announces itself to the dumper. A thread that
blocks there never reaches coredump_task_exit() at all, so the dumper
ends up waiting for a thread that never parks. Refusing the creation
leaves the cancellation where it is. But it's very ugly to run io_uring
work even before we did all the generic exit work.

Fixes: 92307383082d ("coredump:  Don't perform any cleanups before dumping core")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260921-work-coredump-fixes-v3-14-8e4adb1619e6@kernel.org
Acked-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/fork.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 140b41702c8fe..26b666e98bb8a 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2718,8 +2718,8 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
 		.user_worker	= 1,
 	};
 
-	/* A creator past its fatal signal gets no thread. */
-	if (current->flags & PF_SIGNALED)
+	/* A creator past its fatal signal or its coredump point gets no thread. */
+	if (current->flags & (PF_SIGNALED | PF_POSTCOREDUMP))
 		return ERR_PTR(-EINTR);
 
 	return copy_process(NULL, 0, node, &args);
-- 
2.53.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793207628;
	b=HIOfrR5w7aYGxTYMFwpQbWwBz2+F1xQE11MzpXVJEsG9bDQv31o2ryrtlcpa3m7zg4Lx
	 8JY0e846Vkpdrzv4oBmjkRJZSGKrsdHM4sqB0Xy1nyBqIYv13XNeIGUtTXcHz+OVPkcED
	 +Owo7XofWPnqDpF9B+E91wjOmzrNznNPXkXg398Oh1FkiYtr4tiMvyicbvbCxFZ+F+4ug
	 2vmo2RedVMTWEmNd7vEamhY9F6bUiw0KoXE6IDcyv1OhFqyy08KFdHh3fkmBjjU/rgTEW
	 p3yKSd/CI2qvaE8wA78rhdquBuKpuS4kqG2ZJRls0zukqcvR2GqbaH1PE5LpvtpueMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793207628;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1FFZLlxlYjtOhAC0d3CJurEuQhAKb3ZmKX1diPj0Cns=;
	b=PHZxySJ4oun9MHEsulZ/DAy5OdrJ7VBhe85DkmAzjOvR1J1iAC75AgNsIpeCUjfzCpGw
	 FmRveKs5zZOKWMluwFhyWWJCl8vrt2OMI9WBg3M58/KMFIVh4EemveACGmxmVJvE0NzA7
	 hVR/SFwhVMSnopLkqgq0W0uVJkTrwuRslNarIs6CQPIEbMLDBXvq8vyuul1Yr7w7Y6EDO
	 xtn1cW5aACC1RVrS7+VbrJEvoTc2u8hlB09idbb5lISmi2QDCMWZcEJArp4p7Avvg/UEc
	 RND/pZW0QGVHTV81+ceSXYG5/wLV02/XXrqcYrlASEqUpLJpaHgCxtUwEyKcWXLgNhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gjX7AO1Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F95606A326
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 17:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gjX7AO1Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C985F1F031E2;
	Wed, 28 Oct 2026 17:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793207628;
	bh=1FFZLlxlYjtOhAC0d3CJurEuQhAKb3ZmKX1diPj0Cns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gjX7AO1Z+50qDDkjCy67Sv7aNa8MN+X5lBEdGZqw2RsKYFXWy1aaPVK4zfpQk3Rju
	 Gh1t/NZzUQCaImjZW44CwK6bfObGLMSMbgqFQNt7VKZ3WY2IvDqePxy4OW868C3Ept
	 skzs/PMp66BIAa5HseNi9V4H5M9l1S/fLcWx9113jeTTLPObrg/wZqzoowUuSC4ixv
	 6GEv7IkIIsSqdPPajnSDJedOagbHKJK3oJHHh8QCIA2RxBvfY0QlDPgrt/tq0og1p2
	 VObmHu6/d+jX0vKjE/WfCP92YMsmxBAw5YZjiW2lVnLtK5i9Hzen19Nco6WBdlnRLm
	 zRkliA6JAwk7Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 2/2] fork: don't create io threads once PF_POSTCOREDUMP is set
Date: Wed, 28 Oct 2026 13:13:46 -0400
Message-ID: <20261028171308.1613661-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028171308.1613661-1-sashal@kernel.org>
References: <2026102849-headphone-cattail-5c79@gregkh>
 <20261028171308.1613661-1-sashal@kernel.org>
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
index 73239e4ba6fa4..00159e2898d55 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2689,8 +2689,8 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
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


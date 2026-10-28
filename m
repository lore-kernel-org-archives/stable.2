Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793214217;
	b=CVHjXsCLKr+DMleQVoLg9ffw3AIe4+jG7b0EzfiA28OA5veBsInLAQg7cy6RY85Jib7/
	 eiLEcfsRO1OjlbsPlTPBeNI+mQCdlgBWrBj06W8vZyZl6FWUIuHYUe5O7CwZ8Ao4JU02A
	 nPdskcgQPZqu66PUztYy3KEetDCdbBBpIYpcG9l9S2ToYGTW8CSdDOUStCcytNNB9ibbu
	 Ud77cWsnEVeStPGsGMvD8sglqlx5ChIXrMVQOI3CncYQEb4xkqKkjw9QX6q329Tng0LcA
	 0QAfCog1pfduYlpxy4FwXVek5bSWMY7Mz71a/+DYEH1vk4nvFwmbBwl/Bb361w8nZyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793214217;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=C4ny3E/DJgx+poTEqKzRisjOUtArQtOkrV3V2Ih9C3w=;
	b=M1K6FqwLvkLW2loNo3DMvNgNPWDpmZAtjLXU3BAaTcDTMkn8W/Yf2v6M4QhDQ2oqt+mt
	 KvOYjBho7lYgw6IEei6hftGEIG4P5O0nkismhhSYbnpCONu6pvXAhjM0+vSmkluWOSiNy
	 QzynsSO2fkB2bXik0ujP7NmvYNKEJ3/+19EJf+ZU4lRILcJroy6voyC92mcVNNo+OB7KL
	 FqysjRC00E5SOkcr6GLU2QxvYzIGoTNruuGjICJzMJ7X6SsBS9w7HebTRjmqeUFX6TVNs
	 VTYDUc3FWVRl7soAUKuN715FLrR8azuP5oHG4GJYUYsNYCytVCGOnMkROYUq5K+KQmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aGRJMFpG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0F560A2620
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 19:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aGRJMFpG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AA041F013CA;
	Wed, 28 Oct 2026 19:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793214217;
	bh=C4ny3E/DJgx+poTEqKzRisjOUtArQtOkrV3V2Ih9C3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aGRJMFpGxfHYxLDfD7frrEvOGd8RxOJuxylXC9yA17+cfxdJPUJIeMd+pA1VlIJ79
	 EguWhhR5KFIWzixvcW/K4yGVV1NWo9URYQ0VMb6m9Vui8VYnA9ikqIyz3IpHlsSlVV
	 iCGfURVSWNQU1dgxw6Bj30bZ/RhUxxmFj25fglhoHvIWnr8t1doe5ZJwl9fkWG3InJ
	 EgLCbEW3jSeTiMY5lH1zMZIUPGyDZ6I+q6S3PnAF37gEip7CHYxcgTMWyCObKQEjUO
	 gQXUUvB3pctZm8Rf9UVBItUyUCqfASkg0LEeWWnMwk8egprLEAA494p45D1ka19OMC
	 Yrp4wZIEmJKcA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] fork: don't create io threads once PF_POSTCOREDUMP is set
Date: Wed, 28 Oct 2026 15:03:34 -0400
Message-ID: <20261028190310.2073874-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028190310.2073874-1-sashal@kernel.org>
References: <2026102850-unleveled-version-e04b@gregkh>
 <20261028190310.2073874-1-sashal@kernel.org>
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
index c82956f8fc9d5..140a615daf42e 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2774,8 +2774,8 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
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


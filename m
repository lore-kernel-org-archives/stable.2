Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793216687;
	b=eURBI5m6oXOAHF4KMMqiOsDaLcV89e+yoJ0W8SaslRujokxWLA6iJyKuk/Okw2KSLFE4
	 vuF5+yrRRnPpwWr95Vh387RN0K954E6ycW4578afTS14EJPNyjfd1V68pcNUkMdXvsS6J
	 ud/ZYrc9Og5iM1E2xDRn84zMKLy4UpLAk6Gbod06JuljuYuX0YEITs8rWcuukGLuMZ2qP
	 GKKx5d+0scM5xDkBVkRecbIM2Li9TZrz32sxUmA5F0wQLy8WXdtd2x/4uSp2rYW8XFh+m
	 TLc3PgfmOtds5z49BP0kwy85ESwfLwxnJzMTPGrfqKaOBHrG6CsmDefb0M+lpZ0yQQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793216687;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=f6p9sSFYMTFlABD/3wtyGpv+vgICjzwWvJEdcTAImTA=;
	b=IL/3pNY0IC6mzzQBIhV/5mkcMZPja0EqJf6sbUFvdV0KKoxl3/YJQEO2xArLKuo7C/6O
	 8mNaaR8YNSjmVLkgR30vn1l34wTl7y9uHhy2WTkC1UMS2i0+M2KP5+jPIfwoeZSkxKoZm
	 c3ZMT/gUVm4Sqhe6+RyERxT3zqUlyIIineLBJVDCqmqIBjKjGXZQgvc8U8/yV0p+oO3Tz
	 k0tSqYRO1aTCCvnzzrTn6xnSfO8JX2ijVG1LJvJ6zVh9MeNNoABNyKYThUEl73evOuaVI
	 6U0x9TQqsjJBFOrjnHt66F+1syL7MINmGuvoFbhinYlfZgwluJhpX30h9b3HEJUs1OA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="mrbe/c3f";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDB2606A320
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 19:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mrbe/c3f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A548E1F031E0;
	Wed, 28 Oct 2026 19:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793216687;
	bh=f6p9sSFYMTFlABD/3wtyGpv+vgICjzwWvJEdcTAImTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mrbe/c3fukymh8doFlc4+lcFGfeJfhpHEdm0EPe70kJ7O34IMGKx8M9HaW6uSFnxp
	 JNUutwWS0bW+CUUcclC4hEJi5m1W5zkBQdP6EOhJVLmCcMnHFZokorBreXqm5qFCQ4
	 DU1jwFxXAjqVowUfaIWHZzwcvbPSLfu+23epoWu7syvcCCUrtuPJmgSdvrsyVurd5I
	 gETaxPNvRFDLEVoWFGoH1VD5kO8th9oZixn6TSFnoBy7Bk7h5tPnFYNghcTObKCmjr
	 UlPrhqY05cPJWYFwr/IAzaB4BxNhVJ7ZKikMT4vAGx4MnEgpN6M040pOuVI0TOp/su
	 KZAhc1I/8e9Cg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] fork: don't create io threads once PF_POSTCOREDUMP is set
Date: Wed, 28 Oct 2026 15:44:44 -0400
Message-ID: <20261028194315.2086603-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028194315.2086603-1-sashal@kernel.org>
References: <2026102851-facelift-wand-29b0@gregkh>
 <20261028194315.2086603-1-sashal@kernel.org>
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
index 802bccf2dea74..fd10c6e0dcfa3 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2867,8 +2867,8 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
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


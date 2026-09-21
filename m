Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA6B49F134;
	Mon, 21 Sep 2026 13:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789998358; cv=none; b=lS8qz2ynnMRURmZxKfcc2OS3RXNrkRavjcXrUMcGuKU2UajuQ1/HIspg6r5yPZG8YaKlgKWCYIGpC/o81/t5d/5c5lWK7U3P1vpOQ66ERbEtNWl77CaW6geXgPbZsvU/ej8g8D9BhJfhc2Wv87b7Zlo9M7P8Wtqdi3Y/5BoLXWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789998358; c=relaxed/simple;
	bh=zoAjWyKOyUgPqF1bbSF3AwhSePVYVar4GdEnZBsVBhQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SAcy+QIvcdmzCCj+xG1a8fO/Slh+4zYNMpYZBxCkLQ4ugpuqYdo7tjJkqMogiNQd0tF7qQP4NBz7pPNHRzdUCaCeYYxWTyRicZCY1SsXIPDNa48eyw0AosW/0sThZF5AXIl5OZmaMtezEveMO++FxYOlq+LRDWvKxP4CVo0UuAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMwCvx+g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMwCvx+g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B28351F00898;
	Mon, 21 Sep 2026 13:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789998356;
	bh=Yum+7Pr6lS50dqU+FC2rpRw3i/SJGmY4AJWUq/e3VWU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=aMwCvx+gn1umn2ChfLIavLhDIPn43P8WjESWGQDCfWP2m1/7n5Xj6t19wgs1stBkb
	 Gxdl+Ro6Fglgr5SxerB+KvB1Kb1mAlR7V4AnZanB0xRXQ83hOZ3yGfWy+L48koM6YX
	 QXtwmvdVce4mVd07LW4YReMwKbY+X++Aj5Oir8qaGtU0Mmidi74wsAIZYS21ryH6bc
	 BblTk5uXSs7WaCLPRzdhL3FwpAWt66FwJni3FrS078hqESMIGXFQ9djiltAZ/D1tFF
	 XeckPf1xrrWqaz10YTu65+t3OAJIQc9eFWNK2o+c4SAkX4jVOuC2J1t+t9pIA8Zqjo
	 rhEIz5g4mmWPA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 21 Sep 2026 15:45:03 +0200
Subject: [PATCH v3 14/17] fork: don't create io threads once
 PF_POSTCOREDUMP is set
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-work-coredump-fixes-v3-14-8e4adb1619e6@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3140; i=brauner@kernel.org;
 h=from:subject:message-id; bh=zoAjWyKOyUgPqF1bbSF3AwhSePVYVar4GdEnZBsVBhQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRtNLkbvVmXz3qNnbhOQ0KrW2qR3M7bWyNltI3WPV0SN
 SntrszpjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlsvc3IMN/ulaoL0zw+9vCG
 b0xTZa05NTd/N9ac//mDwI7AU8+fxDAy7Ll792DwfTYbzwl/78mbr+48nHPqyBfJjh3ir9e9y3t
 rwAYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

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
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 kernel/fork.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index ede9f02bef47..fd2829b0a8b6 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2706,8 +2706,8 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
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


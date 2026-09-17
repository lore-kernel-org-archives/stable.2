Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9AC59D605;
	Thu, 17 Sep 2026 16:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789662844; cv=none; b=IJhflYOTAnV+9MU8S1gLJsbW+54d+67q1jU0yPw6tU3DoVPa/36WY/FyfpjnKVnz1cbZ+KC7K5CsN8WxDYRKiH+hPgWLITwjOviOvbtZMhU9fgOu03dEntO5o3iXs2ysu8ADIiL8Ahq3QJ8PH6bwCuX0mXnfSaLeA4JgtX+uNVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789662844; c=relaxed/simple;
	bh=CjOISCKmtsymM0NxmM27RvcIwZJWN4Y8O6fHPpTHVYI=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=cIu9PJ06PyZegk5YUKxG1xx4FSgpe7lSGvgqMBgAcW2WCXjAsPdTYkNGZ+7MgA3nTkMto/aoWHM1f8mRUpWbCKKiRGmxmFoYaXDzqeEqsx7TgzVuo95yV5f6zXxLVvY8VZfDNK9KSiOqhwPYY9SU7uplqlhkU0/rOCrL9eIe88o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=fDZgu8kR; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=x233iRfU; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="fDZgu8kR";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="x233iRfU"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1789662808; bh=QFdjS+vJrDLwqH4oMbfhGUP
	HwfINklrDgbElv6JofZk=; b=fDZgu8kRWaAN4Zqu+tG6VI5oux1eBHXI2Ogjf70ktXJ8jC/fm4
	wu0lVFNDQIBSXVh9X5r1s9KOslrL+p6OpbhD/MIss1elNlqwqY6GGKkLB/J+Uc8Ai7XZtdhz18a
	pAd7rDXV346c61lYwm6rdmlBE6DDL+J3r12WxSJK185IbhpCtTmnGBqt+6xKYe1mTO0YcxdcWKA
	ZlK+9rZIvD/ovpUMp6M4+oJ6N3BoeuNfJzA8tljsNH/SG7KwLMf++rkVYzqH6o18fhckCmqt20O
	LoWHecgXVxFfVgrFZuimUqk8My/sBix0ELNJyLJumvTAIlrPW3q/t6QlTbua4Z2L8Sg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1789662808; bh=QFdjS+vJrDLwqH4oMbfhGUP
	HwfINklrDgbElv6JofZk=; b=x233iRfU6OhN0H0aU9yM3bAupMtolHGlZLwGIyOludR063+hBv
	BhwyeQrFP+s3pd1CSSXvp1iVC3O4QkiU6PBA==;
Date: Thu, 17 Sep 2026 17:33:28 +0100
From: Bradley Morgan <brads@mainlining.org>
To: brauner@kernel.org
CC: axboe@kernel.dk, io-uring@vger.kernel.org, jack@suse.cz,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, mingo@redhat.com,
 neil@brown.name, oleg@redhat.com, peterz@infradead.org,
 stable@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_1/7=5D_fork=3A_refuse_new_threads?=
 =?US-ASCII?Q?_while_a_coredump_or_an_exec_is_in_progress?=
In-Reply-To: <20260917-work-coredump-fixes-v2-1-f3787fcda051@kernel.org>
Message-ID: <DE006398-EA21-4849-8EF4-4ACD66AC329F@mainlining.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 17 September 2026 10:17:28 BST, Christian Brauner <brauner@kernel.org>
wrote:
>Say a SQPOLL thread is a member of a thread-group that coredumps.
>The coredump code uses zap_process() and sends SIGKILL. The SQPOLL
>thread uses io_sqd_handle_event() and calls get_signal(). It removes
>SIGKILL from the pending set and returns. The SQPOLL thread breaks out
>of the loop and drains its own task work.
>
>Any pending io_req_task_submit() with REQ_F_FORCE_ASYNC creates a new
>worker when no other worker is free. So it ends up calling
>create_io_thread() from a thread whose fatal signal is gone. That means
>copy_process() allows the creation. It's also possible for an exiting
>io-wq worker to push new work onto the SQPOLL thread.
>
>zap_threads() counts the number of coredumping threads. The coredump
>client waits in coredump_wait_inactive() until all threads in the
>thread-group are parked. The new thread exits right away because the
>workqueue is going down. It inherited PF_SIGNALED from its creator so
>it links itself onto core_state->tasks in coredump_task_exit(). The
>problem is that it then decrements "threads_remaining" even though
>zap_process() never actually counted the new thread. So the count goes
>to zero too early. So either the coredump misses the thread or it dumps
>a thread that is still alive.
>
>The same race exists during exec. de_thread() zaps the other threads
>the same way and counts them in signal->notify_count, and a zapped user
>worker that has already dequeued its SIGKILL can still clone while
>de_thread() waits for that count. And once de_thread() has cleared
>signal->group_exec_task the exec'ing thread itself runs task work in
>io_uring_task_cancel() and a pending create_worker_cb() creates a
>thread after the group was made single-threaded.
>
>Close all of that in copy_process(). Refuse to create a thread while:
>
>(1) SIGNAL_GROUP_EXIT is set (set together with core_state by
>zap_process()
>(2) signal->group_exec_task is set
>(3) while current is in execve
>
>Conditions (1) and (2) are handled with siglock help which means
>copy_process() and zap_process() synchronize on it. create_io_thread()
>treats the failure as a failed task creation and doesn't retry.
>
>Fixes: 3bfe6106693b ("io-wq: fork worker threads from original task")
>Cc: stable@vger.kernel.org
>Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
>---
> kernel/fork.c | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)
>
>diff --git a/kernel/fork.c b/kernel/fork.c
>index 10be4a0ecb3f..6cd167a2b27b 100644
>--- a/kernel/fork.c
>+++ b/kernel/fork.c
>@@ -2491,8 +2491,10 @@ __latent_entropy struct task_struct *copy_process(
> 		goto bad_fork_core_free;
> 	}
> 
>-	/* Let kill terminate clone/fork in the middle */
>-	if (fatal_signal_pending(current)) {
>+	/* Let kill or a group exit, exec or coredump abort clone/fork */
>+	if (fatal_signal_pending(current) ||
>+	    (current->signal->flags & SIGNAL_GROUP_EXIT) ||
>+	   

Hi! This LGTM, thanks for the patch. 

Reviewed-by: Bradley Morgan <brads@mainlining.org>

 

--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/

Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795394119;
	b=3diqTi4pLP5oObvgteQy9e+EpxrghWRE9CvpXSazNEoailAGecglTtVoWAZe7xE1mb2A
	 HuPicmoQWhJwLRUqkYOBLz3WD95LB2qBA4KOmCyRtrx07isjySJTmA4UQO2vgLwA+sfYx
	 tbaRGP87ojYPUR0XbSMetwLSc6uFOxoJtpE04xjZEZM/pb0NF2tQ+dIHJ5tNkjpIWWS+b
	 w31mJSvvhmz+qq1UogJwPTvn0X7YH5MJ9/B5H0YxSbbnuak+KcTL15jNqGfs0+/oahCL9
	 ZD4IyzXqDukozqx+QIqSywy3Z8yB1zJzAnR3xVzzde+dtk5CaPfmMBPCy83PKaKPpHA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795394119;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Aw0e5y5c8i9wNYCWYZcYSwD6rNylTLyRH1SurU5T/II=;
	b=Kptj9lJQv5wC8+irCt/TN9apJg3YY47eurC69FmOLd08LJH1nZNqVu/MKsjq7E6uRzTU
	 gwVSXb7wBH1/PX54/AVuRZXA3SfGhsGlRYgEvSxud6E17LN4TPVYeiDphxxtki9xHmQEg
	 RQKtcxFdybsYgsIUyX8X0iYfo9ijz5yZOnE4PvACqNRjDvzlGWVTkyqzTC+V+e/QNt5FV
	 7HULS154QULq3gYhn80qfyRPem5i/ScpsifMtUyReOqllTLZuqH9mpAci/T8bRe3+Ham4
	 yILaNWH5QXW6tiNbDac2F876L8Wn5/R/roxn2DizlCize7pFcpv20IGXDnq9S2clx4g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bi81H5Qs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17BB606A335;
	Mon, 23 Nov 2026 00:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bi81H5Qs
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795394119;
	b=ZRaYt6iSQ+XdeGsoPYWRM7Mntlf40YbSFfosLdM492pd2Er0BBR4Y9AuDeAM3H4OFljf
	 qibb3dphxvZivls/MWgH17d3N2W8Z8lbpg/tFI+MzXaXTTEBf3UE0lCWN6pJMzHcZ+jk+
	 uDY7KbLlIdMygB40deMcPjeEUpzTCAP0POpMZe71mAH34vwHajjNBv1MPNjsM1dNtGDEM
	 F4xuwUiuKINSFf01CJSBdHua+lShH1Gm19/J1aeF7hcLVMaNEpxoLGa6ex4cjwjSFjcUG
	 b+pnclFvhpsybiRIAY+rDpI0jSXtWFw2x0OMPEI8CvX8MnB075Hn+/OzVRJHFgx1pbA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795394119;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Aw0e5y5c8i9wNYCWYZcYSwD6rNylTLyRH1SurU5T/II=;
	b=yB1CHOMwPRMoJ4saKhRcV3WKCOayif54ulcW8cGKryjsAVWrxpy9tTq/fzU3l+qFzqg4
	 ULNbfW0HRLMDHQmakWXhljetRTerf9DuTgo1ir8YHjxMCseVRm8/pGQg+nkbd89QExw8C
	 CmkKzNNqUEu3HL/4JIkwNpSUYnwfekmbvClS8TQkCRlQyuO/L+dYtMteWB9o0ApyvLcg0
	 g9k7okOqg03LnfTtXFIryCyRAB5bjHEiqvcF7kR7DjsVO5HHUIxVt0zQ1QupzJJa2Czq5
	 wIaARADUNtmMShwEdkedUs3Mtyd/EcvjGhqT27ajsSYw6B05B9p5tVziBMU0yJw0ekw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id EED341F000C6;
	Mon, 23 Nov 2026 00:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795394119;
	bh=Aw0e5y5c8i9wNYCWYZcYSwD6rNylTLyRH1SurU5T/II=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=bi81H5QsX9pC2wnI1jjKZxU4I8nB5fWBkSLmikTK11DTGIKNEiUClOVGvEiDowN/N
	 iNw5n4/4vl45lZ0UzK2VKeONLzaP2qHimygwZioGnYGfenm8n6BUyYQs+P1mIVWHrn
	 AZQhxNMVYVyFS/IyywBoZcshRUBnKHZYpBZBJQ1ekQqDhvHw3gP7UHo8jjyhkvPUd0
	 WFc1VEfM4CTRLGKqMRExSJXlToA992mlbP6JevMLyXxiEwgcqRU4vWb0Q3HaT8ZdCl
	 6WEyFkN12pbSaYk7vDh2HQeGhKsPrUOckTMKvyHiP7oymrM0ANwYVsCCFPsb0imUse
	 JfcbshCTTHVNg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 6E68E4C268;
	Mon, 23 Nov 2026 00:35:12 +0000 (UTC)
From: Mani Tofigh via B4 Relay <devnull+mt4022.columbia.edu@kernel.org>
Date: Sun, 22 Nov 2026 19:35:12 -0500
Subject: [PATCH v2 1/2] sched/wait: Queue non-exclusive waiters at the head
 in do_wait_intr*()
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261122-b4-sched-wait-intr-head-v2-1-4a764b64e8ce@columbia.edu>
References: <20261122-b4-sched-wait-intr-head-v2-0-4a764b64e8ce@columbia.edu>
In-Reply-To: <20261122-b4-sched-wait-intr-head-v2-0-4a764b64e8ce@columbia.edu>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: Oleg Nesterov <oleg@redhat.com>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Christian Brauner <brauner@kernel.org>, 
 Michal Nazarewicz <mina86@mina86.com>, Wen Yang <wen.yang@linux.dev>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 tz2294@columbia.edu, stable@vger.kernel.org, 
 Mani Tofigh <mt4022@columbia.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795394112; l=2797;
 i=mt4022@columbia.edu; s=20261026; h=from:subject:message-id;
 bh=t/EKiWQssfQXpF3qKY+ICig437H7rd2qHOCQVtDp+ik=;
 b=hi28efIN5xw0rW8lQiQmA2+zT+36chA36KU7jbGMXczzHAIy4UrZqhhw3fCp1sc48I4ucPyEe
 13y386I3s5/ATqO3+fGstJNOY5FgHx+57ZWo4tav9uDc5o0l1U6Fqiq
X-Developer-Key: i=mt4022@columbia.edu; a=ed25519;
 pk=gljCMQDuxyKPmd5y37CRpEJGSPXDV1MyAnHBhCgXl0I=
X-Endpoint-Received: by B4 Relay for mt4022@columbia.edu/20261026 with
 auth_id=1322
X-Original-From: Mani Tofigh <mt4022@columbia.edu>
Reply-To: mt4022@columbia.edu
Content-Transfer-Encoding: 7bit

From: Mani Tofigh <mt4022@columbia.edu>

A task blocked in read() on an eventfd or timerfd can sleep forever
while the file is readable, if an epoll(EPOLLEXCLUSIVE) watcher of the
same file was added before it.

eventfd and timerfd wait with wait_event_interruptible_locked_irq().
do_wait_intr_irq() adds the reader at the tail, behind the exclusive
epoll entry, and __wake_up_common() stops after waking that entry.  If
the woken epoll task is killed or leaves without reading, nothing wakes
the reader:

  Task E                   Task A                 Task C
  epoll_wait(ep, -1)
    /* EPOLLEXCLUSIVE */
                           read(efd)
                             /* queued after E */
                                                  write(efd, 1)
                                                    /* wakes E, stops */
                                                  kill(E, SIGKILL)
                           /* still asleep, efd is readable */

A periodic timerfd doesn't wake A either, since the timer is restarted
only by a read.

prepare_to_wait_event() and add_wait_queue() add non-exclusive waiters
at the head, which is what __wake_up_common() relies on.  eventfd did
the same itself before it switched to these helpers.

Do the same in do_wait_intr() and do_wait_intr_irq().  This only changes
the order in which non-exclusive waiters are woken.  Each of them still
gets every wakeup.  With the fix, A is woken by the write.

Fixes: 22c43c81a51e ("wait_event_interruptible_locked() interface")
Cc: stable@vger.kernel.org
Signed-off-by: Mani Tofigh <mt4022@columbia.edu>
---
 kernel/sched/wait.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
index f8d6d8b9d03e..342dec5fd937 100644
--- a/kernel/sched/wait.c
+++ b/kernel/sched/wait.c
@@ -319,8 +319,12 @@ EXPORT_SYMBOL(prepare_to_wait_event);
  */
 int do_wait_intr(wait_queue_head_t *wq, wait_queue_entry_t *wait)
 {
-	if (likely(list_empty(&wait->entry)))
-		__add_wait_queue_entry_tail(wq, wait);
+	if (likely(list_empty(&wait->entry))) {
+		if (wait->flags & WQ_FLAG_EXCLUSIVE)
+			__add_wait_queue_entry_tail(wq, wait);
+		else
+			__add_wait_queue(wq, wait);
+	}
 
 	set_current_state(TASK_INTERRUPTIBLE);
 	if (signal_pending(current))
@@ -336,8 +340,12 @@ EXPORT_SYMBOL(do_wait_intr);
 
 int do_wait_intr_irq(wait_queue_head_t *wq, wait_queue_entry_t *wait)
 {
-	if (likely(list_empty(&wait->entry)))
-		__add_wait_queue_entry_tail(wq, wait);
+	if (likely(list_empty(&wait->entry))) {
+		if (wait->flags & WQ_FLAG_EXCLUSIVE)
+			__add_wait_queue_entry_tail(wq, wait);
+		else
+			__add_wait_queue(wq, wait);
+	}
 
 	set_current_state(TASK_INTERRUPTIBLE);
 	if (signal_pending(current))

-- 
2.53.0



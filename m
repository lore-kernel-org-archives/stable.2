Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795533804;
	b=mXSMHKTwq5rkLjGQHmoCUOo0klQy7YE+W7ULYjEXjH1bXS9899qBHrZg+S37eaJPaq/M
	 K7fLXogJ9sBmgvlmLGleNhcauVUU6+5qAsl2S4OYME1sAjtqLiI30UoYodTAzBayaFZgi
	 Gym9C+s2bzh7c81if54bpIghKHQ3aZYUJhLhxalw0Gp5hybUlqsk4dSuADFtws6pHOi5V
	 K7ueHv0pvuPv+3JinCXyAmFjsLlcMRW3UE9NQxHPtizMhV90ezHihZI5oE4R83GYNneTd
	 oDP6x32LXLMvnVZh1Fr07NrgB/CUF3EzJE8tWqRzzawXNj/kQI6RYJyZKrtzmZShxOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795533804;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=tM0CIXS0YKX0CWkq+pLSO/o6JfejdP8Z0Jf6O6mRF8I=;
	b=r9WNU+gFgioG0C9K3w0PmXlpb0SkMXi/oN1hCBT09SbFtMTWHZZ7X1lPr3NV8vMk8GBM
	 Ud+jEZcLEZWxNiKfC60pzvmqLHxd/NMYSaz7zkgPcZGikSexqHPtl7awPrGhvKUGWzuf/
	 YDM3VgQnel9grZR49bQJDAx3u9mOYJ+PjiFtgRXa1Mt+5K+JPR1rxVdVDnmqXIiBcpfRg
	 ZqzWOFNpgEh+eCA9/qlgDo8nqv9NFhiISt1m6W/Azoo6hDE365YhHQVEiVAeY91QwKTjE
	 fxJadMmXBHP0fKRs7vpop9mIRuLnnwhD6Wxx84StxzpSXsjx61mA8YCGun+F+vAtrsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=wJCuqMO3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513D1606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 15:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=wJCuqMO3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F8E1F000EB;
	Tue, 24 Nov 2026 15:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795533803;
	bh=tM0CIXS0YKX0CWkq+pLSO/o6JfejdP8Z0Jf6O6mRF8I=;
	h=Subject:To:Cc:From:Date;
	b=wJCuqMO3kx8MGBPLmXQn54V0Et0mZIe4lnzoddnIEGuvaOGvufvXeNdiTA4W0rQ/E
	 hnuppQyiYVYsgYV901P5lGB2g554VUsmzstNQhsyGNxauuQdGij451D19Ph8lmfpod
	 RHcSh2st3xfvbaUm3zZt5EQgFwmE8lC885iG+Wrc=
Subject: FAILED: patch "[PATCH] eventpoll: wake the next waiter when a woken waiter is killed" failed to apply to 5.10-stable tree
To: mt4022@columbia.edu,brauner@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 24 Nov 2026 16:23:44 +0100
Message-ID: <2026112443-enactment-candle-5f6b@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 9f4413e522faed76f4cf610098b2369eb3ba1f1c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112443-enactment-candle-5f6b@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9f4413e522faed76f4cf610098b2369eb3ba1f1c Mon Sep 17 00:00:00 2001
From: Mani Tofigh <mt4022@columbia.edu>
Date: Tue, 3 Nov 2026 13:19:01 -0500
Subject: [PATCH] eventpoll: wake the next waiter when a woken waiter is killed

Processes sharing an epoll instance can sleep forever while an event is
ready.  An event wakes only one waiter, which then wakes the next one in
ep_done_scan() if events are still ready.  Since commit c257a340ede0
("fs, epoll: short circuit fetching events if thread has been killed"),
ep_send_events() returns before the scan when the waiter has a fatal
signal.  If the woken waiter is killed before it runs, nobody wakes the
next one:

  Task A                     Task B                 Task C
  epoll_wait(ep, -1)         epoll_wait(ep, -1)
                                                    write(efd)
                                                      /* wakes A only */
                                                    kill(A, SIGKILL)
  ep_send_events()
    return -EINTR
      /* skips ep_done_scan() */
                             /* still asleep */

B then sleeps until another file on the instance becomes ready, if ever.
This can hit eg a pre-fork server whose worker gets OOM killed.  Commit
7fab29e35630 ("fs/epoll: restore waking from ep_done_scan()") fixed the
same kind of hang when the wakeup in ep_done_scan() was removed.

Keep the early return so that a dying task still doesn't take events
nobody will see, but wake the next waiter there if events are ready, as
ep_done_scan() would have.  With the fix, B gets the event.

This bug was identified and confirmed with the help of a deterministic
hypervisor currently under development.  The C reproducer below however
hits it within about 2s.

Fixes: c257a340ede0 ("fs, epoll: short circuit fetching events if thread has been killed")
Cc: stable@vger.kernel.org
Signed-off-by: Mani Tofigh <mt4022@columbia.edu>
Link: https://patch.msgid.link/20261103-epoll-killed-waiter-v1-1-36e08c16b8a2@columbia.edu
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 7a32c70bf2ad..b959af04772c 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -2144,10 +2144,17 @@ static int ep_send_events(struct eventpoll *ep,
 	/*
 	 * Always short-circuit for fatal signals to allow threads to make a
 	 * timely exit without the chance of finding more events available and
-	 * fetching repeatedly.
+	 * fetching repeatedly. The wakeup that got us here may have been the
+	 * only one for the events on ->rdllist, so pass it on to the next
+	 * waiter, as ep_done_scan() would have.
 	 */
-	if (fatal_signal_pending(current))
+	if (fatal_signal_pending(current)) {
+		spin_lock_irq(&ep->lock);
+		if (!list_empty(&ep->rdllist))
+			wake_up(&ep->wq);
+		spin_unlock_irq(&ep->lock);
 		return -EINTR;
+	}
 
 	init_poll_funcptr(&pt, NULL);
 


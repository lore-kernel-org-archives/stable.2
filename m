Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795536484;
	b=vNT82FydXr2UJSXutc4Xynq1KonEYOlWPS5QS/X7mU+w7su3IFDWXdQ17uxCQe2WsdC3
	 IeNkHMLeM33A6oOtCrr3uLsjlDmiAjZ56v0QfFIENCTTjlr6j1/4Y0dNcq3gMC/jsymkN
	 0d3DGrN1UwB94z+PVQ/Lqd5906lUSeznxoW7qq7D8AOiNhuXrR+4tqrbuD3Zl3JX7d7t2
	 hkBARqIjVJJu+DW+wPMjE/FUbjiJFffP5KMQ3aLWLDnxT24tlRuYyOrOYrwn9wwPhqJcu
	 twFIC7zRh4oDSP6PL8kAHrbs6DdO7Kpik5dXah3X839fAn0338c3ZRz4JazfXDyMWkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795536484;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=YzTzNnaVaxzhwNDx5kAeRDcu5RvSeETnZyn70oYVWWU=;
	b=3iHdgP3gLljKgeNYJ40N9mgoyGTQyBWasvkqotUQVZfIa4i5jdQGVBs/9x/PMrqR785z
	 KX7ypN5A0CE2HJ6zJXL1Ln6r5BPwLhcSP0alAkQtROus0EsL/bkS2vjQyOxTKlifOksr+
	 84qI749xTFCimHeyxM/x4T8zuJIcTWWS2ZQ7FvQLYU9tVgRkSuBcerkAKdwxggHI9rybu
	 TwKjf+c54Xmge4LiDoglYpbQ6KJOLY0AnfsCeg0qHTKu/8j6zQxoQlNUmYEdWuxNDL5kt
	 csgd7M7QUFUsA3iEi6caeP095IKmuZB1FgOvY4H8yXbgQp2k27mqGy6etfKTi/4gVxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ss4KH69s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACEF606A323
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 16:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ss4KH69s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 415921F000C6;
	Tue, 24 Nov 2026 16:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795536483;
	bh=YzTzNnaVaxzhwNDx5kAeRDcu5RvSeETnZyn70oYVWWU=;
	h=Subject:To:Cc:From:Date;
	b=ss4KH69sIfAQBGMFQ9oUKL5AhpzWyZvk2tegUO3IfVxg0u2kF1Wt5Q73Nwy9VSELh
	 5O4z+L4wk+6f4aAH+MmqpcH4oqM/AIAvROp5FwdxTF9s5htWDS5jYtQ+vGoc8oRrvu
	 +6JeqWn3j7ISOwL6ErKaQP6UQgQebm3ouqR46T/8=
Subject: FAILED: patch "[PATCH] eventpoll: wake the next waiter when a woken waiter is killed" failed to apply to 5.15-stable tree
To: mt4022@columbia.edu,brauner@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 24 Nov 2026 17:08:24 +0100
Message-ID: <2026112424-culpable-woof-b14f@gregkh>
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 9f4413e522faed76f4cf610098b2369eb3ba1f1c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112424-culpable-woof-b14f@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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
 


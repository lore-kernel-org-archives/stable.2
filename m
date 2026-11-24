Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795542495;
	b=F9vFMw6R6RRORD1c/7VbdzaLL95TgnL8pUSbkJHLbq7l7/wAhrfC9Jsd3YvpezHthqRF
	 bpHVbMP1URUiiBIDsyJ/xZ3dpWz/+A95gpHxGQErHRGXCiq5cN07S/cNzZbU5Vr/Ho7Gh
	 QQaSR+NrAf4opBhtC4mRxHYKZHRmLslgbUZQpZdJETFIQc+m2gkveO4yFzMJ5jsQ+8ps/
	 go75bJamQr6zKsyAWNScuR12QLqUk5GYf9iIwUGW1/JQ2ZaXKCmV/PcZNYrYDP9DWgEbR
	 13vfFVj6YiA07DMPZk8Ed/cBFekrmFD/sfvrYoo7PP5IsTnAx9yJDQuqvJyfeNzkOkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795542495;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=JQsp3WDbkxvou/yu8yEie64j+difLjR/dJRF5/bJgqw=;
	b=18f7GayaM0N7CoJooFmfiT/sMwihh4c23IkhDLbe889qka5CMcyslkmyDa/OT2BUkd1P
	 nLGLOBm8lJsKCh51NlBmyUT/YP0m5WFV9g9PfOpcfcJg9uYSRAvguFsTiSMekeppEFzQB
	 iKJtBXxeCGNYzuKfsLUtRaBjT4qJhRCjSvWUn9koH6cBKCuHwIhD9Y9fpuKtHezVMzfkY
	 a4HWzOgLGSfio2h7VeLAjzgXbQNLq0PBYEpEv9fDbnlCz1Nj3Qo1QMHlTmp5xqAsm8dlp
	 RUtyiTMFmKFf1isuAd5+586QOpRhH+0fYICvTX+LxmrqMjuTE+VUj8/8E54Fo6aXzgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=asNFysZe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BE0606A326
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 17:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=asNFysZe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CC921F000C6;
	Tue, 24 Nov 2026 17:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795542495;
	bh=JQsp3WDbkxvou/yu8yEie64j+difLjR/dJRF5/bJgqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=asNFysZeb6RtCKJi98sGhgzoqNxrv/3ZVL/tWPh7E2elYE9ZRG7K/KDUuL2iP3Utq
	 793HK57qkzpGbaU7bh/HNOgtEgbG3SHKFUPFcbSObE3wAOHmYn/h4WKxTb364EUQcZ
	 I5zL/kU23s30s/SNQF6sUc9VZIniKTsJrUTMdjQozk6qzxzEUmPOr9pIYEy9wzWLaC
	 orCr83XrqID7cKcxgeFJ35NprRkxLgtb3G5F05lPoTozIMyYon5mL5+8WfSN4IIvfc
	 DN1LVjk1v0ia5pEhInKhGP5l/f/7Wi04Jge4jGAPnR8kldPfbjcs5reBISJ2or3w3R
	 +ppRefnJQVadA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mani Tofigh <mt4022@columbia.edu>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 4/4] eventpoll: wake the next waiter when a woken waiter is killed
Date: Tue, 24 Nov 2026 12:48:10 -0500
Message-ID: <20261124174758.2019784-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124174758.2019784-1-sashal@kernel.org>
References: <2026112424-culpable-woof-b14f@gregkh>
 <20261124174758.2019784-1-sashal@kernel.org>
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

From: Mani Tofigh <mt4022@columbia.edu>

[ Upstream commit 9f4413e522faed76f4cf610098b2369eb3ba1f1c ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/eventpoll.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 530f9bd66252e..496a42596b741 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1666,10 +1666,17 @@ static int ep_send_events(struct eventpoll *ep,
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
 
-- 
2.53.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795545289;
	b=itmta5YcyPKi7jRSz5QI/JyL2BKJRMDhGXNLmEtoUds5Y5dJyc386p0uVKGmHqHSPm2Q
	 BLqC+hho7wg1oCHRbUzt3sDAzAkUchp/V20Zf9OoUnoQKkY8Ywrkd/3x1adDxTAR+AbPX
	 2ReexMqdbCDQSLd5afwA5dbG0WJHHTj2NKvJFqbTIgKfxvyUWcfQkTsn7oIiaKZkX38Df
	 G34b/s80UUaWzPwuYQ40KpFjUrMBqvkYSsEeY2Gt5xjVsSM9BlrKipufOWzYPRCoLZ5BN
	 NAOCLz+Wb4RhE6jwDyjMBY2BSTgC0ya5zLTE2I1YuxqIC/pcO38LkatrAR5Pm5QEqmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795545289;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=KrdTl7N9FYdjc3AXPLaLv2IbJp09gp7k2Uvpe7ThBXw=;
	b=zo9ZwgamCfLMjsNqk8v/seUmv51lFQyTeUyM3c2ScB3c7SAnmaLCMg4VtW5+VWnMYh4N
	 2HYdmjxLCoYN4vm9fYyPWV3iXxA0+YvklTCP+tdBfe4awCC0rflesNVU35B37Cm+gaUXn
	 Rg2E9W3YrXYdb15+99H1j2veBtcdMrOjfaq2//8SZWGcuEBFZl0JrspapTM4e0tce/DgU
	 FcilzwApdBNLcqoNEMDLFUDIu5W/C8JKtGhmDpq4ABIRaQGOoK5qnmjpP0DBpgZLlBh37
	 gnv8WwEyg7TWDQA6RAEaY0VsTPDItVdVO3EWLldTtggqMRHh/SxzRqxumaDWLpwqbuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VXZiBalh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EB7606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 18:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VXZiBalh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1210C1F000C0;
	Tue, 24 Nov 2026 18:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795545288;
	bh=KrdTl7N9FYdjc3AXPLaLv2IbJp09gp7k2Uvpe7ThBXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VXZiBalhZJ7h9veMyZ9q2w3Oj0CiZI26nta20OUaU0CVNHVT2LIYL0x4Ggq9uefOq
	 vL/pP3aQsAk5h8oZTd8AhkgHOx85yzSurbtOM+SzGaYq3laDsZgvqVGWc4KG+sBshi
	 Iu/LDsnrTu8LxeSG2g/u3rFoo5A0VW65Ovaj3qbpKf4OXN4KP/uPF45MGQSKbgHyz1
	 aUDK6lgj0vOjsDb6mZX2ZdZ13TDRySNkuj58J3jHLbVB/IwaSLE2AKOKpD/a15taLm
	 p1bOOV8Xm7B8eM5t0Wqt4pyRGo8HpfjZWwYYxiA9RoENSW0VMDPKuvFi+BeA7Np2gy
	 ATLhdSf95eN8w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mani Tofigh <mt4022@columbia.edu>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] eventpoll: wake the next waiter when a woken waiter is killed
Date: Tue, 24 Nov 2026 13:34:46 -0500
Message-ID: <20261124183220.2232955-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112443-enactment-candle-5f6b@gregkh>
References: <2026112443-enactment-candle-5f6b@gregkh>
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
[ sashal: Moved the fatal-signal wake-up into the early return in ep_poll() instead of ep_send_events(), using write_lock_irq() for the rwlock and referring to ep_scan_ready_list() in the comment. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/eventpoll.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 8cf4354e22e77..e5f36fc20972b 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1981,8 +1981,15 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 		 * Always short-circuit for fatal signals to allow
 		 * threads to make a timely exit without the chance of
 		 * finding more events available and fetching
-		 * repeatedly.
+		 * repeatedly. The wakeup that got us here may have
+		 * been the only one for the events on ->rdllist, so
+		 * pass it on to the next waiter, as
+		 * ep_scan_ready_list() would have.
 		 */
+		write_lock_irq(&ep->lock);
+		if (!list_empty(&ep->rdllist))
+			wake_up(&ep->wq);
+		write_unlock_irq(&ep->lock);
 		res = -EINTR;
 	}
 	/*
-- 
2.53.0


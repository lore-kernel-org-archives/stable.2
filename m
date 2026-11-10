Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794310609;
	b=2eGNIM4IEGfCYlZT0z/SsigvVBYVZq3yJHroUMqdZG8W8EOfMWbvXnv8dtRoLp5KpzzM
	 lfBt0WDyfX7bjyAZ9dXVXaOga9fuD2LV0sTmhIQG6oMylIEd7elcD5agVUVhG9Oj5aiwm
	 0K73rfJs16ZGlVqT1DW8eD6x6Q+G9NUHP4fVaZv5DQYwAF0E0OwG4dJeR3ldEZ9z0Hcru
	 40N53CqnKwtTBGA+5VAXiSFl3N++nb9FuXiSv19/ka8W8UAd4gb4SG40DsEzqBna9hIiX
	 pMXKR/OmpzX7gpp8AXtNCEIr6o8Xq9/7rqXnasJPec7xMCKApo68I2JtySnJYQiWERw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794310609;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=kixVgiTzFmo3eOq/ssvfPl61Iy15bJJwVSGa7ryio4M=;
	b=CftcOcJr6lZU6v7QIYpSaqun+J0vCCM8jLP/4UtZ6xGWZmEGUnJK23+wVX1hbjteSsIn
	 W85nWWZg2khSHkaY5LWvHgBFd6lYydJrlcWz7mam0aouBsXfCnO1VJcf0JtRIIkqgxO5S
	 Flxwp5ntgNGxctvyt+th+mM2a/vkq0v3XGtj3mTIKsGWrYuUt+JA6+eSWBAFUW19KcDcV
	 QCqKichvgEHQWi6+SBsBZVvpHKPTxWR8O/3ASL4Ma9UVFIVQ5fGawPSRM63+90VzzjyLA
	 LCRN/XAYtjB/oZ8ZyhLqslMpk6bXkZvYvwHy21U+7JaQAtmCDVd1k5fGnrh/Mvj12Ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gwKMryRb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DA4606A336
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 11:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gwKMryRb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A2B1F0089F;
	Tue, 10 Nov 2026 11:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794310609;
	bh=kixVgiTzFmo3eOq/ssvfPl61Iy15bJJwVSGa7ryio4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gwKMryRbPetffIOShSSWwWZ2Zk5N7jOCh9hSv1xbyg9VTvHVYs6FMpJW0smvb3Ad1
	 KkCLLyNeKZ2Ed6QU8BCZtsNhI0Hkd2M0EsSesGKdWZuwGtweJzHBWWhk9xGg1oHMRB
	 Ntf1XPgrvTaYPzRKaduS4bgrARHY3d00x9MdzPM07MAzZZVW5tyuSXGd68wPQBpz00
	 sddG5xaw/83YSB3sf1aWFl7F4m/LQSDGfTW3Id+0mgrhUGAN0vBfkTfpMFKQVB4PFY
	 LBodG4sWxjxQSoVBfrxQkXweZaWvLjT81QYbeWdzFQhA1109L0MbtkAOt5G4fn+PtB
	 xcigzoYuZcvmw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daehyeon Ko <4ncienth@gmail.com>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] aio: prevent eventfd/epoll recursion on poll
Date: Tue, 10 Nov 2026 06:36:47 -0500
Message-ID: <20261110113603.284603-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061424-failed-5.10-398e3fa789aa@kernel.org>
References: <20261107061424-failed-5.10-398e3fa789aa@kernel.org>
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

From: Daehyeon Ko <4ncienth@gmail.com>

[ Upstream commit 398e3fa789aa5ffddc8689d8cbc7b31e1824130c ]

aio_poll_wake() can complete a keyed poll request inline while the
provider waitqueue lock is held.  If the polled file is an epoll instance
and the AIO result eventfd is watched by that same instance, signaling the
result can feed back into epoll and try to take the provider waitqueue lock
again.

For example, a timerfd wake can follow this path:

  timerfd -> ep_poll_callback -> aio_poll_wake -> aio_complete
          -> eventfd_signal -> ep_poll_callback -> ep_poll_safewake

The second ep_poll_safewake() recursively acquires ep->poll_wait.lock.
eventfd_signal_allowed() does not prevent this because the wake chain did
not begin in eventfd, so the task's eventfd recursion bit is still clear
when aio_poll_wake() decides to complete inline.

An unprivileged process can construct this graph and make a CPU spin on the
recursive lock.  DEBUG_SPINLOCK reports "BUG: spinlock recursion", and
lockdep reports the same epoll waitqueue lock as both held and requested.

Always defer eventfd-backed poll completions through the existing
aio_poll_put_work() path.  At this point the request has already been
detached from the waitqueue and active request list, so the work item can
publish the completion after the provider callback releases its lock.
Poll completions without a result eventfd remain inline.

Fixes: e8693bcfa0b4 ("aio: allow direct aio poll comletions for keyed wakeups")
Cc: stable@vger.kernel.org
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
Link: https://patch.msgid.link/20260813133843.2933127-1-4ncienth@gmail.com
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
[ sashal: Removed the existing eventfd_signal_count() check instead of upstream's !eventfd_signal_allowed() check. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/aio.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/aio.c b/fs/aio.c
index 22b6e20322741..16ceed755b7e5 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1777,7 +1777,12 @@ static int aio_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
 		list_del_init(&req->wait.entry);
 		list_del(&iocb->ki_list);
 		iocb->ki_res.res = mangle_poll(mask);
-		if (iocb->ki_eventfd && eventfd_signal_count()) {
+		/*
+		 * We hold an arbitrary provider waitqueue lock here.  Signaling a
+		 * result eventfd can feed back through epoll and try to take the same
+		 * lock again.  Defer all eventfd-backed poll completions.
+		 */
+		if (iocb->ki_eventfd) {
 			iocb = NULL;
 			INIT_WORK(&req->work, aio_poll_put_work);
 			schedule_work(&req->work);
-- 
2.53.0


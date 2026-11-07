Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050066;
	b=fqNd3PE90OgwdKxD2zAWrNGWyg3SA/3WzA+dTKm0zQALmAO2YzmBAnqmKtoH2w49Qoyy
	 i3W4zT4iXBGYCjgVkF95tvkJlxM0XSiag4mBNH3fRz3KsjHwBFpnJaSMj+u4C1fQbc/AJ
	 72V8ZJT67we3cE6A5HrHN6p3lq/ouAJZ0gOQZseOwPZK//4BqBtTp6p6qQ+UDdQGmWUBW
	 ov02vEtsaZ+TWqzJdHoqjCLRdzIBBwN8LSpKIEm13Gaaxpps33ObX8cPUYXWocrVXMJLx
	 ONw7BWkpxyZZkTpnVqGbB7HHzwNadhPH6IlmDgEO5nlnA1dWZE2E6YinYgJwxqdxB2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050066;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=HWApybBv8y6qEDzuAY7tKsS3WlWTCQ8q7Cw9WvpjWdY=;
	b=gHuEthQ/JWXxH55jcnMnGu4uyxOei4xZoXuJgIEF0WgjCLkY3Bq8mQ45RF4uZDuGXv+D
	 IXe/Sx7o1xAgq4BTd1I2gDa3bSS8DKV4vYprw4862TBhCdpUoUuaYYCyto/4heEcUK/Pe
	 zlSSH3aPWwl81Pszo/ByD1TmRNBHQkYJTK0iwtos2x7DwM7A6SCCg+aJ46XuvY1Qzirbd
	 QcABAKsUU/Bw+FGi4mMHWw9GB2UatXkpzyDipYI5lsxdVQa9tTZfbp3sfhMiFt2Q2Glho
	 hEUI+cW7iPWKyrCxq2KzzHLx2p+bfqWmBgvHBGdWF7riWpU6jrqoYQWL8Owi0MLLRIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="UBi2dp/z";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEBC606A32D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UBi2dp/z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC4DD1F0089F;
	Sat,  7 Nov 2026 11:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050066;
	bh=HWApybBv8y6qEDzuAY7tKsS3WlWTCQ8q7Cw9WvpjWdY=;
	h=From:To:Cc:Subject:Date;
	b=UBi2dp/ztavnKQQfzngha/5WA9wIY/+oMgVnP9Hugbkca+ZO5mCdFoH4fCSjW7VK6
	 GNM4/3Vh0zcQMUT5ul+2OsThxsvYIhzJY1FfFcn0d7iu1qeJvTGv67rAhxKMeoJybU
	 uq+9wN835jnE2LpCG2nkISLFPD2JWFQV6JzbtB8h0SeuuPiIkkbSjaiYkSYAJnp8tv
	 WFg0ZpPsera/XCHKnQCCunFrLINhSlqO1IbyfgKtInr8qBeuwDmHYyQu1gvUjfLoT/
	 Yp6dSu+ugXFJlT/DMZfohhbZIaRViYY7yIU0ifiO7ggNX55wMTxn1Vtre1PJ3cw+JS
	 qn5mwNVivMhaQ==
From: Sasha Levin <sashal@kernel.org>
To: 4ncienth@gmail.com,
	brauner@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] aio: prevent eventfd/epoll recursion on poll" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:14:24 -0500
Message-ID: <20261107061424-failed-5.10-398e3fa789aa@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 398e3fa789aa5ffddc8689d8cbc7b31e1824130c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061424-failed-5.10-398e3fa789aa@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 398e3fa789aa5ffddc8689d8cbc7b31e1824130c Mon Sep 17 00:00:00 2001
From: Daehyeon Ko <4ncienth@gmail.com>
Date: Thu, 13 Aug 2026 22:38:43 +0900
Subject: [PATCH] aio: prevent eventfd/epoll recursion on poll

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
---
 fs/aio.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/aio.c b/fs/aio.c
index d78acc69f4870..92241a24d9e28 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1869,7 +1869,12 @@ static int aio_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
 		list_del_init(&req->wait.entry);
 		list_del(&iocb->ki_list);
 		iocb->ki_res.res = mangle_poll(mask);
-		if (iocb->ki_eventfd && !eventfd_signal_allowed()) {
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





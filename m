Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435244C9557
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 15:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784646841; cv=none; b=nk+zUG8D+DiWNpwJmwtFoUX7cE7Z5sAAeZHw88hEyvfJwBFd4WyssKzVBCzfac42unDQdt1GFtQAZRIv4geJlG70jdgr2haZjPPYnrFe5TyJ1RETpwJo8SCaxRVMNOWeSiVpw8DkiP7Uv2lYJgli7TcCqyjpG9TtQCHBXTWsc18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784646841; c=relaxed/simple;
	bh=yJ/Ad0CTCYMwVj20upkRS09DO9qM40nZHDzNNjawZN0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=brHLvTQJyJUAsi2cf8QO+f7wd+WvvUvkLxiI6KIWN+8O3FKpqC0A6NDifHU1urzXlcFPDMg6yevur/V8UviT4iJHnHVszdeO+2plkkrBvF0LGSCJoCPDMBpEkrdEX6DI0nkw18vFjliylkLcconYqOEQWsrhfhdj2JA7KYq4XjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qrckfdIq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qrckfdIq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C0431F000E9;
	Tue, 21 Jul 2026 15:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784646839;
	bh=eORs/yWezY6r9qQPGYFAeKxHB9XEBdK3XuEWnUs+ucg=;
	h=Subject:To:Cc:From:Date;
	b=qrckfdIqOvX5CEU9jNbt2MlljLwrMaZtRgzd+bc3dQFTS+jFswL+PiPGutaTLj35e
	 V+R0pa4qkPRCft5xma/22dSDS6ntGJ3iDSW3A0IZH/p8fo4WmskFubb3XqhCIBDEzO
	 fZhVctSwhKKyjqEo4fUtXQ5MFyqV1PnKWXO0A23w=
Subject: FAILED: patch "[PATCH] futex/requeue: Prevent NULL pointer dereference in" failed to apply to 5.10-stable tree
To: eilaimemedsnaimel@gmail.com,tglx@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 21 Jul 2026 17:13:41 +0200
Message-ID: <2026072141-striking-reaffirm-3311@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x 74e144274af39935b0f410c0ee4d2b91c3730414
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072141-striking-reaffirm-3311@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 74e144274af39935b0f410c0ee4d2b91c3730414 Mon Sep 17 00:00:00 2001
From: Ji'an Zhou <eilaimemedsnaimel@gmail.com>
Date: Tue, 2 Jun 2026 09:12:04 +0000
Subject: [PATCH] futex/requeue: Prevent NULL pointer dereference in
 remove_waiter() on self-deadlock

When FUTEX_CMP_REQUEUE_PI requeues a non-top waiter that already owns the
target PI futex, task_blocks_on_rt_mutex() returns -EDEADLK before setting
waiter->task.

The subsequent remove_waiter() in rt_mutex_start_proxy_lock() dereferences
the NULL waiter->task, causing a kernel crash.

Add a self-deadlock check for non-top waiters before calling
rt_mutex_start_proxy_lock(), analogous to the top-waiter check in
futex_lock_pi_atomic().

Fixes: 3bfdc63936dd4773109b7b8c280c0f3b5ae7d349 ("rtmutex: Use waiter::task instead of current in remove_waiter()")
Signed-off-by: Ji'an Zhou <eilaimemedsnaimel@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org

diff --git a/kernel/futex/requeue.c b/kernel/futex/requeue.c
index b597cb3d17fc..1d99a84dc9ad 100644
--- a/kernel/futex/requeue.c
+++ b/kernel/futex/requeue.c
@@ -643,6 +643,12 @@ int futex_requeue(u32 __user *uaddr1, unsigned int flags1,
 				continue;
 			}
 
+			/* Self-deadlock: non-top waiter already owns the PI futex. */
+			if (rt_mutex_owner(&pi_state->pi_mutex) == this->task) {
+				ret = -EDEADLK;
+				break;
+			}
+
 			ret = rt_mutex_start_proxy_lock(&pi_state->pi_mutex,
 							this->rt_waiter,
 							this->task);


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498FF4028F2
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 15:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781536810; cv=none; b=VlhMeAR3nUkF6jxtN3jF1bD20ecEg9W+yxpafDj2HvveU1qnsWaBlh2gaAZm9z+gvMY9cdlEd45ptbJQd6hn82LDOd2iNJjTRFjUmbKzhwun3CJ6pGNh2SgRWhKK0Tcm9Qx2g4ykZXxE7eejjTLt3Ud0UXrkqH66hMArm1JHlgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781536810; c=relaxed/simple;
	bh=/4+HGf6jHWAsxc2NUf1EpmvsH6sPI1hUPtSp/lTIe2Q=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=o0xxuEEa26cMrMfZsCP1uWACp08FxlOcLi8ROTTxmCCo8FhXebL6lsHrHeznNdDcQU912uf2Cxs9IJplS8pOI6AaRKvr7uO10z4UI7JIhb1QuwiggF3gdhvs6QZwRd3nF5hcYd1c29PUzMFgWdhkztg+PS5laXiTsz9aVnyNbgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lrkLx+/P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lrkLx+/P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 549A21F000E9;
	Mon, 15 Jun 2026 15:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781536809;
	bh=Oc2BkTSeprN8KN/OWZxABsupS+5smiJxHbXpDLpHfIY=;
	h=Subject:To:Cc:From:Date;
	b=lrkLx+/Pf9pdJDwJ3ISNLLWHSGynhKdCLaEML3vi1cRYeqACVmTINJKx13Qu/w3cC
	 HSSCUDYxYzW8BAZVHoED4EOUoX+NRs0aN+Q2lrL2yQTowKxaL6naaePgyyGTR0a9oU
	 qG8UG8Qw/z1AepFNZhCw/4ytNOHcUL5HE38vf3hk=
Subject: FAILED: patch "[PATCH] locking/rtmutex: Skip remove_waiter() when waiter is not" failed to apply to 6.12-stable tree
To: dave@stgolabs.net,tglx@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 16:47:13 +0200
Message-ID: <2026061513-dating-gaining-4f76@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 40a25d59e85b3c8709ac2424d44f65610467871e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061513-dating-gaining-4f76@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 40a25d59e85b3c8709ac2424d44f65610467871e Mon Sep 17 00:00:00 2001
From: Davidlohr Bueso <dave@stgolabs.net>
Date: Thu, 7 May 2026 04:29:13 -0700
Subject: [PATCH] locking/rtmutex: Skip remove_waiter() when waiter is not
 enqueued

syzbot triggered the following splat in remove_waiter() via
FUTEX_CMP_REQUEUE_PI:

  KASAN: null-ptr-deref in range [0x0000000000000a88-0x0000000000000a8f]
   class_raw_spinlock_constructor
   remove_waiter+0x159/0x1200 kernel/locking/rtmutex.c:1561
   rt_mutex_start_proxy_lock+0x103/0x120
   futex_requeue+0x10e4/0x20d0
   __x64_sys_futex+0x34f/0x4d0

task_blocks_on_rt_mutex() does not arm the waiter upon deadlock detection,
leaving waiter->task nil, where 3bfdc63936dd ("rtmutex: Use waiter::task instead
of current in remove_waiter()") made this fatal.

Furthermore, rt_mutex_start_proxy_lock() should not be calling into remove_waiter()
upon a successfully grabbing the rtmutex. 1a1fb985f2e2 ("futex: Handle early deadlock
return correctly"), moved the remove_waiter() out of __rt_mutex_start_proxy_lock()
(where 'ret' was only ever 0 or < 0) into the wrapper. Tighten this check to
account for try_to_take_rt_mutex().

Fixes: 3bfdc63936dd ("rtmutex: Use waiter::task instead of current in remove_waiter()")
Reported-by: syzbot+78147abe6c524f183ee9@syzkaller.appspotmail.com
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Closes: https://lore.kernel.org/all/69f114ac.050a0220.ac8b.0003.GAE@google.com/
Link: https://patch.msgid.link/20260507112913.1019537-1-dave@stgolabs.net

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 4f386ea6c792..daeeeef973e2 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1558,6 +1558,9 @@ static void __sched remove_waiter(struct rt_mutex_base *lock,
 
 	lockdep_assert_held(&lock->wait_lock);
 
+	if (!waiter_task) /* never enqueued */
+		return;
+
 	scoped_guard(raw_spinlock, &waiter_task->pi_lock) {
 		rt_mutex_dequeue(lock, waiter);
 		waiter_task->pi_blocked_on = NULL;
diff --git a/kernel/locking/rtmutex_api.c b/kernel/locking/rtmutex_api.c
index 124219aea46e..514fce7a4e0a 100644
--- a/kernel/locking/rtmutex_api.c
+++ b/kernel/locking/rtmutex_api.c
@@ -365,7 +365,7 @@ int __sched rt_mutex_start_proxy_lock(struct rt_mutex_base *lock,
 
 	raw_spin_lock_irq(&lock->wait_lock);
 	ret = __rt_mutex_start_proxy_lock(lock, waiter, task, &wake_q);
-	if (unlikely(ret))
+	if (unlikely(ret < 0))
 		remove_waiter(lock, waiter);
 	preempt_disable();
 	raw_spin_unlock_irq(&lock->wait_lock);


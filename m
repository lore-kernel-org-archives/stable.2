Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A27C221F2F
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 16:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784736890; cv=none; b=trx7PjW4Bev2H2ksSK7ULCh1C51llNr31UcUN2ExxjDiB/B5ecCVU2NJVieJYz7DSd7DjW+hon6mO2oU5dFS98PpbcTzkTiaTd/Wy4Nr91rBdoRqDyioxkKRsttiLaP7jynuNil2zJBte4xyXJLIhItEn2LDh0F7h/AfYIEXMzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784736890; c=relaxed/simple;
	bh=hTUotxQMmqauOxD3k92AMA737jQfLqN2yuLbpBe4Co4=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=mRcxL4/Ltyz+7z5AYjh8Ng3NoeHgRn4Uj4lJ2ENAfQY70qywZbBS0afR25A2n6kOlWlZxtbtTtVRWNMWRiSdkgJTPELCWBQFPg9FVYYOia87TqKonXTH54kK/HZabFuZfKJpNhq6bFtahURyBMPcRj5NId24///i22tqUIhdjWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJbvtqKM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJbvtqKM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C39B1F000E9;
	Wed, 22 Jul 2026 16:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784736889;
	bh=iWWxMLk9hxk/7DJPK8mjkqOmQmOc9e8Xh8ZK4MBPn7o=;
	h=Date:From:To:Cc:Subject:References;
	b=oJbvtqKMlWU66ZP6m6/IHnN9649HGgS2HjFACvBvEMVhJwBnuZpG17y2/B1r/TuGl
	 ywXBGwme0xplD4Rppr6TWv/eThFGdl79eiU/+SO74Z4O/MDmt9MGZ7+n6f24gMlHV8
	 PJ4SllSaiywIHO2zo15hUZ+Ao3sat/H3RpokNLLqihiL9m9+3qqtrg6GQJoEtieCDB
	 hseFVLAYsG0O0LFLhIdFXjYXxyG09KYareESaY724HXFe8QtZPPl0l6mVfEIII0wl+
	 xFVXX5bp69kNa6pBEWs/75K3yxaDZ+rTRRRiagU+pfBx6icivs8j2HGEPCOUQJKrmB
	 dpoPlcVU+pP2g==
Date: Wed, 22 Jul 2026 18:14:46 +0200
Message-ID: <20260722153354.781060907@kernel.org>
User-Agent: quilt/0.69
From: Thomas Gleixner <tglx@kernel.org>
To: stable@vger.kernel.org
Cc: tglx@kernel.org
Subject: [patch 5.10.y 2/2] locking/rtmutex: Skip remove_waiter() when waiter
 is not enqueued
References: <2026072141-striking-reaffirm-3311@gregkh>
 <20260722152737.461825448@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Davidlohr Bueso <dave@stgolabs.net>

commit 40a25d59e85b3c8709ac2424d44f65610467871e upstream.

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
---
 kernel/locking/rtmutex.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)
---
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1074,6 +1074,9 @@ static void remove_waiter(struct rt_mute
 
 	lockdep_assert_held(&lock->wait_lock);
 
+	if (!waiter_task) /* never enqueued */
+		return;
+
 	raw_spin_lock(&waiter_task->pi_lock);
 	rt_mutex_dequeue(lock, waiter);
 	waiter_task->pi_blocked_on = NULL;
@@ -1803,7 +1806,7 @@ int rt_mutex_start_proxy_lock(struct rt_
 
 	raw_spin_lock_irq(&lock->wait_lock);
 	ret = __rt_mutex_start_proxy_lock(lock, waiter, task);
-	if (unlikely(ret))
+	if (unlikely(ret < 0))
 		remove_waiter(lock, waiter);
 	raw_spin_unlock_irq(&lock->wait_lock);
 


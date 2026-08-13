Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFF0184
	for <stable@vger.kernel.org>; Thu, 13 Aug 2026 00:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786582475; cv=none; b=grcBInNqUaUlgmKUjv/0oIa2GODZywvTGyGAfimqN85q2KhD0+sdBlCmgjT+q8KuVk0jslF2S+xp24ps2MIX0vdgA/aWDg2tJAit+xzxRDuqhmxQbtV509H6uoC2ITQ8BAzupdsPIpqtLLYUpelCDp5Nc/lEQXR20hQaf2+GXow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786582475; c=relaxed/simple;
	bh=IjvQUv8hWil2nV/+DYArLMDEZZpfZm/ZS7iWzC4Htww=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=aoFu1Kz5c4gMJB9YUcl8y7LlW0t9skaNak4dvGBzV4OSLZtTTNKKojFm2j6nDK5LyGROFIrnSoxKWPoPpApvtRZNsTL+gWWT34pc7u+aFmPIVlyMLUAex7IIo2wvJ8c9xhtlJvEnkZrk+J48uo42YSZvdPHcU9YMPGk9O0if2xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KfOChInA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KfOChInA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAA8B1F000E9;
	Thu, 13 Aug 2026 00:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786582473;
	bh=3sFHWLzP7wySW447Foo1qMTG+5EJSgyHz7Fwcartgtg=;
	h=Subject:To:Cc:From:Date;
	b=KfOChInA/JdSjdVEV0SoGTLSeNKPK+EQxMkNiVqAsSxZY0bZyhG99oA8oZYhoX7Sy
	 WE7Opd3GexM7580+HYyP2me/r9mocd5bxtMEtKspC71skK+oitrBfFHKwF5PwKNA8n
	 ImZVi+Xlfj3QicBf4yuASsGSJZ2xygtjpteDWQvs=
Subject: FAILED: patch "[PATCH] futex: Fix race in futex_pivot_pending() during private hash" failed to apply to 6.18-stable tree
To: yaokai34@huawei.com,peterz@infradead.org,tglx@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 13 Aug 2026 09:52:53 +0900
Message-ID: <2026081353-usher-wackiness-91af@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 8e7ff730dd96519a333d1570edf1c3fabb6d3629
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026081353-usher-wackiness-91af@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8e7ff730dd96519a333d1570edf1c3fabb6d3629 Mon Sep 17 00:00:00 2001
From: Yao Kai <yaokai34@huawei.com>
Date: Tue, 4 Aug 2026 20:55:30 +0800
Subject: [PATCH] futex: Fix race in futex_pivot_pending() during private hash
 resize

A task performing a custom private hash resize can remain blocked in
uninterruptible sleep indefinitely.  The hung-task detector reports:

  INFO: task futex-resizer:314 blocked for more than 10 seconds.
  task:futex-resizer state:D stack:14824 pid:314 tgid:312 ppid:311

  Call Trace:
   __schedule+0x521/0xf30
   schedule+0x22/0xa0
   futex_hash_allocate+0x3db/0x490
   __do_sys_prctl+0x6f5/0xbd0
   do_syscall_64+0xf9/0x530
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

  Kernel panic - not syncing: hung_task: blocked tasks

futex_pivot_pending() allows the resize request to continue when
either no replacement hash is pending (hash_new == NULL) or the current
hash reference count has reached zero.

After the final-reference wake, another futex task can complete the
pivot between the two observations:

  T1                                  T2

  futex_hash_allocate()
    wait_var_event(mm, ...)
      futex_pivot_pending(mm)
        hash_new != NULL
                                      futex_hash()
                                        futex_ref_get(old) -> false
                                        futex_pivot_hash(mm)
                                          hash_new = NULL
                                          __futex_pivot_hash(mm, new)
                                            rcu_assign_pointer(hash, new)
        fph = rcu_dereference(hash) /* new */
        futex_ref_is_dead(fph) -> false
      schedule()

The pivot changes the state from hash_new != NULL with a dead current
hash to hash_new == NULL with a live current hash.  Because
futex_pivot_pending() reads hash_new and hash without serialization,
the resize task can observe hash_new in the pre-pivot state and hash in
the post-pivot state, causing futex_pivot_pending() to return false even
though the pivot has completed.  The task then goes to sleep after the
wakeup has already been consumed.

Serialize state reads in futex_pivot_pending() using futex_mm_phash::lock.
This guarantees that futex_pivot_pending() observes hash_new and hash
atomically, eliminating the race condition.

Fixes: bd54df5ea7ca ("futex: Allow to resize the private local hash")
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Yao Kai <yaokai34@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260804125530.3933754-1-yaokai34@huawei.com

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 2650d1e52803..128c5752f225 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -1783,14 +1783,15 @@ void futex_hash_free(struct mm_struct *mm)
 
 static bool futex_pivot_pending(struct mm_struct *mm)
 {
+	struct futex_mm_phash *mmph = &mm->futex.phash;
 	struct futex_private_hash *fph;
 
-	guard(rcu)();
+	guard(mutex)(&mmph->lock);
 
-	if (!mm->futex.phash.hash_new)
+	if (!mmph->hash_new)
 		return true;
 
-	fph = rcu_dereference(mm->futex.phash.hash);
+	fph = rcu_dereference_raw(mmph->hash);
 	return futex_ref_is_dead(fph);
 }
 


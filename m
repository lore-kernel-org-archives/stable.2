Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9383401A2C
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 12:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787662127; cv=none; b=DiyDtr/zhUTvX0MYjO0UkUaLZKdqLq+9CsyWx3JorH9Fb4HavUJIaNs3xKl7fnV6mKtUJP+n0Tz6tc8nnIZvBubz7pKgHlQKikMZtbzfBDlT4DJWApFGAMMU3Xy61YCzlvP0aAQeDDLW02jY8eeqfuSdgMzfRoee+FKKAp0ejkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787662127; c=relaxed/simple;
	bh=YkPyRiNYy9cY2rII6P7FDUJlwkHuheAxmTvyERDaRO4=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Zd/SYCngOlE+6QbUwJusChzzeoKyKbCuQrJimsYawaZBC6PRhRoKPw8M6IGUuxKgYWQzU8GnihJSAMUwAcWYlocPN0TdlITSAU1s093qRgM/8h/hRw/iZC61gz7rdxlpcVQ1XmBhfBBudTiHH8wS5Sg264/jTmWcqdKUuR+vMQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jSAicBUA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jSAicBUA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EE261F00A3A;
	Tue, 25 Aug 2026 12:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787662122;
	bh=IO7RDPTo+vuJMZbAG1C3NinxMLHTKkSJ+/uwjStM1/s=;
	h=Date:From:To:Cc:Subject:References;
	b=jSAicBUAeHm6gpHA4cS/iU3+4JChpCnFe6IrToPaytyKstwyOa9T3wtfBmvDirNb6
	 Cky4tLxQCOV3T8Wl1XpQeftX1K94faW/FEfde2mfpNHaqI579eAkEI9xVtE99Isuvl
	 8Bhq7Vt9qMfbZqTXEIBKJinBBi4kS4hAFP5Lpo1y9B/eplPGBgl5tlzwjRGqDpKh3P
	 h07uQrwXQ3YGKwDONttSYcyB8ieraMpj9Ws4L8qdsUPw3R+SpWRHpe+m+uIv8KosCo
	 KLkRwtQAy5Faq9qBulOPVr3CYJPygZHFGFnyk2wI6/CvE/jG+qkHuSa0JsAQENJXVF
	 VntujcNDAttjw==
Date: Tue, 25 Aug 2026 14:48:40 +0200
Message-ID: <20260825091708.598105210@kernel.org>
User-Agent: quilt/0.69
From: Thomas Gleixner <tglx@kernel.org>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
 peterz@infradead.org,
 Yao Kai <yaokai34@huawei.com>
Subject: [patch 7.1.y 4/6] futex: Fix race in futex_pivot_pending() during
 private hash resize
References: <2026082446-lumpish-subdivide-9766@gregkh>
 <20260825091624.748852250@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Yao Kai <yaokai34@huawei.com>

commit 8e7ff730dd96519a333d1570edf1c3fabb6d3629 upstream.

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
---
 kernel/futex/core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
---
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -1786,12 +1786,12 @@ static bool futex_pivot_pending(struct m
 {
 	struct futex_private_hash *fph;
 
-	guard(rcu)();
+	guard(mutex)(&mm->futex_hash_lock);
 
 	if (!mm->futex_phash_new)
 		return true;
 
-	fph = rcu_dereference(mm->futex_phash);
+	fph = rcu_dereference_raw(mm->futex_phash);
 	return futex_ref_is_dead(fph);
 }
 


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC4A4229C6
	for <stable@vger.kernel.org>; Sat, 15 Aug 2026 15:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786809317; cv=none; b=IW41fS3lyxTAqSmysPMDOTBKFRO1W4svPjoQW+/f0TyUvVpB7Fws5mMCJTPvPIvrWRYcGFrtUXUvRfkD6shChgnwztxsubsgV52zwcsH5zxHg9ThQYSZWdybtX+uQo66ZthMeUX5RLwq335vcqg+Phu8leAJIkHhRqa1wRXkyn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786809317; c=relaxed/simple;
	bh=8IpuJOxHR706GlJdC1MaCTvBsnsIcuNIwC/JXkIY6C0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Etfw5o3yWQOSR92w//9hod4q2T/Q2APG+SupE8UnGg6rHemY3qDbic7S1KM9aIlWJ86TlTep44zCBoJHqPR3rZxPlPYQydNLJ5WvvuEFU+VGqhI0xUQrEqGToBuz1st7384zqahBjTiefBQabX9uInLW1xiZ4KTMfa46lKD/OG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lnyek3sF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lnyek3sF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E8C1F000E9;
	Sat, 15 Aug 2026 15:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786809314;
	bh=pQBjAZ1SUQVfuIENx8Pz1AtbBIVcuP5UKydLbAkE4ZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Lnyek3sFEaBp1V5OOvq5f2zYhtWPQMKIV4+8x6fboarnVKX4Cy+rOvuoIZu9M4/Jr
	 xbpLMYlFewi+OZ8va4gt9KB6XzX4BfXm3BWhMo+yZvv6K1lUsXs8QwJ62kSbrfMgs7
	 5XIymLXdcRaNfXBKqUNHa1MmPQXtjypiEYrX7E+srAKvLElDHSqmRPRbYaJ25i2SkY
	 5/B0puJNouRsaQOZKRsolkiL62HLev6TdHMGuliaM2t4US8ggn4RZiccZaB9rsSuWT
	 6ND6BbQCKYPnd6/pZN/DkJfPhm/w7jaS0dA6udhxOTkCgi6g39iUS4X+0mbHAJuRGW
	 43lo4cRaoKgjQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yao Kai <yaokai34@huawei.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] futex: Fix race in futex_pivot_pending() during private hash resize
Date: Sat, 15 Aug 2026 11:55:12 -0400
Message-ID: <20260815155512.785627-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026081353-usher-wackiness-91af@gregkh>
References: <2026081353-usher-wackiness-91af@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yao Kai <yaokai34@huawei.com>

[ Upstream commit 8e7ff730dd96519a333d1570edf1c3fabb6d3629 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/futex/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 9e7dea6fc0ccd..0b65188a624b6 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -1743,12 +1743,12 @@ static bool futex_pivot_pending(struct mm_struct *mm)
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
 
-- 
2.53.0


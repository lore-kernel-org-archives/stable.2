Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711C337F8C2;
	Fri,  7 Aug 2026 15:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786118084; cv=none; b=PwNNpKNE/3C1cuNf6KvdqGbkoH4ya0iR47iTrs36Xjb6nZMkQbMv/PgQJzrGaaS+E/mcoeapCsrcL2AWFwYNDAbC3yVwQHSHAmEgpPf2ndBrJm5ylGFtMf9mKa0rAeoT8agoWoLeimTARbzvhy7U7xEI/7Nc8OGSzKPc+XJyFjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786118084; c=relaxed/simple;
	bh=Yhsjm/yXiH/XDWnDEcsjh6syHvFTqp10KqxKrbi2Wvk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QVOoxn70KWWD7QrYpdIVAj6KBQqEUeQpEDrT69+a7NB8GZLuiy4ndLZMDAeDgfrMS2MSKXbOzCuSyGJxb63bEXHYGej/wKRmat3lW/VNb3NcHufVGaL4jqOP9qlY9WH8b869V3UErFRQyRd6VssuAcqIHI+jxPJ+pVOMB8edqcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N9o9kJis; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=El2GYPn6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N9o9kJis";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="El2GYPn6"
Date: Fri, 07 Aug 2026 15:54:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1786118079;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aorsr+bc2/wkK7RC+86R/h/VTILkW5/D9G235zqy0So=;
	b=N9o9kJisPlVZR3rzll8w+U5ph39o2WPi50UpOcGDtRXTrwRKEAE7T+HNFxUcO4FlN5ipCl
	s4ijwqwUPosh97D0cdjuUKWvqPwdbXua+rNak2jaFtGpN7vpmjIm5w8eK/cIS4NrH5Uq/7
	biAGBwQDwccnFs4h2Shsk8VSU+IoBkzJBjG2cw1Obs4usHYE0to2U+59q1ngRt3NokklAY
	87RieiLsMOGzt5RRLz/vjVgVgD9JYrahvfdIfcG5HCPY3fmFJuk1AhBuO3rTX3dcMQpSJo
	Thxl5OmThpqzLM5Tur6MFBh2N8Zfz7WA13sLbzTzEoi4O+GNOnldlST4Kla7MA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1786118079;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aorsr+bc2/wkK7RC+86R/h/VTILkW5/D9G235zqy0So=;
	b=El2GYPn6/swyxUoEAMsLeN2ehHcxekxlTCT83O9GPp43XZnu6l71KqCznt7LddOfB1KoPr
	Pv5Zsq/XfheMrhAQ==
From: "tip-bot2 for Yao Kai" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] futex: Fix race in futex_pivot_pending() during
 private hash resize
Cc: Peter Zijlstra <peterz@infradead.org>, Yao Kai <yaokai34@huawei.com>,
 Thomas Gleixner <tglx@kernel.org>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260804125530.3933754-1-yaokai34@huawei.com>
References: <20260804125530.3933754-1-yaokai34@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178611807751.708.88477594766113221.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     8e7ff730dd96519a333d1570edf1c3fabb6d3629
Gitweb:        https://git.kernel.org/tip/8e7ff730dd96519a333d1570edf1c3fabb6=
d3629
Author:        Yao Kai <yaokai34@huawei.com>
AuthorDate:    Tue, 04 Aug 2026 20:55:30 +08:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Fri, 07 Aug 2026 17:46:30 +02:00

futex: Fix race in futex_pivot_pending() during private hash resize

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
either no replacement hash is pending (hash_new =3D=3D NULL) or the current
hash reference count has reached zero.

After the final-reference wake, another futex task can complete the
pivot between the two observations:

  T1                                  T2

  futex_hash_allocate()
    wait_var_event(mm, ...)
      futex_pivot_pending(mm)
        hash_new !=3D NULL
                                      futex_hash()
                                        futex_ref_get(old) -> false
                                        futex_pivot_hash(mm)
                                          hash_new =3D NULL
                                          __futex_pivot_hash(mm, new)
                                            rcu_assign_pointer(hash, new)
        fph =3D rcu_dereference(hash) /* new */
        futex_ref_is_dead(fph) -> false
      schedule()

The pivot changes the state from hash_new !=3D NULL with a dead current
hash to hash_new =3D=3D NULL with a live current hash.  Because
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
 kernel/futex/core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 2650d1e..128c575 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -1783,14 +1783,15 @@ void futex_hash_free(struct mm_struct *mm)
=20
 static bool futex_pivot_pending(struct mm_struct *mm)
 {
+	struct futex_mm_phash *mmph =3D &mm->futex.phash;
 	struct futex_private_hash *fph;
=20
-	guard(rcu)();
+	guard(mutex)(&mmph->lock);
=20
-	if (!mm->futex.phash.hash_new)
+	if (!mmph->hash_new)
 		return true;
=20
-	fph =3D rcu_dereference(mm->futex.phash.hash);
+	fph =3D rcu_dereference_raw(mmph->hash);
 	return futex_ref_is_dead(fph);
 }
=20

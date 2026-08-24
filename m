Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AA54078D9
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 10:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787568731; cv=none; b=cEuQrxj6m6rmlWRwzQqm06PcBGVVFvf2sNz0cANxtDMS6jYf97j7kF5w52lVuzoZwGFD/SsI1Vt5H/9ZA+V2FC0Xz0S6JzgGcufdWZv2od5OnlE33l/aknUqvUQ+CPvO58mwTr8WOLZ4KCEQld9gs0L+fgnssNTvSE4HU/dvOd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787568731; c=relaxed/simple;
	bh=2s72xHKUFg5tjmsPv4WUjvwErBlLINND3IkiZA8x26c=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GR6PmhnDlhT08iDBYVy4CS0jBYq0vDW1T4joB6uh6bvzdWzYZeFeLaCTFAR6EsVC+xJpST6H/8JXu6OsbX4Us8Z05EV58YLZUfe++hR5NV+6LtCHr14r1hPPmyXhaw0WRMnLCmjy+TdqqsW88k/eDSkd2dpWWM13XfzL1Mo/UvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FyxPW2HG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FyxPW2HG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 562B41F000E9;
	Mon, 24 Aug 2026 10:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787568729;
	bh=b5QN/EPF4PoWJC5Gctev7CLnHsWphe+Ea7esHtjhSG8=;
	h=Subject:To:Cc:From:Date;
	b=FyxPW2HGGkiN1FgJ6AYo8RvHjASy4wwUHBPO+8wxq6dIkBz3DDazMbAYNVP4ytnpI
	 ZzzmtftMA3xt6S5YPlPaoVhEFp9IHODtSJKKZHbcWaYgOpwo+9uUL//GOG257zvOe5
	 zaG6VPLj4x1FAPmqt/ECkVgLrJVOMUw8pPU61p1g=
Subject: FAILED: patch "[PATCH] futex: Fix race on the initial mm->futex.phash.ref allocation" failed to apply to 7.1-stable tree
To: imv4bel@gmail.com,peterz@infradead.org,tglx@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Aug 2026 12:52:06 +0200
Message-ID: <2026082406-engaged-statistic-82bb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.1.y
git checkout FETCH_HEAD
git cherry-pick -x bde0238083647381d4747355c5a19115a3422b96
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082406-engaged-statistic-82bb@gregkh' --subject-prefix 'PATCH 7.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bde0238083647381d4747355c5a19115a3422b96 Mon Sep 17 00:00:00 2001
From: Hyunwoo Kim <imv4bel@gmail.com>
Date: Tue, 11 Aug 2026 23:03:16 +0900
Subject: [PATCH] futex: Fix race on the initial mm->futex.phash.ref allocation

futex_hash_allocate() allocates mm->futex.phash.ref without any locking.
Commit d9b05321e21e ("futex: Move futex_hash_free() back to __mmput()")
moved the allocation here and assumed that the process has just a single
thread at this point.

Commit ee9dce44362b ("futex: Drop CLONE_THREAD requirement for private
default hash alloc") widened need_futex_hash_allocate_default() to cover
any CLONE_VM clone, but left out vfork because the parent is suspended and
cannot race.

That no longer holds once vfork is nested. If a vfork child calls vfork
again and is then killed with SIGKILL, the parent is released from its
vfork wait and runs concurrently with the grandchild in the same mm.
Neither of them went through futex_hash_allocate_default().

When both call prctl(PR_FUTEX_HASH, PR_FUTEX_HASH_SET_SLOTS) at the same
time, each one sees mm->futex.phash.ref as NULL and stores its own percpu
counter. Only the last store survives. The counter stored first is no
longer reachable from the mm, so the references on it are not seen by
__futex_ref_atomic_end(). A private hash that still has references is then
considered dead and freed, and a task that still holds one of its buckets
writes into freed memory in futex_q_lock().

Store the counter once with cmpxchg() and let the loser free_percpu() its
own. The initial reference has to be taken before the store, otherwise
another task can install a private hash while the counter is still 0.

Fixes: d9b05321e21e ("futex: Move futex_hash_free() back to __mmput()")
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/ansrpP4ImE1MaBY9@v4bel

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 2d1dbde54362..b38222e81879 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -1857,14 +1857,18 @@ static int futex_hash_allocate(unsigned int hash_slots, unsigned int flags)
 	}
 
 	if (!mm->futex.phash.ref) {
-		/*
-		 * This will always be allocated by the first thread and
-		 * therefore requires no locking.
-		 */
-		mm->futex.phash.ref = alloc_percpu(unsigned int);
-		if (!mm->futex.phash.ref)
+		unsigned int __percpu *ref = alloc_percpu(unsigned int);
+
+		if (!ref)
 			return -ENOMEM;
-		this_cpu_inc(*mm->futex.phash.ref); /* 0 -> 1 */
+
+		/*
+		 * Tasks sharing the mm can run this concurrently, so take the
+		 * initial reference before publishing the counter.
+		 */
+		this_cpu_inc(*ref); /* 0 -> 1 */
+		if (cmpxchg(&mm->futex.phash.ref, NULL, ref))
+			free_percpu(ref);
 	}
 
 	fph = kvzalloc(struct_size(fph, queues, hash_slots),


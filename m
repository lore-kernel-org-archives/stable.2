Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BC0403B11
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 10:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787568739; cv=none; b=LaMtup1bl9PhzVQWbiIN9a3KScZY+zVJeTDRX8khPaggB4Yv7WDGGdzFCgjIgEOc+LJtUXHj7Epoytl9hBiSRGg2bV3RyTscKgIwe/vuS646qFhp+exdsWAu/T6ltpEk8vv6pl4G2fnVwnLugp22SBDGnIGl8u56c3B156fuFIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787568739; c=relaxed/simple;
	bh=OtIqxx9SNdeHKkT5L2sBZcyIfCutLhaOYNQsn2VDBAs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NBdR8CNQGswFSVZXlMHDuQxgtbzvaf5S8OUlG+4JpZikks6sOwI434sAp8uFVwXNL8kodcWUU3E8xPLA7YwIZ8D7HC/Kvf1u8WDFBjKJV9pro/g7QGZCIBhQeq9cUnAVH9WfXpm1Ys6zy2faGDFXmflU2YYrpIsKoxlqM6J/P8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aBeOOvSE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aBeOOvSE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44721F000E9;
	Mon, 24 Aug 2026 10:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787568738;
	bh=ZdeBskVDLCMaP2HkFxHSejPXF2633Sw/3hLWX09ulTM=;
	h=Subject:To:Cc:From:Date;
	b=aBeOOvSEqu6VNed4sCMmx20vg3echlm25N0iea9obp/hiasdCEgUv9GDzW6l7MuQu
	 hcJVmmXPr6K1U0dNxaOmReWmG0Uh/gRuYoPT+c+WkIJ1yfxgJdzWpQbrQpVbBdcxqO
	 Q9J88J87gOpcbjNUytEKswHnl9zQkFNKaEcw/6Xs=
Subject: FAILED: patch "[PATCH] futex: Fix race on the initial mm->futex.phash.ref allocation" failed to apply to 6.18-stable tree
To: imv4bel@gmail.com,peterz@infradead.org,tglx@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Aug 2026 12:52:06 +0200
Message-ID: <2026082406-pushup-epic-2778@gregkh>
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
git cherry-pick -x bde0238083647381d4747355c5a19115a3422b96
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082406-pushup-epic-2778@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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


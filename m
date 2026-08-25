Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0BC22FDE6
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 22:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787695548; cv=none; b=OkZNn3oVy6HbyfoxANc/QQPAdp65BgVRxPJmd4dkxpK6kwg5hef8R/SIq0hvzKtyoww7Sg05mXcRZIgQOb/17VtGbeHzKMV97c7ZSXJE8ZN8JPf3WcGZAAbjZm3aTVlmzCKu8CzIgxMPRI7gsHETfx2ZiflRwTzagqBemjrqHVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787695548; c=relaxed/simple;
	bh=1lHMb32Ncb42JcgmKWb3oirLvhSBBWPqczjSp6F7vzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H4L12cSm4gzxyq+A/zh44jqch1yEqegOciP1cyRwNPZojeKf5TDUgqzmS4hIo21TZS5Hk71d+tUaXMZflyDaLhgU2PQcgu2f5b/3SgI+7X6qdKPnP/+2auxFK+9/MKQLEv5ChgEhBe6yjomeIlgnN6nchP00epeO6c7TtKanx2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RDQcNLy2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RDQcNLy2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D811F000E9;
	Tue, 25 Aug 2026 22:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787695547;
	bh=oUK6zwxLTb+md93LmDIKqAMMK4ePSJVExm2123P8Ino=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RDQcNLy2tx9LRsefML4t2lv4BgLz+rlJv1qYte22NVPfanPRd4qQzUN/M+E+O+fJo
	 XPtHBSmpMjHZnQUglHpUfm1hfRaB+Wo7XsMGhDnyuRQBgQuidj6fYbR+tHJUjpuydx
	 UcV/wbbpt9g/aeVFm4fhVOEmIA54TJiSlHy3ieHd4kd5tf5j8vcO1S+GY2xavTSepJ
	 Y1AtpvxWP/lmgHBmD0FYTfJuep1SPe9husBj0p1KkhFrrdRaZAfpOW+jGEu+km6c+Q
	 3+cs0IdJzz5TG5hFpiE8JUzJOeNxMSqQiVh/8Hz5K3IdnP5ZkGwl6+Z73Q3r3OOVOd
	 uKEYUn61UBzjA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hyunwoo Kim <imv4bel@gmail.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] futex: Fix race on the initial mm->futex.phash.ref allocation
Date: Tue, 25 Aug 2026 18:05:45 -0400
Message-ID: <20260825220545.2780691-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082406-pushup-epic-2778@gregkh>
References: <2026082406-pushup-epic-2778@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hyunwoo Kim <imv4bel@gmail.com>

[ Upstream commit bde0238083647381d4747355c5a19115a3422b96 ]

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
[ renamed `mm->futex.phash.ref` to `mm->futex_ref` to match the existing flat field name ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/futex/core.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index fde558fd2bd60..934dd2b7f6bcb 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -1830,14 +1830,18 @@ static int futex_hash_allocate(unsigned int hash_slots, unsigned int flags)
 	}
 
 	if (!mm->futex_ref) {
+		unsigned int __percpu *ref = alloc_percpu(unsigned int);
+
+		if (!ref)
+			return -ENOMEM;
+
 		/*
-		 * This will always be allocated by the first thread and
-		 * therefore requires no locking.
+		 * Tasks sharing the mm can run this concurrently, so take the
+		 * initial reference before publishing the counter.
 		 */
-		mm->futex_ref = alloc_percpu(unsigned int);
-		if (!mm->futex_ref)
-			return -ENOMEM;
-		this_cpu_inc(*mm->futex_ref); /* 0 -> 1 */
+		this_cpu_inc(*ref); /* 0 -> 1 */
+		if (cmpxchg(&mm->futex_ref, NULL, ref))
+			free_percpu(ref);
 	}
 
 	fph = kvzalloc(struct_size(fph, queues, hash_slots),
-- 
2.53.0


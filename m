Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1B248F857
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 15:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787671996; cv=none; b=R6IMN/RMM97HqUSM1rZcntbHJpPXstvguK3Syhwzp0WAeEaTASm8zftDXoNyg3/gQN4Wm3X474Q9dKIlKyVf9xEo/3wLi5MELW5bn1eN46EKuTwlJakyIMhtU+OY7u8wnXZ229ouf4tJOXv+tUwSry/v0biy9ehLS1j3CwgSsYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787671996; c=relaxed/simple;
	bh=aLTDPgQ67/RRrY5lBQoqsyYe8A1um+totIQfiR55Xf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BKXL3MKLUSoy4veoB/O4RIfMzQHCq261DTyoCg+2cWRl+dw9uju8n/v6gRly/v0oGEwBuoZsdCREMYx+EwRRgANBFhGp7rElZH9s9Uk00NiH6NCj+C1lbw7/Z4G5VcKuRP2HPt7LsBfxzpOb4xka3mze70C3nBu661o7hyEKUis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oAjWBR/K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oAjWBR/K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A67BB1F01558;
	Tue, 25 Aug 2026 15:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787671994;
	bh=JsFk9B5OtKSmRsDlCCaXhrv8Y78zbxn9tiNRBexy4ts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oAjWBR/KPrzlk6lvfg9v00fqXdSCcQmsfLshv3cAtpmC7evq3e1PP00hk+xvP8p4W
	 qziVnb6t06zu5P8BOHeRRyj+sQ7589JixJ1jGaLMVW9k1B2vpj5De9/n+B/m4qHi67
	 SIaVKhKoDS72HHSGIGFavz3Q7QgnPLXLSqnodgQ6r7hbQIl1s/wnYntb+zuVmgf57E
	 +XloObWJbXImrLzKjZPlLCA9X/RCVzkKa0XexsTT393l7saveL7jUkXeICkv2rLvfc
	 7kXhULQYjvLBq/llaAjdm7aTeLoe12WzkulwoXM/kXco0tnfi5TrjrNsbb3tNNDLdq
	 nnEbyJpA9MqLA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hyunwoo Kim <imv4bel@gmail.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y 3/3] futex: Fix race on the initial mm->futex.phash.ref allocation
Date: Tue, 25 Aug 2026 11:33:10 -0400
Message-ID: <20260825153310.4065884-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260825153310.4065884-1-sashal@kernel.org>
References: <2026082406-engaged-statistic-82bb@gregkh>
 <20260825153310.4065884-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/futex/core.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 033f373fdcc05..0886a11582394 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -1823,14 +1823,18 @@ static int futex_hash_allocate(unsigned int hash_slots, unsigned int flags)
 	}
 
 	if (!mm->futex.phash.ref) {
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
-		mm->futex.phash.ref = alloc_percpu(unsigned int);
-		if (!mm->futex.phash.ref)
-			return -ENOMEM;
-		this_cpu_inc(*mm->futex.phash.ref); /* 0 -> 1 */
+		this_cpu_inc(*ref); /* 0 -> 1 */
+		if (cmpxchg(&mm->futex.phash.ref, NULL, ref))
+			free_percpu(ref);
 	}
 
 	fph = kvzalloc(struct_size(fph, queues, hash_slots),
-- 
2.53.0


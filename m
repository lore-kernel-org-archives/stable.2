Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315446;
	b=FFgvnVAaIALgo6W0DZLN98vSY6SkAr3oZmWgEOzc/K3vkjy/aWWfNguafIM+EppkbPsx
	 rP9omAWzeW3tFZSY4MR5+AQkcO9BW2dAfsiLLX4eSuIxryAvrhkwm6UxBs6fib6KOo+HL
	 jSP/Uqvai20eXvaFltYDkL/PxfBl3YL6UD7yO42+SJAEgHGIizOFG1TpDEVOyxmUqQiI3
	 jk8CX0i2+H90eyy09v/P6qyTvPcG1zy9rqy7ElzuvsNBxcT8unv9iIrcApAGpsNjMYH9q
	 EJDw6Lyl/OgcoXg6FKCTJCOJnmOP0MLgoxx/cPi8fRDB4s9uyl1jId5s5lqjEdCwOfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315446;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5zlnvsFYr9z9Ih7dz4YhWOpewlga8jMKN2V1aX1mRyg=;
	b=v2C0Tq915ClzTn5jnUV2OJuyWeAExdDhKLZ4esIZ65FWqM+ldTzrsNpkOskSirTBkpzu
	 Y4EJfb/nwq8IkFDTcjypZHeWcFepv/chn3zAP4UoSs1k7gshIHhgj22YBNwoHNwR+nccM
	 RBfhL3OxOhkeow+fbY8rjKH9/De7F/4dw459tM9Dp/0HZl8RSChcYQTaNDLQWlrD3KhL3
	 a/YRW7RzI/trqh8dEA4rLzUYG8dnSTnAp8LVFhpkNuJsG9WQnS843REnCzNAIEBEKRKdY
	 FWHKBGG7G6pgsBQS+9cviCiJUwKXTtZADtDJLNyxshujgbf3GYZqj+1zTRomENXjMaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="N/6wTrBw";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC9F606F173
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N/6wTrBw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 967E81F008A2;
	Tue, 10 Nov 2026 12:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794315446;
	bh=5zlnvsFYr9z9Ih7dz4YhWOpewlga8jMKN2V1aX1mRyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N/6wTrBw5PYjvp3FCr4hSkFlXp+2bzCZbUQFzFjyMxwwYD/lymY5x1wGaH+4ULXkx
	 LObNqA4aBNI/T2QAm9mdofe9dGH4zBdtTT0xz/lGIC1e6EFg2SMJ2AVhSHKWLoOfB3
	 cIe9hhhc6waJf5xmXTMWwnOA31oYpevuCU76yo4vgM+80rC7iL07Ady1QkSEwhEuUK
	 tH/U1ayAW3+D1UsCKAttTefkD4xKTKyhqBkWR7qSk5ox+QT0WLbt0nJT83ut09errV
	 M66akyp/fhuNv7bi9NFMZC/j5QUxUFzh5Y/8OJScn9LRbJYalMaJ4sTnXqFwSYu5RQ
	 xKRw8fKu1uMQg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christopher Lusk <clusk@northecho.dev>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Greg Ungerer <gerg@linux-m68k.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] m68k: Fix seccomp filtering on ColdFire and 68000
Date: Tue, 10 Nov 2026 07:57:23 -0500
Message-ID: <20261110125718.1538168-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110125718.1538168-1-sashal@kernel.org>
References: <20261107051013-failed-6.18-48859f8018d9@kernel.org>
 <20261110125718.1538168-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christopher Lusk <clusk@northecho.dev>

[ Upstream commit 48859f8018d93bd93ef35f7430fdf5b97f2f9715 ]

m68k selects HAVE_ARCH_SECCOMP_FILTER for all configurations, but the
ColdFire and 68000 syscall entry paths only branch to
syscall_trace_enter() for TIF_SYSCALL_TRACE. TIF_SECCOMP alone falls
through to syscall dispatch, leaving installed filters ineffective.

Test the combined TIF_SYSCALL_TRACE and TIF_SECCOMP mask in both paths
and route either flag through the existing slow path. Leave the classic
MMU syscall entry implementation unchanged.

Validated the combined test under QEMU mcf5208evb (ColdFire): filters
denying getpid, openat, unlinkat, and reboot each returned -EPERM. A
classic-MMU control (q800) denied the filtered getpid syscall both before
and after this change. The 68000 path shares the same source-level
omission and receives the identical masked test but was not separately
emulated. Compile-tested W=1 with CONFIG_SECCOMP_FILTER=y on both
m5208evb_defconfig and a custom no-MMU UCSIMM configuration; the latter
built arch/m68k/68000/entry.o and vmlinux.

Fixes: 6baaade15594 ("m68k: Add kernel seccomp support")
Cc: stable@vger.kernel.org # v6.3+
Suggested-by: Andreas Schwab <schwab@linux-m68k.org>
Assisted-by: Claude:claude-opus-4-8
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Christopher Lusk <clusk@northecho.dev>
Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/m68k/68000/entry.S    | 3 ++-
 arch/m68k/coldfire/entry.S | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/m68k/68000/entry.S b/arch/m68k/68000/entry.S
index c257cc415c478..0d3cbededc43c 100644
--- a/arch/m68k/68000/entry.S
+++ b/arch/m68k/68000/entry.S
@@ -79,7 +79,8 @@ ENTRY(system_call)
 
 	/* Doing a trace ? */
 	getthreadinfo
-	btst	#(TIF_SYSCALL_TRACE%8),%a2@(TINFO_FLAGS+(31-TIF_SYSCALL_TRACE)/8)
+	moveb	%a2@(TINFO_FLAGS+2),%d1
+	andl	#((_TIF_SYSCALL_TRACE + _TIF_SECCOMP) >> 8),%d1
 	jne	do_trace
 	cmpl	#NR_syscalls,%d0
 	jcc	badsys
diff --git a/arch/m68k/coldfire/entry.S b/arch/m68k/coldfire/entry.S
index 4ea08336e2fb0..d658abdc52075 100644
--- a/arch/m68k/coldfire/entry.S
+++ b/arch/m68k/coldfire/entry.S
@@ -72,7 +72,8 @@ ENTRY(system_call)
 	movel	%d2,%a0
 	movel	%a0@,%a1		/* save top of frame */
 	movel	%sp,%a1@(TASK_THREAD+THREAD_ESP0)
-	btst	#(TIF_SYSCALL_TRACE%8),%a0@(TINFO_FLAGS+(31-TIF_SYSCALL_TRACE)/8)
+	moveb	%a0@(TINFO_FLAGS+2),%d2
+	andl	#((_TIF_SYSCALL_TRACE + _TIF_SECCOMP) >> 8),%d2
 	bnes	1f
 
 	movel	%d3,%a0
-- 
2.53.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046871;
	b=Yaf2k6dRo9WSeZkWRYI7NrmA+LjYpJfMYdcwOnU4c37R74ZLd9pQiuI2UeWZeFAK5wEQ
	 92cOHMbmleO7WepCUWIGAORoIZFDnpMnZuwv+AAAIyvBCjExu2xCKt8SQ0FKEa94KXgCR
	 lfoRX29jpFp9pQPyObfWAAeGH7ynjNMxh1aoEgQjVlGIuO3Mls6HYma/jK0hTECkUhx1u
	 tmmGhwKTcjyBgdtOu8oT1SxWoZd0RA6YKZzAwJpL3/ja0eC8gY6HBUDn3/zaXZtJg9D9F
	 zZMo/VZw4RLP16/oO2myXEo4zSWnEAjEbv1ZSUDNtIm89ipdtu2x1DYZ6LOaO30ZGBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046871;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=1A2LRO9Av3ZkJMaSzmCd4OKVz+T4jQsq2I4AsrT+p6A=;
	b=qAfsCqTeTmEX1d2OSdfk8lxelM7KmUQ2dL9DYZVU3+KkNAVJ7mSiLFxENMByHbnRMb6N
	 1sunrcLjTzmMdnMkEg48yZ6A6F4QowyZzGCj0PWqkycZQJe6IJh4hEStgPw3x63wR/Un7
	 PWNo7DUJi9rwiYs3ZAnBXOaaFHDyQAUdXnJa0ZNZhcZBHV1yB6sYd8e5L3+t4wO3TsMuK
	 atT850LxtovPGYc6vWum54BNc0SgBdVzhStnNsTvtEZsJ5ABfLJlHwwrkJELg6EgstTES
	 BI430DqfYAM5LUbBXEfcec8E7+0iSYNJN63D9NUxTjL6+E3fxLaaDg2QSXGEXA1oaNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hDN9LXtn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B88E606A8FF
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hDN9LXtn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 793661F0089F;
	Sat,  7 Nov 2026 10:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046871;
	bh=1A2LRO9Av3ZkJMaSzmCd4OKVz+T4jQsq2I4AsrT+p6A=;
	h=From:To:Cc:Subject:Date;
	b=hDN9LXtnZkLeRy+4RalG5e9gCcj1vfLK0jmAOu9xlVqPx2nOTF/sqEnPpp9/SaBv/
	 cKG64e/Oy924JUwf1DaypidlMCEnFtOoXIq2Pzi76+aRQ46R+3T4c/U7Bb/0DCuac2
	 gy+QUQ377BxWcDSZQk7ASgvmieh1JyZEjBp49ZiXhOd/J3u02pHz9fI2ZXinhV4aoG
	 B4leJTkqr8xo6W3gavaA5n2H5qDSHojWEYZ5WucWWksabxSxson7LbDZ/JS9ph05+K
	 XIyw96tAbJvdhDJpjWQXs5hBKV5rL+f8GXxyVWHsmFH/o/XnqjZtVBdefhVQuPSrNC
	 IRTp+qEdb0+ZA==
From: Sasha Levin <sashal@kernel.org>
To: clusk@northecho.dev,
	schwab@linux-m68k.org,
	gerg@linux-m68k.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] m68k: Fix seccomp filtering on ColdFire and 68000" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:21:09 -0500
Message-ID: <20261107052109-failed-6.12-48859f8018d9@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 48859f8018d93bd93ef35f7430fdf5b97f2f9715
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052109-failed-6.12-48859f8018d9@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 48859f8018d93bd93ef35f7430fdf5b97f2f9715 Mon Sep 17 00:00:00 2001
From: Christopher Lusk <clusk@northecho.dev>
Date: Sun, 13 Sep 2026 09:17:53 -0400
Subject: [PATCH] m68k: Fix seccomp filtering on ColdFire and 68000

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





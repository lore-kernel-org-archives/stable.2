Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047621;
	b=BYqHr/4oO61nAv93cR8/T07FT/pQuG7d2rM1+iovU2XVsdoxIPFAKlOtyO7Hty6flAik
	 tkwvbJJLBWd5+/oZ5zhOJtMISWKwXA1Y0ql7y6B1HIXhPHI3Vl+tZS5rHBRsdndtgkB/I
	 +K/6qOWsCq7KvXywKthdu4mnab7+HqHD1Eco14zj7R0UPc+/8PjpghSfGO9GcW4bipCSW
	 WtW/zDLFPQpGb+QNAdWT8Kdig6IRRpnkI81BFCec+fAC6R4FXQkXWAUZGAbOubweSaT9s
	 tnqkij8ueR7urqYCXiqiuX/Lo8VR4D8v5lclNxNGENHaSDgHanOCuN37QKBEbfXVvJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047621;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=zMnyaaiHEMbV0l4KGN5MedUEMpai7/nHsXWYVgrP09g=;
	b=P5XfWvFJCh5TvhYcntpwzH0QPZ3nS/GIjsh8+oy4FqSnlIR/Qac6xcNRQjVc41Hhc5Ec
	 d0qX/X84x0Nh0Jz54wMaQRWF23rwwKxDf3LcGAmxn1oU0PFIrQU8d3m6DHAt4SPpztyfr
	 11xe5Gy1xovFecb9hd1yFtJwKqpU1PdzAzaA5A6yOWKD5WrsJv+NpUzzpCs+vRX6NnFRG
	 rWmg5fDtc1N6bXijMDCj0RV5oE++TdVFdaYwtxr1rdmS0X+4uuwx0xHVQJQQQE0LqUol5
	 ZR8FMuAVoZAb0GIGV6c3/M0f36v7E8dq7Bp76mLxKLWqs8uLcOAYopGKN6TWFGeK7/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="mTntXf/D";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C91F606A32E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mTntXf/D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B98731F0089F;
	Sat,  7 Nov 2026 10:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047621;
	bh=zMnyaaiHEMbV0l4KGN5MedUEMpai7/nHsXWYVgrP09g=;
	h=From:To:Cc:Subject:Date;
	b=mTntXf/DNXs9xQuAEgswcBD0LladJPS2HQUTM3Wr9N5wQ8V1pIwPxf/1wiwTA2t8p
	 tcfbhDXhqwaXg9lMI4wu2X3CLk/GFgwpbEwyKFlrIWizTae5SoPzcSR0SpSl/IF98i
	 uQSH96/rgFFUzv32zxbvQofydiBm7vjV6KZPIhNGIVTNuHXxBeJYo13GtFOMeGwWiX
	 yE5aICBxsgnAjBVKVQPoXD+RGBc7WZHx3MJcBynOJi5vAfO2SoyTG03qL6noUlEd6O
	 76Feg9o+oNdiK/TJv2Tp3QyK/fKLEMt28qZy/l7biMryTZc2EKMTYJYZQx47FuPird
	 i6P7UtN7GJtkw==
From: Sasha Levin <sashal@kernel.org>
To: clusk@northecho.dev,
	schwab@linux-m68k.org,
	gerg@linux-m68k.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] m68k: Fix seccomp filtering on ColdFire and 68000" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:33:39 -0500
Message-ID: <20261107053339-failed-6.6-48859f8018d9@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 48859f8018d93bd93ef35f7430fdf5b97f2f9715
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053339-failed-6.6-48859f8018d9@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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





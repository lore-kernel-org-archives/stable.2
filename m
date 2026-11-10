Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315763;
	b=QHcKRUT3FnCGPofuAa9DifQlm6h4mHNWq07n+F6HXVq8MrANMZpW9Gf/xhDB81jmvqUL
	 6HYFhp/izO9iUY/GqY31j4H9DwBkIcrH/asT2tjK7xJppkWwfsAyTTMs5GG9QmH3Kpl+u
	 c9zRO+Lv2d8rjS4RsfM+fItrkGA/GAuz1qssSPRMxnJDw+B3DmMvM7/2u4M3hxlEubBcU
	 rG4lNxERnUX2nreDAahG2SS8DWwtFogmtsKqSHAcsHJeltd54wFEMv9Uon4DjeqX1Oee1
	 x3vRgFedebfZxcl4guxV5cGqryeQraKkdyq9IooV5aCYJXovGkwfPKl5+jskZudOXHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315763;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5zlnvsFYr9z9Ih7dz4YhWOpewlga8jMKN2V1aX1mRyg=;
	b=UA/XR3k2dcV2pYPKOXlL4u6iLY9HOipUmXFtUCweqxTe0zHb92HnTRXpF8+1quODwoQi
	 neEN3Ngh44jARJ5KmIo9+IAeat5wRiDNxkgPBkR1s1t/w6fBhU/CmyLKO83SEmkR8xq90
	 61at0s0rVrWphjENY7eWICG4Q1Ncb9+WiIEuwZbP69So6a60kadPJCqakXszgI9291VWS
	 EllMwXJxk+5P9ykHob6obpuBQ73GVtJx0RWyjo3owpjIwZlQ+Es2EErtJMqkGvCaoYNGW
	 aTJ9/BddDpusV4LxBiKEHFz8E20zpb1spEiTQ1td6WiulKjicZG2xLULTk7sl/U+zAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HtXbz+F4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB874606BFDC
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HtXbz+F4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36EED1F008A1;
	Tue, 10 Nov 2026 13:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794315762;
	bh=5zlnvsFYr9z9Ih7dz4YhWOpewlga8jMKN2V1aX1mRyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HtXbz+F4a4dfDopbSEXezQ0/uX1g23zoEpy++FR/0XjXx4nKNwcxJzfhkaF8p+EHp
	 ws5CLnFCj4HdUkpKbJBWa8oCwx6Nyu5Ah5AFoydcY/o44P7gpLa37JPwuWLvGryjVK
	 zywtn/CCRJ5KwfBMwh1MylI9+IJ3y5FV91tTNV+GhQ0Fx0NqgsfeTBG4DlnRT+Q1AO
	 ycp2uU1LgAb4afYrHw7s9dzZBFCRnrr2x3jSjqQ5KRlvy/82RezECjdrYnAAMlNDQK
	 E4UX7C3O6fWD6xENIFvgORhoouaz3+HC14OPd/TE/3AeQEGSvcXxCUMKO9hvYDm4xa
	 g05/8I6Bl976g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christopher Lusk <clusk@northecho.dev>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Greg Ungerer <gerg@linux-m68k.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] m68k: Fix seccomp filtering on ColdFire and 68000
Date: Tue, 10 Nov 2026 08:02:39 -0500
Message-ID: <20261110130232.1619444-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110130232.1619444-1-sashal@kernel.org>
References: <20261107052109-failed-6.12-48859f8018d9@kernel.org>
 <20261110130232.1619444-1-sashal@kernel.org>
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


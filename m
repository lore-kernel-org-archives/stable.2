Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316042;
	b=dXu13+Le/y3GPp18VbpL8/RozoP7mkwUPAH+diHAzdrsZrmPcMklxzX1u5rhzx0gSkZS
	 BMistKujSZgGKpqqD3Hl9dXEpLB148tsK4x22nqNiZtlPs3L4JhpEW+xE9wpxukt78GB6
	 BLPlx+X7jCGeGQahphZnUaQqSL2zv1vIoTeT7osuzC3BqE7iRMLvQQFEN+0yYKaIp6y+S
	 nEAoJlMTF2vhsmIRnj32sPzLIcfoyO1cXiMDcGDfT/HDKv7PZ1NeMC+JgRWoY8G08ajR8
	 GgWiZ+2axqUpPoRImr4j/9GVoyS9XDpqKlwaQ8R+5x8+dEtia6yOSBNIpEsXVCRM1Wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316042;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Zi58X+5CTp9st5c5/BcgNqrSAxiaxHrvcBXu12nWXD8=;
	b=tCFiHbDDOzqb8botWAXZeQdeeb8LC9CovT4UOlovjwkqs/mkInBTf7FFIRKuK9cn/KpA
	 cfN+C1oRjALc9/FHhCAKEa+HKduQ7v+M1NB1SAxACZuhiqEmTtXk+IdiMyAy0/ofXI2Pg
	 1q/uyetDowFo3qou31RrPU2rKzYAJM2DAXRmT/k3DU6I/jK/JxBvTOXnnklstC2x5kIaN
	 16MwtbZZUKKgCM13Y97fozQ8f7nhLpPlUUZBNn15QsYivLE3K/APjohJBJP3ko+PV4/jw
	 015k3Sk1kNVDgtbmWhkZKIzUTF5n6gHq8pH9Vwf/BBO1urWhsi1lCjAc72EQBxiWsbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nn5eAFfn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9822F606BFDF
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nn5eAFfn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A19E51F008A4;
	Tue, 10 Nov 2026 13:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794316042;
	bh=Zi58X+5CTp9st5c5/BcgNqrSAxiaxHrvcBXu12nWXD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Nn5eAFfn8Sq2ceQhU2BoigV/dIYktCLJgLfRHeeL4/OmTUfVutl1L5QK4vyxH9rlF
	 LIWcg5bRCYt45PAR1cQGlp+QfrH59RetsradsIUrvhGu/50iJTfDhDEgDe4WqC8iiu
	 3Rh3cFcBJfi7qJCJ3Zez0LojEQYdOT/zgTG6P81Ceo05GY5ZuKhdoqA/lPIyyvu0G0
	 vO6gStCOKAImHVnjJDkSAK/wBwIpOWi/MNCqRDnwaf/4B5MWRuu/2vMqWQnTFYeK1J
	 3GsfGyEJNd0bY+rALMWqTTeCfqtZvgzZg/xRsz5ZFTzhad1B1U/0v7y0JTrnzXQsbg
	 82LyNqL67hy4g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christopher Lusk <clusk@northecho.dev>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Greg Ungerer <gerg@linux-m68k.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] m68k: Fix seccomp filtering on ColdFire and 68000
Date: Tue, 10 Nov 2026 08:07:19 -0500
Message-ID: <20261110130712.1651427-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110130712.1651427-1-sashal@kernel.org>
References: <20261107053339-failed-6.6-48859f8018d9@kernel.org>
 <20261110130712.1651427-1-sashal@kernel.org>
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
index 37926b4b205af..6fc2971463695 100644
--- a/arch/m68k/68000/entry.S
+++ b/arch/m68k/68000/entry.S
@@ -82,7 +82,8 @@ ENTRY(system_call)
 
 	/* Doing a trace ? */
 	getthreadinfo
-	btst	#(TIF_SYSCALL_TRACE%8),%a2@(TINFO_FLAGS+(31-TIF_SYSCALL_TRACE)/8)
+	moveb	%a2@(TINFO_FLAGS+2),%d1
+	andl	#((_TIF_SYSCALL_TRACE + _TIF_SECCOMP) >> 8),%d1
 	jne	do_trace
 	cmpl	#NR_syscalls,%d0
 	jcc	badsys
diff --git a/arch/m68k/coldfire/entry.S b/arch/m68k/coldfire/entry.S
index 35104c5417ff4..95d98dead6245 100644
--- a/arch/m68k/coldfire/entry.S
+++ b/arch/m68k/coldfire/entry.S
@@ -75,7 +75,8 @@ ENTRY(system_call)
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


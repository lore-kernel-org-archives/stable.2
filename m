Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046215;
	b=KhT8t7KUZ0TT1UqeV3xQgyK9yZAIiOJXiK4TeB0E7YmlY6uVW/TGpQacUUhhnVfqqmLm
	 MdlpYRaygiQ3sSrCCz6HvvDbFg/T5SC1d+U2hiWJVP68x3nc/oV3U5tuuAKOdMwpiSnIK
	 QM1rpYKGMRN3GLVR05KxJxkBxQ5WVWEaaxF29Gg+TnHpy+YG++2ox43F7+GdCFSO+l9b8
	 N84QpdJ6xNPKWZYYKyd6dmjMb2KY9RrePpppWWWY4HSpEFTZ9q2S9tATlCAUBqlCf0ATG
	 OwGtMPUyhoa6KRdgy4ImsDZPnaKL40nMbfSckJMLrR71TZW/p4N1CODnME15fmKFX8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046215;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=bhzRlyj2bjdgzG7OvB9pZz2PAZCy9+VpW86kKxcpDEQ=;
	b=BryAQhAPWubwgiSn30dYhzN9DwJBPkxx39pheYAJhyHPZnmjPHcOMgpvroe+qPAkTPiE
	 m2tvLTzfPlm/tGm8HOPBs/O916+BYt+/hljdL5BbSlaGeddhI+F5sQSNZ6MdU0Kk+5HCs
	 xkkX5DVO4ca8T5Rd8NDd33VfVZaIwTB7YUBsnuhq8SwOnOh5HkmOrOH6RBHBGt2seSpxT
	 VRm//wvJ+80CSPrL44ng7O9Rvyk3Wc3JVmcIpcrSRtT1t3/GpkoayQsnI2UfN4MbWjCLK
	 ufoW9BUA8lKSI7G0Ts/iX6dFTrZNU+iUAGEyaQboEn70jNAhObeQAy6js2eGBgdg69w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aukIv6MM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F882606A32F
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aukIv6MM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6EE21F0089F;
	Sat,  7 Nov 2026 10:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046215;
	bh=bhzRlyj2bjdgzG7OvB9pZz2PAZCy9+VpW86kKxcpDEQ=;
	h=From:To:Cc:Subject:Date;
	b=aukIv6MMH5HQMPZqvMWOYVzjL3TcORufJONe9/aGN/zrnO2aPGi1+/VyONd5QlY8P
	 w/I9oXpdONBGqccpYSOhYlq8l/Z2MvRH2GWHl8YNr3Pkns4XnrgfB7a39rePy06EgC
	 wPDYfQQjsX4XHF/FK1OBTLRmhxo2U6DiYh+oTKR/qiVVF/z6k6e4rJvQokODcK3vzq
	 zyS5328bBYHS3PEI/fffROnV5V3FZ76oSa35FzhSGUdLGTQuvL1V0NBqbizF0a9CxC
	 8T49BANX7TR1JcjKG2suFW1C9p4LcS2k288oF5+XTcnnVwEBNVUEjIFZ/u3BPz1W4Z
	 WYojydzqmHQiQ==
From: Sasha Levin <sashal@kernel.org>
To: clusk@northecho.dev,
	schwab@linux-m68k.org,
	gerg@linux-m68k.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] m68k: Fix seccomp filtering on ColdFire and 68000" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:10:13 -0500
Message-ID: <20261107051013-failed-6.18-48859f8018d9@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 48859f8018d93bd93ef35f7430fdf5b97f2f9715
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051013-failed-6.18-48859f8018d9@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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




